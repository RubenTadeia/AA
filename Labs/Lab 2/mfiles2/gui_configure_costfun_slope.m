function varargout = gui_configure_costfun_slope(varargin)
% GUI_CONFIGURE_COSTFUN_SLOPE M-file for gui_configure_costfun_slope.fig
%      GUI_CONFIGURE_COSTFUN_SLOPE, by itself, creates a new GUI_CONFIGURE_COSTFUN_SLOPE or raises the existing
%      singleton*.
%
%      H = GUI_CONFIGURE_COSTFUN_SLOPE returns the handle to a new GUI_CONFIGURE_COSTFUN_SLOPE or the handle to
%      the existing singleton*.
%
%      GUI_CONFIGURE_COSTFUN_SLOPE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CONFIGURE_COSTFUN_SLOPE.M with the given input arguments.
%
%      GUI_CONFIGURE_COSTFUN_SLOPE('Property','Value',...) creates a new GUI_CONFIGURE_COSTFUN_SLOPE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_configure_costfun_slope_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_configure_costfun_slope_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_configure_costfun_slope

% Last Modified by GUIDE v2.5 04-Sep-2014 15:08:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_configure_costfun_slope_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_configure_costfun_slope_OutputFcn, ...
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


% --- Executes just before gui_configure_costfun_slope is made visible.
function gui_configure_costfun_slope_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_configure_costfun_slope (see VARARGIN)

input=varargin{1};

if(isempty(input))
  input.nslope=1;
  input.pslope=1;
end

set(handles.nslope, 'String', num2str(input.nslope));
set(handles.pslope, 'String', num2str(input.pslope));


% Choose default command line output for gui_configure_costfun_slope
handles.output = input;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_configure_costfun_slope wait for user response (see UIRESUME)
uiwait(handles.configure_dlg);


% --- Outputs from this function are returned to the command line.
function varargout = gui_configure_costfun_slope_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

handles.output.nslope=str2num(get(handles.nslope,'String'));
handles.output.pslope=str2num(get(handles.pslope,'String'));

varargout{1} = handles.output;
delete(handles.configure_dlg);


% --- Executes during object creation, after setting all properties.
function nslope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nslope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function nslope_Callback(hObject, eventdata, handles)
% hObject    handle to nslope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nslope as text
%        str2double(get(hObject,'String')) returns contents of nslope as a double


% --- Executes when user attempts to close configure_dlg.
function configure_dlg_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to configure_dlg (see GCBO)
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


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.configure_dlg);


% --- Executes during object creation, after setting all properties.
function pslope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pslope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function pslope_Callback(hObject, eventdata, handles)
% hObject    handle to pslope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pslope as text
%        str2double(get(hObject,'String')) returns contents of pslope as a double
