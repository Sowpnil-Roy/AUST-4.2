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
    palm = imdilate(imerode(ImBin, St), St);
    
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
