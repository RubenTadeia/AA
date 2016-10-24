function net=netdefine(ninputs,nunits)
% net=netdefine(ninputs,noutputs,nhidde.layer, nunits)
% 
% Creates a default MLP with a given number of inputs and outputs. 
% nunits is an array containing how many units each layer has. 
%
% each layer's activation function is defined as tanh by default.
%
% The default configuration is a 2 layer network (no hidden layer) with two inputs and 1 output.


if(nargin<1)
  ninputs=2;
end
if(nargin<2)
  nunits=1;
end

net.ninputs=ninputs;

for i=1:length(nunits)
  if (i==1)    %number of inputs to this layer
    ninputsthislayer=ninputs;
  else
    ninputsthislayer=nunits(i-1);
  end
  
  layer.nunits=nunits(i); %number of units of this layer
  layer.afun='tanh';      %tanh activation functions
  
  %next ones are only placeholders until network is reset.
  
  layer.outputactivation=zeros(nunits(i),1);           %all units output 0
  layer.weight=zeros(nunits(i),ninputsthislayer+1); %weights initilized to 0.
  
  layer.eta = zeros(size(layer.weight));         %initial step
  layer.gradient = zeros(size(layer.weight));    
  layer.gradientold = zeros(size(layer.weight));
  layer.z = zeros(size(layer.weight));
  
  net.layer{i}=layer;
end


