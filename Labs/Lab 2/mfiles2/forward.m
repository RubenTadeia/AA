function [nndata] = forward(nndata,trainpattern, typ)
  %given a neural network object and input data, propagate it through the network
  
  ntrain = size(trainpattern,2);
  
  nndata.input=trainpattern;

  for i = 1:length(nndata.layer) %for each layer
    layer=nndata.layer{i};
    
    if i == 1  %first layer?
      layer_input=trainpattern;
    else
      layer_input=nndata.layer{i-1}.outputactivation;
    end
    
    layer_input(end+1,:)=1; %create bias inputs.
    
    layer.inputactivation = layer.weight * layer_input;
    
    layer.outputactivation=call_afun(layer.afun, layer.inputactivation,'direct');
    
    nndata.layer{i}=layer;
  end
