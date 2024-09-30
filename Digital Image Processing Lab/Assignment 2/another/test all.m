% Assignment Title: "Let's Play with Intensity Transformation"

% Load the image based on the student's ID last digit (ID: 20200104071, last digit: 1)
% As per instructions: 71 % 4 = 3, therefore we take sunflower image
img = imread('sunflower.jpeg');

% Convert the image to grayscale
img_gray = rgb2gray(img);

% Plot the grayscale image
figure;
imshow(img_gray);
title('Grayscale Image');

% Take gamma value input from the user, let's use Y = 2.5
Y = 2.5;

% Apply Power Law Transformation on image I with c = 1.5
c_power = 1.5;
img_power_law = c_power * (double(img_gray) .^ Y);

% Plot the Power Law transformed image
figure;
imshow(img_power_law, []);
title('Power Law Transformed Image');

% Take a threshold value input from the user, say A = 200
A = 200;

% Increase brightness by 50% for pixels with intensity smaller than A;
% else decrease it by 25% of image I
img_thresh = double(img_gray);
for i = 1:size(img_thresh, 1)
    for j = 1:size(img_thresh, 2)
        if img_thresh(i, j) < A
            img_thresh(i, j) = img_thresh(i, j) * 1.5;
        else
            img_thresh(i, j) = img_thresh(i, j) * 0.75;
        end
    end
end

% Plot the thresholded image
figure;
imshow(img_thresh, []);
title('Thresholded Image');

% Apply Log Transformation on image I with c = 1.9
c_log = 1.9;
img_log = c_log * log(1 + double(img_gray));

% Plot the log transformed image
figure;
imshow(img_log, []);
title('Log Transformed Image');

% Apply Negation Transformation on I
img_neg = 255 - img_gray;

% Plot the negative image
figure;
imshow(img_neg);
title('Negative Image');

% Show all plots in a figure as a subplot
figure;
subplot(2, 3, 1), imshow(img_gray), title('Grayscale Image');
subplot(2, 3, 2), imshow(img_power_law, []), title('Power Law Transformed');
subplot(2, 3, 3), imshow(img_thresh, []), title('Thresholded Image');
subplot(2, 3, 4), imshow(img_log, []), title('Log Transformed Image');
subplot(2, 3, 5), imshow(img_neg), title('Negative Image');
