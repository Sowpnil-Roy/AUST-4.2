% Load the RGB image
rgbImage = imread('sunflower.jpeg');  % Replace with your image path

% Convert to grayscale
I = rgb2gray(rgbImage);

% Plot the grayscale image
figure;
subplot(3,2,1);
imshow(I);
title('Grayscale Image');

% Take gamma value input from the user
Y = input('Enter the gamma value: ');

% Apply Power Law Transformation
c = 1.5;
I_double = im2double(I);
I_powerlaw = c * (I_double .^ Y);

% Plot the Power Law transformed image
subplot(3,2,2);
imshow(I_powerlaw);
title('Power Law Transformed Image');

% Take a threshold value input from the user
A = input('Enter the threshold value: ');

% Increase brightness by 50% for pixels with intensity smaller than A;
% else decrease it by 25% of image I
I_thresholded = I;
I_thresholded(I < A) = I(I < A) * 1.5;
I_thresholded(I >= A) = I(I >= A) * 0.75;

% Ensure the intensity values are within the valid range [0, 255]
I_thresholded = min(max(I_thresholded, 0), 255);

% Plot the thresholded image
subplot(3,2,3);
imshow(uint8(I_thresholded));
title('Thresholded Image');

% Apply Log Transformation
c_log = 1.9;
I_log = c_log * log(1 + I_double);

% Plot the log transformed image
subplot(3,2,4);
imshow(I_log);
title('Log Transformed Image');

% Apply Negation Transformation
I_negative = 255 - I;

% Plot the negative image
subplot(3,2,5);
imshow(I_negative);
title('Negative Image');

% Display all plots
subplot(3,2,6);
imshow(rgbImage);
title('Original RGB Image');