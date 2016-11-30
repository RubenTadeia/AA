function drawscr(s,mix);
% DRAWSCR(S,MIX) bidimension plot of mixture distributions
%
% This function draws a scatter plot of the bidemensional data 
% data in matrix s as well as elyptical lines representing the 
% covariance of the gaussians in the mixture MIX.
%
% The plot does not differs the prior probability of each class. 
% 
% See also: DRAWSCR
%
% Author: Fernando M. Silva
%         Instituto Superior Técnico
%         fcr@inesc.pt
%

  global np circle circleT;
  global xmin xmax ymin ymax;
  
  if(~exist('hScatter')),
    global hScatter;
    hScatter=9;
    np = 60;
    dt = 2 * pi / (np-1);
    for k=1:np,
      t = (k-1) * dt;
      circle(1,k) = cos(t);
      circle(2,k) = sin(t);            
    end
  end
  figure(hScatter);
  plot(s(2,:),s(1,:),'g*','markersize',2);
  axis([xmin xmax ymin ymax]);
  hold on;

  ng = mix{1};
  p  = mix{2};
  for k=1:ng, 
    g = mix{k+2};
    rxx = g{3};
    [v,d] = eig(rxx);
    mean = g{1};
    circleT = v * sqrt(d) * circle;
    circleT(1,:) = circleT(1,:) + mean(1);
    circleT(2,:) = circleT(2,:) + mean(2);    
%    if(p(k) > 1.0/ng/3),      
      plot(circleT(2,:),circleT(1,:),'r-');    
%    else
%      plot(circleT(2,:),circleT(1,:),'y-');    
%    end
  end

  hold off;
  drawnow;
  return

  
  
		      



