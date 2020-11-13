function [cropresultante] = crop(im_APE_peg,im)
%Considerar que devuelve la imagen achicada un 25%. De ultima al final
%agregarle otro resize y listo. (No lo puse pq no me acuerdo de que tamaño
%la querías recibir ivancito)

im = imresize(im,0.25);
impeg = im_APE_peg;

L = bwlabel(impeg, 8); 
stats = regionprops(L,'BoundingBox');

cropresultante = zeros(size(impeg));
conti = 1;
contj = 1;

for k = 1 : length(stats)
   thisBB = stats(k).BoundingBox;
   x = thisBB(1);
   y = thisBB(2);
   ancho = thisBB(3);
   alto = thisBB(4);
   
   mat=im(round(thisBB(2)-1):round(thisBB(4)+thisBB(2)),round(thisBB(1)-1):round(thisBB(1)+thisBB(3)));
   %imshow(mat)
   
   %mat agarra en cada ciclo del for a 1 imagen cropeada. A esto debería:
   %Ahora se separa a cada imagen.
   %Recordar que la info de la posicion y tamaño me lo da el BB.
   
   nivel = graythresh(mat);
   mat = imbinarize(mat,nivel);
   mat = imcomplement(mat);
   mat = imfill(mat,8,'holes');
   %B = imshow(B);
   
   se = strel('disk',7);
   imdiv = imopen(mat,se);  
   %imshow(imdiv);
   
   % Elimino células ruido
   [label n]=bwlabel(imdiv,4);
   for i=1:n
    ind=find(label==i);
    if(size(ind,1)<80) %Ver bien este umbral
       imdiv(ind)=0;
    end
   end

   % Limpio bordes
   imdiv=imclearborder(imdiv);
    
   %imshow(imdiv);
    
   %Ahora tengo que agregar el pedacito de imagen que recorté al crop final.
   %cropresultante(x:x+ancho,y:y+alto) = imdiv; (dicho informalmente)
   
   for i = round(y)-1:round(y)-1+alto
       for j = round(x)-1:round(x)-1+ancho
           cropresultante(i,j)= imdiv(conti,contj);
           contj=contj+1;
       end
       contj=1;
       conti=conti+1;
   end
   conti=1;
   contj=1;
   
end

   
   %figure()
   %subplot(121);
   %imshow(impeg);
   %subplot(122);
   %imshow(cropresultante);


end
