A = imread('prueba2.bmp');
A = imresize(A,0.25);
B = imcrop(A);
%imshow(B);
B = imresize(B, 4);
imshow(B);
B = rgb2gray(B);
nivel = graythresh(B);
B = imbinarize(B,nivel);
B = imcomplement(B);
B = imfill(B,8,'holes');
%B = imshow(B);

se = strel('disk',30);
Ba = imopen(B,se);

imshow(Ba);
