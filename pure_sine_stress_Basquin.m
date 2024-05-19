function varargout = pure_sine_stress_Basquin(varargin)
% PURE_SINE_STRESS_BASQUIN MATLAB code for pure_sine_stress_Basquin.fig
%      PURE_SINE_STRESS_BASQUIN, by itself, creates a new PURE_SINE_STRESS_BASQUIN or raises the existing
%      singleton*.
%
%      H = PURE_SINE_STRESS_BASQUIN returns the handle to a new PURE_SINE_STRESS_BASQUIN or the handle to
%      the existing singleton*.
%
%      PURE_SINE_STRESS_BASQUIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PURE_SINE_STRESS_BASQUIN.M with the given input arguments.
%
%      PURE_SINE_STRESS_BASQUIN('Property','Value',...) creates a new PURE_SINE_STRESS_BASQUIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pure_sine_stress_Basquin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pure_sine_stress_Basquin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pure_sine_stress_Basquin

% Last Modified by GUIDE v2.5 12-May-2017 15:59:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pure_sine_stress_Basquin_OpeningFcn, ...
                   'gui_OutputFcn',  @pure_sine_stress_Basquin_OutputFcn, ...
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


% --- Executes just before pure_sine_stress_Basquin is made visible.
function pure_sine_stress_Basquin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pure_sine_stress_Basquin (see VARARGIN)

% Choose default command line output for pure_sine_stress_Basquin
handles.output = hObject;


change_unit(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pure_sine_stress_Basquin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change_unit(hObject, eventdata, handles) 
%
n=get(handles.listbox_unit,'Value');
n_mat=get(handles.listbox_material,'Value');


 
mlab='other'; 
 
if(n_mat==1) % aluminum 6061-T6
    m=9.25; 
    mlab='aluminum 6061-T6';
end
if(n_mat==2) % butt-welded steel
    m=3.5;
    mlab='butt-welded steel';
end    
if(n_mat==3) % stainless steel
    m=6.54;
    mlab='stainless steel';
end
 
if(n_mat==4) % Petrucci: aluminum
    m=7.3; 
    mlab='Petrucci: aluminum 2219-T851';
end
if(n_mat==5) % Petrucci: steel
    m=3.324;
    mlab='Petrucci: steel';    
end    
if(n_mat==6) % Petrucci: spring steel
    m=11.760;
    mlab='Petrucci: spring steel';       
end
 
setappdata(0,'mlab',mlab);
 
 
 
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
function varargout = pure_sine_stress_Basquin_OutputFcn(hObject, eventdata, handles) 
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

delete(pure_sine_stress_Basquin);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp('***************************************************');
disp(' ');

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


scf=str2num(get(handles.edit_scf,'String'));

m=str2num(get(handles.edit_m,'String'));
A=str2num(get(handles.edit_A,'String'));

tau=str2num(get(handles.edit_duration,'String'));
freq=str2num(get(handles.edit_freq,'String'));

stress=str2num(get(handles.edit_stress,'String'));

nc=freq*tau;

Sa=(A/nc)^(1/m);

sss=stress*scf;

damage=(1/A)*nc*(sss^m);

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
out1=sprintf(' Stress concentration factor = %g \n',scf);
disp(out1);

out1=sprintf(' Stress Response x scf  = %g %s  \n',scf*stress,su);
disp(out1);

out1=sprintf(' Stress Limit  = %g %s  for %8.4g cycles \n',Sa,su,nc);
disp(out1);



out1=sprintf(' Miners Cumulative Damage = %8.3g \n',damage);
disp(out1);

out1=sprintf(' Damage Rate = %8.4g per sec\n',damage/tau);
disp(out1);


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



function edit_scf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scf as text
%        str2double(get(hObject,'String')) returns contents of edit_scf as a double


% --- Executes during object creation, after setting all properties.
function edit_scf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scf (see GCBO)
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



function edit_stress_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress as text
%        str2double(get(hObject,'String')) returns contents of edit_stress as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
