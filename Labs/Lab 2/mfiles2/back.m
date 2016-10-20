function nndata = back(nndata)

  for i = length(nndata.layer):-1:1
    layer=nndata.layer{i};
    
    derivative = call_afun(layer.afun,layer.inputactivation,'deriv');
    
    if(isempty(derivative))
        error('Can''t compute derivative of activation function')
        return
    end

    layer.backout = layer.backin(1:layer.nunits,:) .* derivative;

    if i ~= 1
      nndata.layer{i-1}.backin = layer.weight' * layer.backout;
    end
    
    nndata.layer{i}=layer;
  end

