function gui_draw_synapse(pos)
  %draws synapses. pos=[x y width height]
  
  x1=pos(1);
  y1=pos(2);
  x2=pos(1)+pos(3);
  y2=pos(2)+pos(4);
  
  points_x=[x1, x2;
            x1, x2;
            x1, x2;
            x1, x2]';
            
  points_y=[y1, y1;
            y1, y2;
            y2, y1;
            y2, y2]';
  hold on          
  plot(points_x, points_y,'k'); %plot the synapses
  hold off
  
