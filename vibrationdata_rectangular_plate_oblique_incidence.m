function varargout = vibrationdata_rectangular_plate_oblique_incidence(varargin)
% VIBRATIONDATA_RECTANGULAR_PLATE_OBLIQUE_INCIDENCE MATLAB code for vibrationdata_rectangular_plate_oblique_incidence.fig
%      VIBRATIONDATA_RECTANGULAR_PLATE_OBLIQUE_INCIDENCE, by itself, creates a new VIBRATIONDATA_RECTANGULAR_PLATE_OBLIQUE_INCIDENCE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RECTANGULAR_PLATE_OBLIQUE_INCIDENCE returns the handle to a new VIBRATIONDATA_RECTANGULAR_PLATE_OBLIQUE_INCIDENCE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RECTANGULAR_PLATE_OBLIQUE_INCIDENCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RECTANGULAR_PLATE_OBLIQUE_INCIDENCE.M with the given input arguments.
%
%      VIBRATIONDATA_RECTANGULAR_PLATE_OBLIQUE_INCIDENCE('Property','Value',...) creates a new VIBRATIONDATA_RECTANGULAR_PLATE_OBLIQUE_INCIDENCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_rectangular_plate_oblique_incidence_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_rectangular_plate_oblique_incidence_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_rectangular_plate_oblique_incidence

% Last Modified by GUIDE v2.5 29-Dec-2014 12:30:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_rectangular_plate_oblique_incidence_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_rectangular_plate_oblique_incidence_OutputFcn, ...
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


% --- Executes just before vibrationdata_rectangular_plate_oblique_incidence is made visible.
function vibrationdata_rectangular_plate_oblique_incidence_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_rectangular_plate_oblique_incidence (see VARARGIN)

% Choose default command line output for vibrationdata_rectangular_plate_oblique_incidence
handles.output = hObject;


change_unit_material(hObject, eventdata, handles);

set(handles.edit_NSM,'String','0');

set(handles.pushbutton_apply_spl,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_rectangular_plate_oblique_incidence wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_rectangular_plate_oblique_incidence_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_rectangular_plate_oblique_incidence);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change_unit_material(hObject, eventdata, handles);

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


% --- Executes on selection change in listbox_BC.
function listbox_BC_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_BC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_BC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_BC


% --- Executes during object creation, after setting all properties.
function listbox_BC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_BC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

c=str2num(get(handles.edit_c,'String'));

n_units=get(handles.listbox_units,'Value');
   n_BC=get(handles.listbox_BC,'Value');
  n_mat=get(handles.listbox_materials,'Value');

a=str2num(get(handles.edit_length,'String'));
b=str2num(get(handles.edit_width,'String'));
h=str2num(get(handles.edit_thickness,'String'));
x=str2num(get(handles.edit_X,'String'));
y=str2num(get(handles.edit_Y,'String'));
E=str2num(get(handles.edit_elastic_modulus,'String'));
mu=str2num(get(handles.edit_poisson_ratio,'String'));
rho=str2num(get(handles.edit_rho,'String'));
NSM=str2num(get(handles.edit_NSM,'String'));
Q=str2num(get(handles.edit_Q,'String'));
MAXF=str2num(get(handles.edit_MAXF,'String'));
MINF=str2num(get(handles.edit_MINF,'String'));

theta=str2num(get(handles.edit_theta,'String'));

damp=1/(2*Q);


if(n_units==1)
    rho=rho/386;
    NSM=NSM/386;
    C=13500. % speed of sound in/sec
else
    [E]=GPa_to_Pa(E);
    h=h/1000;
    C=343;  % speed of sound m/sec
end
%
CL=sqrt(E/rho);   % longitudinal wave speed in material
%
area=a*b;
vol=area*h;
%
rho=rho+(NSM/vol);
%
total_mass=rho*vol;
mass_per_area=total_mass/area;
%
if(n_units==1)
    total_mass=total_mass*386;
end    
%
D=E*h^3/(12*(1.-mu^2));

fig_num=1;

if(n_BC==1)
%    
    [disp_transfer,von_Mises_stress_transfer,f]=...
    ss_ss_ss_ss_plate_oblique(E,D,rho,h,a,b,mu,mass_per_area,damp,x,y,MINF,MAXF,fig_num,theta,c,n_units);    
%
else
%
%% [fn,zzr,fig_num,P,dPdx,d2Pdx2,W,dWdy,d2Wdy2,norm,PF]=...
%%   fixed_fixed_fixed_fixed_plate_Rayleigh(D,rho,h,a,b,mu,mass_per_area,fig_num);
%
%%    [disp_transfer,von_Mises_stress_transfer,f]=...
%%    fixed_fixed_fixed_fixed_plate_pressure_alt(E,rho,mu,a,b,h,D,...
%%   fn,zzr,fig_num,P,dPdx,d2Pdx2,W,dWdy,d2Wdy2,norm,PF,damp,x,y,MAXF); 
%
end

clear length;
num=length(f);
HM_disp_2=zeros(num,1);
HM_stress_vM2=zeros(num,1);
%
for i=1:num
    HM_disp_2(i)=disp_transfer(i,2)^2;
    HM_stress_vM2(i)=von_Mises_stress_transfer(i,2)^2;
end    
     
HM_disp_2=fix_size(HM_disp_2);
HM_stress_vM2=fix_size(HM_stress_vM2);
    
disp_power_trans=[f HM_disp_2];    
vM_power_trans=[f HM_stress_vM2]; 
%
setappdata(0,'displacement_transfer',disp_transfer); 
setappdata(0,'displacement_power_transfer',disp_power_trans); 
setappdata(0,'stress_transfer',von_Mises_stress_transfer); 
setappdata(0,'stress_power_transfer',vM_power_trans);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('  ');
disp(' ************** ');
disp(' ');
disp(' Frequency parameters for plate with large surface area and with ');
disp(' air as the surrounding medium.');
disp(' ');
disp(' The critical frequency is the frequency at which the speed of the ');
disp(' free bending wave in a structure becomes equal to the speed of the ');
disp(' airborne acoustic wave.');

fcr=C^2/(1.8*CL*h);
out1=sprintf('\n    Critical Frequency = %8.4g Hz',fcr);
disp(out1);

if(theta>0.001)
    disp('  ');
    disp(' The coincidence frequency is the frequency at which the forced ');
    disp(' bending wave speed equals the free bending wave speed. ');
    disp(' ');
    fco=fcr/(sin(theta))^2;
    out2=sprintf(' Coincidence Frequency = %8.4g Hz',fco);
    disp(out2);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function edit_output_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_output_filename as a double


% --- Executes during object creation, after setting all properties.
function edit_output_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
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

n=get(handles.listbox_save,'Value');


if(n==1)
    data=getappdata(0,'displacement_transfer');
end  
if(n==2)
    data=getappdata(0,'displacement_power_transfer');
end
if(n==3)
    data=getappdata(0,'stress_transfer');
end  
if(n==4)
    data=getappdata(0,'stress_power_transfer');
end


sz=size(data);

if(max(sz)==0)
    h = msgbox('Data size is zero ');    
else
    output_name=get(handles.edit_output_filename,'String');
    assignin('base', output_name,data);
    h = msgbox('Export Complete.  Press Return. ');
end

set(handles.pushbutton_apply_spl,'Visible','on');


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
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



function edit_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_X_Callback(hObject, eventdata, handles)
% hObject    handle to edit_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_X as text
%        str2double(get(hObject,'String')) returns contents of edit_X as a double


% --- Executes during object creation, after setting all properties.
function edit_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Y as text
%        str2double(get(hObject,'String')) returns contents of edit_Y as a double


% --- Executes during object creation, after setting all properties.
function edit_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_MAXF_Callback(hObject, eventdata, handles)
% hObject    handle to edit_MAXF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_MAXF as text
%        str2double(get(hObject,'String')) returns contents of edit_MAXF as a double


% --- Executes during object creation, after setting all properties.
function edit_MAXF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_MAXF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_NSM_Callback(hObject, eventdata, handles)
% hObject    handle to edit_NSM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_NSM as text
%        str2double(get(hObject,'String')) returns contents of edit_NSM as a double


% --- Executes during object creation, after setting all properties.
function edit_NSM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_NSM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho as text
%        str2double(get(hObject,'String')) returns contents of edit_rho as a double


% --- Executes during object creation, after setting all properties.
function edit_rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_elastic_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_elastic_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

change_unit_material(hObject, eventdata, handles);


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



function edit_poisson_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to edit_poisson_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poisson_ratio as text
%        str2double(get(hObject,'String')) returns contents of edit_poisson_ratio as a double


% --- Executes during object creation, after setting all properties.
function edit_poisson_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function change_unit_material(hObject, eventdata, handles)
%
set(handles.pushbutton_apply_spl,'Visible','off');

n_unit=get(handles.listbox_units,'Value');
n_mat=get(handles.listbox_materials,'Value');

if(n_unit==1)
    set(handles.text_c,'String','Speed of Sound (in/sec)');
    set(handles.edit_c,'String','13400');    
    set(handles.text_length,'String','Length (in)');
    set(handles.text_width,'String','width (in)');
    set(handles.text_X,'String','X (in)');
    set(handles.text_Y,'String','Y (in)');    
    set(handles.text_thickness,'String','Thickness (in)');
    set(handles.text_elastic_modulus,'String','Elastic Modulus (psi)');
    set(handles.text_rho,'String','Mass Density (lbm/in^3)');
    set(handles.text_NSM,'String','Nonstructural Mass (lbm)');    
else
    set(handles.text_c,'String','Speed of Sound (m/sec)'); 
    set(handles.edit_c,'String','343');    
    set(handles.text_length,'String','Length (m)');
    set(handles.text_width,'String','width (m)');
    set(handles.text_X,'String','X (m)');
    set(handles.text_Y,'String','Y (m)');    
    set(handles.text_thickness,'String','Thickness (mm)');    
    set(handles.text_elastic_modulus,'String','Elastic Modulus (Gpa)'); 
    set(handles.text_rho,'String','Mass Density (kg/m^3)');   
    set(handles.text_NSM,'String','Nonstructural Mass (kg)');     
end


if(n_unit==1)  % English
    if(n_mat==1) % aluminum
        E=1e+007;
        rho=0.1;  
    end  
    if(n_mat==2)  % steel
        E=3e+007;
        rho= 0.28;         
    end
    if(n_mat==3)  % copper
        E=1.6e+007;
        rho=  0.322;
    end
    if(n_mat==4)  % G10
        E=2.7e+006;
        rho=  0.065;
    end
else                 % metric
    if(n_mat==1)  % aluminum
        E=70;
        rho=  2700;
    end
    if(n_mat==2)  % steel
        E=205;
        rho=  7700;        
    end
    if(n_mat==3)   % copper
        E=110;
        rho=  8900;
    end
    if(n_mat==4)  % G10
        E=18.6;
        rho=  1800;
    end
end
 
if(n_mat==1) % aluminum
        mu=0.33;  
end  
if(n_mat==2)  % steel
        mu=0.30;         
end
if(n_mat==3)  % copper
        mu=0.33;
end
if(n_mat==4)  % G10
        mu=0.12;
end

if(n_mat<5)
    ss1=sprintf('%8.4g',E);
    ss2=sprintf('%8.4g',rho);
    ss3=sprintf('%8.4g',mu);  
 
    set(handles.edit_elastic_modulus,'String',ss1);
    set(handles.edit_rho,'String',ss2);  
    set(handles.edit_poisson_ratio,'String',ss3);  
end



function edit_theta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta as text
%        str2double(get(hObject,'String')) returns contents of edit_theta as a double


% --- Executes during object creation, after setting all properties.
function edit_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta (see GCBO)
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


% --- Executes on button press in pushbutton_view_diagram.
function pushbutton_view_diagram_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_diagram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=oblique_incidence_image;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_apply_spl.
function pushbutton_apply_spl_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_apply_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_apply_spl;    
set(handles.s,'Visible','on'); 



function edit_MINF_Callback(hObject, eventdata, handles)
% hObject    handle to edit_MINF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_MINF as text
%        str2double(get(hObject,'String')) returns contents of edit_MINF as a double


% --- Executes during object creation, after setting all properties.
function edit_MINF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_MINF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
