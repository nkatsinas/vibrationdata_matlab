function varargout = normal_shear_stress_constant_out_phase(varargin)
% NORMAL_SHEAR_STRESS_CONSTANT_OUT_PHASE MATLAB code for normal_shear_stress_constant_out_phase.fig
%      NORMAL_SHEAR_STRESS_CONSTANT_OUT_PHASE, by itself, creates a new NORMAL_SHEAR_STRESS_CONSTANT_OUT_PHASE or raises the existing
%      singleton*.
%
%      H = NORMAL_SHEAR_STRESS_CONSTANT_OUT_PHASE returns the handle to a new NORMAL_SHEAR_STRESS_CONSTANT_OUT_PHASE or the handle to
%      the existing singleton*.
%
%      NORMAL_SHEAR_STRESS_CONSTANT_OUT_PHASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NORMAL_SHEAR_STRESS_CONSTANT_OUT_PHASE.M with the given input arguments.
%
%      NORMAL_SHEAR_STRESS_CONSTANT_OUT_PHASE('Property','Value',...) creates a new NORMAL_SHEAR_STRESS_CONSTANT_OUT_PHASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before normal_shear_stress_constant_out_phase_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to normal_shear_stress_constant_out_phase_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help normal_shear_stress_constant_out_phase

% Last Modified by GUIDE v2.5 24-May-2017 14:42:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @normal_shear_stress_constant_out_phase_OpeningFcn, ...
                   'gui_OutputFcn',  @normal_shear_stress_constant_out_phase_OutputFcn, ...
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


% --- Executes just before normal_shear_stress_constant_out_phase is made visible.
function normal_shear_stress_constant_out_phase_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to normal_shear_stress_constant_out_phase (see VARARGIN)

% Choose default command line output for normal_shear_stress_constant_out_phase
handles.output = hObject;


change_unit(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes normal_shear_stress_constant_out_phase wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change_unit(hObject, eventdata, handles) 
%
n=get(handles.listbox_unit,'Value');
n_mat=get(handles.listbox_material,'Value');


 
mlab='other'; 

alpha_NP=-1;
 
if(n_mat==1) % aluminum 6061-T6
    m=9.25; 
    mlab='aluminum 6061-T6';
    alpha_NP=0;
end
if(n_mat==2) % butt-welded steel
    m=3.5;
    mlab='butt-welded steel';
    alpha_NP=1;    
end    
if(n_mat==3) % stainless steel
    m=6.54;
    mlab='stainless steel';
    alpha_NP=1;       
end
 
if(n_mat==4) % Petrucci: aluminum
    m=7.3; 
    mlab='Petrucci: aluminum 2219-T851';
    alpha_NP=0;    
end
if(n_mat==5) % Petrucci: steel
    m=3.324;
    mlab='Petrucci: steel';
    alpha_NP=1;       
end    
if(n_mat==6) % Petrucci: spring steel
    m=11.760;
    mlab='Petrucci: spring steel';
    alpha_NP=1;       
end
 
setappdata(0,'mlab',mlab);
 
if(alpha_NP>=0)
    sss=sprintf('%g',alpha_NP);
else
    sss=' ';
end
set(handles.edit_alpha_NP,'String',sss); 
 

if(n_mat==1)  % aluminum 6061-T6
 
    Aksi=9.7724e+17;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=5.5757e+25;        
    end
    
end
if(n_mat==2)  % butt-welded steel
 
      
    Aksi=1.255e+11;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=1.080e+14;      
    end    
    
end
if(n_mat==3)  % stainless steel
   
    Aksi=1.32E+18;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=4.0224e+23;      
    end        
    
end
if(n_mat==4)  % Petrucci: aluminum
   
    Aksi=5.18E+13;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=6.85E+19;      
    end        
    
end
if(n_mat==5)  % Petrucci: steel
   
    Aksi=3.16E+09;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=1.93E+12;      
    end        
    
end
if(n_mat==6)  % Petrucci: spring steel
   
    Aksi=1.95E+27;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=1.41E+37;      
    end        
    
end
 
 
 
 
if(n_mat<=6)
    ms=sprintf('%g',m);    
    As=sprintf('%8.4g',A);
    
    
    if(n==1)
        ss=sprintf('psi^%g',m);
    end
    if(n==2)
        ss=sprintf('ksi^%g',m);        
    end
    if(n==3)
        ss=sprintf('MPa^%g',m);        
    end
    
else
    ms='';    
    As='';    

    if(n==1)
        ss=sprintf('psi^m');
    end
    if(n==2)
        ss=sprintf('ksi^m');        
    end
    if(n==3)
        ss=sprintf('MPa^m');        
    end
   
end

set(handles.text_unit,'String',ss);
 
set(handles.edit_m,'String',ms);
set(handles.edit_A,'String',As);




% --- Outputs from this function are returned to the command line.
function varargout = normal_shear_stress_constant_out_phase_OutputFcn(hObject, eventdata, handles) 
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

delete(normal_shear_stress_constant_out_phase);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp('***************************************************');
disp(' ');


phase=str2num(get(handles.edit_phase,'String'));
alpha=str2num(get(handles.edit_alpha_NP,'String'));


num=get(handles.listbox_unit,'Value');

if(num==1)
   su='psi';
end
if(num==2)
   su='ksi';
end
if(num==3)
   su='MPa';
end


scf_normal=str2num(get(handles.edit_scf_normal,'String'));
scf_shear=str2num(get(handles.edit_scf_shear,'String'));

m=str2num(get(handles.edit_m,'String'));
A=str2num(get(handles.edit_A,'String'));

tau=str2num(get(handles.edit_duration,'String'));
freq=str2num(get(handles.edit_freq,'String'));

stress_normal=str2num(get(handles.edit_stress_normal,'String'));
stress_shear=str2num(get(handles.edit_stress_shear,'String'));

scale=str2num(get(handles.edit_scale,'String'));
k=scale;


nc=freq*tau;

Se_normal = (A/nc)^(1/m);
Se_shear = Se_normal/k;



out1=sprintf(' Fatigue exponent m = %g ',m);
disp(out1);
out1=sprintf(' Fatigue strength coefficient = %g ',A);
disp(out1);
out1=sprintf(' Frequency = %g Hz \n',freq);
disp(out1);
out1=sprintf(' Duration = %g sec \n',tau);
disp(out1);
out1=sprintf(' Number of Cycles = %g  \n',nc);
disp(out1);
out1=sprintf(' Stress concentration factors: \n    = %g normal \n    = %g shear\n',scf_normal,scf_shear);
disp(out1);



out1=sprintf(' Normal Stress x scf = %g %s   ',stress_normal*scf_normal,su);
disp(out1);
out1=sprintf('  Shear Stress x scf = %g %s   \n',stress_shear*scf_shear,su);
disp(out1);


out1=sprintf(' Normal Stress Limit  = %8.3g %s  for %8.4g cycles ',Se_normal,su,nc);
disp(out1);
out1=sprintf('  Shear Stress Limit  = %8.3g %s   \n',Se_shear,su);
disp(out1);

out1=sprintf('   Stress Limit Ratio = %g \n',k);
disp(out1);

out1=sprintf('   Phase Angle Difference = %g deg\n',phase);
disp(out1);

out1=sprintf('                 alpha NP = %g \n',alpha);
disp(out1);

sigma_a=scf_normal*stress_normal;
  tau_a=scf_shear*stress_shear;
  
sigma_ratio=sigma_a/Se_normal;
  tau_ratio=tau_a/Se_shear;

  
px=sigma_ratio;
py=tau_ratio;
  
term=sin(phase*pi/180);
  
term=abs(term);

e=2*(1+alpha*term); 
  



nnn=100;  
  
dx=1/nnn;  

sigma_ratio=zeros((nnn+1),1);
tau_ratio=zeros((nnn+1),1);

for i=1:(nnn+1);
    
    sigma_ratio(i)=(i-1)*dx;
    tau_ratio(i)=(1-(sigma_ratio(i))^e)^(1/e);
    
end    

disp(' ');

figure(1);

plot(sigma_ratio,tau_ratio,'b');

hold on;

plot(px,py,'o','MarkerEdgeColor',[0,0.5,0.5]); 
plot(px,py,'x','MarkerEdgeColor',[0,0.5,0.5]); 
 
legend( 'Lee','Stress Case');
 
grid on;
xlabel('Normal Stress Ratio');
ylabel('Shear Stress Ratio');
out1=sprintf(' Damage Curve, Fully-Reversed, %g deg out-of-phase \n %g Cycles',phase,nc);
title(out1);
xlim([0 1.2]);
ylim([0 1.2]);

hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


msgbox('Calculation complete. Results written to Command Window.');


function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
change_unit(hObject, eventdata, handles); 


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

change_unit(hObject, eventdata, handles); 


% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_m_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m as text
%        str2double(get(hObject,'String')) returns contents of edit_m as a double


% --- Executes during object creation, after setting all properties.
function edit_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_A_Callback(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_A as text
%        str2double(get(hObject,'String')) returns contents of edit_A as a double


% --- Executes during object creation, after setting all properties.
function edit_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scf_normal_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scf_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scf_normal as text
%        str2double(get(hObject,'String')) returns contents of edit_scf_normal as a double


% --- Executes during object creation, after setting all properties.
function edit_scf_normal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scf_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function edit_stress_normal_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress_normal as text
%        str2double(get(hObject,'String')) returns contents of edit_stress_normal as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_normal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scf_shear_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scf_shear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scf_shear as text
%        str2double(get(hObject,'String')) returns contents of edit_scf_shear as a double


% --- Executes during object creation, after setting all properties.
function edit_scf_shear_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scf_shear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stress_shear_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress_shear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress_shear as text
%        str2double(get(hObject,'String')) returns contents of edit_stress_shear as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_shear_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress_shear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_shear_Callback(hObject, eventdata, handles)
% hObject    handle to edit_shear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_shear as text
%        str2double(get(hObject,'String')) returns contents of edit_shear as a double


% --- Executes during object creation, after setting all properties.
function edit_shear_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_shear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale as text
%        str2double(get(hObject,'String')) returns contents of edit_scale as a double


% --- Executes during object creation, after setting all properties.
function edit_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_alpha_NP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alpha_NP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alpha_NP as text
%        str2double(get(hObject,'String')) returns contents of edit_alpha_NP as a double


% --- Executes during object creation, after setting all properties.
function edit_alpha_NP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha_NP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_phase_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase as text
%        str2double(get(hObject,'String')) returns contents of edit_phase as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
