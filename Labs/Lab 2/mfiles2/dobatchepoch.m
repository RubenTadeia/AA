function [nndata] = dobatchepoch(nndata, trainpattern, desiredoutput, valpattern, valdesiredoutput)

% Start by copying input arguments into output ones, because we want to
% keep all the input data when we exit the function.

if nndata.train.epoch == 0                            % In the first epoch we need to start with some extra processing
  
  [nndata] = forward(nndata, trainpattern);           % Propagate training pattern forward
  [nndata] = costcomp(nndata, desiredoutput);         % Compute cost function, and its derivatives for backpropagation
  [nndata] = back(nndata);                            % Propagate backward
  [nndata] = compgrad(nndata, trainpattern);          % Compute gradients
  [nndata] = checkcostmin(nndata);                    % Check whether we have a new minimum training cost, and store it if so
    
  if nargin >= 5                                      % See if we have validation data
    
    [nndata] = forward(nndata, valpattern);             % Propagate validation pattern forward
    [nndata] = costcomp(nndata, valdesiredoutput, 1);   % Compute validation cost; the last argument indicates that these are validation data
    
  end
    
    report(nndata)                                    % Report the initial performance
    
end


nndata.train.epoch=nndata.train.epoch + 1 ;

[nndata] = stepadapt(nndata);                         % Adapt step sizes; backtrack if necessary
[nndata] = weightadapt(nndata);                       % Adapt weights
[nndata] = forward(nndata, trainpattern);             % Propagate training pattern forward
[nndata] = costcomp(nndata, desiredoutput);           % Compute cost function, and its derivatives for backpropagation
[nndata] = back(nndata);                              % Propagate backward
[nndata] = compgrad(nndata, trainpattern);            % Compute gradients
  [nndata] = checkcostmin(nndata);                    % Check whether we have a new minimum training cost, and store it if so

if nargin >= 5                                        % See if we have validation data
  
  [nndata] = forward(nndata, valpattern);               % Propagate validation pattern forward
  [nndata] = costcomp(nndata, valdesiredoutput, 1);     % Compute validation cost; the last argument indicates that these are validation data
  
end




