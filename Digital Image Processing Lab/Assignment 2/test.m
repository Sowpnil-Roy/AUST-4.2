% 1. Get RGB image (replace 'path/to/your/image.jpg' with your actual image path)
image_path = 'sunflower.jpeg';
rgb_image = imread(image_path);

% 2. Convert to grayscale
grayscale_image = rgb2gray(rgb_image);

% 3. Plot grayscale image
figure(1);
subplot(3,3,1);
imshow(grayscale_image);
title('Grayscale Image');

% 4. Get gamma value from user
gamma = input('Enter the gamma value (e.g., 2.5): ');

% 5. Apply power-law transformation with c=1.5
power_law_image = impower(grayscale_image, gamma) * 1.5;

% 6. Plot power-law transformed image
subplot(3,3,2);
imshow(power_law_image);
title('Power Law Transformed Image');

% 7. Get threshold value from user
threshold = input('Enter the threshold value (e.g., 200): ');

% 8. Perform thresholding with brightness modification
thresholded_image = grayscale_image;
thresholded_image(grayscale_image < threshold) = thresholded_image(grayscale_image < threshold) * 1.5; % Increase brightness by 50%
thresholded_image(grayscale_image >= threshold) = thresholded_image(grayscale_image >= threshold) * 0.75; % Decrease brightness by 25%

% 9. Plot thresholded image
subplot(3,3,3);
imshow(thresholded_image);
title('Thresholded Image');

% 10. Apply log transformation with c=1.9
log_transformed_image = imlog(grayscale_image, 1.9);

% 11. Plot log transformed image
subplot(3,3,4);
imshow(log_transformed_image);
title('Log Transformed Image');

% 12. Apply negative transformation
negative_image = imcomplement(grayscale_image);

% 13. Plot negative image
subplot(3,3,5);
imshow(negative_image);
title('Negative Image');

% Show all subplots in a figure
sgtitle('Image Processing Results');
