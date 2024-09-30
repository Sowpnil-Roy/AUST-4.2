% Step 1: Read Input Images
image1 = imread('f1.png');
image2 = imread('f2.png');

% Step 2: Convert Images to Binary

binary_image2 = imbinarize(rgb2gray(image2));

% Step 3: Perform Manual Erosion and Dilation
radius = 20; % Adjust the radius based on your image features
se = strel('disk', radius);

% Define custom functions for erosion and dilation
eroded_image1 = custom_erosion(binary_image1, se);
dilated_image1 = custom_dilation(binary_image1, se);

eroded_image2 = custom_erosion(binary_image2, se);
dilated_image2 = custom_dilation(binary_image2, se);

% Step 4: Count Number of Objects (Fingers)
num_objects1 = count_fingers(eroded_image1);
num_objects2 = count_fingers(eroded_image2);

disp(['Number of objects (fingers) in Image 1: ', num2str(num_objects1)]);
disp(['Number of objects (fingers) in Image 2: ', num2str(num_objects2)]);

% Custom erosion function
function eroded_image = custom_erosion(binary_image, se)
    eroded_image = binary_image; % Initialize with original binary image
    [rows, cols] = size(binary_image);
    [se_rows, se_cols] = size(se.Neighborhood);

    pad_row = floor(se_rows / 2);
    pad_col = floor(se_cols / 2);
    
    padded_image = padarray(binary_image, [pad_row pad_col], 0);
    
    for i = 1:rows
        for j = 1:cols
            region = padded_image(i:i+se_rows-1, j:j+se_cols-1);
            if min(min(region & se.Neighborhood)) == 1
                eroded_image(i, j) = 1;
            else
                eroded_image(i, j) = 0;
            end
        end
    end
    figure;imshow(eroded_image);
end

% Custom dilation function
function dilated_image = custom_dilation(binary_image, se)
    dilated_image = binary_image; % Initialize with original binary image
    [rows, cols] = size(binary_image);
    [se_rows, se_cols] = size(se.Neighborhood);

    pad_row = floor(se_rows / 2);
    pad_col = floor(se_cols / 2);
    
    padded_image = padarray(binary_image, [pad_row pad_col], 0);
    
    for i = 1:rows
        for j = 1:cols
            region = padded_image(i:i+se_rows-1, j:j+se_cols-1);
            if max(max(region & se.Neighborhood)) == 1
                dilated_image(i, j) = 1;
            else
                dilated_image(i, j) = 0;
            end
        end
    end
        figure;imshow(dilated_image);
end

% Function to count number of fingers using bwlabel
function num_objects = count_fingers(binary_image)
    % Remove noise if necessary
    binary_image_cleaned = bwareaopen(binary_image, 100); % Adjust 100 based on noise size
    
    % Label connected components (fingers)
    [labeled_image, num_objects] = bwlabel(binary_image_cleaned);
end