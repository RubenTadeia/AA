function varargout = gui_save_net(varargin)
% GUI_SAVE_NET MATLAB code for gui_save_net.fig
%      GUI_SAVE_NET by itself, creates a new GUI_SAVE_NET or raises the
%      existing singleton*.
%
%      H = GUI_SAVE_NET returns the handle to a new GUI_SAVE_NET or the handle to
%      the existing singleton*.
%
%      GUI_SAVE_NET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SAVE_NET.M with the given input arguments.
%
%      GUI_SAVE_NET('Property','Value',...) creates a new GUI_SAVE_NET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_save_net_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_save_net_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_save_net

% Last Modified by GUIDE v2.5 21-Sep-2015 21:56:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_save_net_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_save_net_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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

% --- Executes just before gui_save_net is made visible.
function gui_save_net_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_save_net (see VARARGIN)

% Choose default command line output for gui_save_net
handles.output = 'Yes';

% Update handles structure
guidata(hObject, handles);

% Insert custom Title and Text if specified by the user
% Hint: when choosing keywords, be sure they are not easily confused 
% with existing figure properties.  See the output of set(figure) for
% a list of figure properties.
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'string'
          set(handles.text1, 'String', varargin{index+1});
        end
    end
end

% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);

    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);

% Show a question icon from dialogicons.mat - variables questIconData
% and questIconMap
load dialogicons.mat

IconData=questIconData;
questIconMap(256,:) = get(handles.save_net, 'Color');
IconCMap=questIconMap;

set(handles.save_net, 'Colormap', IconCMap);

% Make the GUI modal
set(handles.save_net,'WindowStyle','modal')

global NNDATA

if ~isfield(NNDATA.layer{1}, 'weightmin')
  set(handles.best_training,'Enable','off')
end

if ~isfield(NNDATA.layer{1}, 'weightvalmin')
  set(handles.best_validation,'Enable','off')
end

% UIWAIT makes gui_save_net wait for user response (see UIRESUME)
uiwait(handles.save_net);

% --- Outputs from this function are returned to the command line.
function varargout = gui_save_net_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.save_net);

% --- Executes on button press in ok_button.
function ok_button_Callback(hObject, eventdata, handles)
% hObject    handle to ok_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.current, 'Value')
  handles.output = 'current';
elseif get(handles.best_training, 'Value')
  handles.output = 'best_training';
elseif get(handles.best_validation, 'Value')
  handles.output = 'best_validation';
else
  handles.output = 'invalid';
end

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.save_net);

% --- Executes on button press in cancel_button.
function cancel_button_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.save_net);


% --- Executes when user attempts to close save_net.
function save_net_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to save_net (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = 'Cancel';

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(hObject);


% --- Executes on key press over save_net with no controls selected.
function save_net_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to save_net (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    handles.output = 'No';
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.save_net);
end    
    
if isequal(get(hObject,'CurrentKey'),'return')
    uiresume(handles.save_net);
end    


% --- Executes on button press in current.
function current_Callback(hObject, eventdata, handles)
% hObject    handle to current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of current


% --- Executes on button press in best_training.
function best_training_Callback(hObject, eventdata, handles)
% hObject    handle to best_training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of best_training


% --- Executes on button press in best_validation.
function best_validation_Callback(hObject, eventdata, handles)
% hObject    handle to best_validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of best_validation
