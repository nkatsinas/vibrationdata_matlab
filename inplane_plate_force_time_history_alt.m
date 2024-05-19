function varargout = inplane_plate_force_time_history(varargin)
% INPLANE_PLATE_FORCE_TIME_HISTORY MATLAB code for inplane_plate_force_time_history.fig
%      INPLANE_PLATE_FORCE_TIME_HISTORY, by itself, creates a new INPLANE_PLATE_FORCE_TIME_HISTORY or raises the existing
%      singleton*.
%
%      H = INPLANE_PLATE_FORCE_TIME_HISTORY returns the handle to a new INPLANE_PLATE_FORCE_TIME_HISTORY or the handle to
%      the existing singleton*.
%
%      INPLANE_PLATE_FORCE_TIME_HISTORY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INPLANE_PLATE_FORCE_TIME_HISTORY.M with the given input arguments.
%
%      INPLANE_PLATE_FORCE_TIME_HISTORY('Property','Value',...) creates a new INPLANE_PLATE_FORCE_TIME_HISTORY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before inplane_plate_force_time_history_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to inplane_plate_force_time_history_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help inplane_plate_force_time_history

% Last Modified by GUIDE v2.5 06-Feb-2016 15:20:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @inplane_plate_force_time_history_OpeningFcn, ...
                   'gui_OutputFcn',  @inplane_plate_force_time_history_OutputFcn, ...
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


% --- Executes just before inplane_plate_force_time_history is made visible.
function inplane_plate_force_time_history_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to inplane_plate_force_time_history (see VARARGIN)

% Choose default command line output for inplane_plate_force_time_history
handles.output = hObject;

iu=getappdata(0,'iu');

if(iu==1)
    set(handles.text_force_unit,'String','Units: Time(sec) & Force(lbf)');    
else
    set(handles.text_force_unit,'String','Units: Time(sec) & Force(N)');       
end
    
listbox_force_axes_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes inplane_plate_force_time_history wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = inplane_plate_force_time_history_OutputFcn(hObject, eventdata, handles) 
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

delete(inplane_plate_force_time_history);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * ');
disp(' ');

tpi=2*pi;

try
    fig_num=getappdata(0,'fig_num');
catch
    fig_num=1;
end
setappdata(0,'fig_num',fig_num);

iu=getappdata(0,'iu');

nfcols=get(handles.listbox_force_axes,'Value');

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

sz=size(THM);

if(nfcols<=2 && sz(2)~=2)
   warndlg('Input array must have 2 columns');  
   return;    
end
if(nfcols==3 && sz(2)~=3)
   warndlg('Input array must have 3 columns');  
   return; 
end

fn=getappdata(0,'fn');



disp(' ref 1');


tt=THM(:,1);

if(nfcols==1)
    fx=THM(:,2);
    
    out1=sprintf('\n std(fx)=%8.4g ',std(fx));
    disp(out1);
    
end
if(nfcols==2)
    fy=THM(:,2);
end
if(nfcols==3)
    fx=THM(:,2);
    fy=THM(:,3);    
end


nt=sz(1);

if(nt<2);
    warndlg('Time history must have at least two steps.');
    return;
end

dt=(tt(nt)-tt(1))/(nt-1);
sr=1/dt;



node_matrix=getappdata(0,'node_matrix');
sz=size(node_matrix);

number_nodes=sz(1);

out1=sprintf('\n number_nodes=%d ',number_nodes);
disp(out1);

force_node=str2num(get(handles.edit_force_node,'String'));

if(force_node>number_nodes)
   out1=sprintf(' Maximum node number is %d',sz(1));
   warndlg(out1); 
   return;
end



element_matrix=getappdata(0,'element_matrix');
mass_unc=getappdata(0,'mass_unc');
stiff_unc=getappdata(0,'stiff_unc');
stiff=getappdata(0,'stiff');
mass=getappdata(0,'mass');

E=getappdata(0,'E');
rho=getappdata(0,'rho');
mu=getappdata(0,'mu');
ModeShapes=getappdata(0,'ModeShapes');
total_mass=getappdata(0,'total_mass');
dx=getappdata(0,'dx');
dy=getappdata(0,'dy');



try
    damp_Q=getappdata(0,'damp_Q');            
    damp_ratio=getappdata(0,'damp_ratio');  
catch
    warndlg('Damping ratios not found');
    return; 
end

%  ndof = number of includes modes

ndof=str2num(get(handles.edit_num_modes,'String'));

sz=size(ModeShapes');

if(ndof > sz(2))
    out1=sprintf(' Maximum mode number is %d',sz(2));
    warndlg(out1);     
    return;
end

out1=sprintf('\n ndof=%d ',ndof);
disp(out1);

disp(' Natural frequencies (Hz) ');

for i=1:ndof
   out1=sprintf(' %8.4g ',fn(i)); 
   disp(out1); 
end


out1=sprintf('\n  sr=%8.4g  Hz  fn(%d)=%8.4g Hz\n',sr,ndof,fn(ndof));
disp(out1);

if(sr<10*fn(ndof))
    warndlg('Increase sample rate');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MST=ModeShapes';

out1=sprintf('\n  nfcols=%d  force_node=%d  \n',nfcols,force_node);
disp(out1);

node_dof=getappdata(0,'node_dof');

MST

if(nfcols==1) % X
    fx_dof=node_dof(force_node,1);
    nodal_force=MST(1:ndof,fx_dof)*fx';
    out1=sprintf('\n fx_dof=%d  \n',fx_dof);
end
if(nfcols==2) % Y     
    fy_dof=node_dof(force_node,2);
    nodal_force=MST(1:ndof,fy_dof)*fy';
    out1=sprintf('\n fy_dof=%d  \n',fy_dof);
end
if(nfcols==3) % both  
    fx_dof=node_dof(force_node,1);    
    fy_dof=node_dof(force_node,2); 
    out1=sprintf('\n fx_dof=%d  fy_dof=%d\n',fx_dof,fy_dof);
        
    FA=[fx' ; fy'];  
    
    MST_subset= [ MST(1:ndof,fx_dof) MST(1:ndof,fy_dof)];  
    
    nodal_force=MST_subset*FA;    
end
disp(out1);

    
omegan=tpi*fn(1:ndof);
damp=damp_ratio(1:ndof);

[a1,a2,df1,df2,df3,vf1,vf2,vf3,af1,af2,af3]=...
             ramp_invariant_filter_coefficients_force(ndof,omegan,damp,dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

out1=sprintf('\n ndof=%d \n',ndof);
disp(out1);


%
%  Numerical Engine
%
disp(' ')
disp(' Calculating response...');
%
nx=zeros(nt,ndof);
nv=zeros(nt,ndof);
na=zeros(nt,ndof);
%
progressbar;

for j=1:ndof
    progressbar(j/ndof);
%
%  displacement
%
    d_forward=[   df1(j),  df2(j), df3(j) ];
    d_back   =[     1, -a1(j), -a2(j) ];
    d_resp=filter(d_forward,d_back,nodal_force(j,:));
%    
%  velocity
%
    v_forward=[   vf1(j),  vf2(j), vf3(j) ];
    v_back   =[     1, -a1(j), -a2(j) ];
    v_resp=filter(v_forward,v_back,nodal_force(j,:));
%    
%  acceleration
%   
    a_forward=[   af1(j),  af2(j), af3(j) ];
    a_back   =[     1, -a1(j), -a2(j) ]; 
    a_resp=filter(a_forward,a_back,nodal_force(j,:));
%

    nx(:,j)=d_resp;  % displacement
    nv(:,j)=v_resp;  % velocity
    na(:,j)=a_resp;  % acceleration  
%
end
pause(0.3);
progressbar(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear x;
clear v;
clear a;
%
sys_dof=number_nodes*2;

x=zeros(nt,sys_dof);
v=zeros(nt,sys_dof);
%% a=zeros(nt,sys_dof);
%
progressbar;
%
for i=1:nt
    progressbar(i/nt);
    x(i,:)=(ModeShapes(:,1:ndof)*((nx(i,:))'))';
    v(i,:)=(ModeShapes(:,1:ndof)*((nv(i,:))'))';
%%    a(i,:)=(ModeShapes(:,1:ndof)*((na(i,:))'))';    
end
pause(0.3);
progressbar(1);

dmax=0;
dn_max=0;

progressbar;
for j=1:number_nodes
   progressbar(j/number_nodes);    
   z=x(:,2*j-1).^2 + x(:,2*j).^2;
   maxz=max(abs(z));
   dr=sqrt(maxz);
   
   if(dr>dmax)
       dmax=dr;
       dn_max=j;
   end
   
end

if(dn_max==0)
    warndlg(' dn_max=0 ');
    return;
end

pause(0.3);
progressbar(1);

if(iu==1)
    out1=sprintf('\n Resultant Vector Maximum Displacement = \n     %7.3g in at node %d \n',dmax,dn_max);
else
    out1=sprintf('\n Resultant Vector Maximum Displacement = \n     %7.3g mm at node %d \n',dmax/1000,dn_max);    
end    
    
disp(out1);


L=getappdata(0,'L');
W=getappdata(0,'W');

a=L/2;
b=W/2;

sz=size(element_matrix);

num_elem=sz(1);

D=(E/(1-mu^2))*[1 mu 0; mu 1 0; 0 0 (1-mu)/2 ];

Bcg=zeros(3,8);


Bcg(1,:)=[ -1/dx   0    1/dx   0    1/dx   0   -1/dx    0 ];
Bcg(2,:)=[   0   -1/dy   0   -1/dy   0   1/dy    0    1/dy];
Bcg(3,:)=[ -1/dx  -1/dy  -1/dx  1/dy  1/dx  1/dy   1/dx  -1/dy];

Bcg=Bcg/4;

element_cg_strain=zeros(num_elem,nt,3);
element_cg_stress=zeros(num_elem,nt,3);

sv=zeros(num_elem,nt);

sv_max_elem=zeros(num_elem,1);



progressbar;
for i=1:num_elem
    
    progressbar(i/num_elem);
    
    node1=element_matrix(i,1);
    node2=element_matrix(i,2);
    node3=element_matrix(i,3);
    node4=element_matrix(i,4);
    
    U=zeros(nt,8); 
    
    for j=1:nt
            
        u1=x(j,2*node1-1);
        v1=x(j,2*node1);
        
        u2=x(j,2*node2-1);
        v2=x(j,2*node2);
        
        u3=x(j,2*node3-1);
        v3=x(j,2*node3);
        
        u4=x(j,2*node4-1);
        v4=x(j,2*node4);
  
        U(j,:)=[u1 v1 u2 v2 u3 v3 u4 v4];
                 
%%%        un(j)=norm(U(j,:));
    end
    
%%%    [C,I]=max(un);
    
%%%    Bcg
    
    BU=Bcg*U';
    
    element_cg_strain(i,:,:)=BU';   
    
 
    adj_strain=[element_cg_strain(i,:,1)  ; element_cg_strain(i,:,2) ; 2*element_cg_strain(i,:,3)]';    
    
             
    element_cg_stress(i,:,1)=   adj_strain(:,1) + mu*adj_strain(:,2);
    element_cg_stress(i,:,2)=mu*adj_strain(:,1) +    adj_strain(:,2);    
    element_cg_stress(i,:,3)=((1-mu)/2)*adj_strain(:,3);     
    
    
    element_cg_stress(i,:,:)=element_cg_stress(i,:,:)*E/(1-mu^2);
    
    sx=element_cg_stress(i,:,1);
    sy=element_cg_stress(i,:,2);
    txy=element_cg_stress(i,:,3); 
    
    q1=(sx+sy)/2;
    q2=sqrt( ((sx-sy)/2).^2 + txy.^2 );     
    
    s1= q1+q2;
    s2= q1-q2;     
    sv(i,:)=sqrt(s1.^2-s1.*s2+s2.^2);
        
    sv_max_elem(i)=std(sv(i,:));
    
end


%% for i=1:20
%%    out1=sprintf(' %8.4g %8.4g %8.4g ',element_cg_stress(24,i,1),element_cg_stress(24,i,2),element_cg_stress(24,i,3));
%%    disp(out1);
%% end
        


progressbar(0.3);
progressbar(1);


[C,I]=max(sv_max_elem);

disp(' ');
disp(' The maximum values are given in terms of rms. ');
disp(' ');

if(iu==1)
    out1=sprintf(' Maximum von Mises Stress = %8.4g psi rms at elem %d',C,I);
else
    out1=sprintf(' Maximum von Mises Stress = %8.4g Pa rms at elem %d',C,I);    
end    

node1=element_matrix(I,1);
node2=element_matrix(I,2);
node3=element_matrix(I,3);
node4=element_matrix(I,4);

out2=sprintf(' Bounded by nodes  %d %d %d %d ',node1,node2,node3,node4);
    
disp(out1);
disp(out2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
t=fix_size(tt);
%
clear velocity;
clear displacement;
%
velocity=[t v];
displacement=[t x];
%



dof1=2*dn_max-1;
dof2=dof1+1;

out1=sprintf('\n  dof1=%d  dof2=%d  \n',dof1,dof2);
disp(out1);

if(iu==1)
    displacement_max=[t x(:,dof1) x(:,dof2)];
    du='Disp (in)';
else
    displacement_max=[t x(:,dof1)/1000 x(:,dof2)/1000];    
    du='Disp (mm)';    
end

figure(998);
plot( displacement_max(:,1), displacement_max(:,2), displacement_max(:,1), displacement_max(:,3));
xlabel('Time (sec) ');
ylabel(du);
out1=sprintf('Displacement at Node %d ',dn_max);
title(out1);
grid on;




output_name_disp=sprintf('displacement_node_%d',dn_max);
assignin('base', output_name_disp, displacement_max);

%%%


% to avoid error message, do the long way

stress_max=zeros(nt,4);
sxm=zeros(nt,1);
sym=zeros(nt,1);
txym=zeros(nt,1);

for i=1:nt
    sxm(i)=element_cg_stress(I,i,1);
    sym(i)=element_cg_stress(I,i,2);
    txym(i)=element_cg_stress(I,i,3);
    
    stress_max(i,:)=[t(i) sxm(i) sym(i) txym(i)];
end

figure(999);
plot( t,sxm,t,sym,t,txy);
legend('sx','sy','txy');
xlabel('Time (sec) ');
ylabel(' stress');
out1=sprintf('Stress at Elem %d ',I);
title(out1);
grid on;


[rho_sx_sy]=Pearson_coefficient(sxm,sym);
[rho_sx_txy]=Pearson_coefficient(sxm,txy);
[rho_sy_txy]=Pearson_coefficient(sym,txy);

disp(' ');
out9=sprintf(' Pearson Coefficients for Stress Time Histories at Elem %d',I);
disp(out9);

out1=sprintf('      sx-sy %7.3g ',rho_sx_sy);
out2=sprintf('      sx-txy %7.3g ',rho_sx_txy);
out3=sprintf('      sy-txy %7.3g ',rho_sy_txy);
disp(out1);
disp(out2);
disp(out3);

disp(' max strain x-axis ');

eee=abs(element_cg_strain(:,:,1));

max(max(eee))

output_name_stress=sprintf('stress_elem_%d',I);
assignin('base', output_name_stress, stress_max);

%%%
   
assignin('base','velocity',velocity);   
assignin('base','displacement',displacement);   
%
disp(' ');
disp(' Output arrays: ');
disp('   displacement   time & all dof ');
disp('   velocity       time & all dof ');

out1=sprintf('\n   %s  - time  ux  uy',output_name_disp);
disp(out1);
out1=sprintf('\n   %s  - time  sx  sy  txy ',output_name_stress);
disp(out1);
disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function edit_force_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force_node as text
%        str2double(get(hObject,'String')) returns contents of edit_force_node as a double


% --- Executes during object creation, after setting all properties.
function edit_force_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_modes as text
%        str2double(get(hObject,'String')) returns contents of edit_num_modes as a double


% --- Executes during object creation, after setting all properties.
function edit_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_force_axes.
function listbox_force_axes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_axes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_axes

n=get(handles.listbox_force_axes,'Value');

if(n<=2)
    ssc='The input array must have two columns:';    
else
    ssc='The input array must have three columns:';
end

if(n==1)
    ssh='Time & Force X';
end
if(n==2)
    ssh='Time & Force Y';
end
if(n==3)
    ssh='Time, Force X,  Force Y';
end


set(handles.text_force_1,'String',ssc);
set(handles.text_force_2,'String',ssh);


% --- Executes during object creation, after setting all properties.
function listbox_force_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force_axes (see GCBO)
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
