function imdiv = CelPegadas(im)

im = rgb2gray(im);
nivel = graythresh(im);
im = imbinarize(im,nivel);
im = imcomplement(im);
im = imfill(im,8,'holes');
%B = imshow(B);

se = strel('disk',23);
imdiv = imopen(im,se);

%f1 = figure(1);
%subplot(121);
%imshow(A);
%subplot(122);
%imshow(imdiv);
