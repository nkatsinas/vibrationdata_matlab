function varargout = vibrationdata_linear_algebra(varargin)
% VIBRATIONDATA_LINEAR_ALGEBRA MATLAB code for vibrationdata_linear_algebra.fig
%      VIBRATIONDATA_LINEAR_ALGEBRA, by itself, creates a new VIBRATIONDATA_LINEAR_ALGEBRA or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_LINEAR_ALGEBRA returns the handle to a new VIBRATIONDATA_LINEAR_ALGEBRA or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_LINEAR_ALGEBRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_LINEAR_ALGEBRA.M with the given input arguments.
%
%      VIBRATIONDATA_LINEAR_ALGEBRA('Property','Value',...) creates a new VIBRATIONDATA_LINEAR_ALGEBRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_linear_algebra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_linear_algebra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_linear_algebra

% Last Modified by GUIDE v2.5 05-Dec-2014 16:22:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_linear_algebra_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_linear_algebra_OutputFcn, ...
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


% --- Executes just before vibrationdata_linear_algebra is made visible.
function vibrationdata_linear_algebra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_linear_algebra (see VARARGIN)

% Choose default command line output for vibrationdata_linear_algebra
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_linear_algebra wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_linear_algebra_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_tv.
function listbox_tv_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_tv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_tv contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_tv


% --- Executes during object creation, after setting all properties.
function listbox_tv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_tv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_tv,'Value');

m=1;
if(n==m)
    handles.s= VLA_one_vector;
end
m=m+1;

if(n==m)
    handles.s= VLA_two_vectors;       
end
m=m+1; 

if(n==m)
    handles.s= VLA_three_vectors;    
end
m=m+1;

if(n==m)
    handles.s= VLA_one_array;    
end    
m=m+1;

if(n==m)
    handles.s= VLA_array_two_columns;    
end
m=m+1;

if(n==m)
    handles.s= VLA_Ax_b;    
end    
m=m+1;

if(n==m)
    handles.s= mass_stiffness_matrices;   
end   
m=m+1; 

if(n==m)
    handles.s= VLA_2D_transformation; 
end
m=m+1;        

if(n==m)
    handles.s= VLA_3D_transformation;  
end   
m=m+1;

if(n==m)
    handles.s= VLA_unit_vector_normal_plane;    
end 
m=m+1;

if(n==m)
    handles.s= VLA_tensor;    
end 
m=m+1;

if(n==m)
    handles.s= VLA_projection_tensor;     
end 
m=m+1;

if(n==m)
    handles.s= VLA_two_tensors;     
end 
m=m+1;

set(handles.s,'Visible','on'); 



% --- Executes on selection change in listbox_array.
function listbox_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_array


% --- Executes during object creation, after setting all properties.
function listbox_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_array.
function pushbutton_array_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_tv.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_tv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_tv contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_tv


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_tv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
