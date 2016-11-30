function mix = mixdis(x,m)
% Y=MIXDIS(X,M) 
% Computes the probability density function (pdf) of the Gaussian mixture 
% specified by M at the points specified by X.
%
% X may be a matrix, in which each column represents a data point. In that case,
% Y is a row vector of the same size as the number of data points in X, and
% contains the values of the pdf at those points.
% 
%
% Author: Fernando M. Silva
%         Instituto Superior T'ecnico
%         fcr@inesc.pt
%
  ng = m{1};
  p = m{2};
  mix = 0.0;
  for k=1:ng,
    g = m{k+2};
    mix = mix + p(k) * gauss(x,g);
  end;
  
		      



