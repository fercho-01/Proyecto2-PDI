%----------------------------------
%   Tarea 3, insertarCirculo
%   Por:
%       - Luis Fernando Orozco (lfernando.orozco@udea.edu.co)
%         Estudiante de Ingeniería de Sistemas, Udea
%         CC 1216716983
%       - Santiago Sanmartin (santiago.sanmartin@udea.edu.co)
%         Estudiante de Ingenieria de Sistemas, Udea
%         CC 1017209945
%       V1 abril 2017

%Esta función inserta un circulo en una mancha blanca, este circulo será el
%el de radio mayor que se puede insertar en esta.
function [rgbFixed,rgbFixed2,r] = insertarCirculo( mancha1, rgbFixed, rgbFixed2 )
    figure(3);imshow(mancha1);
    
    %se calculan las distancias que hay entre cada pixel al borde de la
    %mancha, es decir donde cambia de blanco a negro.
    distancia = bwdist(~mancha1);
    
    %Se halla la distancia maxima, esta será nuestro radio
    [posy posx] = find(distancia==(maxMatrix(distancia)),1,'last');
    r = maxMatrix(distancia);
    
    %Se inserta el circulo en la imagen
    rgbFixed = insertShape(rgbFixed,'circle',[posx posy r+1],'LineWidth',5,'Color','Red');
    rgbFixed2 = insertShape(rgbFixed2,'FilledCircle',[posx posy r+1],'LineWidth',5,'Color','Black');
end

