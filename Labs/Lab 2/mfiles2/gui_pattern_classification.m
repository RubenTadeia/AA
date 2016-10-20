function varargout = gui_pattern_classification(varargin)
% GUI_PATTERN_CLASSIFICATION M-file for gui_pattern_classification.fig
%      GUI_PATTERN_CLASSIFICATION, by itself, creates a new GUI_PATTERN_CLASSIFICATION or raises the existing
%      singleton*.
%
%      H = GUI_PATTERN_CLASSIFICATION returns the handle to a new GUI_PATTERN_CLASSIFICATION or the handle to
%      the existing singleton*.
%
%      GUI_PATTERN_CLASSIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PATTERN_CLASSIFICATION.M with the given input arguments.
%
%      GUI_PATTERN_CLASSIFICATION('Property','Value',...) creates a new GUI_PATTERN_CLASSIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_pattern_classification_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_pattern_classification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_pattern_classification

% Last Modified by GUIDE v2.5 29-Sep-2015 20:11:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_pattern_classification_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_pattern_classification_OutputFcn, ...
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


% --- Executes just before gui_pattern_classification is made visible.
function gui_pattern_classification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_pattern_classification (see VARARGIN)


axes(handles.screen);

if nargin<4
  errordlg('A trained Neural Network object must be supplied','Error','modal');
  return
  %  close(handles.pattern_classification);
end

handles.nndata=varargin{1}; %save the neural network object

set(handles.input,'String',handles.nndata.gui.input.training);

input=normalize(gui_interpret_input(get(handles.input,'String')), handles.nndata.gui.input.normalize);

if(~isempty(input) & size(input,1)==35)
  handles.input=input;
  handles.current=1;
  
  handles.max_input=max(max(input));
  handles.min_input=min(min(input));

  show_pattern(handles); %show first object.
else
  errordlg('Please choose input data','Error','modal');
  handles.input=[];
end


% Choose default command line output for gui_pattern_classification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_pattern_classification wait for user response (see UIRESUME)
uiwait(handles.pattern_classification);


% --- Outputs from this function are returned to the command line.
function varargout = gui_pattern_classification_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 0;
delete(hObject);

% --- Executes during object creation, after setting all properties.
function input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input as text
%        str2double(get(hObject,'String')) returns contents of input as a double


input=normalize(gui_interpret_input(get(hObject,'String')),handles.nndata.gui.input.normalize);

if(isempty(input))
  errordlg('Invalid input data','Error','modal');
  return
end

if size(input,1)~=35
  errordlg('Wrong input dimensions. Must have 35 columns','Error','modal');
  return
end

handles.input=input;
handles.current=1;

handles.max_input=max(max(input));
handles.min_input=min(min(input));

show_pattern(handles); %show first object.
msgbox('Input data changed','Info');

guidata(handles.pattern_classification, handles);




% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current=handles.current+1;

if(handles.current>size(handles.input,2))
  handles.current=1;
end

show_pattern(handles); %show first object.

guidata(handles.pattern_classification, handles);





% --- Executes on button press in rand.
function rand_Callback(hObject, eventdata, handles)
% hObject    handle to rand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current=ceil(rand*size(handles.input,2));
show_pattern(handles); %show first object.
guidata(handles.pattern_classification, handles);

function show_pattern(handles);
  %given a neural network and input data, shows a given pattern.
  
  number=handles.current;
  
  handles.current_input=handles.input(1:25,number);

  update_gui(handles);
  
  guidata(handles.pattern_classification, handles);


function update_gui(handles);
  input=handles.current_input;
  nndata=handles.nndata;
  
  im=reshape(input,5,5);
  
  old=get(handles.screen);   %save old parameters
  
%   object=imagesc(-im');
  object=image(255 * (im' / 2 + .5));
  colormap(gray);

  %these were a pain to find. There must be a better way to do this.

  %THIS IS VERY UGLY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  global PATTERN_CLASSIFICATION_HANDLES
  PATTERN_CLASSIFICATION_HANDLES=handles;
  
  fcn=['gui_pattern_classification(' char(39) 'screen_ButtonDownFcn' char(39) ', gcbo, [], [])'];
  set(get(object,'Parent'),'ButtonDownFcn',fcn);
  set(object,'HitTest','off');
  set(get(object,'Parent'),'YTick',old.YTick);
  set(get(object,'Parent'),'XTick',old.XTick);

  %propagate the pattern
  nndata=forward(nndata, input);
  
  %show the output
  set(handles.d0,'String', num2str(nndata.layer{end}.outputactivation(1)))
  set(handles.d1,'String', num2str(nndata.layer{end}.outputactivation(2)))
  set(handles.d2,'String', num2str(nndata.layer{end}.outputactivation(3)))
  set(handles.d3,'String', num2str(nndata.layer{end}.outputactivation(4)))
  set(handles.d4,'String', num2str(nndata.layer{end}.outputactivation(5)))
  set(handles.d5,'String', num2str(nndata.layer{end}.outputactivation(6)))
  set(handles.d6,'String', num2str(nndata.layer{end}.outputactivation(7)))
  set(handles.d7,'String', num2str(nndata.layer{end}.outputactivation(8)))
  set(handles.d8,'String', num2str(nndata.layer{end}.outputactivation(9)))
  set(handles.d9,'String', num2str(nndata.layer{end}.outputactivation(10)))
  
  set(handles.pattern,'String', num2str(handles.current));

  [m,ind]=max(nndata.layer{end}.outputactivation);
  
  set(handles.classification,'String', num2str(ind-1));
  

% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.current_input=handles.min_input*ones(25,1);
update_gui(handles);
  
guidata(handles.pattern_classification, handles);



% --- Executes on mouse press over axes background.
function screen_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to screen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
persistent LAST_BUTTON_CLICKED;
global PATTERN_CLASSIFICATION_HANDLES;

if(isempty(handles))
  handles=PATTERN_CLASSIFICATION_HANDLES;   %THIS IS UGLY!!!!!
end

if(isempty(LAST_BUTTON_CLICKED))
  LAST_BUTTON_CLICKED=0;
end

pos=get(hObject,'CurrentPoint');
pos=pos(1,1:2);

b=get(gcf,'SelectionType');

switch b
  case 'open'
    button=LAST_BUTTON_CLICKED;
  case 'normal'
    button=1;
  case 'extend'
    button=2;
  case 'alt'
    button=3;
end    
LAST_BUTTON_CLICKED=button;

pos=round(pos);

switch(button)
  case 1
    value=handles.max_input;
  otherwise
    value=handles.min_input;
end
  
  
handles.current_input(pos(1)+(pos(2)-1)*5)=value;
update_gui(handles);


% --- Executes on button press in confusion.
function confusion_Callback(hObject, eventdata, handles)
% hObject    handle to confusion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nndata=handles.nndata;
input=handles.input(1:25,:);
desired=handles.input(26:end,:);
  
print_confusion_matrix(nndata,input,desired);


% --- Executes when user attempts to close pattern_classification.
function pattern_classification_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to pattern_classification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(hObject);
