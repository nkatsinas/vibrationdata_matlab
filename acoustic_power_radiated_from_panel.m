function varargout = acoustic_power_radiated_from_panel(varargin)
% ACOUSTIC_POWER_RADIATED_FROM_PANEL MATLAB code for acoustic_power_radiated_from_panel.fig
%      ACOUSTIC_POWER_RADIATED_FROM_PANEL, by itself, creates a new ACOUSTIC_POWER_RADIATED_FROM_PANEL or raises the existing
%      singleton*.
%
%      H = ACOUSTIC_POWER_RADIATED_FROM_PANEL returns the handle to a new ACOUSTIC_POWER_RADIATED_FROM_PANEL or the handle to
%      the existing singleton*.
%
%      ACOUSTIC_POWER_RADIATED_FROM_PANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACOUSTIC_POWER_RADIATED_FROM_PANEL.M with the given input arguments.
%
%      ACOUSTIC_POWER_RADIATED_FROM_PANEL('Property','Value',...) creates a new ACOUSTIC_POWER_RADIATED_FROM_PANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before acoustic_power_radiated_from_panel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to acoustic_power_radiated_from_panel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help acoustic_power_radiated_from_panel

% Last Modified by GUIDE v2.5 22-Dec-2015 10:31:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @acoustic_power_radiated_from_panel_OpeningFcn, ...
                   'gui_OutputFcn',  @acoustic_power_radiated_from_panel_OutputFcn, ...
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


% --- Executes just before acoustic_power_radiated_from_panel is made visible.
function acoustic_power_radiated_from_panel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to acoustic_power_radiated_from_panel (see VARARGIN)

% Choose default command line output for acoustic_power_radiated_from_panel
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes acoustic_power_radiated_from_panel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = acoustic_power_radiated_from_panel_OutputFcn(hObject, eventdata, handles) 
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

delete(acoustic_power_radiated_from_panel);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%

tpi=2*pi;
 
disp(' ');
 
iu=get(handles.listbox_units,'Value');
 
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

h=thick;
    
rho=md;
    
fcr=(c^2/(tpi*thick))*sqrt(12*(1-mu^2)*rho/em);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%
 
force=str2num(get(handles.edit_force,'String'));
freq=str2num(get(handles.edit_freq,'String'));
omega=tpi*freq;

disp(' ');
disp(' * * * ');
disp('  ');
 
out1=sprintf('   Center Frequency    f = %8.4g Hz ',freq);
disp(out1);
out1=sprintf(' Critical Frequency  fcr = %8.4g Hz ',fcr);
disp(out1);
 

%%%%%%%%%%%%%%%%%%%%


lf=str2num(get(handles.edit_lf,'String'));
rho_g=str2num(get(handles.edit_gas_md,'String'));

if(iu==1)
    rho_g=(rho_g/386)/12^3;
end

rho_s=rho*thick;

%%%%%%%%%%%%%%%%%%%%

L=str2num(get(handles.edit_L,'String'));
W=str2num(get(handles.edit_W,'String'));

a=min([L W]);
b=max([L W]);

Ap=L*W;

P=2*L+2*W;


disp(' ');


bc=get(handles.listbox_bc,'value');

%% thin plate

    fcr_b=1.3*fcr;

    lambda_c=c/fcr;

    aob=a/b;

    re_critical=@(P,lambda_c,aob)(0.45*sqrt(P/lambda_c)*(aob)^(1/4));
    re_above=@(f,fcr)( 1 - (fcr/f)  )^(-1/2);

        if(freq<fcr)
        
            beta=sqrt(freq/fcr);
            beta2=beta^2;
        
            if(bc==1) % ss
                C1=1;
            else        % clamped
                C1=beta^2*exp(10*lambda_c/P);
            end
        
            if(freq<0.5*fcr)
                g1b=(4/pi^4)*(1-2*beta2)/( beta*(1-beta2) );
            else
                g1b=0;
            end
        
            arg=(1+beta)/(1-beta);
            num=(1-beta2)*log(arg)+2*beta;
            den=(1-beta2)^(1.5);
        
            g2b=(1/(4*pi^2))*num/den;
        
            term=g1b+(P/(2*lambda_c))*g2b;
            rad_eff_half_space=(2*lambda_c/Ap)*term*C1;   
        end
        if(freq==fcr)
            rad_eff_half_space=re_critical(P,lambda_c,aob);   
        end
        if( freq>fcr && freq < fcr_b)
        
            r1=re_critical(P,lambda_c,aob); 
            r2=re_above(freq,fcr);
        
            df=freq-fcr;
            L=fcr_b-fcr;
        
            c2=df/L;
            c1=1-c2;
     
            rad_eff_half_space=c1*r1+c2*r2;
        
        end
        if(freq>=fcr_b)
            rad_eff_half_space=re_above(freq,fcr);
        end 


rad_eff=rad_eff_half_space;

%%%%%%%%%%%%%%%%%%%%

p_dp= rho_g*force^2/(tpi*c*rho_s^2);

p_rad=rho_g*fcr*force^2*rad_eff/(8*c*freq*rho_s^2*lf);

if(freq>fcr)
    p_dp=0;
end

power=p_dp + p_rad;

%%%%%%%%%%%%%%%%%%%%

    B=em*h^3/(12*(1-mu^2));

    
    Z=sqrt(B*rho*h);
    
    Z=Z*8; % Middle
    
    Y=1/Z;

%%%%%%%%%%%%%%%%%%%%

    YR=real(Y);
    power_mech=force^2*YR;
    
%%%%%%%%%%%%%%%%%%%%

if(iu==1)
   YU='(in/sec)/Lbf'; 
   ZU='(Lbf-sec)/in'; 
else
   YU='(m/sec)/N'; 
   ZU='(N-sec)/m';     
end

disp(' Driving Point Real Values ');
disp(' ');
out1=sprintf('  Mobility = %8.4g %s',Y,YU);
out2=sprintf(' Impedance = %8.4g %s ',Z,ZU);

disp(out1);
disp(out2);

%%%%%%%%%%%%%%%%%%%%

clf=(rho_g/rho)*(c/(tpi*freq*thick))*rad_eff;



%%% disp(' ');
%%% out1=sprintf(' Coupling loss factor, panel-to-air = %7.3g \n',clf);
%%% disp(out1);

%%%%%%%%%%%%%%%%%%%%

E1=power_mech/(omega*lf);

M=rho*L*W*thick;

[v1]=energy_to_velox(E1,M);

disp(' ');
out1=sprintf(' Spatial Average Velocity = %8.4g %s rms',v1,sv);
disp(out1);

%%%%%%%%%%%%%%%%%%%%

disp(' ');
out1=sprintf(' Radiation Efficiency = %8.4g \n',rad_eff);
disp(out1);

if(iu==1)
    out1=sprintf(' Power injected into infinite panel = %8.4g in-lbf/sec ',power_mech);
    out2=sprintf('                                    = %8.4g ft-lbf/sec ',power_mech/12);    
    disp(out1);
    disp(out2);    
else    
    out1=sprintf(' Power injected into infinite panel = %8.4g W ',power_mech);
    disp(out1);
end

disp(' ');
disp(' Radiated Acoustic Power from Single Side of Panel ');
disp(' ');

if(iu==1)
    
    out1=sprintf('    Drive Point Radiation = %8.4g in-lbf/sec',p_dp);
    out2=sprintf(' Resonant Modes Radiation = %8.4g in-lbf/sec ',p_rad);
    out3=sprintf('          Total Radiation = %8.4g in-lbf/sec',power);
    disp(out1);
    disp(out2);
    disp(out3);  
    disp(' ');
    
    out1=sprintf('    Drive Point Radiation = %8.4g ft-lbf/sec',p_dp/12);
    out2=sprintf(' Resonant Modes Radiation = %8.4g ft-lbf/sec ',p_rad/12);
    out3=sprintf('          Total Radiation = %8.4g ft-lbf/sec',power/12);
    disp(out1);
    disp(out2);
    disp(out3);    
    
    
else
    out1=sprintf('    Drive Point Radiation = %8.4g W',p_dp);
    out2=sprintf(' Resonant Modes Radiation = %8.4g W',p_rad);
    out3=sprintf('          Total Radiation = %8.4g W',power);
    disp(out1);
    disp(out2);
    disp(out3);    
end




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
    set(handles.text_force,'String','Point Force (lbf rms)'); 
    set(handles.text_L,'String','Length (in)');
    set(handles.text_W,'String','Width (in)');
    
else
    
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');   
    set(handles.text_thick,'String','Thickness (mm)');        
    set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
    set(handles.text_force,'String','Point Force (N rms)');
    set(handles.text_L,'String','Length (m)');
    set(handles.text_W,'String','Width (m)');       
end

%%%
 
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
