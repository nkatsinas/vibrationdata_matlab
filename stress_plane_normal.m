function varargout = stress_plane_normal(varargin)
% STRESS_PLANE_NORMAL MATLAB code for stress_plane_normal.fig
%      STRESS_PLANE_NORMAL, by itself, creates a new STRESS_PLANE_NORMAL or raises the existing
%      singleton*.
%
%      H = STRESS_PLANE_NORMAL returns the handle to a new STRESS_PLANE_NORMAL or the handle to
%      the existing singleton*.
%
%      STRESS_PLANE_NORMAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRESS_PLANE_NORMAL.M with the given input arguments.
%
%      STRESS_PLANE_NORMAL('Property','Value',...) creates a new STRESS_PLANE_NORMAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stress_plane_normal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stress_plane_normal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stress_plane_normal

% Last Modified by GUIDE v2.5 23-Feb-2015 12:21:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stress_plane_normal_OpeningFcn, ...
                   'gui_OutputFcn',  @stress_plane_normal_OutputFcn, ...
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


% --- Executes just before stress_plane_normal is made visible.
function stress_plane_normal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stress_plane_normal (see VARARGIN)

% Choose default command line output for stress_plane_normal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stress_plane_normal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stress_plane_normal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(stress_plane_normal);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_S,'String');
    S=evalin('base',FS); 
catch
    warndlg('Input Tensor does not exist');
    return;
end
 
disp(' ');
disp(' Stress Tensor' );
S



try
    FS=get(handles.edit_n,'String');
    n=evalin('base',FS); 
catch
    warndlg('Input vector does not exist');
    return;
end

n=n/norm(n);
n=fix_size(n);
 
disp(' ');
disp(' Unit normal' );
n


sz1=size(S);
sz2=size(n);

if(sz1(1)~=sz1(2))
    warndlg('Stress tensor must be square.');
    return;
end

if(sz1(2)~=sz2(1))
    warndlg('Input error.  Incompatible vector size');
    return;
end

sigma=dot(n,S*n);
tau=norm(S*n-sigma*n);

m=(S*n-sigma*n)/tau;

disp(' ');
disp(' Normal Stress ');
out1=sprintf(' sigma=%8.4g ',sigma);
disp(out1);

disp(' ');
disp(' Shear Stress ');
out1=sprintf(' tau=%8.4g ',tau);
disp(out1);


disp(' ');
disp(' In-plane Shear Unit Vector ');
m

disp(' ');
disp(' dot(m,n) = ');

dot(m,n)

msgbox('Results written to Command Window');





function edit_S_Callback(hObject, eventdata, handles)
% hObject    handle to edit_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_S as text
%        str2double(get(hObject,'String')) returns contents of edit_S as a double


% --- Executes during object creation, after setting all properties.
function edit_S_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_n_Callback(hObject, eventdata, handles)
% hObject    handle to edit_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_n as text
%        str2double(get(hObject,'String')) returns contents of edit_n as a double


% --- Executes during object creation, after setting all properties.
function edit_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
