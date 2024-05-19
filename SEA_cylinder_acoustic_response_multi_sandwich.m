function varargout = SEA_cylinder_acoustic_response_multi_sandwich(varargin)
% SEA_CYLINDER_ACOUSTIC_RESPONSE_MULTI_SANDWICH MATLAB code for SEA_cylinder_acoustic_response_multi_sandwich.fig
%      SEA_CYLINDER_ACOUSTIC_RESPONSE_MULTI_SANDWICH, by itself, creates a new SEA_CYLINDER_ACOUSTIC_RESPONSE_MULTI_SANDWICH or raises the existing
%      singleton*.
%
%      H = SEA_CYLINDER_ACOUSTIC_RESPONSE_MULTI_SANDWICH returns the handle to a new SEA_CYLINDER_ACOUSTIC_RESPONSE_MULTI_SANDWICH or the handle to
%      the existing singleton*.
%
%      SEA_CYLINDER_ACOUSTIC_RESPONSE_MULTI_SANDWICH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_CYLINDER_ACOUSTIC_RESPONSE_MULTI_SANDWICH.M with the given input arguments.
%
%      SEA_CYLINDER_ACOUSTIC_RESPONSE_MULTI_SANDWICH('Property','Value',...) creates a new SEA_CYLINDER_ACOUSTIC_RESPONSE_MULTI_SANDWICH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_cylinder_acoustic_response_multi_sandwich_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_cylinder_acoustic_response_multi_sandwich_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_cylinder_acoustic_response_multi_sandwich

% Last Modified by GUIDE v2.5 16-Oct-2017 11:15:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_cylinder_acoustic_response_multi_sandwich_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_cylinder_acoustic_response_multi_sandwich_OutputFcn, ...
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


% --- Executes just before SEA_cylinder_acoustic_response_multi_sandwich is made visible.
function SEA_cylinder_acoustic_response_multi_sandwich_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_cylinder_acoustic_response_multi_sandwich (see VARARGIN)

% Choose default command line output for SEA_cylinder_acoustic_response_multi_sandwich
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_cylinder_acoustic_response_multi_sandwich wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_cylinder_acoustic_response_multi_sandwich_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(SEA_cylinder_acoustic_response_multi_sandwich);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

disp(' ');
disp(' * * * * * * * * * ');
disp(' ');

%%%%

q1=get(handles.listbox_gas,'Value');
setappdata(0,'listbox_gas',q1);

q2=get(handles.listbox_band,'Value');
setappdata(0,'listbox_band',q2);

q3=get(handles.listbox_material,'Value');
setappdata(0,'listbox_material',q3);

%%%%

iu=get(handles.listbox_units,'Value');
setappdata(0,'listbox_units',iu);

L=str2num(get(handles.edit_L,'String'));
setappdata(0,'edit_L',L);

diam=str2num(get(handles.edit_diam,'String'));
setappdata(0,'edit_diam',diam);

E=str2num(get(handles.edit_em,'String'));
setappdata(0,'edit_em',E);

mu=str2num(get(handles.edit_mu,'String'));
setappdata(0,'edit_mu',mu);

G=str2num(get(handles.edit_shear_modulus,'String'));
setappdata(0,'edit_shear_modulus',G);

rhoc=str2num(get(handles.edit_md_c,'String'));
setappdata(0,'edit_md_c',rhoc);

hc=str2num(get(handles.edit_thick_c,'String'));
setappdata(0,'edit_thick_c',hc);

tf=str2num(get(handles.edit_thick_f,'String'));
setappdata(0,'edit_thick_f',tf);

rhof=str2num(get(handles.edit_md_f,'String'));
setappdata(0,'edit_md_f',rhof);

bc=get(handles.listbox_bc,'Value');
setappdata(0,'listbox_bc',bc);

gas_c=str2num(get(handles.edit_c,'String')); 
setappdata(0,'edit_c',gas_c);

gas_md=str2num(get(handles.edit_gas_md,'String'));
setappdata(0,'edit_gas_md',gas_md);

if(iu==1)
   rhoc=rhoc/386;
   rhof=rhof/386;
   gas_c=gas_c*12;
   [gas_md]=lbm_per_ft3_to_lbf_sec2_per_in4(gas_md);
else
   [E]=GPa_to_Pa(E);
   [G]=GPa_to_Pa(G);
   tf=tf/1000;
   hc=hc/1000;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end
setappdata(0,'edit_input_array',FS);

sz=size(THM);

if(sz(2)~=3)
    warndlg('Input file must have 3 columns ');
    return;
end

fc=THM(:,1);
dlf=THM(:,3);

fmin=min(fc);
fmax=max(fc);

if(fmin>20)
    fmin=20;
end

pu=get(handles.listbox_pu,'Value');
setappdata(0,'listbox_pu',pu);
       
NL=length(fc);


if(pu==1)
    dB=THM(:,2);  
     
    [pressure]=convert_dB_pressure_alt(dB,iu);
else
    pressure=THM(:,2);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[D,K,S,~,fring]=honeycomb_sandwich_properties_wave(E,G,mu,tf,hc,diam,rhof,rhoc);

[f1,f2]=shear_frequencies(E,G,mu,tf,hc,rhof,rhoc);

NSM_per_area=0;

[fcr,mpa,kflag]=...
          honeycomb_sandwich_critical_frequency(E,G,mu,tf,hc,rhof,rhoc,gas_c,NSM_per_area);

if(kflag==1)
    warndlg('Critical frequency does not exist for this case');
    return;
end
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mmax=220;
nmax=220;

Ap=L*pi*diam;

mass=mpa*Ap;
M=mass;

freq=fc;

Moverlap=zeros(NL,1);

% P=zeros(NL,1);
vel=zeros(NL,1);
accel=zeros(NL,1);

vel_ps=zeros(NL,1);
accel_ps=zeros(NL,1);
total_lf=zeros(NL,1);

v=mu;
air_c=gas_c;

[rad_eff,mph]=...
    re_sandwich_cylinder_engine_alt_dlf(D,K,v,diam,L,mpa,bc,mmax,nmax,air_c,fcr,fring,freq,dlf);

for i=1:NL

    omega=tpi*fc(i);

%%    if(fc(i)> fring)    
%%        [mdens]=Renji_modal_density(omega,Ap,S,D,mpa);
%%         mph(i)=mdens; 
%%    end
         
%    [P(i)]=equivalent_acoustic_power_alt(mph(i),gas_c,rad_eff(i),pressure(i),mpa,freq(i)); 
%    [vel(i),~]=velocity_from_power_one(lf(i),omega,mass,P(i));


    [vel(i),total_lf(i)]=velocity_from_diffuse_pressure_alt(pressure(i),...
                        gas_c,gas_md,M,dlf(i),rad_eff(i),fc(i),mph(i),Ap);
                    
                    
    [Moverlap(i)]=SEA_modal_overlap(mph(i),total_lf(i),fc(i));    
    
    accel(i)=vel(i)*omega;
    
    if(iu==1)
        vel_ps(i)=vel(i);
        accel_ps(i)=accel(i)/386;    
    else
        vel_ps(i)=vel(i)/1000;
        accel_ps(i)=accel(i)/9.81;      
    end    
    
end
    
Moverlap=fix_size(Moverlap);
mph=fix_size(mph);

rad_eff=fix_size(rad_eff);
vel_ps=[fc vel_ps];
accel_ps=[fc accel_ps];
rad_eff=[fc rad_eff];
mover=[fc Moverlap];
modal_dens=[fc mph];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;
md=3;
x_label='Center Frequency (Hz)';

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nb=get(handles.listbox_band,'Value');

if(nb<=2)
    
   
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
      
end

if(pu==1) % dB

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

disp('  ');
out2=sprintf('     Ring Frequency = %7.4g Hz ',fring);
out3=sprintf(' Critical Frequency = %7.4g Hz ',fcr);

disp(out2);
disp(out3);

display_shear_frequencies(f1,f2);
disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp=rad_eff;

x_label='Center Frequency (Hz)';
y_label='Ratio';
t_string='Radiation Efficiency';

ymin=0;
ymax=1.2;
md=3;
[fig_num]=plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
md=3;


t_string='Cylinder Loss Factor';
y_label='Loss Factor';
ppp=[fc dlf];
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


t_string='Cylinder Velocity Spectrum';
if(iu==1)
    y_label='Vel (in/sec)';
else
    y_label='Vel (mm/sec)';    
end   
ppp=vel_ps;
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


t_string='Cylinder Acceleration Spectrum';
y_label='Accel (GRMS)';

ppp=accel_ps;
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


    
    accel_psd=[fc psd];
    
    rrr1=accel_psd;
    
    y_label='Accel (G^2/Hz)';
    
    t_string=sprintf('Cylinder Power Spectral Density  %7.3g GRMS Overall',grms);

    [fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,rrr1,fmin,fmax,md);  

%%   

    md=5;

    rrr1=modal_dens;
    
    y_label='n (modes/Hz)';
    
    t_string=sprintf('Modal Density');

    [fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,rrr1,fmin,fmax,md);  

%%

    md=6;

    rrr1=mover;
    
    y_label=' ';
    
    t_string=sprintf('Modal Overlap');

    [fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,rrr1,fmin,fmax,md);  
           
           
%%%


for i=NL:-1:1
   if(accel_psd(i,2)<1.0e-80)
       accel_psd(i,:)=[];
   end
   if(vel_ps(i,2)<1.0e-80)
       vel_ps(i,:)=[];
   end  
   if(accel_ps(i,2)<1.0e-80)
       accel_ps(i,:)=[];
   end 
   if(rad_eff(i,2)<1.0e-80)
       rad_eff(i,:)=[];
   end
   if(mover(i,2)<1.0e-80)
       mover(i,:)=[];
   end   
   if(modal_dens(i,2)<1.0e-80)
       modal_dens(i,:)=[];
   end     
end

outname1=sprintf('%s_accel_psd',FS);
outname2=sprintf('%s_vel_ps',FS);
outname3=sprintf('%s_accel_ps',FS);
outname4=sprintf('%s_rad_eff',FS);
outname5=sprintf('%s_mover',FS);
outname6=sprintf('%s_modal_dens',FS);

assignin('base',outname1,accel_psd);
assignin('base',outname2,vel_ps);
assignin('base',outname3,accel_ps);
assignin('base',outname4,rad_eff);
assignin('base',outname5,mover);
assignin('base',outname6,modal_dens);

output_filename1=sprintf('%s.txt',outname1);
output_filename2=sprintf('%s.txt',outname2);
output_filename3=sprintf('%s.txt',outname3);
output_filename4=sprintf('%s.txt',outname4);
output_filename5=sprintf('%s.txt',outname5);
output_filename6=sprintf('%s.txt',outname6);

save(output_filename1,'accel_psd','-ASCII')
save(output_filename2,'vel_ps','-ASCII')
save(output_filename3,'accel_ps','-ASCII')
save(output_filename4,'rad_eff','-ASCII')
save(output_filename5,'mover','-ASCII')
save(output_filename6,'modal_dens','-ASCII')


disp(' Output Matlab Arrays: ');
disp(' ');

out1=sprintf(' Acceleration Power Spectral Density: %s',outname1);
out2=sprintf('             Velocity Power Spectrum: %s',outname2);
out3=sprintf('         Acceleration Power Spectrum: %s',outname3);
out4=sprintf('                Radiation Efficiency: %s',outname4);
out5=sprintf('                       Modal Overlap: %s',outname5);
out6=sprintf('                       Modal Density: %s',outname6);

disp(out1);
disp(out3);
disp(out2);
disp(out4);
disp(out5);
disp(out6);

disp(' ASCII Text Arrays: ');
disp(' ');
disp(output_filename1);
disp(output_filename2);
disp(output_filename3);
disp(output_filename4);
disp(output_filename5);
disp(output_filename6);

disp(' ');
disp(' ');


%%%

msgbox('Results written to Command Window');
    
    


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



function edit_md_f_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md_f as text
%        str2double(get(hObject,'String')) returns contents of edit_md_f as a double


% --- Executes during object creation, after setting all properties.
function edit_md_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md_f (see GCBO)
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



function edit_thick_f_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thick_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thick_f as text
%        str2double(get(hObject,'String')) returns contents of edit_thick_f as a double


% --- Executes during object creation, after setting all properties.
function edit_thick_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thick_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thick_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thick_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thick_c as text
%        str2double(get(hObject,'String')) returns contents of edit_thick_c as a double


% --- Executes during object creation, after setting all properties.
function edit_thick_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thick_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_shear_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_shear_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_shear_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_shear_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_shear_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_shear_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md_c as text
%        str2double(get(hObject,'String')) returns contents of edit_md_c as a double


% --- Executes during object creation, after setting all properties.
function edit_md_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md_c (see GCBO)
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
%

%%%%%%%%%%%%%   

set(handles.listbox_pu, 'String', '');
string_th{1}=sprintf('dB ref 20 micro Pa');

if(iu==1)
    string_th{2}=sprintf('psi rms'); 
else
    string_th{2}=sprintf('Pa rms');
end

set(handles.listbox_pu,'String',string_th)

%%%%%%%%%%%%%   

if(iu==1)
    
    set(handles.text_L,'String','Length (in)');

    set(handles.text_thick_f,'String','Individual Face Sheet Thickness (in)');
    set(handles.text_thick_c,'String','Core Thickness (in)');
    set(handles.text_em_f,'String','Elastic Modulus (psi)');
    set(handles.text_md_f,'String','Mass Density (lbm/in^3)');
    set(handles.text_shear_modulus,'String','Shear Modulus (psi)');
    set(handles.text_md_c,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_diam,'String','Diameter (in)');
    
    set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)'); 
    set(handles.text_gas_md,'String','Gas Mass Density (lbm/ft^3)');
    
    if(ng==1)
        set(handles.edit_c,'String','1125');
        set(handles.edit_gas_md,'String','0.076487');       
    else
        set(handles.edit_c,'String',' ');   
        set(handles.edit_gas_md,'String',' ');        
    end

    
else
    
    set(handles.text_L,'String','Length (m)');

    set(handles.text_thick_f,'String','Individual Face Sheet Thickness (mm)');
    set(handles.text_thick_c,'String','Core Thickness (mm)');
    set(handles.text_em_f,'String','Elastic Modulus (GPa)');
    set(handles.text_md_f,'String','Mass Density (kg/m^3)');
    set(handles.text_shear_modulus,'String','Shear Modulus (MPa)');
    set(handles.text_md_c,'String','Mass Density (kg/m^3)');     
    set(handles.text_diam,'String','Diameter (m)');    
    
    set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
    set(handles.text_gas_md,'String','Gas Mass Density (kg/m^3)');   
        
    if(ng==1)
        set(handles.edit_c,'String','343');  
        set(handles.edit_gas_md,'String','1.225');         
    else
        set(handles.edit_c,'String',' ');      
        set(handles.edit_gas_md,'String',' ');          
    end    
    
end

%%%%%%%%%%%%%   

set(handles.listbox_pu, 'String', '');
string_th{1}=sprintf('dB ref 20 micro Pa');

if(iu==1)
    string_th{2}=sprintf('psi rms'); 
else
    string_th{2}=sprintf('Pa rms');
end

set(handles.listbox_pu,'String',string_th)


%%%%
 
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
set(handles.edit_md_f,'String',ss2); 
set(handles.edit_mu,'String',ss3);


%%%%





% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    A = imread('re_sandwich_cylinder.jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100)


% --- Executes on selection change in listbox_geo.
function listbox_geo_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_geo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_geo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_geo
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_geo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_geo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diam_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diam as text
%        str2double(get(hObject,'String')) returns contents of edit_diam as a double


% --- Executes during object creation, after setting all properties.
function edit_diam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam (see GCBO)
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


% --- Executes on selection change in listbox_gas.
function listbox_gas_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_gas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_gas


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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on selection change in listbox_eq.
function listbox_eq_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_eq contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_eq


% --- Executes during object creation, after setting all properties.
function listbox_eq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_view_eq.
function pushbutton_view_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_eq,'Value');

if(n==1)
    A = imread('modal_density_sandwich_cylinder.jpg');
    figure(996);    
end
if(n==2)
    A = imread('re_sandwich_cylinder.jpg');
    figure(997);     
end
if(n==3)
    A = imread('equivalent_acoustic_power_cylinder.jpg');
    figure(998)  
end
if(n==4)
    A = imread('velocity_pressure_cylinder.jpg');
    figure(999);     
end

imshow(A,'border','tight','InitialMagnification',100);  



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


% --- Executes on selection change in listbox_pu.
function listbox10_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pu


% --- Executes during object creation, after setting all properties.
function listbox10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    q1=get(handles.listbox_gas,'Value');  
    SEA_Cylinder.listbox_gas=q1;
    out1=sprintf('SEA_Cylinder.listbox_gas=%d',SEA_Cylinder.listbox_gas);
    disp(out1);
catch
end

try
    q2=get(handles.listbox_band,'Value');    
    SEA_Cylinder.listbox_band=q2;
    out2=sprintf('SEA_Cylinder.listbox_band=%d',SEA_Cylinder.listbox_band);  
    disp(out2);    
catch
end

try
    q3=get(handles.listbox_material,'Value');     
    SEA_Cylinder.listbox_material=q3;
    out3=sprintf('SEA_Cylinder.listbox_material=%d',SEA_Cylinder.listbox_material);  
    disp(out3);      
catch
end

try
    iu=get(handles.listbox_units,'Value');    
    SEA_Cylinder.listbox_units=iu;
    out4=sprintf('SEA_Cylinder.listbox_units=%d',SEA_Cylinder.listbox_units);  
    disp(out4);  
catch
end

try
    L=str2num(get(handles.edit_L,'String'));    
    SEA_Cylinder.edit_L=L;
    out5=sprintf('SEA_Cylinder.edit_L=%g',SEA_Cylinder.edit_L);
    disp(out5);  
catch
end

try
    diam=str2num(get(handles.edit_diam,'String'));     
    SEA_Cylinder.edit_diam=diam;
    out6=sprintf('SEA_Cylinder.edit_diam=%g',SEA_Cylinder.edit_diam);
    disp(out6);  
catch
end

try
    E=str2num(get(handles.edit_em,'String'));     
    SEA_Cylinder.edit_em=E;
    out7=sprintf('SEA_Cylinder.edit_em=%g',SEA_Cylinder.em);
    disp(out7);  
catch
end

try
    mu=str2num(get(handles.edit_mu,'String'));    
    SEA_Cylinder.edit_mu=mu;
    out8=sprintf('SEA_Cylinder.edit_mu=%g',SEA_Cylinder.mu);  
    disp(out8);
catch
end

try
    G=str2num(get(handles.edit_shear_modulus,'String'));     
    SEA_Cylinder.edit_shear_modulus=G;
    out9=sprintf('SEA_Cylinder.edit_shear_modulus=%g',SEA_Cylinder.edit_shear_modulus);     
    disp(out9);
catch
end

try
    rhoc=str2num(get(handles.edit_md_c,'String'));     
    SEA_Cylinder.edit_md_c=rhoc;
    out10=sprintf('SEA_Cylinder.edit_md_c=%g',SEA_Cylinder.edit_md_c); 
    disp(out10);
catch
end

try
    hc=str2num(get(handles.edit_thick_c,'String'));    
    SEA_Cylinder.edit_thick_c=hc;
    out11=sprintf('SEA_Cylinder.edit_thick_c=%g',SEA_Cylinder.edit_thick_c);    
    disp(out11);
catch
end

try
    tf=str2num(get(handles.edit_thick_f,'String'));     
    SEA_Cylinder.edit_thick_f=tf;
    out12=sprintf('SEA_Cylinder.edit_thick_f=%g',SEA_Cylinder.edit_thick_f);     
    disp(out12);
catch
end

try
    rhof=str2num(get(handles.edit_md_f,'String'));     
    SEA_Cylinder.edit_md_f=rhof;
    out13=sprintf('SEA_Cylinder.edit_md_f=%g',SEA_Cylinder.edit_md_f);  
    disp(out13);
catch
end

try
    bc=get(handles.listbox_bc,'Value');    
    SEA_Cylinder.listbox_bc=bc;
    out14=sprintf('SEA_Cylinder.listbox_bc=%g',SEA_Cylinder.listbox_bc);
    disp(out14);
catch
end

try
    c=str2num(get(handles.edit_c,'String'));     
    SEA_Cylinder.edit_c=c;
    out15=sprintf('SEA_Cylinder.edit_c=%g',SEA_Cylinder.edit_c); 
    disp(out15);    
catch
end


try
    gas_md=str2num(get(handles.edit_md,'String'));      
    SEA_Cylinder.edit_gas_md=gas_md;
    out16=sprintf('SEA_Cylinder.edit_gas_md=%g',SEA_Cylinder.edit_gas_md); 
    disp(out16);    
catch
end

try
    FS=get(handles.edit_input_array,'String');    
    SEA_Cylinder.edit_input_array=FS;
    out17=sprintf('SEA_Cylinder.edit_input_array=%s',SEA_Cylinder.edit_input_array);      
    disp(out17);    
catch
end

try
    pu=get(handles.listbox_pu,'Value');     
    SEA_Cylinder.listbox_pu=pu;
    out18=sprintf('SEA_Cylinder.listbox_pu=%d',SEA_Cylinder.listbox_pu); 
    disp(out18);    
catch
end




% % %

structnames = fieldnames(SEA_Cylinder, '-full') % fields in the struct


% % %

   [writefname, writepname] = uiputfile('*.mat','Save data as');

   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    try
 
        save(elk, 'SEA_Cylinder'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)

%%%%%%%%%%
%%%%%%%%%%

% Construct a questdlg with two options
choice = questdlg('Save Complete.  Reset Workspace?', ...
    'Options', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        disp([choice ' Reseting'])
        pushbutton_reset_Callback(hObject, eventdata, handles)
end  


function pushbutton_reset_Callback(hObject, eventdata, handles)
%
clear(hObject, eventdata, handles);

msgbox('Reset Complete');


function clear(hObject, eventdata, handles)
%
setappdata(0,'listbox_gas',1);
setappdata(0,'listbox_band',1);
setappdata(0,'listbox_material',1);
setappdata(0,'listbox_units',1);
setappdata(0,'edit_L','');
setappdata(0,'edit_diam','');
setappdata(0,'edit_em','');
setappdata(0,'edit_mu','');
setappdata(0,'edit_shear_modulus','');
setappdata(0,'edit_md_c','');
setappdata(0,'edit_thick_c','');
setappdata(0,'edit_thick_f','');
setappdata(0,'edit_md_f','');
setappdata(0,'listbox_bc',1);
setappdata(0,'edit_c','');
setappdata(0,'edit_gas_md','');
setappdata(0,'edit_input_array','');
setappdata(0,'listbox_pu',1)


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ref 1');

clear(hObject, eventdata, handles);


[filename, pathname] = uigetfile('*.mat');
 
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
   SEA_Cylinder=evalin('base','SEA_Cylinder');
catch
   warndlg(' evalin failed ');
   return;
end

SEA_Cylinder

disp(' ref 2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(isempty(SEA_Cylinder.listbox_gas))
    warndlg('SEA_Cylinder.listbox_gas is empty');
    return;
end

try
    set(handles.listbox_gas,'Value',SEA_Cylinder.listbox_gas);
catch
end


if(isempty(SEA_Cylinder.listbox_band))
    warndlg('SEA_Cylinder.listbox_band is empty');
    return;
end

try
    set(handles.listbox_band,'Value',SEA_Cylinder.listbox_band);
catch
end


if(isempty(SEA_Cylinder.listbox_material))
    warndlg('SEA_Cylinder.listbox_material is empty');
    return;
end

try
    set(handles.listbox_material,'Value',SEA_Cylinder.listbox_material);
catch
end

try
    set(handles.listbox_units,'Value',SEA_Cylinder.listbox_units);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_L);
    set(handles.edit_L,'String',ss);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_diam);
    set(handles.edit_diam,'String',ss);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_em);
    set(handles.edit_em,'String',ss);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_mu);
    set(handles.edit_mu,'String',ss);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_shear_modulus);
    set(handles.edit_shear_modulus,'String',ss);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_md_c);    
    set(handles.edit_md_c,'String',ss);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_thick_c);
    set(handles.edit_thick_c,'String',ss);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_thick_f);
    set(handles.edit_thick_f,'String',ss);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_md_f);
    set(handles.edit_md_f,'String',ss);
catch
end



if(isempty(SEA_Cylinder.listbox_bc))
    warndlg('SEA_Cylinder.listbox_bc is empty');
    return;
end

try
    set(handles.listbox_bc,'Value',SEA_Cylinder.listbox_bc);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_c);
    set(handles.edit_c,'String',ss);
catch
end

try
    ss=sprintf('%g',SEA_Cylinder.edit_gas_md);
    set(handles.edit_gas_md,'String',ss);
catch
end

try
    ss=sprintf('%s',SEA_Cylinder.edit_input_array);
    set(handles.edit_input_array,'String',ss);
catch
end


if(isempty(SEA_Cylinder.listbox_pu))
    warndlg('SEA_Cylinder.listbox_pu is empty');
    return;
end

try
    set(handles.listbox_pu,'Value',SEA_Cylinder.listbox_pu);
catch
end
