function varargout = picture_view(varargin)
% PICTURE_VIEW M-file for picture_view.fig
%      PICTURE_VIEW, by itself, creates a new PICTURE_VIEW or raises the existing
%      singleton*.
%
%      H = PICTURE_VIEW returns the handle to a new PICTURE_VIEW or the handle to
%      the existing singleton*.
%
%      PICTURE_VIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PICTURE_VIEW.M with the given input arguments.
%
%      PICTURE_VIEW('Property','Value',...) creates a new PICTURE_VIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before picture_view_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to picture_view_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help picture_view

% Last Modified by GUIDE v2.5 25-Mar-2002 12:19:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @picture_view_OpeningFcn, ...
                   'gui_OutputFcn',  @picture_view_OutputFcn, ...
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


% --- Executes just before picture_view is made visible.
function picture_view_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to picture_view (see VARARGIN)

% Choose default command line output for picture_view
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes picture_view wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = picture_view_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
