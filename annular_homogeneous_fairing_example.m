function varargout = annular_homogeneous_fairing_example(varargin)
% ANNULAR_HOMOGENEOUS_FAIRING_EXAMPLE MATLAB code for annular_homogeneous_fairing_example.fig
%      ANNULAR_HOMOGENEOUS_FAIRING_EXAMPLE, by itself, creates a new ANNULAR_HOMOGENEOUS_FAIRING_EXAMPLE or raises the existing
%      singleton*.
%
%      H = ANNULAR_HOMOGENEOUS_FAIRING_EXAMPLE returns the handle to a new ANNULAR_HOMOGENEOUS_FAIRING_EXAMPLE or the handle to
%      the existing singleton*.
%
%      ANNULAR_HOMOGENEOUS_FAIRING_EXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANNULAR_HOMOGENEOUS_FAIRING_EXAMPLE.M with the given input arguments.
%
%      ANNULAR_HOMOGENEOUS_FAIRING_EXAMPLE('Property','Value',...) creates a new ANNULAR_HOMOGENEOUS_FAIRING_EXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before annular_homogeneous_fairing_example_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to annular_homogeneous_fairing_example_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help annular_homogeneous_fairing_example

% Last Modified by GUIDE v2.5 23-May-2016 15:49:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @annular_homogeneous_fairing_example_OpeningFcn, ...
                   'gui_OutputFcn',  @annular_homogeneous_fairing_example_OutputFcn, ...
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


% --- Executes just before annular_homogeneous_fairing_example is made visible.
function annular_homogeneous_fairing_example_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to annular_homogeneous_fairing_example (see VARARGIN)

% Choose default command line output for annular_homogeneous_fairing_example
handles.output = hObject;

material_change(hObject, eventdata, handles)

listbox_dlf_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = annular_homogeneous_fairing_example_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function units_change(hObject,eventdata,handles)

% disp(' units_change ');

material_change(hObject, eventdata, handles);

guidata(hObject, handles)


% --- Executes on button press in return_pushbutton.
function return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(annular_homogeneous_fairing_example)


% --- Executes on selection change in unit_listbox.
function unit_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to unit_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unit_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unit_listbox


iu=get(hObject,'Value');

guidata(hObject, handles);

units_change(hObject,eventdata,handles);
materials_listbox_Callback(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function unit_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unit_listbox (see GCBO)
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


imat=get(hObject,'Value');

guidata(hObject, handles);

material_change(hObject, eventdata, handles);


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



function elastic_modulus_edit_Callback(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elastic_modulus_edit as text
%        str2double(get(hObject,'String')) returns contents of elastic_modulus_edit as a double


% --- Executes during object creation, after setting all properties.
function elastic_modulus_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass_density_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass_density_edit as text
%        str2double(get(hObject,'String')) returns contents of mass_density_edit as a double


% --- Executes during object creation, after setting all properties.
function mass_density_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poisson_edit_Callback(hObject, eventdata, handles)
% hObject    handle to poisson_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poisson_edit as text
%        str2double(get(hObject,'String')) returns contents of poisson_edit as a double


% --- Executes during object creation, after setting all properties.
function poisson_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poisson_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in calculate_button.
function calculate_button_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=getappdata(0,'iu');

c=getappdata(0,'acoustic_cavity_gas_c');

if isempty(c)
   warndlg('acoustic_cavity_gas_c missing. Run Acoustic Cavity'); 
   return;
end 


fc=getappdata(0,'fc');
nfc=length(fc);

if(nfc==0)
    warndlg(' Frequency bands undefined. ');
    return;
end
f=fc;


E=str2num(get(handles.elastic_modulus_edit,'String'));
rho=str2num(get(handles.mass_density_edit,'String'));
mu=str2num(get(handles.poisson_edit,'String'));

OD=str2num(get(handles.edit_OD,'String'));
ID=str2num(get(handles.edit_ID,'String'));

if(ID>=OD)
   warndlg('Diameter error'); 
   return; 
end


T=str2num(get(handles.thickness_edit,'String'));

NSM=str2num(get(handles.NSM_edit,'String'));


if(iu==1)
    rho=rho/386;
    NSM=NSM/386;
else
    [E]=GPa_to_Pa(E);
    T=T/1000;
end


[area]=area_annular_plate(OD,ID);

[L,W]=convert_area_LW(area);

[~,total_mass,rho]=homogeneous_totals_mass(area,T,rho,NSM);

total_md=rho;

thick=T;
md=rho;
em=E;
 
[mph]=annular_plate_mdens(OD,ID,thick,md,em,mu,f); 
[CL]=CL_plate(em,md,mu);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ndlf=get(handles.listbox_dlf,'Value');

if(ndlf==2)
   ulf=str2num(get(handles.edit_ulf,'String')); 

   if( isempty(ulf)==1)
       warndlg('Enter loss factor');
       return;
   end   
   
end


dlf=zeros(nfc,1);

rad_eff=zeros(nfc,1);


for i=1:nfc

    if(ndlf==1)
        [dlf(i)]=plate_dissipation_loss_factor(fc(i));
    else
        dlf(i)=ulf;
    end
    
    
% Assume freely suspended due to vent paths, excitation on either side, etc.    
    
    [rad_eff(i)]=re_thin_plate_free(fc(i),fcr,L,W,c);  
        
end

dlf=fix_size(dlf);  % keep


setappdata(0,'shelf_mass',total_mass);
setappdata(0,'shelf_area',area);
setappdata(0,'shelf_mdens',[fc mph]);
setappdata(0,'shelf_dlf',[fc dlf]);
setappdata(0,'shelf_thick',thick);
setappdata(0,'shelf_md',total_md);
setappdata(0,'shelf_cL',CL);
setappdata(0,'shelf_rad_eff',rad_eff);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

display_freq_mdens_dlf(f,mph,dlf);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;
x_label='Frequency (Hz)';
y_label='Modal Density (modes/Hz)';
t_string='Modal Density  Annular Plate';
ppp=[fc mph];
fmin=min(fc);
fmax=max(fc);

[fig_num,h2]=...
   plot_loglin_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);


y_label='Loss Factor';
t_string='Loss Factor  Annular Plate';
ppp=[fc dlf];

[fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);


y_label='Rad Eff';
t_string='Radiation Efficiency  Annular Plate';
ppp=[fc rad_eff];
 
[fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msgbox('Results written to Command Window');


function NSM_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NSM_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NSM_edit as text
%        str2double(get(hObject,'String')) returns contents of NSM_edit as a double


% --- Executes during object creation, after setting all properties.
function NSM_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NSM_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_OD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_OD as text
%        str2double(get(hObject,'String')) returns contents of edit_OD as a double


% --- Executes during object creation, after setting all properties.
function edit_OD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thickness_edit_Callback(hObject, eventdata, handles)
% hObject    handle to thickness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thickness_edit as text
%        str2double(get(hObject,'String')) returns contents of thickness_edit as a double


% --- Executes during object creation, after setting all properties.
function thickness_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thickness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function material_change(hObject, eventdata, handles)

iu=getappdata(0,'iu');
imat=get(handles.listbox_material,'Value');


if(iu==1)  % English
    set(handles.text_OD,'String','Outer Diameter (in)');   
    set(handles.text_ID,'String','Inner Diameter (in)');
    set(handles.text_H,'String','Thickness (in)');     
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)');
    set(handles.mass_text,'String','lbm');
else
    set(handles.text_OD,'String','Outer Diameter (m)');   
    set(handles.text_ID,'String','Inner Diameter (m)');
    set(handles.text_H,'String','Thickness (mm)');    
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');   
    set(handles.mass_text,'String','kg');    
end


if(iu==1)  % English
    if(imat==1) % aluminum
        handles.elastic_modulus=1e+007;
        handles.mass_density=0.1;  
    end  
    if(imat==2)  % steel
        handles.elastic_modulus=3e+007;
        handles.mass_density= 0.28;         
    end
    if(imat==3)  % copper
        handles.elastic_modulus=1.6e+007;
        handles.mass_density=  0.322;
    end
else                 % metric
    if(imat==1)  % aluminum
        handles.elastic_modulus=70;
        handles.mass_density=  2700;
    end
    if(imat==2)  % steel
        handles.elastic_modulus=205;
        handles.mass_density=  7700;        
    end
    if(imat==3)   % copper
        handles.elastic_modulus=110;
        handles.mass_density=  8900;
    end
end

if(imat==1)  % aluminum
       handles.poisson=0.33;  
end
if(imat==2)  % steel
       handles.poisson=0.30;      
end
if(imat==3)   % copper
       handles.poisson=0.33; 
end

if(imat<=3)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density); 
    ss3=sprintf('%8.4g',handles.poisson); 
    
else
    handles.elastic_modulus=0;
    handles.mass_density=   0;
    handles.poisson=   0;
    
    ss1=' ';
    ss2=' ';
    ss3=' ';
end

set(handles.elastic_modulus_edit,'String',ss1);
set(handles.mass_density_edit,'String',ss2);  
set(handles.poisson_edit,'String',ss3);  


guidata(hObject, handles);


% --- Executes on selection change in BC_listbox.
function BC_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BC_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BC_listbox



% --- Executes during object creation, after setting all properties.
function BC_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on elastic_modulus_edit and none of its controls.
function elastic_modulus_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on mass_density_edit and none of its controls.
function mass_density_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on poisson_edit and none of its controls.
function poisson_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to poisson_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_OD and none of its controls.
function edit_OD_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_OD (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on thickness_edit and none of its controls.
function thickness_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to thickness_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on NSM_edit and none of its controls.
function NSM_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to NSM_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_base.
function pushbutton_base_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

BC=get(handles.BC_listbox,'Value');

if(BC<=2)
    handles.s=vibrationdata_circular_plate_base;     
else
    handles.s=circular_plate_four_points_base;        
end    
    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('Circular_plate_bending_md.jpg');
figure(998) 
imshow(A,'border','tight','InitialMagnification',100)


% --- Executes on selection change in listbox_iu.
function listbox_iu_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_iu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_iu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_iu


% --- Executes during object creation, after setting all properties.
function listbox_iu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_iu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_lf.
function pushbutton_lf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('plate_lf.jpg');
figure(994) 
imshow(A,'border','tight','InitialMagnification',100)  


% --- Executes on selection change in listbox_dlf.
function listbox_dlf_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dlf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dlf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dlf
nd=get(handles.listbox_dlf,'Value'); 

set(handles.text_ulf,'Visible','on');
set(handles.edit_ulf,'Visible','on'); 

if(nd==1)
    set(handles.text_ulf,'Visible','off');
    set(handles.edit_ulf,'Visible','off');    
end  

% --- Executes during object creation, after setting all properties.
function listbox_dlf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dlf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ulf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ulf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ulf as text
%        str2double(get(hObject,'String')) returns contents of edit_ulf as a double


% --- Executes during object creation, after setting all properties.
function edit_ulf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ulf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ID_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ID as text
%        str2double(get(hObject,'String')) returns contents of edit_ID as a double


% --- Executes during object creation, after setting all properties.
function edit_ID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_rad_eff.
function pushbutton_rad_eff_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rad_eff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure(999);
A = imread('re_free_panel_shelf.jpg');  
imshow(A,'border','tight','InitialMagnification',100); 