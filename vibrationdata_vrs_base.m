function varargout = vibrationdata_vrs_base(varargin)
% VIBRATIONDATA_VRS_BASE MATLAB code for vibrationdata_vrs_base.fig
%      VIBRATIONDATA_VRS_BASE, by itself, creates a new VIBRATIONDATA_VRS_BASE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_VRS_BASE returns the handle to a new VIBRATIONDATA_VRS_BASE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_VRS_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_VRS_BASE.M with the given input arguments.
%
%      VIBRATIONDATA_VRS_BASE('Property','Value',...) creates a new VIBRATIONDATA_VRS_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_vrs_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_vrs_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_vrs_base

% Last Modified by GUIDE v2.5 25-Jan-2021 13:11:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_vrs_base_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_vrs_base_OutputFcn, ...
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


% --- Executes just before vibrationdata_vrs_base is made visible.
function vibrationdata_vrs_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_vrs_base (see VARARGIN)

% Choose default command line output for vibrationdata_vrs_base
handles.output = hObject;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cmap(1,:)=[0 0.1 0.4];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];      % gold
cmap(16,:)=[0 0.8 0.8];     % turquoise   
 
%%%%% axes 1 %%%%%%%%%%%%
 
%%%%%% masses %%%%%%%%%%%%
 
clc; 
axes(handles.axes1);

x=[-5.5 -5.5 5.5 5.5 -5.5];
y=[5.5 6 6 5.5 5.5]-3;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

x=[-4 -4 4 4 -4]; 
y=[3 6 6 3 3]+3.5;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
 
%%%%%% side lines %%%%%%%%%%%%
 
x=[5.5 7.5];
y=[1.5 1.5]+1.25;
plot(x,y,'Color','k');
 
 
x=[4 7.5];
y=[8 8];
plot(x,y,'Color','k');
 
%%%%%% text %%%%%%%%%%%%
 
% text(7,10,'${\ddot{X}}$','Interpreter','latex');

text(8.32,5.2,'..','fontsize',13);
text(8.5,4.5,'y','fontsize',11);

text(8.32,10.7,'..','fontsize',13);
text(8.5,10,'x','fontsize',11);

 
text(-0.9,8,'m','fontsize',11);

text(-5,5.2,'k','fontsize',11);

text(4.5,5.3,'c','fontsize',11);
 
%%%%%% arrows %%%%%%%%%%%%
 
headWidth = 4;
headLength = 4;
 
       
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[7.5 2.75 0 1.5]);        
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[7.5 8 0 1.5]);        
        
 
        
%%%%%% spring %%%%%%%%%%%%        
 
nn=2000;
 
dt=4/(nn-1);
 
t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=sawtooth(2*pi*t,0.5);
 
t=2.5*t/(max(t)-min(t))+2;
 
plot(y-2,t+2,'Color',cmap(5,:),'linewidth',0.75);

x=[-2 -2];
y=[3 min(t+2)];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
 
x=[-2 -2];
y=[max(t)+2 max(t)+2.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 

%%%%%% dashpot %%%%%%%%%%

x=[2.25 2.25];
y=[3 4.625];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.75 2.75];
y=[4.625 4.625];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[2.25 2.25];
y=[5 6.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.25 3.25];
y=[5 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[1.25 1.25];
y=[4.6 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[3.25 3.25];
y=[4.6 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 

%%%%%% end %%%%%%%%%%%%
 
hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-10 12]);
ylim([0 13]);
 
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




set(handles.edit_Q,'String','10');

set(handles.listbox_method,'Value',1);

set(handles.listbox_output_amp,'value',1);
set(handles.listbox_sigma,'value',1);
set(handles.listbox_unit,'value',1);
set(handles.listbox_calculate,'value',1);
set(handles.listbox_FDS_type,'value',1);



set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off')

listbox_method_Callback(hObject, eventdata, handles);
listbox_calculate_Callback(hObject, eventdata, handles);
set(handles.pushbutton_calculate,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_vrs_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_vrs_base_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_vrs_base);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end 

disp(' ');
disp(' * * * * * * * * * * * ');
disp(' ');

nfds=get(handles.listbox_calculate,'value');

idc=2;
bex=0;

if(nfds==2)
    bex=str2num(get(handles.edit_fatigue_exponent,'String'));
    
    if(isempty(bex))
        warndlg('Enter fatigue exponent');
        return;
    end
    
    idc=1;
end    

irp=get(handles.listbox_FDS_type,'value');

k=get(handles.listbox_method,'Value');

try

    if(k==1)
        FS=strtrim(get(handles.edit_input_array,'String'));
        THM=evalin('base',FS);   
    else
        THM=getappdata(0,'THM');
    end

catch
    
    warndlg('Input Filename Error');
    
    return;
    
end

if(THM(:,1)<1.0e-20)
    THM(1,:)=[];
end

n=length(THM(:,1));

spec_minf=THM(1,1);
spec_maxf=THM(n,1);

sminf=get(handles.edit_fmin,'String');
smaxf=get(handles.edit_fmax,'String');
sdur=get(handles.edit_dur,'String');

if isempty(sminf)
    string=sprintf('%8.4g',THM(1,1));
    set(handles.edit_fmin,'String',string);
end

if isempty(smaxf)
    string=sprintf('%8.4g',THM(n,1));    
    set(handles.edit_fmax,'String',string);
end

if isempty(sdur)
    set(handles.edit_dur,'String','60');    
end    

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));
dur=str2num(get(handles.edit_dur,'String'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=get(handles.listbox_method,'Value');

set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save,'Enable','on')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q=str2num(get(handles.edit_Q,'String'));

damp=1/(2*Q);

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=THM(:,1);
a=THM(:,2);

[s,rms]=calculate_PSD_slopes(f,a);


ispace=get(handles.listbox_fn,'Value');

df=0.5;
[fi,ai]=interpolate_PSD(f,a,s,df);

if(ispace==1)
    fn=fi;
end
if(ispace>=2)
    if(ispace==2)
        oct=1/3;
    end
    if(ispace==3)
        oct=1/6;        
    end    
    if(ispace==4)
        oct=1/12;        
    end
    if(ispace==5)
        oct=1/24;        
    end
    
    fn(1)=fi(1);
    f2=fi(end);
    j=2;

    while(1)
        fn(j)=fn(j-1)*2^(oct);
        if(fn(j)>f2)
            fn(j)=f2;
            break;
        end
        j=j+1;
    end    
    
end

p=get(handles.listbox_unit,'Value');

iu=p;

% [fn,a_vrs,rd_vrs]=vrs_engine_f(fi,ai,damp,df);
         
[fn,a_vrs,pv_vrs,rd_vrs,damage]=...
             vibrationdata_fds_vrs_engine_fn(fi,ai,damp,df,iu,idc,irp,bex,dur,fn);         
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn=fix_size(fn);
a_vrs=fix_size(a_vrs);
pv_vrs=fix_size(pv_vrs);
rd_vrs=fix_size(rd_vrs);
damage=fix_size(damage);

j=1;
 
clear length;

L=length(fn);

for i=1:L
%    
    if(fn(i)>=spec_minf && fn(i)<=spec_maxf)
%
        ax=0.5;
        [ms]=risk_overshoot(fn(i),dur,ax);
%
        accel_vrs_peak(j,:)=[fn(i)  ms*a_vrs(i)];
           pv_vrs_peak(j,:)=[fn(i) ms*pv_vrs(i)];        
           rd_vrs_peak(j,:)=[fn(i) ms*rd_vrs(i)];
           j=j+1;
    end   
%       
end

fig_num=1;
power_spectral_density=[f a];
xlab='Frequency (Hz)';
if(p<=1)
    ylab='Accel (G^2/Hz)';
    YS='G';
else
    ylab='Accel ((m/sec^2)^2/Hz)';
    YS='(m/sec^2)^2';
end


t_string=...
    sprintf(' Power Spectral Density  Overall Level = %6.3g %sRMS ',rms,YS); 
    [fig_num,h]=plot_PSD_function(fig_num,xlab,ylab,t_string,power_spectral_density,fmin,fmax);
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
accel_vrs_1_sigma=[fn a_vrs];
accel_vrs_3_sigma=[fn 3*a_vrs];

   pv_vrs_1_sigma=[fn pv_vrs];
   pv_vrs_3_sigma=[fn 3*pv_vrs];
   
   rd_vrs_1_sigma=[fn rd_vrs];
   rd_vrs_3_sigma=[fn 3*rd_vrs];
              fds=[fn damage];


%%%%%%%%%%%%%%%%%%%%

ppp1=accel_vrs_peak;
ppp2=[fn 3*a_vrs];
ppp3=[fn   a_vrs];
data1=[ accel_vrs_peak(:,2),3*a_vrs,a_vrs];

leg1='peak';
leg2='3-sigma';
leg3='1-sigma';

x_label='Natural Frequency (Hz)';
if(p<=2)
    y_label='Accel (G)';
else
    y_label='Accel ((m/sec^2))';    
end

t_string = sprintf(' Acceleration Vibration Response Spectrum Q=%g ',Q);

md=6;

[fig_num]=plot_loglog_function_md_three(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%


nss=length( accel_vrs_peak(:,1) );

fffmin=accel_vrs_peak(1,1);
fffmax=accel_vrs_peak(nss,1);

[~,n1] = min(abs(fn-fffmin));
[~,n2] = min(abs(fn-fffmax));

vrs_set=[accel_vrs_peak(:,1)  a_vrs(n1:n2,1)  3*a_vrs(n1:n2,1)   accel_vrs_peak(:,2) ];


if(k==1)
    output_name=sprintf('%s_avrs_set_%g',FS,Q);
else
    output_name=sprintf('avrs_set_%g',Q);   
end
    
output_name = strrep(output_name,'.','p');
output_name = output_name(~isspace(output_name));

out1=sprintf('\n nss=%d   %s\n',nss,output_name);
disp(out1);

assignin('base', output_name, vrs_set);
output_name_txt=sprintf('%s.txt',output_name);
save(output_name_txt,'vrs_set','-ASCII')

out1=sprintf('\n Acceleration VRS written to: %s \n',output_name_txt);
disp(out1);
disp('  Four columns:  fn(Hz)  GRMS  3-sigma(G)  Peak(G) ');
disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

md=6;

ppp1=pv_vrs_peak;
ppp2=[fn 3*pv_vrs];
ppp3=[fn   pv_vrs];
data2=[ pv_vrs_peak(:,2),3*pv_vrs,pv_vrs];

leg1='peak';
leg2='3-sigma';
leg3='1-sigma';

[C,I]=max(pv_vrs_peak(:,2));
if(p<=1)
    ylab='PV (in/sec)';
    out1=sprintf(' Maximum Peak PV = %7.3g in/sec at %8.4g Hz',C,pv_vrs_peak(I,1));
else
    ylab='PV (m/sec)';    
    out1=sprintf(' Maximum Peak PV = %7.3g m/sec at %8.4g Hz',C,fn(I));
end           
disp(out1);      

y_label=ylab;
x_label='Natural Frequency (Hz)';
t_string = sprintf(' Pseudo Velocity Vibration Response Spectrum Q=%g ',Q);

[fig_num]=plot_loglog_function_md_three(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

md=6;

ppp1=rd_vrs_peak;
ppp2=[fn 3*rd_vrs];
ppp3=[fn   rd_vrs];
data3=[ rd_vrs_peak(:,2),3*rd_vrs,rd_vrs];

leg1='peak';
leg2='3-sigma';
leg3='1-sigma';

if(p<=1)
    ylab='Rel Disp (in)';
else
    ylab='Rel Disp (mm)';    
end
y_label=ylab;
x_label='Natural Frequency (Hz)';

t_string = sprintf(' Relative Displacement Vibration Response Spectrum Q=%g ',Q);

[fig_num]=plot_loglog_function_md_three(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
  
if(iu==1)
   [fig_num]=subplots_vrs_set(fig_num,fn,data1,data2,data3,Q,fmin,fmax); 
end
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(idc==1)
%
    disp(' ');
    disp(' The fatigue damage spectrum is (peak-valley)/2 ');
    if(irp==1)
       nmetric=1;
    end
    if(irp==2)
       nmetric=2;  
    end
    if(irp==3)
       nmetric=4;
    end
%

    x_label='Natural Frequency (Hz)';
    ppp=[fn damage];
    
    [fig_num]=plot_fds_function(fig_num,x_label,ppp,fmin,fmax,nmetric,Q,bex);

%     
    set(handles.edit_output_array_fds,'enable','on')
    set(handles.pushbutton_save_FDS,'enable','on')
%
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'accel_vrs_1_sigma',accel_vrs_1_sigma);
setappdata(0,'accel_vrs_3_sigma',accel_vrs_3_sigma);
setappdata(0,'accel_vrs_peak',accel_vrs_peak);

setappdata(0,'pv_vrs_1_sigma',pv_vrs_1_sigma);
setappdata(0,'pv_vrs_3_sigma',pv_vrs_3_sigma);
setappdata(0,'pv_vrs_peak',pv_vrs_peak);

setappdata(0,'rd_vrs_1_sigma',rd_vrs_1_sigma);
setappdata(0,'rd_vrs_3_sigma',rd_vrs_3_sigma);
setappdata(0,'rd_vrs_peak',rd_vrs_peak);


setappdata(0,'fds',fds);



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_amp,'value');
m=get(handles.listbox_sigma,'value');


if(n==1)
    if(m==1)
        data=getappdata(0,'accel_vrs_1_sigma');
    end
    if(m==2)
        data=getappdata(0,'accel_vrs_3_sigma');
    end
    if(m==3)
        data=getappdata(0,'accel_vrs_peak');
    end 
end    
if(n==2)
    if(m==1)
        data=getappdata(0,'pv_vrs_1_sigma');
    end
    if(m==2)
        data=getappdata(0,'pv_vrs_3_sigma');
    end
    if(m==3)
        data=getappdata(0,'pv_vrs_peak');
    end 
end 
if(n==3)
    if(m==1)
        data=getappdata(0,'rd_vrs_1_sigma');
    end
    if(m==2)
        data=getappdata(0,'rd_vrs_3_sigma');
    end
    if(m==3)
        data=getappdata(0,'rd_vrs_peak');
    end    
end

output_name=strtrim(get(handles.edit_output_array,'String'));
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

%%% set(handles.pushbutton_calculate,'Enable','off');

n=get(handles.listbox_method,'Value');


set(handles.edit_output_array,'Enable','off');

set(handles.pushbutton_save,'Enable','off');

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
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
   
   set(handles.pushbutton_calculate,'Enable','on');
end

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



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
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



function edit_dur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur as text
%        str2double(get(hObject,'String')) returns contents of edit_dur as a double


% --- Executes during object creation, after setting all properties.
function edit_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_sigma.
function listbox_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_sigma contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_sigma


% --- Executes during object creation, after setting all properties.
function listbox_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_amp.
function listbox_output_amp_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_amp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_amp


% --- Executes during object creation, after setting all properties.
function listbox_output_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_VRS.
function pushbutton_VRS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_VRS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_calculate.
function listbox_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_calculate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_calculate


set(handles.edit_output_array_fds,'enable','off')
set(handles.pushbutton_save_FDS,'enable','off')

n=get(handles.listbox_calculate,'value');

if(n==1)
    set(handles.text_fatigue_exponent,'visible','off');
    set(handles.edit_fatigue_exponent,'visible','off');
    set(handles.text_fatigue_type,'visible','off');
    set(handles.listbox_FDS_type,'visible','off');    
    set(handles.uipanel_FDS,'visible','off');
else
    set(handles.text_fatigue_exponent,'visible','on');
    set(handles.edit_fatigue_exponent,'visible','on');  
    set(handles.text_fatigue_type,'visible','on');
    set(handles.listbox_FDS_type,'visible','on');     
    set(handles.uipanel_FDS,'visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fatigue_exponent_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fatigue_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fatigue_exponent as text
%        str2double(get(hObject,'String')) returns contents of edit_fatigue_exponent as a double


% --- Executes during object creation, after setting all properties.
function edit_fatigue_exponent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fatigue_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_FDS_type.
function listbox_FDS_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_FDS_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_FDS_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_FDS_type


% --- Executes during object creation, after setting all properties.
function listbox_FDS_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_FDS_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_FDS.
function pushbutton_save_FDS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_FDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'fds');
output_name=strtrim(get(handles.edit_output_array_fds,'String'));
assignin('base', output_name, data);
 
h = msgbox('Save Complete'); 


function edit_output_array_fds_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_fds as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_fds as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_fds_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_fn.
function listbox_fn_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fn contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fn


% --- Executes during object creation, after setting all properties.
function listbox_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
