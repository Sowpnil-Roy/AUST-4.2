% function imDerivative()

S = im2double(rgb2gray(imread('coins.jpg')));
[row, col] = size(S);
R = zeros(row, col);

%%

for i = 1:row
   for j = 1:col-1
       x = S(i, j) - S(i, j+1);
       R(i,j) = x;
   end    
end


figure;
subplot(1,2,1);
imshow(S);
title('input');

subplot(1,2,2);
imshow(R);
title('derivatives');

%%

% for i = 1:row-1
%    for j = 1:col-1
%        x = S(i, j) - S(i+1, j);
%        R(i,j) = x;
%    end    
% end
% 
% figure;
% subplot(1,2,1);
% imshow(S);
% title('input');
% 
% subplot(1,2,2);
% imshow(R);
% title('derivatives');

% end