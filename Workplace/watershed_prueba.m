% imcmyk = rgb2cmyk(cr);
% magenta = imcmyk(:, :, 2);
% 
% gmag=imgradient(magenta);

im=imcomplement(im2double(rgb2gray(cr)));
im=imclearborder(im);
gmag=imgradient(im);


SE=strel('disk',25);
Ie=imerode(magenta,SE);
Irec=imreconstruct(Ie,magenta);
figure
subplot(121)
imshow(Irec);
subplot(122)
imshow(magenta);

%% -
Iobrd = imdilate(Irec,SE);
Ilim = imreconstruct(imcomplement(Iobrd),imcomplement(Irec));
Ilim = imcomplement(Ilim);
subplot(121)
imshow(Ilim)
subplot(122)
imshow(magenta);

%% -
fgm=imregionalmax(Ilim);
imshow(fgm);
%% -
se2 = strel(ones(5,5));
fgm2 = imclose(fgm,se2);
fgm3 = imerode(fgm2,se2);


fgm4 = bwareaopen(fgm3,30);

I2 = labeloverlay(magenta,fgm4);
imshow(I2)
%% -

bw=imbinarize(Ilim);
imshow(bw);

%% -
D = bwdist(bw);
DL = watershed(D);
bgm = (DL == 0);
imshow(bgm,[])
%% -
gmag2 = imimposemin(gmag, bgm | fgm4);

L = watershed(gmag2);
Lrgb = label2rgb(L,'jet','w','shuffle');
imshow(Lrgb)
%% -
%Me quedo con ambas imágenes
im1=L==2
imshow(im1)
SE=strel('disk',5);
im1=imopen(im1,SE);
imshow(im1)
%% -
im2=L==3
imshow(im2)
im2=imopen(im2,SE);
imshow(im2)
%% -

%Imprimo todo
subplot(131)
imshow(magenta)
subplot(132)
imshow(im1)
subplot(133)
imshow(im2)