function varargout = nm_mdof_modal_arbitrary_force(varargin)
% NM_MDOF_MODAL_ARBITRARY_FORCE MATLAB code for nm_mdof_modal_arbitrary_force.fig
%      NM_MDOF_MODAL_ARBITRARY_FORCE, by itself, creates a new NM_MDOF_MODAL_ARBITRARY_FORCE or raises the existing
%      singleton*.
%
%      H = NM_MDOF_MODAL_ARBITRARY_FORCE returns the handle to a new NM_MDOF_MODAL_ARBITRARY_FORCE or the handle to
%      the existing singleton*.
%
%      NM_MDOF_MODAL_ARBITRARY_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NM_MDOF_MODAL_ARBITRARY_FORCE.M with the given input arguments.
%
%      NM_MDOF_MODAL_ARBITRARY_FORCE('Property','Value',...) creates a new NM_MDOF_MODAL_ARBITRARY_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nm_mdof_modal_arbitrary_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nm_mdof_modal_arbitrary_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nm_mdof_modal_arbitrary_force

% Last Modified by GUIDE v2.5 11-Nov-2016 13:30:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nm_mdof_modal_arbitrary_force_OpeningFcn, ...
                   'gui_OutputFcn',  @nm_mdof_modal_arbitrary_force_OutputFcn, ...
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


% --- Executes just before nm_mdof_modal_arbitrary_force is made visible.
function nm_mdof_modal_arbitrary_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nm_mdof_modal_arbitrary_force (see VARARGIN)

% Choose default command line output for nm_mdof_modal_arbitrary_force
handles.output = hObject;

set(handles.listbox_damping,'Value',2);

listbox_damping_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nm_mdof_modal_arbitrary_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nm_mdof_modal_arbitrary_force_OutputFcn(hObject, eventdata, handles) 
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

iu=get(handles.listbox_units,'value');


FS=get(handles.edit_mass,'String');
M=evalin('base',FS); 

FS=get(handles.edit_stiffness,'String');
K=evalin('base',FS); 

FS=get(handles.edit_force,'String');
F=evalin('base',FS); 



if(isempty(M))
   warndlg('enter mass array'); 
   return; 
end  
if(isempty(K))
   warndlg('enter stiffness array'); 
   return; 
end 
if(isempty(F))
   warndlg('enter force array'); 
   return; 
end 

if(iu==2)
    M=M/386;
end

szM=size(M);
szK=size(K);
szF=size(F);

num_force_col=szF(2)-1;

NT=szF(1);

sys_dof=szM(1);

if(num_force_col ~= sys_dof)
   warndlg('number of force dof not equal to number of system dof'); 
   return; 
end    

ndof=sys_dof;

dur=F(NT,1)-F(1,1);

dt=dur/(NT-1);

out1=sprintf(' NT=%d  dur=%8.4g sec  dt=%8.4g sec',NT,dur,dt);
disp(out1);

%
disp(' ');
[fn,omegan,ModeShapes,MST]=Generalized_Eigen(K,M,1);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=F(:,1);

FF=F(:,2:ndof+1);

%%

ndamp=get(handles.listbox_damping,'Value');

if(ndamp==1)

    FS=get(handles.edit_damping_coefficient,'String');
    C=evalin('base',FS);     

    if(isempty(C))
        warndlg('enter damping coefficient'); 
        return; 
    end    
    
else
    
    damp=str2num(get(handles.edit_damping_ratio,'String'));   
    dampv=ones(ndof,1)*damp;

    C=zeros(ndof,ndof);

    for i=1:ndof
        C(i,i)=2*dampv(i)*omegan(i);
    end

    C=M*ModeShapes*C*MST*M;   
   
end


DI=zeros(ndof,1);
VI=zeros(ndof,1);

[U,Ud,Udd]=Newmark_force_mdof(DI,VI,dt,NT,ndof,M,C,K,FF);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
x=U';
y=Ud';
accel=Udd';
v=y;

mdof_plot_legend_3iu(t,x,v,accel,ndof,iu);

%%% leave after mdof_plot

clear acceleration;
clear velocity;
clear displacement;
%
if(iu<=2)
    accel=accel/386;
end
%
acceleration=[t accel];
velocity=[t v];
displacement=[t x];



setappdata(0,'acceleration',acceleration);
setappdata(0,'velocity',velocity);
setappdata(0,'displacement',displacement);



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(ri_mdof_modal_arbitrary_force);


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



function edit_damping_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damping_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damping_ratio as text
%        str2double(get(hObject,'String')) returns contents of edit_damping_ratio as a double


% --- Executes during object creation, after setting all properties.
function edit_damping_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_modes as text
%        str2double(get(hObject,'String')) returns contents of edit_num_modes as a double


% --- Executes during object creation, after setting all properties.
function edit_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_force_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force as text
%        str2double(get(hObject,'String')) returns contents of edit_force as a double


% --- Executes during object creation, after setting all properties.
function edit_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force (see GCBO)
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
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
end


output_array=get(handles.edit_output_array,'String');
assignin('base', output_array, data);

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


% --- Executes on selection change in listbox_damping.
function listbox_damping_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_damping contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_damping

n=get(handles.listbox_damping,'Value');

set(handles.text_damping_coefficient,'Visible','off');
set(handles.edit_damping_coefficient,'Visible','off'); 
set(handles.text_damping_ratio,'Visible','off');
set(handles.edit_damping_ratio,'Visible','off');    

if(n==1)
    set(handles.text_damping_coefficient,'Visible','on');
    set(handles.edit_damping_coefficient,'Visible','on');  
else  
    set(handles.text_damping_ratio,'Visible','on');
    set(handles.edit_damping_ratio,'Visible','on');
end



% --- Executes during object creation, after setting all properties.
function listbox_damping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_damping_coefficient_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damping_coefficient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damping_coefficient as text
%        str2double(get(hObject,'String')) returns contents of edit_damping_coefficient as a double


% --- Executes during object creation, after setting all properties.
function edit_damping_coefficient_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping_coefficient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
