function nndata = checkcostmin(nndata)
%
% Check whether we have reached a new minimum of the training cost

nndata.train.costminprev = nndata.train.costmin;      % Record the minimum at the previous epoch, which is still needed in the 'report' function
  
  if nndata.train.cost(end) <= nndata.train.costmin
        
    %   Record new cost minimum, together with the corresponding training state
    
    nndata.train.costmin = nndata.train.cost(end);
    for i = 1:length(nndata.layer)
      nndata.layer{i}.weightmin = nndata.layer{i}.weight;
      nndata.layer{i}.gradientmin = nndata.layer{i}.gradient;
      nndata.layer{i}.etamin = nndata.layer{i}.eta;
    end
  end
return




