clc
clear all;
close all;

rgb = imread('3.png');

I = rgb2gray(rgb);
figure,imshow(I);

I_imadjust = imadjust(I);
I_histeq = histeq(I);
I_adapthisteq = adapthisteq(I);
montage({I,I_imadjust,I_histeq,I_adapthisteq},"Size",[1 4])
title("Original Image and Enhanced Images using" +...
    "imadjust,histeq,and adapthisteq")

BW = imbinarize(I_adapthisteq);
figure,imshowpair(rgb,BW,'montage'),title('Original V Binary')