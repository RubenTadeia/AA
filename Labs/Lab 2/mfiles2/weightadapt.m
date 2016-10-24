function nndata = weightadapt(nndata)

  for i = 1:length(nndata.layer)
    layer=nndata.layer{i};
    layer.z = layer.gradient + nndata.train.alpha * layer.z;
    layer.weight = layer.weight - layer.eta .* layer.z;
    
    nndata.layer{i}=layer;
  end

    
