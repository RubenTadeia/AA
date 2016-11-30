%
% Program for testing the EM algorithm with 
% data read from a data file.
% 
% Before calling this program, set the following variables:
% 1. ng  - The number of Gaussians to be used.
% 2. nit - The maximum number of iterations
%             (nit=0 runs until the log-likelihood increases by less that 1E-4;
%              nit=-1 runs until the log-likelihood stops increasing).
%
% Run example:
%
% clear; ng = 2; nit = -1 ; emest  
%
% The initial data are read, by default, from the file 'data.txt'. However, a 
% different file can be used setting the variable 'ifile':
%  
% clear; ng = 2; nit = -1 ; ifile='mydata.txt'; emest  
%
% The program writes the parameters of the estimated mixture in the file 'est.txt'.
%  
% The variable 'draw' controls the drawing of graphics. Set draw=1 to enable the drawing of graphics, and draw=0 to disable it.
%
% See: TSTEM,READMIX,EM,SAVEMIX,GEN
% 
% Author: Fernando M. Silva
%         Instituto Superior Técnico
%         fcr@inesc.pt
%
global xmin xmax ymin ymax;

if(~exist('ng')),
  fprintf(1,'Error: ng (number of gaussians) not defined\n');
  fprintf(1,'Type "help emest"\n');
  return
end
if(~exist('nit')),
  fprintf(1,'Error: nit (number of iterations) not defined\n');
  fprintf(1,'Type "help emest"\n');
  return
end




%
% Limits for graphics; only needed in em if draw equals 1
%
xmax=5;xmin=-xmax;ymin=xmin;ymax=xmax;

%
% Read data
%
if (exist('ifile')),
  load(ifile);
  ic=1;
  while((ifile(ic) ~= '.') & (ic <= length(ifile))),
    clear sfile;
    sname(ic) = ifile(ic);
    ic = ic+1;
  end
  s = eval(sname);
else
  load 'data.txt';
  s = data;
end

[ndim,ns] = size(s);

%
% Run EM on s data set with ng gaussians.
% Draw on
%
if(~exist('draw')),
  draw = 1;
end
est=em(s,ng,nit,draw);
%
% Save result 
%
savemix(est,'est.txt',1);























