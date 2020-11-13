function drawBB(im)

s = regionprops(im);
figure
imshow(im);
hold on

for j=1 : length(s)
    thisBB = s(j).BoundingBox;
    rectangle('Position', [thisBB(1), thisBB(2), thisBB(3), thisBB(4)], 'EdgeColor','r', 'LineWidth', 3);
    hold on
end

end