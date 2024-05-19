function varargout = rectangular_plate_uniform_pressure_large_deflection(varargin)
% RECTANGULAR_PLATE_UNIFORM_PRESSURE_LARGE_DEFLECTION MATLAB code for rectangular_plate_uniform_pressure_large_deflection.fig
%      RECTANGULAR_PLATE_UNIFORM_PRESSURE_LARGE_DEFLECTION, by itself, creates a new RECTANGULAR_PLATE_UNIFORM_PRESSURE_LARGE_DEFLECTION or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_PLATE_UNIFORM_PRESSURE_LARGE_DEFLECTION returns the handle to a new RECTANGULAR_PLATE_UNIFORM_PRESSURE_LARGE_DEFLECTION or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_PLATE_UNIFORM_PRESSURE_LARGE_DEFLECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_PLATE_UNIFORM_PRESSURE_LARGE_DEFLECTION.M with the given input arguments.
%
%      RECTANGULAR_PLATE_UNIFORM_PRESSURE_LARGE_DEFLECTION('Property','Value',...) creates a new RECTANGULAR_PLATE_UNIFORM_PRESSURE_LARGE_DEFLECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_plate_uniform_pressure_large_deflection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_plate_uniform_pressure_large_deflection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_plate_uniform_pressure_large_deflection

% Last Modified by GUIDE v2.5 10-Aug-2021 13:05:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_plate_uniform_pressure_large_deflection_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_plate_uniform_pressure_large_deflection_OutputFcn, ...
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


% --- Executes just before rectangular_plate_uniform_pressure_large_deflection is made visible.
function rectangular_plate_uniform_pressure_large_deflection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_plate_uniform_pressure_large_deflection (see VARARGIN)

% Choose default command line output for rectangular_plate_uniform_pressure_large_deflection
handles.output = hObject;

change_unit_material(hObject, eventdata, handles);

set(handles.edit_NSM,'String','0');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rectangular_plate_uniform_pressure_large_deflection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rectangular_plate_uniform_pressure_large_deflection_OutputFcn(hObject, eventdata, handles) 
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
delete(rectangular_plate_uniform_pressure_large_deflection);


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
     
    set(handles.text_thickness,'String','Thickness (in)');
    set(handles.text_elastic_modulus,'String','Elastic Modulus (psi)');
    set(handles.text_rho,'String','Mass Density (lbm/in^3)');
    set(handles.text_NSM,'String','Nonstructural Mass (lbm)');    
else
    set(handles.text_length,'String','Length (m)');
    set(handles.text_width,'String','width (m)');
   
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

try
    FS=get(handles.edit_input_psd,'String');
    THM=evalin('base',FS);   
catch 
    warndlg('Input Filename Error');
    return;
end


fig_num=1;
setappdata(0,'fig_num',1);

MAXF=str2num(get(handles.edit_FMAX,'String'));

nnn=length(THM(:,1));

for i=nnn:-1:1
    if(THM(i,1)>MAXF*1.01)
        THM(i,:)=[];
    end
end

n_units=get(handles.listbox_units,'Value');
iu=n_units;

   n_BC=get(handles.listbox_BC,'Value');
  n_mat=get(handles.listbox_materials,'Value');

L=str2num(get(handles.edit_length,'String'));
W=str2num(get(handles.edit_width,'String'));
h=str2num(get(handles.edit_thickness,'String'));

b=min([L W]);
a=max([L W]);
CC=sqrt(L*W)/2;

ratio=a/b;

E=str2num(get(handles.edit_elastic_modulus,'String'));
mu=str2num(get(handles.edit_poisson_ratio,'String'));
rho=str2num(get(handles.edit_rho,'String'));
NSM=str2num(get(handles.edit_NSM,'String'));
Q=str2num(get(handles.edit_Q,'String'));

damp=1/(2*Q);

dur=str2num(get(handles.edit_T,'String'));

if(n_units==1)
    rho=rho/386;
    NSM=NSM/386;
else
    [E]=GPa_to_Pa(E);
    h=h/1000;
end

sound_speed=sqrt(E/rho);
rho_c=rho*sound_speed;

%
area=L*W;
vol=area*h;
%
rho=rho+(NSM/vol);
%
total_mass=rho*vol;
mass_per_area=total_mass/area;

%

rhos=mass_per_area;

D=E*h^3/(12*(1.-mu^2));

sqDrho=sqrt(D/rhos);

a2=L^2;
a4=L^4;

b2=W^2;
b4=W^4;

a2b2=L^2*W^2;


disp(' Calculate modal frequency & plate shape ');

if(n_BC==1) % ss
%    
    fn=(pi/2)*sqDrho*( (1/a2) + (1/b2) );
    
    [fig_num]=ss_plate_mode_shape(fn,L,W,mass_per_area,fig_num);
    
    v=[1.0 0.0444 0.2874;    % Roark, table 26
       1.2 0.0616 0.3762; 
       1.4 0.0770 0.4530; 
       1.6 0.0906 0.5172; 
       1.8 0.1017 0.5688; 
       2.0 0.1110 0.6102; 
       3.0 0.1335 0.7134;
       4.0 0.1400 0.7410;
       5.0 0.1417 0.7476;
       1000 0.1421 0.750];

%
else  % fixed
%
    [fn,zzr,fig_num,P,dPdx,d2Pdx2,WW,dWdy,d2Wdy2,norm,PF]=...
    fixed_fixed_fixed_fixed_plate_Rayleigh(D,rho,h,L,W,mu,mass_per_area,fig_num);
    fn(2:end)=[];
%
    v=[1.0 0.0138 0.3078; 
       1.2 0.0188 0.3834; 
       1.4 0.0226 0.4356; 
       1.6 0.0251 0.4680; 
       1.8 0.0267 0.4872; 
       2.0 0.0277 0.4974; 
       1000 0.0284 0.5];
%
end

LV=length(v(:,1));


for i=1:LV-1
    if(ratio==v(i,1))
        alpha=v(i,2);
        beta=v(i,3);
        break;
    end
    if(ratio==v(i+1,1))
        alpha=v(i+1,2);
        beta=v(i+1,3);
        break;
    end    
    if(ratio>v(i,1) && ratio <v(i+1,1))
        x1=v(i,1);
        y1=v(i,2);
        x2=v(i+1,1);
        y2=v(i+1,2);        
        [alpha]=linear_interpolation_function(x1,y1,x2,y2,ratio);
        y1=v(i,3);
        y2=v(i+1,3);         
        [beta]=linear_interpolation_function(x1,y1,x2,y2,ratio);        
        break;
    end
end

fprintf('\n alpha=%8.4g  beta=%8.4g\n',alpha,beta);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Synthesize time history

disp('Synthesize time history');

psd=THM;
sr=10*THM(end,1);
dt=1/sr;
[psd_synthesis]=pressure_psd_syn_function_rng1(dur,psd,sr);

npe=1.5;
[psd_synthesis(:,2)]=half_cosine_fade_perc(psd_synthesis(:,2),npe);

% Transmitted pressure

disp('arbit_pressure_function');

fprintf('\n fn=%7.3g Hz, Q=%g  \n',fn,Q);

[trans_pressure]=sdof_response_engine(fn,Q,psd_synthesis(:,2),dt); 

t=psd_synthesis(:,1);
nt=length(t);

data1=psd_synthesis;
data2=[t trans_pressure];

xlabel2='Time(sec)';

if(iu==1)
    ylabel1='Pressure (psi)';
    t_string1=sprintf('External Pressure   %7.3g psi rms  ',std(data1(:,2)));
    t_string2=sprintf('Transmitted Pressure   %7.3g psi rms  ',std(data2(:,2)));
else
    ylabel1='Pressure (Pa)';    
    t_string1=sprintf('External Pressure   %7.3g Pa rms  ',std(data1(:,2)));
    t_string2=sprintf('Transmitted Pressure   %7.3g Pa rms  ',std(data2(:,2)));    
end

ylabel2=ylabel1;

[fig_num]=subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);

disp(' ');
disp(' Perform time domain stress analysis');

% Stress response per large deflection

% bending
% y = alpha*qb*b^3/E*h^3
% y = qb/Cb;
% qb = y*Cb;

Cb=E*h^3/(alpha*b^4);

% membrane
% qm=y^3*Cm


Cm=E*h/(0.516*CC^4);

stress=zeros(nt,1);
Y=zeros(nt,1);

Sm=zeros(nt,1);
Sb=zeros(nt,1);

progressbar;

for i=1:nt
    
    progressbar(i/nt);
    
    Prms=trans_pressure(i);
    p=[Cm 0 Cb -Prms];
    r = roots(p);
    
    for j=3:-1:1
        if(abs(imag(r(j)))>0.00001)
            r(j)=[];
        end
    end
    ra=abs(r);
    [~,I]=max(ra);
    Y(i)=real(r(I));
    
    qm=Y(i)^3*Cm;
    qb=Y(i)*Cb;
    
    Sm(i)=0.396*(qm^2*E*CC^2/h^2)^(1/3);
    
    Sb(i)=beta*qb*b^2/h^2;
    
    stress(i)=(Sm(i)+Sb(i));
end

progressbar(1);


[V]=differentiate_function(Y,dt);
V=fix_size(V);

data1=[t Y];
data2=[t V];

setappdata(0,'displacement',[t Y]);
setappdata(0,'velocity',[t V]);
setappdata(0,'stress',[t stress]);

xlabel2='Time (sec)';


fprintf('\n Plate Center Results \n\n');

if(iu==1)
    ylabel1='Disp (in)';
    t_string1=sprintf('Displacement at Plate Center   %7.3g inch 1\\sigma  ',std(Y));
    fprintf(' Displacement = %7.3g inch 3\x3c3 \n',3*std(Y));
else  
    ylabel1='Disp (m)';    
    t_string1=sprintf('Displacement at Plate Center   %7.3g m 1\\sigma  ',std(Y));
    fprintf(' Displacement = %7.3g m 3\x3c3 \n',3*std(Y));    
end


THM=[t Y];
x_label='Time (sec)';
y_label=ylabel1;
t_string=t_string1;
nbars=31;
[fig_num]=plot_time_history_histogram(fig_num,THM,t_string,x_label,y_label,nbars);


if(iu==1)
    ylabel2='Vel (in/sec)';
    fprintf(' Velocity = %7.3g in/sec 3\x3c3 \n',3*std(V));
    t_string2=sprintf('Velocity at Plate Center   %7.3g inch/sec 1\\sigma  ',std(V));
else  
    ylabel2='Vel (m/sec)';  
    fprintf(' Velocity = %7.3g m/sec 3\x3c3 \n',3*std(V));    
    t_string2=sprintf('Velocity at Plate Center   %7.3g m/sec 1\\sigma  ',std(V));
end

stress_velocity=2*rho_c*std(V);

ssd=std(stress);

if(iu==1)
    
    
    if(ssd<1000)
        t_string3=sprintf('Stress at Plate Center   %7.3g psi 1\\sigma  ',ssd);
        ylabel3='Stress (psi)';
        data3=[t stress];
    else
        t_string3=sprintf('Stress at Plate Center   %7.3g ksi 1\\sigma  ',ssd/1000);
        ylabel3='Stress (ksi)';
        data3=[t stress/1000];
    end    
    
    fprintf(' Stress = %7.3g psi 3\x3c3 = %7.3g ksi 3\x3c3   \n',3*ssd,3*ssd/1000);
    fprintf('\n Stress from velocity = %7.3g psi 1\x3c3 \n',stress_velocity);
      fprintf('                      = %7.3g psi 3\x3c3 \n',3*stress_velocity);    
else  
    ylabel3='Stress (Pa)';
    t_string3=sprintf('Stress at Plate Center   %7.3g Pa 1\x3c3  ',ssd);
    fprintf(' Stress = %7.3g m 3\x3c3 \n',3*ssd);    
    fprintf('\n Stress from velocity = %7.3g Pa 1\x3c3 \n',stress_velocity);    
end
xlabel3=xlabel2;

[fig_num]=subplots_three_linlin_three_titles(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);

sbs=std(Sb);
sms=std(Sm);

if(iu==1) 
    
    if(sbs<1000)
        t_string1=sprintf('Bending Stress at Plate Center   %7.3g psi 1\\sigma  ',sbs); 
    else
        t_string1=sprintf('Bending Stress at Plate Center   %7.3g ksi 1\\sigma  ',sbs/1000);         
    end
        
    if(sms<1000)
        t_string2=sprintf('Membrane Stress at Plate Center   %7.3g psi 1\\sigma  ',sms);
    else
        t_string2=sprintf('Membrane Stress at Plate Center   %7.3g ksi 1\\sigma  ',sms/1000);        
    end
        
    if(ssd<1000)
        t_string3=sprintf('Total Stress at Plate Center   %7.3g psi 1\\sigma  ',ssd);
    else
        t_string3=sprintf('Total Stress at Plate Center   %7.3g ksi 1\\sigma  ',ssd/1000);        
    end
else
    t_string1=sprintf('Bending Stress at Plate Center   %7.3g Pa 1\\sigma  ',std(Sb)); 
    t_string2=sprintf('Membrane Stress at Plate Center   %7.3g Pa 1\\sigma  ',std(Sm));       
    t_string3=sprintf('Total Stress at Plate Center   %7.3g Pa 1\\sigma  ',ssd);    
end

ylabel1=ylabel3;
ylabel2=ylabel3;

if(iu==1)
    ylabel1='Stress (ksi)';
    ylabel2=ylabel1;
    ylabel3=ylabel1;     
    data1=[t Sb/1000];
    data2=[t Sm/1000];
    data3=[t stress/1000];
else
    data1=[t Sb];
    data2=[t Sm];
    data3=[t stress];    
end    

[fig_num]=subplots_three_linlin_three_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);

THM=data3;
x_label='Time (sec)';
y_label=ylabel1;
t_string=t_string3;
nbars=31;
[fig_num]=plot_time_history_histogram(fig_num,THM,t_string,x_label,y_label,nbars);

% go to rainflow script

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[mu,sd,rms,sk,kt]=kurtosis_stats(stress);

fprintf('\n Total stress statistics \n');

if(iu==1)
    fprintf('  Mean=%6.3g psi\n',mu);
else
    fprintf('  Mean=%6.3g Pa\n',mu);    
end
fprintf('  Skewness=%6.3g \n',sk);
fprintf('  Kurtosis=%6.3g \n',kt);

msgbox('Stress calculation complete');


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
    data=getappdata(0,'stress');
end  
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
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



% --- Executes on key press with focus on edit_poisson_ratio and none of its controls.
function edit_poisson_ratio_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson_ratio (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_length and none of its controls.
function edit_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_X and none of its controls.
function edit_X_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_X (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_Y and none of its controls.
function edit_Y_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_MAXF and none of its controls.
function edit_MAXF_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_MAXF (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    dur=get(handles.edit_T,'String');
    plate_pressure.dur=dur;
catch
end

try
    input_psd=get(handles.edit_input_psd,'String');
    plate_pressure.input_psd=input_psd;
catch
end

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
    dur=plate_pressure.dur;    
    set(handles.edit_T,'String',dur);
catch
end

try
    input_psd=plate_pressure.input_psd;    
    set(handles.edit_input_psd,'String',input_psd);
catch
end

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



function edit_input_psd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_psd as text
%        str2double(get(hObject,'String')) returns contents of edit_input_psd as a double


% --- Executes during object creation, after setting all properties.
function edit_input_psd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double


% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_fatigue.
function pushbutton_fatigue_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fatigue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=vibrationdata_rainflow_Miners_nasgro;
set(handles.s,'Visible','on');



function edit_FMAX_Callback(hObject, eventdata, handles)
% hObject    handle to edit_FMAX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_FMAX as text
%        str2double(get(hObject,'String')) returns contents of edit_FMAX as a double


% --- Executes during object creation, after setting all properties.
function edit_FMAX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_FMAX (see GCBO)
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
