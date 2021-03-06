function y = gen(m)
% Y=GEN(M) 
%  generates one random sample according to the 
%  mixture defined by the cell array M
%  
% See also READMIX for the full M format 
% specification
% 
%
% Author: Fernando M. Silva
%         Instituto Superior T'ecnico
%         fcr@inesc.pt
%
 ng = m{1};
  
  th=m{ng+3};
  
  xr=rand;
  
  for k=1:ng,
    if(xr < th(k))
      ix = k;
      break;
    end
  end

  g = m{ix+2};
  dim = length(g{1});
	       
  x = randn(dim,1);
  
  y = g{2} * x + g{1};
  
  return;
  
		      



