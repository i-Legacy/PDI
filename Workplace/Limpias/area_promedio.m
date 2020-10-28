folder = 'E:\Documentos\ING_BIOMEDICA\Cuarto Año\Segundo Cuatrimestre\Procesamiento Digital de Imágenes\TP_Final\Workplace\Limpias\';
a = dir([folder '*.jpg']);
cant = size(a,1);

matrix = zeros(2, cant); % Aqui guardo todas las areas y promedios 


% Necesito guardar las imagenes como Logical o si no no puedo
% Me dio paja seguir

for k=1 : cant
     dir = sprintf('%s%d.jpg', folder, k);
     im = imread(dir);
     im =imbinarize(im, 0.1);
     
     % Area
     matrix(1, k) = sum( im(:) ); % como esta binarizada se puede hacer esto para estimar el area
     
     % Perimetro
     % circularity = (Perimeter .^ 2) ./ (4 * pi * area);
end

%% Histograma de Areas
histogram(matrix(1, :),'NumBins', size(matrix, 2),'BinLimits',[0 max(matrix(1, :))])

%% Histograma de Perimetros

%% Histograma de Roundness
