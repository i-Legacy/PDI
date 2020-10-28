function result = AplicarWatershed(im)

%     for k=1 : m
%         if L(j, k) == 1
%             matrix(j, k) = L(j, k);
%         end
%     end
% % end
% %    
% stats=regionprops(im,'BoundingBox');
% 
% %separación individual
% clear matriz;%col1: area; col2:perimetro
% cont=1;
% matrix = zeros(n, m);
% for k = 1 : length(stats)
%    thisBB = stats(k).BoundingBox;
%    mat=im(round(thisBB(2)-1):round(thisBB(4)+thisBB(2)),round(thisBB(1)-1):round(thisBB(1)+thisBB(3)));
%    %im_limpia=imclearborder(mat);%Limpio los bordes
%    mat = imresize(mat, 4);
%    imwshed 
%    wshedmat = im(round(thisBB(2)-1):round(thisBB(4)+thisBB(2)),round(thisBB(1)-1):round(thisBB(1)+thisBB(3)));
%    
%   
  Lrgb = wshed(cr)
 
  figure
  subplot(121)
  imshow(Lrgb )
  subplot(122)
  imshow(cr)

end