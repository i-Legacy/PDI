%%---------inciso A

function imagen_transformada = AplicarLUT(imagen, LUT)

% Debo escalar la LUT segun la cantidad de colores de la imagen
% Como es escala de grises, utilizo 0-255 colores posibles
if size(imagen, 3) > 1
    imagen = rgb2gray(imagen);
end

[rows , columns] = size(imagen);

% Defino una imagen del mismo tamaño que la original, pero rellena de ceros
imagen_transformada = uint8(zeros(rows, columns));
for k=1 : rows
    for m=1 : columns
        % en cada pixel de la imagen, guardo el resultado de pasar el pixel
        % original por una LUT
        imagen_transformada(k, m) = LUT(imagen(k, m));
    end
end

end
