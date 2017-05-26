function [NM,F,C]=maxMatrix(M)
[tf,tc]=size(M);
NM=M(1,1);
F=1;
C=1;
for i=1:tf
for j=1:tc
if M(i,j)>NM
NM=M(i,j);
F=i;
C=j;
end
end
end


