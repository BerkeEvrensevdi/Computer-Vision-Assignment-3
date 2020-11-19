clear all;
%H_hanging = load('H_hanging.mat');
%H_ND = load('H_ND.mat');
%H_Rainier = load('H_Rainier.mat');
load('H_Hanging.mat', 'H')


hanging1 = imread('Hanging1.png');
hanging2 = imread('Hanging2.png');
;

homInverse = inv(H);
disp(homInverse);
result = Stitch2(im2double(hanging1),im2double(hanging2),H,homInverse);
figure; imshow(result);