I = imread('aust_sky.jpg');
G = im2double(rgb2gray(I));

[row, col] = size(G);
R = double(zeros(row, col));
    
S = imnoise(G, 'salt & pepper', 0.07);
    

for i = 4:row-3
    for j = 4:col-3
        N = S(i-3 : i+3, j-3 : j+3);
        t = mean(N(:));
        R(i,j) = t;
    end
end

figure;
subplot(2, 2, 1);
imshow(I);
title('Original Image');
subplot(2, 2, 2);
imshow(G);
title('Grayscale Image');
subplot(2, 2, 3);
imshow(S);
title('Nooisy Image');
subplot(2, 2, 4);
imshow(R);
title('Filtered Image');

