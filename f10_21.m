%% CLEAR ALL
clc; clear all;

%% Imagen green channel
im=imread('007source.jpg');
im=imresize(im,0.25);
img=im(:,:,2); %Me quedo con el canal G
U=graythresh(im);
imb=imbinarize(img,U);
imb = imcomplement(imb);

%% CMYK
imcmyk = rgb2cmyk(im);
cyan = imcmyk(:, :, 1);
magenta = imcmyk(:, :, 2);
yellow = imcmyk(:, :, 3);
black = imcmyk(:, :, 4);
% 
% figure
% subplot(2, 2, 1)
% imshow(cyan)
% subplot(2, 2, 2)
% imshow(yellow)
% subplot(2, 2, 3)
% imshow(magenta)
% subplot(2, 2, 4)
% imshow(black)


%% prueba
result = magenta;
[n, m] = size(magenta);
umbralRBC = [0 85];
aux = double(zeros(size(magenta)));
for j=1 : n
    for k=1 : m
        if magenta(j, k) < umbralRBC(1) || magenta(j, k) > umbralRBC(2)
            aux(j, k) = 1;
        end
    end
end

SE = strel('disk', 2);
imo = imopen(aux, SE);
SE = strel('disk', 10);
imc = imclose(imo, SE);
SE = strel('disk', 5);
imd = imdilate(imc, SE);
for j=1 : n
    for k=1 : m
         if imd(j, k) == 1
             result(j, k) = 0;
         end
    end
end

imb = imbinarize(result); 
SE = strel('disk', 4);
imo = imopen(imb, SE);
result = magenta;
for j=1 : n
    for k=1 : m
         if imo(j, k) == 0
             result(j, k) = 0;
         end
    end
end
%% Print
figure 
subplot(1, 2, 1)
imshow(magenta)
title("magenta")
subplot(1, 2, 2)
imshow(result)
title("resultado")
    
%% borrado de las q son muy pequeñas






