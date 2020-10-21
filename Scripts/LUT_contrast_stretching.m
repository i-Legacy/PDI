function LUT = LUT_contrast_stretching(a, b)

% Las 3 rectas q se forman uniendo el origen con a, a con b y b con el
% final estan definidas por el grafico O[i] - i. 
% i: input image density
% O[i]: output image density
% Las intensidades estan definidas entre 0-255
% Divido el plot en tertilos

LUT = uint8(zeros(255, 1));

tertilo_1 = 255/3;
tertilo_2 = tertilo_1 * 2;
tertilo_3 = 255;
% 1er tertilo: 0 - 84
% 2do tertilo: 85 - 170
% 3er tertilo: 171 - 255

m_1 = a / tertilo_1;
for k=1 : 85
    LUT(k) = a - m_1 * (tertilo_1 - k);
end

m_2 = (b - a) / (tertilo_2 - tertilo_1);
for k=tertilo_1 : tertilo_2
    LUT(k) = b - m_2 * (tertilo_2 - k);
end

m_3 = (tertilo_3 - b) / (tertilo_3 - tertilo_2);
for k=tertilo_2 : tertilo_3
    LUT(k) = tertilo_3 - m_3 * (tertilo_3 - k);
end

end