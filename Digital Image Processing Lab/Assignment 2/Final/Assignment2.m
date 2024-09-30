
img = imread('sunflower.jpeg');

img = rgb2gray(img);
imgd = im2double(img);

[row, col] = size(img);
[rowd, cold] = size(imgd);

img1 = uint8(ones(row, col));
img2 = ones(rowd, cold);

% Histogram of main image
total = zeros(1,256);
for i = 1:row
    for j = 1:col
        temp = img(i,j);
        total(temp+1) = total(temp+1) + 1;
    end
end
figure;
bar(total);

%Negative Image
for i = 1: row
    for j = 1: col
        img1(i,j) = 255 - img(i,j);
    end
end
% Histogram for Negative
total = zeros(1,256);
for i = 1:row
    for j = 1:col
        temp = img1(i,j);
        total(temp+1) = total(temp+1) + 1;
    end
end
figure;
bar(total);
% imhist(img1);
% figure;
% imshow(img);
% figure;
% imshow(img1);
 
%Threasholding
th = input('Enter a threashold value: ');
for i = 1: row
    for j = 1: col
        if img(i,j)>= th
            img1(i,j) = img(i,j)+img(i,j)*.05;
        else
            img1(i,j) = img(i,j)-img(i,j)*.25;
        end
    end
end

% Histogram for threasholding
total = zeros(1,256);
for i = 1:row
    for j = 1:col
        temp = img1(i,j);
        total(temp+1) = total(temp+1) + 1;
    end
end
figure;
bar(total);

% figure;
% imshow(img);
% figure;
% imshow(img1);
 
%logarithomic
cc = input("Enter a number: ");
for i = 1: rowd
    for j = 1: cold
        img2(i,j) = cc*(log(1+imgd(i,j)));
    end
end
% Histogram of Logarithmic
total = zeros(1,10);
for i = 1:row
    for j = 1:col
        temp = uint8(img2(i,j));
        total(temp+1) = total(temp+1) + 1;
    end
end
figure;
bar(total,'r');

% imhist(img2);
% figure;
% imshow(img);
% figure;
% imshow(img2);

%Power law
c = input("Enter a number: ");
gamma = input("Enter gamma: ");
for i = 1: rowd
    for j = 1: cold
        img2(i,j) = c*power(imgd(i,j), gamma);
    end
end

% Histogram of Power Law
total = zeros(1,10);
for i = 1:row
    for j = 1:col
        temp = uint8(img2(i,j));
        total(temp+1) = total(temp+1) + 1;
    end
end
figure;
bar(total,'r');

% imhist(img2);
% figure;
% imshow(img);
% figure;
% imshow(img2);