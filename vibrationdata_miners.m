function varargout = vibrationdata_miners(varargin)
% VIBRATIONDATA_MINERS MATLAB code for vibrationdata_miners.fig
%      VIBRATIONDATA_MINERS, by itself, creates a new VIBRATIONDATA_MINERS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_MINERS returns the handle to a new VIBRATIONDATA_MINERS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_MINERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_MINERS.M with the given input arguments.
%
%      VIBRATIONDATA_MINERS('Property','Value',...) creates a new VIBRATIONDATA_MINERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_miners_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_miners_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_miners

% Last Modified by GUIDE v2.5 29-Jun-2015 14:24:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_miners_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_miners_OutputFcn, ...
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


% --- Executes just before vibrationdata_miners is made visible.
function vibrationdata_miners_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_miners (see VARARGIN)

% Choose default command line output for vibrationdata_miners
handles.output = hObject;

change_unit(hObject, eventdata, handles);
listbox_input_format_Callback(hObject, eventdata, handles);
listbox_mean_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_miners wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_miners_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_miners);


function change_unit(hObject, eventdata, handles) 
%
set(handles.edit_damage,'Enable','off','Visible','off');
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


m=get(handles.listbox_mean,'Value');

if(n==1)
%    set(handles.text_mean_stress,'String','Mean Stress (psi)');
    if(m>=2 && m<=3)
        set(handles.text_aux_stress,'String','Ultimate Stress Limit (psi)');
    end
    if(m==4)
        set(handles.text_aux_stress,'String','True Fracture Stress (psi)');    
    end
    if(m==5)
        set(handles.text_aux_stress,'String','Yield Stress Limits (psi)');      
    end
end
if(n==2)
%    set(handles.text_mean_stress,'String','Mean Stress (ksi)');
    if(m>=2 && m<=3)
        set(handles.text_aux_stress,'String','Ultimate Stress Limit (ksi)');
    end
    if(m==4)
        set(handles.text_aux_stress,'String','True Fracture Stress (ksi)');    
    end
    if(m==5)
        set(handles.text_aux_stress,'String','Yield Stress Limits (ksi)');      
    end
end    
if(n==3)
%    set(handles.text_mean_stress,'String','Mean Stress (MPa)');
    if(m>=2 && m<=3)
        set(handles.text_aux_stress,'String','Ultimate Stress Limit (MPa)');
    end
    if(m==4)
        set(handles.text_aux_stress,'String','True Fracture Stress (MPa)');    
    end
    if(m==5)
        set(handles.text_aux_stress,'String','Yield Stress Limits (MPa)');      
    end
end    


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp('*************');
disp('  ');

scf=str2num(get(handles.edit_scf,'String'));

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);   
catch
    warndlg('Input data file not found');
    return; 
end    

nif=get(handles.listbox_input_format,'Value');

sz=size(THM);

if(nif==1)
    if(sz(2)==3)
        warndlg('Input file has three columns. Should have two.');
        return;
    end
else
    if(sz(2)==2)
        warndlg('Input file has three columns. Should have two.');
        return;
    end    
end
    
    
out1=sprintf(' Input array: %s',FS);
disp(out1);

nnn=get(handles.listbox_unit,'Value');

if(nnn==1)
    YY='psi';
    ylab='Stress (psi)';
end
if(nnn==2)
    YY='ksi';    
    ylab='Stress (ksi)';
end
if(nnn==3)
    YY='MPa';    
    ylab='Stress (MPa)';
end

out1=sprintf(' Unit:  %s ',ylab);
disp(out1);


mlab=getappdata(0,'mlab');

out1=sprintf('\n Material: %s ',mlab);
disp(out1);

s=double(THM(:,1));

if(min(s)<0)
   errordlg('Minimum Stress < 0 '); 
   return; 
end

s=s*scf;

if(nif==1)
    n=double(THM(:,2));    
else
    mean_stress=double(THM(:,2));
    mean_stress=mean_stress*scf;
    n=double(THM(:,3));       
end

if(min(n)<0)
   errordlg('Minimum Cycle < 0 '); 
   return; 
end

mx=str2num(get(handles.edit_m,'String'));
A=str2num(get(handles.edit_A,'String'));
tau=str2num(get(handles.edit_duration,'String'));

disp(' ');
out1=sprintf(' Fatigue exponent m = %g ',mx);
disp(out1);
out2=sprintf(' Fatigue strength coefficient A = %g ',A);
disp(out2);
out3=sprintf('\n Duration tau = %g sec ',tau);
disp(out3);



m=length(s);

D=0;

zp=m;

ssa=0;
ssr=0;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mc=get(handles.listbox_mean,'Value');

if(mc>=2)  
    aux_stress=str2num(get(handles.edit_stress_aux,'String'));
end
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:m
%
   Se=s(i);
%
%%%%%%%%%%%%%%%%%%%%%%%%%
%
   C=1;
%
   if(mc==2) % Gerber Ultimate Stress 
        C=1-(abs(mean_stress(i))/aux_stress)^2;
   end
   if(mc==3) % Goodman Ultimate Stress 
        C=1-(abs(mean_stress(i))/aux_stress);
   end
   if(mc==4) % Morrow True Fracture
        C=1-(abs(mean_stress(i))/aux_stress);
   end
   if(mc==5) % Soderberg Yield Stress
        C=1-(abs(mean_stress(i))/aux_stress);
   end
%
   Se=Se/C;
%
%%%%%%%%%%%%%%%%%%%%%%%%%
%
  
    D=D+n(i)*Se^mx;
    
    ssa=ssa+Se^mx;      
    ssr=ssr+(2*Se)^mx;    
    
%    
end
%% out1=sprintf('\n @@@ D=%8.4g \n',D);
%% disp(out1);
%

out1=sprintf('\n Maximum Rainflow Stress Amplitude=%8.4g %s ',max( s ),YY);
disp(out1);

out1=sprintf('\n Number of Rainflow Cycles=%8.4g \n',sum(n));
disp(out1);

D=D/A;


ssa=ssa/m;
ssr=ssr/m;


rzp=zp/tau;
disp(' ');
out1=sprintf(' Rate of Peaks = %8.4g per sec ',rzp);
disp(out1);


sd=sprintf('%8.4g',D);
set(handles.edit_damage,'Enable','on','Visible','on','String',sd);

disp(' ');
disp(' -------  Amplitude Results -------  ');

out1=sprintf('\n E[A^m]=%8.4g',ssa);
disp(out1);

if(D<0)
    D=0;
end

disp(' ');
out1=sprintf(' Cumulative Damage = %8.4g ',D);
disp(out1);
out2=sprintf(' Damage Rate = %8.4g per sec',D/tau);
disp(out2);
disp(' ');

msgbox('Results written to Command Window.');


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



function edit_damage_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damage as text
%        str2double(get(hObject,'String')) returns contents of edit_damage as a double


% --- Executes during object creation, after setting all properties.
function edit_damage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_m and none of its controls.
function edit_m_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_damage,'Enable','off','Visible','off');


% --- Executes on key press with focus on edit_A and none of its controls.
function edit_A_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_damage,'Enable','off','Visible','off');


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_damage,'Enable','off','Visible','off');



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


% --- Executes on selection change in listbox_mean.
function listbox_mean_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean

n=get(handles.listbox_mean,'Value');

if(n==1)
%    set(handles.edit_mean_stress,'Visible','off');
%    set(handles.text_mean_stress,'Visible','off');
    set(handles.edit_stress_aux,'Visible','off');
    set(handles.text_aux_stress,'Visible','off');    
else
%    set(handles.edit_mean_stress,'Visible','on');
%    set(handles.text_mean_stress,'Visible','on');
    set(handles.edit_stress_aux,'Visible','on');
    set(handles.text_aux_stress,'Visible','on');     
end

iu=get(handles.listbox_unit,'Value');

if(n==2) % Gerber
    if(iu==1)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (psi)'); 
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (ksi)'); 
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (MPa)'); 
    end    
end
if(n==3) % Goodman
    if(iu==1)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (psi)');   
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (ksi)');   
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (MPa)');   
    end    
   
end
if(n==4) % Morrow
    if(iu==1)
            set(handles.text_aux_stress,'String','True Fracture Stress (psi)');   
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','True Fracture Stress (ksi)');   
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','True Fracture Stress (MPa)');   
    end    
  
end
if(n==5) % Soderberg
    if(iu==1)
            set(handles.text_aux_stress,'String','Yield Stress Limit (psi)');   
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','Yield Stress Limit (ksi)');   
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','Yield Stress Limit (MPa)');   
    end      
end


% --- Executes during object creation, after setting all properties.
function listbox_mean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mean_stress_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mean_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mean_stress as text
%        str2double(get(hObject,'String')) returns contents of edit_mean_stress as a double


% --- Executes during object creation, after setting all properties.
function edit_mean_stress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mean_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stress_aux_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress_aux as text
%        str2double(get(hObject,'String')) returns contents of edit_stress_aux as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_aux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_input_format.
function listbox_input_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_format

n=get(handles.listbox_input_format,'Value');

set(handles.listbox_mean,'Value',1);

if(n==1)
    set(handles.text_smc,'Visible','off');     
    set(handles.listbox_mean,'Visible','off');    
else
    set(handles.text_smc,'Visible','on');     
    set(handles.listbox_mean,'Visible','on');
end



% --- Executes during object creation, after setting all properties.
function listbox_input_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_stress_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_stress as text
%        str2double(get(hObject,'String')) returns contents of edit_input_stress as a double


% --- Executes during object creation, after setting all properties.
function edit_input_stress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
