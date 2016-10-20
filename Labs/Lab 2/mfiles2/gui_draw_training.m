function gui_draw_training(pos,params)
  %draws a training layer on screen

  x=pos(1);
  y=pos(2);
  width=pos(3);
  height=pos(4);
  
  patch([x x x+width x+width],[y y+height y+height y], 'g');
  text(x+width/7, y+height/9, 'training');
  
  result=call_costfun(params.typ, [], [], 'graph');
  description=call_costfun(params.typ, [], [], 'description');
  
  s=result(1,:);
  t=result(2,:);
  
  s=width/4*s;
  t=-height/8*t;
  
  hold on
  
  plot(s+x+width/2,t+y+height/2+1.5,'r');
  description = sprintf(strrep(description, ' ', '\n'));	% Replace blanks with newlines
  text(x+5,y+16/20*height,description); 
  
  hold off
