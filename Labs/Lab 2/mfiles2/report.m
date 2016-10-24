function report(nndata)
%
% report(nndata)
%
% This function is called by 'trainbatch', 'dobatchepoch' and 'neural_gui' to output data about the training process.
% 
% This function is not intended to be called by the user.
%
% This function may be edited to suit the user's needs regarding the contents and format of the output during training.

if nndata.train.epoch == 0      % Is this the initial state? If so, the report is somewhat different
    fprintf(1,'\ninitial state,  training cost = %11.8f', nndata.train.cost(1))
else
    fprintf(1,'epoch %7d,  training cost = %11.8f,  improvement = %11.8f', nndata.train.epoch, nndata.train.cost(end), nndata.train.costminprev - nndata.train.cost(end))
end

if ~isempty(nndata.gui.input.validation)      % See if we have validation data
  if nndata.train.epoch == 0                % Is this the initial state? If so, the report is somewhat different
    fprintf(1,',                              validation cost = %11.8f', nndata.train.valcost(1))
  else
    fprintf(1,',  validation cost = %11.8f,  excess = %11.8f', nndata.train.valcost(end), nndata.train.valcost(end) - nndata.train.valcostmin)
  end
end

fprintf(1,'\n')                 % Terminate the output line
  
return
