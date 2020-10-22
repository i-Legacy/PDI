function [matriz,im_fil]=AreaPerimetro(im)
%Recibe la imagen en escala de grises, luego de haber eliminado los
%leucocitos con EliminarWBC


% Umbralización
U=graythresh(im);
im_bin=imbinarize(im,U);
%im_bin=imcomplement(im_bin);


% Filtrado morfológico
SE=strel('disk',4);
im_fil=imopen(im_bin,SE);


% Elimino células ruido
[label n]=bwlabel(im_fil,4);
for i=1:n
ind=find(label==i);
    if(size(ind,1)<200) %defino un umbral empírico
        im_fil(ind)=0;
    end
end

% rectangulos
im_fil=imclearborder(im_fil); %Elimino las células sobre el borde, ya que probablemente esten cortadas y no son representativas
stats=regionprops(im_fil,'BoundingBox');


%separación individual
clear matriz;%col1: area; col2:perimetro
cont=1;
for k = 1 : length(stats)
   thisBB = stats(k).BoundingBox;
   mat=im_fil(round(thisBB(2)-1):round(thisBB(4)+thisBB(2)),round(thisBB(1)-1):round(thisBB(1)+thisBB(3)));
   im_limpia=imclearborder(mat);%Limpio los bordes
   
   %Cierre de las células
   SE=strel('disk',20);
   im_limpia=imclose(im_limpia,SE);
   
   %Area
   matriz(cont,1)=length(find(im_limpia==1));

   %Perimetro
   SE=strel('disk',1);
   im_eros=imerode(im_limpia,SE);
   contorno=im_limpia-im_eros;
   [fil col]=find(contorno==1);
   y=fil(1); %Me quedo con un punto de inicio para el algoritmo de traceboundary
   x=col(1);
   conto=bwtraceboundary(im_limpia,round([y,x]),'N');
   d = diff(conto); 
   matriz(cont,2)= sum(sqrt(sum(d.*d,2))); %sqrt(x^2+y^2)
   %matriz(cont,2)= length(find(contorno==1)); %Otra forma de calcular perímetro
   cont=cont+1;
end

end
