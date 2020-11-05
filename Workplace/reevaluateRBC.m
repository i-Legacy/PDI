function result = reevaluateRBC(BW, im) 
  
 result = zeros(size(BW)); 
 L = bwlabel(BW, 8); 
stats = regionprops(L, 'BoundingBox');  
 
 for k = 1 : length(stats) 
    BB = stats(k).BoundingBox; 
    rec = bboxresize(im, BB); 
    aux = CelPegadas(rec);
    result = result + aux; 
end 
 
end 
 