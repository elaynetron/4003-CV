import cv2
import numpy as np

'''
Standard Otsu global threshold algorithm
cv2.threshold(image, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU,)
'''
def global_threshold(image):
    channels = [0]  # grayscale - [0]
    mask = None
    histSize = [256]
    ranges = [0, 256]
    hist = cv2.calcHist([image], channels, mask, histSize, ranges, )

    # iterate over all and get probabilities
    weights = [num_bin[0] / image.size for num_bin in hist]

    # init
    result = -1
    min_var = float('inf')

    for threshold in range(len(hist)):
        weight1 = sum(weights[:threshold + 1])
        weight2 = sum(weights[threshold + 1:])

        if weight1 != 0 and weight2 != 0:
            # class mean and variance for class1
            mean1 = sum([pixel_val * weight for pixel_val, weight in
                         enumerate(weights[:threshold + 1])])
            mean1 /= weight1
            var1 = sum([((pixel_val - mean1) ** 2) * weight for pixel_val,
                        weight in enumerate(weights[:threshold + 1])])
            var1 /= weight1

            # class mean and variance for class2
            mean2 = sum([pixel_val * weight for pixel_val, weight in
                         enumerate(weights[threshold + 1:])])
            mean2 /= weight2
            var2 = sum([((pixel_val - mean2) ** 2) * weight for pixel_val,
                        weight in enumerate(weights[threshold + 1:])])
            var2 /= weight2

            # find best threshold
            interclass_var = weight1 * var1 + weight2 * var2
            if interclass_var < min_var:
                result = threshold
                min_var = interclass_var

    # return image with same shape but with fill_value as result threshold
    return np.full_like(image, fill_value=result)


'''
Otsu algorithm performed on segmented blocks of the image
vert_seg: number of vertical segments
hori_seg: number of horizontal segments
'''
def segment_threshold(image, vert_seg, hori_seg):
    height, width = image.shape
    # calculate segment sizes based on number of segments in each direction
    seg_height = height // vert_seg + 1
    seg_width = width // hori_seg + 1

    # init
    threshold = np.zeros_like(image)

    # how much to offset for 1 segment in each direction
    for vert_offset in range(0, height, seg_height):
        for hori_offset in range(0, width, seg_width):
            # retrieve only that segment of the image
            segment = image[vert_offset: seg_height + vert_offset,
                      hori_offset: seg_width + hori_offset]

            # apply global Otsu threshold to that segment
            segment_threshold = global_threshold(segment)
            threshold[vert_offset: seg_height + vert_offset,
            hori_offset: seg_width + hori_offset] = segment_threshold

    return threshold


'''
Otsu algorithm performed on sliding window over image
wind_height, wind_width: height and width of window
vert_step, hori_step: number of steps to take in each direction 
'''
def sliding_window_threshold(image, wind_height, wind_width, vert_step, hori_step):
    height, width = image.shape

    # init
    threshold, count = np.zeros_like(image, dtype=np.float64), np.zeros_like(image)

    # how much to offset for 1 window in each direction
    for vert_offset in range(0, height - wind_height + vert_step, vert_step):
        for hori_offset in range(0, width - wind_width + hori_step, hori_step):
            # retrieve only that window of the image
            window = image[vert_offset: wind_height + vert_offset,
                     hori_offset: wind_width + hori_offset]

            # apply global Otsu threshold to that window
            window_threshold = global_threshold(window)
            threshold[vert_offset: wind_height + vert_offset,
            hori_offset: wind_width + hori_offset] += np.mean(window_threshold)

            # how many times it is repeated (due to overlap)
            # so that we can get average later on
            count[vert_offset: wind_height + vert_offset,
            hori_offset: wind_width + hori_offset] += 1

    return threshold / count
