function varargout = displacement_beam_column_sir_6dof(varargin)
% DISPLACEMENT_BEAM_COLUMN_SIR_6DOF MATLAB code for displacement_beam_column_sir_6dof.fig
%      DISPLACEMENT_BEAM_COLUMN_SIR_6DOF, by itself, creates a new DISPLACEMENT_BEAM_COLUMN_SIR_6DOF or raises the existing
%      singleton*.
%
%      H = DISPLACEMENT_BEAM_COLUMN_SIR_6DOF returns the handle to a new DISPLACEMENT_BEAM_COLUMN_SIR_6DOF or the handle to
%      the existing singleton*.
%
%      DISPLACEMENT_BEAM_COLUMN_SIR_6DOF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPLACEMENT_BEAM_COLUMN_SIR_6DOF.M with the given input arguments.
%
%      DISPLACEMENT_BEAM_COLUMN_SIR_6DOF('Property','Value',...) creates a new DISPLACEMENT_BEAM_COLUMN_SIR_6DOF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before displacement_beam_column_sir_6dof_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to displacement_beam_column_sir_6dof_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help displacement_beam_column_sir_6dof

% Last Modified by GUIDE v2.5 23-Aug-2017 11:08:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @displacement_beam_column_sir_6dof_OpeningFcn, ...
                   'gui_OutputFcn',  @displacement_beam_column_sir_6dof_OutputFcn, ...
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


% --- Executes just before displacement_beam_column_sir_6dof is made visible.
function displacement_beam_column_sir_6dof_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to displacement_beam_column_sir_6dof (see VARARGIN)

% Choose default command line output for displacement_beam_column_sir_6dof
handles.output = hObject;

iu=getappdata(0,'iu');

if(iu==1)
    ss='where  F=force (lbf)  &  M=moment (in-lbf)';
else
    ss='where  F=force (N)  &  M=moment (N-m)';
end

set(handles.text_force_unit,'String',ss);

%%%

xx=getappdata(0,'xx');
num=length(xx);
sn=sprintf('%d',num);
set(handles.edit_nodes,'String',sn);
sn=sprintf('%d',6*num);
set(handles.edit_dof,'String',sn);

 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes displacement_beam_column_sir_6dof wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = displacement_beam_column_sir_6dof_OutputFcn(hObject, eventdata, handles) 
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

delete(displacement_beam_column_sir_6dof);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * * * ');
disp('  ');

iu=getappdata(0,'iu');
stiff=getappdata(0,'stiff');
mass=getappdata(0,'mass');
ModeShapes=getappdata(0,'ModeShapes');
xx=getappdata(0,'xx');

J=getappdata(0,'J');
Iyy=getappdata(0,'Iyy');
Izz=getappdata(0,'Izz');
E=getappdata(0,'elastic_modulus');
area=getappdata(0,'area');

EIz=E*Izz;
EIy=E*Iyy;


rbm=ModeShapes(:,1:6);


try
    FS=get(handles.edit_loads_array,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found.');
    return;
end

force_array=THM;


num_nodes=length(xx);

szf=size(force_array);

if(szf(2)~=6)
    warndlg('Input array must have six columns');
    return;
end

anum=szf(1)*szf(2);

force=zeros(anum,1);

ijk=1;
for i=1:6:anum
    force(i)=force_array(ijk,1);
    force(i+1)=force_array(ijk,2);    
    force(i+2)=force_array(ijk,3);
    force(i+3)=force_array(ijk,4);
    force(i+4)=force_array(ijk,5);    
    force(i+5)=force_array(ijk,6);    
    ijk=ijk+1;
end

%%% for i=1:anum
%%%   out1=sprintf('  %d  %8.4g  ',i,force(i));
%%%   disp(out1); 
%%% end


%%%

cdof=[1 2 3 4 5 6];

    num_cdof=length(cdof);
    
    kee=stiff;
    
    for i=1:num_cdof
        
        j=cdof(i);
        
        kee(j,:)=0;
        kee(:,j)=0;
        
    end
    
%%    disp(' ');
%%    disp(' Inertia Relief Matrix');


    szm=size(mass);
    
    nq=szm(1);
    
    id=eye(nq);
    
    R=id-mass*rbm*rbm';
    
    Gc=pinv(kee);
    
    
%%    disp(' ');
%%    disp(' Constrained Flexibility Matrix ');    
        
%%    Gc
    
%%    disp(' System Flexibility for Elastic Modes ');

    Ge=R'*Gc*R;
        
    try
        ddd=Ge*force;
    catch
        
        disp(' size Ge ');
        size(Ge)
        disp(' size force ');
        size(force)        
        
        warndlg(' Multiplication error:  ddd=Ge*force ');
        return; 
    end

np=length(xx);

dx=zeros(np,7);

dx(:,1)=xx;

ijk=1;

for i=1:np
    
    dx(i,2:7)=[ ddd(ijk) ddd(ijk+1) ddd(ijk+2) ddd(ijk+3) ddd(ijk+4) ddd(ijk+5)];
    
    ijk=ijk+6;
    
end

disp(' ');
disp(' Displacements ');
disp(' ');
    disp('     x       TX      TY      TZ     RX       RY      RZ');

if(iu==1)
    disp('    (in)     (in)    (in)   (in)   (rad)    (rad)    (rad) ');     
else
    disp('    (m)       (m)     (m)    (m)   (rad)    (rad)    (rad) ');        
end


for i=1:np
   
    out1=sprintf(' %8.4f \t %8.4f \t %8.4f \t %8.4f ',dx(i,1),dx(i,2),dx(i,3),dx(i,4),dx(i,5),dx(i,6),dx(i,7));
    disp(out1);
    
end    

m1=max(dx(:,2));
m2=max(dx(:,3));
m3=max(dx(:,4));
m4=max(dx(:,5));
m5=max(dx(:,6));
m6=max(dx(:,7));

n1=min(dx(:,2));
n2=min(dx(:,3));
n3=min(dx(:,4));
n4=min(dx(:,5));
n5=min(dx(:,6));
n6=min(dx(:,7));


disp('   ');

out1=sprintf('    max  \t %8.4f \t %8.4f \t %8.4f \t %8.4f \t %8.4f \t %8.4f',m1,m2,m3,m4,m5,m6);
out2=sprintf('    min  \t %8.4f \t %8.4f \t %8.4f \t %8.4f \t %8.4f \t %8.4f',n1,n2,n3,n4,n5,n6);

disp(out1);
disp(out2);

assignin('base','displacement_array',dx);

%%%%%%%%%%%%%%

fig_num=10;

figure(fig_num);
fig_num=fig_num+1;
plot3(xx+dx(:,2),dx(:,3),dx(:,4)); 
grid on;
title('Displacement Shape');

if(iu==1)
   xlabel('x (in)');
   ylabel('y (in)');
   zlabel('z (in)');
   xlabel2='x (in)';
   ylabel1='y (in)';
   ylabel2='z (in)';
else
   xlabel('x (m)');   
   ylabel('y (m)');
   zlabel('z (m)'); 
   xlabel2='x (m)'; 
   ylabel1='y (m)';
   ylabel2='z (m)';   
end

zz=get(gca,'zlim');
yy=get(gca,'ylim');
      
cc=max(abs([zz(1) zz(2) yy(1) yy(2)]));
      
ylim([ -cc, cc  ]);
zlim([ -cc, cc  ]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1=[xx+dx(:,2) dx(:,3)];
data2=[xx+dx(:,2) dx(:,4)];

t_string1='Displacement XY View';
t_string2='Displacement XZ View';

[fig_num]=subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Moment_y=zeros(num_nodes,1);
Moment_z=zeros(num_nodes,1);

Shear_y=zeros(num_nodes,1);
Shear_z=zeros(num_nodes,1);


x=0;
L=xx(2)-xx(1);
[MA,VA]=beam_bending_moment_array(L,x);

%            Uy      Rz
dispV=[  dx(1,3) dx(1,7)  dx(2,3) dx(2,7) ]';

Moment_z(1)=(EIz/L^2)*MA*dispV;
 Shear_z(1)=(EIz/L^2)*VA*dispV;

%            Uz      Ry
dispV=[  dx(1,4) dx(1,6)  dx(2,4) dx(2,6) ]';

Moment_y(1)=(EIy/L^2)*MA*dispV;
 Shear_y(1)=(EIy/L^2)*VA*dispV;
 

%%%

ne=num_nodes-1;

My_right=zeros(ne,1);
My_left =zeros(ne,1);
Vy_right=zeros(ne,1);
Vy_left =zeros(ne,1);

Mz_right=zeros(ne,1);
Mz_left =zeros(ne,1);
Vz_right=zeros(ne,1);
Vz_left =zeros(ne,1);


for i=1:ne
    
    L=xx(i+1)-xx(i);
    
    dispV=[  dx(i,3) dx(i,7)  dx(i+1,3) dx(i+1,7) ]';
    
    x=0;
    [MA,VA]=beam_bending_moment_array(L,x);
    Mz_left(i)=(EIz/L^2)*MA*dispV;
    Vz_left(i)=(EIz/L^2)*VA*dispV;    
    
    x=1;
    [MA,VA]=beam_bending_moment_array(L,x);
    Mz_right(i)=(EIz/L^2)*MA*dispV;
    Vz_right(i)=(EIz/L^2)*VA*dispV;        
    
    dispV=[  dx(1,4) dx(1,6)  dx(2,4) dx(2,6) ]';    
  
    x=0;
    [MA,VA]=beam_bending_moment_array(L,x);
    My_left(i)=(EIy/L^2)*MA*dispV;
    Vy_left(i)=(EIy/L^2)*VA*dispV;    
    
    x=1;
    [MA,VA]=beam_bending_moment_array(L,x);
    My_right(i)=(EIy/L^2)*MA*dispV;
    Vy_right(i)=(EIy/L^2)*VA*dispV;     
    
    
end

for i=1:(ne-1)
    
    Moment_z(i+1)=mean([Mz_right(i) Mz_left(i+1)]);
     Shear_z(i+1)=mean([Vz_right(i) Vz_left(i+1)]);    
     
    Moment_y(i+1)=mean([My_right(i) My_left(i+1)]);
     Shear_y(i+1)=mean([Vy_right(i) Vy_left(i+1)]);         
    
end

Moment_z(num_nodes)=Mz_right(ne);
 Shear_z(num_nodes)=Vz_right(ne);

Moment_y(num_nodes)=My_right(ne);
 Shear_y(num_nodes)=Vy_right(ne);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('  ');
disp('  Peak Max & Min  Bending Moments ');
disp('  ');
out1=sprintf('   Mz:    %8.4g     %8.4g  ',max(Moment_z),min(Moment_z));
disp(out1);
out1=sprintf('   My:    %8.4g     %8.4g  ',max(Moment_y),min(Moment_y));
disp(out1);

disp('  ');
disp('   Peak Max & Min  Shear Forces ');
disp('  ');
out1=sprintf('   Vz:    %8.4g     %8.4g  ',max(Shear_z),min(Shear_z));
disp(out1);
out1=sprintf('   Vy:    %8.4g     %8.4g  ',max(Shear_y),min(Shear_y));
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
   ylabel1='Moment (in-lbf)';
   ylabel2='Force (lbf)';
else
   ylabel1='Moment (N-m)'; 
   ylabel2='Force (N)';   
end


data1=[xx,Moment_z];
data2=[xx,Shear_z];
t_string1='Bending Moment about Z-axis';
t_string2='Shear Force';
[fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);


data1=[xx,Moment_y];
data2=[xx,Shear_y];
t_string1='Bending Moment about Y-axis';
t_string2='Shear Force';
[fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);


function edit_loads_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_loads_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_loads_array as text
%        str2double(get(hObject,'String')) returns contents of edit_loads_array as a double


% --- Executes during object creation, after setting all properties.
function edit_loads_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_loads_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nodes as text
%        str2double(get(hObject,'String')) returns contents of edit_nodes as a double


% --- Executes during object creation, after setting all properties.
function edit_nodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dof_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dof as text
%        str2double(get(hObject,'String')) returns contents of edit_dof as a double


% --- Executes during object creation, after setting all properties.
function edit_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
