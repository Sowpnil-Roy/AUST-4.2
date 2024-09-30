

S = im2double((imread('coins.jpg')));

%% defining filters
hx = [-1 0 1;
      -1 0 1;
      -1 0 1];
  
hy = [ 1  1  1;
       0  0  0;
      -1 -1 -1];

%% applying filters

Rx = imfilter(S, hx);
Ry = imfilter(S, hy);

R = (Rx.^2 + Ry.^2).^0.5;

figure;
subplot(1,3,1);
imshow(S);
title('input');

subplot(1,3,2);
imshow(Rx);
title('edges along x');

subplot(1,3,3);
imshow(Ry);
title('edges along y');

figure;
imshow(R)
