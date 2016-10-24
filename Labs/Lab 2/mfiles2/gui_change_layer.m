function varargout = gui_change_layer(varargin)
% GUI_CHANGE_LAYER M-file for gui_change_layer.fig
%      GUI_CHANGE_LAYER, by itself, creates a new GUI_CHANGE_LAYER or raises the existing
%      singleton*.
%
%      H = GUI_CHANGE_LAYER returns the handle to a new GUI_CHANGE_LAYER or the handle to
%      the existing singleton*.
%
%      GUI_CHANGE_LAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CHANGE_LAYER.M with the given input arguments.
%
%      GUI_CHANGE_LAYER('Property','Value',...) creates a new GUI_CHANGE_LAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_change_layer_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_change_layer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_change_layer

% Last Modified by GUIDE v2.5 01-Oct-2004 12:20:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_change_layer_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_change_layer_OutputFcn, ...
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


% --- Executes just before gui_change_layer is made visible.
function gui_change_layer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_change_layer (see VARARGIN)

input=varargin{1};
set(handles.nunits, 'String', input.nunits);

%%%%%%%%%%%%%%%%%%%%%%%%%%% find all possible activation functions
fil=dir;
n=1;
default_value=1;
for i=1:length(fil)
  if(strncmp(fil(i).name,'afun_',5) & strcmp(fil(i).name(end-1:end),'.m'))
    possible{n}=feval(fil(i).name(1:end-2), [],'description');
    names{n}=fil(i).name(6:end-2);
    
    %check to see if this is the previously selected function
    if strcmpi(input.afun,names{n})
      default_value=n;
    end
    
    
    n=n+1;
  end
end

set(handles.activation_fun,'String',possible);
set(handles.activation_fun,'Value',default_value);


% Choose default command line output for gui_change_layer
handles.output = input;
handles.afun_names=names;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_change_layer wait for user response (see UIRESUME)
uiwait(handles.layer_dlg);


% --- Outputs from this function are returned to the command line.
function varargout = gui_change_layer_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

handles.output.nunits=str2num(get(handles.nunits,'String'));

names=handles.afun_names;
value=get(handles.activation_fun,'Value');

handles.output.afun=names{value};         %select activation function

varargout{1} = handles.output;
delete(handles.layer_dlg);


% --- Executes during object creation, after setting all properties.
function nunits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nunits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function nunits_Callback(hObject, eventdata, handles)
% hObject    handle to nunits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nunits as text
%        str2double(get(hObject,'String')) returns contents of nunits as a double
uiresume(handles.layer_dlg);


% --- Executes when user attempts to close layer_dlg.
function layer_dlg_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to layer_dlg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(hObject);


% --- Executes during object creation, after setting all properties.
function activation_fun_CreateFcn(hObject, eventdata, handles)
% hObject    handle to activation_fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in activation_fun.
function activation_fun_Callback(hObject, eventdata, handles)
% hObject    handle to activation_fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns activation_fun contents as cell array
%        contents{get(hObject,'Value')} returns selected item from activation_fun


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.layer_dlg);


