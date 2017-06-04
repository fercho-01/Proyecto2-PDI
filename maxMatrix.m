%----------------------------------
%   Tarea 3, maxMatrix
%       - Luis Fernando Orozco (lfernando.orozco@udea.edu.co)
%         Estudiante de Ingeniería de Sistemas, Udea
%         CC 1216716983
%       - Santiago Sanmartin (santiago.sanmartin@udea.edu.co)
%         Estudiante de Ingenieria de Sistemas, Udea
%         CC 1017209945
%       V1 abril 2017

%Esta función halla el valor maximo de una matriz
function [NM,F,C]=maxMatrix(M)
    
    %Se obtienen las dimensiones de la matriz
    [tf,tc]=size(M);
    NM=M(1,1); %Primer elemento de la matriz
    F=1;
    C=1;
    
    %Se recorre la matriz
    for i=1:tf
        for j=1:tc
        %Se compara el valor maximo hasta ahora con el actual
        if M(i,j)>NM
            %Si el actual es mayor que el que se tenia, se actualiza el
            %valor maximo
            NM=M(i,j);
            F=i;
            C=j;
        end
    end
end


