function imDerivativeConv()

S = im2double(rgb2gray(imread('coins.jpg')));


%% 

h = [1 -1];
R = imfilter(S, h);


figure;
subplot(1,2,1);
imshow(S);
title('input');

subplot(1,2,2);
imshow(R);
title('derivatives');


%% derivatives

% h = [1 ; -1];
% R = imfilter(S, h);
% 
% 
% figure;
% subplot(1,2,1);
% imshow(S);
% title('input');
%  
% subplot(1,2,2);
% imshow(R);
% title('derivatives');

end