im =imread('Result.png');
im_bin = imbinarize(im);


%% Filtrado morfológico
SE=strel('disk',4);

im_fil=imopen(im_bin,SE);

figure(1)
subplot(121)
imshow(im_bin)
subplot(122)
imshow(im_fil)

%% rectangulos
stats=regionprops(im_fil,'BoundingBox');
for k = 1 : length(stats)
thisBB = stats(k).BoundingBox;
rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
'EdgeColor','g','LineWidth',1 )
end
%% Elimino células ruido
[label n]=bwlabel(im_fil,4);
for i=1:n
ind=find(label==i);
    if(size(ind,1)<200) %defino un umbral empírico
        im_fil(ind)=0;
    end
end

%% rectangulos
figure(2)
imshow(im_fil)
stats=regionprops(im_fil,'BoundingBox');
for k = 1 : length(stats)
thisBB = stats(k).BoundingBox;
rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
'EdgeColor','g','LineWidth',1 )
end

%% separación individual
for k = 1 : length(stats)
thisBB = stats(k).BoundingBox;
%if(round(thisBB(4)+thisBB(2))<size(im_fil,1)&&round(thisBB(3)+thisBB(1))<size(im_fil,2)) %Así de paso estoy eliminando los que estan sobre el borde y salen cortados
if(round(thisBB(2)+thisBB(4)+1)<=size(im_fil,1)&&round(thisBB(3)+thisBB(1)+1)<=size(im_fil,2)&&...
       round(thisBB(2)-1)>=1 && round(thisBB(1)-1)>=1) 
%mat=im_fil(round(thisBB(2)):round(thisBB(4)+thisBB(2)),round(thisBB(1)):round(thisBB(3)+thisBB(1))); 
   mat=im_fil(round(thisBB(2)-1):round(thisBB(4)+thisBB(2)+1),round(thisBB(1)-1):round(thisBB(3)+thisBB(1)+1));
   
   im_limpia=imclearborder(mat);%Limpio los bordes
   
   %Cierre de las células
   SE=strel('disk',20);
   im_limpia=imclose(im_limpia,SE);
   
   figure(3)
   subplot(121)
   imshow(mat);
   subplot(122)
   imshow(im_limpia);
   
end
end