%for p=1:5
%folder='C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\'
%filePattern = fullfile(folder, '*.jpg');
%file=dir(filePattern);
%filename=fullfile(file(p).folder,file(p).name);
%im=imread(filename);
clear all; clc;
folder = 'E:\Documentos\ING_BIOMEDICA\Cuarto Año\Segundo Cuatrimestre\Procesamiento Digital de Imágenes\TP_Final\Imagenes\001source.jpg' ;
im=imread(folder);
im_elim=EliminarWBC(im);
[AP im_AP]=AreaPerimetro(im_elim);

figure()
stats=regionprops(im_AP,'BoundingBox');
imshow(im_AP)
for k = 1 : length(stats)
thisBB = stats(k).BoundingBox;
rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
'EdgeColor','g','LineWidth',1 )
end

%end