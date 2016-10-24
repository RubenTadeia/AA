function cost = test_cost(nndata, input, desired_output)
%
% Returns the value of the cost function for a given set of input patterns and desired outputs
  
  if numel(nndata.train.cost) > 0
    storedcost = nndata.train.cost(end);    % Keep value, to put back in place at the end of this function
  end
  
  nndata = forward(nndata, input);
  nndata = costcomp(nndata, desired_output);
  
  cost = nndata.train.cost(end);
  
  if exist('storedcost', 'var')
    nndata.train.cost(end) = storedcost;    % Put the correct value back in place...
  else
    nndata.train.cost = [];                 % ...or remove it if it didn't exist upon entry into this function
  end
  
  
