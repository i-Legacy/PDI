function result = relabel(im, k)

% Debe recibir la im_APE_sep labeleada
% Sumo el indice de im_APE para poder concatenarlo
tam = max(im(:));
for j=1 : tam
    im(find(im == j)) = j + k;
end
result = im;

end