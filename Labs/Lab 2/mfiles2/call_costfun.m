function result = call_costfun(costfun_name, output, desired, typ)
  
  name = strcat('costfun_', costfun_name); 
  
  result = feval(name, output, desired, typ);
  
  
  
