%for p=1:5
%folder='C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\'
%filePattern = fullfile(folder, '*.jpg');
%file=dir(filePattern);
%filename=fullfile(file(p).folder,file(p).name);
%im=imread(filename);

im=imread('C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\003source.jpg');
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