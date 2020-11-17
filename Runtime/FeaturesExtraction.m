function [matriz,im_label]=FeaturesExtraction(im_fil)
%Recibe la imagen desde Preproc() y devuelve una matriz con area, per�metro
%y eccentricidad

CC=bwconncomp(im_fil,4); %Para poder hacer los bounding-box con una 4 vecindad
stats=regionprops(CC,'BoundingBox'); % Left, Top, Width, Heigh

im_label=bwlabel(im_fil,4);

%separaci�n individual
clear matriz;%col1: area; col2:perimetro
for k = 1 : length(stats)
    thisBB = stats(k).BoundingBox;
    mat=im_fil(round(thisBB(2)-1):round(thisBB(4)+thisBB(2)),round(thisBB(1)-1):round(thisBB(1)+thisBB(3)));
    im_limpia=imclearborder(mat,4);%Limpio los bordes

    %Cierre de las c�lulas %quiza se pueda mejorar esto, para que no queden tan gruesas
    SE=strel('disk',10);
    im_limpia=imclose(im_limpia,SE);

    %reemplazo en la imagen im_fil
    %im_fil(round(thisBB(2)-1):round(thisBB(4)+thisBB(2)),round(thisBB(1)-1):round(thisBB(1)+thisBB(3)))=im_limpia;

    %Area
    matriz(k,1)=length(find(im_limpia==1));

    %Perimetro
    SE=strel('disk',1);
    im_eros=imerode(im_limpia,SE);
    contorno=im_limpia-im_eros;
    [fil col]=find(contorno==1);
    y = fil(1); %Me quedo con un punto de inicio para el algoritmo de traceboundary
    x = col(1);
    conto=bwtraceboundary(im_limpia,round([y,x]),'N');

    %Para graficar el contorno
    %    imshow(im_limpia)
    %    hold on
    %    plot(conto(:,2),conto(:,1),'g','LineWidth',3);
    %    
    d = diff(conto); 
    matriz(k,2)= sum(sqrt(sum(d.*d,2))); %sqrt(x^2+y^2)
    %matriz(cont,2)= length(find(contorno==1)); %Otra forma de calcular per�metro

    %Eccentricidad
    stats_ec=regionprops(im_limpia,'Eccentricity');
    % stats_ec=regionprops(im_limpia,'perimeter');
    % stats_ec=regionprops(im_limpia,'area'); lmao
    matriz(k,3)=stats_ec(1).Eccentricity;
end
% im_label=bwlabel(im_fil);

end
