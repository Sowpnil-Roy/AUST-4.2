% Step 1: Read Input Images
imageFiles = dir('hand_images/*.png'); % Assuming the images are stored in a folder named 'hand_images'
numImages = length(imageFiles);

% Disk shaped structuring element
se = strel('disk', 5);
seArray = se.Neighborhood;

for i = 1:numImages
    % Read the image
    img = imread(fullfile(imageFiles(i).folder, imageFiles(i).name));
    
    % Convert to grayscale
    grayImg = rgb2gray(img);
    
    % Convert to binary image
    binaryImg = imbinarize(grayImg);
    
    % Remove noise
    binaryImg = imopen(binaryImg, se);
    
    % Manual Erosion
    erodedImg = false(size(binaryImg));
    for row = 1:size(binaryImg, 1) - size(seArray, 1) + 1
        for col = 1:size(binaryImg, 2) - size(seArray, 2) + 1
            if all(all(binaryImg(row:row+size(seArray, 1)-1, col:col+size(seArray, 2)-1) & seArray))
                erodedImg(row + floor(size(seArray, 1) / 2), col + floor(size(seArray, 2) / 2)) = true;
            end
        end
    end
    
    % Manual Dilation
    dilatedImg = false(size(erodedImg));
    for row = 1:size(erodedImg, 1)
        for col = 1:size(erodedImg, 2)
            if erodedImg(row, col)
                dilatedImg(max(1, row-floor(size(seArray, 1)/2)):min(size(erodedImg, 1), row+floor(size(seArray, 1)/2)), ...
                           max(1, col-floor(size(seArray, 2)/2)):min(size(erodedImg, 2), col+floor(size(seArray, 2)/2))) = ...
                           dilatedImg(max(1, row-floor(size(seArray, 1)/2)):min(size(erodedImg, 1), row+floor(size(seArray, 1)/2)), ...
                                      max(1, col-floor(size(seArray, 2)/2)):min(size(erodedImg,  2), col+floor(size(seArray, 2)/2))) | seArray;
            end
        end
    end
    
    % Count number of objects (fingers) using bwlabel
    [L, num] = bwlabel(dilatedImg);
    
    % Display results
    figure;
    subplot(1, 4, 1); imshow(img); title('Original Image');
    subplot(1, 4, 2); imshow(binaryImg); title('Binary Image');
    subplot(1, 4, 3); imshow(erodedImg); title('Eroded Image');
    subplot(1, 4, 4); imshow(dilatedImg); title(['Processed Image with ', num2str(num), ' fingers']);
end

% Display final counts
disp('Finger counts for each image:');
disp(fingerCounts);