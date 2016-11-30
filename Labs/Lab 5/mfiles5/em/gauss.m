function v = gauss(x,g)
%  V=GAUSS(X,M) 
%  Computes the pdf of the gaussian specified by G
%  at the points specified by X.
%
% X may be a matrix in which each column represents an 
% independent sample. In this case, V is a row-vector 
% of the same size of the number of samples in X.
% 
% Some globals are used here for sake of efficiency
%
% Author: Fernando M. Silva
%         Instituto Superior T'ecnico
%         fcr@inesc.pt
%
  global meanG m0G r1G aG bG dxG;

  meanG  = g{1};
  r1G    = g{4};
  d      = g{5};
  dim    = length(r1G);

  sz = size(x);
  ns = sz(2);
  m0G = meanG*([1:ns]*0+1);
  dxG = x - m0G;
  
  aG = r1G * dxG;
  bG = aG .* dxG;
  ex = bG(1,:);
  for k=2:dim,
    ex = ex + bG(k,:);
  end
  ex = ex / 2;
  
  c = (2*pi)^length(meanG)*d;
  
  v = exp(-ex)/sqrt(c);
  return

  
  
		      



