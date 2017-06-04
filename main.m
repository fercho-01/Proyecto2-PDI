%----------------------------------
%   Tarea 3, Main
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



%Binarización de la imagen
 redMF(blueMF>230) = 0;
 greenMF(blueMF>230) = 0;
 blueMF(blueMF>230) = 0;

 redMF(blueMF ~= 0) = 255;
 greenMF(blueMF ~= 0) = 255;
 blueMF(blueMF ~= 0) = 255;

 %reconstrucción de la imagen
rgbFixed = cat(3, redMF, greenMF, blueMF);
rgbFixed2 = rgbFixed;
figure(2);imshow(rgbFixed);impixelinfo();
seguir=true;
j = 1;

%Pintar circulos en cada mancha
while seguir
    imagen = im2bw(rgbFixed);
    
    %Indentificar cuantas manchas blancas hay en la imagen
    [manchas cantidad] = bwlabel(imagen);
    
    if(cantidad>0)
        for i=1:cantidad
            %Esto se ejecuta por cada mancha blanca de la imagen
            
            %Se separa la mancha para esta iteración
            mancha1 = imagen;
            mancha1(manchas~=i)=0;
            mancha1(mancha1>0)=1;

            %Se inserta circulo en la imagen
            [rgbFixed,rgbFixed2,radio] = insertarCirculo(mancha1,rgbFixed,rgbFixed2);
            
            %Se almacena el radio del circulo insertado
            radios(j) = radio;
            radios(2,j) = j;
            j=j+1;
             
            figure(5);imshow(rgbFixed);
            
        end
    else
       %Si ya no hay donde insertar circulos se detiene el ciclo
       seguir=false; 
    end
    
    %Se lee comando por consola, si se ingresa s continua de lo contrario
    %se para el ciclo
    user_entry = input('prompt','s');
    if(user_entry~='y')
        seguir=false;
    end
end

%Muestras las imagenes
figure(4);imshow(rgbFixed2);impixelinfo();
figure(5);imshow(rgbFixed);

%Ordena la matriz de radios
radios2 = sort(radios);
figure(10);

%Se crea un histograma con los radios
h = histogram(radios2,373);
