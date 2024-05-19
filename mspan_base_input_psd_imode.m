function varargout = mspan_base_input_psd_imode(varargin)
% MSPAN_BASE_INPUT_PSD_IMODE MATLAB code for mspan_base_input_psd_imode.fig
%      MSPAN_BASE_INPUT_PSD_IMODE, by itself, creates a new MSPAN_BASE_INPUT_PSD_IMODE or raises the existing
%      singleton*.
%
%      H = MSPAN_BASE_INPUT_PSD_IMODE returns the handle to a new MSPAN_BASE_INPUT_PSD_IMODE or the handle to
%      the existing singleton*.
%
%      MSPAN_BASE_INPUT_PSD_IMODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MSPAN_BASE_INPUT_PSD_IMODE.M with the given input arguments.
%
%      MSPAN_BASE_INPUT_PSD_IMODE('Property','Value',...) creates a new MSPAN_BASE_INPUT_PSD_IMODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mspan_base_input_psd_imode_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mspan_base_input_psd_imode_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mspan_base_input_psd_imode

% Last Modified by GUIDE v2.5 16-Jul-2021 13:33:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mspan_base_input_psd_imode_OpeningFcn, ...
                   'gui_OutputFcn',  @mspan_base_input_psd_imode_OutputFcn, ...
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


% --- Executes just before mspan_base_input_psd_imode is made visible.
function mspan_base_input_psd_imode_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mspan_base_input_psd_imode (see VARARGIN)

% Choose default command line output for mspan_base_input_psd_imode
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mspan_base_input_psd_imode wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mspan_base_input_psd_imode_OutputFcn(hObject, eventdata, handles) 
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

delete(mspan_base_input_psd);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


dof=getappdata(0,'dof');
num_nodes_Tz_free=round(dof/2);


fn=getappdata(0,'fn');
ModeShapes=getappdata(0,'ModeShapes');
E=getappdata(0,'E');
rho=getappdata(0,'rho');
I=getappdata(0,'I');    
cna=getappdata(0,'cna');  

num_elem=getappdata(0,'num_elem');

Q=str2double(get(handles.edit_Q,'String'));
damp=1/(2*Q);

step_partition_Callback(hObject, eventdata, handles);

rot_dof=getappdata(0,'rot_dof');

TT=getappdata(0,'TT');
T1=getappdata(0,'T1');
T2=getappdata(0,'T2');

Mwd=getappdata(0,'Mwd');
Mww=getappdata(0,'Mww');
Kwd=getappdata(0,'Kwd');
Kww=getappdata(0,'Kww');

TZ_tracking_array=getappdata(0,'TZ_tracking_array'); 
num_Tz=length(TZ_tracking_array);

free_dof_array=getappdata(0,'free_dof_array'); 
constraint_matrix=getappdata(0,'constraint_matrix'); 

part_fn=getappdata(0,'part_fn');
omega=getappdata(0,'part_omega');

ModeShapes=getappdata(0,'part_ModeShapes');
MST=ModeShapes';

ngw=getappdata(0,'ngw');

nem=getappdata(0,'nem');

xx=getappdata(0,'xx');
LEN=getappdata(0,'LEN');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS=get(handles.edit_input_psd,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found');
    return;
end

num=length(THM(:,1));
 
fmin=THM(1,1);
fmax=THM(num,1);
  

%%%  need to cleanup

sz=size(Mww);
nff=sz(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omegan=omega;
omn2=omegan.^2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f(1)=fmin;
oct=2^(1/48);

k=2;
while(1)
    f(k)=f(k-1)*oct;
    
    if(f(k)>fmax)
        f(k)=fmax;
        break;
    end
    
    k=k+1;
end

freq=f;

np=length(f);


%
 
omega=2*pi*f;
om2=omega.^2;

%
[~,jnear]=min(abs(omegan(1)-omega));

N=zeros(nff,1);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[base_psd]=interp_psd_oct(THM(:,1),THM(:,2),freq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_modes_include=str2num(get(handles.edit_num_modes,'String'));

if(nff> num_modes_include)
    nff=num_modes_include;
end    

%
y=ones(nem,1);

A=-MST*Mwd*y;
%
acc=zeros(np,num_Tz);
rd=zeros(np,num_Tz);
stress=zeros(np,num_Tz);

num_dof_unc=num_elem*2+2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for k=1:np  % for each excitation frequency
    
    for i=nff:nff  % dof
        N(i)=A(i)/(omn2(i)-om2(k) + (1i)*2*damp*omegan(i)*omega(k));
    end
    
    Ud=zeros(nem,1); 
    for i=1:nem  % convert acceleration input to displacement
        Ud(i)=1/(-om2(k));
    end
%
    Uw=ModeShapes*N;   

    Udw=[Ud; Uw];
%
    U=TT*Udw;    
    
    nu=length(U);
    
    if(k==1)
        fprintf(' nu=%d num_elem=%d  num_nodes_Tz_free=%d\n',nu,num_elem,num_nodes_Tz_free);
        ngw
    end
    
    Ur=zeros(nu,1);
    
    for i=1:nu
       Ur(ngw(i))=U(i);   
    end    
    
    if(k==1)
        num_nodes=num_elem+1;
        total_dof=num_nodes*2;
    
        R_tracking_array=zeros(num_nodes,1);

        rot_dof;  
        num_Ur=length(Ur);
    
        rot_constraint_matrix=constraint_matrix;
    
        constraint_matrix;
    
        length(constraint_matrix(:,1))
    
        for i=length(constraint_matrix(:,1)):-1:1
            if(constraint_matrix(i,3)==0)
                rot_constraint_matrix(i,:)=[];
            end
        end
    
        bbb=(1:num_Ur);
    
        for i=1:num_Tz
            [Lia,Locb] =ismember(TZ_tracking_array,bbb);
            if(Lia==1)
                bbb(Locb)=[];
            end
        end
    
        fprintf(' num_nodes=%d  num_Ur=%d \n',num_nodes,num_Ur);
        ccc=rot_constraint_matrix(:,1);
        
        kv=1;
        for jj=1:num_nodes    
            if(ismember(jj,ccc))
%                fprintf(' jj=%d  included \n',jj);
            else    
%                fprintf(' jj=%d  kv=%d \n',jj,kv);
                R_tracking_array(jj)=bbb(kv);
                kv=kv+1;
            end
        end
    end
    
    for jk=1:num_Tz
        node=jk;    
        ij=TZ_tracking_array(node);
        acc(k,jk)=om2(k)*abs(Ur(ij));
         rd(k,jk)=abs(Ur(ij)-Ud(1));        
    end
    
    for nk=1:num_nodes-1
    
        left_node=nk;
        right_node=nk+1;

        LL=abs(xx(left_node)-xx(right_node));
        
        [B]=beam_stress_B(0,LL);
        
        TL=TZ_tracking_array(left_node);
        TR=TZ_tracking_array(right_node);
        
        URL=0;
        URR=0;
        RL=0;
        RR=0;
        
        if(R_tracking_array(left_node)~=0)
            RL=R_tracking_array(left_node);
            URL=Ur(RL);
        end
        if(R_tracking_array(right_node)~=0)
            RR=R_tracking_array(right_node);
            URR=Ur(RR);            
        end
         
         d=transpose([Ur(TL) URL Ur(TR) URR]);

%       if(k==1)
%           fprintf('nk=%d  %d %d %d %d   \n',nk,TL,RL,TR,RR);
%            fprintf('  %8.4g  %8.4g  %8.4g  %8.4g \n\n',d(1),d(2),d(3),d(4));
%            B
%        end

            stress(k,nk)=abs(cna*E*B*d);
            
           QQQ=1; 
           if(k==jnear  && QQQ==1)
                 dzL=Ur(TL);
                 ryL=URL; 
                 dzR=Ur(TR); 
                 ryR=URR; 
                 s1=stress(k,nk);
                 fprintf('\n\n nk=%d \n\n',nk);
                 fprintf(' cna=%g  E=%7.3g  s1=%8.4g \n',cna,E,s1*386);
                 fprintf('B  %7.3g  %7.3g\n',real(B(1)*dzL),imag(B(1)*dzL));
                 fprintf('B  %7.3g  %7.3g\n',real(B(2)*ryL),imag(B(2)*ryL));
                 fprintf('B  %7.3g  %7.3g\n',real(B(3)*dzR),imag(B(3)*dzR));
                 fprintf('B  %7.3g  %7.3g\n',real(B(4)*ryR),imag(B(4)*ryR));   
                 cna*E*B*d
                transpose([Ur(TL) URL Ur(TR) URR])
            end
        
    end
    
% stress at right end  

    stress(k,end)=stress(k,end-1);
    
end


rd=rd*386;
stress=stress*386;

f=fix_size(f);

   acc_power=zeros(np,num_nodes);
    rd_power=zeros(np,num_nodes);
stress_power=zeros(np,num_nodes);
 
     acc_psd=zeros(np,num_nodes);
      rd_psd=zeros(np,num_nodes); 
  stress_psd=zeros(np,num_nodes);
 
  
for i=1:np
    for j=1:num_nodes
            acc_power(i,j)=acc(i,j)^2;
             rd_power(i,j)=rd(i,j)^2;
         stress_power(i,j)=stress(i,j)^2;
         
              acc_psd(i,j)=acc_power(i,j)*base_psd(i);
               rd_psd(i,j)= rd_power(i,j)*base_psd(i);
           stress_psd(i,j)=stress_power(i,j)*base_psd(i);        
    end
end    

 accel_rms=zeros(num_nodes,1);
    rd_rms=zeros(num_nodes,1);
stress_rms=zeros(num_nodes,1);


disp(' ');
disp(' Overall Levels ');
disp(' Node  Accel(GRMS)  Rel Disp(in RMS)   Stress(psi RMS) ');

for i=1:length(accel_rms)
    [~,accel_rms(i)]=calculate_PSD_slopes(f,acc_psd(:,i));
    [~,rd_rms(i)]=calculate_PSD_slopes(f,rd_psd(:,i));
    [~,stress_rms(i)]=calculate_PSD_slopes(f,stress_psd(:,i));   
    fprintf(' %d \t %8.4g \t %8.4g \t %8.4g  \n',i,accel_rms(i),rd_rms(i),stress_rms(i));
end

[C,I]=max(accel_rms);
[Crd,Ird]=max(rd_rms);
[Cst,Ist]=max(stress_rms);

[~,input_rms]=calculate_PSD_slopes(f,base_psd);

leg_a=sprintf('Input %6.3g GRMS',input_rms);
leg_b=sprintf('Response %6.3g GRMS',C);

fig_num=100;

ppp=[ f base_psd];
qqq=[ f acc_psd(:,I)];
setappdata(0,'acc_psd',[f acc_psd(:,I)]);

x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';

t_string_a=sprintf(' Accel PSD  Max at Node %d   Location %6.3g in',I,xx(I,1));

[fig_num,h2]=plot_PSD_two_h2(fig_num,x_label,y_label,t_string_a,ppp,qqq,leg_a,leg_b);

%%

md=5;

ppp=[ f rd_psd(:,Ird)];
setappdata(0,'rd_psd',[f rd_psd(:,Ird)]);

fmin=f(1);
fmax=f(end);
y_label='Rel Disp (inch^2/Hz)';
t_string=sprintf(' Rel Disp PSD  Max at Node %d   Location %6.3g in  \n Overall Level %7.3g inch RMS',Ird,xx(Ird,1),Crd);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%

pv_psd=zeros(np,1);

for i=1:np
    pv_psd(i)=(2*pi*f(i))^2*rd_psd(i,Ird);
end

ppp=[ f pv_psd];
setappdata(0,'pv_psd',[f pv_psd]);

[~,PV_rms]=calculate_PSD_slopes(f,pv_psd);

fmin=f(1);
fmax=f(end);
y_label='PV ((in/sec)^2/Hz)';
t_string=sprintf(' Pseudo Velocity PSD  Max at Node %d   Location %6.3g in  \n Overall Level %7.3g in/sec RMS',Ird,xx(Ird,1),PV_rms);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%


ppp=[ f stress_psd(:,Ist)];
setappdata(0,'stress_psd',[f stress_psd(:,Ist)]);

y_label='Stress (psi^2/Hz)';
t_string=sprintf(' Stress PSD  Max at Node %d   Location %6.3g in  \n Overall Level %7.4g psi RMS',Ist,xx(Ist,1),Cst);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


cross_section=getappdata(0,'cross_section');

if(cross_section<=3)

    E=getappdata(0,'E');
    rho=getappdata(0,'rho');
    c=sqrt(E/rho);

    if(cross_section==1)  % rectangle
        scale=sqrt(3);
    end
    if(cross_section==2)  % pipe
        scale=sqrt(2);
    end
    if(cross_section==3)  % solid
        scale=2;
    end    
    
    SV=scale*rho*c*PV_rms;

    fprintf('\n\n  Maximum Stress estimate from Pseudo Velocity = %8.4g psi RMS  \n\n',SV)

    set(handles.uipanel_save,'Visible','on');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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


function step_partition_Callback(hObject, eventdata, handles)

%  ea=[1 2]  dof with enforced

% num total dof
% nem number of dof with enforced acceleration

%
%  etype =1  enforced acceleration
%         2  enforced displacement
%

etype =1;

dof_status=getappdata(0,'dof_status');

mass=getappdata(0,'mass_unc');
stiff=getappdata(0,'stiff_unc');

mass
stiff


sz=size(mass);
dof=sz(1);

tracking_array=zeros(dof,1);
free_dof_array=zeros(dof,1);


for i=1:dof
    tracking_array(i)=i;
    free_dof_array(i)=i;
end

num_nodes_Tz_free=round(dof/2);

TZ_tracking_array=zeros(num_nodes_Tz_free,1);

for i=1:num_nodes_Tz_free
   TZ_tracking_array(i)=2*i-1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=1;

for i=1:num_nodes_Tz_free
    
    if( dof_status(2*i-1)==0 || dof_status(2*i)==0)
        constraint_matrix(k,:)=[i 0 0];
        
        if(dof_status(2*i-1)==0)
            constraint_matrix(k,2)=1;
        end
        if(dof_status(2*i)==0)
            constraint_matrix(k,3)=1;
        end     
        
        k=k+1;
    end    
        
end


k=1;

ibc=1;

n=length(constraint_matrix(:,1));
    
for i=1:n
    
    if(constraint_matrix(i,2)==1)
        ea(k)=2*constraint_matrix(i,1)-1;
        k=k+1;
    end
        
    if(constraint_matrix(i,3)==1)
        rot_constraint_matrix(ibc,1)=constraint_matrix(i,1);
        rot_constraint_matrix(ibc,2)=0;
        rot_constraint_matrix(ibc,3)=constraint_matrix(i,3);
        ibc=ibc+1;
    end
            
end

ibc=ibc-1;

constraint_matrix
ea

if(ibc>=1)
    rot_constraint_matrix
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(constraint_matrix);

nc=sz(1);

k=1;
for i=1:nc 
    
     cmn=constraint_matrix(i,1);
    
     if(constraint_matrix(i,2)==1)
        cdof(k)=2*cmn-1;
        k=k+1;
     end    
     if(constraint_matrix(i,3)==1)
        cdof(k)=2*cmn;
        k=k+1;
     end   
end

cdof=sort(cdof,'descend');

for i=1:length(cdof)
    free_dof_array(cdof(i))=[];
end    

cdof
free_dof_array


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


k=1;
for i=1:ibc 
     if(rot_constraint_matrix(i,3)==1)
        rot_dof(k)=2*rot_constraint_matrix(i,1);
        k=k+1;
     end
end

try
    rot_dof=sort(rot_dof);
    ibc=length(rot_dof);  
catch
    rot_dof=0;
    ibc=0;
end
    
  
    
ea=unique(ea);
nem=length(ea);
setappdata(0,'nem',nem);

ea=fix_size(ea);

eac(:,1)=ea;


rot_dof



if(ibc>=1)  % correct ea matrix
    
    rot_dof=sort(rot_dof,'descend');
    
    for i=1:ibc
        for j=1:nem
            if(ea(j)>rot_dof(i))
                ea(j)=ea(j)-1;
%%                out7=sprintf(' %d %d ',ea(j),rot_dof(i));
%%                disp(out7);
            end
        end
    end
    
    drot_dof=sort(rot_dof,'descend');
    
    for i=1:ibc
        
      tracking_array(drot_dof(i))=[];
         
    end   

    
    for i=1:ibc
        for j=1:num_nodes_Tz_free
            if( TZ_tracking_array(j)>rot_dof(i) )
                   TZ_tracking_array(j)=TZ_tracking_array(j)-1;
            end       
        end
    end    
    
    
end


eac(:,2)=ea;

for i=1:length(ea)
    eac(i,3)=eac(i,2)-eac(i,1);
end
    

ea=unique(ea);
nem=length(ea);


if(nem==0)
    warndlg('No drive dofs');
    return;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ibc>=1)
    sz=size(rot_constraint_matrix);
else
    sz(1)=0;
end
    
for i=sz(1):-1:1
    if(rot_constraint_matrix(i,3)==1)
        p=2*rot_constraint_matrix(i,1);
         mass(:,p)=[];
         mass(p,:)=[];
        stiff(:,p)=[];
        stiff(p,:)=[];      
    end
end


sz=size(mass);
num=sz(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
etype=1;
 
% num total dof
% nem number of dof with enforced acceleration
 
disp(' Track Changes ');  

% num = total dof - constrained rotational dof
% ea = Tz dof enforced acceleration

fprintf(' nem=%d  num=%d  \n',nem,num);
ea

[ngw]=track_changes(nem,num,ea);
 
dtype=2; % display partitioned matrices

%% out1=sprintf('\n ** num=%d  nem=%d \n',num,nem);
%% disp(out1);


fprintf(' ibc=%d \n',ibc);

disp(' Enforced Partition Matrices ');    

[TT,T1,T2,Mwd,Mww,Kwd,Kww]=...
                enforced_partition_matrices(num,ea,mass,stiff,etype,dtype);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp(' Generalized Eigen ');            
            
[part_fn,part_omega,part_ModeShapes,part_MST]=Generalized_Eigen(Kww,Mww,2);            
            
setappdata(0,'TT',TT);
setappdata(0,'T1',T1);
setappdata(0,'T2',T2);

setappdata(0,'Mwd',Mwd);
setappdata(0,'Mww',Mww);
setappdata(0,'Kwd',Kwd);
setappdata(0,'Kww',Kww);

setappdata(0,'rot_dof',rot_dof);
setappdata(0,'constraint_matrix',constraint_matrix);
 
setappdata(0,'TZ_tracking_array',TZ_tracking_array); 

setappdata(0,'tracking_array',tracking_array); 
setappdata(0,'free_dof_array',free_dof_array); 

setappdata(0,'part_fn',part_fn);
setappdata(0,'part_omega',part_omega);
setappdata(0,'part_ModeShapes',part_ModeShapes);
setappdata(0,'ngw',ngw);


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_input_psd and none of its controls.
function edit_input_psd_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_psd (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'stress_psd');
end
if(n==2)
    data=getappdata(0,'acc_psd');
end
if(n==3)
    data=getappdata(0,'pv_psd');
end
if(n==4)
    data=getappdata(0,'rd_psd');
end

output_name=get(handles.edit_output_array_name,'String');

assignin('base', output_name, data);

h = msgbox('Save Complete'); 

% --- Executes on button press in pushbutton_Dirlik.
function pushbutton_Dirlik_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Dirlik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_stress_psd_fatigue_nasgro;
set(handles.s,'Visible','on');



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
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
