function [mdl] = Train()
%Genera (y devuelve) un modelo entrenado con los datos conocidos, que luego
%se usará para predecir con los datos desconocidos

ap=zeros(202+211+212,3);
ap(1:202,3)=1; %circulares
ap(203:202+211,3)=2; %elongadas
ap(202+211+1:size(ap,1),3)=3;%otras

%% Calculo circulares
for p=1:202
folder='C:\Users\server\Desktop\PDI\ProyectoFinal\erythrocytesIDB1\individual cells\circular\'
filePattern = fullfile(folder, '*.jpg');
file=dir(filePattern);
filename=fullfile(file(p).folder,file(p).name);
im=imread(filename);
im_pre=Preproc(imcomplement(rgb2gray(im)));
[AP im_AP]=AreaPerimetro(im_pre);
ap(p,1:2)=AP(1:2);
end

%% Calculo elongadas
for p=1:211
folder='C:\Users\server\Desktop\PDI\ProyectoFinal\erythrocytesIDB1\individual cells\elongated\'
filePattern = fullfile(folder, '*.jpg');
file=dir(filePattern);
filename=fullfile(file(p).folder,file(p).name);
im=imread(filename);
im_pre=Preproc(imcomplement(rgb2gray(im)));
[AP im_AP]=AreaPerimetro(im_pre);
for k=1:size(AP,1)
if((4*pi*AP(k,1))/AP(k,2)^2<0.8) %me quedo solo con las elongadas
    ap(p+(k-1)+202,1:2)=AP(k,:);
end
end

end

%% Calculo otras
for p=1:212
folder='C:\Users\server\Desktop\PDI\ProyectoFinal\erythrocytesIDB1\individual cells\other\'
filePattern = fullfile(folder, '*.jpg');
file=dir(filePattern);
filename=fullfile(file(p).folder,file(p).name);
im=imread(filename);
im_pre=Preproc(imcomplement(rgb2gray(im)));
[AP im_AP]=AreaPerimetro(im_pre);
for k=1:size(AP,1)
if((4*pi*AP(k,1))/AP(k,2)^2<0.9) %me quedo solo con las elongadas
    ap(p+(k-1)+202+211,1:2)=AP(k,1:2);
end
end

end

%% Armo la tabla 
ap(any(isnan(ap), 2), :) = [];
FR=4*pi*ap(:,1)./ap(:,2).^2;
Clase=ap(:,3);
Clase=Clase(1:625);
FR=FR(1:625);
%t=table(FR(1:625),Clase(1:625));
%mdl=fitcdiscr(t,Clase(1:625));
mdl=fitcdiscr(FR,Clase);
