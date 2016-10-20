function result=costfun_mse(output, desired, typ)

switch typ
  case 'direct',
    error = output - desired;
    result = sum(sum(error.^2)) / (size(error,1) * size(error,2));
  case 'feedback',
    error = output - desired;
    result=2 * error / (size(error,1) * size(error,2));
  case 'configure',
    %This cost function does not have options. This part is to be used by configurable error criteria.
    %For example, using the dual slope cost function needs to select slopes.
    result = [];
  case 'description',
    result = 'squared error';
  case 'graph',
    x = -1:.1:1;
    y = x.^2;
    result = [x;y];
end

