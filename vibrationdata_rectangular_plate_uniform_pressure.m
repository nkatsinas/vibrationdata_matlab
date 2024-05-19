function varargout = vibrationdata_rectangular_plate_uniform_pressure(varargin)
% VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE MATLAB code for vibrationdata_rectangular_plate_uniform_pressure.fig
%      VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE, by itself, creates a new VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE returns the handle to a new VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE.M with the given input arguments.
%
%      VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE('Property','Value',...) creates a new VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_rectangular_plate_uniform_pressure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_rectangular_plate_uniform_pressure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_rectangular_plate_uniform_pressure

% Last Modified by GUIDE v2.5 03-Aug-2021 15:37:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_rectangular_plate_uniform_pressure_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_rectangular_plate_uniform_pressure_OutputFcn, ...
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


% --- Executes just before vibrationdata_rectangular_plate_uniform_pressure is made visible.
function vibrationdata_rectangular_plate_uniform_pressure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_rectangular_plate_uniform_pressure (see VARARGIN)

% Choose default command line output for vibrationdata_rectangular_plate_uniform_pressure
handles.output = hObject;

change_unit_material(hObject, eventdata, handles);

set(handles.pushbutton_apply_pressure,'Enable','off');

set(handles.edit_NSM,'String','0');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_rectangular_plate_uniform_pressure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_rectangular_plate_uniform_pressure_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_rectangular_plate_uniform_pressure);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change_unit_material(hObject, eventdata, handles);
set(handles.pushbutton_apply_pressure,'Enable','off');


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
set(handles.pushbutton_apply_pressure,'Enable','off');



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
set(handles.pushbutton_apply_pressure,'Enable','off');


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
n_unit=get(handles.listbox_units,'Value');
n_mat=get(handles.listbox_materials,'Value');

if(n_unit==1)
    set(handles.text_length,'String','Length (in)');
    set(handles.text_width,'String','width (in)');
    set(handles.text_X,'String','X (in)');
    set(handles.text_Y,'String','Y (in)');    
    set(handles.text_thickness,'String','Thickness (in)');
    set(handles.text_elastic_modulus,'String','Elastic Modulus (psi)');
    set(handles.text_rho,'String','Mass Density (lbm/in^3)');
    set(handles.text_NSM,'String','Nonstructural Mass (lbm)');    
else
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






% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    

fig_num=1;
setappdata(0,'fig_num',1);


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

damp=1/(2*Q);


if(n_units==1)
    rho=rho/386;
    NSM=NSM/386;
else
    [E]=GPa_to_Pa(E);
    h=h/1000;
end
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
    [disp_transfer,von_Mises_stress_transfer,f,HM_stress_xx,HM_stress_yy,HM_stress_xy]=...
    ss_ss_ss_ss_plate_uniform(E,D,rho,h,a,b,mu,mass_per_area,damp,MAXF,fig_num,n_units,x,y);    
%
else
%
    [fn,zzr,fig_num,P,dPdx,d2Pdx2,W,dWdy,d2Wdy2,norm,PF]=...
    fixed_fixed_fixed_fixed_plate_Rayleigh(D,rho,h,a,b,mu,mass_per_area,fig_num);
%
    [disp_transfer,von_Mises_stress_transfer,f,HM_stress_xx,HM_stress_yy,HM_stress_xy]=...
    fixed_fixed_fixed_fixed_plate_pressure_alt(E,rho,mu,a,b,h,...
    fn,fig_num,P,dPdx,d2Pdx2,W,dWdy,d2Wdy2,norm,PF,damp,x,y,MAXF,n_units); 


%
end

try
    
    clear length;
    num=length(f);
    HM_disp_2=zeros(num,1);
    HM_stress_vM2=zeros(num,1);
    HM_stress_xx2=zeros(num,1);
    HM_stress_yy2=zeros(num,1);
    HM_stress_xy2=zeros(num,1);

%
    for i=1:num
        HM_disp_2(i)=disp_transfer(i,2)^2;
        HM_stress_vM2(i)=von_Mises_stress_transfer(i,2)^2;
        HM_stress_xx2(i)=HM_stress_xx(i)^2;
        HM_stress_yy2(i)=HM_stress_yy(i)^2;
        HM_stress_xy2(i)=HM_stress_xy(i)^2;  
    end    
     
    disp_power_trans=[f HM_disp_2];    
    vM_power_trans=[f HM_stress_vM2]; 
    Hxx_power_trans=[f HM_stress_xx2]; 
    Hyy_power_trans=[f HM_stress_yy2]; 
    Hxy_power_trans=[f HM_stress_xy2];

catch
end

%
try
    setappdata(0,'displacement_transfer',disp_transfer); 
    setappdata(0,'displacement_power_transfer',disp_power_trans); 
    setappdata(0,'stress_transfer',von_Mises_stress_transfer); 
catch
end
    
try
    setappdata(0,'stress_power_transfer',vM_power_trans);
    setappdata(0,'Hxx_power_trans',Hxx_power_trans);
    setappdata(0,'Hyy_power_trans',Hyy_power_trans);
    setappdata(0,'Hxy_power_trans',Hxy_power_trans);
catch
end

setappdata(0,'x',x); 
setappdata(0,'y',y); 
setappdata(0,'n_units',n_units);


set(handles.pushbutton_apply_pressure,'Enable','on');


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


% --- Executes on button press in pushbutton_response_PSD.
function pushbutton_response_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_response_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_input_trans_mult;                  
       
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_apply_pressure.
function pushbutton_apply_pressure_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_apply_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vibrationdata_rectangular_plate_uniform_pressure_PSD;


% --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_apply_pressure,'Enable','off');


% --- Executes on key press with focus on edit_poisson_ratio and none of its controls.
function edit_poisson_ratio_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson_ratio (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_apply_pressure,'Enable','off');


% --- Executes on key press with focus on edit_length and none of its controls.
function edit_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_apply_pressure,'Enable','off');


% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_apply_pressure,'Enable','off');


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_apply_pressure,'Enable','off');


% --- Executes on key press with focus on edit_X and none of its controls.
function edit_X_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_X (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_apply_pressure,'Enable','off');


% --- Executes on key press with focus on edit_Y and none of its controls.
function edit_Y_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_apply_pressure,'Enable','off');


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_apply_pressure,'Enable','off');


% --- Executes on key press with focus on edit_MAXF and none of its controls.
function edit_MAXF_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_MAXF (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_apply_pressure,'Enable','off');


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    iu=get(handles.listbox_units,'Value');
    plate_pressure.iu=iu;
catch
end

try
    BC=get(handles.listbox_BC,'Value');
    plate_pressure.BC=BC;
catch
end

try
    mat=get(handles.listbox_materials,'Value');
    plate_pressure.mat=mat;
catch
end
try
    L=get(handles.edit_length,'String');
    plate_pressure.L=L;
catch
end
try
    width=get(handles.edit_width,'String');
    plate_pressure.width=width;
catch
end
try
    thickness=get(handles.edit_thickness,'String');
    plate_pressure.thickness=thickness;
catch
end
try
    X=get(handles.edit_X,'String');
    plate_pressure.X=X;
catch
end
try
    Y=get(handles.edit_Y,'String');
    plate_pressure.Y=Y;
catch
end
try
    Q=get(handles.edit_Q,'String');
    plate_pressure.Q=Q;
catch
end
try
    MAXF=get(handles.edit_MAXF,'String');
    plate_pressure.MAXF=MAXF;
catch
end
try
    elastic_modulus=get(handles.edit_elastic_modulus,'String');
    plate_pressure.elastic_modulus=elastic_modulus;
catch
end
try
    poisson_ratio=get(handles.edit_poisson_ratio,'String');
    plate_pressure.poisson_ratio=poisson_ratio;
catch
end
try
    rho=get(handles.edit_rho,'String');
    plate_pressure.rho=rho;
catch
end
try
    NSM=get(handles.edit_NSM,'String');
    plate_pressure.NSM=NSM;
catch
end

% % %
 
 structnames = fieldnames(plate_pressure, '-full'); % fields in the struct
  
% % %
 
    [writefname, writepname] = uiputfile('*.mat','Save data as');
   
    elk=sprintf('%s%s',writepname,writefname);

try
    save(elk, 'plate_pressure'); 
catch
    warndlg('Save error');
    return;
end
 
disp(' ');
out1=sprintf('Save Complete: %s',writefname);
disp(out1);
msgbox(out1);




% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat', 'Select plot save file');

NAME = [pathname,filename];

struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try
   plate_pressure=evalin('base','plate_pressure');
catch
   warndlg(' evalin failed ');
   setappdata(0,'eflag',1);   
   return;
end

%%%%%%%%%%%%

%%%%%


try
    iu=plate_pressure.iu;    
    set(handles.listbox_units,'Value',iu);
catch
end

try
    BC=plate_pressure.BC;    
    set(handles.listbox_BC,'Value',BC);
catch
end

try
    mat=plate_pressure.mat;    
    set(handles.listbox_materials,'Value',mat);
catch
end

listbox_units_Callback(hObject, eventdata, handles);
listbox_materials_Callback(hObject, eventdata, handles)



try
    L=plate_pressure.L;    
    set(handles.edit_length,'String',L);
catch
end
try
    width=plate_pressure.width;    
    set(handles.edit_width,'String',width);
catch
end
try
    thickness=plate_pressure.thickness;    
    set(handles.edit_thickness,'String',thickness);
catch
end
try
    X=plate_pressure.X;    
    set(handles.edit_X,'String',X);
catch
end
try
    Y=plate_pressure.Y;    
    set(handles.edit_Y,'String',Y);
catch
end
try
    Q=plate_pressure.Q;    
    set(handles.edit_Q,'String',Q);
catch
end
try
    MAXF=plate_pressure.MAXF;    
    set(handles.edit_MAXF,'String',MAXF);
catch
end
try
    elastic_modulus=plate_pressure.elastic_modulus;    
    set(handles.edit_elastic_modulus,'String',elastic_modulus);
catch
end
try
    poisson_ratio=plate_pressure.poisson_ratio;    
    set(handles.edit_poisson_ratio,'String',poisson_ratio);
catch
end
try
    rho=plate_pressure.rho;    
    set(handles.edit_rho,'String',rho);
catch
end
try
    NSM=plate_pressure.NSM;    
    set(handles.edit_NSM,'String',NSM);
catch
end
