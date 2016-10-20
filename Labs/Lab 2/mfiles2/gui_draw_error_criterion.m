function gui_draw_layer(pos)
  %draws a neuron layer on screen

  x=pos(1);
  y=pos(2);
  width=pos(3);
  height=pos(4);
  
  patch([x x x+width x+width],[y y+height y+height y], 'c');
  hold on
  line=plot([x-width/2 x],(y+height/2)*[1 1],'k');
  hold off
  set(line,'LineWidth',4);
  text(x+width/4, y+height/9, 'error');
  
