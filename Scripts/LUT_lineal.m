%%---------inciso B

function LUT = LUT_lineal(C, B)

LUT = uint8(zeros(256, 1));
tam = size(LUT);
for k=1 : tam
    aux = k*C + B;
    if aux > 255
        aux = 255;
    elseif aux < 0 
        aux = 0;
    end
    LUT(k) = aux;
end

end