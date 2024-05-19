function varargout = VLA_2D_transformation(varargin)
% VLA_2D_TRANSFORMATION MATLAB code for VLA_2D_transformation.fig
%      VLA_2D_TRANSFORMATION, by itself, creates a new VLA_2D_TRANSFORMATION or raises the existing
%      singleton*.
%
%      H = VLA_2D_TRANSFORMATION returns the handle to a new VLA_2D_TRANSFORMATION or the handle to
%      the existing singleton*.
%
%      VLA_2D_TRANSFORMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VLA_2D_TRANSFORMATION.M with the given input arguments.
%
%      VLA_2D_TRANSFORMATION('Property','Value',...) creates a new VLA_2D_TRANSFORMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VLA_2D_transformation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VLA_2D_transformation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VLA_2D_transformation

% Last Modified by GUIDE v2.5 29-Dec-2014 16:42:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VLA_2D_transformation_OpeningFcn, ...
                   'gui_OutputFcn',  @VLA_2D_transformation_OutputFcn, ...
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


% --- Executes just before VLA_2D_transformation is made visible.
function VLA_2D_transformation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VLA_2D_transformation (see VARARGIN)

% Choose default command line output for VLA_2D_transformation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VLA_2D_transformation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VLA_2D_transformation_OutputFcn(hObject, eventdata, handles) 
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

delete(VLA_2D_transformation);



function edit_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    FS=get(handles.edit_array_name,'String');
    A=evalin('base',FS); 
catch
    warndlg('Input array does not exist');
    return;
end

A=fix_size(A);

sz=size(A);

nr=sz(1);
nc=sz(2);

if(nc~=1)
    warndlg(' Input vector must have one column. ');
    return;
end

if(nr==2 || nr==3)
else
    warndlg(' Input vector must have either two or three rows. ');
    return;    
end

theta=str2num(get(handles.edit_theta,'String'));


n=get(handles.listbox_units,'Value');

if(n==1)
    theta=theta*pi/180;
end

c=cos(theta);
s=sin(theta);


if(nr==2)
    T=[ c s  ; -s  c  ];
else
    T=[ c s  0; -s  c 0; 0 0 1 ];  
end    

disp(' Input Vector ');
A

disp(' Transformation Array ');
T

disp(' Output Vector ');
B=T*A

msgbox('Results written to Matlab Command Window');


function edit_theta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta as text
%        str2double(get(hObject,'String')) returns contents of edit_theta as a double


% --- Executes during object creation, after setting all properties.
function edit_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
