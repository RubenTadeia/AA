function result=afun_lin(argument, typ)
  %linear activation function
  
  switch typ
    case 'direct',
      result=argument;
    case 'deriv',
      result=ones(size(argument));
    case 'description',
      result='linear';
    case 'graph',
      x=-1:.1:1;
      y=x;
      result=[x;y];
  end
  
  
