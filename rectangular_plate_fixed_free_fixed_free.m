function varargout = rectangular_plate_fixed_free_fixed_free(varargin)
% RECTANGULAR_PLATE_FIXED_FREE_FIXED_FREE MATLAB code for rectangular_plate_fixed_free_fixed_free.fig
%      RECTANGULAR_PLATE_FIXED_FREE_FIXED_FREE, by itself, creates a new RECTANGULAR_PLATE_FIXED_FREE_FIXED_FREE or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_PLATE_FIXED_FREE_FIXED_FREE returns the handle to a new RECTANGULAR_PLATE_FIXED_FREE_FIXED_FREE or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_PLATE_FIXED_FREE_FIXED_FREE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_PLATE_FIXED_FREE_FIXED_FREE.M with the given input arguments.
%
%      RECTANGULAR_PLATE_FIXED_FREE_FIXED_FREE('Property','Value',...) creates a new RECTANGULAR_PLATE_FIXED_FREE_FIXED_FREE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_plate_fixed_free_fixed_free_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_plate_fixed_free_fixed_free_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_plate_fixed_free_fixed_free

% Last Modified by GUIDE v2.5 06-Sep-2014 14:19:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_plate_fixed_free_fixed_free_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_plate_fixed_free_fixed_free_OutputFcn, ...
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


% --- Executes just before rectangular_plate_fixed_free_fixed_free is made visible.
function rectangular_plate_fixed_free_fixed_free_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_plate_fixed_free_fixed_free (see VARARGIN)

% Choose default command line output for rectangular_plate_fixed_free_fixed_free
handles.output = hObject;

set(handles.listbox_unit,'Value',1);
set(handles.listbox_material,'Value',1);

set(handles.pushbutton_base_input,'Visible','off');

listbox_unit_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rectangular_plate_fixed_free_fixed_free wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rectangular_plate_fixed_free_fixed_free_OutputFcn(hObject, eventdata, handles) 
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

delete(rectangular_plate_fixed_free_fixed_free);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'rectangular_plate_fixed_free_fixed_free_base_key',0);

fmin=1.0e+90; 

n=get(handles.listbox_unit,'Value');
iu=n;

  E=str2num(get(handles.edit_elastic_modulus,'String'));
 mu=str2num(get(handles.edit_poisson,'String'));
rho=str2num(get(handles.edit_mass_density,'String'));
nsm=str2num(get(handles.edit_nsm,'String'));
  
  L_fixed=str2num(get(handles.edit_fixed_length,'String'));
  L_free=str2num(get(handles.edit_free_length,'String'));
  T=str2num(get(handles.edit_thickness,'String'));

  
if(length(L_fixed)==0)
    warndlg('Enter Fixed Length');
    return;
end
if(length(L_free)==0)
    warndlg('Enter Free Length');
    return;
end
if(length(T)==0)
    warndlg('Enter Thickness');
    return;
end
  
   
if(n==1) % English
    rho=rho/386;
    nsm=nsm/386;
else
    T=T/1000;
    [E]=GPa_to_Pa(E);
end


setappdata(0,'T',T);
setappdata(0,'L_fixed',L_fixed);
setappdata(0,'L_free',L_free);  
setappdata(0,'iu',iu);  

setappdata(0,'E',E);
setappdata(0,'rho',rho);
setappdata(0,'mu',mu);

area=L_fixed*L_free;
volume=area*T;

total_mass = (rho*volume + nsm);

rho=total_mass/volume;

if(n==1)
    total_mass=total_mass*386;
end

s1=sprintf('%8.4g',total_mass);

set(handles.edit_total_mass,'String',s1);

h=T;
a=L_fixed;
b=L_free;

clear T;

D=E*(h^3)/(12*(1-mu^2)); 

DR=D/(rho*h/2); 
out1=sprintf(' Plate Stiffness Factor = %8.4g lbf in\n',D); 
disp(out1); 
% 
num=200; 
nnn=num;
dx=b/num;   % needed switch
dy=a/num; 
pia=pi/a; 
pib=pi/b; 
% 
knum=800; 
alpha_r=0; 
theta_r=0;
%
fn1=(22.373/(2*pi))*sqrt(D/(rho*h))/b^2;
%
disp(' ');
out1=sprintf(' Expected:  fn ~ %8.4g Hz ',fn1);
disp(out1);
%
disp(' ');
disp(' Calculating natural frequency.... ');
%
L=b;
%
c1=2*mu;
c2=2*(1-mu);
%
root=4.73004;
setappdata(0,'root',root);
bL=root;
beta=root/L;
beta2=beta^2;
C=(sinh(bL)+sin(bL))/(cosh(bL)-cos(bL));  
%
for i=1:(nnn+1)
   ii=i-1;
   x(i)=ii*dx;
   y(i)=(ii*dy-(a/2));
end 
%    
disp(' ');

progressbar;

for k=1:knum
    
    progressbar(k/knum);
    
    if(k<knum/10 || rand<0.5)
        alpha=  -1.0 +2*rand;
        theta=   5*rand/a;
    else
        alpha=alpha_r*(0.98+0.04*rand);
        theta=theta_r*(0.98+0.04*rand);    
    end
    theta2=theta^2;
%
    if(k==1)
        alpha=0;
    end
%
    V=0;
    T=0;   
%    
    argx=beta*x;
    argy=theta*y;
%

    Z1A=0;
    Z2A=0;   
%
    for(i=1:nnn+1)
        cosh_arg=cosh(argx(i));
        cos_arg=cos(argx(i));
        sinh_arg=sinh(argx(i));
        sin_arg=sin(argx(i));
%        
                    P=(cosh_arg-cos_arg)-C*(sinh_arg-sin_arg);     
            dPdx=beta*((sinh_arg+sin_arg)-C*(cosh_arg-cos_arg));
         d2Pdx2=beta2*((cosh_arg+cos_arg)-C*(sinh_arg+sin_arg));
%        
        for(j=1:nnn+1)
            cos_arg=cos(argy(j));
            sin_arg=sin(argy(j));
                 W=1+alpha*cos_arg;
              dWdy=-alpha*theta*sin_arg;
            d2Wdy2=-alpha*theta2*cos_arg;            
%
            Z=P*W;
            
            Z1A=Z1A+Z;            
            Z2A=Z2A+Z^2;         
%    
            dZdx  =   dPdx*W; 
            d2Zdx2= d2Pdx2*W;     
%
            dZdy  = P*dWdy; 
            d2Zdy2= P*d2Wdy2;  
%    
            d2Zdxdy=dPdx*dWdy;
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
    if(fn<fmin)
        fmin=fn;
        alpha_r=alpha;
        theta_r =theta;
        
        Z1A_r=Z1A;
        Z2A_r=Z2A;        
        

        out1=sprintf('%d %8.4g Hz  alpha=%8.4g  theta=%8.4g %8.4g',k,fn,alpha_r,theta_r);
        disp(out1);
    end
end

setappdata(0,'fn',fmin);
setappdata(0,'alpha_r',alpha_r);
setappdata(0,'theta_r',theta_r);
setappdata(0,'beta',beta);
%
pause(0.3);
progressbar(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    qq=dx*dy*h*rho;

         ZA=Z1A_r*qq;
        ZAA=Z2A_r*qq;
%
       ZAA=sqrt(ZAA);
       
    part_r=(ZA/ZAA);  
%
setappdata(0,'ZAA',ZAA);
setappdata(0,'part',part_r);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
clear xx;
clear yy;
clear zzr;
%
fig_num=1;
figure(fig_num);
fig_num=fig_num+1;
zmax=0;
zmin=0;
%
num=40; 

dx=b/num;   % needed switch
dy=a/num; 
%
clear arg;
clear x;
clear y;
%
for i=1:(num+1)
          x=((i-1)*dx-(b/2));
          yy(i)=x;
          arg=beta*(x+b/2);
          P=(cosh(arg)-cos(arg))-C*(sinh(arg)-sin(arg)); 
%          
        for j=1:(num+1)
            y=((j-1)*dy-(a/2));
            xx(j)=y;
            arg=theta_r*y;
              W=1+alpha_r*cos(arg);
%
             zzr(i,j)=P*W;
%
            if(zzr(i,j)>zmax)
                zmax=zzr(i,j);
            end
%
            if(zzr(i,j)<zmin)
                zmin=zzr(i,j);
            end            
        end
end
%
%
zzr=zzr/(max(max(abs(zzr))));

minxx=min(xx);
minyy=min(yy);

xx=xx-min(xx);
yy=yy-min(yy);

clear aaa;
clear abc;
xymax=max([max(xx) max(yy)]);

zmin=0;
zmax=2.5;

surf(xx,yy,zzr);
% xlim([0 xymax]) 
% ylim([0 xymax]) 
zlim([zmin zmax])
xlabel('X');
ylabel('Y');
out1=sprintf('Rayleigh: fn=%8.4g Hz',fmin); 
title(out1);

%
disp(' ');
out1=sprintf(' Expected:  fn ~ %8.4g Hz   Rayleigh: fn=%8.4g Hz',fn1,fmin);
disp(out1);
%


se=sprintf('Expected: fn ~ %8.4g Hz \n\n',fn1);

sr=sprintf('Rayleigh: fn = %8.4g Hz',fmin);

s1=sprintf('%s %s',se,sr);

set(handles.edit_result,'Enable','on','String',s1,'Max',7);


set(handles.pushbutton_base_input,'Visible','on');

setappdata(0,'fig_num',fig_num);

% --- Executes on button press in pushbutton_base_input.
function pushbutton_base_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_base_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=rectangular_plate_fixed_free_fixed_free_base;   
set(handles.s,'Visible','on'); 



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



function edit_free_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_free_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_free_length as text
%        str2double(get(hObject,'String')) returns contents of edit_free_length as a double


% --- Executes during object creation, after setting all properties.
function edit_free_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_free_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fixed_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fixed_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fixed_length as text
%        str2double(get(hObject,'String')) returns contents of edit_fixed_length as a double


% --- Executes during object creation, after setting all properties.
function edit_fixed_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fixed_length (see GCBO)
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


function clear_result(hObject, eventdata, handles)
%
set(handles.edit_result,'Enable','off','String','');
set(handles.edit_total_mass,'Enable','off','String','');


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
    sL='Fixed Edge Length (in)';
    sW='Free Edge Length (in)';
    sT='Thickness (in)';
else
    sem='Elastic Modulus (GPa)';
    smd='Mass Density (kg/m^3)';
    snsm='Nonstructral Mass (kg)';
    stmass='Total Mass (kg)';
    sL='Fixed Edge Length (m)';
    sW='Free Edge Length (m)';
    sT='Thickness (mm)';    
end    
%
set(handles.text_elastic_modulus,'String',sem);
set(handles.text_mass_density,'String',smd);
set(handles.text_nsm,'String',snsm);
set(handles.text_total_mass,'String',stmass);
set(handles.text_fixed_edge_length,'String',sL);
set(handles.text_free_edge_length,'String',sW);
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


% --- Executes on key press with focus on edit_total_mass and none of its controls.
function edit_total_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_total_mass (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_result(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_fixed_length and none of its controls.
function edit_fixed_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fixed_length (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_result(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_free_length and none of its controls.
function edit_free_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_free_length (see GCBO)
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
