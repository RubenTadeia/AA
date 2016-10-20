function varargout = picture_show(varargin)
% PICTURE_SHOW M-file for picture_show.fig
%      PICTURE_SHOW, by itself, creates a new PICTURE_SHOW or raises the existing
%      singleton*.
%
%      H = PICTURE_SHOW returns the handle to a new PICTURE_SHOW or the handle to
%      the existing singleton*.
%
%      PICTURE_SHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PICTURE_SHOW.M with the given input_img arguments.
%
%      PICTURE_SHOW('Property','Value',...) creates a new PICTURE_SHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before picture_show_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to picture_show_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help picture_show

% Last Modified by GUIDE v2.5 09-Oct-2004 14:07:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @picture_show_OpeningFcn, ...
                   'gui_OutputFcn',  @picture_show_OutputFcn, ...
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


% --- Executes just before picture_show is made visible.
function picture_show_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to picture_show (see VARARGIN)


axes(handles.input_img);

if nargin<4
  errordlg('A trained Neural Network object must be supplied','Error', ...
	   'modal');
  return
%  close(handles.picture_show);
end

handles.nndata=varargin{1}; %save the neural network object

input=normalize(gui_interpret_input(handles.nndata.gui.input.training), handles.nndata.gui.input.normalize);

if(~isempty(input) & size(input,1)==10)
  handles.input=input;
  handles.current=1;
  
  handles.max_input=max(max(input));
  handles.min_input=min(min(input));

  show_picture(handles); %show first object.
else
  errordlg('Training data is not valid','Error','modal');
  return
end


% Choose default command line output for picture_show
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes picture_show wait for user response (see UIRESUME)
uiwait(handles.picture_show);


% --- Outputs from this function are returned to the command line.
function varargout = picture_show_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 0;
delete(hObject);


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current=handles.current+1;

if(handles.current>floor(size(handles.input,2)/196) )
  handles.current=1;
end

show_picture(handles); %show first object.

guidata(handles.picture_show, handles);


function show_picture(handles);
  %given a neural network and input data, shows a given picture.
  number=handles.current;
  
  handles.current_input=handles.input(:,(number-1)*196+1:number*196);
  set(handles.image_number, 'String', num2str(number));

  update_gui(handles);
  
  guidata(handles.picture_show, handles);


function update_gui(handles);
  input=handles.current_input;
  nndata=handles.nndata;
  
  im=reshape(input(5,:),14,14);
  
  axes(handles.input_img);

  imagesc(im);
  axis xy
  axis off

  colormap(gray);

  im=reshape(input(10,:),14,14);
  
  axes(handles.desired_img);
  imagesc(im);
  axis xy
  axis off
  colormap(gray);
  
  nndata=forward(nndata, input(1:9,:));
  
  %show the output
  im=reshape(nndata.layer{end}.outputactivation,14,14);
  
  axes(handles.output_img);
  imagesc(im);
  axis xy
  axis off
  colormap(gray);
  

% --- Executes when user attempts to close picture_show.
function picture_show_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to picture_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(hObject);


% --- Executes on mouse press over axes background.
function input_img_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to input_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in training.
function training_Callback(hObject, eventdata, handles)
% hObject    handle to training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of training

set(handles.test,'Value',0);

input=normalize(gui_interpret_input(handles.nndata.gui.input.training), handles.nndata.gui.input.normalize);

if(~isempty(input) & size(input,1)==10)
  handles.input=input;
  handles.current=1;
  
  handles.max_input=max(max(input));
  handles.min_input=min(min(input));

  show_picture(handles); %show first object.
else
  errordlg('Invalid training data','Error','modal');
  set(handles.test,'Value',1);
  set(handles.training,'Value',0);  
  return
end



% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in test.
function test_Callback(hObject, eventdata, handles)
% hObject    handle to test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of test

set(handles.training,'Value',0);

input=normalize(gui_interpret_input(handles.nndata.gui.input.test), handles.nndata.gui.input.normalize);

if(~isempty(input) & size(input,1)==10)
  handles.input=input;
  handles.current=1;
  
  handles.max_input=max(max(input));
  handles.min_input=min(min(input));

  show_picture(handles); %show first object.
else
  errordlg('Invalid test data','Error','modal');
  set(handles.test,'Value',0);
  set(handles.training,'Value',1);

  return
end

% Update handles structure
guidata(hObject, handles);

