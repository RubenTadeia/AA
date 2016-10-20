function result = costfun_slope(output, desired, typ)

persistent slope

switch typ
  case 'direct',
    error = output - desired;
    result = sum(sum(comp_slope(error,-slope.nslope,slope.pslope))) / (size(error,1)*size(error,2));
  case 'feedback',
    error = output - desired;
    result = (-slope.nslope * (error<0) + slope.pslope * (error>0)) / (size(error,1) * size(error,2));
  case 'configure',
    slope = gui_configure_costfun_slope(slope);
    result=slope;
  case 'description',
    result = 'dual slope';
  case 'graph',
    x = -1:.1:1;
    y = comp_slope(x,-slope.nslope,slope.pslope);
    
    y = y/max(max(y));
    
    result = [x;y];
end

function y = comp_slope(x,nslope,pslope)
y = nslope*x.*(x<0)+pslope*x.*(x>0);


