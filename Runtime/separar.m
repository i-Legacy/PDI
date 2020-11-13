function [APE_sep, im_APE_sep] = separar(im_APE_peg, im, Umin, Umax)

im_APE_sep  = crop(im_APE_peg,im, Umin, Umax);
[label , tam] = bwlabel(im_APE_sep);
for j = 1 : tam
    ind = find(label == j);
    area = length(ind);
    if(area > Umax)
        label(ind)=0;
    end
end
[APE_sep, im_APE_sep] = FeaturesExtraction(logical(label));

end