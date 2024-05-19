function varargout = rectangular_plate_simply_supported(varargin)
% RECTANGULAR_PLATE_SIMPLY_SUPPORTED MATLAB code for rectangular_plate_simply_supported.fig
%      RECTANGULAR_PLATE_SIMPLY_SUPPORTED, by itself, creates a new RECTANGULAR_PLATE_SIMPLY_SUPPORTED or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_PLATE_SIMPLY_SUPPORTED returns the handle to a new RECTANGULAR_PLATE_SIMPLY_SUPPORTED or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_PLATE_SIMPLY_SUPPORTED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_PLATE_SIMPLY_SUPPORTED.M with the given input arguments.
%
%      RECTANGULAR_PLATE_SIMPLY_SUPPORTED('Property','Value',...) creates a new RECTANGULAR_PLATE_SIMPLY_SUPPORTED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_plate_simply_supported_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_plate_simply_supported_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_plate_simply_supported

% Last Modified by GUIDE v2.5 26-Jul-2022 08:38:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_plate_simply_supported_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_plate_simply_supported_OutputFcn, ...
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


% --- Executes just before rectangular_plate_simply_supported is made visible.
function rectangular_plate_simply_supported_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_plate_simply_supported (see VARARGIN)

% Choose default command line output for rectangular_plate_simply_supported
handles.output = hObject;

set(handles.listbox_unit,'Value',1);
set(handles.listbox_material,'Value',1);

set(handles.pushbutton_base,'Visible','off');
set(handles.pushbutton_force,'Visible','off');

listbox_unit_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rectangular_plate_simply_supported wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rectangular_plate_simply_supported_OutputFcn(hObject, eventdata, handles) 
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

delete(rectangular_plate_simply_supported);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

iu=get(handles.listbox_unit,'Value');

  E=str2num(get(handles.edit_elastic_modulus,'String'));
 mu=str2num(get(handles.edit_poisson,'String'));
rho=str2num(get(handles.edit_mass_density,'String'));
nsm=str2num(get(handles.edit_nsm,'String'));

if(isempty(nsm))
    warndlg('Enter nonstructural mass');
    return;
end


try
  L=str2num(get(handles.edit_length,'String'));
except
    warndlg(' Enter Length ');
    return;
end
  
try
  W=str2num(get(handles.edit_width,'String'));
except
    warndlg(' Enter Width ');
    return;
end

try
  T=str2num(get(handles.edit_thickness,'String'));
except
    warndlg(' Enter Thickness ');
    return;
end


  
if(iu==1) % English
    rho=rho/386;
    nsm=nsm/386;
else
    L=L/1000;
    W=W/1000;
    T=T/1000;
    [E]=GPa_to_Pa(E);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  after unit conversion

setappdata(0,'iu',iu);  
setappdata(0,'E',E);  
setappdata(0,'mu',mu);
setappdata(0,'nsm',nsm);
setappdata(0,'L',L);
setappdata(0,'W',W);
setappdata(0,'T',T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

area=L*W;
volume=area*T;

total_mass = (rho*volume + nsm);

h=T;
a=L;
b=W;

rho=total_mass/volume;

mass_area=rho*h;

setappdata(0,'rho',rho);

D=E*(h^3)/(12*(1-mu^2));
BBB=D;
% 
setappdata(0,'D',D);

sq_mass=sqrt(total_mass);

setappdata(0,'sq_mass',sq_mass);
%
DD=sqrt(D/(rho*h));

fprintf('\n  D = %8.4g  rho*h = %8.4g \n\n',D,rho*h);

%
setappdata(0,'DD',DD);

nmodes=70;
mt=nmodes^2;
n2=nmodes*nmodes;

omegamn=zeros(nmodes,nmodes);
%
faux=zeros(nmodes,nmodes);
%
i=1;
for m=1:nmodes
    for n=1:nmodes
        omegamn(m,n)=DD*( (m*pi/a)^2 + (n*pi/b)^2 );
        faux(i)=omegamn(m,n)/(2*pi);
        i=i+1;        
    end
end
%

sort(faux);

setappdata(0,'total_mass',total_mass);


Amn=2/sqrt(total_mass);
%
AAA=(2*sqrt(total_mass)/pi^2);
FFF= 2*a*b/(sqrt(total_mass)*pi^2);
%
iv=1;
%
part=zeros(nmodes,nmodes);
%
fbig=zeros(n2,8);
m_index=zeros(n2,1);
n_index=zeros(n2,1);
%
for i=1:nmodes
    for j=1:nmodes
             core=(cos(i*pi)-1)*(cos(j*pi)-1)/(i*j);
        part(i,j)=AAA*core;
        
        force_part=FFF*core;
        
        
            m_index(iv)=i;
            n_index(iv)=j;        
        
            fbig(iv,1)=faux(iv);
            fbig(iv,2)=i;
            fbig(iv,3)=j;
            fbig(iv,4)=part(i,j);
            fbig(iv,5)=(part(i,j))^2;
            fbig(iv,6)=m_index(iv);
            fbig(iv,7)=n_index(iv);
            fbig(iv,8)=force_part;
        
            iv=iv+1;
        
  
    end
end



fbig=sortrows(fbig,1);
%

sz=size(fbig);

kj=1;

part_max=max(abs(fbig(:,4)));

for i=1:sz(1)
    part=abs(fbig(i,4));
    if((part/part_max)>1.0e-03)
        fbigs(kj,:)=fbig(i,:);
        kj=kj+1;
    end
end

fbigs(:,4);
setappdata(0,'fbig',fbigs);

%
if(mt>16)
    mt=16;
end

setappdata(0,'mt',mt);

disp(' ');
disp('    fn(Hz)   m   n        PF    EMM ratio');
for i=1:mt 
    out1=sprintf(' %9.5g \t %d\t %d\t %8.4g\t %8.4g  ',fbig(i,1),fbig(i,2),fbig(i,3),fbig(i,4),fbig(i,5)/total_mass);
    disp(out1);
    
end
disp(' ');


assignin('base','plate_fn',fbig(i,1)); 

ioct=2;
[fc,imax]=octaves(ioct);

fn=fbig(:,1);

mode_count=zeros(imax,1);
modal_density=zeros(imax,2);

fnL=length(fn);
fcL=length(fc);

for i=1:ceil(0.5*fnL)
    
    for j=1:(fcL-1)
       
        if(fn(i)> fc(j) && fn(i) < fc(j+1))
            mode_count(j)=mode_count(j)+1;
            break;
        end    
        
    end
    
end

for j=1:fcL
    
    bw=( 2^(1/6) -   1/(2^(1/6))  )*fc(j);

   if(mode_count(j) >=1)
        modal_density(j,2)=mode_count(j)/bw;
   end
end    


fff=fc;
aaa=modal_density(:,2);

%% [ff,aa]=remove_zeros_all(fff,aaa);

ff=fix_size(fff);
aa=fix_size(aaa);

[fx,ax]=remove_zeros_all(fff,aaa);


fxL=length(fx);

fmin=fx(1);
fmax=fx(fxL-1);


clear modal_density;

modal_density=[ff aa];


CCC=(area/(4*pi))*sqrt( mass_area/BBB );

ffL=length(ff);

SEA_md=zeros(ffL,1);


for i=1:ffL
    
    omega=2*pi*ff(i);
   
    term=CCC-0.25*((mass_area/BBB)^(0.25))*(( L+W )/pi)/sqrt(omega);
    
    SEA_md(i)=2*pi*term;
    
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
num_nodes=81;
setappdata(0,'num_nodes',num_nodes);   
%
disp(' ');
%
dx=a/80;
dy=b/80;
%
pa=pi/a;
pb=pi/b;
%
clear z;
clear zmn;
%
x=zeros(1,num_nodes);
y=zeros(1,num_nodes);
z=zeros(num_nodes,num_nodes);
zmn=zeros(mt,num_nodes,num_nodes);
%
for i=1:num_nodes
    x(i)=pa*(i-1)*dx;   
    y(i)=pb*(i-1)*dy;  
end
%
xx=x*a/max(x);
yy=y*b/max(y);
%
for iv=1:mt
    for i=1:num_nodes
        term1=sin(fbig(iv,2)*x(i));
        for j=1:num_nodes    
            z(i,j)=term1*sin(fbig(iv,3)*y(j));
            zmn(iv,i,j)=z(i,j);
        end        
    end
    if(iv<=6)
        figure(fig_num);
        fig_num=fig_num+1;
        zzr=z';
        surf(xx,yy,zzr);
        xlabel('X');
        ylabel('Y');
        out1=sprintf('Mode %d   fn=%8.4g Hz',iv,fbig(iv,1));
        title(out1);
    end
%
end
%
z=z*Amn;
%
setappdata(0,'Amn',Amn);
setappdata(0,'ModeShapes',z);
%

x_label='Frequency (Hz)';
y_label='Modal Density (modes/Hz)';
t_string='Modal Density, Plate Bending, Simply Supported';

ppp1=modal_density(1:(ffL-1),:);
ppp2=[ff(1:(ffL-1)) SEA_md(1:(ffL-1))];

leg1='Modal Analysis';
leg2='SEA Theory';




ymin=0;
ymax=1.4*max(modal_density(:,2));


[fig_num,h2]=plot_loglin_function_two_NW_ymin_ymax_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,ymin,ymax);           
           
%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  After calculation
%

if(iu==1)
    total_mass=total_mass*386;
end

s1=sprintf('%8.4g',total_mass);

set(handles.edit_total_mass,'String',s1);

%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.pushbutton_base,'Visible','on');
set(handles.pushbutton_force,'Visible','on');


setappdata(0,'fig_num',fig_num);

msgbox('Results written to Command Window');

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



function edit_nsm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nsm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nsm as text
%        str2double(get(hObject,'String')) returns contents of edit_nsm as a double


% --- Executes during object creation, after setting all properties.
function edit_nsm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nsm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_total_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_total_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_total_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_total_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_total_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_total_mass (see GCBO)
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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

set(handles.edit_total_mass,'String','');

n=get(handles.listbox_unit,'Value');

m=get(handles.listbox_material,'Value');

if(n==1)  % English
    if(m==1) % aluminum
        elastic_modulus=1e+007;
        mass_density=0.1;  
    end  
    if(m==2)  % steel
        elastic_modulus=3e+007;
        mass_density= 0.28;         
    end
    if(m==3)  % copper
        elastic_modulus=1.6e+007;
        mass_density=  0.322;
    end
    if(m==4)  % G10
        elastic_modulus=2.7e+006;
        mass_density=  0.065;
    end
else                 % metric
    if(m==1)  % aluminum
        elastic_modulus=70;
        mass_density=  2700;
    end
    if(m==2)  % steel
        elastic_modulus=205;
        mass_density=  7700;        
    end
    if(m==3)   % copper
        elastic_modulus=110;
        mass_density=  8900;
    end
    if(m==4)  % G10
        elastic_modulus=18.6;
        mass_density=  1800;
    end
end
 
if(m==1) % aluminum
        poisson=0.33;  
end  
if(m==2)  % steel
        poisson= 0.30;         
end
if(m==3)  % copper
        poisson=  0.33;
end
if(m==4)  % G10
        poisson=  0.12;
end
 
if(m<5)
    ss1=sprintf('%8.4g',elastic_modulus);
    ss2=sprintf('%8.4g',mass_density);
    ss3=sprintf('%8.4g',poisson);  
 
    set(handles.edit_elastic_modulus,'String',ss1);
    set(handles.edit_mass_density,'String',ss2);  
    set(handles.edit_poisson,'String',ss3);  
end


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



function edit_poisson_Callback(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poisson as text
%        str2double(get(hObject,'String')) returns contents of edit_poisson as a double


% --- Executes during object creation, after setting all properties.
function edit_poisson_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

n=get(handles.listbox_unit,'Value');

if(n==1)
    sem='Elastic Modulus (psi)';
    smd='Mass Density (lbm/in^3)';
    snsm='Nonstructral Mass (lbm)';
    stmass='Total Mass (lbm)';
    sL='Length (in)';
    sW='Width (in)';
    sT='Thickness (in)';
else
    sem='Elastic Modulus (GPa)';
    smd='Mass Density (kg/m^3)';
    snsm='Nonstructral Mass (kg)';
    stmass='Total Mass (kg)';
    sL='Length (mm)';
    sW='Width (mm)';
    sT='Thickness (mm)';    
end    
%
set(handles.text_elastic_modulus,'String',sem);
set(handles.text_mass_density,'String',smd);
set(handles.text_nsm,'String',snsm);
set(handles.text_total_mass,'String',stmass);
set(handles.text_length,'String',sL);
set(handles.text_width,'String',sW);
set(handles.text_thickness,'String',sT);

listbox_material_Callback(hObject, eventdata, handles);




% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_base.
function pushbutton_base_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=plate_ss_base;    

set(handles.s,'Visible','on'); 


% --- Executes on key press with focus on edit_nsm and none of its controls.
function edit_nsm_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nsm (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_total_mass,'String','');


% --- Executes on key press with focus on edit_mass_density and none of its controls.
function edit_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_total_mass,'String','');


% --- Executes on button press in pushbutton_force.
function pushbutton_force_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=plate_ss_force;    

set(handles.s,'Visible','on'); 


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
