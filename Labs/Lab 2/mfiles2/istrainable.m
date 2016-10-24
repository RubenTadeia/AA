function result=istrainable(nndata)
  %verifies if all activation functions are diferentiable
  
  result=1;
  
  for i=1:length(nndata.layer)
    layer=nndata.layer{i};
    
    if(isempty(call_afun(layer.afun,0,'deriv')))
      result=0;
      return;
    end
  end
