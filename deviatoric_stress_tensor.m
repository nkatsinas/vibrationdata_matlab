function varargout = deviatoric_stress_tensor(varargin)
% DEVIATORIC_STRESS_TENSOR MATLAB code for deviatoric_stress_tensor.fig
%      DEVIATORIC_STRESS_TENSOR, by itself, creates a new DEVIATORIC_STRESS_TENSOR or raises the existing
%      singleton*.
%
%      H = DEVIATORIC_STRESS_TENSOR returns the handle to a new DEVIATORIC_STRESS_TENSOR or the handle to
%      the existing singleton*.
%
%      DEVIATORIC_STRESS_TENSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEVIATORIC_STRESS_TENSOR.M with the given input arguments.
%
%      DEVIATORIC_STRESS_TENSOR('Property','Value',...) creates a new DEVIATORIC_STRESS_TENSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before deviatoric_stress_tensor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to deviatoric_stress_tensor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help deviatoric_stress_tensor

% Last Modified by GUIDE v2.5 02-Apr-2015 11:00:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @deviatoric_stress_tensor_OpeningFcn, ...
                   'gui_OutputFcn',  @deviatoric_stress_tensor_OutputFcn, ...
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


% --- Executes just before deviatoric_stress_tensor is made visible.
function deviatoric_stress_tensor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to deviatoric_stress_tensor (see VARARGIN)

% Choose default command line output for deviatoric_stress_tensor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes deviatoric_stress_tensor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = deviatoric_stress_tensor_OutputFcn(hObject, eventdata, handles) 
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
 
disp(' ');
disp(' Cauchy Stress Tensor' );
S

mean_stress=trace(S)/3;

C=S;

for i=1:3
    C(i,i)=S(i,i)-mean_stress;
end

disp(' ');

out1=sprintf(' mean stress=%8.4g ',mean_stress);
disp(out1);


disp(' ');
disp(' Deviatoric Stress Tensor' );
C


disp(' ');
disp(' Deviatoric Stress Tensor Invariants' );

J1=trace(C);

J2=0;
J3=0;

for i=1:3
    for j=1:3
        J2=J2+C(i,j)*C(j,i);
        
        for k=1:3
            J3=J3+C(i,j)*C(j,k)*C(k,i);
        end
        
    end
end
J2=J2/2;
J3=J3/3;

out1=sprintf(' J1=%8.4g \n J2=%8.4g \n J3=%8.4g  ',J1,J2,J3);
disp(out1);

msgbox('Results written to Command Window');





% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(deviatoric_stress_tensor);


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
