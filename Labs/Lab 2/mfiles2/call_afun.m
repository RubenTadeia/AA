function result=call_afun(afun_name, argument, typ)
  % given an activation function name, calls the function with the argument. 
  % for what typ can be, check any of the activation functions (for example afun_lin.m)
  
  name=strcat('afun_',afun_name);
  
  result=feval(name,argument,typ);
  
  
