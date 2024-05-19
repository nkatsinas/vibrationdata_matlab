function varargout = VLA_one_vector(varargin)
% VLA_ONE_VECTOR MATLAB code for VLA_one_vector.fig
%      VLA_ONE_VECTOR, by itself, creates a new VLA_ONE_VECTOR or raises the existing
%      singleton*.
%
%      H = VLA_ONE_VECTOR returns the handle to a new VLA_ONE_VECTOR or the handle to
%      the existing singleton*.
%
%      VLA_ONE_VECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VLA_ONE_VECTOR.M with the given input arguments.
%
%      VLA_ONE_VECTOR('Property','Value',...) creates a new VLA_ONE_VECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VLA_one_vector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VLA_one_vector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VLA_one_vector

% Last Modified by GUIDE v2.5 10-Jan-2015 15:25:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VLA_one_vector_OpeningFcn, ...
                   'gui_OutputFcn',  @VLA_one_vector_OutputFcn, ...
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


% --- Executes just before VLA_one_vector is made visible.
function VLA_one_vector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VLA_one_vector (see VARARGIN)

% Choose default command line output for VLA_one_vector
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VLA_one_vector wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VLA_one_vector_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_v,'String');
    v=evalin('base',FS);
catch
    warndlg('Vector does not exist');
    return;    
end

v=fix_size(v);

sz=size(v);

if(sz(1) ~=3 )
    warndlg('Vector must have three rows');
    return;     
end

if(sz(2) ~=1 )
    warndlg('Vector must have one column');
    return;     
end


disp(' ');


N=norm(v);

out1=sprintf(' norm = %8.4g',N);
disp(out1)

cos_theta=zeros(3,1);
theta_rad=zeros(3,1);
theta_deg=zeros(3,1);


disp(' ');


n=3;

for i=1:n
   cos_theta(i)=v(i)/N;   
   out1=sprintf(' cos( theta %d )= %8.4g',i,cos_theta(i));
   disp(out1);
end

disp(' ');

for i=1:n
   theta_rad(i)=acos(cos_theta(i));   
   out1=sprintf(' theta %d = %8.4g rad',i,theta_rad(i));
   disp(out1);   
end


disp(' ');


for i=1:n
   theta_deg(i)=theta_rad(i)*180/pi;   
   out1=sprintf(' theta %d = %8.4g deg',i,theta_deg(i));
   disp(out1);      
end




msgbox(' Results written to Command Window ');



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


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
