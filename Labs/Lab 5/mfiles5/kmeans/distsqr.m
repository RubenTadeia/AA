function d2 = distsqr(x,y)
%D = DISTSQR(X,Y) return the squared euclidean distance
% between x and y
%
% Author: Fernando M. Silva
%         Instituto Superior T'ecnico
%         fcr@inesc.pt
%
   b = x-y;
   d2 = b'*b;
   return;
   