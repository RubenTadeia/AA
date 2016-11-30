function m = em(s,ng,nit,draw,mref)
%
%  M=EM(S,NG,NIT,DRAW,MREF) tries to fit the data samples in S with a
%  mixture of NG Gaussians using the EM algorithm.
%
%  Each column of S represents one data pattern.
%
%  NIT is the maximum number of iterations of the EM algorithm. Every
%  10 iterations, the estimated mixture is written to file ' tmp.txt'.
%  With NIT=-1, the algorithm runs until the log-likelihood stops increasing.  
%  
%  MREF is an optional reference mixture to which the estimated 
%  mixture is to be compared (this is usually used with synthetic 
%  data to assess the algorithm behavior). 
% 
%  DRAW is a boolean flag used to control the display of pdf graphics
%  (only used with bidimensional distributions)
%
%  See also: GAUSS,DRAWSCR
%
% Author: Fernando M. Silva
%         Instituto Superior Técnico
%         fcr@inesc.pt
%
  global xmin xmax ymin ymax;
  [dim,ns] = size(s);
  
  ref = (nargin == 5);
  
  draw = draw & (dim == 2);

%
% Compute the log-likelihood of the generating distribution
%
  if(ref),
	  lkGen = sum(log(mixdis(s,mref)));
  	  fprintf(1,'Generating distribution''s log-likelihood: %f\n',lkGen);
  end
  if(draw),
%
% Initialize graphic data, mesh plan, etc.
%
    npx=50;
    npy=50;
    dx=(xmax-xmin)/(npx-1);    
    dy=(ymax-ymin)/(npy-1);    
    xg=[xmin:dx:xmax]';
    yg=[ymin:dy:ymax]';
    
    xmesh(2,npx*npy)=0;
    for ky=1:npy,
      for kx=1:npx,
			xmesh(1,(ky-1)*npx+kx) = xg(kx);
			xmesh(2,(ky-1)*npx+kx) = yg(ky);
      end
   end
   if(ref),
% Draw generating distribution
	 zp = mixdis(xmesh,mref);
    z  = reshape(zp,npx,npy);
    figure(1);
    mesh(xg,yg,z);
    title('Generating distribution');
  end  
% % Draw histogram     
%   h(npx,npy) = 0;
%   h = h * 0;
% 
%   for k=1:ns,
%       xp=s(1,k);
%       yp=s(2,k);
%       ix = floor((xp - xmin)/dx + 1);
%       iy = floor((yp - ymin)/dy + 1);
%       if((ix > 0) & (ix <= npx) & (iy > 0) & (iy <= npy)),
% 		h(ix,iy) = h(ix,iy) + 1;  
%     end
%   end;
%   figure(2);
%   mesh(xg,yg,h/(dx*dy*ns));
%   title('Histogram');   
end
%
% 
%

%
% Data initialization
%

%
% Each savePer iterations we write the estimated mixture to file 'tmp.txt'.
%
  savePer  = Inf;        % Use Inf in order never to write to the temp file
  perCount = 0;


%  
% Compute global covariance matrix
%  
  rxx = 0;
  for k=1:ns,
    x = s(:,k);
    rxx = rxx + x * x';
  end
  rxx  = rxx / ns;
  rxx1 = inv(rxx);
  drxx = det(rxx);
  
%
% Initialize centers by randomly selecting
% ng samples and using them as first covariance 
% estimate the global covariance matrix.
%
  mix{1} = ng;
  p = [1:ng]'*0+1.0/ng;
  mix{2} = p;
  for k=1:ng,
    ix = floor(rand * ns + 1);
    m = s(:,ix);
    c = {m,eye(dim),rxx,rxx1,drxx};
    mix{k+2} = c;
  end

%
% Save the initial mixture for later analysis.
% Usually, not needed.
%
  savemix(mix,'init.txt',0);

%
% Initialize dimensions for sake of speed
%
  gFdp(ns,ng) = 0;
%   Fdp(ns)     = 0;
  stay = 1;				% Flag which indicates whether to continue with the iterations

  lkLast = -Inf;		% Initialization of last iteration's log-likelihood
  itCount = 0;
  while(stay),
    %
    %  Start of iteration
    %
    p = mix{2};

%
% Compute the fdp and likelihood of training set
% for current mixture
% 
%    
   for k=1:ng,
      gFdp(:,k) = gauss(s,mix{k+2})';
   end
   Fdp = gFdp * p;
   lkHood = sum(log(Fdp));
   
   if(ref),
    	fprintf(1,'Iteration = %d log-lk. = %g   Gen.log-lk. = %g\n',itCount,lkHood,lkGen);
    else
      fprintf(1,'Iteration = %d log-lk. = %g\n',itCount,lkHood);
    end;
   
%
% Compute posteriors
%    
    h = 1 ./ Fdp * p';
    h = h .* gFdp;    
	 hsum = sum(h);
    
    new = mix;

%
% Recompute means and covariances
%
    for j=1:ng,
      
      mean = s * h(:,j) / hsum(j);
      
      for kx=1:dim,
      	for ky=1:dim,
	 			a = (s(kx,:)-mean(kx));
	  			b = (s(ky,:)-mean(ky));	  
	  			rxx(kx,ky) = sum(a.*b.*h(:,j)');
			end
      end
      
      rxx = rxx / hsum(j);    
      new{j+2}{1} = mean;
      new{j+2}{3} = rxx;    
    end
    
%
% Re-estimate weights
%
	 p = (sum(h)/ns)';
    new{2} = p;
    for j=1:ng,
      new{j+2}{2} = eye(dim);
      new{j+2}{4} = inv(new{j+2}{3});
      new{j+2}{5} = det(new{j+2}{3});
    end

%
% Check the weights. They must add up to 1.
%
    
    th(1)=p(1);
    for k=2:ng,
      th(k) = th(k-1) + p(k);
    end;
    if(abs(th(ng) - 1) > 1e-6),
      fprintf(1,'Error in weights: weights add up to %f (should be 1)',th);
      error('Error found in em');
    end
    new{ng+3} = th;
%
%
    mix = new;
    
    if(draw),
      zp = mixdis(xmesh,mix);
      z  = reshape(zp,npx,npy);

      figure(3);
      mesh(xg,yg,z);zlim([0 0.2]);
      title('Estimated distribution');
      %      view(-37.5,80);
      if(ref),
      	drawscr(s,mix,mref);
         title(sprintf('Generating (blue) and estimated (red) distributions\nThe ellipses are at one standard deviation from the means'));
      else
         drawsc(s,mix);
         title(sprintf('Training data and estimated distribution\nThe ellipses are at one standard deviation from the means'));
      end;	
      drawnow;
    end
    
    perCount=perCount+1;
    if(perCount == savePer),
      perCount=0;
      savemix(mix,'tmp.txt',1);
    end

    if(nit < 0),
      stay = lkHood > lkLast;			% Proceed if the likelihood has increased
    else 
      if(nit == 0),
	stay = (lkHood - lkLast) > 1e-4;	% Proceed if the likelihood has increased more than 1E-4
      else
	stay = itCount < nit;
      end
    end
    lkLast = lkHood;
    itCount = itCount+1;

  end
  m = mix;
  return;
