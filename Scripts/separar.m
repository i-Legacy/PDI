function [matriz, im_label]= separar(im_APE_peg)

im_APE_sep = crop(im_APE_peg);

% [matriz, im_APE_sep] = FeaturesExtraction(im_APE_sep);
% 
% CC = bwconncomp(im_APE_sep, 4); %Para poder hacer los bounding-box con una 4 vecindad
% stats = regionprops(CC, 'BoundingBox'); % Left, Top, Width, Heigh
% 
% clear matriz;%col1: area; col2:perimetro
% for k = 1 : length(stats)
%    thisBB = stats(k).BoundingBox;
%    X = round(thisBB(2)-1) : round(thisBB(4)+thisBB(2));
%    Y = round(thisBB(1)-1) : round(thisBB(1)+thisBB(3));
%    aux = im_fil(X, Y);
%    im_limpia = imclearborder(aux,4);%Limpio los bordes
%    
%    %Cierre de las células %quiza se pueda mejorar esto, para que no queden tan gruesas
%    SE = strel('disk',10);
%    im_limpia = imclose(im_limpia,SE);
%    
%    stats_ec = regionprops(im_limpia, 'Eccentricity');
%    stats_area = regionprops(im_limpia, 'Area');
%    stats_per = regionprops(im_limpia, 'Perimeter');
%    
%    %Area
%    matriz(k,1) = stats_ec;
%    matriz(k,2) = stats_area;
%    matriz(k,3) = stats_per;
% end
% 
% im_label = bwlabel(im_APE_sep, 4);


end