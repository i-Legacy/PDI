function L = wshed(seg)

k = 5;
se = strel('disk', k);
ero = logical(imerode(seg, se));
s = regionprops(ero);
tam = length(s);
while(tam == 1)
    k = k + 5;
    se = strel('disk', k);
    ero = imerode(ero, se);
    s = regionprops(ero);
    tam = length(s);
end
% if tam >= 2
%     for j=1 : tam
%         thisBB = s(j).BoundingBox;
%         cx = round(thisBB(1) + thisBB(3)/2);
%         cy = round(thisBB(2) + thisBB(4)/2);
%         ero(cy, cx) = 0;
%     end
% elseif tam <= 1
%     kmeans
% end
% Distans transform
D = bwdist(~ero);
D = -D;

% Cambiar el minimo local para que deje de sobresegmentar porque me tiene
% RECONTRA PODRIDO Y NO PARA DE SOBRESEGMENTAR ODIO LA WATERSHED
mask = imextendedmin(D, 2);
D2 = imimposemin(D, mask);
%imshowpair(seg, mask, 'blend');

% watershed
w = watershed(D2, 8);
w(~seg) = 0;

% borro el ruido
Umin = 200;
L = bwlabel(w);
tam = max(L(:));
for j=1 : tam
    ind = find(L == j);
    area = length(ind);
    if(area < Umin)
        L(ind)=0;
    end
end
se = strel('disk', 10);
L = imerode(L, se);

end