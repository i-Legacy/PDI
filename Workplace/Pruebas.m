%% Histograma Area 
hist_area = histogram(AP(:, 1),'NumBins', size(AP, 1),'BinLimits',[0 max(AP(:, 1))]);

    
%% Histograma Perimetro 
hist_per = histogram(AP(:, 2),'NumBins', size(AP, 1),'BinLimits',[0 max(AP(:, 2))]);

%% Histograma Circularity 
Arr = (AP(:, 2) .^ 2) ./ (4 * pi * AP(:, 1));
% circularity = (Perimeter .^ 2) ./ (4 * pi * area);
APC = [AP Arr];
hist_cir = histogram(APC(:, 3),'NumBins', size(AP, 1),'BinLimits',[0 max(APC(:, 3))]);

%% Resize
%1580
im = imresize(imread('001source.jpg'), 0.25);
cr = imcrop(im);
cr = imresize(cr, 6.5);
% imshow(cr)


%%
im_elim=EliminarWBC(cr);
[AP im_AP]=AreaPerimetro(im_elim);

figure()
stats=regionprops(im_AP,'BoundingBox');
imshow(im_AP)
for k = 1 : length(stats)
thisBB = stats(k).BoundingBox;
rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
'EdgeColor','g','LineWidth',1 )
end

%%
SE=strel('disk',30);
imo=imopen(im_AP,SE);
%espicularidad
[AP im_AP]=AreaPerimetro_p(imo);


figure()
stats=regionprops(im_AP,'BoundingBox');
imshow(im_AP)
for k = 1 : length(stats)
thisBB = stats(k).BoundingBox;
rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
'EdgeColor','g','LineWidth',1 )
end

%% watershed

L = watershed(cr)













