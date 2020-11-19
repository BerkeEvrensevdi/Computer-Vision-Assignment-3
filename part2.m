clear all;
im= imread("original.jpg");

figure, imshow(im);

im=imresize(im,[85,110]);

[labels, peaks]=segmentMS(im,100,20);

labels = imresize(labels,[250,400]);

figure;

imshow(labels);