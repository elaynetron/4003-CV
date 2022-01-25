%%CE4003 Computer Vision Lab 1 - Elayne Tan
%%2.1
Pc = imread('Images/MRT Train.jpg');
whos Pc
P = rgb2gray(Pc);
imshow(P);
min(P(:)), max(P(:)) % check original min and max
P2 = (255-0)/(204-13)*imsubtract(P,13);
P2_double = (255-0)/(204-13)*(double(P)-13);
P2_double = uint8(P2_double);
min(P2(:)), max(P2(:)) %to check if the min and max is 0 and 255
min(P2_double(:)), max(P2_double(:)) %to check if the min and max is 0 and 255
imshow(P2);
imshow(P2_double);

%%2.2
imhist(P,10);
imhist(P,256);
P3 = histeq(P,255);
imhist(P3,10);
imhist(P3,256);
%rerun
P3 = histeq(P,255);
imhist(P3,10);
imhist(P3,256);

%%2.3
syms x y % x = sym('x'); y = sym('y');
h1(x,y) = 1/(2*pi*(1.0^2))*exp(-(x^2+y^2)/(2*(1.0^2))); %(i) sigma = 1.0
h2(x,y) = 1/(2*pi*(2.0^2))*exp(-(x^2+y^2)/(2*(2.0^2))); %(ii) sigma = 2.0
xMax = floor(5/2);
yMax = floor(5/2);
[x,y] = meshgrid(-xMax:1:xMax, -yMax:1:yMax);
m1 = h1(x,y);
m1 = m1/sum(m1(:)); %normalise
sum1 = double(sum(m1(:)));
m1 = double(m1)
m2 = h2(x,y);
m2 = m2/sum(m2(:)); %normalise
sum2 = double(sum(m2(:)));
m2 = double(m2)
mesh(m1)
mesh(m2)
%Assume ntu_gn is 'Library with Gaussian Noise'
ntu_gn = imread('Images/Library with Gaussian Noise.jpg');
imshow(ntu_gn);
%m1
ntu_gn_m2 = conv2(m1, double(ntu_gn));
imshow(uint8(ntu_gn_m1));
%m2
ntu_gn_m2 = conv2(m2, double(ntu_gn));
imshow(uint8(ntu_gn_m2));
%Assume ntu-sp is 'Library with Speckle Noise'
ntu_sp = imread('Images/Library with Speckle Noise.jpg');
imshow(ntu_sp);
%m1
ntu_sp_m1 = conv2(m1, double(ntu_sp));
imshow(uint8(ntu_sp_m1));
%m2
ntu_sp_m2 = conv2(m2, double(ntu_sp));
imshow(uint8(ntu_sp_m2));

%%2.4
ntu_gn_med33 = medfilt2(double(ntu_gn), [3 3]);
imshow(uint8(ntu_gn_med33));
ntu_gn_med55 = medfilt2(double(ntu_gn), [5 5]);
imshow(uint8(ntu_gn_med55));
ntu_sp_med33 = medfilt2(double(ntu_sp), [3 3]);
imshow(uint8(ntu_sp_med33));
ntu_sp_med55 = medfilt2(double(ntu_sp), [5 5]);
imshow(uint8(ntu_sp_med55));

%%2.5
pck = imread('Images/PCK with Channel Interference.jpg');
imshow(pck);
F = fft2(pck);
S = real(F).^2 + imag(F).^2;
imagesc(fftshift(S.^0.1)); 
colormap('default');
imagesc(S.^0.1); 
%[x,y] = ginput
x1 = round(8.6814);
x2 = round(248.8464);
y1 = round(242.3584);
y2 = round(16.8173);
F(y2-2:y2+2, x2-2:x2+2) = 0;
F(y1-2:y1+2, x1-2:x1+2) = 0;
S = real(F).^2 + imag(F).^2;
imagesc(fftshift(S.^0.1)); 
colormap('default');
F_in = uint8(ifft2(F));
imshow(F_in);
F_improve = fft2(pck);
F_improve(y2-5:y2+5, x2-5:x2+5) = 0;
F_improve(y1-5:y1+5, x1-5:x1+5) = 0;
F_improve(y1, :) = 0;
F_improve(:, x1) = 0;
F_improve(y2, :) = 0;
F_improve(:, x2) = 0;
S = real(F_improve).^2 + imag(F_improve).^2;
imagesc(fftshift(S.^0.1)); 
colormap('default');
F_improve_in = uint8(ifft2(F_improve));
imshow(F_improve_in);
primate = imread('Images/Caged Primate.jpg');
imshow(primate);
primate = rgb2gray(primate);
F_primate = fft2(primate);
S = real(F_primate).^2 + imag(F_primate).^2;
imagesc((S.^0.1)); 
colormap('default');
%similarly, coordinates gotten from ginput and rounded
p1x = 11;
p1y = 252;
p2x = 22;
p2y = 248;
p3x = 248;
p3y = 4;
p4x = 238;
p4y = 11;
F_primate(p1y-3:p1y+3, p1x-3:p1x+3) = 0;
F_primate(p2y-3:p2y+3, p2x-3:p2x+3) = 0;
F_primate(p3y-3:p3y+3, p3x-3:p3x+3) = 0;
F_primate(p4y-3:p4y+3, p4x-3:p4x+3) = 0;
F_primate(p1y, :) = 0;
F_primate(:, p1x) = 0;
F_primate(p2y, :) = 0;
F_primate(:, p2x) = 0;
F_primate(p3y, :) = 0;
F_primate(:, p3x) = 0;
F_primate(p4y, :) = 0;
F_primate(:, p4x) = 0;
F_primate_in = ifft2(F_primate);
imshow(uint8(F_primate_in));

%%2.6
book = imread('Images/Slanted View of Book.jpg');
imshow(book);
%[x,y] = ginput(4)
x = round([2.0864;143.5028;307.3555;255.6841]);
y = round([161.2932;28.0354;47.0722;215.0042]);
xd = [0;0;210;210];
yd = [297;0;0;297];
A = [
    x(1),y(1),1,0,0,0,-xd(1)*x(1),-xd(1)*y(1);
    0,0,0,x(1),y(1),1,-yd(1)*x(1),-yd(1)*y(1);
    x(2),y(2),1,0,0,0,-xd(2)*x(2),-xd(2)*y(2);
    0,0,0,x(2),y(2),1,-yd(2)*x(2),-yd(2)*y(2);
    x(3),y(3),1,0,0,0,-xd(3)*x(3),-xd(3)*y(3);
    0,0,0,x(3),y(3),1,-yd(3)*x(3),-yd(3)*y(3);
    x(4),y(4),1,0,0,0,-xd(4)*x(4),-xd(4)*y(4);
    0,0,0,x(4),y(4),1,-yd(4)*x(4),-yd(4)*y(4);
    ];
v = [xd(1);yd(1);xd(2);yd(2);xd(3);yd(3);xd(4);yd(4)];
u = A\v
U = reshape([u;1], 3, 3)'
w = U*[x'; y'; ones(1,4)];
w = w ./ (ones(3,1) * w(3,:))
T = maketform('projective', U');
book_warp = imtransform(book, T, 'XData', [0 210], 'YData', [0 297]);
imshow(book_warp)