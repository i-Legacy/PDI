function [feat] = Feat_conoc()
%Extrae descriptores geom�tricos del 100% de las c�lulas ya clasificadas
%Faltar�a agregar otros descriptores
s1=202;
s2=209;
s3=211;
ap(1:s1,4)=1; %circulares
ap(s1+1:s1+s2,4)=2; %elongadas
ap(s1+s2+1:s1+s2+s3,4)=3;%otras

%% Calculo circulares
folder='E:\Documentos\ING_BIOMEDICA\Cuarto A�o\Segundo Cuatrimestre\Procesamiento Digital de Im�genes\Version 2, erythrocytesIDB\erythrocytesIDB1\individual cells\circular'
for p=1:s1
filePattern = fullfile(folder, '*.jpg');
file=dir(filePattern);
filename=fullfile(file(p).folder,file(p).name);
im=imread(filename);
im_pre=Preproc(imcomplement(rgb2gray(im)));
SE=strel('disk',20);
im_limpia=imclose(im_pre,SE);
[AP im_AP]=FeaturesExtraction(im_limpia);
ap(p,1:3)=AP(1:3);
% ap(p,1:2)=AP(1:2);
% stats=regionprops(im_limpia,'Eccentricity');
% ap(p,3)=stats(1).Eccentricity;
end

%% Calculo elongadas
folder='E:\Documentos\ING_BIOMEDICA\Cuarto A�o\Segundo Cuatrimestre\Procesamiento Digital de Im�genes\Version 2, erythrocytesIDB\erythrocytesIDB1\individual cells\elongated'
for p=1:s2
filePattern = fullfile(folder, '*.jpg');
file=dir(filePattern);
filename=fullfile(file(p).folder,file(p).name);
im=imread(filename);
im_pre=Preproc(imcomplement(rgb2gray(im)));
SE=strel('disk',10);
im_limpia=imclose(im_pre,SE);
[AP im_AP]=FeaturesExtraction(im_limpia);
ap(s1+p,1:3)=AP(1:3);
% stats=regionprops(im_limpia,'Eccentricity');
% ap(s1+p,3)=stats(1).Eccentricity;
 end

%% Calculo otras
folder='E:\Documentos\ING_BIOMEDICA\Cuarto A�o\Segundo Cuatrimestre\Procesamiento Digital de Im�genes\Version 2, erythrocytesIDB\erythrocytesIDB1\individual cells\other'
for p=1:s3
filePattern = fullfile(folder, '*.jpg');
file=dir(filePattern);
filename=fullfile(file(p).folder,file(p).name);
im=imread(filename);
im_pre=Preproc(imcomplement(rgb2gray(im)));
SE=strel('disk',10);
im_limpia=imclose(im_pre,SE);
[AP im_AP]=FeaturesExtraction(im_limpia);
ap(s1+s2+p,1:3)=AP(1:3);
% stats=regionprops(im_limpia,'Eccentricity');
% ap(s1+s2+p,3)=stats(1).Eccentricity;
end

%% Calculo los descriptores
% feat(:,1)=1:size(ap,1);
feat(:,1)=4*pi*ap(:,1)./ap(:,2).^2;
feat(:,2)=ap(:,3);
feat(:,3)=ap(:,4);

%% Chequeo normalidad para poder usar LDA
% %Esto se puede mostrar en el .ppt
% histogram(FR(1:s1))
% histogram(FR(s1+1:s1+s2))
% histogram(FR(s1+s2+1:s1+s2+s3))
% 
% %Hago un test Shapiro-Wilk
% [H,pvalue,W]=swtest(FR(1:s1),0.05)
% [H,pvalue,W]=swtest(FR(s1+1:s1+s2))
% [H,pvalue,W]=swtest(FR(s1+s2+1:s1+s2+s3))
% %Seg�n este test, la clase 1 y 3 no tienen distribuci�n normal; habr�a que
% %usar otro clasificador
% %probar fitncb