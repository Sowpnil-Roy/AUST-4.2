% Implementation of Gaussian Filter

I = imread('mrbean.jpg'); % Read the image
I = rgb2gray(I); % Convert to grayscale

sigma = input('Enter value of sigma: '); % Get sigma value from user

% Designing the 11x11 kernel
[X, Y] = meshgrid(-5:5, -5:5);
kernel = exp((-1.*(X.^2 + Y.^2)) ./ (2*sigma^2)) ./ (2*pi*sigma^2);
kernel = kernel / sum(kernel(:)); % Normalize the kernel

% Padding input image
input_padded = double(padarray(I, [5, 5])); % Pad the image with a border of 5 pixels

% Applying Filter to input image
[ROW, COL] = size(I);
output = zeros([ROW, COL]);

for i = 1:ROW
    for j = 1:COL
        temp = input_padded(i:i+10, j:j+10) .* kernel; % Extract the region of interest
        output(i, j) = sum(temp(:)); % Apply the filter
    end
end

% Writing output image 
output = uint8(output);
imwrite(output, 'mrbean_blurred.jpg');

figure;
subplot(1, 2, 1);
imshow(I);
title('Input Image');

subplot(1, 2, 2);
imshow(output);
title(['Output Image with sigma = ' num2str(sigma)]);
