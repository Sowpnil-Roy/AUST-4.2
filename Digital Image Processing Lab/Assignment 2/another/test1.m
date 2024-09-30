%Assignment-2  ID: 20200104071

img = imread('sunflower.jpeg');

I = rgb2gray(img);

% Plot the grayscale image
figure;
imshow(I);
title('Grayscale Image');

Y = input('Enter a gamma value: ');

c_power = input("Enter a number of Power Law Transformation: ");
img_power_law = c_power * (double(I) .^ Y);

% Plot the Power Law transformed image
figure;
imshow(img_power_law, []);
title('Power Law Transformed Image'); 


A = input('Enter a threashold value: ');

% Increase brightness by 50% for pixels with intensity smaller than A;
% else decrease it by 25% of image I
img_threshold = double(I);
for i = 1:size(img_threshold, 1)
    for j = 1:size(img_threshold, 2)
        if img_threshold(i, j) < A
            img_threshold(i, j) = img_threshold(i, j) * 1.5;
        else
            img_threshold(i, j) = img_threshold(i, j) * 0.75;
        end
    end
end

% Plot the thresholded image
figure;
imshow(img_threshold, []);
title('Thresholded Image');

% Apply Log Transformation on image I with c = 1.9
c_log = input("Enter a number of log Transformation: ");
img_log = c_log * log(1 + double(I));

% Plot the log transformed image
figure;
imshow(img_log, []);
title('Log Transformed Image');

% Apply Negation Transformation on I
img_neg = 255 - I;

% Plot the negative image
figure;
imshow(img_neg);
title('Negative Image');

% Show all plots in a figure as a subplot
figure;
subplot(2, 3, 1), imshow(I), title('Grayscale Image');
subplot(2, 3, 2), imshow(img_power_law, []), title('Power Law Transformed');
subplot(2, 3, 3), imshow(img_threshold, []), title('Thresholded Image');
subplot(2, 3, 4), imshow(img_log, []), title('Log Transformed Image');
subplot(2, 3, 5), imshow(img_neg), title('Negative Image');
subplot(2, 3, 6), imshow(img), title('Original Image');


%gamma value: 2.5
%Power Law Transformation: 1.5
%threashold value: 200
%log Transformation: 1.9