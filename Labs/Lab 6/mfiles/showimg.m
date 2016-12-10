function showimg(v,bias)
    global h w
    colormap('gray');
    [nr,nc]=size(v);
    if (nargin<2)
        bias=zeros(nr,1);
    end
    r=[];
    for i=1:nc
        r=[r,reshape(v(:,i)+bias,h,w)];
    end
    imagesc(r);
end
