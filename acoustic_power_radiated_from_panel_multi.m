function varargout = acoustic_power_radiated_from_panel_multi(varargin)
% ACOUSTIC_POWER_RADIATED_FROM_PANEL_MULTI MATLAB code for acoustic_power_radiated_from_panel_multi.fig
%      ACOUSTIC_POWER_RADIATED_FROM_PANEL_MULTI, by itself, creates a new ACOUSTIC_POWER_RADIATED_FROM_PANEL_MULTI or raises the existing
%      singleton*.
%
%      H = ACOUSTIC_POWER_RADIATED_FROM_PANEL_MULTI returns the handle to a new ACOUSTIC_POWER_RADIATED_FROM_PANEL_MULTI or the handle to
%      the existing singleton*.
%
%      ACOUSTIC_POWER_RADIATED_FROM_PANEL_MULTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACOUSTIC_POWER_RADIATED_FROM_PANEL_MULTI.M with the given input arguments.
%
%      ACOUSTIC_POWER_RADIATED_FROM_PANEL_MULTI('Property','Value',...) creates a new ACOUSTIC_POWER_RADIATED_FROM_PANEL_MULTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before acoustic_power_radiated_from_panel_multi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to acoustic_power_radiated_from_panel_multi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help acoustic_power_radiated_from_panel_multi

% Last Modified by GUIDE v2.5 15-Jan-2016 10:10:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @acoustic_power_radiated_from_panel_multi_OpeningFcn, ...
                   'gui_OutputFcn',  @acoustic_power_radiated_from_panel_multi_OutputFcn, ...
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


% --- Executes just before acoustic_power_radiated_from_panel_multi is made visible.
function acoustic_power_radiated_from_panel_multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to acoustic_power_radiated_from_panel_multi (see VARARGIN)

% Choose default command line output for acoustic_power_radiated_from_panel_multi
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes acoustic_power_radiated_from_panel_multi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = acoustic_power_radiated_from_panel_multi_OutputFcn(hObject, eventdata, handles) 
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

delete(acoustic_power_radiated_from_panel_multi);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
%%%%%%%%%%%%%%%%%%%%
 
tpi=2*pi;
 
iu=get(handles.listbox_units,'Value');
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
 
catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end
 
sz=size(THM);
NL=sz(1);
 
if(sz(2)~=3)
    warndlg('Input file must have 3 columns ');
    return;
end
 
fc=THM(:,1);
force=THM(:,2);
lf=THM(:,3);

fmin=min(fc);
fmax=max(fc);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
em=str2num(get(handles.edit_em,'String'));
md=str2num(get(handles.edit_md,'String'));
mu=str2num(get(handles.edit_mu,'String')); 
c=str2num(get(handles.edit_c,'String')); 
thick=str2num(get(handles.edit_thick,'String')); 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
if(iu==1) % English
 
    c=c*12;
    md=md/386;
    
    sv='in/sec';
    
else     % metric
    
    [em]=GPa_to_Pa(em);
  
    thick=thick/1000; 
 
    sv='m/sec';
end
 
rho=md;
 
h=thick;
     
[fcr]=critical_frequency_thin_plate(c,thick,mu,rho,em);
 
%%%%%%%%%%%%%%%%%%%%
 
rho_g=str2num(get(handles.edit_gas_md,'String'));
 
if(iu==1)
    rho_g=(rho_g/386)/12^3;
end
 
rho_s=rho*thick;
 
%%%%%%%%%%%%%%%%%%%%
 
B=em*h^3/(12*(1-mu^2));
 
Z=sqrt(B*rho*h);
    
Z=Z*8; % Middle
    
Y=1/Z;
YR=real(Y);
 
%%%%%%%%%%%%%%%%%%%%
 
L=str2num(get(handles.edit_L,'String'));
W=str2num(get(handles.edit_W,'String'));
 
M=rho*L*W*thick;
 
a=min([L W]);
b=max([L W]);
 
bc=get(handles.listbox_bc,'value');
 
%% thin plate
 
rad_eff=zeros(NL,1);
p_dp=zeros(NL,1);
p_rad=zeros(NL,1);
v1=zeros(NL,1);
 
power=zeros(NL,1);
power_mech=zeros(NL,1);
 
 
for i=1:NL
    
    omega=tpi*fc(i);
    
    force2=force(i)^2;
    
    [rad_eff(i)]=re_thin_plate_bc(fc(i),fcr,a,b,c,bc);    
    
    p_dp(i)= rho_g*force2/(tpi*c*rho_s^2);
 
    p_rad(i)=rho_g*fcr*force(i)^2*rad_eff(i)/(8*c*fc(i)*rho_s^2*lf(i));
 
    if(fc(i)>fcr)
        p_dp(i)=0;
    end
 
    power(i)=p_dp(i) + p_rad(i);  
    
    power_mech(i)=force2*YR;
 
    E1=power_mech(i)/(omega*lf(i));

    [v1(i)]=energy_to_velox(E1,M);
end    
    
%%%%%%%%%%%%%%%%%%%%
 
%% clf=(rho_g/rho)*(c/(tpi*freq*thick))*rad_eff;
 
%%% disp(' ');
%%% out1=sprintf(' Coupling loss factor, panel-to-air = %7.3g \n',clf);
%%% disp(out1);
 
%%%%%%%%%%%%%%%%%%%%
 
disp(' ');
disp(' * * * ');
disp(' ');
disp(' Radiated Acoustic Power from Single Side of Panel ');
disp(' ');

disp('             Drive      Resonant Mode    Total ');
disp(' Center      Point        Radiated     Radiated ');
disp('  Freq       Power         Power         Power  '); 
    
if(iu==1)
    disp('  (Hz)    (in-lbf/sec)   (in-lbf/sec)  (in-lbf/sec)  ');  
else
    disp('  (Hz)        (W)            (W)            (W)  ');      
end

for i=1:NL
    out1=sprintf('%8.4g   %8.4g      %8.4g      %8.4g ',fc(i),p_dp(i),p_rad(i),power(i));
    disp(out1);
end
 
if(iu==1)
   YU='(in/sec)/lbf'; 
   ZU='(lbf-sec)/in';
   PU='in-lbf/sec';
else
   YU='(m/sec)/N'; 
   ZU='(N-sec)/m'; 
   PU='W';
end
 
disp(' ');
disp(' Driving Point Real Values ');
disp(' ');
out1=sprintf('  Mobility = %8.4g %s',Y,YU);
out2=sprintf(' Impedance = %8.4g %s ',Z,ZU);
disp(out1);
disp(out2);
 
disp(' ');
out1=sprintf(' Critical Frequency = %8.4g Hz \n',fcr);
disp(out1);

% % %

              rad_eff=[fc rad_eff];
  driving_point_power=[fc p_dp];
  resonant_mode_power=[fc p_rad];
total_radiation_power=[fc power];

%

assignin('base', 'rad_eff',rad_eff);
assignin('base', 'driving_point_power',driving_point_power);
assignin('base', 'resonant_mode_power',resonant_mode_power);
assignin('base', 'total_radiation_power',total_radiation_power);

disp(' ');
disp('Output arrays ');
disp('      Driving Point Power: driving_point_power');
disp('      Resonant Mode Power: resonant_mode_power');
disp('    Total Radiation Power: total_radiation_power');
disp('     Radiation Efficiency: rad_eff ');
disp(' ');

% % %

fig_num=1;
x_label='Center Frequency (Hz)';
md=3;


ppp1=total_radiation_power;
t_string='Total Radiated Acoustic Power Spectrum';

if(iu==1)
    y_label='Power (in-lbf/sec)';    
else
    y_label='Power (W)';     
end


[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,ppp1,fmin,fmax,md);
           

% % %


ppp1=rad_eff;
t_string='Panel Radiation Efficiency';

y_label='Rad Eff';    

[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,ppp1,fmin,fmax,md);

% % % 

% % % 
 
ppp1=[fc force];
t_string='Point Force Spectrum';

if(iu==1)
    y_label='Force (lbf rms)';    
else
    y_label='Force (N rms)';     
end

[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,ppp1,fmin,fmax,md);

% % %

ppp1=[fc lf];
t_string='Panel Loss Factor';

y_label='Loss Factor';    

[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,ppp1,fmin,fmax,md);


% % %
 
msgbox('Results written to Command Window');



% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change(hObject, eventdata, handles)

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



function edit_re_Callback(hObject, eventdata, handles)
% hObject    handle to edit_re (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_re as text
%        str2double(get(hObject,'String')) returns contents of edit_re as a double


% --- Executes during object creation, after setting all properties.
function edit_re_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_re (see GCBO)
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
change(hObject, eventdata, handles)

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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material
change(hObject, eventdata, handles)

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


function change(hObject, eventdata, handles)

iu=get(handles.listbox_units,'Value');
 
imat=get(handles.listbox_material,'Value');
 
%%%
 
if(iu==1)  % English   
    
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_thick,'String','Thickness (in)');    
    set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)'); 
    set(handles.text_force,'String','2. Point Force (lbf rms)'); 
    set(handles.text_L,'String','Length (in)');
    set(handles.text_W,'String','Width (in)');
    
else
    
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');   
    set(handles.text_thick,'String','Thickness (mm)');        
    set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
    set(handles.text_force,'String','2. Point Force (N rms)');
    set(handles.text_L,'String','Length (m)');
    set(handles.text_W,'String','Width (m)');       
end
 
%%%
 
    if(iu==1)  % English
        if(imat==1) % aluminum
            elastic_modulus=1e+007;
            mass_density=0.1;  
        end  
        if(imat==2)  % steel
            elastic_modulus=3e+007;
            mass_density= 0.28;         
        end
        if(imat==3)  % copper
            elastic_modulus=1.6e+007;
            mass_density=  0.322;
        end
        if(imat==4)  % G10
            elastic_modulus=2.7e+006;
            mass_density=  0.065;
        end
    else                 % metric
        if(imat==1)  % aluminum
            elastic_modulus=70;
            mass_density=  2700;
        end
        if(imat==2)  % steel
            elastic_modulus=205;
            mass_density=  7700;        
        end
        if(imat==3)   % copper
            elastic_modulus=110;
            mass_density=  8900;
        end
        if(imat==4)  % G10
            elastic_modulus=18.6;
            mass_density=  1800;
        end
    end
        
%%%%%%%%%%%%%%    
    
    if(imat==1) % aluminum
        poisson=0.33;  
    end  
    if(imat==2)  % steel
        poisson= 0.30;         
    end
    if(imat==3)  % copper
        poisson=  0.33;
    end
    if(imat==4)  % G10
        poisson=  0.12;
    end    
    
%%%%%%%%%%%%%%
 
    if(imat<5)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
        ss3=sprintf('%8.4g',poisson);  
 
        set(handles.edit_em,'String',ss1);
        set(handles.edit_md,'String',ss2);    
        set(handles.edit_mu,'String',ss3); 
        
    end
 
%%%%%%%%%%%%%%
 
%%%
 
ng=get(handles.listbox_gas,'Value');
 
if(iu==1)
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

%%%%%%%%%


    



function edit_force_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force as text
%        str2double(get(hObject,'String')) returns contents of edit_force as a double


% --- Executes during object creation, after setting all properties.
function edit_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force (see GCBO)
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


% --- Executes on button press in pushbutton_fcr.
function pushbutton_fcr_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fcr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('fcr_thin_plate.jpg'); 
figure(997)
imshow(A,'border','tight','InitialMagnification',100) 

% --- Executes on button press in pushbutton_re.
function pushbutton_re_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_re (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('re_thin_panel.jpg');
     figure(998) 
     imshow(A,'border','tight','InitialMagnification',100)

% --- Executes on button press in pushbutton_radiated_power.
function pushbutton_radiated_power_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_radiated_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('radiated_thin_panel.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100)


% --- Executes on button press in pushbutton_mob.
function pushbutton_mob_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('mi_thin_plate.jpg');
     figure(996) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on button press in pushbutton_power_force.
function pushbutton_power_force_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_power_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('plate_power.jpg');
    figure(995) 
    imshow(A,'border','tight','InitialMagnification',100) 



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
