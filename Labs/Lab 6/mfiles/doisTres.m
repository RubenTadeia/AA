%Cálculo das variâncias ou energias:
% Variância dos dados iniciais (centrados
% ou não):
sx=0;
n=20;
for i=1:n
sx=sx+d(i,i);
end
% Variância dos dados reconstruídos para
% diferentes valores de m
sxr=zeros(n,1);
for m=1:n
for i=1:m
sxr(m)=sxr(m)+d(n+1-i,n+1-i);
end
end
% Variâncias dos dados reconstruídos
% relativas à dos dados iniciais:
sxrsx=sxr/sx;
% Determinação do número mínimo de
% componentes prinipais que representam
% mais de 95% da energia dos dados:
m=n;
while sxrsx(m)>0.95 && m>0
m=m-1;
end
m=m+1;
display(m);