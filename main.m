clear all;close all;clc;
%Cargar imagen original
a = imread('DSC_2663.jpg');
%cargar mascara
b = imread('mascara2.jpg');

%usar la mascara para seleccionar la región de interes en la imagen
%original
b(b>0)=255;
a(b==255)=0;

%recortar la imagen original
[fil,col] = find(rgb2gray(a)>0);
fmin = min(fil(:));
fmax = max(fil(:));
cmin = min(col(:));
cmax = max(col(:));
c = a(fmin:fmax,cmin:cmax,:);
figure(1);
imshow(c);impixelinfo();

%extraer los canales r,g,b de la imagen
r = c(:, :, 1);
g = c(:, :, 2);
b = c(:, :, 3);

%aplicar median filter a cada canal de la imagen
redMF = medfilt2(r, [40 40]);
greenMF = medfilt2(g, [40 40]);
blueMF = medfilt2(b, [40 40]);

%reconstrucción de la imagen
rgbFixed = cat(3, redMF, greenMF, blueMF);
figure(2);imshow(rgbFixed);impixelinfo();

%reconstrucción de la imagen
rgbFixed = cat(3, redMF, greenMF, blueMF);
figure(2);imshow(rgbFixed);impixelinfo();

%Binarización de la imagen
redMF(blueMF>230) = 0;
greenMF(blueMF>230) = 0;
blueMF(blueMF>230) = 0;

redMF(blueMF ~= 0) = 255;
greenMF(blueMF ~= 0) = 255;
blueMF(blueMF ~= 0) = 255;

%reconstrucción de la imagen
rgbFixed = cat(3, redMF, greenMF, blueMF);
figure(3);imshow(rgbFixed);impixelinfo();
