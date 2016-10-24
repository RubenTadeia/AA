function result=afun_lin(argument, typ)
  %linear activation function
  
  switch typ
    case 'direct',
      result=sign(argument);
    case 'deriv',
      result=[];
    case 'description',
      result='sign';
    case 'graph',
      x=-1:.1:1;
      y=sign(x);
      result=[x;y];
  end
  
  
