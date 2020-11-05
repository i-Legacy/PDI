function imdiv = CelPegadas(im)

im = rgb2gray(im);
nivel = graythresh(im);
im = imbinarize(im,nivel);
im = imcomplement(im);
im = imfill(im,8,'holes');
%B = imshow(B);

se = strel('disk',23);
imdiv = imopen(im,se);


% Una vez cortadas, hay q hacer 2 cosas.
% 1. Borrar los bordes (intento agrandar el tamaño de los BB asi las imagenes importantes no se borran)
% 2. Guardar el centro cartesiano de cada imagen con respecto de la imagen
% BW original, tal que luego las pueda volver a poner ahi

%f1 = figure(1);
%subplot(121);
%imshow(A);
%subplot(122);
%imshow(imdiv);

end