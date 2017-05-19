%----------------------------------
%   Tarea 2, Main
%   Por:
%       - Luis Fernando Orozco (lfernando.orozco@udea.edu.co)
%         Estudiante de Ingeniería de Sistemas, Udea
%         CC 1216716983
%       - Santiago Sanmartin (santiago.sanmartin@udea.edu.co)
%         Estudiante de Ingenieria de Sistemas, Udea
%         CC 1017209945
%       V1 abril 2017

clear all;close all;clc;
%Cargar imagen original
a = imread('DSC_2663.jpg');
%cargar mascara
b = imread('mascara3.jpg');

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

%Se crea una copia de la imagen
rgbFixed2 = rgbFixed;
buscarCentroides = true;

while buscarCentroides
    %Se buscan los centroides de las manchas blancas
    Ibw = im2bw(rgbFixed);
    Ibw = imfill(Ibw,'holes');
    Ilabel = bwlabel(Ibw);
    stat = regionprops(Ilabel,'centroid','MajorAxisLength','MinorAxisLength');
    centroids = cat(1, stat.Centroid);
    centroids = round(centroids);

    indexCentroid =1;
    if(centroids>0)
 
        %Se recorre cada centroide encontrado
        for x = 1: numel(stat)
            r=5;
            seguir = true;
            %Buscar el radio
            centroidX = centroids(x,1);
            centroidY = centroids(x,2);
            pos1X = centroids(x,1); %arriba
            pos2X = centroids(x,1); %abajo
            pos1Y = centroids(x,2); %
            pos2Y = centroids(x,2);
            while seguir
                value1 = rgbFixed(centroidY,pos1X);
                value2 = rgbFixed(centroidY,pos1X);
                value3 = rgbFixed(pos1Y,centroidX);
                value4 = rgbFixed(pos2Y,centroidX);
               if (value1~=0)&&(value2~=0)&&(value3~=0)&&(value4~=0)
                   pos1X = pos1X-1;
                   pos2X = pos2X+1;
                   pos1Y = pos1Y-1;
                   pos2Y = pos2Y+1;
                   if(pos1X<1)||(pos2X>length(rgbFixed))||(pos1Y<1)||(pos2Y>length(rgbFixed))
                      seguir = false; 
                   end

               else
                   seguir = false;
                   figure(5);
                   imshow(rgbFixed);
               end
               r = ((pos2X-1)-(pos1X+1))/2;
               if(r<=0)
                  r=1; 
                  disp(pos1X);
                  disp(pos2X);
                  disp(pos1Y);
                  disp(pos2Y);
                  disp(centroidX);
                  disp(centroidY);
                  disp(rgbFixed(centroidY,centroidX));
               end
               %disp(r);
            end
            rgbFixed2 = insertShape(rgbFixed2,'circle',[centroidX centroidY r],'LineWidth',10,'Color',{'Red'});
            for l=1:r
                rgbFixed = insertShape(rgbFixed,'circle',[centroidX centroidY 0],'LineWidth',(r*2)+4,'Color','Black');
            end
            %pause(0.5);
            figure(4);
            imshow(rgbFixed2);impixelinfo();
            %pause;
        end
    else
       buscarCentroides = false; 
    end
    
end
figure(4);
imshow(rgbFixed2);impixelinfo();
figure(5);
imshow(rgbFixed);
% 
% Ibw = im2bw(rgbFixed);
% Ibw = imfill(Ibw,'holes');
% 
% 
% Ilabel = bwlabel(Ibw);
% stat = regionprops(Ilabel,'centroid');
% imshow(rgbFixed); hold on;
% for x = 1: numel(stat)
%     plot(stat(x).Centroid(1),stat(x).Centroid(2),'ro');
% end
% 
% %A = imread('circlesBrightDark.png');
% %imshow(A)
% 
% % c  = rgb2gray(rgbFixed);
% % C = imbinarize(c);
% % figure(4),imshow(C);
% % [B,L] = bwboundaries(C,'noholes');
% % imshow(label2rgb(L, @gray, [.5 .5 .5]))
% % for k = 1:length(B)
% %    boundary = B{k};
% %    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
% % end
% % 
% % Rmin = 1;
% % Rmax = 1000;
% % [centersBright, radiiBright] = imfindcircles(rgbFixed,[Rmin Rmax],'ObjectPolarity','bright');
% % %[centersDark, radiiDark] = imfindcircles(rgbFixed,[Rmin Rmax],'ObjectPolarity','dark');
% % viscircles(centersBright, radiiBright,'Color','b');
% 
% % Rmin = 1;
% % Rmax = 10;
% % [centersBright, radiiBright] = imfindcircles(rgbFixed,[Rmin Rmax],'ObjectPolarity','bright');
% % %[centersDark, radiiDark] = imfindcircles(rgbFixed,[Rmin Rmax],'ObjectPolarity','dark');
% % viscircles(centersBright, radiiBright,'Color','b');