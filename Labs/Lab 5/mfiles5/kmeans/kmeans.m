function [classErr,class,center,nums]= kmeans(s,nc,draw)
% [classErr,class,center,nums]= kmeans(s,nc,draw) performs a k-means 
% clustering of the samples in S using NC classes. 
%
%  s  -  Sample matrix (samples by column)
%  nc -  Number of centers 
%  draw - DRAW flag. if DRAW=1 and the data are bidimensional, plot
%  data and centers in each step.
%
%  KMEANS returns:
%
%  classErr NC-dimension vector with the mean square error
%           in each class. The total squared error can be
%           computed by sum(CLASSERR);
%  class    The class for each sample in S
%  center   The mean within the class  
%  nums     The number of samples in each class     
%
% Author: Fernando M. Silva
%         Instituto Superior T'ecnico
%         fcr@inesc.pt
%
[dim,ns] = size(s);

%
% needed for graphics
%
colors = '.g.m.y.c.r.b.g.m.y.c.r.b';

%
% Initialize centers;
%
center(1:dim,1:nc) = 0;
fl(1:ns) = 0;
for k=1:nc,
    ix = floor(rand * ns + 1);
    while(fl(ix)),
        ix = floor(rand * ns + 1);    
    end
    fl(ix) = 1;
    center(:,k) = s(:,ix);
end

repeat = 0;
%
% Generate reference as "last distribution"
%
[classErr,class,nums] = nearest(s,center);
totalErr = sum(classErr)/ns;
it = 0;
while(repeat ~= 2),
    
    it = it + 1;
    %  
    % Draw current distribution
    %
    if((dim == 2) & draw),
        clf;
        hold on;
        for i=1:ns,
            for k=1:nc,
                if(class(i)==k),
                    colorindex = mod(2*k-1,12);
                    plot(s(1,i),s(2,i),colors((colorindex:colorindex+1)));
                end
            end
        end
        plot(center(1,1:nc),center(2,1:nc),'k.','markersize',25);
        drawnow;
    end    
    lastErr = totalErr;
    [center,var] = compmean(s,class);
    [classErr,class,nums] = nearest(s,center);    
    totalErr = sum(classErr)/ns;    
    fprintf(1,'Iteration %d,  Mean sq. error = %.10f\n',it,totalErr);
    if(totalErr == lastErr),
        repeat = repeat + 1;
    else
        repeat = 0;
    end
end
















