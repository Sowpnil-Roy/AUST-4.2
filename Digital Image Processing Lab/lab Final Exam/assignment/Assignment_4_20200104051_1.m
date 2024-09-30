%Faiyaz Al Islam
%20200104051
%B1
img = im2double(rgb2gray(imread('lines.png')));

output1 = horizontalLines(img);
output2 = verticalLines(img);

figurePosition = [100, 100, 1200, 600];
figure('Name', 'Summary', 'Position', figurePosition);
subplot(1, 2, 1);
imshow(output1);
title('Horizontal lines');
subplot(1, 2, 2);
imshow(output2);
title('Vertical lines');


function horLines = horizontalLines(img)
filter = [ 1  1  1;
           0  0  0;
          -1 -1 -1];
 horLines =  imfilter(img, filter);
end

function verLines = verticalLines(img)
filter = [-1  0   1;
          -1  0   1;
          -1  0   1];
 verLines =  imfilter(img, filter);
end