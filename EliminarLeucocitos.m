im=(imread('005source.jpg'));
im=imresize(im,0.25);

im_cymk=rgb2cmyk(im);
im_y=im_cymk(:,:,2);

%U=graythresh(im_y)

h=histogram(im_y,'NumBins',256,'BinLimits',[0 255]);
%U=triangulo(h.BinCounts,'R');

[pks locs]=findpeaks(h.BinCounts)
picos=zeros(length(pks),2);
picos(:,1)=pks;
picos(:,2)=locs;
picos=sortrows(picos,1,'descend');
U=round((picos(1)+2*picos(2))/3);

im_y=imbinarize(im2double(im_y),U/255);

%SE=strel('disk',2);
%im_y=imclose(im_y,SE);

im=im2double(im_cymk(:,:,2))-im2double(im_y);
imshow(im);