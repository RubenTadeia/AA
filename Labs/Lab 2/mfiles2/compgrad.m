function nndata = compgrad(nndata,trainpattern)

  for i = 1:length(nndata.layer)
    layer=nndata.layer{i};
    
    layer.gradientold = layer.gradient;
    
    if i == 1
      input=nndata.input;
    else
      input = nndata.layer{i-1}.outputactivation;
    end
    
    input(end+1,:)=1; %add ones
    
    layer.gradient = layer.backout * input';
      
    nndata.layer{i}=layer;
  end

