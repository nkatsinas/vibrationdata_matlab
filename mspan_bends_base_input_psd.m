function varargout = mspan_base_input_psd(varargin)
% MSPAN_BASE_INPUT_PSD MATLAB code for mspan_base_input_psd.fig
%      MSPAN_BASE_INPUT_PSD, by itself, creates a new MSPAN_BASE_INPUT_PSD or raises the existing
%      singleton*.
%
%      H = MSPAN_BASE_INPUT_PSD returns the handle to a new MSPAN_BASE_INPUT_PSD or the handle to
%      the existing singleton*.
%
%      MSPAN_BASE_INPUT_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MSPAN_BASE_INPUT_PSD.M with the given input arguments.
%
%      MSPAN_BASE_INPUT_PSD('Property','Value',...) creates a new MSPAN_BASE_INPUT_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mspan_base_input_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mspan_base_input_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mspan_base_input_psd

% Last Modified by GUIDE v2.5 27-Jun-2021 13:03:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mspan_base_input_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @mspan_base_input_psd_OutputFcn, ...
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


% --- Executes just before mspan_base_input_psd is made visible.
function mspan_base_input_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mspan_base_input_psd (see VARARGIN)

% Choose default command line output for mspan_base_input_psd
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mspan_base_input_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mspan_base_input_psd_OutputFcn(hObject, eventdata, handles) 
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

disp(' ');
disp(' * * * * * response to base input psd * * * * * ');
disp(' ');

dof=getappdata(0,'dof');

TE=getappdata(0,'TE');

E=getappdata(0,'E');
rho=getappdata(0,'rho');
I=getappdata(0,'I');    
cna=getappdata(0,'cna');  
area=getappdata(0,'area');
LEN=getappdata(0,'LEN');

num_elem=getappdata(0,'num_elem');

Q=str2double(get(handles.edit_Q,'String'));
damp=1/(2*Q);

step_partition_Callback(hObject, eventdata, handles);

TT=getappdata(0,'TT');
T1=getappdata(0,'T1');
T2=getappdata(0,'T2');

Mwd=getappdata(0,'Mwd');
Mww=getappdata(0,'Mww');
Kwd=getappdata(0,'Kwd');
Kww=getappdata(0,'Kww');

num_Tz=num_elem+1;
num_nodes=num_elem+1;


omega=getappdata(0,'part_omega');

ModeShapes=getappdata(0,'part_ModeShapes');
MST=ModeShapes';

ngw=getappdata(0,'ngw');

nem=getappdata(0,'nem');

xx=getappdata(0,'xx');

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
  

% disp('size Mww');
sz=size(Mww);
nff=sz(1);

% disp('size Mwd');
size(Mwd);

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

N=zeros(nff,1);
%
[~,jnear]=min(abs(omegan(1)-omega));

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cross=getappdata(0,'cross');
theta=getappdata(0,'theta');

for k=1:np  % for each excitation frequency
    
    for i=1:nff  % dof
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
  %      fprintf(' nu=%d num_elem=%d  nem=%d\n',nu,num_elem,nem);
        ngw;
    end

    Ur=zeros(6*num_nodes,1);
    
    for i=1:nu
       Ur(ngw(i))=U(i);   
    end    
    
    if(k==1)
%        disp(' Ur ');
        for iq=1:length(Ur)
%            fprintf(' %d  %8.4g \n',iq,abs(Ur(iq)));
        end
%        disp(' ');
    end
    
    for jk=1:num_Tz
        iv=6*jk-3;    
        acc(k,jk)=om2(k)*abs(Ur(iv));
         rd(k,jk)=abs(Ur(iv)-Ud(1));        
    end

    for nk=1:num_elem
    
        left_node=nk;
        right_node=nk+1;
        
        LL=LEN(nk);
        [B]=beam_stress_B(0,LL);
        
%   transform displacement to local coordinate system

        ia=6*nk-5;
        d=Ur(ia:(ia+11))';        

        R=rotz(-theta(nk)*180/pi);

        T=zeros(12,12);
        T(1:3,1:3)=R;
        T(4:6,4:6)=R;
        T(7:9,7:9)=R;
        T(10:12,10:12)=R;     
        
        dt=T*transpose(d);  % use transpose because d is complex
        
        
        
%   stress in three axes

        if(cross==1)  % rectangular
            
        else  % pipe or solid cylinder
            dzL=dt(3);
            ryL=dt(5);
            dzR=dt(9);
            ryR=dt(11);
            
            dyL=dt(2); 
            rzL=dt(6); 
            dyR=dt(8); 
            rzR=dt(12);

            sstt=transpose([dzL ryL dzR ryR ])+transpose([dyL rzL dyR rzR ]);
            
            s1=abs(cna*E*B*sstt);
        
            QQQ=0;
            if(k==jnear && QQQ==1)
                 
                 fprintf('\n\n nk=%d \n\n',nk);
                 fprintf(' cna=%g  E=%7.3g  s1=%8.4g \n',cna,E,s1*386);
                 fprintf('B  %7.3g  %7.3g\n',real(B(1)*dzL),imag(B(1)*dzL));
                 fprintf('B  %7.3g  %7.3g\n',real(B(2)*ryL),imag(B(2)*ryL));
                 fprintf('B  %7.3g  %7.3g\n',real(B(3)*dzR),imag(B(3)*dzR));
                 fprintf('B  %7.3g  %7.3g\n',real(B(4)*ryR),imag(B(4)*ryR));   
                 cna*E*B*sstt
                 transpose([dzL ryL dzR ryR ] )
           end

            stress(k,nk)=s1;
        end

    end

% stress at right end  

    stress(k,end)=stress(k,end-1);
    
end


rd=rd*386;
stress=stress*386;

f=fix_size(f);

   acc_power=zeros(np,num_Tz);
    rd_power=zeros(np,num_Tz);
stress_power=zeros(np,num_Tz);
 
     acc_psd=zeros(np,num_Tz);
      rd_psd=zeros(np,num_Tz); 
  stress_psd=zeros(np,num_Tz);
 
  
for i=1:np
    for j=1:num_Tz
            acc_power(i,j)=acc(i,j)^2;
             rd_power(i,j)=rd(i,j)^2;
         stress_power(i,j)=stress(i,j)^2;
         
              acc_psd(i,j)=acc_power(i,j)*base_psd(i);
               rd_psd(i,j)= rd_power(i,j)*base_psd(i);
           stress_psd(i,j)=stress_power(i,j)*base_psd(i);        
    end
end    

 accel_rms=zeros(num_Tz,1);
    rd_rms=zeros(num_Tz,1);
stress_rms=zeros(num_Tz,1);


disp(' ');
disp(' Overall Levels ');
disp(' Node   Accel   Rel Disp    Stress ');
disp('       (GRMS)   (in RMS)    (psi)');

for i=1:num_Tz
    [~,accel_rms(i)]=calculate_PSD_slopes(f,acc_psd(:,i));
    [~,rd_rms(i)]=calculate_PSD_slopes(f,rd_psd(:,i));
    [~,stress_rms(i)]=calculate_PSD_slopes(f,stress_psd(:,i));   
    fprintf(' %d \t %8.4g \t %8.4g \t %8.4g   \n',i,accel_rms(i),rd_rms(i),stress_rms(i));
end

[C,I]=max(accel_rms);
[Crd,Ird]=max(rd_rms);
[Cst,Ist]=max(stress_rms);

% fprintf('\n Ist=%d \n',Ist);

[~,input_rms]=calculate_PSD_slopes(f,base_psd);

leg_a=sprintf('Input %5.3g GRMS',input_rms);
leg_b=sprintf('Response %5.3g GRMS',C);

fig_num=100;

ppp=[ f base_psd];
qqq=[ f acc_psd(:,I)];
setappdata(0,'acc_psd',[f acc_psd(:,I)]);

x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';

t_string_a=sprintf(' Accel PSD  Max at Node %d   Location (%5.3g, %5.3g) in',I,xx(I,1),xx(I,2));

[fig_num,h2]=plot_PSD_two_h2(fig_num,x_label,y_label,t_string_a,ppp,qqq,leg_a,leg_b);

%%

md=5;

ppp=[ f rd_psd(:,Ird)];
setappdata(0,'rd_psd',[f rd_psd(:,Ird)]);

fmin=f(1);
fmax=f(end);
y_label='Rel Disp (inch^2/Hz)';
t_string=sprintf(' Rel Disp PSD  Max at Node %d   Location (%5.3g, %5.3g) in   \n Overall Level %7.3g inch RMS',Ird,xx(Ird,1),xx(Ird,2),Crd);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%

pv_psd=zeros(np,1);

for i=1:np
    pv_psd(i)=(2*pi*f(i))^2*rd_psd(i,Ird);
end

ppp=[ f pv_psd];
setappdata(0,'pv_psd',[f pv_psd]);
setappdata(0,'all_stress_psd',[f stress_psd]);

[~,PV_rms]=calculate_PSD_slopes(f,pv_psd);

fmin=f(1);
fmax=f(end);
y_label='PV ((in/sec)^2/Hz)';
t_string=sprintf(' Pseudo Velocity PSD  Max at Node %d   Location (%5.3g, %5.3g) in  \n Overall Level %7.3g in/sec RMS',Ird,xx(Ird,1),xx(Ird,2),PV_rms);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%

qqq=1;

if(qqq==1)

    ppp=[ f stress_psd(:,Ist)];
    setappdata(0,'stress_psd',[f stress_psd(:,Ist)]);

    y_label='Stress (psi^2/Hz)';
    t_string=sprintf(' Stress PSD  Max at Node %d   Location (%5.3g, %5.3g) in  \n Overall Level %7.4g psi RMS',Ist,xx(Ist,1),xx(Ist,2),Cst);

    try
         [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
    catch
    end

end
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
    
    scale2=Cst/(  rho*c*PV_rms );

    fprintf('\n Maximum Stress estimate from Pseudo Velocity \n');
    fprintf('       = %8.4g psi RMS for k=%4.2f \n',SV,scale)
    fprintf('       = %8.4g psi RMS for k=%4.2f \n',Cst,scale2)

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

cdof=getappdata(0,'cdof');
cdof=sort(unique(cdof),'descend');
cdof

dof_status=getappdata(0,'dof_status');

Mass=getappdata(0,'mass_unc');
Stiff=getappdata(0,'stiff_unc');

disp('size mass_unc');
sz=size(Mass)

dof=sz(1);   % unconstrained dof

fprintf('\n dof=%d \n',dof);

tracking_array=zeros(dof,1);
free_dof_array=zeros(dof,1);

for i=1:dof
    tracking_array(i)=i;
    free_dof_array(i)=i;
end

num_nodes=round(dof/6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\n num_nodes=%d  length(dof_status)=%d \n',num_nodes,length(dof_status));

k=1;
    
for i=3:6:6*num_nodes
    
    if(ismember(i,cdof))
        ea(k)=i;
        k=k+1;
    end
        
end

disp(' ea before ');
ea

ibc=length(ea);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ea=unique(ea);
nem=length(ea);
setappdata(0,'nem',nem);

ea=fix_size(ea);

% disp(' ea before ');
% ea

TZ_tracking_array=(3:6:6*num_nodes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_con=length(cdof);

cdof=sort(cdof,'descend');

cdof_minus_TZ=cdof;

for i=3:6:6*num_nodes
    if(ismember(i,cdof_minus_TZ))
        jj = cdof_minus_TZ==i;
        cdof_minus_TZ(jj)=[];
    end
end
 

% cdof_minus_TZ

setappdata(0,'cdof_minus_TZ',cdof_minus_TZ);

% num total dof
% nem number of dof with enforced acceleration
% ea = Tz dof enforced acceleration


%  Track changes
%
num=num_nodes*6;
ngw=zeros(num,1);
ea;
ngw(1:nem)=ea;
for i=1:num
    if(~ismember(i,cdof))
        ngw(nem+i)=i;
    end
end
ngw=ngw(ngw~=0);
% disp('cdof')
% cdof
% disp('ngw');
% ngw

fprintf(' nem=%d  num=%d  \n',nem,num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ea_orig=ea;

kk=0;


for i=1:num_con
    if(~ismember(cdof(i),ea_orig))
        Stiff(cdof(i),:)=[];
        Stiff(:,cdof(i))=[];
        Mass(cdof(i),:)=[];
        Mass(:,cdof(i))=[];
     
        kk=kk+1;
        
        for k=1:nem
            if(cdof(i)<ea(k) )
                ea(k)=ea(k)-1;
            end
        end
        for k=1:num_nodes
            if(cdof(i)<TZ_tracking_array(k))
                TZ_tracking_array(k)=TZ_tracking_array(k)-1;
            end
        end        

    end    
end


fprintf(' kk=%d dof removed \n',kk);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ea after ');
ea

% disp('TZ_tracking_array');
% TZ_tracking_array


if(nem==0)
    warndlg('No drive dofs');
    return;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

etype=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
dtype=2; % display partitioned matrices

fprintf(' ibc=%d \n',ibc);

disp(' Enforced Partition Matrices '); 

num=length(Mass(:,1));


[TT,T1,T2,Mwd,Mww,Kwd,Kww]=...
                enforced_partition_matrices(num,ea,Mass,Stiff,etype,dtype);

disp('size Mwd');
size(Mwd)
disp('size Mww');
size(Mww)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp(' Generalized Eigen ');            
            
[part_fn,part_omega,part_ModeShapes,~]=Generalized_Eigen(Kww,Mww,2);            
       
disp(' n    fn(Hz) ');

for i=1:min([length(part_fn) 6])
    fprintf('%d.  %8.4g \n',i,part_fn(i));
end


setappdata(0,'TT',TT);
setappdata(0,'T1',T1);
setappdata(0,'T2',T2);

setappdata(0,'Mwd',Mwd);
setappdata(0,'Mww',Mww);
setappdata(0,'Kwd',Kwd);
setappdata(0,'Kww',Kww);

setappdata(0,'TZ_tracking_array',TZ_tracking_array); 

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
if(n==5)
    data=getappdata(0,'all_stress_psd');
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
