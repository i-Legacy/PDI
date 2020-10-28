%Las IMG son de 80x80

%Circulares

%CELULA 1

R1 = imread('c0001.jpg');
R1 = im2double(R1);
R1 = rgb2gray(R1);

Umbral = graythresh(R1);
R1b = imbinarize(R1,Umbral);
R1c = imcomplement(R1b);
imshow(R1c);

R1fil=imclearborder(R1c); 
imshow(R1fil);

SE1=strel('disk',3);
R1open=imopen(R1fil,SE1);
imshow(R1open);


%Perimetro

SE2=strel('disk',1);
im_eros=imerode(R1open,SE2);
contornoC=R1open-im_eros;
imshow(contornoC);

[filaa1C columnaa1C] = find(R1open == 1);
[filap1C columnap1C] = find(contornoC == 1); 

p1C = numel(columnap1C);
a1C = numel(columnaa1C);

%Factor redondez

circularity1C = (p1C.^ 2) ./ (4 * pi * a1C);

%CELULA 2

R2 = imread('c0002.jpg');
R2 = im2double(R2);
R2 = rgb2gray(R2);

Umbral = graythresh(R2);
R2b = imbinarize(R2,Umbral);
R2c = imcomplement(R2b);
imshow(R2c);

R2fil=imclearborder(R2c); 
imshow(R2fil);

SE1=strel('disk',3);
R2open=imopen(R2fil,SE1);
imshow(R2open);


%Perimetro

SE2=strel('disk',1);
im_eros=imerode(R2open,SE2);
contornoC=R2open-im_eros;
imshow(contornoC);

[filaa2C columnaa2C] = find(R2open == 1);
[filap2C columnap2C] = find(contornoC == 1); 

p2C = numel(columnap2C);
a2C = numel(columnaa2C);

%Factor redondez

circularity2C = (p2C.^ 2) ./ (4 * pi * a2C);

%CELULA 3

R3 = imread('c0003.jpg');
R3 = im2double(R3);
R3 = rgb2gray(R3);

Umbral = graythresh(R3);
R3b = imbinarize(R3,Umbral);
R3c = imcomplement(R3b);
imshow(R3c);

R3fil=imclearborder(R3c); 
imshow(R3fil);

SE1=strel('disk',3);
R3open=imopen(R3fil,SE1);
imshow(R3open);


%Perimetro

SE2=strel('disk',1);
im_eros=imerode(R3open,SE2);
contorno3C=R3open-im_eros;
imshow(contorno3C);

[filaa3C columnaa3C] = find(R3open == 1);
[filap3C columnap3C] = find(contorno3C == 1); 

p3C = numel(columnap3C);
a3C = numel(columnaa3C);

%Factor redondez

circularity3C = (p3C.^ 2) ./ (4 * pi * a3C);


%Elongadas

%CELULA 1

E1 = imread('e0001.jpg');
E1 = im2double(E1);
E1 = rgb2gray(E1);

Umbral = graythresh(E1);
E1b = imbinarize(E1,Umbral);
E1c = imcomplement(E1b);
imshow(E1c);

E1fil=imclearborder(E1c); 
imshow(E1fil);

SE = strel('disk',10);
E1fil = imclose(E1fil,SE);
imshow(E1fil);

SE1=strel('disk',3);
E1open=imopen(E1fil,SE1);
imshow(E1open);


%Perimetro

SE2=strel('disk',1);
im_eros=imerode(E1open,SE2);
contornoE=E1open-im_eros;
imshow(contornoE);

[filaa1E columnaa1E] = find(E1open == 1);
[filap1E columnap1E] = find(contornoE == 1); 

p1E = numel(columnap1E);
a1E = numel(columnaa1E);

%Factor redondez

circularity1E = (p1E.^ 2) ./ (4 * pi * a1E);

%Otras

%CELULA 1

O1 = imread('o0001.jpg');
O1 = im2double(O1);
O1 = rgb2gray(O1);

Umbral = graythresh(O1);
O1b = imbinarize(O1,Umbral);
O1c = imcomplement(O1b);
imshow(O1c);

O1fil=imclearborder(O1c); 
imshow(O1fil);

SE1=strel('disk',3);
O1open=imopen(O1fil,SE1);
imshow(O1open);


%Perimetro

SE2=strel('disk',1);
im_eros=imerode(O1open,SE2);
contornoO=O1open-im_eros;
imshow(contornoO);

[filaa1O columnaa1O] = find(O1open == 1);
[filap1O columnap1O] = find(contornoO == 1); 

p1O = numel(columnap1O);
a1O = numel(columnaa1O);

%Factor redondez

circularity1O = (p1O.^ 2) ./ (4 * pi * a1O);


%CELULA 2


O2 = imread('o0002.jpg');
O2 = im2double(O2);
O2 = rgb2gray(O2);

Umbral = graythresh(O2);
O2b = imbinarize(O2,Umbral);
O2c = imcomplement(O2b);
imshow(O2c);

O2fil=imclearborder(O2c); 
imshow(O2fil);

SE = strel('disk',10);
O2fil = imclose(O2fil,SE);
imshow(O2fil);

SE1=strel('disk',3);
O2open=imopen(O2fil,SE1);
imshow(O2open);


%Perimetro

SE2=strel('disk',1);
im_eros=imerode(O2open,SE2);
contornoO2=O2open-im_eros;
imshow(contornoO2);

[filaa2O columnaa2O] = find(O2open == 1);
[filap2O columnap2O] = find(contornoO2 == 1); 

p2O = numel(columnap2O);
a2O = numel(columnaa2O);

%Factor redondez

circularity2O = (p2O.^ 2) ./ (4 * pi * a2O);