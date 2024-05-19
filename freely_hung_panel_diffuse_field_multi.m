function varargout = freely_hung_panel_diffuse_field_multi(varargin)
% FREELY_HUNG_PANEL_DIFFUSE_FIELD_MULTI MATLAB code for freely_hung_panel_diffuse_field_multi.fig
%      FREELY_HUNG_PANEL_DIFFUSE_FIELD_MULTI, by itself, creates a new FREELY_HUNG_PANEL_DIFFUSE_FIELD_MULTI or raises the existing
%      singleton*.
%
%      H = FREELY_HUNG_PANEL_DIFFUSE_FIELD_MULTI returns the handle to a new FREELY_HUNG_PANEL_DIFFUSE_FIELD_MULTI or the handle to
%      the existing singleton*.
%
%      FREELY_HUNG_PANEL_DIFFUSE_FIELD_MULTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FREELY_HUNG_PANEL_DIFFUSE_FIELD_MULTI.M with the given input arguments.
%
%      FREELY_HUNG_PANEL_DIFFUSE_FIELD_MULTI('Property','Value',...) creates a new FREELY_HUNG_PANEL_DIFFUSE_FIELD_MULTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before freely_hung_panel_diffuse_field_multi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to freely_hung_panel_diffuse_field_multi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help freely_hung_panel_diffuse_field_multi

% Last Modified by GUIDE v2.5 16-Jan-2016 14:11:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @freely_hung_panel_diffuse_field_multi_OpeningFcn, ...
                   'gui_OutputFcn',  @freely_hung_panel_diffuse_field_multi_OutputFcn, ...
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


% --- Executes just before freely_hung_panel_diffuse_field_multi is made visible.
function freely_hung_panel_diffuse_field_multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to freely_hung_panel_diffuse_field_multi (see VARARGIN)

% Choose default command line output for freely_hung_panel_diffuse_field_multi
handles.output = hObject;

change(hObject, eventdata, handles);
listbox_structure_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes freely_hung_panel_diffuse_field_multi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = freely_hung_panel_diffuse_field_multi_OutputFcn(hObject, eventdata, handles) 
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

delete(freely_hung_panel_diffuse_field_multi);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

sz=size(THM);

if(sz(2)~=3)
    warndlg('Input file must have 3 columns ');
    return;
end

disp(' ');
disp(' * * * ');
disp('  ');

ns=get(handles.listbox_structure,'value');

iu=get(handles.listbox_units,'Value');

pu=get(handles.listbox_pu,'Value');
   
fc=THM(:,1);
lf=THM(:,3);
    
NL=length(fc);

if(pu==1)
    dB=THM(:,2);  
     
    [pressure]=convert_dB_pressure_alt(dB,iu);
else
    pressure=THM(:,2);    
end

setappdata(0,'iu',iu);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

em=str2num(get(handles.edit_em,'String'));
md=str2num(get(handles.edit_md,'String'));
mu=str2num(get(handles.edit_mu,'String')); 

c=str2num(get(handles.edit_c,'String')); 
gas_md=str2num(get(handles.edit_gas_md,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    md=md/386;
    c=c*12;
    
    [gas_md]=lbm_per_ft3_to_lbf_sec2_per_in4(gas_md);
    
else
    [em]=GPa_to_Pa(em);
end

rho_c=c*gas_md;

display_gas_acoustic_impedance(iu,rho_c);

thick=str2num(get(handles.edit_thick,'String'));
L=str2num(get(handles.edit_L,'String'));
W=str2num(get(handles.edit_W,'String'));

Ap=L*W;

if(iu==2)
    thick=thick/1000; 
end
   
mass=md*thick*L*W;

rho=md;
        
[fcr]=critical_frequency_thin_plate(c,thick,mu,rho,em);

[CL]=CL_plate(em,rho,mu);

rho_s=md*thick;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Thin Panel
   
%    L = length
%    W = width
%    c = speed of sound
%    fcr = critical frequency

v=zeros(NL,1);
rad_eff=zeros(NL,1);

for i=1:NL
    
    freq=fc(i);

    [rad_eff(i)]=re_thin_plate_free(freq,fcr,L,W,c);
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    omega=tpi*freq;

    anum=sqrt(12)*pi*c^2;
    aden=2*rho_c*thick*CL*rho_s*omega^2;

    bden= 1 + (rho_s*omega*lf(i))/(2*rho_c*rad_eff(i));

    v2=(pressure(i)^2)*(anum/aden)*(1 / bden);

    v(i)=sqrt(v2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    radiation_resistance=rho_c*Ap*rad_eff;
    clf=radiation_resistance/(mass*tpi*freq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

scf=str2num(get(handles.edit_scf,'String'));

K=sqrt(3);
strain=(K/CL)*v;
stress=em*strain*scf;

stress=fix_size(stress);
strain=fix_size(strain);

if(iu==2)
    v=v*1000;
end

out1=sprintf(' Critical Frequency = %8.4g Hz \n',fcr);
disp(out1);

out1=sprintf(' Stress Concentration Factor = %g \n',scf);
disp(out1);

disp(' Stress is Free Field ');
disp(' ');
disp(' Both velocity and stress are RMS ');

disp(' ');
    disp(' Freq     Velocity    Stress     Radiation');

if(iu==1)
    disp('  (Hz)    (in/sec)    (psi)      Efficiency'); 
else
    disp('  (Hz)    (mm/sec)    (Pa)       Efficiency');    
end

a=zeros(NL,1);

for i=1:NL
   fprintf(' %g    %8.4g    %8.4g    %7.3g \n',fc(i),v(i),stress(i),rad_eff(i));
   a(i)=v(i)*(2*pi*fc(i));
end

if(iu==1)
    a(i)=a(i)/386;
else
    a(i)=a(i)/9810;
end

arms=sqrt(sum(a.^2));
vrms=sqrt(sum(v.^2));
prms=sqrt(sum(stress.^2));

disp(' ');
if(iu==1)
    out1=sprintf(' Overall Acceleration = %7.3g GRMS',arms);
else
    out1=sprintf(' Overall Acceleration = %7.3g m/sec^2 RMS',arms);    
end    
disp(out1);

if(iu==1)
    out1=sprintf(' Overall Velocity = %7.3g in/sec RMS',vrms);
else
    out1=sprintf(' Overall Velocity = %7.3g mm/sec RMS',vrms);    
end    
disp(out1);

if(iu==1)
    out1=sprintf(' Overall Stress   = %7.3g psi RMS',prms);
else
    out1=sprintf(' Overall Stress   = %7.3g Pa RMS',prms);    
end    
disp(out1);

accel_ps=[fc a];
vel_ps=[fc v];
stress_ps=[fc stress];
rad_eff=[fc rad_eff];

assignin('base', 'vel_ps',vel_ps);
assignin('base', 'stress_ps',stress_ps);
assignin('base', 'rad_eff',rad_eff);

%%%
%
%  plots
%
md=4;
fig_num=1;
fmin=min(fc);
fmax=max(fc);
x_label='Frequency (Hz)';

if(pu==1) % dB
    nb=get(handles.listbox_band,'Value');

    if(nb<=2)
        n_type=nb; 
        [fig_num]=spl_plot(fig_num,n_type,fc,dB);
    end    

else
    
    t_string='Acoustic Pressure';
    if(iu==1)
        y_label='Pressure (psi)';
    else
        y_label='Pressure (Pa)';    
    end   
    ppp=[fc THM(:,2)];
    [fig_num,h2]=...
        plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    
    
end        


t_string='Panel Loss Factor';
y_label='Loss Factor';
ppp=[fc lf];
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


t_string='Panel Acceleration';
if(iu==1)
    y_label='Accel (G)';
else
    y_label='Accel (G)';    
end   
ppp=accel_ps;
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

t_string='Panel Velocity';
if(iu==1)
    y_label='Vel (in/sec)';
else
    y_label='Vel (mm/sec)';    
end   
ppp=vel_ps;
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


t_string='Panel Stress';
if(iu==1)
    y_label='Stress (psi)';
else
    y_label='Stress (Pa)';    
end   
ppp=stress_ps;
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


t_string='Radiation Efficiency';
y_label='Radiation Efficiency';
ppp=rad_eff;
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


%%%

if(pu~=1)
   disp(' '); 
end

disp(' Output Arrays ');
disp('   Power Spectra:  vel_ps & stress_ps ');
disp('   Radiation Efficiency:  rad_eff ');

%%%

msgbox('Results written to Command Window');


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

n=get(handles.listbox_structure,'Value');



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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material
change(hObject, eventdata, handles);

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


function change(hObject, eventdata, handles)
%
iu=get(handles.listbox_units,'Value');

imat=get(handles.listbox_material,'Value');

ng=get(handles.listbox_gas,'Value');


%%%


set(handles.text_material,'String','Select Material');


set(handles.text_thick,'Visible','on');
set(handles.edit_thick,'Visible','on');

set(handles.listbox_pu, 'String', '');
string_th{1}=sprintf('dB ref 20 micro Pa');

if(iu==1)  % English   
    

    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_thick,'String','Thickness (in)');
    set(handles.text_L,'String','Length (in)');
    set(handles.text_W,'String','Width (in)');
    
    set(handles.text_gas_md,'String','Gas Mass Density (lbm/ft^3)'); 
    set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)'); 

    
    if(ng==1)
        set(handles.edit_c,'String','1125');
        set(handles.edit_gas_md,'String','0.076487');       
    else
        set(handles.edit_c,'String',' ');   
        set(handles.edit_gas_md,'String',' ');        
    end
       
    string_th{2}=sprintf('psi rms');    

    
else
    
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');   
    set(handles.text_thick,'String','Thickness (mm)');        
    set(handles.text_L,'String','Length (m)');
    set(handles.text_W,'String','Width (m)');  
    
    set(handles.text_gas_md,'String','Gas Mass Density (kg/m^3)');    
    set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
   
    
    if(ng==1)
        set(handles.edit_c,'String','343');  
        set(handles.edit_gas_md,'String','1.225');         
    else
        set(handles.edit_c,'String',' ');      
        set(handles.edit_gas_md,'String',' ');          
    end    

    string_th{2}=sprintf('Pa rms');       
    
end

set(handles.listbox_pu,'String',string_th)

%%%%%%%%%%%%%%   

[elastic_modulus,mass_density,poisson]=six_materials(iu,imat);
 
%%%%
 
 
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

%%%


% --- Executes on selection change in listbox_cross.
function listbox_cross_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cross contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cross
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_cross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_r1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_r1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_r1 as text
%        str2double(get(hObject,'String')) returns contents of edit_r1 as a double


% --- Executes during object creation, after setting all properties.
function edit_r1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_r1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_r2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_r2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_r2 as text
%        str2double(get(hObject,'String')) returns contents of edit_r2 as a double


% --- Executes during object creation, after setting all properties.
function edit_r2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_r2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_area_Callback(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_area as text
%        str2double(get(hObject,'String')) returns contents of edit_area as a double


% --- Executes during object creation, after setting all properties.
function edit_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_I_Callback(hObject, eventdata, handles)
% hObject    handle to edit_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_I as text
%        str2double(get(hObject,'String')) returns contents of edit_I as a double


% --- Executes during object creation, after setting all properties.
function edit_I_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_I (see GCBO)
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



function edit_Ix_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Ix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Ix as text
%        str2double(get(hObject,'String')) returns contents of edit_Ix as a double


% --- Executes during object creation, after setting all properties.
function edit_Ix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Ix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Iy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Iy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Iy as text
%        str2double(get(hObject,'String')) returns contents of edit_Iy as a double


% --- Executes during object creation, after setting all properties.
function edit_Iy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Iy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function intermediate_print(hObject, eventdata, handles)
%
    iu=getappdata(0,'iu');
    ns=getappdata(0,'ns');
    nc=getappdata(0,'nc');
    imat=getappdata(0,'imat');

    if(imat==1)
        disp('Aluminum');
    end    
    if(imat==2)
        disp('Steel');
    end    
    if(imat==3)
        disp('Copper');
    end    
    if(imat==4)
        disp('G10');
    end    
    if(imat==5)
        disp('Other Material');
    end        
    
    



% --- Executes on selection change in listbox_band.
function listbox_band_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band


% --- Executes during object creation, after setting all properties.
function listbox_band_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material_2.
function listbox_material_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material_2


% --- Executes during object creation, after setting all properties.
function listbox_material_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_em_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_em_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_em_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_em_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_em_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_em_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_md_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_md_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thick_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thick_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thick_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_thick_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_thick_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thick_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thick_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thick as text
%        str2double(get(hObject,'String')) returns contents of edit_thick as a double


% --- Executes during object creation, after setting all properties.
function edit_thick_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mu_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mu_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mu_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_mu_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_mu_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end










% --- Executes on selection change in listbox_structure.
function listbox8_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_structure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_structure


% --- Executes during object creation, after setting all properties.
function listbox8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_fcr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fcr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fcr as text
%        str2double(get(hObject,'String')) returns contents of edit_fcr as a double


% --- Executes during object creation, after setting all properties.
function edit_fcr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fcr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_gas_md and none of its controls.
function edit_gas_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_em and none of its controls.
function edit_em_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_md and none of its controls.
function edit_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_mu and none of its controls.
function edit_mu_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




function edit_h_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h as text
%        str2double(get(hObject,'String')) returns contents of edit_h as a double


% --- Executes during object creation, after setting all properties.
function edit_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fct_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fct as text
%        str2double(get(hObject,'String')) returns contents of edit_fct as a double


% --- Executes during object creation, after setting all properties.
function edit_fct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_core_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md_core (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md_core as text
%        str2double(get(hObject,'String')) returns contents of edit_md_core as a double


% --- Executes during object creation, after setting all properties.
function edit_md_core_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md_core (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_W_Callback(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_W as text
%        str2double(get(hObject,'String')) returns contents of edit_W as a double


% --- Executes during object creation, after setting all properties.
function edit_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_bc.
function listbox_bc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bc


% --- Executes during object creation, after setting all properties.
function listbox_bc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on button press in pushbutton_re.
function pushbutton_re_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_re (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_structure,'Value');

if(n==1) 
     A = imread('re_free_panel.jpg');
     figure(998) 
     imshow(A,'border','tight','InitialMagnification',100)    
else
    A = imread('free_panel_velox.jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100)     
end


% --- Executes on button press in pushbutton_rr.
function pushbutton_rr_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    A = imread('freely_hung_panel_diffuse_field.jpg');
    figure(997) 
    imshow(A,'border','tight','InitialMagnification',100)


% --- Executes on button press in pushbutton_clf.
function pushbutton_clf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L as text
%        str2double(get(hObject,'String')) returns contents of edit_L as a double


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit_pressure_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pressure as text
%        str2double(get(hObject,'String')) returns contents of edit_pressure as a double


% --- Executes during object creation, after setting all properties.
function edit_pressure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
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


% --- Executes on selection change in listbox_pu.
function listbox_pu_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pu


% --- Executes during object creation, after setting all properties.
function listbox_pu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
