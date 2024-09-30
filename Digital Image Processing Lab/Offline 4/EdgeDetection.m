
% ID: 20200104071
% Group: B1

% 1. Program for detecting horizontal & vertical lines from input image

in = im2gray(imread("lines.png"));
in = imbinarize(in);

out_h = horizontal_lines(in);
out_v = vertical_lines(in);

figure;
subplot(1, 3, 1); imshow(in); title("Input Image");
subplot(1, 3, 2); imshow(out_h); title("Horizontal Lines");
subplot(1, 3, 3); imshow(out_v); title("Vertical Lines");


function output = vertical_lines(input)
    % Applying horizontal edge detection with central derivatives

    filter = [1 0 -1];
    [ROW, COL] = size(input);
    output = zeros([ROW, COL]);

    for i = 1:ROW
        for j = 2:COL-1
            temp = input(i, j-1:j+1) .* filter;
            output(i, j) = sum(temp(:)); 
        end
    end
end


function output = horizontal_lines(input)
    rotated = transpose(input);
    temp = vertical_lines(rotated);
    output = transpose(temp);
end






