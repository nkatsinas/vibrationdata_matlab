function varargout = acoustic_cavity_fairing_example(varargin)
% ACOUSTIC_CAVITY_FAIRING_EXAMPLE MATLAB code for acoustic_cavity_fairing_example.fig
%      ACOUSTIC_CAVITY_FAIRING_EXAMPLE, by itself, creates a new ACOUSTIC_CAVITY_FAIRING_EXAMPLE or raises the existing
%      singleton*.
%
%      H = ACOUSTIC_CAVITY_FAIRING_EXAMPLE returns the handle to a new ACOUSTIC_CAVITY_FAIRING_EXAMPLE or the handle to
%      the existing singleton*.
%
%      ACOUSTIC_CAVITY_FAIRING_EXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACOUSTIC_CAVITY_FAIRING_EXAMPLE.M with the given input arguments.
%
%      ACOUSTIC_CAVITY_FAIRING_EXAMPLE('Property','Value',...) creates a new ACOUSTIC_CAVITY_FAIRING_EXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before acoustic_cavity_fairing_example_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to acoustic_cavity_fairing_example_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help acoustic_cavity_fairing_example

% Last Modified by GUIDE v2.5 15-Feb-2017 10:10:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @acoustic_cavity_fairing_example_OpeningFcn, ...
                   'gui_OutputFcn',  @acoustic_cavity_fairing_example_OutputFcn, ...
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


% --- Executes just before acoustic_cavity_fairing_example is made visible.
function acoustic_cavity_fairing_example_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to acoustic_cavity_fairing_example (see VARARGIN)

% Choose default command line output for acoustic_cavity_fairing_example
handles.output = hObject;


iu=getappdata(0,'iu');  % keep first


external_SPL=getappdata(0,'external_spl_name');

if isempty(external_SPL)
   warndlg('external_SPL missing. Run fairing'); 
end


ba=getappdata(0,'acoustic_cavity_bare_wall_alpha');

if(isempty(ba)==0)
    ss=sprintf('%g',ba);
    set(handles.edit_bare_wall_alpha,'String',ss);
end    


sa=getappdata(0,'acoustic_cavity_surface_area');

if(isempty(sa)==0)
    ss=sprintf('%g',sa);
    set(handles.edit_surface_area,'String',ss);
end    




pp=getappdata(0,'acoustic_cavity_percent_payload');
if(isempty(pp)==0)
    ss=sprintf('%g',pp);
    set(handles.edit_percent_payload,'String',ss);
end    


cc=getappdata(0,'acoustic_cavity_clearance');
if(isempty(cc)==0)
    ss=sprintf('%g',cc);
    set(handles.edit_clearance,'String',ss);
end   




dlf=getappdata(0,'acoustic_cavity_dlf');
if(isempty(dlf)==0)
    ss=sprintf('%g',mean(dlf));
    set(handles.edit_lf,'String',ss);
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
    
diameter=getappdata(0,'acoustic_cavity_diameter');
if(isempty(diameter)==0)
    ss=sprintf('%g',diameter);
    set(handles.edit_diameter,'String',ss);
end    

H=getappdata(0,'acoustic_cavity_H');
if(isempty(H)==0)
    ss=sprintf('%g',H);
    set(handles.edit_H,'String',ss);
end   

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

% UIWAIT makes acoustic_cavity_fairing_example wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = acoustic_cavity_fairing_example_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
try
    varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(acoustic_cavity_fairing_example);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp('****');

iu=getappdata(0,'iu');

external_SPL=getappdata(0,'external_spl_data');


if isempty(external_SPL)
   warndlg('external_SPL missing. Run fairing'); 
   return;
else 
   fc=external_SPL(:,1);
end

nfc=length(fc);




imed=get(handles.listbox_gas,'Value');

c=str2num(get(handles.edit_c,'String')); 
gas_md=str2num(get(handles.edit_gas_md,'String'));

setappdata(0,'acoustic_cavity_gas_rho',gas_md);

if(iu==1)
    su='in/sec';
    gas_md=gas_md/(12^3*386);
    c=c*12;    
else
    su='m/sec';
end

setappdata(0,'acoustic_cavity_gas_rho_c',gas_md*c);
setappdata(0,'acoustic_cavity_gas_md',gas_md);
setappdata(0,'acoustic_cavity_gas_c',c);


cc=str2num(get(handles.edit_clearance,'String'));

if isempty(cc)
   warndlg('Enter Clearance'); 
   return;
end

setappdata(0,'acoustic_cavity_clearance',cc);

H=cc;


pp=str2num(get(handles.edit_percent_payload,'String'));
setappdata(0,'acoustic_cavity_percent_payload',pp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fill_factor=zeros(nfc,1);

Vr=pp/100;

for i=1:nfc
    
    aa=c/(2*fc(i)*H);
    
    term=(1+aa)/(1+aa*(1-Vr));
        
    fill_factor(i)=10*log10(term);
              
end


disp('ref 3 ');
size(fc)
size(fill_factor);


fig_num=1;
    
x_label='Frequency (Hz)';
y_label='Fill Factor (dB)';
t_string='Payload Fill Factor';
ppp=[fc fill_factor];

size(ppp)

fmin=min(fc);
fmax=max(fc);
    
[fig_num]=plot_loglin_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
                 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mph=zeros(nfc,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    disp(' Acoustic Volume ');
       
    
    V=str2num(get(handles.edit_volume,'String'));  
   
    if isempty(V)
        warndlg('Enter Volume'); 
        return;
    end    
    
    
    D=V/c^3;   
    
    for i=1:nfc
        
        [mph(i)]=acoustic_volume_mdens(D,fc(i));  
              
    end
    
    stitle='Acoustic Volume  Modal Density';

%

    surface_area=str2num(get(handles.edit_surface_area,'String'));  
   
    if isempty(surface_area)
        warndlg('Enter Surface Area'); 
        return;
    end 

    setappdata(0,'acoustic_cavity_surface_area',surface_area);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mph=fix_size(mph);    
                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dlf=str2num(get(handles.edit_lf,'String'));
dlf=dlf*ones(nfc,1);


modal_density=[fc mph];

setappdata(0,'acoustic_cavity_dlf',dlf);
setappdata(0,'acoustic_cavity_volume',V); 
setappdata(0,'acoustic_cavity_modal_density',mph); 
setappdata(0,'acoustic_cavity_fill_factor',fill_factor);


bare_wall_alpha=str2num(get(handles.edit_bare_wall_alpha,'String'));

setappdata(0,'acoustic_cavity_bare_wall_alpha',bare_wall_alpha);

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

  
fig_num=451;
    
x_label='Frequency (Hz)';
y_label='Modal Density (modes/Hz)';
t_string=stitle;
ppp=[fc mph];
md=6;
fmin=min(fc);
fmax=max(fc);
    
[fig_num]=plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
           

out1=sprintf('\n nfc=%d \n',nfc);
disp(out1);

% fill_factor


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


ng=get(handles.listbox_gas,'Value');

%%%


set(handles.edit_volume,'Visible','on'); 
set(handles.text_volume,'Visible','on'); 


if(iu==1)  % English
  
    set(handles.text_clearance,'String','(in)');       
    
    set(handles.text_volume,'String','Volume (in^3)');  
    set(handles.text_surface_area,'String','Surface Area (in^2)');     
    
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
    
    set(handles.text_clearance,'String','(m)');     

    set(handles.text_volume,'String','Volume (m^3)');
    set(handles.text_surface_area,'String','Surface Area (m^2)');        
    
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



function edit_fairing_absorption_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fairing_absorption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fairing_absorption as text
%        str2double(get(hObject,'String')) returns contents of edit_fairing_absorption as a double


% --- Executes during object creation, after setting all properties.
function edit_fairing_absorption_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fairing_absorption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_percent_payload_Callback(hObject, eventdata, handles)
% hObject    handle to edit_percent_payload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_percent_payload as text
%        str2double(get(hObject,'String')) returns contents of edit_percent_payload as a double


% --- Executes during object creation, after setting all properties.
function edit_percent_payload_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_percent_payload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clearance_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clearance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clearance as text
%        str2double(get(hObject,'String')) returns contents of edit_clearance as a double


% --- Executes during object creation, after setting all properties.
function edit_clearance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clearance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_surface_area_Callback(hObject, eventdata, handles)
% hObject    handle to edit_surface_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_surface_area as text
%        str2double(get(hObject,'String')) returns contents of edit_surface_area as a double


% --- Executes during object creation, after setting all properties.
function edit_surface_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_surface_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bare_wall_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bare_wall_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bare_wall_alpha as text
%        str2double(get(hObject,'String')) returns contents of edit_bare_wall_alpha as a double


% --- Executes during object creation, after setting all properties.
function edit_bare_wall_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bare_wall_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
