function varargout = vibrationdata_sdof_transfer(varargin)
% VIBRATIONDATA_SDOF_TRANSFER MATLAB code for vibrationdata_sdof_transfer.fig
%      VIBRATIONDATA_SDOF_TRANSFER, by itself, creates a new VIBRATIONDATA_SDOF_TRANSFER or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SDOF_TRANSFER returns the handle to a new VIBRATIONDATA_SDOF_TRANSFER or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SDOF_TRANSFER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SDOF_TRANSFER.M with the given input arguments.
%
%      VIBRATIONDATA_SDOF_TRANSFER('Property','Value',...) creates a new VIBRATIONDATA_SDOF_TRANSFER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_sdof_transfer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_sdof_transfer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_sdof_transfer

% Last Modified by GUIDE v2.5 07-Jan-2019 13:18:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_sdof_transfer_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_sdof_transfer_OutputFcn, ...
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


% --- Executes just before vibrationdata_sdof_transfer is made visible.
function vibrationdata_sdof_transfer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_sdof_transfer (see VARARGIN)

% Choose default command line output for vibrationdata_sdof_transfer
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

%%%%%% masses %%%%%%%%%%%%
 
axes(handles.axes1);
x=[-4 -4 4 4 -4];
y=[3 6 6 3 3]-3;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

 
%%%%%% side lines %%%%%%%%%%%%
 
x=[4 6];
y=[1.5 1.5];
plot(x,y,'Color','k');
 
 
 
%%%%%% text %%%%%%%%%%%%
 
text(7,3,'x','fontsize',11);
text(0.5,6,'F','fontsize',11);
text(-0.9,1.5,'m','fontsize',11);
text(-5,-1.5,'k','fontsize',11);
text(4.5,-1.5,'c','fontsize',11);
 
%%%%%% arrows %%%%%%%%%%%%
 
headWidth = 4;
headLength = 4;
 
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[0 3 0 2]);
 
        
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[6 1.5 0 1.5]);        
        
%%%%%% spring %%%%%%%%%%%%        
 
nn=2000;
 
dt=4/(nn-1);
 
t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=sawtooth(2*pi*t,0.5);
 
t=3*t/(max(t)-min(t))+2;

plot(y-2,t+2-7,'Color',cmap(5,:),'linewidth',0.75);
 

x=[0 0];
y=[3 min(t+2)]-7;
plot(x-2,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[0 0];
y=[max(t)+2 max(t)+2.5]-7;
plot(x-2,y,'Color',cmap(5,:),'linewidth',0.75);
 
%%%%%% dashpot %%%%%%%%%%

x=[2.25 2.25];
y=[2.5 4.625]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.75 2.75];
y=[4.625 4.625]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[2.25 2.25];
y=[5 6.5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.25 3.25];
y=[5 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[1.25 1.25];
y=[4.6 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[3.25 3.25];
y=[4.6 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



%%%%%% base %%%%%%%%%%%
 
x=[-5 5];
y=[ 1 1]-5;
plot(x,y,'Color','k','linewidth',0.75);
y=[0.5 1]-5;
x=[-0.7 0];
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-4.2;
plot(x,y,'Color','k','linewidth',0.75);
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+4.2;
plot(x,y,'Color','k','linewidth',0.75);
 
 
 
%%%%%% end %%%%%%%%%%%%
 
 
hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-11.5 11.5]);
ylim([-6 7.5]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


listbox_method_Callback(hObject, eventdata, handles);

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_sdof_transfer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_sdof_transfer_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_sdof_transfer);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * ');
disp(' ');

mu=3;  % leave

n=get(handles.listbox_method,'Value');

Q=str2num(get(handles.edit_Q,'String'));
damp=1/(2*Q);


%%%

tpi=2*pi;

N_per_lbf = 4.448;
lbf_per_N=1/N_per_lbf;
 
Nm_per_lbfin=175.13;
 
kg_per_lbm=0.45351;

in_per_meter=39.3701;
meter_per_in=1/in_per_meter;


mu=get(handles.listbox_mass_unit,'Value');

ku=get(handles.listbox_stiffness_unit,'Value');


%%%

mass=str2num(get(handles.edit_mass,'String')); 

mass_orig=mass;


if(mu==1)  % convert mass to kg
        mass=mass*kg_per_lbm;
end
if(mu==2)
        mass=mass*kg_per_lbm*386;        
end  


if(n==1)
    fn=str2num(get(handles.edit_fn,'String'));
    omegan=tpi*fn;
    stiffness=mass*omegan^2;
else
   
    stiffness=str2num(get(handles.edit_stiffness,'String'));       
    
    if(ku==1)  % convert stiffness to N/m
        stiffness=stiffness*Nm_per_lbfin;
    end
    if(ku==2)
        stiffness=stiffness*Nm_per_lbfin/12;        
    end   
    if(ku==4)
        stiffness=stiffness*1000;        
    end       
   
    omegan=sqrt(stiffness/mass);
    
    fn=omegan/tpi;
    
end


%%%%%%%%%%%%

f1=str2num(get(handles.edit_f1,'String'));
f2=str2num(get(handles.edit_f2,'String'));
df=str2num(get(handles.edit_df,'String'));

numfreq=1+floor((f2-f1)/df);

%%%%

freq=zeros(numfreq,1);

admittance=zeros(numfreq,1);
mobility=zeros(numfreq,1);
accelerance=zeros(numfreq,1);

admittance_mag=zeros(numfreq,1);
mobility_mag=zeros(numfreq,1);
accelerance_mag=zeros(numfreq,1);

admittance_phase=zeros(numfreq,1);
mobility_phase=zeros(numfreq,1);
accelerance_phase=zeros(numfreq,1);

%%%%

omegan2=omegan^2;

for i=1:numfreq
    
    progressbar(i/numfreq);
    freq(i)=f1+(i-1)*df;
    omega=tpi*freq(i);
    
    den=(omegan2-omega^2)+1i*2*damp*omegan*omega;
    
     admittance(i)=1/(mass*den);
       mobility(i)=1i*omega*admittance(i);
    accelerance(i)=-omega^2*admittance(i);
    
end

if(mu<=2)

    stiffness=stiffness*lbf_per_N;
    stiffness=stiffness*meter_per_in;

    admittance=admittance*N_per_lbf;     
    admittance=admittance*in_per_meter;  % in/lbf
    
    mobility=mobility*N_per_lbf;  
    mobility=mobility*in_per_meter;    % in/sec/lbf       

    accelerance=accelerance*N_per_lbf; % (m/sec^2)/lbf 
    accelerance=accelerance/9.81;       % G/lbf      
else
    accelerance=accelerance/9.81;   % G/N
end


%%%%%%%%%%%%%%%%%%%%

N=180/pi;

for i=1:numfreq

     H=admittance(i);
     admittance_mag(i)=abs(H);
     admittance_phase(i)=N*atan2(imag(H),real(H)); 

     H=mobility(i);
     mobility_mag(i)=abs(H);
     mobility_phase(i)=N*atan2(imag(H),real(H));  

     H=accelerance(i);
     accelerance_mag(i)=abs(H);
     accelerance_phase(i)=N*atan2(imag(H),real(H));
     
end 

   dynamic_stiffness=[freq 1./admittance ];
mechanical_impedance=[freq 1./mobility ];
        dynamic_mass=[freq 1./accelerance ];

 admittance=[freq admittance ];
   mobility=[freq mobility ];
accelerance=[freq accelerance ];

setappdata(0,'admittance',admittance);
setappdata(0,'mobility',mobility);
setappdata(0,'accelerance',accelerance);

%%%%%%%%%%%%%%%%%%%%

if(mu<=2)
    Hd='(in/lbf)';
    Hv='(in/sec/lbf)';
    Ha='(G/lbf)';
    Hdd='(lbf/in)';
    Hvv='(lbf/in/sec)';
    Haa='(lbf/G)';   
else
    Hd='(m/N)';
    Hv='(m/sec/N)';
    Ha='(G/N)';   
    Hdd='(N/m)';
    Hvv='(N/m/sec)';
    Haa='(N/G)';       
end

fig_num=1;

ff=freq;
fmin=f1;
fmax=f2;

md=4;

%%%%%%%%%%%%%%%%%%%%

stiff=stiffness;

FRF_m=admittance_mag;
FRF_p=admittance_phase;

ylab=sprintf('Magnitude %s ',Hd);

if(mu==1)
    t_string=sprintf('Admittance  mass=%g lbm, stiff=%6.4g lbf/in, fn=%g Hz, Q=%g',mass_orig,stiff,fn,Q);
end 
if(mu==2)
    t_string=sprintf('Admittance  mass=%g lbf sec^2/in, fn=%g Hz, Q=%g',mass_orig,fn,Q);
end  
if(mu==3)
    t_string=sprintf('Admittance  mass=%g kg, fn=%g Hz, Q=%g',mass_orig,fn,Q);    
end

[fig_num]=...
    plot_magnitude_phase_function(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md);


%%%%%%%%%%%%%%%%%%%%

FRF_m=mobility_mag;
FRF_p=mobility_phase;

ylab=sprintf('Magnitude %s ',Hv);

if(mu==1)
    t_string=sprintf('Mobility  mass=%g lbm, stiff=%6.4g lbf/in, fn=%g Hz, Q=%g',mass_orig,stiff,fn,Q);
end 
if(mu==2)
    t_string=sprintf('Mobility  mass=%g lbf sec^2/in, fn=%g Hz, Q=%g',mass_orig,fn,Q);
end  
if(mu==3)
    t_string=sprintf('Mobility  mass=%g kg, fn=%g Hz, Q=%g',mass_orig,fn,Q);    
end

[fig_num]=...
    plot_magnitude_phase_function(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md);

%%%%%%%%%%%%%%%%%%%%

FRF_m=accelerance_mag;
FRF_p=accelerance_phase;

ylab=sprintf('Magnitude %s ',Ha);

if(mu==1)
    t_string=sprintf('Accelerance  mass=%g lbm, stiff=%6.4g lbf/in, fn=%g Hz, Q=%g',mass_orig,stiff,fn,Q);
end 
if(mu==2)
    t_string=sprintf('Accelerance  mass=%g lbf sec^2/in, fn=%g Hz, Q=%g',mass_orig,fn,Q);
end  
if(mu==3)
    t_string=sprintf('Accelerance  mass=%g kg, fn=%g Hz, Q=%g',mass_orig,fn,Q);    
end

[fig_num]=...
    plot_magnitude_phase_function(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md);

%%%%%%%%%%%%%%%%%%%%

set(handles.uipanel_save,'Visible','on');

fprintf('\n fn=%8.4g Hz ',fn);

%%%

f=freq;

[C,I]=max([f admittance_mag]);
xmax=admittance_mag(I(2));
fmax=f(I(2));

fprintf('\n Maximum Admittance:  %8.4g Hz, %8.4g %s ',fmax,xmax,Hd);

%%%%

[C,I]=max([f mobility_mag]);
xmax=mobility_mag(I(2));
fmax=f(I(2));

fprintf('\n Maximum Mobility:  %8.4g Hz, %8.4g %s \n',fmax,xmax,Hv);

%%%%

[C,I]=max([f accelerance_mag]);
xmax=accelerance_mag(I(2));
fmax=f(I(2));

fprintf('\n Maximum Accelerance:  %8.4g Hz, %8.4g %s \n\n',fmax,xmax,Ha);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hp=figure(fig_num);
fig_num=fig_num+1;

[xtt,xTT,iflag]=xtick_label(f(1),f(end));

subplot(2,3,1);
plot(admittance(:,1),abs(admittance(:,2)));
title('Admittance');
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
xlabel('Frequency (Hz)');
ylabel(sprintf('Magnitude %s ',Hd));
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
end 

subplot(2,3,2);
plot(mobility(:,1),abs(mobility(:,2)));
title('Mobility');
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
xlabel('Frequency (Hz)');
ylabel(sprintf('Magnitude %s ',Hv));
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
end 

subplot(2,3,3);
plot(accelerance(:,1),abs(accelerance(:,2)));
title('Accelerance');
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
xlabel('Frequency (Hz)');
ylabel(sprintf('Magnitude %s ',Ha));
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
end 

subplot(2,3,4);
plot(dynamic_stiffness(:,1),abs(dynamic_stiffness(:,2)));
title('Dynamic Stiffness');
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
xlabel('Frequency (Hz)');
ylabel(sprintf('Magnitude %s ',Hdd));
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
end 

subplot(2,3,5);
plot(mechanical_impedance(:,1),abs(mechanical_impedance(:,2)));
title('Mechanical Impedance');
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
xlabel('Frequency (Hz)');
ylabel(sprintf('Magnitude %s ',Hvv));
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
end 

subplot(2,3,6);
plot(dynamic_mass(:,1),abs(dynamic_mass(:,2)));
title('Dynamic Mass');
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
xlabel('Frequency (Hz)');
ylabel(sprintf('Magnitude %s ',Haa));
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
end 


if(mu==1)
    t_string=sprintf('SDOF Response  mass=%g lbm, stiff=%6.4g lbf/in, fn=%g Hz, Q=%g',mass_orig,stiff,fn,Q);
end 
if(mu==2)
    t_string=sprintf('mass=%g lbf sec^2/in, fn=%g Hz, Q=%g',mass_orig,fn,Q);
end  
if(mu==3)
    t_string=sprintf('mass=%g kg, fn=%g Hz, Q=%g',mass_orig,fn,Q);    
end

sgt=sgtitle(t_string);
sgt.FontSize = 11;

set(hp, 'Position', [0 0 1200 650]);


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



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
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

set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_method,'Value');

set(handles.uipanel_fn,'Visible','off');

set(handles.text_stiffness,'Visible','off');
set(handles.edit_stiffness,'Visible','off');
set(handles.listbox_stiffness_unit,'Visible','off');

set(handles.uipanel_mass_stiffness,'Visible','on');

if(n==1)
    set(handles.uipanel_fn,'Visible','on');
else    
    set(handles.text_stiffness,'Visible','on');
    set(handles.edit_stiffness,'Visible','on');
    set(handles.listbox_stiffness_unit,'Visible','on');
    
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


% --- Executes on selection change in listbox_mass_unit.
function listbox_mass_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mass_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mass_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mass_unit
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_mass_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mass_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_stiffness_unit.
function listbox_stiffness_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_stiffness_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_stiffness_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_stiffness_unit
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_stiffness_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_stiffness_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
    data=getappdata(0,'admittance');
end
if(n==2)
    data=getappdata(0,'mobility');
end
if(n==3)
    data=getappdata(0,'accelerance');
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 



% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_mass and none of its controls.
function edit_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_stiffness and none of its controls.
function edit_stiffness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');



function edit_f1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f1 as text
%        str2double(get(hObject,'String')) returns contents of edit_f1 as a double


% --- Executes during object creation, after setting all properties.
function edit_f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f2 as text
%        str2double(get(hObject,'String')) returns contents of edit_f2 as a double


% --- Executes during object creation, after setting all properties.
function edit_f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_df_Callback(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_df as text
%        str2double(get(hObject,'String')) returns contents of edit_df as a double


% --- Executes during object creation, after setting all properties.
function edit_df_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% --- Executes on selection change in listbox_stiffness.
function listbox_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_stiffness contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_stiffness


% --- Executes during object creation, after setting all properties.
function listbox_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
