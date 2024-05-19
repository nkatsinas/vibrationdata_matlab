function varargout = acoustic_cavity_cylindrical_shell_example(varargin)
% ACOUSTIC_CAVITY_CYLINDRICAL_SHELL_EXAMPLE MATLAB code for acoustic_cavity_cylindrical_shell_example.fig
%      ACOUSTIC_CAVITY_CYLINDRICAL_SHELL_EXAMPLE, by itself, creates a new ACOUSTIC_CAVITY_CYLINDRICAL_SHELL_EXAMPLE or raises the existing
%      singleton*.
%
%      H = ACOUSTIC_CAVITY_CYLINDRICAL_SHELL_EXAMPLE returns the handle to a new ACOUSTIC_CAVITY_CYLINDRICAL_SHELL_EXAMPLE or the handle to
%      the existing singleton*.
%
%      ACOUSTIC_CAVITY_CYLINDRICAL_SHELL_EXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACOUSTIC_CAVITY_CYLINDRICAL_SHELL_EXAMPLE.M with the given input arguments.
%
%      ACOUSTIC_CAVITY_CYLINDRICAL_SHELL_EXAMPLE('Property','Value',...) creates a new ACOUSTIC_CAVITY_CYLINDRICAL_SHELL_EXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before acoustic_cavity_cylindrical_shell_example_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to acoustic_cavity_cylindrical_shell_example_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help acoustic_cavity_cylindrical_shell_example

% Last Modified by GUIDE v2.5 03-Jan-2019 17:49:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @acoustic_cavity_cylindrical_shell_example_OpeningFcn, ...
                   'gui_OutputFcn',  @acoustic_cavity_cylindrical_shell_example_OutputFcn, ...
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


% --- Executes just before acoustic_cavity_cylindrical_shell_example is made visible.
function acoustic_cavity_cylindrical_shell_example_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to acoustic_cavity_cylindrical_shell_example (see VARARGIN)

% Choose default command line output for acoustic_cavity_cylindrical_shell_example
handles.output = hObject;

set(handles.edit_volume,'String','');

iu=getappdata(0,'iu');  % keep first

dlf=getappdata(0,'acoustic_cavity_dlf');
if(isempty(dlf)==0)
    ss=sprintf('%g',mean(dlf));
    set(handles.edit_lf,'String',ss);
end    


percent=getappdata(0,'percent');
if(isempty(percent)==0)
    ss=sprintf('%g',percent);
    set(handles.edit_percent,'String',ss);
end  


V=getappdata(0,'acoustic_cavity_volume');
if(isempty(V)==0)
    ss=sprintf('%g',V);
    set(handles.edit_volume,'String',ss);
end      

ns=getappdata(0,'acoustic_cavity_ns');
if(isempty(ns)==0)
    set(handles.listbox_structure,'Value',ns);
end     

imed=getappdata(0,'acoustic_cavity_imed');
if(isempty(imed)==0)
    set(handles.listbox_gas,'Value',imed);
end    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diameter=getappdata(0,'cylindrical_shell_diam');
if(isempty(diameter)==0)
    ss=sprintf('%g',diameter);
    set(handles.edit_diameter,'String',ss);
end 

diameter=getappdata(0,'acoustic_cavity_diameter');
if(isempty(diameter)==0)
    ss=sprintf('%g',diameter);
    set(handles.edit_diameter,'String',ss);
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H=getappdata(0,'cylindrical_shell_L');
if(isempty(H)==0)
    ss=sprintf('%g',H);
    set(handles.edit_H,'String',ss);
end   

H=getappdata(0,'acoustic_cavity_H');
if(isempty(H)==0)
    ss=sprintf('%g',H);
    set(handles.edit_H,'String',ss);
end   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gas_md=getappdata(0,'acoustic_cavity_gas_rho');
if(isempty(gas_md)==0)
    
    if(iu==1)
       gas_md=gas_md*(12^3*386); 
    end
    
    ss=sprintf('%g',gas_md);
    set(handles.edit_gas_md,'String',ss);
end 

c=getappdata(0,'acoustic_cavity_c');
if(isempty(c)==0)
    
    if(iu==1)
       c=c/12; 
    end
    
    ss=sprintf('%g',c);
    set(handles.edit_c,'String',ss);
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes acoustic_cavity_cylindrical_shell_example wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = acoustic_cavity_cylindrical_shell_example_OutputFcn(hObject, eventdata, handles) 
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

delete(acoustic_cavity_cylindrical_shell_example);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp('****');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iu=getappdata(0,'iu');  % keep first

H=0;         % keep
diameter=0;
V=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ns=get(handles.listbox_structure,'Value');   % keep
imed=get(handles.listbox_gas,'Value');

c=str2num(get(handles.edit_c,'String')); 
gas_md=str2num(get(handles.edit_gas_md,'String'));

if(iu==1)
    su='in/sec';
    gas_md=gas_md/(12^3*386);
    c=c*12;    
else
    su='m/sec';
end

setappdata(0,'acoustic_cavity_gas_rho_c',gas_md*c);
setappdata(0,'acoustic_cavity_gas_rho',gas_md);
setappdata(0,'acoustic_cavity_gas_c',c);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fc=getappdata(0,'fc');
nfc=length(fc);

if(nfc==0)
    warndlg(' Frequency bands undefined. Run Cylindrical Shell. ');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

percent=str2num(get(handles.edit_percent,'String'));

setappdata(0,'percent',percent);

mph=zeros(nfc,1);

if(ns==1) % Cylinder
    
    disp(' Acoustic Cavity Cylinder 3D ');

    H=str2num(get(handles.edit_H,'String'));    
    diameter=str2num(get(handles.edit_diameter,'String'));  
    
    r=diameter/2;
    
    V=pi*r^2*H;
    
    stitle='Acoustic Cylinder 3D  Modal Density';    
    
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ns==2) % Volume
    
    disp(' Acoustic Volume ');
    
    V=str2num(get(handles.edit_volume,'String'));  
        
    stitle='Acoustic Volume  Modal Density';

%
end

D=(V/c^3)*percent/100;
    
for i=1:nfc
        
    [mph(i)]=acoustic_volume_mdens(D,fc(i));  
              
end

if(ns==1)
    V=V*percent/100;
    ss=sprintf('%9.5g',V);
    set(handles.edit_volume,'String',ss);
    
    setappdata(0,'acoustic_cavity_volume',V);     
else
    setappdata(0,'acoustic_cavity_volume',V); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mph=fix_size(mph);    
                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dlf=str2num(get(handles.edit_lf,'String'));
dlf=dlf*ones(nfc,1);


modal_density=[fc mph];

setappdata(0,'acoustic_cavity_dlf',dlf);
setappdata(0,'acoustic_cavity_modal_density',mph); 

setappdata(0,'acoustic_cavity_ns',ns);
setappdata(0,'acoustic_cavity_imed',imed);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 
    disp(' ');
    disp('  One-third Octave ');
    disp('  ');
    disp('  Center  Modal ');
    disp('  Freq    Density ');
    disp('  (Hz)    (modes/Hz) ');
                 
    for i=1:nfc
        out1=sprintf(' %6.0f  %8.4g',fc(i),mph(i));
        disp(out1);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(iu==1)
        out1=sprintf('\n Volume = %8.4g in^3',V);
    else
        out1=sprintf('\n Volume = %8.4g m^3',V);        
    end
    disp(out1);    

out10=sprintf('\n Speed of Sound in Gas = %8.4g %s',c,su);
disp(out10);

if(iu==1)
    out10=sprintf('                       = %8.4g ft/sec',c/12);
    disp(out10);    
end

  
fig_num=450;
    
x_label='Frequency (Hz)';
y_label='Modal Density (modes/Hz)';
t_string=stitle;
ppp=[fc mph];
md=6;
fmin=min(fc);
fmax=max(fc);
    
[fig_num]=plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
                 

msgbox('Results written to Command Window');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change(hObject, eventdata, handles);

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


% --- Executes on selection change in listbox_structure.
function listbox_structure_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_structure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_structure
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_structure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L as text
%        str2double(get(hObject,'String')) returns contents of edit_L as a double


% --- Executes during object creation, after setting all properties.
function edit_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c as text
%        str2double(get(hObject,'String')) returns contents of edit_c as a double


% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_gas.
function listbox_gas_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_gas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_gas

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_gas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_temp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_temp as text
%        str2double(get(hObject,'String')) returns contents of edit_temp as a double


% --- Executes during object creation, after setting all properties.
function edit_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_width as text
%        str2double(get(hObject,'String')) returns contents of edit_width as a double


% --- Executes during object creation, after setting all properties.
function edit_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_H_Callback(hObject, eventdata, handles)
% hObject    handle to edit_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_H as text
%        str2double(get(hObject,'String')) returns contents of edit_H as a double


% --- Executes during object creation, after setting all properties.
function edit_H_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function change(hObject, eventdata, handles)
%
iu=getappdata(0,'iu');
ns=get(handles.listbox_structure,'Value');

ng=get(handles.listbox_gas,'Value');

%%%


set(handles.edit_H,'Visible','off'); 
set(handles.text_H,'Visible','off'); 

set(handles.edit_diameter,'Visible','off'); 
set(handles.text_diameter,'Visible','off'); 


set(handles.edit_volume,'Enable','off'); 
set(handles.text_volume,'Enable','off'); 


if(iu==1)  % English
   
    set(handles.text_H,'String','Height (in)');      
    set(handles.text_diameter,'String','Diameter (in)');     
    set(handles.text_volume,'String','Volume (in^3)');      
    
    set(handles.text_gas_md,'String','Gas Mass Density (lbm/ft^3)'); 
    set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)'); 
    
    if(ng==1)
        set(handles.edit_c,'String','1125');
        set(handles.edit_gas_md,'String','0.076487');       
    else
        set(handles.edit_c,'String',' ');   
        set(handles.edit_gas_md,'String',' ');        
    end    
    
else

    set(handles.text_H,'String','Height (m)');
    set(handles.text_diameter,'String','Diameter (m)');
    set(handles.text_volume,'String','Volume (m^3)'); 
    
    set(handles.text_gas_md,'String','Gas Mass Density (kg/m^3)');    
    set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
    
    if(ng==1)
        set(handles.edit_c,'String','343');  
        set(handles.edit_gas_md,'String','1.225');         
    else
        set(handles.edit_c,'String',' ');      
        set(handles.edit_gas_md,'String',' ');          
    end   
    
end


if(ns==1)
    set(handles.edit_H,'Visible','on'); 
    set(handles.text_H,'Visible','on');    
    set(handles.edit_diameter,'Visible','on'); 
    set(handles.text_diameter,'Visible','on');    
end

if(ns==2)
    set(handles.edit_volume,'Enable','on'); 
    set(handles.text_volume,'Enable','on');    
end

%%%



function edit_volume_Callback(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_volume as text
%        str2double(get(hObject,'String')) returns contents of edit_volume as a double


% --- Executes during object creation, after setting all properties.
function edit_volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ns=get(handles.listbox_structure,'Value');


if(ns==1)
    A = imread('3D_Cylinder_md.jpg');
    figure(997) 
    imshow(A,'border','tight','InitialMagnification',100)
end

if(ns==2)
    A = imread('3D_Other_md.jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100)
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_lf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf as text
%        str2double(get(hObject,'String')) returns contents of edit_lf as a double


% --- Executes during object creation, after setting all properties.
function edit_lf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gas_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gas_md as text
%        str2double(get(hObject,'String')) returns contents of edit_gas_md as a double


% --- Executes during object creation, after setting all properties.
function edit_gas_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_medium.
function listbox_medium_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_medium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_medium contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_medium


% --- Executes during object creation, after setting all properties.
function listbox_medium_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_medium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_percent_Callback(hObject, eventdata, handles)
% hObject    handle to edit_percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_percent as text
%        str2double(get(hObject,'String')) returns contents of edit_percent as a double


% --- Executes during object creation, after setting all properties.
function edit_percent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_percent and none of its controls.
function edit_percent_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_percent (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_volume,'String','');


% --- Executes on key press with focus on edit_diameter and none of its controls.
function edit_diameter_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_volume,'String','');


% --- Executes on key press with focus on edit_H and none of its controls.
function edit_H_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_H (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_volume,'String','');