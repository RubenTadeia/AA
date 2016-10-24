function varargout = bayes_gui(varargin)
% BAYES_GUI M-file for bayes_gui.fig
%      BAYES_GUI, by itself, creates a new BAYES_GUI or raises the existing
%      singleton*.
%
%      H = BAYES_GUI returns the handle to a new BAYES_GUI or the handle to
%      the existing singleton*.
%
%      BAYES_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BAYES_GUI.M with the given screen arguments.
%
%      BAYES_GUI('Property','Value',...) creates a new BAYES_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bayes_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bayes_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bayes_gui

% Last Modified by GUIDE v2.5 20-Oct-2004 21:58:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bayes_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @bayes_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before bayes_gui is made visible.
function bayes_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bayes_gui (see VARARGIN)


axes(handles.screen);
axis ij

bayes_data.ramp_output=[-1:.015:1];
bayes_data.class_prob{1}=gaussian(bayes_data.ramp_output, -.5,.15);
bayes_data.class_prob{2}=gaussian(bayes_data.ramp_output, 0,.075);
bayes_data.class_prob{3}=gaussian(bayes_data.ramp_output, .5,.25);

bayes_data.x_prob=(bayes_data.class_prob{1}+bayes_data.class_prob{2}+bayes_data.class_prob{3})/3;

nnin=load('bayes_saved_net'); %get default net from file.
bayes_data.nndata=nnin.NNDATA;
%propagate through network
bayes_data.nndata=forward(bayes_data.nndata,bayes_data.ramp_output);

draw_gui;


handles.bayes_data=bayes_data;
% Choose default command line output for bayes_gui
handles.output = hObject;



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bayes_gui wait for user response (see UIRESUME)
%uiwait(handles.bayes_gui);


% --- Outputs from this function are returned to the command line.
function varargout = bayes_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 0;

% --- Executes when user attempts to close bayes_gui.
function bayes_gui_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to bayes_gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on mouse press over axes background.
function screen_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to screen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function draw_gui(handles)

%this function is ugly (more independence of coordinates is needed)

%%%%%%%%%%%%%% RAMP %%%%%%%%%%%%%%%%%%%%%%%%%%
draw_box(10,40,25,25,'y','ramp','gui_element_ramp','[]');

%%%%%%%%%%%%% P(X|C) %%%%%%%%%%%%%%%%%%%%%%%%%
draw_box(60,10,25,25,'y','P(X|C=1)','gui_element_prob','1');
draw_box(60,40,25,25,'y','P(X|C=2)','gui_element_prob','2');
draw_box(60,70,25,25,'y','P(X|C=3)','gui_element_prob','3');

draw_line(35,52, 60,22,'k',2);
draw_line(35,52, 60,52,'k',2);
draw_line(35,52, 60,82,'k',2);

%%%%%%%%%%%%% Plus P(x) %%%%%%%%%%%%%%%%%%%%%%%%%
draw_box(110,50,6,6,'y','+','gui_element_plus','[]');

draw_line(85,22,110,53,'k',2);
draw_line(85,52,110,53,'k',2);
draw_line(85,82,110,53,'k',2);


%%%%%%%%%%%% Times P(X,C) %%%%%%%%%%%%%%%%%%%%%%
draw_box(160,20,6,6,'y','x','gui_element_times','1');
draw_box(160,50,6,6,'y','x','gui_element_times','2');
draw_box(160,80,6,6,'y','x','gui_element_times','3');

draw_line(116,53,160,23,'k',2);  %lines from plus to times
draw_line(116,53,160,53,'k',2);
draw_line(116,53,160,83,'k',2);

draw_line(95,115,160,23,'b',2);  %lines from NN to times
draw_line(95,125,160,53,'b',2);  
draw_line(95,135,160,83,'b',2);  


%%%%%%%%%%% Neural net %%%%%%%%%%%%%%%%%%%%%%%%%
draw_box(55,110,40,30,'y','NN','gui_element_neural_net','[]');

draw_line(35,52,55,125,'b',2);  


function handle=draw_line(x1,y1,x2,y2,color,width)
hold on
handle=plot([x1 x2],[y1,y2],color);
set(handle,'LineWidth',width);
hold off

function handle=draw_box(x,y,w,h,color,txt,click_function,args)
handle=patch([x x x+w x+w], [y y+h y+h y], color);

if(nargin>6)
  h=text(x+2, y+3, txt);
  set(h,'HitTest','off');
end

if(nargin>7)
  fcn=['bayes_gui(' char(39) click_function char(39) ', gcbo, [], guidata(gcbo),' args ')'];
  set(handle, 'ButtonDownFcn',fcn);
end


function y=gaussian(x, mean, sigma)
y=1/(sqrt(2*pi)*sigma)*exp( -(x-repmat(mean,size(x,1), size(x,2))).^2/(2*sigma^2));


function button=last_button_pressed;
persistent LAST_BUTTON_CLICK 

if(isempty('LAST_BUTTON_CLICK')) %the first time around need to initialize
                                 %the variable
    LAST_BUTTON_CLICK=0;
end

%get button pressed
b=get(gcf,'SelectionType');
switch b          %decode the button press
    case 'open'
        button=LAST_BUTTON_CLICK;
    case 'normal'
        button=1;
    case 'extend'
        button=2;
    case 'alt'
        button=3;
end
LAST_BUTTON_CLICK=button;


function gui_element_ramp(hObject,eventdata,handles,args);
figure; 
plot(handles.bayes_data.ramp_output);
xlabel('sample');
ylabel('output value');
title('Ramp element output');

function gui_element_prob(hObject,eventdata,handles,args);
figure; 
plot(handles.bayes_data.ramp_output,handles.bayes_data.class_prob{args});
xlabel('sample value');
ylabel('probability');
title(['Sample probability given a class P(x|C=' num2str(args) ')']);

function gui_element_plus(hObject,eventdata,handles,args);
figure; 
plot(handles.bayes_data.ramp_output,handles.bayes_data.x_prob);
xlabel('sample value');
ylabel('probability');
title('Sample probability P(x)');


function gui_element_times(hObject,eventdata,handles,args);
%this is the only one computed locally (since neural network can change at
%any time) 
figure; 
plot(handles.bayes_data.ramp_output,handles.bayes_data.x_prob.*handles.bayes_data.nndata.layer{end}.outputactivation(args,:));
xlabel('sample value');
ylabel('probability');
title(['Joint probability density P(x,C=' num2str(args) ')']);



function gui_element_neural_net(hObject,eventdata,handles,args);

global NNDATA

button=last_button_pressed;
if(button==3)
  set(handles.bayes_gui,'Visible','off');
  try %just in case something goes wrong, we can still see the gui.
    neural_handle=neural_gui(handles.bayes_data.nndata);
    uiwait(neural_handle);
    handles.bayes_data.nndata=NNDATA; %save it for future reference.
    try
      handles.bayes_data.nndata=forward(handles.bayes_data.nndata,handles.bayes_data.ramp_output);
    catch
      errordlg('Invalid network topology');
    end
    guidata(handles.bayes_gui, handles);    
  catch 
    errordlg('Could not call neural_gui');
  end
  set(handles.bayes_gui,'Visible','on');
end

if(button==1)
figure; 
plot(handles.bayes_data.ramp_output,handles.bayes_data.nndata.layer{end}.outputactivation);
xlabel('sample');
ylabel('probability');
title('Class probability given a sample P(C|x)');  
end





