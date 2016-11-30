function [classErr,class,nums] = nearest(s,c)
%[classErr,class,nums] = nearest(s,c) distributes the samples in matrix 
% s by  the clusters defined in the centers in matrix c, according 
% nearest neighbor criteria
%
%   Each column in s is a sample and each column in c is a center.
%
%  classErr Nc-dimension vector with the mean square error
%           in each class. The total squared error can be
%           computed by sum(classErr);
%
%   class is a  column vector, with dimension equal to the 
% number of samples, that specifies the class (nearest center) for each   
% sample.
%
%   nums is an integer vector, whose dimension is the number of 
% classes, that returns the total number of samples in each class.
%
%
% Author: Fernando M. Silva
%         Instituto Superior T'ecnico
%         fcr@inesc.pt
%
  [dim,ns]   = size(s);
  [dummy,nc] = size(c); 
  class = 0*[1:ns]';
  nums  = 0*[1:nc]';
  classErr(1:nc) = 0;
  for k=1:ns,
    dmin = distsqr(s(:,k),c(:,1));
    ic = 1;
    for n=2:nc,
      d = distsqr(s(:,k),c(:,n));
      if(d < dmin),
	dmin = d;
	ic = n;
      end
    end
    class(k)=ic;
    nums(ic) = nums(ic)+1;
    classErr(ic) = classErr(ic) + dmin;
  end
