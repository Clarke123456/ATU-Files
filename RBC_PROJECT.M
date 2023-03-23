clc
clear all
close all

rgb = imread('3.png');

I = rgb2gray(rgb);
figure,imshow(I)

level = multithresh(I)
level = 0.7

BW = imbinarize(I,level);

figure
imshowpair(rgb,BW,'montage'),title('Orginal v Binary')



