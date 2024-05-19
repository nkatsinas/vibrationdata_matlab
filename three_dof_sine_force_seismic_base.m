function varargout = three_dof_sine_force_seismic_base(varargin)
% THREE_DOF_SINE_FORCE_SEISMIC_BASE MATLAB code for three_dof_sine_force_seismic_base.fig
%      THREE_DOF_SINE_FORCE_SEISMIC_BASE, by itself, creates a new THREE_DOF_SINE_FORCE_SEISMIC_BASE or raises the existing
%      singleton*.
%
%      H = THREE_DOF_SINE_FORCE_SEISMIC_BASE returns the handle to a new THREE_DOF_SINE_FORCE_SEISMIC_BASE or the handle to
%      the existing singleton*.
%
%      THREE_DOF_SINE_FORCE_SEISMIC_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THREE_DOF_SINE_FORCE_SEISMIC_BASE.M with the given input arguments.
%
%      THREE_DOF_SINE_FORCE_SEISMIC_BASE('Property','Value',...) creates a new THREE_DOF_SINE_FORCE_SEISMIC_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before three_dof_sine_force_seismic_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to three_dof_sine_force_seismic_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help three_dof_sine_force_seismic_base

% Last Modified by GUIDE v2.5 03-Jan-2017 14:36:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @three_dof_sine_force_seismic_base_OpeningFcn, ...
                   'gui_OutputFcn',  @three_dof_sine_force_seismic_base_OutputFcn, ...
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


% --- Executes just before three_dof_sine_force_seismic_base is made visible.
function three_dof_sine_force_seismic_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to three_dof_sine_force_seismic_base (see VARARGIN)

% Choose default command line output for three_dof_sine_force_seismic_base
handles.output = hObject;



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes three_dof_sine_force_seismic_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = three_dof_sine_force_seismic_base_OutputFcn(hObject, eventdata, handles) 
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

delete(three_dof_sine_force_seismic_base);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

      damp=getappdata(0,'damp_ratio');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        iu=getappdata(0,'unit');
        base_mass=getappdata(0,'base_mass');        
 
freq=str2num(get(handles.edit_freq,'String'));
amp=str2num(get(handles.edit_amp,'String'));



if(iu==1)
    scale=386;
else
    scale=9.81;
end

amp=amp*scale;

force=amp*base_mass;

ndof=length(fn);
nf=length(freq);



omn=zeros(ndof,1);
omn2=zeros(ndof,1);

for i=1:ndof
    omn(i)=tpi*fn(i);
    omn2(i)=omn(i)^2;    
end

omega=zeros(nf,1);
omega2=zeros(nf,1);

for i=1:nf
    omega(i)=tpi*freq(i);
    omega2(i)=omega(i)^2;
end

fnv=fn;
dampv=damp;
        
%
%

QE=ModeShapes;

nrb=0; % leave as is

%%%%%%


h_disp_complex=zeros(ndof,1);

num_columns=ndof;

d_f_mag=zeros(ndof,1);
v_f_mag=zeros(ndof,1);
a_f_mag=zeros(ndof,1);

H_disp_force=zeros(ndof,1);
H_velox_force=zeros(ndof,1);
H_accel_force=zeros(ndof,1);

HM_accel=zeros(ndof,1);
HM_velox=zeros(ndof,1);
HM_disp=zeros(ndof,1);

k=1; % base dof


for i=1:ndof

    iam=3;
    [H_accel_force(i)]=...
    transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
    

    HM_accel(i)=abs(H_accel_force(i)/H_accel_force(1));
    a_f_mag(i)=amp*HM_accel(i);


    v_f_mag(i)= a_f_mag(i)/omega;
    d_f_mag(i)= a_f_mag(i)/omega2;

end    

%%%%%%

a_f_mag=a_f_mag/scale;

% rd21=amp*abs(h_disp_complex(2)-h_disp_complex(1));

disp(' ');
disp(' ');
disp(' ');
out1=sprintf(' Excitation Frequency = %8.4g Hz',freq);
disp(out1);
out1=sprintf('    Base acceleration = %8.4g G',amp/scale);
disp(out1);

if(iu==1)
   out2=sprintf('     Equivalent Force = %8.4g lbf',force);
else
   out2=sprintf('     Equivalent Force = %8.4g N',force);
end

disp(out2);



disp(' ');
disp('   Response  Base Mass   Mass 1   Mass 2 ');  


if(iu==1) 
    out1=sprintf('    Disp(in)  %6.3g   %6.3g   %6.3g',d_f_mag(1),d_f_mag(2),d_f_mag(3));
    out2=sprintf(' Vel(in/sec)  %6.3g   %6.3g   %6.3g',v_f_mag(1),v_f_mag(2),v_f_mag(3));
    out3=sprintf('    Accel(G)  %6.3g   %6.3g   %6.3g',a_f_mag(1),a_f_mag(2),a_f_mag(3));   
else
    
    v_f_mag=v_f_mag*100;
    d_f_mag=d_f_mag*1000;    
   
    out1=sprintf('       Disp(mm)  %6.3g   %6.3g   %6.3g',d_f_mag(1)*1000,d_f_mag(2)*1000,d_f_mag(3)*1000);
    out2=sprintf('    Vel(cm/sec)  %6.3g   %6.3g   %6.3g',v_f_mag(1)*100,v_f_mag(2)*100,v_f_mag(3)*100);
    out3=sprintf('       Accel(G)  %6.3g   %6.3g   %6.3g',a_f_mag(1),a_f_mag(2),a_f_mag(3));    
end

disp(out1);
disp(out2);
disp(out3);
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
