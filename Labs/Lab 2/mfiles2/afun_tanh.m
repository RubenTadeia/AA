function result=afun_tanh(argument, typ)
  %tanh activation function
  
  switch typ
    case 'direct',
      result=tanh(argument);
    case 'deriv',
      result=1-tanh(argument).^2 + 1e-15;    % The 1e-15 term is to avoid rounding to 0
    case 'description',
      result='tanh';
    case 'graph',
      x=-1:.1:1;
      y=tanh(x*4);
      y=y/max(abs(y));
      result=[x;y];
  end
  
  
