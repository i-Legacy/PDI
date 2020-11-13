function bbox = bboxresize(BB, scale, size)
 
bbox(1) = BB(1) - size; 
if(bbox(1) <= 0)
    bbox(1) = 1;
end
bbox(2) = BB(2) - size; 
if(bbox(2) <= 0)
    bbox(2) = 1;
end
bbox(3) = BB(3) + size*2; 
bbox(4) = BB(4) + size*2; 
bbox = bbox * scale; 
 
end
