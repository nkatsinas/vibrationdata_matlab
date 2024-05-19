function varargout = octahedral_stress(varargin)
% OCTAHEDRAL_STRESS MATLAB code for octahedral_stress.fig
%      OCTAHEDRAL_STRESS, by itself, creates a new OCTAHEDRAL_STRESS or raises the existing
%      singleton*.
%
%      H = OCTAHEDRAL_STRESS returns the handle to a new OCTAHEDRAL_STRESS or the handle to
%      the existing singleton*.
%
%      OCTAHEDRAL_STRESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OCTAHEDRAL_STRESS.M with the given input arguments.
%
%      OCTAHEDRAL_STRESS('Property','Value',...) creates a new OCTAHEDRAL_STRESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before octahedral_stress_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to octahedral_stress_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help octahedral_stress

% Last Modified by GUIDE v2.5 02-Apr-2015 12:21:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @octahedral_stress_OpeningFcn, ...
                   'gui_OutputFcn',  @octahedral_stress_OutputFcn, ...
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


% --- Executes just before octahedral_stress is made visible.
function octahedral_stress_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to octahedral_stress (see VARARGIN)

% Choose default command line output for octahedral_stress
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes octahedral_stress wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = octahedral_stress_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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

sz=size(S);

if(sz(1)~=3 || sz(2)~=3)
    warndlg('Input array size must be 3x3');
    return; 
end
 
disp(' ');
disp(' Cauchy Stress Tensor' );
S


I1=trace(S);

I2=0;

for i=1:3
    for j=1:3
        I2=I2+S(i,i)*S(j,j)-S(i,j)*S(j,i);
    end
end

I2=I2/2;

sigma_oct=I1/3

tau_oct=sqrt( 2*I1^2-6*I2)/3

msgbox('Results written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(octahedral_stress);

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
