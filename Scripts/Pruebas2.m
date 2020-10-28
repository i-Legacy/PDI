%Recibe la imagen en escala de grises, luego de haber eliminado los
%leucocitos con EliminarWBC

%Circulares

%CELULA1

im1 = imread('c0001.jpg');
im1 = rgb2gray(im1);

[AP1, im_ap] = AreaPerimetro(im1);

%Factor redondez

circularity1c =  (4 *pi* AP1(1,1))/ (AP1(1,2)^ 2) ;

%CELULA2

im2 = imread('c0002.jpg');
im2 = rgb2gray(im2);

[AP2, im_ap] = AreaPerimetro(im2);

%Factor redondez

circularity2c =  (4 *pi* AP2(1,1))/ (AP2(1,2)^ 2) ;


%CELULA3

im3 = imread('c0003.jpg');
im3 = rgb2gray(im3);

[AP3, im_ap] = AreaPerimetro(im3);

%Factor redondez

circularity3c =  (4 *pi* AP3(1,1))/ (AP3(1,2)^ 2) ;



%Elongadas

%CELULA1

ime1 = imread('e0001.jpg');
ime1 = rgb2gray(ime1);

[APe1, im_ap] = AreaPerimetro(ime1);

%Factor redondez

circularity1e =  (4 *pi* APe1(1,1))/ (APe1(1,2)^ 2) ;

%CELULA2

ime2 = imread('e0002.jpg');
ime2 = rgb2gray(ime2);

[APe2, im_ap] = AreaPerimetro(ime2);

%Factor redondez

circularity2e =  (4 *pi* APe2(1,1))/ (APe2(1,2)^ 2) ;


%CELULA3

ime3 = imread('e0003.jpg');
ime3 = rgb2gray(ime3);

[APe3, im_ap] = AreaPerimetro(ime3);

%Factor redondez

circularity3e =  (4 *pi* APe3(1,1))/ (APe3(1,2)^ 2) ;



%Otras

%CELULA1

imo1 = imread('o0001.jpg');
imo1 = rgb2gray(imo1);

[APo1, im_ap] = AreaPerimetro(imo1);

%Factor redondez

circularity1o =  (4 *pi* APo1(1,1))/ (APo1(1,2)^ 2) ;

%CELULA2

imo2 = imread('o0002.jpg');
imo2 = rgb2gray(imo2);

[APo2, im_ap] = AreaPerimetro(imo2);

%Factor redondez

circularity2o =  (4 *pi* APo2(1,1))/ (APo2(1,2)^ 2) ;


%CELULA3

imo3 = imread('o0003.jpg');
imo3 = rgb2gray(imo3);

[APo3, im_ap] = AreaPerimetro(imo3);

%Factor redondez

circularity3o =  (4 *pi* APo3(1,1))/ (APo3(1,2)^ 2) ;


%Las circulares van entre 0.9 y 1
%Las otras van entre 0.7 y 0.8
%Las elongadas son menores a 0.7
