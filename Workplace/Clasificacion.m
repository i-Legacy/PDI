function [matriz]=Clasificacion(matriz)
%recibe una matriz con area y perimetro y almacena la etiqueta
%correspondiente en una tercer columna
% 1: redonda
% 2: elongada
% 3: otra

%Defino los umbrales (buscar algun criterio)
Umin=0.3;
Umax=0.6;

for i=1:size(matriz,1) %Revisar por qué clasifica mal
    FR=matriz(i,2)^2/(4*pi*matriz(i,1));
    if(FR>Umax)
        matriz(i,3)=1; %es un RBC redondo
    elseif(FR>Umax&&FR<Umin)
        matriz(i,3)=2; %Es un RBC elongado
    elseif(FR<Umin)
        matriz(i,3)=3; %Es otra célula
    end
end