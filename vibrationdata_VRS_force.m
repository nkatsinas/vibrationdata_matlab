function varargout = vibrationdata_VRS_force(varargin)
% VIBRATIONDATA_VRS_FORCE MATLAB code for vibrationdata_VRS_force.fig
%      VIBRATIONDATA_VRS_FORCE, by itself, creates a new VIBRATIONDATA_VRS_FORCE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_VRS_FORCE returns the handle to a new VIBRATIONDATA_VRS_FORCE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_VRS_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_VRS_FORCE.M with the given input arguments.
%
%      VIBRATIONDATA_VRS_FORCE('Property','Value',...) creates a new VIBRATIONDATA_VRS_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_VRS_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_VRS_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_VRS_force

% Last Modified by GUIDE v2.5 04-Aug-2014 09:39:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_VRS_force_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_VRS_force_OutputFcn, ...
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


% --- Executes just before vibrationdata_VRS_force is made visible.
function vibrationdata_VRS_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_VRS_force (see VARARGIN)

% Choose default command line output for vibrationdata_VRS_force
handles.output = hObject;


set(handles.edit_Q,'String','10');

set(handles.listbox_method,'Value',1);

set(handles.listbox_save,'value',1);
set(handles.listbox_sigma,'value',1);
set(handles.listbox_unit,'value',1);
set(handles.listbox_FDS_type,'value',1);

set(handles.pushbutton_calculate,'Enable','on');

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');


listbox_calculate_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_VRS_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_VRS_force_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_VRS_force);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    


nfds=get(handles.listbox_calculate,'value');

idc=2;
bex=0;

if(nfds==2)
    bex=str2num(get(handles.edit_fatigue_exponent,'String'));
    idc=1;
end    

irp=get(handles.listbox_FDS_type,'value');
tpi=2*pi;

k=get(handles.listbox_method,'Value');

try

    if(k==1)
        FS=get(handles.edit_input_array,'String');
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

k=get(handles.listbox_method,'Value');

set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save,'Enable','on');
set(handles.listbox_sigma,'Enable','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,input_rms] = calculate_PSD_slopes(THM(:,1),THM(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q=str2num(get(handles.edit_Q,'String'));

damp=1/(2*Q);

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=THM(:,1);
a=THM(:,2);

[s,rms]=calculate_PSD_slopes(f,a);
%

p=get(handles.listbox_unit,'Value');
iu=p;

masss=get(handles.edit_mass,'String');

if isempty(masss)
    warndlg('Enter Mass');
    return;
else
    mass=str2num(masss);    
end
mass_orig=mass;

if(p==1)
    mass=mass/386;
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f1=fmin;
f2=fmax;

ocn=1./24.;
%
fi(1)=f1;
%
j=2;
while(1)
    fi(j)=fi(j-1)*2^(ocn);
    if(fi(j)>f2)
        fi(j)=f2;
        break;
    end
    j=j+1;
end
fn=fi;
%

n_ref=length(fi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
[ai]=interp_psd_oct(f,a,fi);
%
%
omega=zeros(n_ref,1);
omega2=zeros(n_ref,1);
omegan=zeros(n_ref,1);
omegan2=zeros(n_ref,1);
stiffness=zeros(n_ref,1);
%
for j=1:n_ref
%    
    omega(j)=tpi*fi(j);
    omega2(j)=omega(j)^2;
%
    omegan(j)=tpi*fn(j);
    omegan2(j)=omegan(j)^2;
%
    stiffness(j)=omegan2(j)*mass;
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

drms=zeros(n_ref,1);
vrms=zeros(n_ref,1);
grms=zeros(n_ref,1);
FT_rms=zeros(n_ref,1);
damage=zeros(n_ref,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%


progressbar;

for ijk=1:n_ref
%    
    progressbar(ijk/n_ref);
%
    dpsd=zeros(n_ref,1);
    vpsd=zeros(n_ref,1);
    apsd=zeros(n_ref,1);
    FT_psd=zeros(n_ref,1);
%
%
%      Transmitted Force
%
    for j=1:n_ref
%
        rho=fi(j)/fn(ijk);
        num= 1.+(2*damp*rho)^2;
        den= (1-rho^2)^2 + (2*damp*rho)^2;
        t= num/den;
        FT_psd(j)=( t*ai(j) );
%
    end
    [FT_m0,FT_rms_ind]=cm0(FT_psd,fi,n_ref);
    FT_rms(ijk)=FT_rms_ind;
%    
%      Absolute Displacement
%
    for j=1:n_ref
%        
        num=( (omegan2(ijk)/stiffness(ijk))^2 );
        den=( (omegan2(ijk)-omega2(j))^2) + ( (2*damp*omega(j)*omegan(ijk))^2);
        t= num/den;
        dpsd(j)=( t*ai(j) );
%
    end
    if(p==2 || p==3)
        dpsd=dpsd*1000^2;
    end
    [m0,rms]=cm0(dpsd,fi,n_ref);
    drms(ijk)=rms;
%
%      Velocity
%
    for j=1:n_ref
%     
        num=( (omega(j)*omegan2(ijk)/stiffness(ijk))^2 );
        den=( (omegan2(ijk)-omega2(j))^2) + ( (2*damp*omega(j)*omegan(ijk))^2);
        t= num/den;
        vpsd(j)=( t*ai(j) );
%
    end
    [m0,rms]=cm0(vpsd,fi,n_ref);
    vrms(ijk)=rms;
%
%      Acceleration
%
    for j=1:n_ref
%
        num=( (omega2(j)*omegan2(ijk)/stiffness(ijk))^2 );
        den=( (omegan2(ijk)-omega2(j))^2) + ( (2*damp*omega(j)*omegan(ijk))^2);
        t= num/den;
        apsd(j)=( t*ai(j) );
%
    end
    if(p==1)
         apsd=apsd/(386^2);
    end
    if(p==2)
         apsd=apsd/(9.81^2);       
    end

    [m0,rms]=cm0(apsd,fi,n_ref);
    grms(ijk)=rms;
%   
%
    if(idc==1)  % calculate fds
%
            fi=fix_size(fi);
%
            if(irp==1)  % accel
                THF=[fi apsd];
            end
            if(irp==2)  % v
                THF=[fi vpsd];
            end   
            if(irp==3)  % d
                THF=[fi dpsd];
            end 
            if(irp==4)  % tf
                THF=[fi FT_psd];
            end    
%            
            [ddd]=Dirlik_fds_oct(THF,bex,ocn,dur);
            damage(ijk)=ddd;           
    end
%
%
end
%
pause(0.5);
progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn=fix_size(fn);
grms=fix_size(grms);
vrms=fix_size(vrms);
drms=fix_size(drms);
FT_rms=fix_size(FT_rms);


for i=1:length(fn)

              accel_vrs_1_sigma(i,:)=[fn(i)  grms(i)];
                vel_vrs_1_sigma(i,:)=[fn(i)  vrms(i)];
               disp_vrs_1_sigma(i,:)=[fn(i)  drms(i)];
        trans_force_vrs_1_sigma(i,:)=[fn(i)  FT_rms(i)];


              accel_vrs_3_sigma(i,:)=[fn(i)  3*grms(i)];
                vel_vrs_3_sigma(i,:)=[fn(i)  3*vrms(i)];
               disp_vrs_3_sigma(i,:)=[fn(i)  3*drms(i)];
        trans_force_vrs_3_sigma(i,:)=[fn(i)  3*FT_rms(i)];        
end        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear length;
for i=1:length(fn)
%    
    if(fn(i)>=spec_minf && fn(i)<=spec_maxf)
%
        ax=0.5;
        [ms]=risk_overshoot(fn(i),dur,ax);
%
              accel_vrs_peak(j,:)=[fn(i)  ms*grms(i)];
                vel_vrs_peak(j,:)=[fn(i)  ms*vrms(i)];
               disp_vrs_peak(j,:)=[fn(i)  ms*drms(i)];
        trans_force_vrs_peak(j,:)=[fn(i)  ms*FT_rms(i)];
        
           j=j+1;
    end   
%       
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fig_num=1;

if(p==1)
    yys='Force (lbf^2/Hz)';
    t_string=sprintf(' Input Force PSD  %8.4g lbf RMS',input_rms);
   
else
    yys='Force (N^2/Hz)'; 
    t_string=sprintf(' Input Force PSD  %8.4g N RMS',input_rms);     
end

fi=fix_size(fi);
ai=fix_size(ai);

md=6;
ppp=[fi ai];
x_label='Frequency (Hz)';
y_label=yys;
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=fig_num+1;
figure(fig_num);
plot(accel_vrs_peak(:,1),accel_vrs_peak(:,2),fn,3*grms,fn,grms);
legend('peak','3-sigma','1-sigma');
xlabel('Natural Frequency (Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');

if(p==1)
    ylabel('Accel (G)');
end
if(p==2)   
    ylabel('Accel (G)');
end
if(p==3)
    ylabel('Accel (m/sec^2)');
end

if(p==1)
    out1=sprintf('Acceleration VRS, mass=%g lbm, Q=%g ',mass_orig,Q);
else
    out1=sprintf('Acceleration VRS, mass=%g kg, Q=%g ',mass_orig,Q);       
end

title(out1);
xlim([fmin fmax]);

    if(round(fmin)==20 && round(fmax)==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
    end
    if(round(fmin)==10 && round(fmax)==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
    end

%
w=10000;
ymax= 10^ceil(log10(max(accel_vrs_peak(:,2))));
ymin= 10^floor(log10(min(grms)));
if(ymin<ymax/w)
    ymin=ymax/w;
end
ylim([ymin,ymax]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=fig_num+1;
figure(fig_num);
plot(vel_vrs_peak(:,1),vel_vrs_peak(:,2),fn,3*vrms,fn,vrms);
legend('peak','3-sigma','1-sigma');
xlabel('Natural Frequency (Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');

if(p==1)
    ylabel('Vel (in/sec)');
end
if(p==2)   
    ylabel('Vel (m/sec)');
end
if(p==3)
    ylabel('Vel (m/sec)');
end

if(p==1)
    out1=sprintf('Velocity VRS, mass=%g lbm, Q=%g ',mass_orig,Q);
else
    out1=sprintf('Velocity VRS, mass=%g kg, Q=%g ',mass_orig,Q);       
end

title(out1);
xlim([fmin fmax]);

    if(round(fmin)==20 && round(fmax)==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
    end
    if(round(fmin)==10 && round(fmax)==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
    end

%
w=10000;
ymax= 10^ceil(log10(max(vel_vrs_peak(:,2))));
ymin= 10^floor(log10(min(vrms)));
if(ymin<ymax/w)
    ymin=ymax/w;
end
ylim([ymin,ymax]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=fig_num+1;
figure(fig_num);
plot(disp_vrs_peak(:,1),disp_vrs_peak(:,2),fn,3*drms,fn,drms);
legend('peak','3-sigma','1-sigma');
xlabel('Natural Frequency (Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');

if(p==1)
    ylabel('Disp (in)');
end
if(p==2)   
    ylabel('Disp (mm)');
end
if(p==3)
    ylabel('Disp (mm)');
end

if(p==1)
    out1=sprintf('Displacement VRS, mass=%g lbm, Q=%g ',mass_orig,Q);
else
    out1=sprintf('Displacement VRS, mass=%g kg, Q=%g ',mass_orig,Q);       
end

title(out1);
xlim([fmin fmax]);

    if(round(fmin)==20 && round(fmax)==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
    end
    if(round(fmin)==10 && round(fmax)==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
    end

w=10000;
ymax= 10^ceil(log10(max(disp_vrs_peak(:,2))));
ymin= 10^floor(log10(min(drms)));
if(ymin<ymax/w)
    ymin=ymax/w;
end
ylim([ymin,ymax]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=fig_num+1;
figure(fig_num);
plot(trans_force_vrs_peak(:,1),trans_force_vrs_peak(:,2),fn,3*FT_rms,fn,FT_rms);
legend('peak','3-sigma','1-sigma');
xlabel('Natural Frequency (Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');

if(p==1)
    ylabel('Force (lbf)');
end
if(p==2)   
    ylabel('Force (N)');
end
if(p==3)
    ylabel('Force (N)');
end

if(p==1)
    out1=sprintf('Transmitted Force VRS, mass=%g lbm, Q=%g ',mass_orig,Q);
else
    out1=sprintf('Transmitted Force VRS, mass=%g kg, Q=%g ',mass_orig,Q);       
end

title(out1);
xlim([fmin fmax]);

    if(round(fmin)==20 && round(fmax)==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
    end
    if(round(fmin)==10 && round(fmax)==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
    end

w=10000;
ymax= 10^ceil(log10(max(trans_force_vrs_peak(:,2))));
ymin= 10^floor(log10(min(FT_rms)));
if(ymin<ymax/w)
    ymin=ymax/w;
end
ylim([ymin,ymax]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(idc==1)
%
    disp(' ');
    disp(' The fatigue damage spectrum is (peak-valley)/2 ');
    if(irp==1)
       if(iu==1) 
            out1 = sprintf(' Acceleration FDS mass=%g lbm Q=%g b=%g',mass_orig,Q,bex);
       else
            out1 = sprintf(' Acceleration FDS mass=%g kg Q=%g b=%g',mass_orig,Q,bex);           
       end    
       if(iu<=2)
            ylab=sprintf('Damage Index (G^{ %g })',bex);
       else
            ylab=sprintf('Damage Index ((m/sec^2)^{ %g })',bex);           
       end
    end
    if(irp==2)
       if(iu==1) 
            out1 = sprintf(' Velocity FDS mass=%g lbm Q=%g b=%g',mass_orig,Q,bex);
            ylab=sprintf('Damage Index (ips^{ %g })',bex);             
       else
            out1 = sprintf(' Velocity FDS mass=%g kg Q=%g b=%g',mass_orig,Q,bex);           
            ylab=sprintf('Damage Index ((m/sec)^{ %g })',bex);         
       end    
    end
    if(irp==3)
       if(iu==1)  
            out1 = sprintf(' Displacement FDS mass=%g lbm Q=%g b=%g',mass_orig,Q,bex); 
            ylab=sprintf('Damage Index (in^{ %g })',bex);
       else
            out1 = sprintf(' Displacement FDS mass=%g kg Q=%g b=%g',mass_orig,Q,bex); 
            ylab=sprintf('Damage Index (mm^{ %g })',bex);            
       end    
    end
    if(irp==4)
       if(iu==1)  
            out1 = sprintf(' Transmitted FDS Q=%g b=%g',Q,bex); 
            ylab=sprintf('Damage Index (lbf^{ %g })',bex);
       else
            out1 = sprintf(' Transmitted FDS Q=%g b=%g',Q,bex); 
            ylab=sprintf('Damage Index (N^{ %g })',bex);            
       end    
    end    
%
    fig_num=fig_num+1;
    figure(fig_num);
    plot(fi,damage);
    fds=[fi damage];
    setappdata(0,'fds',fds);
    xlabel('Natural Frequency (Hz)');
    grid on;
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
    title(out1);
    xlim([fmin fmax])
    ylabel(ylab);
%
    if(round(fmin)==20 && round(fmax)==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
    end
    if(round(fmin)==10 && round(fmax)==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
    end
%     
    set(handles.edit_output_array_fds,'enable','on')
    set(handles.pushbutton_save_FDS,'enable','on')
%
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'accel_vrs_1_sigma',accel_vrs_1_sigma);
setappdata(0,'accel_vrs_3_sigma',accel_vrs_3_sigma);
setappdata(0,'accel_vrs_peak',accel_vrs_peak);

setappdata(0,'vel_vrs_1_sigma',vel_vrs_1_sigma);
setappdata(0,'vel_vrs_3_sigma',vel_vrs_3_sigma);
setappdata(0,'vel_vrs_peak',vel_vrs_peak);

setappdata(0,'disp_vrs_1_sigma',disp_vrs_1_sigma);
setappdata(0,'disp_vrs_3_sigma',disp_vrs_3_sigma);
setappdata(0,'disp_vrs_peak',disp_vrs_peak);

setappdata(0,'trans_force_vrs_1_sigma',trans_force_vrs_1_sigma);
setappdata(0,'trans_force_vrs_3_sigma',trans_force_vrs_3_sigma);
setappdata(0,'trans_force_vrs_peak',trans_force_vrs_peak);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


n=get(hObject,'Value');

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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'value');
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
        data=getappdata(0,'vel_vrs_1_sigma');        
    end
    if(m==2)
        data=getappdata(0,'vel_vrs_3_sigma');
    end
    if(m==3)
        data=getappdata(0,'vel_vrs_peak'); 
    end    
end
if(n==3)
    if(m==1)
        data=getappdata(0,'disp_vrs_1_sigma');
    end
    if(m==2)
        data=getappdata(0,'disp_vrs_3_sigma');
    end
    if(m==3)
        data=getappdata(0,'disp_vrs_peak');
    end    
end
if(n==4)
    if(m==1)
        data=getappdata(0,'trans_force_vrs_1_sigma');
    end
    if(m==2)
        data=getappdata(0,'trans_force_vrs_3_sigma');
    end
    if(m==3)
        data=getappdata(0,'trans_force_vrs_peak');
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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


p=get(handles.listbox_unit,'Value');

if(p==1)
    set(handles.text_mass_label,'String','Mass (lbm)');
else
    set(handles.text_mass_label,'String','Mass (kg)');    
end



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
output_name=get(handles.edit_output_array_fds,'String');
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
