%Faiyaz Al Islam
%20200104051
%B1

img = im2double(rgb2gray(imread('eren.jfif')));
sigma = input('Enter the sigma value: ');

gx = [-5 -4 -3 -2 -1 0 1 2 3 4 5;
      -5 -4 -3 -2 -1 0 1 2 3 4 5;
      -5 -4 -3 -2 -1 0 1 2 3 4 5;
      -5 -4 -3 -2 -1 0 1 2 3 4 5;
      -5 -4 -3 -2 -1 0 1 2 3 4 5;
      -5 -4 -3 -2 -1 0 1 2 3 4 5;
      -5 -4 -3 -2 -1 0 1 2 3 4 5;
      -5 -4 -3 -2 -1 0 1 2 3 4 5;
      -5 -4 -3 -2 -1 0 1 2 3 4 5;
      -5 -4 -3 -2 -1 0 1 2 3 4 5;
      -5 -4 -3 -2 -1 0 1 2 3 4 5;
      ];
  
gy = [-5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5;
      -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4;
      -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3;
      -2 -2 -2 -2 -2 -2 -2 -2 -2 -2 -2;
      -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1;
       0  0  0  0  0  0  0  0  0  0  0;
       1  1  1  1  1  1  1  1  1  1  1;
       2  2  2  2  2  2  2  2  2  2  2;
       3  3  3  3  3  3  3  3  3  3  3;
       4  4  4  4  4  4  4  4  4  4  4;
       5  5  5  5  5  5  5  5  5  5  5
       ];
   
ksize = 11;
kernel = double(zeros(ksize,ksize));

for i = 1:ksize
    for j = 1:ksize
        kernel(i,j) = 1/(2*3.1416*sigma^2) * exp(-(gx(i,j)^2 + gy(i,j)^2) / (2 * sigma^2));
    end
end 

[rows, cols] = size(img);
newImage = double(zeros(rows, cols));

for i = 6:rows-5
    for j = 6:cols-5
        portion = img(i-5 : i+5, j-5 : j+5);
        newImage(i,j) = sum(sum(double(portion) .* kernel));
    end
end

figure;imshow(img);
figure; imshow(newImage);

figurePosition = [100, 100, 1200, 900];
figure('Name', 'Summary', 'Position', figurePosition);
subplot(1, 2, 1);
imshow(img);
title('Original Image');
subplot(1, 2, 2);
imshow(newImage);
title('Filtered Image');

str = num2str(sigma, '%.1f');
filename = ['filtered_image_with_sigma_' str '.png'];
imwrite(newImage, filename);
   