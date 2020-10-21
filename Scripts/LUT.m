function imc = LUT(im, umbralRBC)

% saco canal amarillo
imcymk = rgb2cmyk(im);
imy = imcymk(:, :, 2);
[n, m] = size(imy);
% [n, m] = size(imc);
% min_ = min(imc(:));
% max_ = max(imc(:));
% N = double(max_ - min_);
% step = 255/N;
% lut = 0 : step : 255;
% result = zeros(n, m);
% for j=1 : n
%     for k=1 : m
%         result(j, k) = lut(imc(j, k)+1);
%     end
% end
aux = imy;
for j=1 : n
    for k=1 : m
        if imy(j, k) < umbralRBC(1) || imy(j, k) > umbralRBC(2)
            aux(j, k) = 0;
        end
    end
end
imb = imbinarize(aux);
% SE=strel('disk', 1);
% imo=imopen(imb, SE);
% SE=strel('disk', 1);
% imc=imclose(imo, SE);
figure
subplot(1, 2, 1)
imshow(imy)
subplot(1, 2, 2)
imshow(imb)

end