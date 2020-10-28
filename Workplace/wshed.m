function Lrgb = wshed(cr)

im=imcomplement(im2double(rgb2gray(cr)));
gmag=imgradient(im);
SE=strel('disk',30);
Ie=imerode(im,SE);
Irec=imreconstruct(Ie,im);
Iobrd = imdilate(Irec,SE);
Ilim = imreconstruct(imcomplement(Iobrd),imcomplement(Irec));
Ilim = imcomplement(Ilim);
fgm=imregionalmax(Ilim);
se2 = strel(ones(5,5));
fgm2 = imclose(fgm,se2);
fgm3 = imerode(fgm2,se2);
fgm4 = bwareaopen(fgm3,30);
I2 = labeloverlay(im,fgm4);
bw=imbinarize(Ilim);
D = bwdist(bw);
DL = watershed(D);
bgm = (DL == 0);
gmag2 = imimposemin(gmag, bgm | fgm4);
L = watershed(gmag2);
L(~bw) = 0;
Lrgb = label2rgb(L,'jet','w','shuffle');

end