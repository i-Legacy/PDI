%for p=1:5
%folder='C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\'
%filePattern = fullfile(folder, '*.jpg');
%file=dir(filePattern);
%filename=fullfile(file(p).folder,file(p).name);
%im=imread(filename);

im=imread('C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\001source.jpg');
%  im=imread('C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\c0001.jpg');
im_elim=EliminarWBC(im);
im_pre=Preproc(im_elim);
[AP im_AP]=AreaPerimetro(im_pre);

%Descarto las que estan juntas
[im_AP_ind,im_AP_peg]=individuales(AP,im_AP);
subplot(131)
imshow(im_AP)
subplot(132)
imshow(im_AP_ind)
subplot(133)
imshow(im_AP_peg)

%AP_sep=wshed(im_peg); devuelve matriz con area y perimetro?
%im_clas_ind=Clasificacion(AP); agrega una tercer columna con la clasificación
%im_clas_peg=Clasificacion(AP_sep);


%Grafico la imagen (habría que graficarla luego de la clausura)
figure()
stats=regionprops(im_AP_ind,'BoundingBox');

for k = 1 : length(stats)
thisBB = stats(k).BoundingBox;
rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
'EdgeColor','g','LineWidth',1 )

% mat=im_AP_ind(round(thisBB(2)-1):round(thisBB(4)+thisBB(2)),round(thisBB(1)-1):round(thisBB(1)+thisBB(3)));
% 
% SE=strel('disk',10);
% im_limpia=imclose(im_AP_ind,SE);
% im_AP_ind(round(thisBB(2)-1):round(thisBB(4)+thisBB(2)),round(thisBB(1)-1):round(thisBB(1)+thisBB(3)))=mat;
end
imshow(im_AP_ind)
%end