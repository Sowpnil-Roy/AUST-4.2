filenames = {'f1.png', 'f2.png', 'f3.png', 'f4.png', 'f5.png'};

figurePosition = [100, 100, 1200, 900];
figure('Name', 'Output', 'Position', figurePosition);
numImages = numel(filenames);

for i = 1:numImages
    image = imread(filenames{i});
    subplot(5, 6, (i-1)*6 + 1);
    imshow(image);
    title('Original');
    
    gray = rgb2gray(image);
    IR = imresize(gray, [50, 50]);
    ImBin = imbinarize(IR);
    subplot(5, 6, (i-1)*6 + 2);
    imshow(ImBin);
    title('Binary');
    
    St = strel('disk', 5);
    %palm = imdilate(imerode(ImBin, St), St);
    palm = custom_erosion(ImBin,St);
    palm = custom_dilation(palm,St);
    subplot(5, 6, (i-1)*6 + 3);
    imshow(palm);
    title('Palm');
   
    finger_noisy = ImBin - palm;
    subplot(5, 6, (i-1)*6 + 4);
    imshow(finger_noisy);
    title('Finger (Noisy)');
    
    finger_noiseless = bwareaopen(finger_noisy, 5);
    subplot(5, 6, (i-1)*6 + 5);
    imshow(finger_noiseless);
    title('Finger (Noiseless)');
    
    num_fingers = max(bwlabel(finger_noiseless));
    final = max(num_fingers(:));
    pos = [15 15];
    blank_img = ones(50,50);
    blank_img(:,:) = 1;
    fig_num = insertText(blank_img,pos,final,'BoxColor','white');
    subplot(5, 6, (i-1)*6 + 6);
    imshow(fig_num);
    title('Number of finger');
end


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
   % figure;imshow(eroded_image);
end


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
        %figure;imshow(dilated_image);
end