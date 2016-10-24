function varargout = gui_netdefine(varargin)
% GUI_NETDEFINE M-file for gui_netdefine.fig
%      GUI_NETDEFINE, by itself, creates a new GUI_NETDEFINE or raises the existing
%      singleton*.
%
%      H = GUI_NETDEFINE returns the handle to a new GUI_NETDEFINE or the handle to
%      the existing singleton*.
%
%      GUI_NETDEFINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_NETDEFINE.M with the given input arguments.
%
%      GUI_NETDEFINE('Property','Value',...) creates a new GUI_NETDEFINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_netdefine_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_netdefine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_netdefine

% Last Modified by GUIDE v2.5 28-Sep-2004 21:25:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_netdefine_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_netdefine_OutputFcn, ...
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


% --- Executes just before gui_netdefine is made visible.
function gui_netdefine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command checkbox1 arguments to gui_netdefine (see VARARGIN)

if(nargin>3)
  nndata=varargin{1};
  if(isempty(nndata))
    nndata=create_net;
    nndata.gui.input.training='';
    nndata.gui.input.validation='';
    nndata.gui.input.test='';
    nndata.gui.input.normalize=[];
    nndata.gui.display_net=gui_create_display_net(nndata);
  end
else
  nndata=create_net;  
  nndata.gui.input.training='';
  nndata.gui.input.validation='';
  nndata.gui.input.test='';
  nndata.gui.input.normalize=[];
  nndata.gui.display_net=gui_create_display_net(nndata);
end

%%% initialize gui


set(handles.ninputs,'String',nndata.ninputs);
set(handles.noutputs,'String',nndata.layer{end}.nunits);

nunits=[];
for i=1:length(nndata.layer)-1
  nunits=[nunits '  ' num2str(nndata.layer{i}.nunits)];
end
set(handles.nunits,'String',nunits);


% Choose default command checkbox1 output for gui_netdefine
handles.output = nndata;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_netdefine wait for user response (see UIRESUME)
uiwait(handles.netdefine);


% --- Outputs from this function are returned to the command checkbox1.
function varargout = gui_netdefine_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command checkbox1 output from handles structure
varargout{1} = handles.output;

delete(handles.netdefine); %close gui window

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



% --- Executes during object creation, after setting all properties.
function nhiddenlayers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nhidde.layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function nhiddenlayers_Callback(hObject, eventdata, handles)
% hObject    handle to nhidde.layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nhidde.layer as text
%        str2double(get(hObject,'String')) returns contents of nhidde.layer as a double


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


% --- Executes on button press in linearoutputs.
function linearoutputs_Callback(hObject, eventdata, handles)
% hObject    handle to linearoutputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ninputs=str2double(get(handles.ninputs,'String'));
noutputs=str2double(get(handles.noutputs,'String'));
nunits=str2double(get(handles.nunits,'String'));
if isnan(nunits)              % If the field was blank or invalid...
  nunits = [];                % ...indicate no hidden units
end

% Choose default command checkbox1 output for gui_netdefine
new_nndata = create_net(ninputs, [nunits noutputs]);

%handles.output.layer=new_net.layer;
%handles.output.ninputs=new_net.ninputs;
%handles.ouput=reset_net(handles.output);

new_nndata.gui=handles.output.gui;
new_nndata.gui.display_net=gui_create_display_net(new_nndata);
handles.output=new_nndata; %return new network

% Update handles structure
guidata(hObject, handles);

uiresume(handles.netdefine);

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume(handles.netdefine);


% --- Executes when user attempts to close netdefine.
function netdefine_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to netdefine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
%delete(hObject);
uiresume(hObject);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


