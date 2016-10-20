function result=afun_sigmoid(argument, typ)
  %sigmoid activation function
  
  switch typ
    case 'direct',
      result=1./(1+exp(-argument));
    case 'deriv',
      %the following trick is to avoid inf/inf.
      %if the argument<-700, saturate it (because exp(710)=inf :)
      argument(find(argument<-700))=-700;
      ex=exp(-argument);      
      result=ex./(1+ex).^2 +1e-6;    % The 1e-6 term is to avoid rounding to 0
    case 'description',
      result='sigmoid';
    case 'graph',
      x=-1:.1:1;
      y=1./(1+exp(-7*x));
      y=y/max(abs(y));
      result=[x;y];
  end
  
  
