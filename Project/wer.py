import numpy

'''
Calculate WER with Levenshtein distance
Works only for iterables up to 254 elements (uint8)
test: string to be tested for accuracy
answer: string with correct answer
'''
def wer(test, answer):
    # initialisation
    test = test.split()
    answer = answer.split()
    d = numpy.zeros((len(test)+1)*(len(answer)+1),
                    dtype=numpy.uint8)
    d = d.reshape((len(test)+1, len(answer)+1))

    for i in range(len(test)+1):
        for j in range(len(answer)+1):
            if i == 0:
                d[0][j] = j
            elif j == 0:
                d[i][0] = i

    # computation
    for i in range(1, len(test)+1):
        for j in range(1, len(answer)+1):
            if test[i-1] == answer[j-1]:
                d[i][j] = d[i-1][j-1]
            else:
                substitution = d[i-1][j-1] + 1
                insertion = d[i][j-1] + 1
                deletion = d[i-1][j] + 1
                d[i][j] = min(substitution, insertion, deletion)

    num_errors = d[len(test)][len(answer)]
    total_words = len(answer)
    num_correct = total_words - num_errors
    return num_correct/total_words