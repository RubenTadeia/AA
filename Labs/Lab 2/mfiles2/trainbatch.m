function nndata = trainbatch (nndata, trainpattern, desiredoutput, validationpattern, validationdesiredoutput)
%
% [net,trainvars] = trainbatch (net,trainvars,trainpattern,desiredpattern)
%
% Train a net (MLP) in batch mode.
%
%   nndata          - Network to be trained with training parameters and variables.
%   trainpattern    - Training patterns (2-d array, one pattern per column).
%   desiredoutputs  - Desired outputs (2-d array, one pattern per column).

global NN_USER_STOP_TRAIN

for i = 1:nndata.train.nepochs
  if(NN_USER_STOP_TRAIN)        % The Stop button was clicked?
    break;
  end
  
  if nargin < 5                 % We have no validation data
    [nndata] = dobatchepoch(nndata, trainpattern, desiredoutput);
  else                          % We have validation data
    [nndata] = dobatchepoch(nndata, trainpattern, desiredoutput, validationpattern, validationdesiredoutput);
  end
  
  
  if(nndata.train.reporteveryepoch | mod(nndata.train.epoch,20) == 0 | i == nndata.train.nepochs | nndata.train.cost(end) <= nndata.train.desiredcost)
    
    report(nndata)              % Report the state of the training
    
    %       pause(0.01)            % This is to allow the system to display plots during the run (are there any plots to show? Use 'drawnow'?)
  end
  
  
  if nndata.train.cost(end) <= nndata.train.desiredcost     % Have we reached the desired cost? If so, we're done.
    break
  end
  
end



    
