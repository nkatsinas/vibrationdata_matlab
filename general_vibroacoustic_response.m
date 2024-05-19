function varargout = general_vibroacoustic_response(varargin)
% GENERAL_VIBROACOUSTIC_RESPONSE MATLAB code for general_vibroacoustic_response.fig
%      GENERAL_VIBROACOUSTIC_RESPONSE, by itself, creates a new GENERAL_VIBROACOUSTIC_RESPONSE or raises the existing
%      singleton*.
%
%      H = GENERAL_VIBROACOUSTIC_RESPONSE returns the handle to a new GENERAL_VIBROACOUSTIC_RESPONSE or the handle to
%      the existing singleton*.
%
%      GENERAL_VIBROACOUSTIC_RESPONSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENERAL_VIBROACOUSTIC_RESPONSE.M with the given input arguments.
%
%      GENERAL_VIBROACOUSTIC_RESPONSE('Property','Value',...) creates a new GENERAL_VIBROACOUSTIC_RESPONSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before general_vibroacoustic_response_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to general_vibroacoustic_response_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help general_vibroacoustic_response

% Last Modified by GUIDE v2.5 25-Sep-2017 10:57:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @general_vibroacoustic_response_OpeningFcn, ...
                   'gui_OutputFcn',  @general_vibroacoustic_response_OutputFcn, ...
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


% --- Executes just before general_vibroacoustic_response is made visible.
function general_vibroacoustic_response_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to general_vibroacoustic_response (see VARARGIN)

% Choose default command line output for general_vibroacoustic_response
handles.output = hObject;

change(hObject, eventdata, handles);
listbox_dlf_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes general_vibroacoustic_response wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = general_vibroacoustic_response_OutputFcn(hObject, eventdata, handles) 
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

delete(general_vibroacoustic_response);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * ');
disp('  ');

fig_num=1;

iu=get(handles.listbox_units,'Value');

gas_mass_density=str2num(get(handles.edit_gas_mass_density,'String'));
setappdata(0,'gas_mass_density',gas_mass_density);

c=str2num(get(handles.edit_c,'String'));

mass_dens=str2num(get(handles.edit_mdens,'String')); 

c_orig=c;
mass_dens_orig=mass_dens;

if(iu==1)
    c=c*0.3048;                  % convert from ft/sec    to  m/sec
    mass_dens=mass_dens*4.8816 ; % convert from lbm/ft^2  to  kg/m^2
end


try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

sz=size(THM);

if(sz(2)~=4)
   warndlg('Input array must have four columns'); 
   return; 
end

num=sz(1);

        fc=THM(:,1);
       spl=THM(:,2);
       rad=THM(:,3);
modal_dens=THM(:,4);

   power=zeros(num,1);
power_dB=zeros(num,1);

pressure_ref=20e-06;

power_ref=1.0e-12;

out1=sprintf('\n  c = %8.4g m/sec ',c);
disp(out1);
out1=sprintf('\n  mass density = %8.4g kg/m^2 \n',mass_dens);
disp(out1);

disp(' Zero dB References: ');
disp('   Pressure 20 micro Pa');
disp('   Power     1 pico Watt ');
disp(' ');

disp('   fc    SPL    Power  ');
disp('  (Hz)   (dB)    (dB)  ');

for i=1:num
    pressure=pressure_ref*10^(spl(i)/20);
    den=mass_dens*(4*pi*fc(i)^2);
    power(i)=c^2*rad(i)*pressure^2*modal_dens(i)/den;   
    power_dB(i)=10*log10(power(i)/power_ref);
    out1=sprintf('%7.1f  %6.1f  %6.1f',fc(i),spl(i),power_dB(i));
    disp(out1);
end

[oadb]=oaspl_function(power_dB);

data=[fc power_dB];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'fc',fc);
setappdata(0,'spl',spl);
setappdata(0,'rad',rad);
setappdata(0,'modal_dens',modal_dens);
setappdata(0,'iu',iu);
setappdata(0,'power_dB',power_dB);
setappdata(0,'c_orig',c_orig);
setappdata(0,'mass_dens_orig',mass_dens_orig);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp=data;
fmin=min(fc);
fmax=max(fc);



t_string=sprintf('Acoustic Power   Overall Level=%7.1f dB \n (ref 1 pico Watt)',oadb);
x_label='Center Frequency (Hz)';
y_label='Power (dB)';
plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

acoustic_power=ppp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tpi=2*pi;

iu=getappdata(0,'iu');

fc=getappdata(0,'fc');
spl=getappdata(0,'spl');
rad_eff=getappdata(0,'rad');
modal_dens=getappdata(0,'modal_dens');

power_dB=getappdata(0,'power_dB');
c_orig=getappdata(0,'c_orig');
mass_dens_orig=getappdata(0,'mass_dens_orig');
gas_mass_density=getappdata(0,'gas_mass_density');

c=c_orig;
mass_dens=mass_dens_orig;


nd=get(handles.listbox_dlf,'Value');

if(nd==7)
    dlfc=str2num(get(handles.edit_dlf,'String'));    
end

num=length(fc);

dlf=zeros(num,1);

f=fc;

for i=1:num
    
    if(nd==1)  % Plate
        [dlf(i)]=plate_dissipation_loss_factor(f(i));        
    end
    if(nd==2)  % Sandwich Panel, Bare
        [dlf(i)]=sandwich_panel_bare_lf(f(i));        
    end
    if(nd==3)  % Sandwich Panel, Built-up
        [dlf(i)]=sandwich_panel_built_up_lf(f(i));        
    end    
    if(nd==4)  % Stowed Solar Array
         fp=250;
         if(f(i)<=fp)
                dlf(i)=0.05;
         else
                dlf(i)=0.050*(fp/f(i));
         end        
    end
    if(nd==5)  % Cylinder, Lower Estimate
            fp=3000;
            if(f(i)<=fp)
                dlf(i) =0.002;
            else
                dlf(i) =0.004;                  
            end        
    end
    if(nd==6)  % Cylinder, Upper Estimate
            fp=3000;
            if(f(i)<=fp)
                dlf(i)=0.03;                
            else
                dlf=0.006;                     
            end        
    end   
    if(nd==7)  % user input
        dlf(i)=dlfc;
    end     
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mph=modal_dens;
dB=spl;

NL=length(fc);


vel=zeros(NL,1);
accel=zeros(NL,1);
Moverlap=zeros(NL,1);
pressure=zeros(NL,1);

Ap=str2num(get(handles.edit_area,'String'));

gas_md=gas_mass_density;

if(iu==1)
    gas_md=gas_md*16.016;        % convert from lbm/ft^3 to kg/m^3
    mass_dens=mass_dens*4.8816;  % convert from lbm/ft^2 to kg/m^2
    c=c*0.3048;                  % convert from ft/sec to m/sec
    Ap=Ap*0.092903;              % convert from ft^2 to m^2 
end  

M=mass_dens*Ap;

power_ref=1e-12;
pressure_ref=20e-06;

disp(' ');
out1=sprintf('      M=%8.4g kg',M);
out2=sprintf('     Ap=%8.4g m^2',Ap);
out3=sprintf('      c=%8.4g m/sec',c);
out4=sprintf(' gas_md=%8.4g kg/m^3',gas_md);
disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(' ');

disp('  freq    v     pressure    modes_per_radps   lf    RR');

for i=1:NL
    
    f=fc(i);
    omega=tpi*f;

    [Moverlap(i)]=SEA_modal_overlap(mph(i),dlf(i),fc(i));

%   power=power_ref*(10^(power_dB/10));      % power watts
    
    pressure(i)=pressure_ref*(10^(spl(i)/20));  % pressure Pa
    
    [vel(i),total_lf]=velocity_from_diffuse_pressure_alt(pressure(i),c,...
                                    gas_md,M,dlf(i),rad_eff(i),f,mph(i),Ap);
    
    accel(i)=vel(i)*omega;

end   

accel_ps=accel/9.81;  % accel GRMS  

if(iu==1)
      vel=vel*39.37;  % convert from m/sec to in/sec RMS
else
      vel=vel*1000;
end

vel_ps=vel;
    
vel_ps=[fc vel_ps];
accel_ps=[fc accel_ps];
rad_eff=[fc rad_eff];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
disp(' ');
disp(' * * * ');
disp(' ');
 
disp('  Velocity & Acceleration RMS Values ');
disp(' ');
 
   disp('    Freq    Velocity   Accel      Modal');
 
if(iu==1)
   disp('    (Hz)    (in/sec)    (G)      Overlap');
else
   disp('    (Hz)    (mm/sec)    (G)      Overlap');    
end
 
for i=1:NL
   out1=sprintf(' %8.4g  %8.4g  %8.4g  %7.3g',fc(i),vel_ps(i,2),accel_ps(i,2),Moverlap(i));
   disp(out1); 
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
nb=1;   %  one-third octave band
 
[psd,grms]=psd_from_spectrum(nb,fc,accel_ps(:,2));
 
    disp(' ');
    disp(' Power Spectral Density ');
    disp(' ');
    disp('   Freq    Accel');
    disp('   (Hz)   (G^2/Hz)');
    
    for i=1:NL
        
        out1=sprintf('   %g   %8.4g ',fc(i),psd(i));
        disp(out1);
    
    end
      

 
n_type=1;  % one-third octave band

[fig_num]=spl_plot(fig_num,n_type,fc,dB);
   
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
vrms=sqrt(sum(vel_ps(:,2).^2));
 
disp(' ');
if(iu==1)
    out1=sprintf(' Overall Velocity = %7.3g in/sec RMS',vrms);
else
    out1=sprintf(' Overall Velocity = %7.3g mm/sec RMS',vrms);    
end    
 
out2=sprintf(' Overall Acceleration = %7.3g G RMS',grms);    
 
disp(out1);
disp(out2);
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fmin=min(fc);
fmax=max(fc);

ppp=[fc,mph];
md=3;
x_label='Center Frequency (Hz)';
y_label='n (modes/Hz)';
t_string='Modal Density';
fmin=20;
fmax=10000;

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%

ppp=rad_eff;
x_label='Center Frequency (Hz)';
y_label='Ratio';
t_string='Radiation Efficiency';

ymin=0;
ymax=1.2;
md=3;
[fig_num]=plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
md=3;
%%

t_string='Loss Factor';
y_label='Loss Factor';
ppp=[fc dlf];
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
 
 
t_string='Velocity Spectrum';
if(iu==1)
    y_label='Vel (in/sec)';
else
    y_label='Vel (mm/sec)';    
end   
ppp=vel_ps;
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
 
 
t_string='Acceleration Spectrum';
y_label='Accel (GRMS)';
 
ppp=accel_ps;
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
  
    accel_psd=[fc psd];
    
    rrr1=accel_psd;
    
    y_label='Accel (G^2/Hz)';
    
    t_string=sprintf('Power Spectral Density  %7.3g GRMS Overall',grms);
 
    [fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,rrr1,fmin,fmax,md);  
 
%%%
 
assignin('base', 'acoustic_power',acoustic_power);
assignin('base', 'accel_psd',accel_psd);
assignin('base', 'vel_ps',vel_ps);
assignin('base', 'accel_ps',accel_ps);
assignin('base', 'rad_eff',rad_eff);
 
disp('  ');
disp(' Output Arrays ');
disp('            Power Spectra:  vel_ps & accel_ps ');
disp('   Power Spectral Density:  accel_psd ');
disp('     Radiation Efficiency:  rad_eff ');
 
%%%
 
msgbox('Results written to Command Window');
 





% --- Executes on selection change in listbox_system.
function listbox_system_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_system (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_system contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_system

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_system_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_system (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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

function change(hObject, eventdata, handles)
%
iu=get(handles.listbox_units,'Value');

    % acoustic
  
    if(iu==1)
        set(handles.text_mdens,'String','Mass/Area (lbm/ft^2)');
        set(handles.text_area,'String','Surface Area (ft^2)');
        set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)');         
        set(handles.edit_c,'String','1125');     
        set(handles.text_gas_mass_density,'String','Gas Mass Density (lbm/ft^3)');
        set(handles.edit_gas_mass_density,'String','0.076487');    
    else
        set(handles.text_mdens,'String','Mass/Area (kg/m^2)');  
        set(handles.text_area,'String','Surface Area (m^2)');
        set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');        
        set(handles.edit_c,'String','343');     
        set(handles.text_gas_mass_density,'String','Gas Mass Density (kg/m^3)'); 
        set(handles.edit_gas_mass_density,'String','1.225');           
    end   



function edit_velox_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velox as text
%        str2double(get(hObject,'String')) returns contents of edit_velox as a double


% --- Executes during object creation, after setting all properties.
function edit_velox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_velox and none of its controls.
function edit_velox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

change(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_mass and none of its controls.
function edit_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
change(hObject, eventdata, handles);



function edit_energy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_energy as text
%        str2double(get(hObject,'String')) returns contents of edit_energy as a double


% --- Executes during object creation, after setting all properties.
function edit_energy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_pressure.
function listbox_pressure_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pressure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pressure
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_pressure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pressure as text
%        str2double(get(hObject,'String')) returns contents of edit_pressure as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_energy and none of its controls.
function edit_energy_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_energy (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_pressure,'Visible','off');


% --- Executes on key press with focus on edit_volume and none of its controls.
function edit_volume_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_pressure,'Visible','off');


% --- Executes on key press with focus on edit_gas_md and none of its controls.
function edit_gas_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_pressure,'Visible','off');


% --- Executes on key press with focus on edit_c and none of its controls.
function edit_c_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_pressure,'Visible','off');


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('equivalent_acoustic_power_cylinder.jpg');
figure(990) 
imshow(A,'border','tight','InitialMagnification',100); 



% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_mdens_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mdens as text
%        str2double(get(hObject,'String')) returns contents of edit_mdens as a double


% --- Executes during object creation, after setting all properties.
function edit_mdens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
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



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_vr.
function pushbutton_vr_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_vr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function edit_gas_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gas_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gas_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_gas_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_gas_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_mass_density (see GCBO)
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


% --- Executes on selection change in listbox_equation.
function listbox_equation_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_equation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_equation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_equation


% --- Executes during object creation, after setting all properties.
function listbox_equation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_equation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mm=get(handles.listbox_equation,'Value');

if(mm==1)
    A = imread('equivalent_acoustic_power_cylinder.jpg');
    figure(990) 
    imshow(A,'border','tight','InitialMagnification',100); 
end
if(mm==2)
    A = imread('velocity_pressure_panel.jpg');
    figure(1000),imshow(A,'border','tight','InitialMagnification',100)  
end
if(mm==3)

    n=get(handles.listbox_dlf,'value');
 
    if(n==1)
        A = imread('plate_lf.jpg');
        figure(994) 
        imshow(A,'border','tight','InitialMagnification',100)      
    end
    if(n==2 || n==3)
        A = imread('sandwich_lf.jpg');
        figure(995) 
        imshow(A,'border','tight','InitialMagnification',100)           
    end
    if(n==4)
        A = imread('stowed_solar_array_lf.jpg');
        figure(997) 
        imshow(A,'border','tight','InitialMagnification',100)      
    end
    if(n==5 || n==6)
        A = imread('cylinder_lf.jpg');
        figure(998) 
        imshow(A,'border','tight','InitialMagnification',100)      
    end
    
end


% --- Executes on selection change in listbox_dlf.
function listbox_dlf_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dlf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dlf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dlf
n=get(handles.listbox_dlf,'Value');

set(handles.edit_dlf,'Visible','off');
set(handles.text_dlf,'Visible','off');

if(n==7)
    set(handles.edit_dlf,'Visible','on');
    set(handles.text_dlf,'Visible','on');    
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



function edit_dlf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dlf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dlf as text
%        str2double(get(hObject,'String')) returns contents of edit_dlf as a double


% --- Executes during object creation, after setting all properties.
function edit_dlf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dlf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
