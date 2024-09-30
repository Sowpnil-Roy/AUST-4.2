S = rgb2gray(imread('peppers_color.jpg'));

h = 1/(7*7)*ones(7); % filter/ kernel

R = imfilter(S, h); % performs filter (basic correlation technique) on S with h kernel
R = conv2(S, h); % performs convolution on S with h kernel
R = normxcorr2(h,S); % performs normalized cross correlation on S with template h (with window sliding).





