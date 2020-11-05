function rec = bboxresize(im, BB) 
 
scale = 4; 
BB(1) = BB(1) - 15; 
BB(2) = BB(2) - 15; 
BB(3) = BB(3) + 30; 
BB(4) = BB(4) + 30; 
BB = BB * scale; 
rec = im(round(BB(2)) : round(BB(4)+BB(2)), round(BB(1)) : round(BB(1)+BB(3)), :); 
 
end

function result = reevaluateRBC(BW, im) 
  
 result = zeros(size(BW)); 
 L = bwlabel(BW, 8); 
stats = regionprops(L, 'BoundingBox');  
 
 for k = 1 : length(stats) 
    BB = stats(k).BoundingBox; 
    rec = bboxresize(im, BB); 
    result = result + rec; 
end 
 
end 
 