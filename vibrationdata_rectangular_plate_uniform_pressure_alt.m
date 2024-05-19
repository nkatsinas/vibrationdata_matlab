function varargout = vibrationdata_rectangular_plate_uniform_pressure_alt(varargin)
% VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_ALT MATLAB code for vibrationdata_rectangular_plate_uniform_pressure_alt.fig
%      VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_ALT, by itself, creates a new VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_ALT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_ALT returns the handle to a new VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_ALT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_ALT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_ALT.M with the given input arguments.
%
%      VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_ALT('Property','Value',...) creates a new VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_ALT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_rectangular_plate_uniform_pressure_alt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_rectangular_plate_uniform_pressure_alt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_rectangular_plate_uniform_pressure_alt

% Last Modified by GUIDE v2.5 02-Dec-2019 14:07:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_rectangular_plate_uniform_pressure_alt_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_rectangular_plate_uniform_pressure_alt_OutputFcn, ...
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


% --- Executes just before vibrationdata_rectangular_plate_uniform_pressure_alt is made visible.
function vibrationdata_rectangular_plate_uniform_pressure_alt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_rectangular_plate_uniform_pressure_alt (see VARARGIN)

% Choose default command line output for vibrationdata_rectangular_plate_uniform_pressure_alt
handles.output = hObject;

change_unit_material(hObject, eventdata, handles);
listbox_BC_Callback(hObject, eventdata, handles);

set(handles.edit_NSM,'String','0');

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_rectangular_plate_uniform_pressure_alt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_rectangular_plate_uniform_pressure_alt_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_rectangular_plate_uniform_pressure_alt);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change_unit_material(hObject, eventdata, handles);
set(handles.uipanel_save,'Visible','off');


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
set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_BC,'Value');

string_th{1}=sprintf('1'); 

if(n==1)
    string_th{2}=sprintf('4');
    string_th{3}=sprintf('9'); 
    string_th{4}=sprintf('16'); 
    string_th{5}=sprintf('25');      
end

set(handles.listbox_modes,'String',string_th);
set(handles.listbox_modes,'Value',1);



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
set(handles.uipanel_save,'Visible','off');


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



disp(' ');
disp(' * * * * * * * ');
disp(' ');


FS=get(handles.edit_input_array_name,'String');

try
    THM=evalin('base',FS);  
catch
    warndlg('Input array not found');
    return;
end

fa=THM(:,1);

fmin=fa(1);
fmax=fa(end);

field=get(handles.listbox_field,'Value');


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


damp=1/(2*Q);


if(n_units==1)
    rho=rho/386;
    NSM=NSM/386;
    c=13500;
else
    [E]=GPa_to_Pa(E);
    h=h/1000;
    c=343;
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
D=E*h^3/(12*(1-mu^2));



kn=get(handles.listbox_modes,'Value');
kxx=[1 2 3 4 5];
nm=kxx(kn);


faux=zeros(nm,1);

mass=mass_per_area*a*b;
%
  
DD=sqrt(D/(rho*h));


N=24;
%
[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N);
[fpsd]=interp_psd_oct(THM(:,1),THM(:,2),freq);

nf=np;

% modes shapes are mass normalized


fig_num=1;

if(n_BC==1)

    Amn=2/sqrt(mass);  
    AAA=(Amn*area/pi^2);
    
    [omegan,fbig,part,phi,~,phi_xx,~,phi_yy,phi_xy,fig_num]=ss_ss_ss_ss_plate_alt(AAA,Amn,DD,a,b,nm,fig_num);
    [H]=H_response(nf,nm,omega,omegan,damp);
    
    if(field==1)
        [jrs2]=joint_acceptance_ss(nm,phi,Amn,AAA,a,b,field,part,c);
        [GD,GV]=GD_response_ss(nf,nm,Amn,phi,x,y,field,H,jrs2,omega,a,b,fpsd);
        [SXX,SYY,SXY]=ss_ss_ss_ss_plate_stress_PSD(E,h,mu,nf,nm,phi_xx,phi_yy,phi_xy,a,b,Amn,H,field,fpsd,x,y,jrs2);
    end
    if(field==2)        
        [jrs2]=joint_acceptance_ss_diffuse(nm,phi,Amn,AAA,a,b,field,part,c,nf,omega);
        [GD,GV]=GD_response_ss_diffuse(nf,nm,Amn,phi,x,y,field,H,jrs2,omega,a,b,fpsd);       
        [SXX,SYY,SXY]=ss_ss_ss_ss_plate_stress_PSD_diffuse(E,h,mu,nf,nm,phi_xx,phi_yy,phi_xy,a,b,Amn,H,field,fpsd,x,y,jrs2);
    end
    if(field==3)        
        [jrs2]=joint_acceptance_ss_uncorrelated(nm,phi,Amn,AAA,a,b,field,part,c);
        [GD,GV]=GD_response_ss(nf,nm,Amn,phi,x,y,field,H,jrs2,omega,a,b,fpsd);
        [SXX,SYY,SXY]=ss_ss_ss_ss_plate_stress_PSD(E,h,mu,nf,nm,phi_xx,phi_yy,phi_xy,a,b,Amn,H,field,fpsd,x,y,jrs2);
    end    
    
else

    nm=1;
    [omegan,fbig,part,phi,dx,dy,dxy,P,W,norm,fig_num]=...
    fixed_fixed_fixed_fixed_plate_Rayleigh_alt(mass_per_area,D,DD,rho,h,mu,a,b,nm,fig_num);
    [H]=H_response(nf,nm,omega,omegan,damp);
    
    if(field==1)
        [jrs2]=joint_acceptance_fixed(nm,phi,norm,field,a,b,P,W,part,c);
        [GD,GV]=GD_response_fixed(nf,phi,P,W,x,y,field,H,jrs2,omega,fpsd,norm);
        [SXX,SYY,SXY]=fixed_fixed_fixed_fixed_plate_stress_PSD(E,h,mu,nf,dx,dy,dxy,H,fpsd,x,y,jrs2);
    end    
    if(field==2)        
        msgbox('Function to be added in future revision');
        return;
    end
    if(field==3)        
        [jrs2]=joint_acceptance_fixed_uncorrelated(nm,phi,norm,field,a,b,P,W,part,c);
        [GD,GV]=GD_response_fixed(nf,phi,P,W,x,y,field,H,jrs2,omega,fpsd,norm);
        [SXX,SYY,SXY]=fixed_fixed_fixed_fixed_plate_stress_PSD(E,h,mu,nf,dx,dy,dxy,H,fpsd,x,y,jrs2);
    end   
        
end

[SVM]=von_Mises_stress_PSD(SXX,SYY,SXY,nf);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fbig=sortrows(fbig,1);

disp(' ');

    if(n_BC==1)
        disp(' Simply-Supported, All Edges');
    else
        disp(' Fixed, All Edges');
    end

disp(' ');
disp('    fn(Hz)   m   n     PF');
%
for i=1:length(faux)
    m=fbig(i,2);
    n=fbig(i,3);
    if(n_BC==1)
        PF=part(AAA,m,n);
    else
        PF=part;
    end
    out1=sprintf(' %9.5g \t %d\t %d \t %8.4g',fbig(i,1),fbig(i,2),fbig(i,3),PF);
    disp(out1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


GD=abs(GD);

[~,rms] = calculate_PSD_slopes(freq,GD);

ppp=[freq GD];

if(n_units==1)
    t_string=sprintf('Displacement Response PSD  (x=%g, y=%g in) \n %7.4g in rms overall',x,y,rms);
    y_label='Disp (in^2/Hz)';
else
    t_string=sprintf('Displacement Response PSD  (x=%g, y=%g m) \n %7.4g mm rms overall',x,y,rms);   
    y_label='Disp (mm^2/Hz)';    
end
   
x_label='Frequency (Hz)';

md=7;


[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

disp(' ');
disp(t_string);


setappdata(0,'displacement_psd',ppp);

set(handles.uipanel_save,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


GV=abs(GV);

[~,rms] = calculate_PSD_slopes(freq,GV);

ppp=[freq GV];

if(n_units==1)
    t_string=sprintf('Velocity Response PSD  (x=%g, y=%g in) \n %7.4g in/sec rms overall',x,y,rms);
    y_label='Disp (in^2/Hz)';
else
    t_string=sprintf('Velocity Response PSD  (x=%g, y=%g m) \n %7.4g mm/sec rms overall',x,y,rms);   
    y_label='Disp (mm^2/Hz)';    
end
   
x_label='Frequency (Hz)';

md=7;


[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

disp(' ');
disp(t_string);


setappdata(0,'velocity_psd',ppp);

set(handles.uipanel_save,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(n_units==1)
    t_string=sprintf('Stress Response PSD  (x=%g, y=%g in)',x,y);
    y_label='Stress (psi^2/Hz)';
    uu='psi';
else
    t_string=sprintf('Stress Response PSD  (x=%g, y=%g m)',x,y);   
    y_label='Stress (Pa^2/Hz)';
    uu='Pa ';
end

SXX=abs(SXX);
SYY=abs(SYY);
SXY=abs(SXY);

[~,SXX_RMS] = calculate_PSD_slopes(freq,SXX);
[~,SYY_RMS] = calculate_PSD_slopes(freq,SYY);
[~,SXY_RMS] = calculate_PSD_slopes(freq,SXY);

ppp1=[freq SXX];
ppp2=[freq SYY];
ppp3=[freq SXY];

leg1=sprintf('SXX %7.3g %s RMS',SXX_RMS,uu);
leg2=sprintf('SYY %7.3g %s RMS',SYY_RMS,uu);
leg3=sprintf('SZZ %7.3g %s RMS',SXY_RMS,uu);

md=7;

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

   
%%%%%


[~,rms] = calculate_PSD_slopes(freq,SVM);

ppp=[freq SVM];

if(n_units==1)
    t_string=sprintf('von Mises Stress Response PSD  (x=%g, y=%g in) \n %7.4g psi rms overall',x,y,rms);
    y_label='Stress (psi^2/Hz)';
else
    t_string=sprintf('von Mises Stress Response PSD  (x=%g, y=%g m) \n %7.4g Pa rms overall',x,y,rms);   
    y_label='Stress (Pa^2/Hz)';    
end
    
x_label='Frequency (Hz)';

md=7;

fc=ppp(:,1);

fmin=fc(1);
fmax=fc(end);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


% disp(' Calculation complete');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function[H]=H_response(nf,nm,omega,omegan,damp)

    H=zeros(nf,nm,nm);
    
    for k=1:nf
        
       for i=1:nm
           for j=1:nm
%            
                den=(omegan(i,j)^2-omega(k)^2) + (1i)*2*damp*omega(k)*omegan(i,j);
                H(k,i,j)=1/den;
           end     
%
        end
    end
    
%

function[GD,GV]=GD_response_ss(nf,nm,Amn,phi,x,y,field,H,jrs2,omega,a,b,fpsd)
    
    GD=zeros(nf,1);
    GV=zeros(nf,1);
    
    for k=1:nf
        for i=1:nm
            for j=1:nm   
                
                [p1,p2,q1,q2]=index(field,i,j,nm);
                    
                for p=p1:p2
                    for q=q1:q2
                        term1=(phi(Amn,x,y,i,j,a,b))*(phi(Amn,x,y,p,q,a,b))*jrs2(i,j,p,q);
                        term2=H(k,i,j)*conj(H(k,p,q));
                        GD(k)=GD(k)+term1*term2;
                    end
                end
            end
        end
        GD(k)=GD(k)*fpsd(k);
        GV(k)=GD(k)*(omega(k))^2;
    end     

    
function[GD,GV]=GD_response_ss_diffuse(nf,nm,Amn,phi,x,y,field,H,jrs2,omega,a,b,fpsd)
    
    GD=zeros(nf,1);
    GV=zeros(nf,1);
    
    for k=1:nf
        for i=1:nm
            for j=1:nm   
                
                [p1,p2,q1,q2]=index(field,i,j,nm);
                    
                for p=p1:p2
                    for q=q1:q2
                        term1=(phi(Amn,x,y,i,j,a,b))*(phi(Amn,x,y,p,q,a,b))*jrs2(k,i,j,p,q);
                        term2=H(k,i,j)*conj(H(k,p,q));
                        GD(k)=GD(k)+term1*term2;
                    end
                end
            end
        end
        GD(k)=GD(k)*fpsd(k);
        GV(k)=GD(k)*(omega(k))^2;
    end     
    
    GD=abs(GD);
    GV=abs(GV);
      
    
function[GD,GV]=GD_response_fixed(nf,phi,P,W,x,y,field,H,jrs2,omega,fpsd,norm)
    
    GD=zeros(nf,1);
    GV=zeros(nf,1);
    
    for k=1:nf
        term1=phi(P(x),W(y),norm)*phi(P(x),W(y),norm)*jrs2;
        term2=H(k,1,1)*conj(H(k,1,1));
        GD(k)=GD(k)+term1*term2;
        GD(k)=GD(k)*fpsd(k);
        GV(k)=GD(k)*(omega(k))^2;
    end       
    
function[jrs2]=joint_acceptance_ss_uncorrelated(nm,phi,Amn,AAA,a,b,field,part,c)

   jrs2=zeros(nm,nm,nm,nm);

        for i=1:nm
            for j=1:nm
                for p=i:i
                    for q=j:j
                            
                        jrs2(i,j,p,q)=jrs2(i,j,p,q)+part(AAA,i,j)*part(AAA,p,q);
             
                    end
                end    
            end
        end     
   
        
%%
function[jrs2]=joint_acceptance_ss(nm,phi,Amn,AAA,a,b,field,part,c)

   jrs2=zeros(nm,nm,nm,nm);

        for i=1:nm
            for j=1:nm
                for p=1:nm
                    for q=1:nm
                            
                        jrs2(i,j,p,q)=jrs2(i,j,p,q)+part(AAA,i,j)*part(AAA,p,q);
             
                    end
                end    
            end
        end     
   
        
%%

function[jrs2]=joint_acceptance_ss_diffuse(nm,phi,Amn,AAA,a,b,field,part,c,nf,omega)

    tic 

    jrs2=zeros(nf,nm,nm,nm,nm);
    
    num=41;
    
    dx=a/(num-1);
    dy=b/(num-1);
%
 
    x=zeros(num,1);
    y=zeros(num,1);
 
    for i=1:num
        ii=i-1;
        x(i)=ii*dx;
        y(i)=ii*dy;
    end
    
    disp('ref 1');

    kv=1;
    
    progressbar;
    
    dr=zeros(num^4,1);
    
    for i1=1:num
        for j1=1:num
            for i2=i1:num
                for j2=j1:num
                
                    idiff=abs(i1-i2);
                    jdiff=abs(j1-j2);
                    
                    dr(kv,1)=idiff;
                    dr(kv,2)=jdiff;
                    
                    kv=kv+1;
                    
%                    d(idiff+1,jdiff+1)=abs(pdist([x(i1),y(j1);x(i2),y(j2)],'euclidean'));
                          
                end
            end
        end        
    end   
    
    progressbar(1);
   
    
    ddr=unique(dr,'rows');
    
   
    nd=length(ddr);

    ss=zeros(nf,nd); 
    
    sa=zeros(nf,nd,nd);
    
    for i=1:nd
        ia=ddr(i,1);
        ib=ddr(i,2);
        d=norm( [ia*dx,ib*dy ]);
        
        for ijk=1:nf
            
            k=omega(ijk)/c;
            
            if(d>1.0e-80)
                
                arg=k*d;   
                ss(ijk,i)=sin(arg)/arg;
            else
                ss(ijk,i)=1;             
            end
            
            sa(ijk,ia+1,ib+1)=ss(ijk,i);
            
        end       
            
    end

    

     disp('ref 2');

      kv=1;
      
      ttt=num^2*nm^2;
    
       progressbar;
    
       Q=zeros(num,num,nm,nm);
       
        for i1=1:num
            for j1=1:num
                for i=1:nm
                    for j=1:nm
                        
                        progressbar(kv/ttt);
                        
                        Q(i1,j1,i,j)=phi(Amn,x(i1),y(j1),i,j,a,b);
                        
                        kv=kv+1;
                    end
                end
            end
        end
        
        progressbar(1);
                        
                      
    disp('ref 3');
    
        QA=zeros(num,num,nm,nm,num,num,nm,nm);
        cc=zeros(num,num,nm,nm,num,num,nm,nm);
    
        num4=num^4;
        
        kv=0;
        
        for i1=1:num
            for j1=1:num
                for i2=1:num
                    for j2=1:num
               
                        progressbar(kv/num4);      
                        
                        for i=1:nm
                            for j=1:nm
                
                                for p=1:nm
                                    for q=1:nm              
                                        
                                        
                                         if(cc(i1,j1,i,j,i2,j2,p,q)==0)
                                            QA(i1,j1,i,j,i2,j2,p,q)=Q(i1,j1,i,j)*Q(i2,j2,p,q);
                                            cc(i1,j1,i,j,i2,j2,p,q)=1;
                                         end
                                         
                                         if(cc(i2,j2,p,q,i1,j1,i,j)==0)
                                            QA(i2,j2,p,q,i1,j1,i,j)=QA(i1,j1,i,j,i2,j2,p,q);
                                            cc(i2,j2,p,q,i1,j1,i,j)=1;
                                         end
                                    end
                                end
                            end
                        end
                        
                        kv=kv+1;
                    end
                end
            end
        end
        
        progressbar(1);
        
        clear cc;
    
    disp('ref 4'); 
    

       kv=1;
  
        
       progressbar;
       
       
        for ijk=1:nf
        
            progressbar(ijk/nf);        
                                       
               
            for i1=1:num
                for j1=1:num
                    for i2=1:num
                        for j2=1:num
       
                            idiff=abs(i1-i2);
                            jdiff=abs(j1-j2);
                            ss=sa(ijk,idiff+1,jdiff+1);
                       
                            for i=1:nm
                                for j=1:nm
                
                                    for p=1:nm
                                        for q=1:nm
     
                                            jrs2(ijk,i,j,p,q)=jrs2(ijk,i,j,p,q)+QA(i1,j1,i,j,i2,j2,p,q)*ss;
                                    
                                            kv=kv+1;
                                         
                                        end
                                    end    
                                end 
                            end
                         
                        end
                    end    
                end
            end    
        end
     
           
       progressbar(1);

       disp('ref 5'); 

    jrs2=jrs2*dx^2*dy^2;
       
    toc
    
function[jrs2]=joint_acceptance_fixed(nm,phi,norm,field,a,b,P,W,part,c)

   jrs2=part^2;
   
   return;
   
% following code is place holder   

   jrs2=zeros(nm,nm,nm,nm);

%%
    num=31;
    
    dx=a/(num-1);
    dy=b/(num-1);
%
 
    x=zeros(num,1);
    y=zeros(num,1);
 
    for i=1:num
        ii=i-1;
        x(i)=ii*dx;
        y(i)=ii*dy;
    end
    
    for i=1:nm
        for j=1:nm
            for p=1:nm
                for q=1:nm
                    for i1=1:num
                        for j1=1:num
                            for i2=1:num
                                for j2=1:num
                                    jrs2(i,j,p,q)=jrs2(i,j,p,q)+phi(P(x(i1)),W(y(j1)),norm)*phi(P(x(i2)),W(y(j2)),norm);
                                end
                            end    
                        end 
                    end
                end
            end    
        end
    end        

    jrs2=jrs2*dx^2*dy^2;
    
%%


function[jrs2]=joint_acceptance_fixed_uncorrelated(nm,phi,norm,field,a,b,P,W,part,c)

   jrs2=part^2;
   
   return;
   
% following code is place holder   

   jrs2=zeros(nm,nm,nm,nm);

%%
    num=31;
    
    dx=a/(num-1);
    dy=b/(num-1);
%
 
    x=zeros(num,1);
    y=zeros(num,1);
 
    for i=1:num
        ii=i-1;
        x(i)=ii*dx;
        y(i)=ii*dy;
    end
    
    for i=1:nm
        for j=1:nm
            for p=i:i
                for q=j:j
                    for i1=1:num
                        for j1=1:num
                            for i2=1:num
                                for j2=1:num
                                    jrs2(i,j,p,q)=jrs2(i,j,p,q)+phi(P(x(i1)),W(y(j1)),norm)*phi(P(x(i2)),W(y(j2)),norm);
                                end
                            end    
                        end 
                    end
                end
            end    
        end
    end        

    jrs2=jrs2*dx^2*dy^2;
    
%%


function[p1,p2,q1,q2]=index(field,i,j,nm)

    if(field==1)
        p1=1;
        p2=nm;
        q1=1;
        q2=nm;
    else
        p1=i;
        p2=i;
        q1=j;
        q2=j;
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
% hObject    handle to edit_poisson_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poisson_ratio as text
%        str2double(get(hObject,'String')) returns contents of edit_poisson_ratio as a double


% --- Executes during object creation, after setting all properties.
function edit_rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson_ratio (see GCBO)
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
    data=getappdata(0,'displacement_psd');
end
if(n==4)
    data=getappdata(0,'stress_transfer');
end  
if(n==5)
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
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_poisson_ratio and none of its controls.
function edit_poisson_ratio_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson_ratio (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_length and none of its controls.
function edit_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_X and none of its controls.
function edit_X_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_X (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_Y and none of its controls.
function edit_Y_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_MAXF and none of its controls.
function edit_MAXF_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_MAXF (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in listbox_materials.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_materials contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_materials


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit_poisson_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poisson_ratio as text
%        str2double(get(hObject,'String')) returns contents of edit_poisson_ratio as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho as text
%        str2double(get(hObject,'String')) returns contents of edit_rho as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit_NSM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_NSM as text
%        str2double(get(hObject,'String')) returns contents of edit_NSM as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_NSM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_interpolate.
function listbox_interpolate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_interpolate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_interpolate


% --- Executes during object creation, after setting all properties.
function listbox_interpolate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_field.
function listbox_field_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_field contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_field
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_modes.
function listbox_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_modes
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_rho and none of its controls.
function edit_rho_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_NSM and none of its controls.
function edit_NSM_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_NSM (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    n=get(handles.listbox_view,'Value');

    if(n==1)
        A = imread('rectangular_plate_force_PSD_response.jpg');
        figure(996)
    end    
    if(n==2)
        A = imread('plate_stress_PSD.jpg');
        figure(997)        
    end    
    if(n==3)
        A = imread('rectangular_plate_force_PSD_response_vM.jpg');
        figure(998)       
    end
    if(n==4)
        A = imread('diffuse_field_equation.jpg');
        figure(999)       
    end
    
    imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on selection change in listbox_view.
function listbox_view_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_view contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_view


% --- Executes during object creation, after setting all properties.
function listbox_view_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
