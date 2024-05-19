function varargout = vibrationdata_inplane_rectangular_plate_fea(varargin)
% VIBRATIONDATA_INPLANE_RECTANGULAR_PLATE_FEA MATLAB code for vibrationdata_inplane_rectangular_plate_fea.fig
%      VIBRATIONDATA_INPLANE_RECTANGULAR_PLATE_FEA, by itself, creates a new VIBRATIONDATA_INPLANE_RECTANGULAR_PLATE_FEA or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_INPLANE_RECTANGULAR_PLATE_FEA returns the handle to a new VIBRATIONDATA_INPLANE_RECTANGULAR_PLATE_FEA or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_INPLANE_RECTANGULAR_PLATE_FEA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_INPLANE_RECTANGULAR_PLATE_FEA.M with the given input arguments.
%
%      VIBRATIONDATA_INPLANE_RECTANGULAR_PLATE_FEA('Property','Value',...) creates a new VIBRATIONDATA_INPLANE_RECTANGULAR_PLATE_FEA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_inplane_rectangular_plate_fea_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_inplane_rectangular_plate_fea_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_inplane_rectangular_plate_fea

% Last Modified by GUIDE v2.5 06-Feb-2016 13:48:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_inplane_rectangular_plate_fea_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_inplane_rectangular_plate_fea_OutputFcn, ...
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


% --- Executes just before vibrationdata_inplane_rectangular_plate_fea is made visible.
function vibrationdata_inplane_rectangular_plate_fea_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_inplane_rectangular_plate_fea (see VARARGIN)

% Choose default command line output for vibrationdata_inplane_rectangular_plate_fea
handles.output = hObject;

clear_all(hObject, eventdata, handles); 

try
    fig_num=getappdata(0,'fig_num');
catch
    fig_num=0;
end

fig_num=fig_num+20;

setappdata(0,'fig_num',fig_num);

set(handles.listbox_mode,'Value',1);


point_mass_matrix=zeros(1,2);
setappdata(0,'point_mass_matrix',point_mass_matrix);
assignin('base', 'point_mass_matrix', point_mass_matrix);

ip_constraint_matrix=zeros(1,3);
setappdata(0,'ip_constraint_matrix',ip_constraint_matrix);
assignin('base', 'ip_constraint_matrix', ip_constraint_matrix);

listbox_unit_Callback(hObject, eventdata, handles);

model_key=0;
setappdata(0,'model_key',model_key);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_inplane_rectangular_plate_fea wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_inplane_rectangular_plate_fea_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function clear_all(hObject, eventdata, handles) 

set(handles.pushbutton_constraints,'Visible','off');
set(handles.pushbutton_calculate_fn,'Visible','off');
set(handles.uipanel_plot_modes,'Visible','off');

set(handles.pushbutton_damping,'Visible','off');
set(handles.pushbutton_force_th,'Visible','off');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_inplane_rectangular_plate_fea);


% --- Executes on button press in pushbutton_generate_mesh.
function pushbutton_generate_mesh_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_generate_mesh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_all_masses(hObject, eventdata, handles);

fig_num=1;

mass_method=get(handles.listbox_mass_method,'Value');
n=get(handles.listbox_unit,'Value');
iu=n;

if(mass_method<=2)
    rho=str2num(get(handles.edit_mass_density,'String'));
    
    if(iu==1) % English
        rho=rho/386;
    end    
end
if(mass_method==2)
    nsm=str2num(get(handles.edit_nsm,'String'));
    
    if(iu==1) % English
        nsm=nsm/386;
    end
end
if(mass_method==3)
    total_mass=str2num(get(handles.edit_total_mass,'String'));    
    
    if(iu==1) % English
        total_mass=total_mass/386;
    end          
end

  E=str2num(get(handles.edit_elastic_modulus,'String'));
 mu=str2num(get(handles.edit_poisson,'String'));

  
  L=str2num(get(handles.edit_length,'String'));
  W=str2num(get(handles.edit_width,'String'));
  T=str2num(get(handles.edit_thickness,'String'));

  
if(length(L)==0)
    warndlg('Enter Length');
    return;
end
if(length(W)==0)
    warndlg('Enter Width');
    return;
end
if(length(T)==0)
    warndlg('Thickness');
    return;
end

if(iu==2) % metric
    T=T/1000;
    [E]=GPa_to_Pa(E);
    L=L/1000;
    W=W/1000;
end
  
 
area=L*W;
volume=area*T;


mass_method=get(handles.listbox_mass_method,'Value');

if(mass_method<=2)
    bare_mass=rho*volume;
end

if(mass_method==1)    
    total_mass = bare_mass;
end
if(mass_method==2)
    total_mass = (bare_mass + nsm);
end
if(mass_method==3)
    total_mass = str2num(get(handles.edit_total_mass,'String'));
end

rho=total_mass/volume;

setappdata(0,'T',T);
setappdata(0,'L',L);
setappdata(0,'W',W);  
setappdata(0,'iu',iu);  
  
setappdata(0,'E',E);
setappdata(0,'rho',rho);
setappdata(0,'mu',mu);

if(n==1)
    total_mass=total_mass*386;
end


update_all_masses(hObject, eventdata, handles);


h=T;


thick=h;

clear T;


nx=str2num(get(handles.edit_nodes_length,'String'));
ny=str2num(get(handles.edit_nodes_width,'String'));

setappdata(0,'nx',nx);
setappdata(0,'ny',ny);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

number_nodes=nx*ny;

ne=(nx-1)*(ny-1);
nelem=ne;

%
dx=L/(nx-1);
dy=W/(ny-1);
%
setappdata(0,'dx',dx);
setappdata(0,'dy',dy);
%

clear volume;
volume=zeros(ne,1);

for i=1:ne    
    volume(i)=h*dx*dy;  % volume per element
end    
%
ijk=1;
%
node_matrix=zeros(nx*ny,2);
%
for j=1:ny
%    
    for i=1:nx
        node_matrix(ijk,1)=(i-1)*dx;
        node_matrix(ijk,2)=(j-1)*dy;        
        ijk=ijk+1;  
    end
%    
end

%
j=1;
k=1;

element_matrix=zeros(ne,4);

for i=1:ne
%
    element_matrix(i,1)=j; 
    element_matrix(i,2)=j+1; 
    element_matrix(i,3)=element_matrix(i,2)+nx;
    element_matrix(i,4)=element_matrix(i,1)+nx;
%
    j=j+1;
    k=k+1;
    
    if(k==nx)
        j=j+1;
        k=1;
    end
%    
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
h=figure(fig_num);
fig_num=fig_num+1;
if(iu==1)
    plot(node_matrix(:,1),node_matrix(:,2),'.');
else
    plot(1000*node_matrix(:,1),1000*node_matrix(:,2),'.');    
end
%
clear nodex;
clear nodey;
nodex=node_matrix(:,1);
nodey=node_matrix(:,2);

%
for i=1:number_nodes
   string=num2str(i,'%d\n');
   if(iu==1)
        text(nodex(i),nodey(i),string);
   else
        text(1000*nodex(i),1000*nodey(i),string);       
   end
end
%
if(iu==1)
    xlabel('X (in)');
    ylabel('Y (in)');
else
    xlabel('X (mm)');
    ylabel('Y (mm)');    
end
title('Nodes & Elements');
grid on;
%
xmax=max(nodex)+dx/2;
ymax=max(nodey)+dy/2;
%
xmin=min(nodex)-dx/2;
ymin=min(nodey)-dy/2;
%
if(iu==1)
    axis([xmin,xmax,ymin,ymax]);
else
    xxmin=xmin*1000;
    xxmax=xmax*1000;    
    yymin=ymin*1000;
    yymax=ymax*1000;       
    axis([xxmin,xxmax,yymin,yymax]);    
end    
%
node1=element_matrix(:,1);
node2=element_matrix(:,2);
node3=element_matrix(:,3);
node4=element_matrix(:,4);
%
hold on;
%
for i=1:ne
    x=[ nodex(node1(i)) nodex(node2(i)) nodex(node3(i)) nodex(node4(i)) nodex(node1(i))];
    y=[ nodey(node1(i)) nodey(node2(i)) nodey(node3(i)) nodey(node4(i)) nodey(node1(i))];

    if(iu==1)
        plot(x,y);    
    else
        xx=1000*x;
        yy=1000*y;
        plot(xx,yy);        
    end
end
hold off;
%
pname='nodes_elements.png';        
out1=sprintf('\n plot file:   %s \n',pname);
disp(out1);
    
set(gca,'Fontsize',12);
print(h,pname,'-dpng','-r300');
%
dof=number_nodes*2;
setappdata(0,'dof',dof);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Calculating uncontrained mass and stiffness matrices... ');

[mass,stiff]=vibrationdata_inplane_rectangular_plate_mass_stiff...
  (nelem,nodex,nodey,node1,node2,node3,node4,thick,dof,rho,E,mu);

%
mass_unc=mass;
stiff_unc=stiff;

setappdata(0,'nodex',nodex);
setappdata(0,'nodey',nodey);

setappdata(0,'mass_unc',mass_unc);
setappdata(0,'stiff_unc',stiff_unc);
setappdata(0,'node_matrix',node_matrix);
setappdata(0,'fig_num',fig_num);
setappdata(0,'number_nodes',number_nodes);
setappdata(0,'total_mass',total_mass);


setappdata(0,'iu',iu);

setappdata(0,'node_matrix',node_matrix);
setappdata(0,'element_matrix',element_matrix);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


set(handles.pushbutton_constraints,'Visible','on'); 
set(handles.pushbutton_calculate_fn,'Visible','on');

    
disp('* Unconstrained model statistics ');
out1=sprintf('\n  nodes=%d  elements=%d   degrees-of-freedom=%d  \n',number_nodes,nelem,dof);
disp(out1);


disp(' ');
disp(' Generation complete');
msgbox('Generation Complete');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function edit_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_width as text
%        str2double(get(hObject,'String')) returns contents of edit_width as a double
update_all_masses(hObject, eventdata, handles);

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
update_all_masses(hObject, eventdata, handles);

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
update_all_masses(hObject, eventdata, handles);

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
update_all_masses(hObject, eventdata, handles);

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
update_all_masses(hObject, eventdata, handles);

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

clear_all(hObject, eventdata, handles); 

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

listbox_mass_method_Callback(hObject, eventdata, handles);
update_all_masses(hObject, eventdata, handles);
  

function update_bare_plate(hObject, eventdata, handles)
%

iu=get(handles.listbox_unit,'Value');

try
    L=str2num(get(handles.edit_length,'String'));
    W=str2num(get(handles.edit_width,'String'));
    T=str2num(get(handles.edit_thickness,'String')); 
    rho=str2num(get(handles.edit_mass_density,'String'));     
    
    if(iu==2)
        L=L/1000;
        W=W/1000;
        T=T/1000;
    end
    
    volume=L*W*T;
    
    out1=sprintf('volume=%6.3g  rho=%6.3g',volume,rho);
%%    disp(out1);
    
    bare_mass=volume*rho;
    s2=sprintf('%6.3g',bare_mass);
    if(bare_mass>0 && bare_mass<1.0e+20)
        set(handles.edit_bare_plate_mass,'String',s2);
    else
        set(handles.edit_bare_plate_mass,'String','0');
    end
catch
    set(handles.edit_bare_plate_mass,'String','0');
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

update_all_masses(hObject, eventdata, handles);

n=get(handles.listbox_unit,'Value');

if(n==1)
    sem='Elastic Modulus (psi)';
    smd='Mass Density (lbm/in^3)';
    snsm='Nonstructural Mass (lbm)';
    sbare='Bare Plate Mass (lbm)';
    spoint='Point Masses (lbm)';    
    stmass='Total Mass (lbm)';
    sL='Length (in)';
    sW='Width (in)';
    sT='Thickness (in)';
else
    sem='Elastic Modulus (GPa)';
    smd='Mass Density (kg/m^3)';
    snsm='Nonstructural Mass (kg)';
    sbare='Bare Plate Mass (kg)';  
    spoint='Point Masses (kg)';      
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
set(handles.text_bare_plate,'String',sbare);
set(handles.text_point_mass,'String',spoint);

listbox_material_Callback(hObject, eventdata, handles);
clear_all(hObject, eventdata, handles); 

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


% --- Executes on selection change in listbox_mass_method.
function listbox_mass_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mass_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mass_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mass_method

set(handles.edit_total_mass,'String','0');

clear_all(hObject, eventdata, handles); 

n=get(handles.listbox_mass_method,'Value');

set(handles.text_mass_density,'Visible','off');
set(handles.edit_mass_density,'Visible','off');   


set(handles.edit_nsm,'Enable','off');

set(handles.edit_total_mass,'Enable','off');

if(n<=2)
    set(handles.text_mass_density,'Visible','on');
    set(handles.edit_mass_density,'Visible','on');      
end

if(n==2)
    set(handles.edit_nsm,'Enable','on');
else
    set(handles.edit_nsm,'String','0');    
end
if(n==3)
    set(handles.edit_total_mass,'Enable','on');    
end

update_all_masses(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_mass_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mass_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nodes_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nodes_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nodes_width as text
%        str2double(get(hObject,'String')) returns contents of edit_nodes_width as a double


% --- Executes during object creation, after setting all properties.
function edit_nodes_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nodes_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nodes_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nodes_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nodes_length as text
%        str2double(get(hObject,'String')) returns contents of edit_nodes_length as a double


% --- Executes during object creation, after setting all properties.
function edit_nodes_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nodes_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_constraints.
function pushbutton_constraints_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_constraints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



setappdata(0,'ic_choice',0);


set(handles.uipanel_plot_modes,'Visible','off');

handles.s=rectangular_inplane_plate_fea_constraints;
set(handles.s,'Visible','on')

set(handles.pushbutton_calculate_fn,'Visible','on');

% --- Executes on button press in pushbutton_calculate_fn.
function pushbutton_calculate_fn_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=getappdata(0,'fig_num');

mass_method=get(handles.listbox_mass_method,'Value');


try
    THM=evalin('base','point_mass_matrix');   
    point_mass_matrix=THM;
end


mass=getappdata(0,'mass_unc');
stiff=getappdata(0,'stiff_unc');
dof=getappdata(0,'dof');

iu=getappdata(0,'iu');

nodex=getappdata(0,'nodex');
nodey=getappdata(0,'nodey');
number_nodes=getappdata(0,'number_nodes');

ibc=0;

try
    THM=evalin('base','ip_constraint_matrix');   
    ip_constraint_matrix=THM;
    n=length(ip_constraint_matrix(:,1));   
    
    for i=1:n
        if(ip_constraint_matrix(i,1)>0)
            ibc=ibc+1;
        end
    end
    
end


dofx_node=zeros(number_nodes,1);
dofy_node=zeros(number_nodes,1);


for i=1:number_nodes
    dofx_node(i)=i;
    dofy_node(i)=i;
end    

for i=n:-1:1
   
    ncn=ip_constraint_matrix(i,1);
    ncx=ip_constraint_matrix(i,2);
    ncy=ip_constraint_matrix(i,3);    
    
    if(ncx==1)
        dofx_node(ncn)=[];
    end
    if(ncy==1)
        dofy_node(ncn)=[];
    end   
        
end

%% dofx_node
%% dofy_node

node_dof=zeros(number_nodes,2);

for i=1:number_nodes
    
    for j=1:length(dofx_node)
        node_dof(dofx_node(j),1)=1;
    end
    
    for j=1:length(dofy_node)
        node_dof(dofy_node(j),2)=1;        
    end  
    
end    

%% node_dof

kv=1;

for i=1:number_nodes

    if(node_dof(i,1)~=0)
        node_dof(i,1)=kv;
        kv=kv+1;
    end
    if(node_dof(i,2)~=0)
        node_dof(i,2)=kv;
        kv=kv+1;
    end    

end

setappdata(0,'node_dof',node_dof);

%% node_dof



out1=sprintf('\n number of constrained nodes = %d \n',ibc);
disp(out1);

pmt=0;

mass_unc=mass;

if(ibc>=1 && ip_constraint_matrix(1,1) ~= 0)

    [mass,stiff,pp,con]=...
        rectangular_inplane_plate_apply_constraints(ip_constraint_matrix,ibc,mass,stiff);

end

[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiff,mass,2);

setappdata(0,'stiff',stiff);
setappdata(0,'mass',mass);

iu=getappdata(0,'iu');

L=str2num(get(handles.edit_length,'String'));
W=str2num(get(handles.edit_width,'String'));
T=str2num(get(handles.edit_thickness,'String'));

if(iu==2)
   L=L/1000;
   W=W/1000;
   T=T/1000;
end

if(mass_method<=2)

    rho=str2num(get(handles.edit_mass_density,'String'));


    pmass=L*W*T*rho;

    total_mass=pmass;

    if(pmt>0)
        if(iu==1)
            total_mass=pmass+pmt*386;
        else
            total_mass=pmass+pmt;
        end
    end

else
    total_mass=str2num(get(handles.edit_total_mass,'String'));    
end

total_mass;



setappdata(0,'total_mass',total_mass);
ss=sprintf('%8.4g',total_mass);
set(handles.edit_total_mass,'String',ss);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ibc>=1 && ip_constraint_matrix(1,1) ~= 0)
    [ModeShapes]=inplane_mode_shape_correction(dof,pp,con,ModeShapes);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mode=ModeShapes;

sz=size(mass_unc);
NL=sz(1);

vx=zeros(NL,1);
vy=zeros(NL,1);

vx(1:2:NL,:)=1;
vy(2:2:NL,:)=1;
   

  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    LMx=mode'*mass_unc*vx;
    pfx=LMx;
    mmmx=mode'*mass_unc*mode;   

    clear length;
    nndd=length(pfx);
    pffx=zeros(nndd,1);
    emmx=zeros(nndd,1);
    for i=1:nndd
        pffx(i)=pfx(i)/mmmx(i,i);
        emmx(i)=pfx(i)^2/mmmx(i,i);
        if(emmx(i) < 1e-30)
            emmx(i)=0.;
            pffx(i)=0.;
        end    
%
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    LMy=mode'*mass_unc*vy;
    pfy=LMy;
    mmmy=mode'*mass_unc*mode;   
 
    clear length;
    nndd=length(pfy);
    pffy=zeros(nndd,1);
    emmy=zeros(nndd,1);
    for i=1:nndd
        pffy(i)=pfy(i)/mmmy(i,i);
        emmy(i)=pfy(i)^2/mmmy(i,i);
        if(emmy(i) < 1e-30)
            emmy(i)=0.;
            pffy(i)=0.;
        end    
%
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
%
      
%
    mmat=get(handles.listbox_material,'Value');
    if(mmat==1)
       out1='Material: aluminum';
    end
    if(mmat==2)
       out1='Material: steel';
    end
    if(mmat==3)
       out1='Material: copper';
    end
    if(mmat==4)
       out1='Material: G10';
    end
    if(mmat==5)
       out1='Material: other';
    end    
    disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~]=inplane_print_table(iu,total_mass,emmx,emmy,fn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
   

setappdata(0,'mass_unc',mass_unc);
setappdata(0,'fn',fn);

setappdata(0,'ModeShapes',ModeShapes);
setappdata(0,'ibc',ibc);
setappdata(0,'pffx',pffx);
setappdata(0,'pffy',pffy);
setappdata(0,'emmx',emmx);
setappdata(0,'emmy',emmy);

set(handles.uipanel_plot_modes,'Visible','on');


set(handles.pushbutton_damping,'Visible','on');
update_all_masses(hObject, eventdata, handles);

msgbox('fn Calculation Complete');

% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
 
fig_num=getappdata(0,'fig_num');
fig_num=fig_num+20;
 
iu=getappdata(0,'iu');
dof=getappdata(0,'dof');
 
nodex=getappdata(0,'nodex');
nodey=getappdata(0,'nodey');
number_nodes=getappdata(0,'number_nodes');
 
fn=getappdata(0,'fn');
ModeShapes=getappdata(0,'ModeShapes');
    
k=get(handles.listbox_mode,'Value');
 
element_matrix=getappdata(0,'element_matrix');
 
L=getappdata(0,'L');
W=getappdata(0,'W');
 
[fig_num]=...
vibrationdata_inplane_rectangular_elements_plot_modes(element_matrix,...
                    nodex,nodey,fig_num,ModeShapes,fn,k,iu,L,W); 
 
 
setappdata(0,'fig_num',fig_num);
 
function edit_mode_number_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mode_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of edit_mode_number as text
%        str2double(get(hObject,'String')) returns contents of edit_mode_number as a double
 

% --- Executes during object creation, after setting all properties.
function edit_mode_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mode_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
% --- Executes on selection change in listbox_mode.
function listbox_mode_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mode
 
 
% --- Executes during object creation, after setting all properties.
function listbox_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
% --- Executes on button press in pushbutton_point_mass.
function pushbutton_point_mass_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
setappdata(0,'ichoice',0);
 
% handles.s=rectangular_plate_fea_point_mass;
% set(handles.s,'Visible','on')
 
h=rectangular_plate_fea_point_mass;
 
waitfor(h);
 
update_all_masses(hObject, eventdata, handles)
 
function update_all_masses(hObject, eventdata, handles)
%
update_bare_plate(hObject, eventdata, handles);
update_point_mass(hObject, eventdata, handles);
update_total_mass(hObject, eventdata, handles);
 
function update_total_mass(hObject, eventdata, handles)
%
 
n=get(handles.listbox_mass_method,'Value');
 
 
if(n==3)
    return;
end
 
try
  nsm=str2num(get(handles.edit_nsm,'String'));
catch
  nsm=0;
end
 
try
  bare_mass=str2num(get(handles.edit_bare_plate_mass,'String'));
catch
  bare_mass=0;
end
 
try
  point_mass=str2num(get(handles.edit_point_mass,'String'));
catch
  point_mass=0;
end
 
 
tm=nsm+bare_mass+point_mass;
 
ss=sprintf('%6.3g',tm);
set(handles.edit_total_mass,'String',ss);
 
 
function update_point_mass(hObject, eventdata, handles)
%
%% disp(' update point mass');
%
try
    point_mass_matrix=evalin('base','point_mass_matrix');   
    pmt=sum(point_mass_matrix(:,2));
    ss=sprintf('%6.3g',pmt);
catch
%%    disp(' update point mass failed');
     ss='0';
end
 
 
set(handles.edit_point_mass,'String',ss); 
 
% --- Executes on button press in pushbutton_damping.
function pushbutton_damping_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
handles.s=plate_fea_damping;     
set(handles.s,'Visible','on'); 

set(handles.pushbutton_force_th,'Visible','on'); 
 
 
 % --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 

% --- Executes on key press with focus on edit_poisson and none of its controls.
function edit_poisson_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 


% --- Executes on key press with focus on edit_mass_density and none of its controls.
function edit_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 
update_all_masses(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_nsm and none of its controls.
function edit_nsm_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nsm (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 
update_all_masses(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_total_mass and none of its controls.
function edit_total_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_total_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 


% --- Executes on key press with focus on edit_length and none of its controls.
function edit_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 
update_all_masses(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
 
clear_all(hObject, eventdata, handles); 
update_all_masses(hObject, eventdata, handles);

 

% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 
update_all_masses(hObject, eventdata, handles);
 
% --- Executes on key press with focus on edit_nodes_length and none of its controls.
function edit_nodes_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nodes_length (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 
 
 
% --- Executes on key press with focus on edit_nodes_width and none of its controls.
function edit_nodes_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nodes_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 
 
 
% --- Executes on button press in pushbutton_plate_fea_transmissibility.
function pushbutton_plate_fea_transmissibility_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plate_fea_transmissibility (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
handles.s=plate_fea_transmissibility;     
set(handles.s,'Visible','on'); 



% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
reset_all(hObject, eventdata, handles);
 
rho=0;
nsm=0;
total_mass=0;
 
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


set(handles.edit_model_name,'String',filename);
 
 
structnames
 
value=evalin('base',structnames{1});   
 
sz=size(value);
 
 
disp(' ');
disp(' Wait for completion message... ');
 

for i=1:sz(1)
 
    
    if( strfind(value{i,1},'dx')>=1)
        dx=str2num(value{i,2});
        setappdata(0,'dx',dx);
    end
    if( strfind(value{i,1},'dy')>=1)
        dy=str2num(value{i,2});
        setappdata(0,'dy',dy);       
    end
 
        
    if( strfind(value{i,1},'iu')>=1)
        iu=str2num(value{i,2});
        set(handles.listbox_unit,'Value',iu);
        listbox_unit_Callback(hObject, eventdata, handles);        
    end
    if( strfind(value{i,1},'material')>=1)
        m=str2num(value{i,2});
        set(handles.listbox_material,'Value',m);
    end
    if( strfind(value{i,1},'mass_method')>=1)
        m=str2num(value{i,2});
        set(handles.listbox_mass_method,'Value',m);
        listbox_mass_method_Callback(hObject, eventdata, handles);
        mass_method=m;
    end    
%    
%
    if( strfind(value{i,1},'nx')>=1)
        nx=str2num(value{i,2});
        ss=sprintf('%d',nx);
        set(handles.edit_nodes_length,'String',ss);
        setappdata(0,'nx',nx);         
    end        
    if( strfind(value{i,1},'ny')>=1)
        ny=str2num(value{i,2});
        ss=sprintf('%d',ny);
        set(handles.edit_nodes_width,'String',value{i,2});
        setappdata(0,'ny',ny);  
    end     
%    
    if( strfind(value{i,1},'T')>=1)
        set(handles.edit_thickness,'String',value{i,2});
        T=str2num(value{i,2});
    end       
    if( strfind(value{i,1},'L')>=1)
        set(handles.edit_length,'String',value{i,2});  
        L=str2num(value{i,2});        
    end     
    if( strfind(value{i,1},'W')>=1)
        set(handles.edit_width,'String',value{i,2});
        W=str2num(value{i,2});        
    end         
%
    if( strfind(value{i,1},'E')>=1)
        set(handles.edit_elastic_modulus,'String',value{i,2});
        E=str2num(value{i,2});
    end       
    if( strfind(value{i,1},'rho')>=1)
        set(handles.edit_mass_density,'String',value{i,2});
        rho=str2num(value{i,2});   
    end     
    if( strfind(value{i,1},'mu')>=1)
        set(handles.edit_poisson,'String',value{i,2});   
        mu=str2num(value{i,2});         
    end    
 %   
    if( strfind(value{i,1},'nsm')>=1)
        ss=sprintf('%6.3g',str2num(value{i,2}));
 %%       disp('**');
 %%       ss
        set(handles.edit_nsm,'String',ss);
        setappdata(0,'nsm',str2num(value{i,2})); 
        nsm=str2num(value{i,2}); 
    end   
    if( strfind(value{i,1},'total_mass')>=1)
        set(handles.edit_total_mass,'String',value{i,2});
        setappdata(0,'total_mass',str2num(value{i,2})); 
        total_mass=str2num(value{i,2});         
    end  
    
      
end 
  
dof=nx*ny;

%%%%%%%%%%%%%
 
try
    nodex=evalin('base',structnames{2});
    nodex=str2num(nodex);
    setappdata(0,'nodex',nodex);
catch
    nodex=[];
end
 
 
try
    nodey=evalin('base',structnames{3});
    nodey=str2num(nodey);
    setappdata(0,'nodex',nodey);
catch
    nodey=[];
end
 
 
try
    mass_unc=evalin('base',structnames{4});
    setappdata(0,'mass_unc',mass_unc);
catch
    mass_unc=[];
end
 
try
    stiff_unc=evalin('base',structnames{5});
    setappdata(0,'stiff_unc',stiff_unc);
catch
    stiff_unc=[];
end
 
try
    node_matrix=evalin('base',structnames{6});
    setappdata(0,'node_matrix',node_matrix);
catch
    node_matrix=[];
end
 
nodex=node_matrix(:,1);
nodey=node_matrix(:,2);
 
setappdata(0,'nodex',nodex);
setappdata(0,'nodey',nodey);
 
 
try
    element_matrix=evalin('base',structnames{7});
    setappdata(0,'element_matrix',element_matrix);
catch
    element_matrix=[];
end
 
try
    ip_constraint_matrix=evalin('base',structnames{8});
    setappdata(0,'ip_constraint_matrix',ip_constraint_matrix);
    assignin('base', 'ip_constraint_matrix', ip_constraint_matrix);
catch
    ip_constraint_matrix=[];
end
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
try
    mass=evalin('base',structnames{9});
    setappdata(0,'mass',mass);
catch
    mass=[];
end
 
try
    stiff=evalin('base',structnames{10});
    setappdata(0,'stiff',stiff);
catch
    stiff=[];
end
 
try
    fn=evalin('base',structnames{11});
    setappdata(0,'fn',fn);
catch
    fn=[];
end

try
    emmx=evalin('base',structnames{12});
    setappdata(0,'emmx',emmx);
catch
    emmx=[];
end


try
    emmy=evalin('base',structnames{13});
    setappdata(0,'emmy',emmy);
catch
    emmy=[];
end

try
    ModeShapes=evalin('base',structnames{14});
    setappdata(0,'ModeShapes',ModeShapes);
catch
    ModeShapes=[];
end
 
try
    ibc=evalin('base',structnames{15});
    setappdata(0,'ibc',ibc);
catch
    ibc=0;
end
 
try
    damp_Q=evalin('base',structnames{16});
    setappdata(0,'damp_Q',damp_Q);
catch
    damp_Q=[];
end
 
try
    damp_ratio=evalin('base',structnames{17});
    setappdata(0,'damp_ratio',damp_ratio);
catch
    damp_ratio=[];
end

try
    total_mass=evalin('base',structnames{18});
    setappdata(0,'total_mass',total_mass);
catch
    total_mass=0;
end
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
setappdata(0,'T',T);
setappdata(0,'L',L);
setappdata(0,'W',W);  
setappdata(0,'iu',iu);  
  
setappdata(0,'E',E);
setappdata(0,'rho',rho);
setappdata(0,'mu',mu);

s1=sprintf('%8.4g',rho);
set(handles.edit_mass_density,'String',s1);
 
s1=sprintf('%8.4g',nsm);
set(handles.edit_nsm,'String',s1);
 
s1=sprintf('%8.4g',total_mass);
set(handles.edit_total_mass,'String',s1);
 
update_bare_plate(hObject, eventdata, handles);
update_point_mass(hObject, eventdata, handles);
update_total_mass(hObject, eventdata, handles);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    fig_num=getappdata(0,'fig_num');
catch
    fig_num=1;
end
 
if(length(nx)>0 && length(ny)>0 && min(size(mass_unc))>0 && max(size(stiff_unc))>0)
 
    h=figure(fig_num);
    fig_num=fig_num+1;
    
    if(iu==1)
        plot(node_matrix(:,1),node_matrix(:,2),'.');
    else
        plot(1000*node_matrix(:,1),1000*node_matrix(:,2),'.');    
    end
    
 
%
    number_nodes=length(nodex);
    setappdata(0,'number_nodes',number_nodes);
    
    for i=1:number_nodes
        string=num2str(i,'%d\n');
        if(iu==1)
            text(nodex(i),nodey(i),string);
        else
            text(1000*nodex(i),1000*nodey(i),string);       
        end
    end
 
%
    if(iu==1)
        xlabel('X (in)');
        ylabel('Y (in)');
    else
        xlabel('X (mm)');
        ylabel('Y (mm)');    
    end
    title('Nodes & Elements');
    grid on;
%
    xmax=max(nodex)+dx/2;
    ymax=max(nodey)+dy/2;
%
    xmin=min(nodex)-dx/2;
    ymin=min(nodey)-dy/2;
%
    if(iu==1)
        axis([xmin,xmax,ymin,ymax]);
    else
        xxmin=xmin*1000;
        xxmax=xmax*1000;    
        yymin=ymin*1000;
        yymax=ymax*1000;       
        axis([xxmin,xxmax,yymin,yymax]);    
    end
 
%
    node1=element_matrix(:,1);
    node2=element_matrix(:,2);
    node3=element_matrix(:,3);
    node4=element_matrix(:,4);
%
    hold on;
%
    ne=length(node1);
    nelem=ne;
%
    for i=1:ne
        x=[ nodex(node1(i)) nodex(node2(i)) nodex(node3(i)) nodex(node4(i)) nodex(node1(i))];
        y=[ nodey(node1(i)) nodey(node2(i)) nodey(node3(i)) nodey(node4(i)) nodey(node1(i))];
 
        if(iu==1)
            plot(x,y);    
        else
            xx=1000*x;
            yy=1000*y;
            plot(xx,yy);        
        end
    end
    hold off;
 
%
    pname='nodes_elements.png';        
    out1=sprintf('\n plot file:   %s \n',pname);
    disp(out1);
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
    ip_constraint_matrix=getappdata(0,'ip_constraint_matrix');
        
    iu=getappdata(0,'iu');
 
    sz=size(ip_constraint_matrix);
 
    N=sz(1);
 
    node_matrix=getappdata(0,'node_matrix');
 
    sz=size(node_matrix);
 
    if(max(sz)<=0)
        warndlg('node_matrix does not exist');
        return;
    end
 
 
    
    dx=getappdata(0,'dx');
    dy=getappdata(0,'dy');
 
    
    h=figure(fig_num);
    fig_num=fig_num+1;
    setappdata(0,'fig_num',fig_num)    
 
    if(iu==1)
        plot(node_matrix(:,1),node_matrix(:,2),'.');
    else
        plot(1000*node_matrix(:,1),1000*node_matrix(:,2),'.');    
    end
 
    title('Constraints (Ux,Uy)  0=free 1=constrained');
%
    clear nodex;
    clear nodey;
    nodex=node_matrix(:,1);
    nodey=node_matrix(:,2);
%
 
%
    for i=1:N
        if(ip_constraint_matrix(i,1)>0) 
       
%%        string=sprintf('%d',ip_constraint_matrix(i,1));
  
            string='';
 
            if(ip_constraint_matrix(i,2)==1)        
                string=strcat(string,'1');
            else
                string=strcat(string,'0');            
            end
            if(ip_constraint_matrix(i,3)==1)
                string=strcat(string,'1');
            else
                string=strcat(string,'0');                        
            end
  
        
            p=ip_constraint_matrix(i,1);
        
            if(iu==1)
                text(nodex(p),nodey(p),string);
            else
                text(1000*nodex(p),1000*nodey(p),string);            
            end
        end     
    end
    if(iu==1)
        xlabel('X (in)');
        ylabel('Y (in)');
    else
        xlabel('X (mm)');
        ylabel('Y (mm)');    
    end
    grid on;
 
%
    xmax=max(nodex)+dx/2;
    ymax=max(nodey)+dy/2;
%
    xmin=min(nodex)-dx/2;
    ymin=min(nodey)-dy/2;
%
 
    if(iu==1)
        axis([xmin,xmax,ymin,ymax]);
    else
        xxmin=1000*xmin;
        xxmax=1000*xmax;
        yymin=1000*ymin;
        yymax=1000*ymax;    
        axis([xxmin,xxmax,yymin,yymax]);    
    end
    
    pname='constraints.png';        
    out1=sprintf('plot file:   %s',pname);
    disp(out1);
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    dof=number_nodes*2;
    setappdata(0,'dof',dof);
%
    disp(' Unconstrained model statistics ');
    out1=sprintf('\n  nodes=%d  elements=%d   degrees-of-freedom=%d  \n',number_nodes,nelem,dof);
    disp(out1);
    
   
    set(handles.pushbutton_constraints,'Visible','on');
    set(handles.pushbutton_calculate_fn,'Visible','on');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
end

if(length(fn)>1)
    [~]=inplane_print_table(iu,total_mass,emmx,emmy,fn);
end
 
if(length(damp_Q)>=1 && length(damp_ratio)>=1)
        disp(' ');
        disp('Mode    fn     Q     Damping');
        disp('       (Hz)          Ratio');
 
        for i=1:length(damp_Q)
            out1=sprintf('%d  %8.4g  %6.3g  %6.3g',i,fn(i),damp_Q(i),damp_ratio(i));
            disp(out1);
        end
 
        setappdata(0,'damp_Q',damp_Q);
        setappdata(0,'damp_ratio',damp_ratio);       
end
 
    set(handles.pushbutton_damping,'Visible','on');
    
    set(handles.uipanel_plot_modes,'Visible','on');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
model_key=1;
setappdata(0,'model_key',model_key);
 
disp(' ');
disp('Load complete');
msgbox('Load Complete');
 
% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
k=1;
 
 
try  
    iu=get(handles.listbox_unit,'Value');
    iu_s=sprintf('%d',iu);
    str_array{k, 1} = 'iu';
    str_array{k, 2} = iu_s;
    k=k+1;
end
 
try
    n=get(handles.listbox_material,'Value');
    n_s=sprintf('%d',n);
    str_array{k, 1} = 'material';
    str_array{k, 2} = n_s;
    k=k+1;
end
 
 
try
    nx=str2num(get(handles.edit_nodes_length,'String'));
    nx_s=sprintf('%d',nx);
    str_array{k, 1} = 'nx';
    str_array{k, 2} = nx_s;
    k=k+1;
end
    
try
    ny=str2num(get(handles.edit_nodes_width,'String'));       
    ny_s=sprintf('%d',ny); 
    str_array{k, 1} = 'ny';
    str_array{k, 2} = ny_s;
    k=k+1;
end
 
 
try
    T=str2num(get(handles.edit_thickness,'String'));
    T_s=sprintf('%g',T);
    str_array{k, 1} = 'T';
    str_array{k, 2} = T_s;
    k=k+1;
end
 
try
    L=str2num(get(handles.edit_length,'String'));
    L_s=sprintf('%g',L);
    str_array{k, 1} = 'L';
    str_array{k, 2} = L_s;
    k=k+1;
end
 
try
    W=str2num(get(handles.edit_width,'String')); 
    W_s=sprintf('%g',W);
    str_array{k, 1} = 'W';
    str_array{k, 2} = W_s;
    k=k+1;    
end
 
try
    E=str2num(get(handles.edit_elastic_modulus,'String')); 
    E_s=sprintf('%g',E);
    str_array{k, 1} = 'E';
    str_array{k, 2} = E_s;
    k=k+1;    
end
 
try
    rho=str2num(get(handles.edit_mass_density,'String')); 
    rho_s=sprintf('%g',rho);
    str_array{k, 1} = 'rho';
    str_array{k, 2} = rho_s;
    k=k+1;    
end
 
 
try
    mu=str2num(get(handles.edit_poisson,'String')); 
    mu_s=sprintf('%g',mu);
    str_array{k, 1} = 'mu';
    str_array{k, 2} = mu_s;
    k=k+1;
end
 
try
    nm=get(handles.listbox_mass_method,'Value');
    nm_s=sprintf('%d',nm);
    str_array{k, 1} = 'mass_method';
    str_array{k, 2} = nm_s;
    k=k+1;
end
 
try
    nsm=str2num(get(handles.edit_nsm,'String'));
    nsm_s=sprintf('%g',nsm);
    str_array{k, 1} = 'nsm';
    str_array{k, 2} = nsm_s;
    k=k+1;
end
 
try
    total_mass=str2num(get(handles.edit_total_mass,'String'));
    total_mass_s=sprintf('%g',total_mass);
    str_array{k, 1} = 'total_mass';
    str_array{k, 2} = total_mass_s;
    k=k+1;
end
 
%%%
 
 
try
    dx=getappdata(0,'dx');
    dx_s=sprintf('%g',dx);
    str_array{k, 1} = 'dx';
    str_array{k, 2} = dx_s;
    k=k+1;
end
try
    dy=getappdata(0,'dy');
    dy_s=sprintf('%g',dy);
    str_array{k, 1} = 'dy';
    str_array{k, 2} = dy_s;
    k=k+1;
end
try
    dof=getappdata(0,'dof');
    dof_s=sprintf('%d',dof);
    str_array{k, 1} = 'dof';
    str_array{k, 2} = dof_s;
    k=k+1;
end
try
    number_nodes=getappdata(0,'number_nodes');
    number_nodes_s=sprintf('%d',number_nodes);
    str_array{k, 1} = 'number_nodes';
    str_array{k, 2} = number_nodes_s;
    k=k+1;
end
 
try
    nodex=getappdata(0,'nodex');
catch
    nodex=[];
end  
try
    nodey=getappdata(0,'nodey');
catch  
    nodey=[];    
end  
 
try
    mass_unc=getappdata(0,'mass_unc');
catch
    mass_unc=[];
end  
try
    stiff_unc=getappdata(0,'stiff_unc');
catch  
    stiff_unc=[];    
end

%%

try
    mass=getappdata(0,'mass');
catch
    mass=[];
end  
try
    stiff=getappdata(0,'stiff');
catch  
    stiff=[];    
end

%%

try
    node_matrix=getappdata(0,'node_matrix');
catch  
    node_matrix=[];    
end
try
    element_matrix=getappdata(0,'element_matrix');
catch  
    element_matrix=[];    
end
 
%%%
 
try
    ip_constraint_matrix=evalin('base','ip_constraint_matrix');           
catch
    ip_constraint_matrix=[];
end
 
%%%
 
 
try
    fn=getappdata(0,'fn');           
catch
    fn=[];
end
 
try
    emmx=getappdata(0,'emmx');           
catch
    emmx=[];
end
try
    emmy=getappdata(0,'emmx');           
catch
    emmy=[];
end

 
try
    ModeShapes=getappdata(0,'ModeShapes');    
catch
    ModeShapes=[];
end
 
try
    ibc=getappdata(0,'ibc');           
catch
    ibc=[];
end
 
 
try
    damp_Q=getappdata(0,'damp_Q');            
catch
    damp_Q=[];
end
 
 
try
    damp_ratio=getappdata(0,'damp_ratio');            
catch
    damp_ratio=[];
end
 
%%%
 
try
    total_mass=getappdata(0,'total_mass');            
catch
    total_mass=[];
end
 
%%%
 
    [writefname, writepname] = uiputfile('*.mat','Save data as');
    writepfname = fullfile(writepname, writefname);
    
    
    pattern = '.mat';
    replacement = '';
    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
   
    
    ss=sprintf('%s',sname);
    out1=sprintf('%s=str_array;',ss);
    eval(out1);
 
    
    ss_nx=sprintf('%s_nx',sname);
    out1=sprintf('%s_nx=nodex;',ss);
    eval(out1);
    
    ss_ny=sprintf('%s_ny',sname);    
    out1=sprintf('%s_ny=nodey;',ss);
    eval(out1);
    
    ss_mass_unc=sprintf('%s_mass_unc',sname);    
    out1=sprintf('%s_mass_unc=mass_unc;',ss);
    eval(out1);
    
    ss_stiff_unc=sprintf('%s_stiff_unc',sname);    
    out1=sprintf('%s_stiff_unc=stiff_unc;',ss);
    eval(out1);
    
    
    ss_node_matrix=sprintf('%s_node_matrix',sname);    
    out1=sprintf('%s_node_matrix=node_matrix;',ss);
    eval(out1);   
    
    ss_element_matrix=sprintf('%s_element_matrix',sname);    
    out1=sprintf('%s_element_matrix=element_matrix;',ss);
    eval(out1);   
   
    
    ss_ip_constraint_matrix=sprintf('%s_ip_constraint_matrix',sname);    
    out1=sprintf('%s_ip_constraint_matrix=ip_constraint_matrix;',ss);
    eval(out1); 
    
    ss_mass=sprintf('%s_mass',sname);    
    out1=sprintf('%s_mass=mass;',ss);
    eval(out1);  
 
    ss_stiff=sprintf('%s_stiff',sname);    
    out1=sprintf('%s_stiff=stiff;',ss);
    eval(out1);  
 
    ss_fn=sprintf('%s_fn',sname);    
    out1=sprintf('%s_fn=fn;',ss);
    eval(out1);  
    
  
    ss_emmx=sprintf('%s_emmx',sname);    
    out1=sprintf('%s_emmx=emmx;',ss);
    eval(out1);  
    
    ss_emmy=sprintf('%s_emmy',sname);    
    out1=sprintf('%s_emmy=emmy;',ss);
    eval(out1);     
        
    
 
    ss_ModeShapes=sprintf('%s_ModeShapes',sname);    
    out1=sprintf('%s_ModeShapes=ModeShapes;',ss);
    eval(out1);  
 
    ss_ibc=sprintf('%s_ibc',sname);    
    out1=sprintf('%s_ibc=ibc;',ss);
    eval(out1);      
    
 
    ss_damp_Q=sprintf('%s_damp_Q',sname);    
    out1=sprintf('%s_damp_Q=damp_Q;',ss);
    eval(out1);     
    
    ss_damp_ratio=sprintf('%s_damp_ratio',sname);    
    out1=sprintf('%s_damp_ratio=damp_ratio;',ss);
    eval(out1);        
        
 
    ss_total_mass=sprintf('%s_total_mass',sname);    
    out1=sprintf('%s_total_mass=total_mass;',ss);
    eval(out1);   
    
%%%
 
    save(elk,ss,ss_nx,ss_ny,ss_mass_unc,ss_stiff_unc,ss_node_matrix,...
         ss_element_matrix,ss_ip_constraint_matrix,...
         ss_mass,ss_stiff,ss_fn,ss_emmx,ss_emmy,ss_ModeShapes,ss_ibc,...
         ss_damp_Q,ss_damp_ratio,ss_total_mass);
    
    
 
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
 
 
 
function reset_all(hObject, eventdata, handles) 
 
set(handles.edit_length,'String','');
set(handles.edit_width,'String','');
set(handles.edit_thickness,'String','');
 
 
% set(handles.listbox_material,'Value',1);
listbox_material_Callback(hObject, eventdata, handles);
 
set(handles.listbox_mass_method,'Value',1);
listbox_mass_method_Callback(hObject, eventdata, handles);
 
 
setappdata(0,'dx','');
setappdata(0,'dy','');
setappdata(0,'dof','');
setappdata(0,'number_nodes','');
setappdata(0,'nodex','');
setappdata(0,'nodey','');
setappdata(0,'mass_unc','');
setappdata(0,'stiff_unc','');
setappdata(0,'node_matrix','');
setappdata(0,'element_matrix','');
setappdata(0,'fn',''); 
setappdata(0,'ModeShapes','');  
setappdata(0,'ibc','');  
setappdata(0,'pff','');   
setappdata(0,'emm','');
 
setappdata(0,'damp_Q','');
setappdata(0,'damp_ratio','');  
 
setappdata(0,'nem','');
setappdata(0,'TT','');
setappdata(0,'T1','');
setappdata(0,'T2','');
 
setappdata(0,'Mwd','');
setappdata(0,'Mww','');
setappdata(0,'Kwd','');
setappdata(0,'Kww','');
 
 
setappdata(0,'TZ_tracking_array',''); 
 
setappdata(0,'tracking_array',''); 
setappdata(0,'free_dof_array',''); 
 
setappdata(0,'part_fn','');
setappdata(0,'part_omega','');
setappdata(0,'part_ModeShapes','');
setappdata(0,'ngw','');
 
setappdata(0,'ip_constraint_matrix_added','');
 
 
assignin('base', 'ip_constraint_matrix','');
assignin('base', 'point_mass_matrix','');
assignin('base', 'ematrix','');
assignin('base', 'mass','');
assignin('base', 'stiff','');
 
set(handles.edit_model_name,'String','');
 
 
set(handles.edit_bare_plate_mass,'String','0');
set(handles.edit_nsm,'String','0');
set(handles.edit_point_mass,'String','0');
set(handles.edit_total_mass,'String','0');
 
 
 
 
 
% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
 
reset_all(hObject, eventdata, handles);
 
msgbox('Reset Complete');
 
 
 
function edit_model_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_model_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of edit_model_name as text
%        str2double(get(hObject,'String')) returns contents of edit_model_name as a double
 
 
% --- Executes during object creation, after setting all properties.
function edit_model_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_model_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
 
function edit_bare_plate_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bare_plate_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of edit_bare_plate_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_bare_plate_mass as a double
 
 
% --- Executes during object creation, after setting all properties.
function edit_bare_plate_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bare_plate_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
 
function edit_point_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of edit_point_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_point_mass as a double
 
 
% --- Executes during object creation, after setting all properties.
function edit_point_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
 
function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double
 
 
% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
% --- Executes on button press in pushbutton_mdof_srs.
function pushbutton_mdof_srs_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mdof_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
handles.s=plate_mdof_srs;     
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_force_th.
function pushbutton_force_th_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_force_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=inplane_plate_force_time_history;     
set(handles.s,'Visible','on');
