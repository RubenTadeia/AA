global w h

h=60;

x=imread('faces.bmp');

[nr,w]=size(x);
ni=nr/h;

y=[];

for i=1:ni
    xi=x(1+h*(i-1):h+h*(i-1),:);
    vi=reshape(xi,h*w,1);
    y(:,i)=vi;
end
