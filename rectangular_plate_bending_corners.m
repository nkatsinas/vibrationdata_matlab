function varargout = rectangular_plate_bending_corners(varargin)
% RECTANGULAR_PLATE_BENDING_CORNERS MATLAB code for rectangular_plate_bending_corners.fig
%      RECTANGULAR_PLATE_BENDING_CORNERS, by itself, creates a new RECTANGULAR_PLATE_BENDING_CORNERS or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_PLATE_BENDING_CORNERS returns the handle to a new RECTANGULAR_PLATE_BENDING_CORNERS or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_PLATE_BENDING_CORNERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_PLATE_BENDING_CORNERS.M with the given input arguments.
%
%      RECTANGULAR_PLATE_BENDING_CORNERS('Property','Value',...) creates a new RECTANGULAR_PLATE_BENDING_CORNERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_plate_bending_corners_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_plate_bending_corners_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_plate_bending_corners

% Last Modified by GUIDE v2.5 05-May-2024 15:18:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_plate_bending_corners_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_plate_bending_corners_OutputFcn, ...
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


% --- Executes just before rectangular_plate_bending_corners is made visible.
function rectangular_plate_bending_corners_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_plate_bending_corners (see VARARGIN)

% Choose default command line output for rectangular_plate_bending_corners
handles.output = hObject;

set(handles.listbox_unit,'Value',1);
set(handles.listbox_material,'Value',1);

set(handles.pushbutton_base_input,'Visible','off');

listbox_unit_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rectangular_plate_bending_corners wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rectangular_plate_bending_corners_OutputFcn(hObject, eventdata, handles) 
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

delete(rectangular_plate_bending_corners);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'rectangular_plate_bending_corners_key',0);

fmin=1.0e+90; 

n=get(handles.listbox_unit,'Value');
iu=n;

  E=str2num(get(handles.edit_elastic_modulus,'String'));
 mu=str2num(get(handles.edit_poisson,'String'));
rho=str2num(get(handles.edit_mass_density,'String'));
nsm=str2num(get(handles.edit_nsm,'String'));
  
  L=str2num(get(handles.edit_length,'String'));
  W=str2num(get(handles.edit_width,'String'));
  T=str2num(get(handles.edit_thickness,'String'));

  
if(isempty(L))
    warndlg('Enter Length');
    return;
end
if(isempty(W))
    warndlg('Enter Width');
    return;
end
if(isempty(T))
    warndlg('Thickness');
    return;
end

if(n==1) % English
    rho=rho/386;
    nsm=nsm/386;
else
    L=L/1000;
    W=W/1000;
    T=T/1000;
    [E]=GPa_to_Pa(E);
end
  
  
setappdata(0,'T',T);
setappdata(0,'L',L);
setappdata(0,'W',W);  
setappdata(0,'iu',iu);  
  
setappdata(0,'E',E);
setappdata(0,'rho',rho);
setappdata(0,'mu',mu);

area=L*W;
volume=area*T;

total_mass = (rho*volume + nsm);

rho=total_mass/volume;

if(n==1)
    total_mass=total_mass*386;
end

s1=sprintf('%8.4g',total_mass);

set(handles.edit_total_mass,'String',s1);

h=T;
a=L;
b=W;

clear T;

D=E*(h^3)/(12*(1-mu^2)); 


            fprintf('vol=%8.4g  total_mass=%8.4g  area=%8.4g app.DD=%8.4g\n',volume,total_mass,area,D)

      

% 
num=40;
np1=num+1;

nnn=num;
dx=a/num; 
dy=b/num; 
pia=pi/a; 
pib=pi/b; 
% 
knum=2000; 
alpha_r=0; 
beta_r=0;
gamma_r=0;

fprintf('a=%8.4g  h=%8.4g  app.rhos*h=%8.4g \n',a,h,rho*h)
%
fn1=1.13*sqrt(D/(rho*h))/a^2;
fn2=1.13*sqrt(D/(rho*h))/b^2;
fff=[fn1 fn2];
flow=min(fff);
fup=max(fff);
%
set(handles.edit_result,'Enable','on','String','Calculating...');
%
%
c1=2*mu;
c2=2*(1-mu);
%
for k=1:knum
    alpha= 0.8*rand+0.2;
    beta = 0.8*rand+0.2;
    
    if(k==1)
        beta=alpha;
    end
%
    if(k>10 && rand > 0.8 )
        alpha=alpha_r*(0.96+0.08*rand);
        beta =beta_r*(0.96+0.08*rand);    
    end
%
    aaa=[alpha beta];
    gamma= min(aaa)*rand;
%    
    if(abs(a-b)<a/100)
        alpha=beta;
    end
%
    sum=alpha+beta+gamma;
    alpha=alpha/sum;
    beta =beta/sum;
    gamma=gamma/sum;
%
    pia_alpha=pia*alpha;
    pib_beta =pib*beta;
    pia2_alpha=(pia^2)*alpha;
    pib2_beta =(pib^2)*beta;    
%
    Z1A=0;
    Z2A=0;
    V=0;
    T=0;
    for i=0:nnn
        x=(i*dx-(a/2))*pia;
        cx=cos(x);
        sx=sin(x);
        for j=0:nnn
            y=(j*dy-(b/2))*pib;
            sy=sin(y);
            cy=cos(y);
            Z=alpha*cx + beta*cy + gamma*cx*cy;
%
            Z1A=Z1A+Z;            
            Z2A=Z2A+Z^2;
%
            dZdx  =  -pia_alpha*(1+gamma*sy)*sx;
            d2Zdx2=  -pia2_alpha*(1+gamma*sy)*cx;   
%
            dZdy  =  -pib_beta*(1+gamma*sx)*sy;
            d2Zdy2=  -pib2_beta*(1+gamma*sx)*cy;  
%    
            d2Zdxdy=pia_alpha*pib_beta*gamma*sy*sx;
%
            V1=(d2Zdx2)^2;
            V2=(d2Zdy2)^2;
            V3=c1*(d2Zdx2)*(d2Zdy2);
            V4=c2*(d2Zdxdy)^2;
%            
            V=V+ V1+V2+V3+V4;
            T=T+Z^2;
        end
    end
    V=V*D/2;
    T=T*rho*h/2;
    omega=sqrt(V/T);
    fn=omega/(2*pi);
    if(fn<fmin && fn>= flow)
        fmin=fn;
        alpha_r=alpha;
        beta_r =beta;
        gamma_r=gamma;
%
        out1=sprintf('%d %8.4g Hz  alpha=%8.4g  beta=%8.4g  gamma=%8.4g ',k,fn,alpha_r,beta_r,gamma_r);
        disp(out1);
%
        Z1A_r=Z1A;
        Z2A_r=Z2A;
%
    end  
%
end
%
    qq=dx*dy*h*rho;

         ZA=Z1A_r*qq;
        ZAA=Z2A_r*qq;
%
       ZAA=sqrt(ZAA);
       
    part_r=(ZA/ZAA);  
%
setappdata(0,'ZAA',ZAA);
setappdata(0,'part',part_r);

%
sflow=sprintf('Lower bound f= %8.4g Hz \n',flow);
  sup=sprintf('Upper bound f= %8.4g Hz \n\n',fup);

sest=sprintf('Esimated fn=%8.4g Hz',fmin);

s1=sprintf('%s %s %s',sflow,sup,sest);

set(handles.edit_result,'Enable','on','String',s1,'Max',7);

setappdata(0,'fn',fmin);
setappdata(0,'alpha_r',alpha_r);
setappdata(0,'beta_r',beta_r);
setappdata(0,'gamma_r',gamma_r);


%
clear xx;
clear yy;
clear zzr;
%

fig_num=1;
figure(fig_num);  
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);

xx=zeros(np1,1);
yy=zeros(np1,1);
zzr=zeros(np1,np1);
%
for i=1:np1 
        xx(i)=((i-1)*dx-(a/2));
        cx=cos(xx(i)*pia);
%        sx=sin(xx(i)*pia);
        for j=1:np1
            yy(j)=((j-1)*dy-(b/2));
%            sy=sin(yy(j));
            cy=cos(yy(j)*pib);
            zzr(i,j)=alpha_r*cx + beta_r*cy + gamma_r*cx*cy;
        end
end

zzr=zzr/(max(max(abs(zzr))));

xxmin=min(xx);
yymin=min(yy);

xx=xx-xxmin;
yy=yy-yymin;

clear aaa;
clear abc;
abc=[max(xx) max(yy)];
aaa=max(abc);
xmin=-aaa;
ymin=-aaa;
zmin=0;
zmax=3;
xmax=aaa;
ymax=aaa;
surf(xx,yy,zzr);
% xlim([xmin xmax]) 
% ylim([ymin ymax]) 
zlim([zmin zmax]) 
xlabel('X');
ylabel('Y');

out1=sprintf('fn=%8.4g Hz',fmin);
title(out1);

set(handles.pushbutton_base_input,'Visible','on');




function clear_result(hObject, eventdata, handles)
%
set(handles.edit_result,'Enable','off','String','');
set(handles.edit_total_mass,'Enable','off','String','');


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
clear_result(hObject, eventdata, handles);

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

clear_result(hObject, eventdata, handles);

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
clear_result(hObject, eventdata, handles);



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



function edit_result_Callback(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_result as text
%        str2double(get(hObject,'String')) returns contents of edit_result as a double


% --- Executes during object creation, after setting all properties.
function edit_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_result(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_poisson and none of its controls.
function edit_poisson_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_result(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_mass_density and none of its controls.
function edit_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_result(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_nsm and none of its controls.
function edit_nsm_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nsm (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_result(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_length and none of its controls.
function edit_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_result(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_result(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_result(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_base_input.
function pushbutton_base_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_base_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=rectangular_plate_corners_base;   

set(handles.s,'Visible','on'); 


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
