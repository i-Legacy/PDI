%for p=1:5
%folder='C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\'
%filePattern = fullfile(folder, '*.jpg');
%file=dir(filePattern);
%filename=fullfile(file(p).folder,file(p).name);
%im=imread(filename);

im=imread('C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\005source.jpg');
%  im=imread('C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\c0001.jpg');
im_elim=EliminarWBC(im);
im_pre=Preproc(im_elim);
[AP im_AP]=AreaPerimetro(im_pre);

%Descarto las que estan juntas
[im_AP_ind,im_AP_peg]=individuales(AP,im_AP);
% subplot(131)
% imshow(im_AP)
% subplot(132)
% imshow(im_AP_ind)
% subplot(133)
% imshow(im_AP_peg)

%AP_sep=wshed(im_peg); devuelve matriz con area y perimetro?
mdl=Train; %se llama una sola vez, después se comenta
AP_clasif_ind=Test(mdl,AP); %agrega una tercer columna con la clasificación
%im_clas_peg=Test(AP_sep);


%% Grafico la imagen ya clasificada
figure()

stats=regionprops(im_AP_ind,'BoundingBox');


for k = 1 : length(stats)
thisBB = stats(k).BoundingBox;
rec=im(round(thisBB(2)):round(thisBB(4)+thisBB(2)),round(thisBB(1)):round(thisBB(1)+thisBB(3)));
if(AP_clasif_ind(k,4)==1)
    im_clas=insertText(rec,[1,1],'C','Fontsize',15,'BoxOpacity',0,'TextColor','white');
elseif(AP_clasif_ind(k,4)==2)
    im_clas=insertText(rec,[1,1],'E','Fontsize',15,'BoxOpacity',0,'TextColor','white');
elseif(AP_clasif_ind(k,4)==3)
    im_clas=insertText(rec,[1,1],'O','Fontsize',15,'BoxOpacity',0,'TextColor','white');
end
im(round(thisBB(2)):round(thisBB(4)+thisBB(2)),round(thisBB(1)):round(thisBB(1)+thisBB(3)))=rgb2gray(im_clas);
%im_clas=0;
end

imshow(im)
% stats=regionprops(im_clas,'BoundingBox');
for k = 1 : length(stats)
 thisBB = stats(k).BoundingBox;
rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
'EdgeColor','g','LineWidth',1 )
end

%end