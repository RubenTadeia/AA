%
% Program for testing the EM algorithm with 
% synthetic data. Data is generated according 
% to the mixture specified in one user specified
% file.
%  
% Before calling this program, set the following variables:
% 1. ns  - The total number of synthetic data patterns to be generated.
% 2. ng  - The number of Gaussians to be used in the Gaussian mixture.
% 3. nit - The maximum number of iterations
%             (nit=0 runs until the log-likelihood increases by less that 1E-4;
%              nit=-1 runs until the log-likelihood stops increasing).
%
% Run example:
%
% clear; ns = 5000; ng = 10; nit = 0 ; tstem  
%
% The initial mixture for generating synthetic data is read, by default, 
% from file 'mix.txt'. However, a different file can be used by setting 
% the variable 'ifile':
%
% clear; ns = 5000; ng = 3; nit = 0 ; ifile='my_mix.txt'; tstem  
%
% The program writes the parameters of the estimated mixture in the file 'est.txt'.
%  
% The variable 'draw' controls the drawing of graphics. Set draw=1 to enable the drawing of graphics, and draw=0 to disable it.
%
% See: EMEST,READMIX,EM,SAVEMIX,GEN
% 
% Author: Fernando M. Silva
%         Instituto Superior T'ecnico
%         fcr@inesc.pt
%
global xmin xmax ymin ymax;

if(~exist('ns')),
  fprintf(1,'Error: ns (number of samples) not defined\n');
  fprintf(1,'Type "help tstem"\n');
  return
end
if(~exist('ng')),
  fprintf(1,'Error: ng (number of gaussians) not defined\n');
  fprintf(1,'Type "help tstem"\n');
  return
end
if(~exist('nit')),
  fprintf(1,'Error: nit (number of iterations) not defined\n');
  fprintf(1,'Type "help tstem"\n');
  return
end




%
% Limits for graphics; only needed in em if draw equals 1
%
xmax=5;xmin=-xmax;ymin=xmin;ymax=xmax;

%
% Read generation mixture 
%
% Input format 0 - Generation matrix, 1 - covariance matrix
%
informat = 1;
if (exist('ifile')),
  m = readmix(ifile,informat);
else
  m = readmix('mix.txt',informat);
end
dim = length(m{3}{2});
%
% Save synthetic mixture (in covariance format, for later analysis)
%
savemix(m,'genmix.txt',1);
%
% Generate synthetic samples
%
clear s
s(1:dim,1:ns) = 0; 
for k=1:ns,
  s(:,k) = gen(m);
end;

%
% Run EM on s data set with ng Gaussians.
% Set draw=1 by default.
%
if(~exist('draw')),
  draw = 1;
end
est=em(s,ng,nit,draw,m);
%
% Save result 
%
savemix(est,'est.txt',1);











