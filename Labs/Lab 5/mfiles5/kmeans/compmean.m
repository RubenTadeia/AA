function [c,var] = compmean(s,class)
%[C,VAR] = COMPMEAN(S,CLASS) compute the mean of each class
% in matrix sample S according to the classes specified in vector 
% CLASS. 
%
% c is a matrix in which each row is the mean of each class. VAR a 
% column vector in which each entry is the determinant of the 
% autocovariant matrix of the samples in each class.
%
% Author: Fernando M. Silva
%         Instituto Superior T'ecnico
%         fcr@inesc.pt
%  
  [dim,ns] = size(s);
  nc = max(class);
  c(1:dim,1:nc)=0;
  var(1,1:nc) = 0;
  rxx(1:dim,1:dim) = 0;
  for k=1:nc,
    selector = 1-sign(abs((class-k)));
    nums = sum(selector);
    mean = s * selector / nums;
    
    for kx=1:dim,
      for ky=1:dim,
        a = (s(kx,:)-mean(kx));
        b = (s(ky,:)-mean(ky));         
        rxx(kx,ky) = sum(a.*b*selector);
      end
    end
    
    rxx = rxx / nums;   
    c(:,k) = mean;
    var(k) = det(rxx);
  end
  
    
