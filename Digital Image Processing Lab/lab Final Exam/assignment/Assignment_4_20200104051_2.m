%Faiyaz Al Islam
%20200104051
%B1

I = im2double(rgb2gray(imread('coins.jpg')));

T = 1.3;

Gx = [-1 0 1; 
      -2 0 2; 
      -1 0 1
      ];
Gy = [-1 -2 -1;
      0   0  0; 
      1   2  1
      ];
  
dx =  imfilter(I, Gx);
dy = imfilter(I, Gy);

D = (dx.^2 + dy.^2).^0.5;

[rows, cols] = size(I);
final = zeros(rows, cols);

for i = 1:rows
    for j = 1:cols
        if(D(i,j)>T)
            final(i,j) = D(i,j);
        end
    end
end

figurePosition = [100, 100, 1200, 900];
figure('Name', 'Summary', 'Position', figurePosition);
subplot(1, 2, 1);
imshow(I);
title('Original Image');
subplot(1, 2, 2);
imshow(final);
title('Output Image');