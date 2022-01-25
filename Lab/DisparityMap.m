function ret = DisparityMap(img_l, img_r, temp_x, temp_y)
    img_l = im2double(img_l);
    img_r = im2double(img_r);
    if (size(img_l) ~= size(img_r)) 
        error("Image sizes are not the same!"); end
    [img_h, img_w] = size(img_l);
    
    offset_x = floor(temp_x/2);
    offset_y = floor(temp_y/2);
    ret = ones(img_h-offset_x+1, img_w-offset_y+1);
    
    for row = 1+offset_x : img_h-offset_x
        for col = 1+offset_y : img_w-offset_y
            temp_r = img_l(row-offset_x : row+offset_x, ... 
                col-offset_y : col+offset_y);
            temp_l = rot90(temp_r, 2);
            
            ssd_min = inf;
            ssd_min_i = 0;
            
            for i = max(1+offset_y, col-14) : col
                temp = img_r(row-offset_x : row+offset_x, ...
                    i-offset_y : i+offset_y);
                temp_r = rot90(temp, 2);
                
                conv_r = conv2(temp, temp_r);
                conv_l = conv2(temp, temp_l);
                
                ssd = conv_r(temp_x, temp_y) - 2*conv_l(temp_x, temp_y);
                if ssd < ssd_min
                    ssd_min = ssd;
                    ssd_min_i = i;
                end
            end
            ret(row-offset_x, col-offset_y) = col-ssd_min_i;
        end
    end
end