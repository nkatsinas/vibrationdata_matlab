function varargout = vibrationdata_srs_base_triaxial(varargin)
% VIBRATIONDATA_SRS_BASE_TRIAXIAL MATLAB code for vibrationdata_srs_base_triaxial.fig
%      VIBRATIONDATA_SRS_BASE_TRIAXIAL, by itself, creates a new VIBRATIONDATA_SRS_BASE_TRIAXIAL or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SRS_BASE_TRIAXIAL returns the handle to a new VIBRATIONDATA_SRS_BASE_TRIAXIAL or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SRS_BASE_TRIAXIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SRS_BASE_TRIAXIAL.M with the given input arguments.
%
%      VIBRATIONDATA_SRS_BASE_TRIAXIAL('Property','Value',...) creates a new VIBRATIONDATA_SRS_BASE_TRIAXIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_srs_base_triaxial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_srs_base_triaxial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_srs_base_triaxial

% Last Modified by GUIDE v2.5 14-Jul-2016 14:00:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_srs_base_triaxial_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_srs_base_triaxial_OutputFcn, ...
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


% --- Executes just before vibrationdata_srs_base_triaxial is made visible.
function vibrationdata_srs_base_triaxial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_srs_base_triaxial (see VARARGIN)

% Choose default command line output for vibrationdata_srs_base_triaxial
handles.output = hObject;


set(handles.edit_Q,'String','10');

set(handles.listbox_method,'Value',1);

listbox_method_Callback(hObject, eventdata, handles); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_srs_base_triaxial wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_srs_base_triaxial_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'accel_data'); 
end
if(n==2)
    data=getappdata(0,'p_vel_data');
end
if(n==3)
    data=getappdata(0,'rel_disp_data'); 
end
if(n==4)
    adata=getappdata(0,'accel_data'); 
end
if(n==5)
    adata=getappdata(0,'p_vel_data');
end
if(n==6)
    adata=getappdata(0,'rel_disp_data'); 
end

if(n>=4 && n<=6)
    
    sz=size(adata);
    
    n=length(adata(:,1));
    
    for i=1:n
        data(i,:)=[adata(i,1) max([adata(i,2) adata(i,3)])];
    end    
end    
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_type.
function listbox_output_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_type


% --- Executes during object creation, after setting all properties.
function listbox_output_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_method,'Value');

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g %g %g',[4 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end



% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

res=get(handles.listbox_residual,'Value');


fig_num=1;

iu=get(handles.listbox_unit,'Value');

k=get(handles.listbox_method,'Value');

iflag=1;
 
if(k==1)
     try  
         FS=get(handles.edit_input_array,'String');
         THM=evalin('base',FS);  
         iflag=1;
     catch
         iflag=0; 
         warndlg('Input Array does not exist.  Try again.')
     end
else
  THM=getappdata(0,'THM');
end
 
if(iflag==0)
    return;
end 


n=length(THM(:,1));

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);
sr=1/dt;

Q=str2num(get(handles.edit_Q,'String'));

fstart=str2num(get(handles.edit_start_frequency,'String'));
  fend=str2num(get(handles.edit_plot_fmax,'String'));
  
if(fstart==0)
   fstart=0.1; 
end  

damp=1/(2*Q);

fn(1)=fstart;

fmax=sr/8;

num=1;


oct=2^(1/12);

while(1)
    
    num=num+1;
  
    fn(num)=fn(num-1)*oct;
  
    if(fn(num)>fmax)
        break;
    end
    
end

fn=fix_size(fn);

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Initialize coefficients  &  SRS engine
%

   abs_accel_data=zeros(num,3);
   abs_pv_data=zeros(num,3);
abs_rd_data=zeros(num,3);


for i=1:3

    yy=double(THM(:,i+1));
    
    [abs_accel,abs_pv,abs_rd,~,~,~]=...
                                 srs_engine_function(yy,fn,damp,dt,iu,res);                             
                             
       abs_accel_data(:,i)=abs_accel;
       abs_pv_data(:,i)=abs_pv;
    abs_rd_data(:,i)=abs_rd;
    
end

simple_env_accel=zeros(num,3);
simple_env_pv=zeros(num,3);
simple_env_rd=zeros(num,3);


for i=1:num
    simple_env_accel(i)=max(abs_accel_data(i,:));
    simple_env_pv(i)   =max(abs_pv_data(i,:));
    simple_env_rd(i)   =max(abs_rd_data(i,:));    
end

    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

nc=get(handles.listbox_columns,'Value');

if(iu==1 || iu==2)
    ylab='Accel(G)';
else
    ylab='Accel(m/sec^2)';    
end


leg4='Envelope';
leg5='Hypersphere';

if(nc==1)
    t3=sprintf('Base Input Acceleration Time Histories  X,Y,Z');    
    leg1='X';
    leg2='Y';
    leg3='Z';
end
if(nc==2)
    t3=sprintf('Base Input Acceleration Time Histories  L,R,T'); 
    leg1='L';
    leg2='R';
    leg3='T';    
end
if(nc==3)
    t3=sprintf('Base Input Acceleration Time Histories  R,L,T');
    leg1='R';
    leg2='L';
    leg3='T';    
end
if(nc==4)
    t3=sprintf('Base Input Acceleration Time Histories  NS,EW,UP');
    leg1='NS';
    leg2='EW';
    leg3='UP';    
end
if(nc==5)
    t3=sprintf('Base Input Acceleration Time Histories ');
    leg1='1';
    leg2='2';
    leg3='3';    
end

    
h=figure(fig_num);
fig_num=fig_num+1;

        subplot(3,1,1);
        plot(THM(:,1),THM(:,2));
        title(t3);
        ylabel(ylab);
        grid on;
        
        subplot(3,1,2);   
        plot(THM(:,1),THM(:,3));
        ylabel(ylab);         
        grid on;
        
        subplot(3,1,3);    
        plot(THM(:,1),THM(:,4));
        ylabel(ylab);       
        grid on;
        
        xlabel('Time (sec)');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

disp(' ');
disp(' * * * * * * ');
disp(' ');

nnn=32;

[XX,YY,ZZ]=sphere(nnn);

%%%   hypersphere accel :)

    disp('   fn     Accel    c1     c2     c3 ');

if(iu<=2)
    disp('  (Hz)     (G)                    ');
else
    disp('  (Hz)   (m/s^2)                  ');    
end

atype=1;
[fn,accel_max,cmax,CCr,iz]=hypersphere_SRS_core(nnn,fn,damp,dt,THM,XX,YY,ZZ,atype,res);



nnmm=length(THM(:,2));
uniaxial_accel_wc=zeros(nnmm,1);
uniaxial_pv_wc=zeros(nnmm,1);

uniaxial_accel_wc(:)=cmax(iz,1)*THM(:,2)+cmax(iz,2)*THM(:,3)+cmax(iz,3)*THM(:,4);

accel_hypersphere=[fn accel_max];

%%%%%

figure(fig_num)
fig_num=fig_num+1;
plot(THM(:,1),uniaxial_accel_wc);
grid on;
tt=sprintf('Worst Case Uniaxial Acceleration for Acceleration Response \n fn=%7.3g Hz Q=%g',fn(iz),Q);
title(tt);
xlabel('Time (sec)');
ylabel(ylab);
yabs=max(abs(get(gca,'ylim')));
ylim([-yabs,yabs]);

%%%%%

disp(' ');
disp(' Acceleration Worst Case');
disp(' ');

    disp('   fn     Accel    c1     c2     c3 ');

if(iu<=2)
    disp('  (Hz)     (G)                    ');
else
    disp('  (Hz)   (m/s^2)                  ');    
end

out1=sprintf('%7.3g %7.3g %7.3g %7.3g %7.3g',...
                        fn(iz),accel_max(iz),cmax(iz,1),cmax(iz,2),cmax(iz,3));
disp(out1);

%%%%%

figure(fig_num)
fig_num=fig_num+1;
sphere(nnn) 
surf(XX,YY,ZZ,CCr);

if(fn(iz)>10)
    tt=sprintf('Acceleration Hypersphere fn=%7.3g Hz Q=%g',fn(iz),Q);
else
    tt=sprintf('Acceleration Hypersphere fn=%5.3g Hz Q=%g',fn(iz),Q);    
end    
    
title(tt);
xlabel('C1');
ylabel('C2');
zlabel('C3');
colorbar;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
disp(' ');
 
% apv=abs_pv_data;
 
%%%   hypersphere pv :)
 
    disp('   fn      PV      c1     c2     c3 ');
 
if(iu<=1)
    disp('  (Hz)   (in/sec)                  ');
else
    disp('  (Hz)   (cm/sec)                  ');
        
end
 
atype=2;
[fn,pv_max,cmax,CCr,iz]=hypersphere_SRS_core(nnn,fn,damp,dt,THM,XX,YY,ZZ,atype,res); 

%
if(iu==1)
        pv_max=pv_max*386;
        CCr=CCr*386;
end
if(iu==2)
        pv_max=pv_max*9.81;
        CCr=CCr*9.81;
end
if(iu>=2)
        qqq=100;
end
if(iu>=2)
        simple_env_pv=simple_env_pv*qqq;   
        abs_pv_data=abs_pv_data*qqq;    
        pv_max=pv_max*qqq;      
        CCr=CCr*qqq;       
end    


pv_hypersphere=[fn pv_max];
 
disp(' ');
disp(' Pseudo Velocity Worst Case');
disp(' ');
 
    disp('   fn       PV      c1     c2     c3 ');
 
if(iu<=2)
    disp('  (Hz)    (in/sec)                    ');
else
    disp('  (Hz)    (cm/sec)                  ');    
end
 
out1=sprintf('%7.3g %7.3g %7.3g %7.3g %7.3g',...
                       fn(iz),pv_max(iz),cmax(iz,1),cmax(iz,2),cmax(iz,3));
disp(out1);


uniaxial_pv_wc(:)=cmax(iz,1)*THM(:,2)+cmax(iz,2)*THM(:,3)+cmax(iz,3)*THM(:,4);
 

%%%%%%%%%%%%%%%%%%

figure(fig_num)
fig_num=fig_num+1;
plot(THM(:,1),uniaxial_pv_wc);
grid on;
tt=sprintf('Worst Case Uniaxial Acceleration for Pseudo Velocity Response \n fn=%7.3g Hz Q=%g',fn(iz),Q);
title(tt);
xlabel('Time (sec)');
ylabel(ylab);
yabs=max(abs(get(gca,'ylim')));
ylim([-yabs,yabs]);
yabsa=yabs;


%%%%%%%%%%%%%%%%%%

figure(fig_num)
fig_num=fig_num+1;
sphere(nnn) 
surf(XX,YY,ZZ,CCr);
 
if(fn(iz)>10)
    tt=sprintf('Pseudo Velocity Hypersphere fn=%7.3g Hz Q=%g',fn(iz),Q);
else
    tt=sprintf('Pseudo Velocity Hypersphere fn=%5.3g Hz Q=%g',fn(iz),Q);    
end    
    
title(tt);
xlabel('C1');
ylabel('C2');
zlabel('C3');
colorbar;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
md=4;
x_label='Natural Frequency (Hz)';
 
fmin=min(fn);
fmax=max(fn);
 
fn=fix_size(fn);
 
%%% plot log5  accel
 
t_string=sprintf('Acceleration Shock Response Spectra Q=%g',Q);
 
 
if(iu<=2)
    y_label='Peak Accel (G)';
else
    y_label='Peak Accel (m/sec^2)';    
end
 
 
ppp1=[fn abs_accel_data(:,1)];
ppp2=[fn abs_accel_data(:,2)];
ppp3=[fn abs_accel_data(:,3)];
ppp4=[fn simple_env_accel];
ppp5=[fn accel_max];
 
accel_array=[fn ppp1(:,2) ppp2(:,2) ppp3(:,2) ppp4(:,2) ppp5(:,2)];
 
[fig_num,h2]=plot_loglog_function_md_five_h2(fig_num,x_label,...
                              y_label,t_string,ppp1,ppp2,ppp3,ppp4,ppp5,...
                                    leg1,leg2,leg3,leg4,leg5,fmin,fmax,md);
 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%% plot log5  pv
 
 
t_string=sprintf('Pseudo Velocity Shock Response Spectra Q=%g',Q);
 
 
if(iu==1)
    y_label='Peak PV (in/sec)';
else
    y_label='Peak PV (cm/sec)';    
end
 
    ppp1=[fn abs_pv_data(:,1)];
    ppp2=[fn abs_pv_data(:,2)];
    ppp3=[fn abs_pv_data(:,3)];
    ppp4=[fn simple_env_pv];
    ppp5=[fn pv_max];
 
pv_array=[fn ppp1(:,2) ppp2(:,2) ppp3(:,2) ppp4(:,2) ppp5(:,2)];
 
[fig_num,h2]=plot_loglog_function_md_five_h2(fig_num,x_label,...
                              y_label,t_string,ppp1,ppp2,ppp3,ppp4,ppp5,...
                                    leg1,leg2,leg3,leg4,leg5,fmin,fmax,md);
 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

if(nc==1)
    t3=sprintf('Base Input Acceleration Time Histories  X,Y,Z, \n & Worst Case Uniaxial Acceleration for Acceleration Response');    
end
if(nc==2)
    t3=sprintf('Base Input Acceleration Time Histories  L,R,T, \n & Worst Case Uniaxial Acceleration for Acceleration Response');  
end
if(nc==3)
    t3=sprintf('Base Input Acceleration Time Histories  R,L,T, \n & Worst Case Uniaxial Acceleration for Acceleration Response');  
end
if(nc==4)
    t3=sprintf('Base Input Acceleration Time Histories  NS,EW,UP, \n & Worst Case Uniaxial Acceleration for Acceleration Response'); 
end
if(nc==5)
    t3=sprintf('Base Input Acceleration Time Histories \n & Worst Case Uniaxial Acceleration for Acceleration Response');   
end

    
hp=figure(fig_num);
fig_num=fig_num+1;

        subplot(4,1,1);
        plot(THM(:,1),THM(:,2));
        title(t3);
        ylabel(ylab);
        grid on;
        ylim([-yabsa,yabsa]);
        set(gca,'ytick',[-yabsa, 0, yabsa]);       

        subplot(4,1,2);   
        plot(THM(:,1),THM(:,3));
        ylabel(ylab);         
        grid on;
        ylim([-yabsa,yabsa]);     
        set(gca,'ytick',[-yabsa, 0, yabsa]);          
        
        subplot(4,1,3);    
        plot(THM(:,1),THM(:,4));
        ylabel(ylab);       
        grid on;
        ylim([-yabsa,yabsa]);        
        set(gca,'ytick',[-yabsa, 0, yabsa]);          
        
        subplot(4,1,4);    
        plot(THM(:,1),uniaxial_accel_wc(:));
        ylabel(ylab);       
        grid on;     
        ylim([-yabsa,yabsa]);        
        set(gca,'ytick',[-yabsa, 0, yabsa]);          
        
        xlabel('Time (sec)');
        set(hp, 'Position', [0 0 650 650]);
        
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

txt4='Uniaxial';

if(nc==1)
    t3=sprintf('Base Input Acceleration Time Histories  X,Y,Z, \n & Worst Case Uniaxial Acceleration for Pseudo Velocity Response');    
    txt1 ='X';
    txt2 ='Y';
    txt3 ='Z';
end
if(nc==2)
    t3=sprintf('Base Input Acceleration Time Histories  L,R,T, \n & Worst Case Uniaxial Acceleration for Pseudo Velocity Response');  
    txt1 ='L';
    txt2 ='R';
    txt3 ='T';    
end
if(nc==3)
    t3=sprintf('Base Input Acceleration Time Histories  R,L,T, \n & Worst Case Uniaxial Acceleration for Pseudo Velocity Response');  
    txt1 ='R';
    txt2 ='L';
    txt3 ='T';    
end
if(nc==4)
    t3=sprintf('Base Input Acceleration Time Histories  NS,EW,UP, \n & Worst Case Uniaxial Acceleration for Pseudo Velocity Response'); 
    txt1 ='NS';
    txt2 ='EW';
    txt3 ='UP';    
end
if(nc==5)
    t3=sprintf('Base Input Acceleration Time Histories \n & Worst Case Uniaxial Acceleration for Pseudo Velocity Response');
    txt1 ='Axis 1';
    txt2 ='Axis 2';
    txt3 ='Axis 3';    
end


xm=max(get(gca,'xlim'));

xx=0.9*xm;
yy=0.8*yabs;

hp=figure(fig_num);
fig_num=fig_num+1;

        subplot(4,1,1);
        plot(THM(:,1),THM(:,2));
        title(t3);
        ylabel(ylab);
        grid on;
        ylim([-yabsa,yabsa]);
        set(gca,'ytick',[-yabsa, 0, yabsa]);       
        text(xx,yy,txt1,'HorizontalAlignment','right');
        
        
        subplot(4,1,2);   
        plot(THM(:,1),THM(:,3));
        ylabel(ylab);         
        grid on;
        ylim([-yabsa,yabsa]);     
        set(gca,'ytick',[-yabsa, 0, yabsa]); 
        text(xx,yy,txt2,'HorizontalAlignment','right');        
        
        subplot(4,1,3);    
        plot(THM(:,1),THM(:,4));
        ylabel(ylab);       
        grid on;
        ylim([-yabsa,yabsa]);        
        set(gca,'ytick',[-yabsa, 0, yabsa]);          
        text(xx,yy,txt3,'HorizontalAlignment','right');
        
        subplot(4,1,4);    
        plot(THM(:,1),uniaxial_pv_wc(:));
        ylabel(ylab);       
        grid on;     
        ylim([-yabsa,yabsa]);        
        set(gca,'ytick',[-yabsa, 0, yabsa]);          
        text(xx,yy,txt4,'HorizontalAlignment','right');        
        
        xlabel('Time (sec)');
        set(hp, 'Position', [0 0 650 650]);
 
        uniaxial_pv_wc=fix_size(uniaxial_pv_wc);
        uniaxial_pv_wc=[THM(:,1) uniaxial_pv_wc];
        
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


disp(' ');
 
if(iu==1)
    disp(' Units:  Hz, G, in/sec, in ');
end
if(iu==2)
    disp(' Units:  Hz, G, cm/sec, mm ');
end
if(iu==3)
    disp(' Units:  Hz, m/sec^2, cm/sec, mm ');
end
%
disp(' ');
disp(' Output arrays ');
disp('  ');
disp('  accel_hypersphere: fn accel hypersphere ');
disp('     pv_hypersphere: fn    pv hypersphere ');
disp('  ');
disp('  accel_array: fn accel1, accel2, accel3, accel envelope, accel hypersphere');
disp('     pv_array: fn    pv1,    pv2,    pv3,    pv envelope,    pv hypersphere');
disp('  ');
disp('     uniaxial_pv_wc: time(sec) worst case accel input for pv response');
disp('  ');

assignin('base', 'accel_hypersphere', accel_hypersphere);
assignin('base', 'pv_hypersphere', pv_hypersphere);
assignin('base', 'accel_array', accel_array);
assignin('base', 'pv_array', pv_array);
assignin('base', 'uniaxial_pv_wc',uniaxial_pv_wc); 
 
msgbox('Results written to Command Window');




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_srs_base)

% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


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



function edit_start_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_start_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_start_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
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



function edit_plot_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plot_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_plot_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_plot_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
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


% --- Executes on key press with focus on edit_start_frequency and none of its controls.
function edit_start_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on edit_plot_fmax and none of its controls.
function edit_plot_fmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on listbox_unit and none of its controls.
function listbox_unit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency_spacing.
function listbox_frequency_spacing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_spacing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_spacing


% --- Executes during object creation, after setting all properties.
function listbox_frequency_spacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_residual.
function listbox_residual_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_residual contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_residual


% --- Executes during object creation, after setting all properties.
function listbox_residual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_columns.
function listbox_columns_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_columns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_columns contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_columns


% --- Executes during object creation, after setting all properties.
function listbox_columns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_columns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
