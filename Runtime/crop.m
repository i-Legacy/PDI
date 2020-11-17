function cropresultante = crop(im_APE_peg,im, Umin, Umax)
%Considerar que devuelve la imagen achicada un 25%. De ultima al final
%agregarle otro resize y listo. (No lo puse pq no me acuerdo de que tamaño
%la querías recibir ivancito)

% Por algun motivo hacer Umax * 4 no equivale al area original

% im = imresize(im,0.25);
impeg = im_APE_peg;
% 
% L = bwlabel(impeg, 8); 
% stats = regionprops(L,'BoundingBox'); 
stats = regionprops(logical(impeg),'BoundingBox');

m = size(im, 1);
n = size(im, 2);
cropresultante = zeros(m, n);
conti = 1;
contj = 1;

for k = 1 : length(stats)
    thisBB = stats(k).BoundingBox;
    %    x = thisBB(1);
    %    y = thisBB(2);
    %    ancho = thisBB(3);
    %    alto = thisBB(4);
    thisBB = bboxresize(thisBB, 4, 6); % bbox = bboxresize(BB, scale, size)
    x = thisBB(1);
    y = thisBB(2);
    ancho = thisBB(3);
    alto = thisBB(4);
    %    X = round(thisBB(2)-1) : round(thisBB(4)+thisBB(2));
    %    Y = round(thisBB(1)-1) : round(thisBB(1)+thisBB(3));
    % Estan al reves porque Y es columnas y X es filas
    Y = x : x+ancho;
    X = y : y+alto;
    mat = im(X, Y);
   

    %mat=im(X, Y);
    %imshow(mat)

    %mat agarra en cada ciclo del for a 1 imagen cropeada. A esto debería:
    %Ahora se separa a cada imagen.
    %Recordar que la info de la posicion y tamaño me lo da el BB.

    nivel = graythresh(mat);
    mat = imbinarize(mat, nivel);
    mat = imcomplement(mat);
    mat = imfill(mat,8,'holes');
    %B = imshow(B);

    se = strel('disk', 20);
    imdiv = imopen(mat,se);  
    %imshow(imdiv);

    % Elimino células ruido
    [label, n] = bwlabel(imdiv,4);
    for i=1:n
        ind=find(label==i);
        if(size(ind,1) < Umin) 
            imdiv(ind) = 0;
        end
    end

    % Limpio bordes
    imdiv=imclearborder(imdiv);
    label = bwlabel(imdiv, 4);
    for j=1 : max(label(:))
        ind = find(label == j);
        aux1 = zeros(size(label));
        aux1(ind) = 1;
        aux2 = logical(imresize(aux1, 0.25));
        area = sum(aux2(:));
        if(area>Umax)
            imdiv(ind) = 0;
            matrix = zeros(size(label));
            matrix(ind) = 1;
            L = wshed(matrix);
            imdiv = imdiv + L;
        end
    end
    
    %     if length(s) == 1
    %         imdiv = wshed(imdiv);
    %     end
    %     imdiv = imresize(imdiv, 0.25);
    %     x = x * 0.25;
    %     y = y * 0.25;
    %     ancho = ancho * 0.25;
    %     alto = alto * 0.25;

    imshow(imdiv);

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
cropresultante = imbinarize(imresize(cropresultante, 0.25), 'adaptive');
    
end
