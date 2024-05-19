function varargout = panel_point_force_multi(varargin)
% PANEL_POINT_FORCE_MULTI MATLAB code for panel_point_force_multi.fig
%      PANEL_POINT_FORCE_MULTI, by itself, creates a new PANEL_POINT_FORCE_MULTI or raises the existing
%      singleton*.
%
%      H = PANEL_POINT_FORCE_MULTI returns the handle to a new PANEL_POINT_FORCE_MULTI or the handle to
%      the existing singleton*.
%
%      PANEL_POINT_FORCE_MULTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PANEL_POINT_FORCE_MULTI.M with the given input arguments.
%
%      PANEL_POINT_FORCE_MULTI('Property','Value',...) creates a new PANEL_POINT_FORCE_MULTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before panel_point_force_multi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to panel_point_force_multi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help panel_point_force_multi

% Last Modified by GUIDE v2.5 08-Jan-2016 16:58:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @panel_point_force_multi_OpeningFcn, ...
                   'gui_OutputFcn',  @panel_point_force_multi_OutputFcn, ...
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


% --- Executes just before panel_point_force_multi is made visible.
function panel_point_force_multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to panel_point_force_multi (see VARARGIN)

% Choose default command line output for panel_point_force_multi
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes panel_point_force_multi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = panel_point_force_multi_OutputFcn(hObject, eventdata, handles) 
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

delete(panel_point_force_multi);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

fig_num=1;

x_label='Frequency (Hz)';
md=4;

iu=get(handles.listbox_units,'Value');
ns=get(handles.listbox_structure,'Value');

%%%%%%

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

%%%%%%

fc=THM(:,1);
NL=length(fc);
fmin=min(fc);
fmax=max(fc);


F=THM(:,2);
lf=THM(:,3);

if(ns==1 || ns==2)  % Thin Plate
    
    

    area=str2num(get(handles.edit_area,'String'));
    
    E=str2num(get(handles.edit_em,'String'));
    rho=str2num(get(handles.edit_md,'String'));
    mu=str2num(get(handles.edit_mu,'String'));      
    h=str2num(get(handles.edit_thick,'String'));
        
    if(iu==1)
       rho=rho/386; 
    else
       h=h/1000;
       [E]=GPa_to_Pa(E);
    end
    
    B=E*h^3/(12*(1-mu^2));
    
    Z=sqrt(B*rho*h);
    
    if(ns==1) % Middle 
        Z=Z*8;
    else      % Edge
        Z=Z*3.5;
    end
    Y=1/Z;
end

mass=rho*area*h;

[modal_density_Hz,~,~,~]=...
                         panel_generic_modal_density(E,mu,rho,h,area);

                     
vel=zeros(NL,1);
accel=zeros(NL,1);
Moverlap=zeros(NL,1);

for i=1:NL

    omega=tpi*fc(i);
    
    vel2 = F(i)^2*real(Y)/(mass*lf(i)*omega);

    vel(i) = sqrt(vel2);
    
    accel(i)=vel(i)*omega;
    
    Moverlap(i)=modal_density_Hz*lf(i)*fc(i);  

end
                   

if(iu==1)
   VU='in/sec';
   YU='(in/sec)/lbf'; 
   ZU='(lbf-sec)/in'; 
   FU='lbf';
else
   VU='mm/sec'; 
   YU='(m/sec)/N'; 
   ZU='(N-sec)/m'; 
   FU='N';
end

disp(' ');
disp(' * * * ');
disp(' ');
disp(' ');
disp(' Driving Point Real Values ');
disp(' ');
out1=sprintf('  Mobility = %8.4g %s',Y,YU);
out2=sprintf(' Impedance = %8.4g %s \n',Z,ZU);

disp(out1);
disp(out2);


if(iu==1)
   accel=accel/386;
else
   accel=accel/9.81;
   vel=vel*1000; 
end

disp('Spatial Averages, Reverberant Field');
disp(' ');
disp('  Velocity & Accel are RMS ');
disp(' ');
    disp('  Freq   Force   Loss     Velocity     Accel    Modal');

if(iu==1)
    disp('  (Hz)   (lbf)  Factor     (in/sec)     (G)    Overlap');
else
    disp('  (Hz)   (N)    Factor     (mm/sec)     (G)    Overlap');    
end    

for i=1:NL
    out1=sprintf('  %g %7.4g  %8.4g   %8.4g  %8.4g  %7.3g',...
                             fc(i),F(i),lf(i),vel(i),accel(i),Moverlap(i));
    disp(out1);
end

%%

vrms=sqrt(sum(vel.^2));
arms=sqrt(sum(accel.^2));

%%%%%%%%%%%%%

fc=fix_size(fc);
vel=fix_size(vel);
accel=fix_size(accel);

  vel_ps=[fc vel];
accel_ps=[fc accel];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp1=vel_ps;

t_string='Velocity Spectrum';

if(iu==1)
    y_label='Vel (in/sec rms)';    
else
    y_label='Vel (mm/sec rms)';     
end

[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,ppp1,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aaa1=accel_ps;

y_label='Accel (G rms)';
t_string='Acceleration Spectrum';

[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,aaa1,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

qqq1=[fc F];

t_string='Input Force Spectrum';

if(iu==1)
   y_label='Force (lbf)'; 
else
   y_label='Force (N)';    
end

[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,qqq1,fmin,fmax,md);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  

rrr1=[fc lf];

t_string='Total Loss Factor';

y_label='Loss Factor'; 

[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,rrr1,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nb=get(handles.listbox_band,'Value');

if(nb<=2)
    
    [psd,~]=psd_from_spectrum(nb,fc,accel);

    disp(' ');
    disp(' Power Spectral Density ');
    disp(' ');
    disp('   Freq    Accel');
    disp('   (Hz)   (G^2/Hz)');
    
    for i=1:NL
        

        
        out1=sprintf('   %g   %8.4g ',fc(i),psd(i));
        disp(out1);
    
    end
    
    accel_psd=[fc psd];
    
    rrr1=accel_psd;
    
    y_label='Accel (G^2/Hz)';
    
    t_string=sprintf('Power Spectral Density  %7.3g GRMS Overall',arms);

    [fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,rrr1,fmin,fmax,md);    
    
end
%%%%%%%%%%%%%%%%%

disp(' ');
if(iu==1)
    out1=sprintf(' Overall Velocity     = %7.3g in/sec rms',vrms);
else
    out1=sprintf(' Overall Velocity     = %7.3g mm/sec rms',vrms);    
end    
disp(out1);

    out1=sprintf(' Overall Acceleration = %7.3g G rms',arms);
disp(out1);

%%

%%

disp(' ');
out1=sprintf(' Modal density = %7.3g modes/Hz',modal_density_Hz);
disp(out1);
disp(' ');

%%%%%%%%%%%%%%%%%

assignin('base', 'vel_ps',vel_ps);
assignin('base', 'accel_ps',accel_ps);

disp('Output arrays: ');
disp('  Power Spectra:          vel_ps & accel_ps ');
disp('  Power Spectral Density: accel_psd ');
disp(' ');

msgbox('Results written to command window');



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
ns=get(handles.listbox_structure,'Value');
imat=get(handles.listbox_material,'Value');

if(iu==1)  % English
    set(handles.text_pf,'String','2. Point Force (lbf rms)');        
    set(handles.text_thick,'String','Thickness (in)');     
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_area,'String','Area (in^2)');    
else
    set(handles.text_pf,'String','2. Point Force (N rms)');      
    set(handles.text_thick,'String','Thickness (mm)');    
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');     
    set(handles.text_area,'String','Area (m^2)');     
end

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


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


A = imread('mi_thin_plate.jpg');
figure(998) 
imshow(A,'border','tight','InitialMagnification',100) 




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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('velox_point_force.jpg');
figure(999) 
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
