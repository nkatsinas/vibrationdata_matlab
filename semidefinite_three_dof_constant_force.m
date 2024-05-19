function varargout = semidefinite_three_dof_constant_force(varargin)
%SEMIDEFINITE_THREE_DOF_CONSTANT_FORCE M-file for semidefinite_three_dof_constant_force.fig
%      SEMIDEFINITE_THREE_DOF_CONSTANT_FORCE, by itself, creates a new SEMIDEFINITE_THREE_DOF_CONSTANT_FORCE or raises the existing
%      singleton*.
%
%      H = SEMIDEFINITE_THREE_DOF_CONSTANT_FORCE returns the handle to a new SEMIDEFINITE_THREE_DOF_CONSTANT_FORCE or the handle to
%      the existing singleton*.
%
%      SEMIDEFINITE_THREE_DOF_CONSTANT_FORCE('Property','Value',...) creates a new SEMIDEFINITE_THREE_DOF_CONSTANT_FORCE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to semidefinite_three_dof_constant_force_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SEMIDEFINITE_THREE_DOF_CONSTANT_FORCE('CALLBACK') and SEMIDEFINITE_THREE_DOF_CONSTANT_FORCE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SEMIDEFINITE_THREE_DOF_CONSTANT_FORCE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help semidefinite_three_dof_constant_force

% Last Modified by GUIDE v2.5 07-Aug-2017 18:05:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @semidefinite_three_dof_constant_force_OpeningFcn, ...
                   'gui_OutputFcn',  @semidefinite_three_dof_constant_force_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before semidefinite_three_dof_constant_force is made visible.
function semidefinite_three_dof_constant_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for semidefinite_three_dof_constant_force
handles.output = hObject;

iu=getappdata(0,'iu');

if(iu==1)
   set(handles.text_force,'String','Force (lbf)'); 
else
   set(handles.text_force,'String','Force (N)');     
end



fstr='semidefinite_three_dof_force.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
 
pos1 = getpixelposition(handles.pushbutton_return,true);
pos2 = getpixelposition(handles.uipanel_enter_data,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos2(2) w h]);
axis off;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes semidefinite_three_dof_constant_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = semidefinite_three_dof_constant_force_OutputFcn(hObject, eventdata, handles)
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

delete(semidefinite_three_dof_constant_force);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * ');
disp('  ');



cn=get(handles.listbox_cn,'Value');
    
       mass=getappdata(0,'mass');
  stiffness=getappdata(0,'stiffness');      
        iu=getappdata(0,'unit');

        k1=getappdata(0,'k1');
        k2=getappdata(0,'k2');        
        
f1=str2num(get(handles.edit_force_1,'String'));

f2=str2num(get(handles.edit_force_2,'String'));

f3=str2num(get(handles.edit_force_3,'String'));

force=[f1 ; f2; f3]


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    cdof=cn;

   [Ge]=three_dof_semidefinite_Ge(mass,stiffness,cdof);    

    force=fix_size(force);
    x=Ge*force;

    if(iu==2)
        x=x*1000; 
    end
    
    disp(' ');
    
    if(iu==1);
        disp(' Displacement Vector (in)');        
    else
        disp(' Displacement Vector (mm)'); 
    end

    out1=sprintf('  x1  %8.4g \n  x2  %8.4g \n  x3  %8.4g ',x(1),x(2),x(3));
    disp(out1);

    disp(' ');
    
    if(iu==1);
        disp(' Relative Displacements (in)');        
    else
        disp(' Relative Displacements (mm)'); 
    end
    
    x21=x(2)-x(1);
    x31=x(3)-x(1);
    x32=x(3)-x(2);

    out1=sprintf('  x2-x1  %8.4g \n  x3-x1  %8.4g \n  x3-x2  %8.4g ',x21,x31,x32);
    disp(out1);

    disp(' ');
    
    if(iu==1);
        disp(' Spring Force (lbf)');        
    else
        disp(' Spring Force (N)'); 
    end    
    
    
    out1=sprintf('  spring 1  %8.4g \n  spring 2  %8.4g  ',k1*x21,k2*x32);
    disp(out1);
    
msgbox('Calculation complete.  Results written to Command Window');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes during object creation, after setting all properties.
function uipanel_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'rd');
end
if(n==2)
    data=getappdata(0,'dd');
end
if(n==3)
    data=getappdata(0,'v');
end
if(n==4)
    data=getappdata(0,'acc');
end

output_array=get(handles.edit_output_array,'String');
assignin('base', output_array, data);

%

output_array_1=sprintf('%s_1',output_array);
output_array_2=sprintf('%s_2',output_array);

assignin('base', output_array_1, [data(:,1) data(:,2)] );
assignin('base', output_array_2, [data(:,1) data(:,3)] );

%

h = msgbox('Save Complete'); 

disp(' ');
disp(output_array);
disp(output_array_1);
disp(output_array_2);


function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% --- Executes on selection change in listbox_dof.
function listbox_dof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dof

iu=getappdata(0,'unit');

n=get(handles.listbox_dof,'Value');

if(n<=2)
   if(iu==1)
        ss='The input array must have two columns:  time (sec) & force (lbf)';
   else
        ss='The input array must have two columns:  time (sec) & force (N)';
   end
end
if(n==3)
   if(iu==1)
        ss='The input array must have threes columns:  time (sec) & force 1 & force 2 (lbf)';  
   else
        ss='The input array must have threes columns:  time (sec) & force 1 & force 2 (N)';        
   end
end

set(handles.text_force,'String',ss);


% --- Executes during object creation, after setting all properties.
function listbox_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_IR.
function listbox_IR_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_IR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_IR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_IR


% --- Executes during object creation, after setting all properties.
function listbox_IR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_IR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_force_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_force_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_force_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_force_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_force_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_force_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_cn.
function listbox_cn_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cn contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cn


% --- Executes during object creation, after setting all properties.
function listbox_cn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_force_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_force_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_force_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
