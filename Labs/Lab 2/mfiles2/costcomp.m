function nndata = costcomp(nndata, desiredoutput, valflag)

if nargin < 3
  valflag = false;
end

% neterror = nndata.layer{end}.outputactivation - desiredoutput;
cost = call_costfun(nndata.train.costfun, nndata.layer{end}.outputactivation, desiredoutput, 'direct');

if valflag            % This is a validation cost: record cost; also record minimum cost and corresponding weights if it's a new cost minimum
  
  nndata.train.valcost(nndata.train.epoch+1) = cost;            % Record validation cost. We use epoch+1 because array indexes start at 1
  if cost < nndata.train.valcostmin                             % Is it a minimum? 
    nndata.train.valcostmin = cost;                               % Yes - Record the minimum cost...
    for i = 1:length(nndata.layer)
      nndata.layer{i}.weightvalmin = nndata.layer{i}.weight;      % ...and the corresponding weights
    end
  end
  
else                  % This is a training cost: record cost and compute derivatives to backpropagate
  
  nndata.train.cost(nndata.train.epoch+1) = cost;               % Record training cost. We use epoch+1 because array indexes start at 1
  nndata.layer{end}.backin = call_costfun(nndata.train.costfun, nndata.layer{end}.outputactivation, desiredoutput, 'feedback');    % Compute derivatives

end
return



