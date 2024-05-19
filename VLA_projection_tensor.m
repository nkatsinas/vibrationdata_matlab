function varargout = VLA_projection_tensor(varargin)
% VLA_PROJECTION_TENSOR MATLAB code for VLA_projection_tensor.fig
%      VLA_PROJECTION_TENSOR, by itself, creates a new VLA_PROJECTION_TENSOR or raises the existing
%      singleton*.
%
%      H = VLA_PROJECTION_TENSOR returns the handle to a new VLA_PROJECTION_TENSOR or the handle to
%      the existing singleton*.
%
%      VLA_PROJECTION_TENSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VLA_PROJECTION_TENSOR.M with the given input arguments.
%
%      VLA_PROJECTION_TENSOR('Property','Value',...) creates a new VLA_PROJECTION_TENSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VLA_projection_tensor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VLA_projection_tensor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VLA_projection_tensor

% Last Modified by GUIDE v2.5 10-Jan-2015 14:29:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VLA_projection_tensor_OpeningFcn, ...
                   'gui_OutputFcn',  @VLA_projection_tensor_OutputFcn, ...
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


% --- Executes just before VLA_projection_tensor is made visible.
function VLA_projection_tensor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VLA_projection_tensor (see VARARGIN)

% Choose default command line output for VLA_projection_tensor
handles.output = hObject;


set(handles.pushbutton_multiply,'Visible','off');
set(handles.text_v,'Visible','off');
set(handles.edit_v,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VLA_projection_tensor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VLA_projection_tensor_OutputFcn(hObject, eventdata, handles) 
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

delete(VLA_projection_tensor);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_n,'String');
    n=evalin('base',FS);
catch
    warndlg('Vector does not exist');
    return;    
end

n=n/norm(n);

n=fix_size(n);

nn=n*n';

I=eye(3);

disp(' ');
disp(' Projection Tensor ');

PT=I-nn


setappdata(0,'PT',PT);


disp(' ');
disp(' Projection Tensor saved as PT ');

assignin('base', 'PT', PT);

msgbox('Results written to Comnand Window ');

set(handles.pushbutton_multiply,'Visible','on');
set(handles.text_v,'Visible','on');
set(handles.edit_v,'Visible','on');    


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


% --- Executes on button press in pushbutton_multiply.
function pushbutton_multiply_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_multiply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_v,'String');
    v=evalin('base',FS);
catch
    warndlg('Vector does not exist');
    return;    
end

PT=getappdata(0,'PT');

v=fix_size(v);

disp(' ');
disp(' Projected vector ');

Pv=PT*v

disp(' ');
disp(' Projected vector saved as Pv ');
assignin('base', 'Pv', Pv);

msgbox('Results written to Comnand Window ');




function edit_v_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v as text
%        str2double(get(hObject,'String')) returns contents of edit_v as a double


% --- Executes during object creation, after setting all properties.
function edit_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
