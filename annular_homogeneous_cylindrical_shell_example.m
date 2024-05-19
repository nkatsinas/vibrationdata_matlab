function varargout = annular_homogeneous_cylindrical_shell_example(varargin)
% ANNULAR_HOMOGENEOUS_CYLINDRICAL_SHELL_EXAMPLE MATLAB code for annular_homogeneous_cylindrical_shell_example.fig
%      ANNULAR_HOMOGENEOUS_CYLINDRICAL_SHELL_EXAMPLE, by itself, creates a new ANNULAR_HOMOGENEOUS_CYLINDRICAL_SHELL_EXAMPLE or raises the existing
%      singleton*.
%
%      H = ANNULAR_HOMOGENEOUS_CYLINDRICAL_SHELL_EXAMPLE returns the handle to a new ANNULAR_HOMOGENEOUS_CYLINDRICAL_SHELL_EXAMPLE or the handle to
%      the existing singleton*.
%
%      ANNULAR_HOMOGENEOUS_CYLINDRICAL_SHELL_EXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANNULAR_HOMOGENEOUS_CYLINDRICAL_SHELL_EXAMPLE.M with the given input arguments.
%
%      ANNULAR_HOMOGENEOUS_CYLINDRICAL_SHELL_EXAMPLE('Property','Value',...) creates a new ANNULAR_HOMOGENEOUS_CYLINDRICAL_SHELL_EXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before annular_homogeneous_cylindrical_shell_example_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to annular_homogeneous_cylindrical_shell_example_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help annular_homogeneous_cylindrical_shell_example

% Last Modified by GUIDE v2.5 03-Jun-2016 10:21:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @annular_homogeneous_cylindrical_shell_example_OpeningFcn, ...
                   'gui_OutputFcn',  @annular_homogeneous_cylindrical_shell_example_OutputFcn, ...
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


% --- Executes just before annular_homogeneous_cylindrical_shell_example is made visible.
function annular_homogeneous_cylindrical_shell_example_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to annular_homogeneous_cylindrical_shell_example (see VARARGIN)

% Choose default command line output for annular_homogeneous_cylindrical_shell_example
handles.output = hObject;


E=getappdata(0,'homogeneous_shelf_em');
if(isempty(E)==0)
    ss=sprintf('%g',E);
    set(handles.edit_em,'String',ss);
end 

rho=getappdata(0,'homogeneous_shelf_rho');
if(isempty(rho)==0)
    ss=sprintf('%g',rho);
    set(handles.edit_md,'String',ss);
end 

mu=getappdata(0,'homogeneous_shelf_mu');
if(isempty(mu)==0)
    ss=sprintf('%g',mu);
    set(handles.edit_mu,'String',ss);
end 

H=getappdata(0,'homogeneous_shelf_H');
if(isempty(H)==0)
    ss=sprintf('%g',H);
    set(handles.edit_H,'String',ss);
end 

imat=getappdata(0,'homogeneous_shelf_imat');
if(isempty(imat)==0)
    if(imat>=1 && imat<=7)
        set(handles.listbox_materials,'Value',imat);
    else
        set(handles.listbox_materials,'Value',1);
    end            
end 

NSM=getappdata(0,'shelf_NSM');
if(isempty(NSM)==0)
    ss=sprintf('%g',NSM);
    set(handles.NSM_edit,'String',ss);
end 

ndlf=getappdata(0,'shelf_ndlf');
if(isempty(ndlf)==0)
    if(ndlf>=1 && ndlf<=2)
        set(handles.listbox_dlf,'Value',ndlf);
    else
        set(handles.listbox_dlf,'Value',1);        
    end
end 

dlf=getappdata(0,'shelf_dlf');
if(isempty(dlf)==0)
    ss=sprintf('%g',mean(dlf));
    set(handles.edit_ulf,'String',ss);
end 

OD=getappdata(0,'annular_shelf_OD');
if(isempty(OD)==0)
    ss=sprintf('%g',OD);
    set(handles.edit_OD,'String',ss);
end 

ID=getappdata(0,'annular_shelf_ID');
if(isempty(ID)==0)
    ss=sprintf('%g',ID);
    set(handles.edit_ID,'String',ss);
end 

material_change(hObject, eventdata, handles)

listbox_dlf_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = annular_homogeneous_cylindrical_shell_example_OutputFcn(hObject, eventdata, handles) 
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

delete(annular_homogeneous_cylindrical_shell_example);


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


% --- Executes on selection change in listbox_materials.
function listbox_materials_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_materials contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_materials


guidata(hObject, handles);

material_change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_materials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_em_Callback(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_em as text
%        str2double(get(hObject,'String')) returns contents of edit_em as a double


% --- Executes during object creation, after setting all properties.
function edit_em_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md as text
%        str2double(get(hObject,'String')) returns contents of edit_md as a double


% --- Executes during object creation, after setting all properties.
function edit_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mu as text
%        str2double(get(hObject,'String')) returns contents of edit_mu as a double


% --- Executes during object creation, after setting all properties.
function edit_mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
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

imat=get(handles.listbox_materials,'Value');

ndlf=get(handles.listbox_dlf,'Value');

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


E=str2num(get(handles.edit_em,'String'));
rho=str2num(get(handles.edit_md,'String'));
mu=str2num(get(handles.edit_mu,'String'));

OD=str2num(get(handles.edit_OD,'String'));
ID=str2num(get(handles.edit_ID,'String'));

if(ID>=OD)
   warndlg('Diameter error'); 
   return; 
end


T=str2num(get(handles.edit_H,'String'));
H=T;

NSM=str2num(get(handles.NSM_edit,'String'));

setappdata(0,'homogeneous_shelf_em',E);
setappdata(0,'homogeneous_shelf_rho',rho);
setappdata(0,'homogeneous_shelf_mu',mu);
setappdata(0,'homogeneous_shelf_H',H);
setappdata(0,'homogeneous_shelf_imat',imat);
setappdata(0,'shelf_NSM',NSM);




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
[fcr]=critical_frequency_thin_plate(c,thick,mu,rho,em);

setappdata(0,'shelf_fcr',fcr); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
setappdata(0,'shelf_modal_density',mph);
setappdata(0,'shelf_ndlf',ndlf);
setappdata(0,'shelf_dlf',dlf);
setappdata(0,'total_shelf_thick',thick);
setappdata(0,'total_shelf_md',total_md);
setappdata(0,'shelf_cL',CL);
setappdata(0,'shelf_rad_eff',rad_eff);

setappdata(0,'annular_shelf_OD',OD);
setappdata(0,'annular_shelf_ID',ID);

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

function material_change(hObject, eventdata, handles)

iu=getappdata(0,'iu');
imat=get(handles.listbox_materials,'Value');


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


%%%%
 
[elastic_modulus,mass_density,poisson]=six_materials(iu,imat);
 
if(imat<=6)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
        ss3=sprintf('%8.4g',poisson);
else
        ss1=' ';
        ss2=' ';
        ss3=' ';        
end
 
set(handles.edit_em,'String',ss1);
set(handles.edit_md,'String',ss2); 
set(handles.edit_mu,'String',ss3);

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


% --- Executes on key press with focus on edit_em and none of its controls.
function edit_em_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_md and none of its controls.
function edit_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_mu and none of its controls.
function edit_mu_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
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



% --- Executes on key press with focus on edit_H and none of its controls.
function edit_H_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_H (see GCBO)
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
