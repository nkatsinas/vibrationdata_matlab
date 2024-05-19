function varargout = vibrationdata_three_dof_sine_force_seismic_base(varargin)
% VIBRATIONDATA_THREE_DOF_SINE_FORCE_SEISMIC_BASE MATLAB code for vibrationdata_three_dof_sine_force_seismic_base.fig
%      VIBRATIONDATA_THREE_DOF_SINE_FORCE_SEISMIC_BASE, by itself, creates a new VIBRATIONDATA_THREE_DOF_SINE_FORCE_SEISMIC_BASE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_THREE_DOF_SINE_FORCE_SEISMIC_BASE returns the handle to a new VIBRATIONDATA_THREE_DOF_SINE_FORCE_SEISMIC_BASE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_THREE_DOF_SINE_FORCE_SEISMIC_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_THREE_DOF_SINE_FORCE_SEISMIC_BASE.M with the given input arguments.
%
%      VIBRATIONDATA_THREE_DOF_SINE_FORCE_SEISMIC_BASE('Property','Value',...) creates a new VIBRATIONDATA_THREE_DOF_SINE_FORCE_SEISMIC_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_three_dof_sine_force_seismic_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_three_dof_sine_force_seismic_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_three_dof_sine_force_seismic_base

% Last Modified by GUIDE v2.5 03-Jan-2017 14:07:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_three_dof_sine_force_seismic_base_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_three_dof_sine_force_seismic_base_OutputFcn, ...
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


% --- Executes just before vibrationdata_three_dof_sine_force_seismic_base is made visible.
function vibrationdata_three_dof_sine_force_seismic_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_three_dof_sine_force_seismic_base (see VARARGIN)

% Choose default command line output for vibrationdata_three_dof_sine_force_seismic_base
handles.output = hObject;

iu=getappdata(0,'unit');

if(iu==1)
    set(handles.text_base_accel,'String','Force (lbf)');
else
    set(handles.text_base_accel,'String','Force (N)');    
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_three_dof_sine_force_seismic_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_three_dof_sine_force_seismic_base_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_three_dof_sine_force_seismic_base);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        iu=getappdata(0,'unit');
 
freq=str2num(get(handles.edit_freq,'String'));
amp=str2num(get(handles.edit_amp,'String'));
        
%
%

%%%%%%

d_f_mag=zeros(2,1);


h_disp_complex=zeros(2,1);

num_columns=2;

for i=1:2

    iam=1;
    [H_disp_force]=...
    transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
    HM_disp=abs(H_disp_force);
    d_f_mag(i)=amp*HM_disp;
    h_disp_complex(i)=H_disp_force;
      
    iam=2;
    [H_velox_force]=...
    transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
    HM_velox=abs(H_velox_force);
    v_f_mag(i)=amp*HM_velox;

    iam=3;
    [H_accel_force]=...
    transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);

    if(iu==1)
        scale=386;
    else
        scale=9.81;
    end
    
    H_accel_force=H_accel_force/scale;
    

    HM_accel=abs(H_accel_force);
    a_f_mag(i)=amp*HM_accel;
    
end    

%%%%%%

rd21=amp*abs(h_disp_complex(2)-h_disp_complex(1));

disp(' ');
if(iu==1)
    disp(' Response      dof 1   dof 2 ');    
    out1=sprintf('    Disp(in)  %6.3g   %6.3g',d_f_mag(1),d_f_mag(2));
    out2=sprintf(' Vel(in/sec)  %6.3g   %6.3g',v_f_mag(1),v_f_mag(2));
    out3=sprintf('    Accel(G)  %6.3g   %6.3g',a_f_mag(1),a_f_mag(2));   
else
    disp(' Response         dof 1   dof 2 ');    
    out1=sprintf('       Disp(mm)  %6.3g   %6.3g',d_f_mag(1)*1000,d_f_mag(2)*1000);
    out2=sprintf('    Vel(cm/sec)  %6.3g   %6.3g',v_f_mag(1)*100,v_f_mag(2)*100);
    out3=sprintf('       Accel(G)  %6.3g   %6.3g',a_f_mag(1),a_f_mag(2));    
end

disp(out1);
disp(out2);
disp(out3);

disp(' ');
disp(' Relative Displacement (dof 2 - dof 1) ');
if(iu==1)
    out4=sprintf('    Disp(in)  %6.3g',rd21);
else
    out4=sprintf('    Disp(mm)  %6.3g',rd21*1000);    
end

disp(out4);
disp(' ');

msgbox('Results written to Command Window');


% --- Executes on selection change in listbox_force.
function listbox_force_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force


% --- Executes during object creation, after setting all properties.
function listbox_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_amp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amp as text
%        str2double(get(hObject,'String')) returns contents of edit_amp as a double


% --- Executes during object creation, after setting all properties.
function edit_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
