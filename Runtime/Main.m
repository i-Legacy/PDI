%% Imagen actual
%clear all; clc
% im = imread('E:\Documentos\ING_BIOMEDICA\Cuarto A�o\Segundo Cuatrimestre\Procesamiento Digital de Im�genes\TP_Final\Imagenes\004source.jpg');
im=imread('C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\003source.jpg');
%% Armo el clasificador en base a las ya clasificadas
feat = Feat_conoc;
%Calculo los 2 accuracy del clasificador y el modelo, que luego se usar� sobre las im�genes completas
[acc_FR_dis, acc_FR_tr, acc_FR_nb, mdl_FR_knn,mdl_FR_dis,mdl_FR_tr,mdl_FR_nb] = Modelo(feat(:,[1 3])); %Considerando solo FR
[acc_Ec_dis, acc_Ec_tr, acc_Ec_nb, mdl_Ec_knn,mdl_Ec_dis,mdl_Ec_tr,mdl_Ec_nb] = Modelo(feat(:,[2 3])); %Considerando solo Ec (eccentricidad)
[acc_FR_Ec_dis, acc_FR_Ec_tr, acc_FR_Ec_nb, mdl_FR_Ec_knn,mdl_FR_Ec_dis,mdl_FR_Ec_tr,mdl_FR_Ec_nb] = Modelo(feat(:,1:3)); %Considerando ambos, FR y Ec. Este clasifica mejor (tiene mejor accuracy)

[acc_El_dis, acc_El_tr, acc_El_nb, mdl_El] = Modelo([feat(:,2)./feat(:,3) feat(:,3)]); %Considerando solo elipsidad (FR/Ec)
%Con la elipsidad anda peor, tiene peor accuracy que con los dem�s.
%Ac� vienen los dem�s modelos con otras features
%% Explicacion
% Primero separo en dos imagenes, im_APE_ind y im_APE_peg
% Luego clasifico la  previo a separarlas, im_APE, y le agrego un indice
% Recordar: Las tres imagenes estan labeleadas
% Me fijo cuales labels de im_APE tambien estan en im_APE_peg, y las borro
% del clasificador. Como le agrege un indice, ahora se que celulas son las q sobrevivieron
% Postproceso im_APE_peg para encontrar im_APE_sep
% Sumo im_APE_sep y im_APE_ind para obtener im_APE_final, donde todas las celulas estan separadas
% Clasifico las celulas de im_APE_ind, le agrego un indice y, a cada
% indice, le sumo el indice maximo del clasificador anterior. De esa
% manera, estoy creando un clasificador que arranca donde el primero termino
% concateno ambos clasificadores. Como el segundo estaba en el orden de
% im_APE_sep, a cada label de esta imagen le sumo el mismo valor q al indice del clasificador
% Asi, obteno tanto la imagen final de celulas separadas como un
% clasificador completo que esta en el orden de las celulas

%% trabajo con las no clasificadas
%for p=1:5
%folder='C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\'
%filePattern = fullfile(folder, '*.jpg');
%file=dir(filePattern);
%filename=fullfile(file(p).folder,file(p).name);
%im=imread(filename);

%  im=imread('C:\Users\server\Desktop\PDI\ProyectoFinal\PDI\Imagenes\c0001.jpg');
im_elim = EliminarWBC(im);
im_pre = Preproc(im_elim);
[APE, im_APE] = FeaturesExtraction(im_pre);

%Separo entre las que estan juntas
[Umin, Umax] = umbral(APE(:, 1));
[im_APE_ind,im_APE_peg] = individuales(APE(:,1:2), im_APE, Umin, Umax);

%% Clasifico las c�lulas individuales (que ya estan separadas)
% clas_indiv=Clasificar(mdl_FR,4*pi*AP(:,1)./AP(:,2).^2); %Con FR solamente
% clas_indiv=Clasificar(mdl_FR_Ec, [4*pi*APE(:,1)./APE(:,2).^2, APE(:,3)]); %Con Fr+Ec
clas_indiv=Ensamble( mdl_FR_Ec_knn,mdl_FR_Ec_dis,mdl_FR_Ec_tr,mdl_FR_Ec_nb,[feat(:,1:2) feat(:,3)],[4*pi*APE(:,1)./APE(:,2).^2, APE(:,3)]); %Con Fr+Ec, usando un ensamble

%Comparando a ojo las clasificaciones de ambos, funciona mejor el segundo,
%ya que el primero clasifica algunas como C cuando en realidad son O,
%mientras que esas mismas el segundo las clasifica como O (ver con imagen 5)
% roundness = [4*pi*APE_final(:,1)./APE_final(:,2).^2, APE_final(:,3)]; % [roundness, eccentricidad]
% clas = Clasificar(mdl_FR_Ec, roundness); 

%% Borro las clasificaciones correspondientes a las celulas pegadas
% Termina siendo mejor ponerlo 
clas_indiv(:,2)=clas_indiv;
tam = size(clas_indiv,1);
clas_indiv(:,1)=1:tam;
for i=1:tam %Borro los datos de las que est�n pegadas
    ind=find(im_APE_peg==i);
    if(isempty(ind)==0) %Si est� en la im�gen con c�lulas pegadas
        clas_indiv(i,:)=0; %La elimino de la clasificaci�n de las individuales
    end
end
clas_indiv( ~any(clas_indiv,2), : ) = [];  %elimino filas que estan en 0

%% Postprocesado
[APE_sep, im_APE_sep] = separar(im_APE_peg, im, Umin, Umax);
% clas_sep = Clasificar(mdl_FR_Ec, [4*pi*APE_sep(:, 1)./APE_sep(:, 2).^2, APE_sep(:, 3)]); %Con Fr+Ec
% clas_sep=Ensamble([feat(:,1:2) feat(:,3)],[4*pi*APE_sep(:,1)./APE_sep(:,2).^2, APE_sep(:,3)]);
clas_sep=Ensamble(mdl_FR_Ec_knn,mdl_FR_Ec_dis,mdl_FR_Ec_tr,mdl_FR_Ec_nb,[feat(:,1:2) feat(:,3)],[4*pi*APE_sep(:,1)./APE_sep(:,2).^2, APE_sep(:,3)]); %Con Fr+Ec, usando un ensamble

% Le agrego un indice en la primera columna
clas_sep(:, 2) = clas_sep;
clas_sep(:, 1) = (1 : length(clas_sep)) + tam;
% Concateno ambos clasificadores
% genero la imagen final de las celulas individuales
im_APE_result = im_APE_ind + im_APE_sep;
im_APE_result = logical(im_APE_result);

%% Grafico la imagen ya clasificada
figure()
im_etiq=imresize(im,0.25);
stats=regionprops(im_APE,'BoundingBox');
stats2 = regionprops(im_APE_sep,'BoundingBox'); %%
cont = 1;
%for k = 1 : length(stats)
for k = 1 : max(clas_sep(:, 1)) %%
    aux=find(clas_indiv(:,1)==k);
    aux2=find(clas_sep(:,1)==k); %%
    if(isempty(aux)==0) %si la c�lula k no es de ninguna c�lula despegada
        thisBB = stats(k).BoundingBox;
        rec=im_etiq(round(thisBB(2)):round(thisBB(4)+thisBB(2)),round(thisBB(1)):round(thisBB(1)+thisBB(3)),:);
        if(clas_indiv(aux,2)==1)
            im_clas=insertText(rec,[1,1],'C','Fontsize',round(20*thisBB(4)/35),'BoxOpacity',0,'TextColor','white'); 
        elseif(clas_indiv(aux,2)==2)
            im_clas=insertText(rec,[1,1],'E','Fontsize',round(20*thisBB(4)/35),'BoxOpacity',0,'TextColor','white');
        elseif(clas_indiv(aux,2)==3)
            im_clas=insertText(rec,[1,1],'O','Fontsize',round(20*thisBB(4)/35),'BoxOpacity',0,'TextColor','white');
        end
    elseif(isempty(aux2) == 0)
        thisBB = stats2(cont).BoundingBox;
        rec=im_etiq(round(thisBB(2)):round(thisBB(4)+thisBB(2)),round(thisBB(1)):round(thisBB(1)+thisBB(3)),:);
        if(clas_sep(aux2,2)==1)
            im_clas=insertText(rec,[1,1],'C','Fontsize',round(20*thisBB(4)/35),'BoxOpacity',0,'TextColor','white'); 
        elseif(clas_sep(aux2,2)==2)
            im_clas=insertText(rec,[1,1],'E','Fontsize',round(20*thisBB(4)/35),'BoxOpacity',0,'TextColor','white');
        elseif(clas_sep(aux2,2)==3)
            im_clas=insertText(rec,[1,1],'O','Fontsize',round(20*thisBB(4)/35),'BoxOpacity',0,'TextColor','white');
        end
        cont = cont + 1;
    end
    im_etiq(round(thisBB(2)):round(thisBB(4)+thisBB(2)),round(thisBB(1)):round(thisBB(1)+thisBB(3)),:)=im_clas;
end

imshow(im_etiq)
% for k = 1 : length(stats)
cont = 1;
for k = 1 : max(clas_sep(:, 1)) %%
    aux=find(clas_indiv(:,1)==k);
    aux2=find(clas_sep(:,1)==k); %%
    if (k <= max(clas_indiv(:, 1)))
        thisBB = stats(k).BoundingBox;
    else
        thisBB2 = stats2(cont).BoundingBox;
    end
    if(isempty(aux) == 0)
        rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','g','LineWidth',1 );
    elseif(isempty(aux2) == 0)
        rectangle('Position', [thisBB2(1),thisBB2(2),thisBB2(3),thisBB2(4)],'EdgeColor','r','LineWidth',1 );
        cont = cont + 1;
    end
%     else
%         rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','r','LineWidth',1 )    
%     end
end