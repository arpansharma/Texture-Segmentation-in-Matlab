clc;
clear all;
close all;
[fname path] = uigetfile('*.*', 'Enter an Image');
fname = strcat(path,fname);
I = imread(fname);
subplot(2,2,1);
imshow(I),title('Original Image');
ScrSize = get(0,'ScreenSize');
set(gcf,'Units','pixels','Position',ScrSize,'Toolbar','none','Menubar','none');

I = rgb2gray(I);
E = entropyfilt(I);
Eim = mat2gray(E);
subplot(2,2,2);
imshow(Eim), title('Texture Image');

%Why is the Value of threshold taken as 0.8 ?
%May be this differs from image to image.
%Depending on objects that need to be segmented.
BW1 = imbinarize(Eim, .8);
subplot(2,2,3);
imshow(BW1), title('Rought Mask for Texture 1');    

%Value of 2000 ?
%Even this depends on the type of image.
BWao = bwareaopen(BW1,2000);

nhood = true(9);
closeBWao = imclose(BWao,nhood);

roughMask = imfill(closeBWao,'holes');
subplot(2,2,4);
imshow(roughMask), title('Segmenting Texture 2');

I2 = I;
I2(roughMask) = 0;
figure;
subplot(2,2,1);
imshow(I2), title('Raw image of Texture 2');
ScrSize = get(0,'ScreenSize');
set(gcf,'Units','pixels','Position',ScrSize,'Toolbar','none','Menubar','none');

E2 = entropyfilt(I2);
E2im = mat2gray(E2);
subplot(2,2,2);
imshow(E2im), title('Calculated Texture 2 image');

BW2 = imbinarize(E2im);
mask2 = bwareaopen(BW2,1000);

texture1 = I;
texture1(~mask2) = 0;
texture2 = I;
texture2(mask2) = 0;
subplot(2,2,3);
imshow(texture1), title('Segmentation Result of Texture 1');
subplot(2,2,4);
imshow(texture2), title('Segmentation Result of Texture 2');

boundary = bwperim(mask2);
segmentResults = I;
segmentResults(boundary) = 255;
figure;
imshow(segmentResults), title('Boundary Separated Textures');
ScrSize = get(0,'ScreenSize');
set(gcf,'Units','pixels','Position',ScrSize,'Toolbar','none','Menubar','none');


