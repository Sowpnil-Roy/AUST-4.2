
% ID: 20200104071
% Group: B1

% 2. Program for applying sobel edge detection on input image

in = im2gray(imread("coins.png"));

T = 36;
Gx = [-1 0 1;
      -2 0 2;
      -1 0 1];

Gy = [ 1  2  1;
       0  0  0;
      -1 -2 -1];

[ROW, COL] = size(in);
input_padded = double(padarray(in, [1,1]));
output = double(zeros([ROW, COL]));

for i= 1:ROW
    for j = 1:COL
        temp = input_padded(i:i+2, j:j+2) .* Gx;
        output1 = sum(temp(:))/9;

        temp = input_padded(i:i+2, j:j+2) .* Gy;
        output2 = sum(temp(:))/9;
        
        if sqrt(output1.^2 + output2.^2) > T
            output(i, j) = 255;
        end

    end
end

output = uint8(output);

figure;
subplot(1, 2, 1); imshow(in); title("Input Image");
subplot(1, 2, 2); imshow(output); title("Edges detected with Sobel technique");
