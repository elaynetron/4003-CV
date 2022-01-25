%%CE4003 Computer Vision Lab 2 - Elayne Tan
%%3.1 (a)
macritchie = imread('Images/MacRitchie Cross-Country Race.jpg');
macritchie = rgb2gray(macritchie);
imshow(macritchie)

%3.1 (b)
hori_sobel = [
    -1 -2 -1; 
    0 0 0; 
    1 2 1
];
vert_sobel = [
    -1 0 1; 
    -2 0 2; 
    -1 0 1
];
hori_conv = conv2(macritchie, hori_sobel);
vert_conv = conv2(macritchie, vert_sobel);
imshow(uint8(hori_conv))
imshow(uint8(vert_conv))

%3.1 (c)
combined = hori_conv.^2 + vert_conv.^2;
imshow(uint8(combined))
imshow((combined), [])
imshow(uint8(sqrt(combined)))

%3.1 (d)
min_comb = min(combined(:));
max_comb = max(combined(:));
combined = 255*(combined - min_comb)/(max_comb - min_comb);
combined = uint8(combined);
% ----- Uncomment to plot threshold values comparison
% subplot(3,3,1), imhist(combined, 256), title('Histogram');
% subplot(3,3,2), imshow(combined), title('Original');
% Et = combined > 2;
% subplot(3,3,3), imshow(Et), title('Threshold = 2');
% Et = combined > 5;
% subplot(3,3,4), imshow(Et), title('Threshold = 5');
% Et = combined > 10;
% subplot(3,3,5), imshow(Et), title('Threshold = 10');
% Et = combined > 20;
% subplot(3,3,6), imshow(Et), title('Threshold = 20');
% Et = combined > 50;
% subplot(3,3,7), imshow(Et), title('Threshold = 50');
% Et = combined > 70;
% subplot(3,3,8), imshow(Et), title('Threshold = 70');
% Et = combined > 100;
% subplot(3,3,9), imshow(Et), title('Threshold = 100');
Et = combined > 15;
imshow(Et)

%3.1 (e)
tl = 0.04;
th = 0.1;
sigma = 1.0;
% ----- Uncomment to plot sigma values comparison
% E = edge(macritchie, 'canny', [tl th], sigma);
% subplot(3,3,1), imshow(E), title('Sigma = 1.0');
% E = edge(macritchie, 'canny', [tl th], 1.5);
% subplot(3,3,2), imshow(E), title('Sigma = 1.5');
% E = edge(macritchie, 'canny', [tl th], 2.0);
% subplot(3,3,3), imshow(E), title('Sigma = 2.0');
% E = edge(macritchie, 'canny', [tl th], 2.5);
% subplot(3,3,4), imshow(E), title('Sigma = 2.5');
% E = edge(macritchie, 'canny', [tl th], 3.0);
% subplot(3,3,5), imshow(E), title('Sigma = 3.0');
% E = edge(macritchie, 'canny', [tl th], 3.5);
% subplot(3,3,6), imshow(E), title('Sigma = 3.5');
% E = edge(macritchie, 'canny', [tl th], 4.0);
% subplot(3,3,7), imshow(E), title('Sigma =4.0');
% E = edge(macritchie, 'canny', [tl th], 4.5);
% subplot(3,3,8), imshow(E), title('Sigma = 4.5');
% E = edge(macritchie, 'canny', [tl th], 5.0);
% subplot(3,3,9), imshow(E), title('Sigma = 5.0');

% ----- Uncomment to plot tl values comparison
% E = edge(macritchie, 'canny', [0.01 th], sigma);
% subplot(3,3,1), imshow(E), title('tl = 0.01');
% E = edge(macritchie, 'canny', [0.02 th], sigma);
% subplot(3,3,2), imshow(E), title('tl = 0.02');
% E = edge(macritchie, 'canny', [0.03 th], sigma);
% subplot(3,3,3), imshow(E), title('tl = 0.03');
% E = edge(macritchie, 'canny', [tl th], sigma);
% subplot(3,3,4), imshow(E), title('tl = 0.04');
% E = edge(macritchie, 'canny', [0.05 th], sigma);
% subplot(3,3,5), imshow(E), title('tl = 0.05');
% E = edge(macritchie, 'canny', [0.06 th], sigma);
% subplot(3,3,6), imshow(E), title('tl = 0.06');
% E = edge(macritchie, 'canny', [0.07 th], sigma);
% subplot(3,3,7), imshow(E), title('tl = 0.07');
% E = edge(macritchie, 'canny', [0.08 th], sigma);
% subplot(3,3,8), imshow(E), title('tl = 0.08');
% E = edge(macritchie, 'canny', [0.09 th], sigma);
% subplot(3,3,9), imshow(E), title('tl = 0.09');

%3.2 (a)
E = edge(macritchie, 'canny', [tl th], sigma);
imshow(E)

%3.2 (b)
help radon;
[H, xp] = radon(E);
imshow(uint8(H))

%3.2 (c)
imagesc(H)

%3.2 (d)
theta = 104;
radius = xp(157);
[A, B] = pol2cart(theta*pi/180, radius);
A;
B = -B;
C = A*(A+179) + B*(B+145);

%3.2(e)
xl = 0;
yl = (C-A*xl)/B;
xr = 358-1;
yr = (C-A*xr)/B;

%3.2(f)
imshow(macritchie)
line([xl xr], [yl, yr])
theta = 103;
radius = xp(157);
[A, B] = pol2cart(theta*pi/180, radius);
B = -B;
C = A*(A+179) + B*(B+145);
xl = 0;
yl = (C-A*xl)/B;
xr = 358-1;
yr = (C-A*xr)/B;
imshow(macritchie)
line([xl xr], [yl, yr])

precise_theta = 0:0.01:179;
[precise_H, xp] = radon(E, precise_theta);
imagesc(precise_H)
theta = 102.70;
radius = xp(157);
[A, B] = pol2cart(theta*pi/180, radius);
B = -B;
C = A*(A+179) + B*(B+145);
xl = 0;
yl = (C-A*xl)/B;
xr = 358-1;
yr = (C-A*xr)/B;
imshow(macritchie)
line([xl xr], [yl, yr])

%3.3 (b)
corr_l = imread('Images/Synthetic Left Image of Corridor.jpg');
corr_l = rgb2gray(corr_l);
corr_r = imread('Images/Synthetic Right Image of Corridor.jpg');
corr_r = rgb2gray(corr_r);
imshow(corr_l);
imshow(corr_r);

%3.3 (c)
%D = DisparityMap(corr_l, corr_r, 11, 11);
imshow(D, [-15 15]);
exp = imread('Images/Disparity Image of Corridor Scene.jpg');
imshow(exp)

%3.3 (d)
corr_l = imread('Images/Left Image of Triclops Stereo Pair.jpg');
corr_l = rgb2gray(corr_l);
corr_r = imread('Images/Right Image of Triclops Stereo Pair.jpg');
corr_r = rgb2gray(corr_r);
imshow(corr_l);
imshow(corr_r);
D = DisparityMap(corr_l, corr_r, 11, 11);
imshow(D, [-15 15]);
exp = imread('Images/Disparity of Triclops Stereo Pair.jpg');
imshow(exp)




