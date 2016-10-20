function gui_draw_input_layer(pos, params)
  %draws an input layer on screen  
  %if typ exists, additional information about data will be shown.
  
  x=pos(1);
  y=pos(2);
  width=pos(3);
  height=pos(4);
  
  patch([x x x+width x+width],[y y+height y+height y], 'c');
  text(x+width/4, y+height/9, 'input');
  
  
  if(nargin>1)
    text(x+2, y+height/2, params.typ, 'Interpreter','none');
    
    text(x+width/4, y+17*height/20, [num2str(params.ninputs) ':' num2str(params.noutputs)]);

  end
