function varargout = tensor_coordinate_frame_transformation(varargin)
% TENSOR_COORDINATE_FRAME_TRANSFORMATION MATLAB code for tensor_coordinate_frame_transformation.fig
%      TENSOR_COORDINATE_FRAME_TRANSFORMATION, by itself, creates a new TENSOR_COORDINATE_FRAME_TRANSFORMATION or raises the existing
%      singleton*.
%
%      H = TENSOR_COORDINATE_FRAME_TRANSFORMATION returns the handle to a new TENSOR_COORDINATE_FRAME_TRANSFORMATION or the handle to
%      the existing singleton*.
%
%      TENSOR_COORDINATE_FRAME_TRANSFORMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TENSOR_COORDINATE_FRAME_TRANSFORMATION.M with the given input arguments.
%
%      TENSOR_COORDINATE_FRAME_TRANSFORMATION('Property','Value',...) creates a new TENSOR_COORDINATE_FRAME_TRANSFORMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tensor_coordinate_frame_transformation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tensor_coordinate_frame_transformation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tensor_coordinate_frame_transformation

% Last Modified by GUIDE v2.5 10-Mar-2015 15:26:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tensor_coordinate_frame_transformation_OpeningFcn, ...
                   'gui_OutputFcn',  @tensor_coordinate_frame_transformation_OutputFcn, ...
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


% --- Executes just before tensor_coordinate_frame_transformation is made visible.
function tensor_coordinate_frame_transformation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tensor_coordinate_frame_transformation (see VARARGIN)

% Choose default command line output for tensor_coordinate_frame_transformation
handles.output = hObject;

listbox_number_Callback(hObject, eventdata, handles);
listbox_units_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tensor_coordinate_frame_transformation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tensor_coordinate_frame_transformation_OutputFcn(hObject, eventdata, handles) 
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

delete(tensor_coordinate_frame_transformation);


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

if(nc~=3)
    warndlg(' Input array must have three columns. ');
    return;
end

if(nr~=3)
    warndlg(' Input array must have three rows. ');
    return;    
end


nu=get(handles.listbox_units,'Value');

%%%%%%%%%%

n=get(handles.listbox_number,'Value');


for i=1:n

    temp=A;

    if(i==1)
        mr=get(handles.listbox_r1,'Value');
        theta=str2num(get(handles.edit_theta1,'String'));
        dir=get(handles.listbox_dir1,'Value');
    end
    if(i==2)
        mr=get(handles.listbox_r2,'Value');
        theta=str2num(get(handles.edit_theta2,'String'));
        dir=get(handles.listbox_dir2,'Value');        
    end
    if(i==3)
        mr=get(handles.listbox_r3,'Value');
        theta=str2num(get(handles.edit_theta3,'String'));
        dir=get(handles.listbox_dir3,'Value');        
    end    

    if(nu==1)
        theta=theta*pi/180;
    end
    
    if(dir==1)
        theta=-theta;
    end

    c=cos(theta);
    s=sin(theta);
    
        
    if(mr==1)
        T=[ 1  0 0; 0 c s;  0 -s c ]        
    end
    if(mr==2)
        T=[ c  0 -s; 0 1 0; s  0 c ]        
    end
    if(mr==3)
        T=[ c s 0; -s c 0;  0  0 1 ]           
    end    
    
    A=T*temp*T';
    
end


disp(' ');
disp(' Transformed tensor name:  transformed_tensor');

assignin('base','transformed_tensor', A);

msgbox('Results written to Matlab Command Window');




% --- Executes on selection change in listbox_r1.
function listbox_r1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_r1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_r1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_r1


% --- Executes during object creation, after setting all properties.
function listbox_r1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_r1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta1 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta1 as a double


% --- Executes during object creation, after setting all properties.
function edit_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_r2.
function listbox_r2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_r2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_r2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_r2


% --- Executes during object creation, after setting all properties.
function listbox_r2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_r2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_r3.
function listbox_r3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_r3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_r3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_r3


% --- Executes during object creation, after setting all properties.
function listbox_r3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_r3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta2 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta2 as a double


% --- Executes during object creation, after setting all properties.
function edit_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta3 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta3 as a double


% --- Executes during object creation, after setting all properties.
function edit_theta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_dir1.
function listbox_dir1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dir1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dir1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dir1


% --- Executes during object creation, after setting all properties.
function listbox_dir1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dir1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_dir2.
function listbox_dir2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dir2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dir2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dir2


% --- Executes during object creation, after setting all properties.
function listbox_dir2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dir2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_dir3.
function listbox_dir3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dir3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dir3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dir3


% --- Executes during object creation, after setting all properties.
function listbox_dir3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dir3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
n=get(handles.listbox_units,'Value');

if(n==1)
    set(handles.text_angle,'String','CCW Angle (deg)');
else
    set(handles.text_angle,'String','CCW Angle (rad)');    
end

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


% --- Executes on selection change in listbox_number.
function listbox_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_number
n=get(handles.listbox_number,'Value');


set(handles.text_r2,'Visible','off');
set(handles.listbox_r2,'Visible','off');
set(handles.edit_theta2,'Visible','off');
set(handles.listbox_dir2,'Visible','off');

set(handles.text_r3,'Visible','off');
set(handles.listbox_r3,'Visible','off');
set(handles.edit_theta3,'Visible','off');
set(handles.listbox_dir3,'Visible','off');

if(n>=2)
    
    set(handles.text_r2,'Visible','on');
    set(handles.listbox_r2,'Visible','on');
    set(handles.edit_theta2,'Visible','on');    
    set(handles.listbox_dir2,'Visible','on');

end
if(n==3)

    set(handles.text_r3,'Visible','on');
    set(handles.listbox_r3,'Visible','on');
    set(handles.edit_theta3,'Visible','on');      
    set(handles.listbox_dir3,'Visible','on');
    
end


% --- Executes during object creation, after setting all properties.
function listbox_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
