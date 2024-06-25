function varargout = Class10_5_14(varargin)
% CLASS10_5_14 MATLAB code for Class10_5_14.fig
%      CLASS10_5_14, by itself, creates a new CLASS10_5_14 or raises the existing
%      singleton*.
%
%      H = CLASS10_5_14 returns the handle to a new CLASS10_5_14 or the handle to
%      the existing singleton*.
%
%      CLASS10_5_14('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLASS10_5_14.M with the given input arguments.
%
%      CLASS10_5_14('Property','Value',...) creates a new CLASS10_5_14 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Class10_5_14_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Class10_5_14_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Class10_5_14

% Last Modified by GUIDE v2.5 14-May-2024 11:12:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Class10_5_14_OpeningFcn, ...
                   'gui_OutputFcn',  @Class10_5_14_OutputFcn, ...
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


% --- Executes just before Class10_5_14 is made visible.
function Class10_5_14_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Class10_5_14 (see VARARGIN)

% Choose default command line output for Class10_5_14
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Class10_5_14 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Class10_5_14_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(hObject,'Value',get(hObject,'Max'))
set(findobj(gcf,'Tag','radiobutton2'),'Value',get(findobj(gcf,'Tag','radiobutton1'),'Min'))
set(findobj(gcf,'Tag','radiobutton3'),'Value',get(findobj(gcf,'Tag','radiobutton2'),'Min'))


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(hObject,'Value',get(hObject,'Max'))
set(findobj(gcf,'Tag','radiobutton1'),'Value',get(findobj(gcf,'Tag','radiobutton1'),'Min'))
set(findobj(gcf,'Tag','radiobutton2'),'Value',get(findobj(gcf,'Tag','radiobutton2'),'Min'))

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
set(hObject,'Value',get(hObject,'Max'))
set(findobj(gcf,'Tag','radiobutton1'),'Value',get(findobj(gcf,'Tag','radiobutton1'),'Min'))
set(findobj(gcf,'Tag','radiobutton3'),'Value',get(findobj(gcf,'Tag','radiobutton2'),'Min'))


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hrf=findobj(gcf,'Tag','radiobutton1');
hri=findobj(gcf,'Tag','radiobutton2');
hrc=findobj(gcf,'Tag','radiobutton3');
set(gcf,'CurrentAxes',findobj(gcf,'Type','Axes'))
ezsurf(@peaks)
if(get(hrf,'Value')==get(hrf,'Max'))
shading flat
elseif(get(hri,'Value')==get(hri,'Max'))
shading faceted 
elseif(get(hrc,'Value')==get(hrc,'Max'))
shading interp
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla %清空绘图区

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton1_Callback

% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla %清空绘图区

% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close %关闭绘图区

% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
