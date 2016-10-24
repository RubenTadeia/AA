function varargout = gui_configure_costfun_sigmoid(varargin)
%GUI_CONFIGURE_COSTFUN_SIGMOID M-file for gui_configure_costfun_sigmoid.fig
%      GUI_CONFIGURE_COSTFUN_SIGMOID, by itself, creates a new GUI_CONFIGURE_COSTFUN_SIGMOID or raises the existing
%      singleton*.
%
%      H = GUI_CONFIGURE_COSTFUN_SIGMOID returns the handle to a new GUI_CONFIGURE_COSTFUN_SIGMOID or the handle to
%      the existing singleton*.
%
%      GUI_CONFIGURE_COSTFUN_SIGMOID('Property','Value',...) creates a new GUI_CONFIGURE_COSTFUN_SIGMOID using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to gui_configure_costfun_sigmoid_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI_CONFIGURE_COSTFUN_SIGMOID('CALLBACK') and GUI_CONFIGURE_COSTFUN_SIGMOID('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI_CONFIGURE_COSTFUN_SIGMOID.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_configure_costfun_sigmoid

% Last Modified by GUIDE v2.5 25-Sep-2015 17:16:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_configure_costfun_sigmoid_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_configure_costfun_sigmoid_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_configure_costfun_sigmoid is made visible.
function gui_configure_costfun_sigmoid_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

factor=varargin{1};

if(isempty(factor))
  factor = 10;
 end

set(handles.factor, 'String', num2str(factor));

% Choose default command line output for gui_configure_costfun_slope
handles.output = factor;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_configure_costfun_slope wait for user response (see UIRESUME)
uiwait(handles.configure_dlg);


% --- Outputs from this function are returned to the command line.
function varargout = gui_configure_costfun_sigmoid_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output = str2num(get(handles.factor,'String'));
varargout{1} = handles.output;
delete(handles.configure_dlg);



function factor_Callback(hObject, eventdata, handles)
% hObject    handle to factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of factor as text
%        str2double(get(hObject,'String')) returns contents of factor as a double


% --- Executes during object creation, after setting all properties.
function factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.configure_dlg);
