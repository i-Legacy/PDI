%pruebo

impeg = imread('im_AP_peg.bmp');
im = imread('005source.jpg');
im = imresize(im,0.25);

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
   %im_limpia=imclearborder(mat,4);%Limpio los bordes
   %imshow(mat)
   
   %mat agarra en cada ciclo del for a 1 imagen. A esto debería:
   %separarlas
   %guardar la posicion en alguna variable? no se si hace falta. Ta en bb
   
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
   %cropresultante(x:x+ancho,y:y+alto) = mat; (dicho informalmente)
   
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

   
   figure()
   subplot(121);
   imshow(impeg);
   subplot(122);
   imshow(cropresultante);
