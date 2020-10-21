im=imread('001source.jpg');
im=imresize(im,0.25);

%% Analizo los tres canales
%{
subplot(131)
imshow(im(:,:,1))
subplot(132)
imshow(im(:,:,2))
subplot(133)
imshow(im(:,:,3))
%}
im=im(:,:,2); %Me quedo con el canal G

%% Umbralización
U=graythresh(im);
im_bin=imbinarize(im,U);
%im_bin=imcomplement(im_bin);

subplot(121)
imshow(im)
subplot(122)
imshow(im_bin)

%% Filtrado morfológico
SE=strel('disk',4);

%{
im_fil=imerode(im_fil,SE);
im_fil=imerode(im_fil,SE);
im_fil=imdilate(im_bin,SE);
im_fil=imdilate(im_bin,SE);
%}



SE=strel('disk',2);
im_fil=imopen(im_bin,SE);
%im_fil=imclose(im_fil,SE);

figure
subplot(121)
imshow(im_bin)
subplot(122)
imshow(im_fil)