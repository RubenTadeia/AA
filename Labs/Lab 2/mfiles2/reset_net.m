function nndata=reset_net(nndata)
  %net=netdefine(nndata)
  %given a neural network object, resets all the training variables 


  for i=1:length(nndata.layer) %for each layer
    layer=nndata.layer{i};
    
    if (i==1)    %find number of inputs to this layer
      ninputsthislayer=nndata.ninputs;
    else
      ninputsthislayer=nndata.layer{i-1}.nunits;
    end
    

    layer.outputactivation=zeros(layer.nunits,1);           % Reserve space for output activations
    layer.weight= 2 * nndata.train.weightrange * (rand(layer.nunits,ninputsthislayer+1) - .5);  % random weights, uniformly distributed 
    
    layer.eta = nndata.train.eta0*ones(size(layer.weight));         % initial step
    layer.gradient = zeros(size(layer.weight));    
    layer.gradientold = zeros(size(layer.weight));          % Set old gradient to zero
    layer.z = zeros(size(layer.weight));                    % Set the memory of the momentum terms to zero
    
    if isfield(layer, 'weightmin')            % Remove the 'weightmin' and 'weightvalmin' fields, if they exist
      layer = rmfield(layer, 'weightmin');
    end

    if isfield(layer, 'weightvalmin')
      layer = rmfield(layer, 'weightvalmin');
    end

    nndata.layer{i}=layer;
    
    
    nndata.train.epoch = 0;                  % current epoch
    nndata.train.falseepochs = 0;            % is this used later on, or not?
    nndata.train.costmin = Inf;              % minimum cost achieved till now in the training set
    nndata.train.cost = [];                  % clear training cost values
    nndata.train.valcostmin = Inf;           % minimum cost achieved till now in the validation set
    nndata.train.valcost = [];               % clear validation cost values
    
    
  end


