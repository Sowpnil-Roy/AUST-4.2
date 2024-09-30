%Assignment-2  ID: 20200104071

img = imread('sunflower.jpeg');

img = rgb2gray(img);
imgd = im2double(img);

[row, col] = size(img);
[rowd, cold] = size(imgd);

img1 = uint8(ones(row, col));
img2 = ones(rowd, cold);


%Negative Image
for i = 1: row
    for j = 1: col
        img1(i,j) = 255 - img(i,j);
    end
end



 %imhist(img1);
 %figure;
 imshow(img);
 figure;
 imshow(img1);
 
%Threasholding (7)
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


 %figure;
 imshow(img);
 figure;
 imshow(img1);
 
%logarithomic
%Apply Log Transformation on image
cc = input("Enter a number of log Transformation: ");
for i = 1: rowd
    for j = 1: cold
        img2(i,j) = cc*(log(1+imgd(i,j)));
    end
end


 %imhist(img2);
 %figure;
 imshow(img);
 figure;
 imshow(img2);

%Power law
%Apply Power Law Transformation on image 
c = input("Enter a number of Power Law Transformation: ");

%Take gamma value input from the user
gamma = input("Enter gamma value: ");
for i = 1: rowd
    for j = 1: cold
        img2(i,j) = c*power(imgd(i,j), gamma);
    end
end


 %imhist(img2);
 %figure;
 imshow(img);
 figure;
 imshow(img2);


 % 200  1.9  1.5   2.5