function [rgbFixed,rgbFixed2] = insertarCirculo( mancha1, rgbFixed, rgbFixed2 )
    figure(3);imshow(mancha1);
    distancia = bwdist(~mancha1);
    [posy posx] = find(distancia==(maxMatrix(distancia)),1,'last');
    r = maxMatrix(distancia);
    disp('entro');
    disp('*****');
    disp(posx);
    disp(posy);
    disp('-----');
    rgbFixed = insertShape(rgbFixed,'circle',[posx posy r+1],'LineWidth',5,'Color','Red');
    rgbFixed2 = insertShape(rgbFixed2,'FilledCircle',[posx posy r+1],'LineWidth',5,'Color','Black');
    rgbFixed2(rgbFixed2==102) = 0;
    rg = rgbFixed2(:, :, 1);
    mancha1(rg==0)=0;
    %figure(4);imshow(mancha1);impixelinfo();
    %figure(5);imshow(rgbFixed);
    
    
%     [manchas1 cantidad1] = bwlabel(mancha1);
%     %disp(cantidad);
%     for i=1:cantidad1
%         mancha = mancha1;
%         mancha(manchas1~=i)=0;
%         mancha(mancha>0)=1;
%         figure(6);imshow(mancha);
%         
%         [rgbFixed,rgbFixed2] = insertarCirculo(mancha,rgbFixed,rgbFixed2);
%     end
    
end

