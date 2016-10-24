function varargout = gui_traindefine(varargin)
% GUI_TRAINDEFINE M-file for gui_traindefine.fig
%      GUI_TRAINDEFINE, by itself, creates a new GUI_TRAINDEFINE or raises the existing
%      singleton*.
%
%      H = GUI_TRAINDEFINE returns the handle to a new GUI_TRAINDEFINE or the handle to
%      the existing singleton*.
%
%      GUI_TRAINDEFINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TRAINDEFINE.M with the given input arguments.
%
%      GUI_TRAINDEFINE('Property','Value',...) creates a new GUI_TRAINDEFINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_traindefine_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_traindefine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_traindefine

% Last Modified by GUIDE v2.5 04-Sep-2014 15:13:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_traindefine_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_traindefine_OutputFcn, ...
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


% --- Executes just before gui_traindefine is made visible.
function gui_traindefine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_traindefine (see VARARGIN)

if(nargin>3)
  train=varargin{1};
  if(isempty(train))
    train=traindefine;
  end
else
  train=traindefine;
end

%%% initialize gui

set(handles.nepochs,'String',train.nepochs);
set(handles.desiredcost,'String',train.desiredcost);
set(handles.weightrange,'String',train.weightrange);
set(handles.eta0,'String',train.eta0);
set(handles.alpha,'String',train.alpha);
set(handles.adaptivesteps,'Value',train.adaptivesteps);
set(handles.etaup,'String',train.etaup);
set(handles.etadown,'String',train.etadown);
set(handles.costcontrol,'Value',train.costcontrol);
set(handles.costtolerance,'String',sprintf('%1.8f',train.costtolerance));
set(handles.etareduce,'String',train.etareduce);
set(handles.reporteveryepoch,'Value',train.reporteveryepoch);

%%%%%%%%%%%%%%%%%%%%%%%%%%% find all possible cost functions
fil=dir;
n=1;
default_value = 1;
for i=1:length(fil)
  if(strncmp(fil(i).name, 'costfun_', 8) && strcmp(fil(i).name(end-1:end), '.m'))
    possible{n} = feval(fil(i).name(1:end-2), [], [], 'description');
    names{n} = fil(i).name(9:end-2);
    
    %check to see if this is the previously selected function
    if strcmpi(train.costfun,names{n})
      default_value=n;
    end
    n=n+1;
  end
end

set(handles.costfunction,'String',possible);
set(handles.costfunction,'Value',default_value);

% Choose default command line output for gui_traindefine
handles.output = train;
handles.costfunction_names=names;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_traindefine wait for user response (see UIRESUME)
uiwait(handles.traindefine);


% --- Outputs from this function are returned to the command line.
function varargout = gui_traindefine_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

delete(handles.traindefine); %close gui window

% --- Executes during object creation, after setting all properties.
function nepochs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nepochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function nepochs_Callback(hObject, eventdata, handles)
% hObject    handle to nepochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nepochs as text
%        str2double(get(hObject,'String')) returns contents of nepochs as a double


% --- Executes during object creation, after setting all properties.
function desiredcost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to desiredcost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function desiredcost_Callback(hObject, eventdata, handles)
% hObject    handle to desiredcost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of desiredcost as text
%        str2double(get(hObject,'String')) returns contents of desiredcost as a double


% --- Executes during object creation, after setting all properties.
function weightrange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to weightrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function weightrange_Callback(hObject, eventdata, handles)
% hObject    handle to weightrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of weightrange as text
%        str2double(get(hObject,'String')) returns contents of weightrange as a double


% --- Executes during object creation, after setting all properties.
function eta0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eta0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function eta0_Callback(hObject, eventdata, handles)
% hObject    handle to eta0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eta0 as text
%        str2double(get(hObject,'String')) returns contents of eta0 as a double


% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double


% --- Executes during object creation, after setting all properties.
function etaup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etaup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function etaup_Callback(hObject, eventdata, handles)
% hObject    handle to etaup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etaup as text
%        str2double(get(hObject,'String')) returns contents of etaup as a double


% --- Executes during object creation, after setting all properties.
function etadown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etadown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function etadown_Callback(hObject, eventdata, handles)
% hObject    handle to etadown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etadown as text
%        str2double(get(hObject,'String')) returns contents of etadown as a double


% --- Executes during object creation, after setting all properties.
function costtolerance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to costtolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function costtolerance_Callback(hObject, eventdata, handles)
% hObject    handle to costtolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of costtolerance as text
%        str2double(get(hObject,'String')) returns contents of costtolerance as a double


% --- Executes during object creation, after setting all properties.
function etareduce_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etareduce (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function etareduce_Callback(hObject, eventdata, handles)
% hObject    handle to etareduce (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etareduce as text
%        str2double(get(hObject,'String')) returns contents of etareduce as a double


% --- Executes on button press in adaptivesteps.
function adaptivesteps_Callback(hObject, eventdata, handles)
% hObject    handle to adaptivesteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

train.adaptivesteps = get(hObject,'Value');
set(handles.costcontrol,'Value',train.adaptivesteps);


% --- Executes on button press in costcontrol.
function costcontrol_Callback(hObject, eventdata, handles)
% hObject    handle to costcontrol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of costcontrol


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

train=handles.output; %start with saved copy

train.nepochs=str2double(get(handles.nepochs,'String'));
train.desiredcost=str2double(get(handles.desiredcost,'String'));
train.weightrange=str2double(get(handles.weightrange,'String'));
train.eta0=str2double(get(handles.eta0,'String'));
train.alpha=str2double(get(handles.alpha,'String'));
train.adaptivesteps=get(handles.adaptivesteps,'Value');
train.etaup=str2double(get(handles.etaup,'String'));
train.etadown=str2double(get(handles.etadown,'String'));
train.costcontrol=get(handles.costcontrol,'Value');
train.costtolerance=str2double(get(handles.costtolerance,'String'));
train.etareduce=str2double(get(handles.etareduce,'String'));
train.reporteveryepoch=get(handles.reporteveryepoch,'Value');

names=handles.costfunction_names;
value=get(handles.costfunction,'Value');

train.costfun=names{value};         %select cost function
set(handles.traindefine, 'Visible', 'off');
set(handles.traindefine, 'WindowStyle', 'normal');
call_costfun(train.costfun, [], [], 'configure'); %configure it


% Choose default command line output for gui_traindefine
handles.output = train;

% Update handles structure
guidata(hObject, handles);


uiresume(handles.traindefine);


% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume(handles.traindefine);


% --- Executes when user attempts to close traindefine.
function traindefine_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to traindefine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
%delete(hObject);
uiresume(hObject);



% --- Executes on button press in reporteveryepoch.
function reporteveryepoch_Callback(hObject, eventdata, handles)
% hObject    handle to reporteveryepoch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of reporteveryepoch


% --- Executes during object creation, after setting all properties.
function costfunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to costfunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in costfunction.
function costfunction_Callback(hObject, eventdata, handles)
% hObject    handle to costfunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns costfunction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from costfunction
