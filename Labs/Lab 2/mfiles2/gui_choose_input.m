%NOTE: 
%    Due to matlab error if a string is passed (it tries to execute it as a function... no comments...)
%        the training argument must be given in a structure with parameter "value". Ricardo

function varargout = gui_choose_input(varargin)
% GUI_CHOOSE_INPUT M-file for gui_choose_input.fig
%      GUI_CHOOSE_INPUT, by itself, creates a new GUI_CHOOSE_INPUT or raises the existing
%      singleton*.
%
%      H = GUI_CHOOSE_INPUT returns the handle to a new GUI_CHOOSE_INPUT or the handle to
%      the existing singleton*.
%
%      GUI_CHOOSE_INPUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CHOOSE_INPUT.M with the given training arguments.
%
%      GUI_CHOOSE_INPUT('Property','Value',...) creates a new GUI_CHOOSE_INPUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_choose_input_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_choose_input_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_choose_input

% Last Modified by GUIDE v2.5 17-Sep-2015 19:05:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_choose_input_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_choose_input_OutputFcn, ...
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


% --- Executes just before gui_choose_input is made visible.
function gui_choose_input_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_choose_input (see VARARGIN)

if(nargin>3)
  input=varargin{1};
  if(isempty(input))
    input.training='';
    input.validation='';
    input.test='';
    input.normalize=[];
    input.ninputs=1;
    input.noutputs=1;
  end
else
  input.training='';
  input.validation='';
  input.test='';
  input.normalize=[];
  input.ninputs=1;
  input.noutputs=1;
end

set(handles.training, 'String', input.training);
set(handles.validation,'String', input.validation);
set(handles.test,'String', input.test);

set(handles.ninputs, 'String', input.ninputs);
set(handles.noutputs, 'String', input.noutputs);

set(handles.normalize, 'Value', ~isempty(input.normalize));
set(handles.normalize_range, 'String', num2str(input.normalize));



% Choose default command line output for gui_choose_input
handles.output = input;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_choose_input wait for user response (see UIRESUME)
uiwait(handles.input_dlg);


% --- Outputs from this function are returned to the command line.
function varargout = gui_choose_input_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(hObject);

% --- Executes during object creation, after setting all properties.
function training_CreateFcn(hObject, eventdata, handles)
% hObject    handle to training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function training_Callback(hObject, eventdata, handles)
% hObject    handle to training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of training as text
%        str2double(get(hObject,'String')) returns contents of training as a double

% --- Executes when user attempts to close input_dlg.
function input_dlg_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to input_dlg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(hObject);


% --- Executes during object creation, after setting all properties.
function ninputs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ninputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function ninputs_Callback(hObject, eventdata, handles)
% hObject    handle to ninputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ninputs as text
%        str2double(get(hObject,'String')) returns contents of ninputs as a double


% --- Executes during object creation, after setting all properties.
function noutputs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noutputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function noutputs_Callback(hObject, eventdata, handles)
% hObject    handle to noutputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noutputs as text
%        str2double(get(hObject,'String')) returns contents of noutputs as a double


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


output.training=get(handles.training, 'String');
output.validation=get(handles.validation,'String');
output.test=get(handles.test,'String');
output.ninputs=str2num(get(handles.ninputs,'String'));
output.noutputs=str2num(get(handles.noutputs,'String'));

if(get(handles.normalize,'Value'))
  output.normalize=str2num(get(handles.normalize_range, 'String'));
else
  output.normalize=[];
end



in=gui_interpret_input(output.training);

if(isempty(in))
  errordlg('Could not interpret training data','Error');
  return
end

if(size(in, 1)~=output.ninputs+output.noutputs)
  errordlg('Training data dimensions are not correct'); 
  return
end


if(~isempty(output.validation))
  validation=gui_interpret_input(output.validation);
  
  
  if(isempty(validation))
    errordlg('Could not interpret validation data','Error');
    return
  end
  
  if(size(validation, 1)~=output.ninputs+output.noutputs)
    errordlg('Validation data dimensions are not correct'); 
    return
  end
end


if(~isempty(output.test))
  test=gui_interpret_input(output.test);
  
  
  if(isempty(test))
    errordlg('Could not interpret test data','Error');
    return
  end
  
  if(size(test, 1)~=output.ninputs+output.noutputs)
    errordlg('Test data dimensions are not correct'); 
    return
  end
end
  
  

handles.output=output; %save it in handles so it get's returned
guidata(handles.input_dlg, handles); %save handles

uiresume(handles.input_dlg);


% --- Executes during object creation, after setting all properties.
function validation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function validation_Callback(hObject, eventdata, handles)
% hObject    handle to validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of validation as text
%        str2double(get(hObject,'String')) returns contents of validation as a double


% --- Executes on button press in normalize.
function normalize_Callback(hObject, eventdata, handles)
% hObject    handle to normalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of normalize


% --- Executes during object creation, after setting all properties.
function normalize_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to normalize_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function normalize_range_Callback(hObject, eventdata, handles)
% hObject    handle to normalize_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of normalize_range as text
%        str2double(get(hObject,'String')) returns contents of normalize_range as a double



function test_Callback(hObject, eventdata, handles)
% hObject    handle to test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of test as text
%        str2double(get(hObject,'String')) returns contents of test as a double


% --- Executes during object creation, after setting all properties.
function test_CreateFcn(hObject, eventdata, handles)
% hObject    handle to test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
