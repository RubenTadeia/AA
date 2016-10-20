function nndata=create_net(ninputs, nunits)
  %creates a complete neural network object.
  %
  %it calls netdefine, traindefine and resets the network.
  
  if(nargin<1)
    ninputs=2;
  end
  if(nargin<2)
    nunits=1;
  end
  
  %create default structure
  nndata=netdefine(ninputs,nunits);
  nndata.train=traindefine;
    
  %reset it
  nndata=reset_net(nndata);
  
