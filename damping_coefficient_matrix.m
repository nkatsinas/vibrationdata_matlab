function varargout = damping_coefficient_matrix(varargin)
% DAMPING_COEFFICIENT_MATRIX MATLAB code for damping_coefficient_matrix.fig
%      DAMPING_COEFFICIENT_MATRIX, by itself, creates a new DAMPING_COEFFICIENT_MATRIX or raises the existing
%      singleton*.
%
%      H = DAMPING_COEFFICIENT_MATRIX returns the handle to a new DAMPING_COEFFICIENT_MATRIX or the handle to
%      the existing singleton*.
%
%      DAMPING_COEFFICIENT_MATRIX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DAMPING_COEFFICIENT_MATRIX.M with the given input arguments.
%
%      DAMPING_COEFFICIENT_MATRIX('Property','Value',...) creates a new DAMPING_COEFFICIENT_MATRIX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before damping_coefficient_matrix_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to damping_coefficient_matrix_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help damping_coefficient_matrix

% Last Modified by GUIDE v2.5 21-Aug-2014 16:43:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @damping_coefficient_matrix_OpeningFcn, ...
                   'gui_OutputFcn',  @damping_coefficient_matrix_OutputFcn, ...
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


% --- Executes just before damping_coefficient_matrix is made visible.
function damping_coefficient_matrix_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to damping_coefficient_matrix (see VARARGIN)

% Choose default command line output for damping_coefficient_matrix
handles.output = hObject;

set(handles.uipanel_save,'visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes damping_coefficient_matrix wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = damping_coefficient_matrix_OutputFcn(hObject, eventdata, handles) 
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
delete(damping_coefficient_matrix);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  

%%%

FS=get(handles.edit_mass,'String');
mass=evalin('base',FS); 
   
FS=get(handles.edit_stiffness,'String');
stiffness=evalin('base',FS); 



[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);
%
disp('         Natural      ');
disp('Mode   Frequency(Hz)  ');
%    
mmm=MST*mass*ModeShapes;   
%
clear length;
dof=length(fn);

if(dof<1)
    msgbox('Error:  dof=0');    
    return;
end    

%
%%%
%
    
msgbox('Results written to Matlab Command Window');
    
for i=1:dof
    out1 = sprintf('%d  %10.4g ',i,fn(i) );
    disp(out1);
end

if(dof<50) 
    ModeShapes
end
    
fn=fix_size(fn);
    
           
%%%

n=get(handles.listbox_Q,'Value');
m=get(handles.listbox_uniform,'Value');


if(m==1) % uniform
%
    damp=str2num(get(handles.edit_enter_damping,'String')); 
%
    if(n==1) % Q
        Q=str2num(get(handles.edit_enter_damping,'String'));
        damp=1/(2*Q); 
    end
%
    dampv=damp*ones(dof,1);
%
else  % varies by mode
%
    FS=get(handles.edit_enter_damping,'String');
    dampv=evalin('base',FS); 

%
    if(n==1) % Q
        for i=1:dof
            dampv(i)=1/(2*dampv(i));
        end       
    end   
%       
end 
%

disp(' ');
%
C=zeros(dof,dof);
%
%
for i=1:dof
    C(i,i)=2*dampv(i)*omega(i);
end
%
C=mass*ModeShapes*C*MST*mass;

if(dof<50)
    C
end

setappdata(0,'fn',fn);
setappdata(0,'ModeShapes',ModeShapes); 
setappdata(0,'C_matrix',C); 

%
set(handles.uipanel_save,'visible','on');


function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'C_matrix');
end
if(n==2)
    data=getappdata(0,'fn');
end
if(n==3)
    data=getappdata(0,'ModeShapes');  
end

output_name=get(handles.edit_output_array_name,'String');
assignin('base',output_name,data);

h = msgbox('Save Complete');


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_enter_damping_Callback(hObject, eventdata, handles)
% hObject    handle to edit_enter_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_enter_damping as text
%        str2double(get(hObject,'String')) returns contents of edit_enter_damping as a double


% --- Executes during object creation, after setting all properties.
function edit_enter_damping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_enter_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_Q.
function listbox_Q_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_Q contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_Q

change_damping(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function listbox_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function change_damping(hObject, eventdata, handles)
%
n=get(handles.listbox_Q,'Value');
m=get(handles.listbox_uniform,'Value');


if(m==1) % uniform
%    
    if(n==1) % Q
        set(handles.text_damping,'String','Uniform Q');
    else     % viscous damping ratio
        set(handles.text_damping,'String','Uniform Damping Ratio');    
    end
%    
else  % varies by mode
%    
    if(n==1) % Q
        set(handles.text_damping,'String','Q Vector Name');
    else     % viscous damping ratio
        set(handles.text_damping,'String','Damping Ratio Vector Name');    
    end
%       
end    






% --- Executes on selection change in listbox_uniform.
function listbox_uniform_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_uniform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_uniform contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_uniform

change_damping(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_uniform_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_uniform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
