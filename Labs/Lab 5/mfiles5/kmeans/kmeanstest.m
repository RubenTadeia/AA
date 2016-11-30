%
%
% Program for test of K-means algorithm
%
% Run example:
%
% clear; ifile = 'mix1.txt' ; ns = 2000 ; nc = 2; kmeanstest 
%
% ifile   Input mixture distribution (default: mix.txt)
% ns      Number of synthetic data points to be generated 
% nc      Number of centers to be used in clustering
%  
% The variable 'draw' controls the drawing of graphics. Set draw=1 to enable the drawing of graphics, and draw=0 to disable it.



if(~exist('ns')),
  fprintf(1,'Error: ns (number of samples) not defined\n');
  fprintf(1,'Type "help kmeanstest"\n');
  return
end
if(~exist('nc')),
  fprintf(1,'Error: nc (number of centers) not defined\n');
  fprintf(1,'Type "help kmeanstest"\n');
  return
end
if(~exist('ifile')),
  ifile = 'mix.txt'
end

%
fprintf(1,'Number of samples = %d, number of centers = %d\n',ns,nc);
%
% Read mixture description file
%
m = readmix(ifile);
%
% How many dimensions this file refers to
%
ndim=length(m{3}{1});

%
% Generate samples according to distribution
%
clear s
s(1:ndim,1:ns) = 0;
for k=1:ns,
  s(:,k) = gen(m);
end;

%
% Yes, we want to draw it
%
draw = 1;
%
% Compute class and centers
%
[classErr,class,center,nums]= kmeans(s,nc,draw);













