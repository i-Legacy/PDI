function bbox = bboxresize(BB, scale, size)
 
bbox(1) = BB(1) - size; 
bbox(2) = BB(2) - size; 
bbox(3) = BB(3) + size*2; 
bbox(4) = BB(4) + size*2; 
bbox = bbox * scale; 
 
end
