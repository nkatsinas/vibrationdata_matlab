function varargout = SEA_two_connected_cylindrical_shells_hs(varargin)
% SEA_TWO_CONNECTED_CYLINDRICAL_SHELLS_HS MATLAB code for SEA_two_connected_cylindrical_shells_hs.fig
%      SEA_TWO_CONNECTED_CYLINDRICAL_SHELLS_HS, by itself, creates a new SEA_TWO_CONNECTED_CYLINDRICAL_SHELLS_HS or raises the existing
%      singleton*.
%
%      H = SEA_TWO_CONNECTED_CYLINDRICAL_SHELLS_HS returns the handle to a new SEA_TWO_CONNECTED_CYLINDRICAL_SHELLS_HS or the handle to
%      the existing singleton*.
%
%      SEA_TWO_CONNECTED_CYLINDRICAL_SHELLS_HS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_TWO_CONNECTED_CYLINDRICAL_SHELLS_HS.M with the given input arguments.
%
%      SEA_TWO_CONNECTED_CYLINDRICAL_SHELLS_HS('Property','Value',...) creates a new SEA_TWO_CONNECTED_CYLINDRICAL_SHELLS_HS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_two_connected_cylindrical_shells_hs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_two_connected_cylindrical_shells_hs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_two_connected_cylindrical_shells_hs

% Last Modified by GUIDE v2.5 15-Jun-2018 16:44:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_two_connected_cylindrical_shells_hs_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_two_connected_cylindrical_shells_hs_OutputFcn, ...
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


% --- Executes just before SEA_two_connected_cylindrical_shells_hs is made visible.
function SEA_two_connected_cylindrical_shells_hs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_two_connected_cylindrical_shells_hs (see VARARGIN)

% Choose default command line output for SEA_two_connected_cylindrical_shells_hs
handles.output = hObject;

clc;

fstr='tcss_a_sm.jpg';
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
pos1 = getpixelposition(handles.axes1,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off; 

change(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','off');
set(handles.pushbutton_sandwich,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_two_connected_cylindrical_shells_hs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_two_connected_cylindrical_shells_hs_OutputFcn(hObject, eventdata, handles) 
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

delete(SEA_two_connected_cylindrical_shells_hs);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('   ');
disp(' * * * * * * * * *  ');
disp('   ');


fig_num=1;

setappdata(0,'fig_num',1);

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end



tpi=2*pi;

[meters_per_inch,Pa_per_psi,kgpm3_per_lbmpft3,kgpm3_per_lbmpin3,...
                                    kgpm2_per_lbmpft2,kgpm2_per_lbmpin2,...
                                                             kg_per_lbm]...
                                                    =mass_unit_conversion();


sname_1=get(handles.edit_sname_1,'String');
sname_2=get(handles.edit_sname_2,'String');



iu=get(handles.listbox_units,'Value');
setappdata(0,'iu',iu);

iuo=iu;

njd=get(handles.listbox_jd,'Value');
 ng=get(handles.listbox_gas,'Value');

setappdata(0,'njd',njd); 
setappdata(0,'ng',ng); 
 
try
   THM=getappdata(0,'SPL_five');
catch
   warndlg('Enter SPL'); 
   return;     
end
    
if(isempty(THM))
   warndlg('Enter SPL'); 
   return; 
end    

freq=THM(:,1);
fc=freq;

dB1=THM(:,2);
dB2=THM(:,3);
lf1=THM(:,4);
lf2=THM(:,5);   


L1=str2num(get(handles.edit_L1,'String'));
L2=str2num(get(handles.edit_L2,'String'));

diam1=str2num(get(handles.edit_diam1,'String'));
diam2=str2num(get(handles.edit_diam2,'String'));

setappdata(0,'L1_orig',L1);
setappdata(0,'L2_orig',L2);
setappdata(0,'diam1_orig',diam1);
setappdata(0,'diam2_orig',diam2);


E=getappdata(0,'E');
mu=getappdata(0,'mu');
G=getappdata(0,'G');

rhoc=getappdata(0,'rhoc');
hc=getappdata(0,'hc');

tf=getappdata(0,'tf');
rhof=getappdata(0,'rhof');

smd=getappdata(0,'smd');

if(isempty(tf))
    warndlg('tf missing. Enter Sandwich Data');
    return;
end
if(isempty(hc))
    warndlg('hc missing. Enter Sandwich Data');
    return;
end
if(isempty(G))
    warndlg('G missing. Enter Sandwich Data');
    return;
end
if(isempty(rhof))
    warndlg('rhof missing. Enter Sandwich Data');
    return;
end
if(isempty(rhoc))
    warndlg('rhoc missing. Enter Sandwich Data');
    return;
end
if(isempty(smd))
    warndlg('smd missing. Enter Sandwich Data');
    return;
end




% bc=get(handles.listbox_bc,'Value');
bc=4;   % simply supported at each end

gas_c=str2num(get(handles.edit_c,'String')); 
gas_md=str2num(get(handles.edit_gas_md,'String'));
fstart=str2num(get(handles.edit_fstart,'String')); 

setappdata(0,'gas_c_orig',gas_c);
setappdata(0,'gas_md_orig',gas_md);
setappdata(0,'fstart_orig',fstart);



if(iu==1)  % convert English to metric
    
   diam1=diam1*meters_per_inch;
   diam2=diam2*meters_per_inch;
   L1=L1*meters_per_inch;
   L2=L2*meters_per_inch;

   
   gas_c=gas_c*12;
   gas_c=gas_c*meters_per_inch;
   
   gas_md=gas_md*kgpm3_per_lbmpft3;
   
else
end

iu=2;

c=gas_c;

rho_c=gas_md*gas_c;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[D1,K1,S1,~,fring1]=honeycomb_sandwich_properties_wave(E(1),G(1),mu(1),tf(1),hc(1),diam1,rhof(1),rhoc(1));
[D2,K2,S2,~,fring2]=honeycomb_sandwich_properties_wave(E(2),G(2),mu(2),tf(2),hc(2),diam2,rhof(2),rhoc(2));


[f11,f12]=shear_frequencies(E(1),G(1),mu(1),tf(1),hc(1),rhof(1),rhoc(1));
[f21,f22]=shear_frequencies(E(2),G(2),mu(2),tf(2),hc(2),rhof(2),rhoc(2));


NSM_per_area=0;

fcr=zeros(2,1);
mpa=zeros(2,1);
B=zeros(2,1);
Bf=zeros(2,1);
kflag=zeros(2,1);


for i=1:2

    [fcr(i),mpa(i),B(i),Bf(i),kflag(i)]=...
          honeycomb_sandwich_critical_frequency_D(E(i),G(i),mu(i),tf(i),hc(i),rhof(i),rhoc(i),gas_c,NSM_per_area);

    if(kflag(i)==1)
        warndlg('Critical frequency does not exist for this case');
        return;
    end

end

mpa=smd;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mmax=220;
nmax=220;

Ap1=L1*pi*diam1;
mass1=mpa(1)*Ap1;
m1=mass1;

Ap2=L2*pi*diam2;
mass2=mpa(2)*Ap2;
m2=mass2;


[rad_eff1,mph1]=...
    re_sandwich_cylinder_engine_alt(D1,K1,mu(1),diam1,L1,mpa(1),bc,mmax,nmax,gas_c,fcr(1),fring1,freq);


[rad_eff2,mph2]=...
    re_sandwich_cylinder_engine_alt(D2,K2,mu(2),diam2,L2,mpa(2),bc,mmax,nmax,gas_c,fcr(2),fring2,freq);


num=length(fc);

jf=1;

for i=num:-1:1
    if(mph1(i)<1.e-20 || mph2(i)<1.e-20 || rad_eff1(i)<1.e-20 || rad_eff2(i)<1.e-20 || fc(i)<fstart )
        jf=i+1;
        break;
    end
end


jg=1;

for i=num:-1:1
    if(mph1(i)<1.e-20 || mph2(i)<1.e-20  )
        jg=i+1;
        break;
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp1=[fc(jg:num) rad_eff1(jg:num)];
ppp2=[fc(jg:num) rad_eff2(jg:num)];


if(jg>=num)
   out1=sprintf('Error:  jg=%8.4g  num=%8.4g ',jg,num);
   warndlg(out1);
   return; 
end


try
    fmin=fc(jf);
catch
    fmin=fc(1);
end    
fmax=fc(num);


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


leg1=sname_1;
leg2=sname_2;
 
f1=fc;
f2=f1;
 
n_type=1;
 
[fig_num]=spl_plot_two(fig_num,n_type,f1,dB1,f2,dB2,leg1,leg2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

leg1=sname_1;
leg2=sname_2;

x_label='Center Frequency (Hz)';
y_label='Ratio';
t_string='Radiation Efficiency';

md=3;
[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
           

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp1=[fc(jg:num) mph1(jg:num)];
ppp2=[fc(jg:num) mph2(jg:num)];

alpha=2^(1/6)-1/2^(1/6);

k=1;

num_modes_1=zeros((num-jg+1),1);
num_modes_2=zeros((num-jg+1),1);
fnm=zeros((num-jg+1),1);


for i=jg:num
    
    bw=fc(i)*alpha;
    
    fnm(k)=fc(i);
    
    num_modes_1(k)=mph1(i)*bw;
    num_modes_2(k)=mph2(i)*bw;    
    
    k=k+1;
    
end

data1=[fnm num_modes_1];
data2=[fnm num_modes_2];

xlabel2='Center Frequency (Hz)';
ylabel1='Modes';
ylabel2='Modes';
t_string1=sprintf('Number of Modes in Band  %s',sname_1);
t_string2=sprintf('Number of Modes in Band  %s',sname_2);

[fig_num]=subplots_two_onethird_bar(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp1=[fc(jg:num) mph1(jg:num)];
ppp2=[fc(jg:num) mph2(jg:num)];

leg1=sname_1;
leg2=sname_2;

x_label='Center Frequency (Hz)';
y_label='n (modes/Hz)';
t_string='Modal Density';

md=3;
[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('   Modal Density (modes/Hz)');
disp(' ');
disp('   fc(Hz)   mph1   mph2 ');
disp(' ');

for i=1:num    
    out1=sprintf('%7.1f  %8.4g  %8.4g',fc(i),mph1(i),mph2(i));
    disp(out1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   power1=zeros(num,1);
power_dB1=zeros(num,1);

   power2=zeros(num,1);
power_dB2=zeros(num,1);




disp(' ');
disp(' Zero dB References: ');
disp('   Pressure 20 micro Pa');
disp('   Power     1 pico Watt ');
disp(' ');


disp('   fc    SPL1    SPL2   Power1   Power2    ');
disp('  (Hz)   (dB)    (dB)    (dB)     (dB)   ');

for i=1:num    
    
    [power1(i),power_dB1(i)]=power_from_spl_dB(fc(i),dB1(i),mph1(i),c,mpa(1),rad_eff1(i));    
    [power2(i),power_dB2(i)]=power_from_spl_dB(fc(i),dB2(i),mph2(i),c,mpa(2),rad_eff2(i));
    
    out1=sprintf('%7.1f  %6.1f  %6.1f  %6.1f  %6.1f',fc(i),dB1(i),dB2(i),power_dB1(i),power_dB2(i));
    disp(out1);
end

disp(' ');

[oapow1]=oaspl_function(power_dB1);
[oapow2]=oaspl_function(power_dB2);

out1=sprintf('\n Overall Power Levels \n  Power 1 = %7.4g dB \n  Power 2 = %7.4g dB ',oapow1,oapow2);
disp(out1);

power_ref=1.0e-12;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



NL=length(fc);

omega=tpi*fc;


if(njd==1)
    Lc=pi*diam1;
end
if(njd==2)
    Lc=pi*diam2;
end
if(njd==3)
    Lc=pi*mean([diam1 diam2]);
end


clf_12=zeros(NL,1);
clf_21=zeros(NL,1);

Moverlap1=zeros(NL,1);
Moverlap2=zeros(NL,1);


lfa1=zeros(NL,1);
lfa2=zeros(NL,1);


for i=1:NL

    [Moverlap1(i)]=SEA_modal_overlap(mph1(i),lf1(i),freq(i));
    [Moverlap2(i)]=SEA_modal_overlap(mph2(i),lf2(i),freq(i));
    
    [clf_12(i),clf_21(i),~]=sandwich_panel_line_two(omega(i),B,Bf,G,mpa,hc,Lc,Ap1,Ap2);
    
    
    radiation_resistance1=rho_c*Ap1*rad_eff1(i);
    lfa1(i)=radiation_resistance1/(m1*omega(i));  
    
    radiation_resistance2=rho_c*Ap2*rad_eff2(i);
    lfa2(i)=radiation_resistance2/(m2*omega(i));      

end

total_lf1=lf1+lfa1;
total_lf2=lf2+lfa2;


ppq1=[fc(jg:num)  Moverlap1(jg:num) ];
ppq2=[fc(jg:num)  Moverlap2(jg:num) ];



leg1=sname_1;
leg2=sname_2;

x_label='Center Frequency (Hz)';
y_label=' ';
t_string='Modal Overlap';

md=4;
[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppq1,ppq2,leg1,leg2,fmin,fmax,md);
       
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear B;

v1=zeros(NL,1);
v2=zeros(NL,1);

a1=zeros(NL,1);
a2=zeros(NL,1);

broadband=zeros(NL,2);

DD=2;
z=2^(1/6);

for i=1:NL

    A=[ total_lf1(i)+clf_12(i)  -clf_21(i)  ; -clf_12(i)  total_lf2(i)+clf_21(i)  ];
    B=[ power1(i); power2(i)]/omega(i);

    E=A\B;

    E1=E(1);
    E2=E(2);
    
    [v1(i),a1(i)]=energy_to_velox_accel(E1,m1,omega(i));    
    [v2(i),a2(i)]=energy_to_velox_accel(E2,m2,omega(i));
    
    delta_f=fc(i)*(z-1/z);

    for j=1:2
        
        if(j==1)
            nnet= total_lf1(i);
            mdens=mph1(i);
        else
            nnet= total_lf2(i);  
            mdens=mph2(i);           
        end
        
        [~,broadband(i,j)]=statistical_response_concentration_core(fc(i),delta_f,nnet,mdens,DD);
        
    end
    
end


if(iu==2)
   v1=v1*1000;
   v2=v2*1000;
end

if(iu==1)
   a1=a1/386;
   a2=a2/386;
else
   a1=a1/9.81;
   a2=a2/9.81;    
end


if(iu==1)
    seu='in-lbf';
    spu='in-lbf/sec';
    spv='in/sec';
else
    seu='J';
    spu='W';
    spv='mm/sec';    
end  

if(iuo==1)
    v1=v1/25.4;
    v2=v2/25.4;
    spv='in/sec';
end


disp(' ');
disp(' * * * * ');
disp(' ');
disp(' Freq      v1       v2         a1       a2');
   
if(iuo==1)
    disp(' (Hz)   (in/sec)   (in/sec)    (G)      (G)');    
else
    disp(' (Hz)   (mm/sec)   (mm/sec)    (G)      (G)');  
end
    
    
for i=1:NL
    
    out1=sprintf(' %g   %8.4g   %8.4g  %8.4g  %8.4g',fc(i),v1(i),v2(i),a1(i),a2(i));
    disp(out1);
    
end



x_label='Frequency (Hz)';
y_label=sprintf('Velocity (%s) rms',spv);




md=5;
leg1=sname_1;
leg2=sname_2;

ppp1=[fc(jf:num) v1(jf:num)];
ppp2=[fc(jf:num) v2(jf:num)];

aaa1=[fc(jf:num) a1(jf:num)];
aaa2=[fc(jf:num) a2(jf:num)];

t_string='Velocity Spectrum';

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_label=sprintf('Accel (G rms)');
t_string='Acceleration Spectrum';

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,aaa1,aaa2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[oapow1]=oaspl_function(power_dB1(jf:num));
[oapow2]=oaspl_function(power_dB2(jf:num));

wov1=power_ref*10^(oapow1/10);
wov2=power_ref*10^(oapow2/10);

leg1=sprintf('%s  %8.4g W overall',sname_1,wov1);
leg2=sprintf('%s  %8.4g W overall',sname_2,wov2);

t_string='Input Power Spectrum';

if(iu==1)
   y_label='Power (in-lbf/sec)'; 
else
   y_label='Power (W)';    
end

qqq1=[fc(jf:num) power1(jf:num)];
qqq2=[fc(jf:num) power2(jf:num)];

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='Loss Factors';
y_label='Loss Factor'; 

rrr1=[fc total_lf1];
rrr2=[fc total_lf2];
rrr3=[fc clf_12];
rrr4=[fc clf_21];
leg1='total lf 1';
leg2='total lf 2';
leg3='clf 12';
leg4='clf 21';

[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,rrr1,rrr2,rrr3,rrr4,leg1,leg2,leg3,leg4,fmin,fmax,md);
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='Maximum Mean-Square Velocity Amplification';
y_label='Amplification (dB)'; 

leg1=sname_1;
leg2=sname_2;
ppp1=[fc(jf:num) broadband(jf:num,1)];
ppp2=[fc(jf:num) broadband(jf:num,2)];

broadband1=ppp1;
broadband2=ppp2;

[fig_num,h2]=plot_loglin_function_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax);           
          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nb=1;
 
if(nb<=2)
    
    [psd1,grms1]=psd_from_spectrum(nb,fc,a1);    
    [psd2,grms2]=psd_from_spectrum(nb,fc,a2);  
    
    [s,grms1] = calculate_PSD_slopes(fc(jf:num),psd1(jf:num));
    [s,grms2] = calculate_PSD_slopes(fc(jf:num),psd2(jf:num));
    
 
    disp(' ');
    disp(' Power Spectral Density ');
    disp(' ');
    disp('   Freq    PSD 1     PSD 2  ');
    disp('   (Hz)   (G^2/Hz)  (G^2/Hz)');
           
    for i=jf:NL
    
        out1=sprintf('  %g    %8.4g  %8.4g',fc(i),psd1(i),psd2(i));
        disp(out1);
    
    end
 

    leg1=sprintf('%s %7.3g GRMS',sname_1,grms1);
    leg2=sprintf('%s %7.3g GRMS',sname_2,grms2);
    
    disp(' ');
    disp(' Overall Levels ');
    disp(' ');   
    out1=sprintf(' Subsystem 1 = %8.4g GRMS',grms1);
    disp(out1);
    out2=sprintf(' Subsystem 2 = %8.4g GRMS',grms2);
    disp(out2);    
    
    psd1=[fc(jf:num) psd1(jf:num)];
    psd2=[fc(jf:num) psd2(jf:num)];    
    
    qqq1=psd1;
    qqq2=psd2;    
    
    y_label='Accel (G^2/Hz)';
    
    t_string=sprintf('Power Spectral Density');
 
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,leg1,leg2,fmin,fmax,md);    
end
 
disp(' ');
disp('  Ring Frequencies ');
disp(' ');
out1=sprintf('%s  %8.4g Hz',sname_1,fring1);
out2=sprintf('%s  %8.4g Hz',sname_1,fring2);
disp(out1);
disp(out2);


disp(' ');
out1=sprintf(' Mass per area = %8.4g kg/m^2',mpa);
out2=sprintf('               = %8.4g lbm/ft^2',mpa/kgpm2_per_lbmpft2 );
out3=sprintf('               = %8.4g lbm/in^2',mpa/kgpm2_per_lbmpin2 );
disp(out1);
disp(out2);
disp(out3);

aa1=[fc dB1 rad_eff1 mph1];
aa2=[fc dB2 rad_eff2 mph2];

assignin('base', 'aa1',aa1);
assignin('base', 'aa2',aa2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Output Arrays:');

disp(' ');
disp(' Power Spectra: vel_ps_1, vel_ps_2, accel_ps_1, accel_ps_2 ');          

assignin('base', 'vel_ps_1',ppp1);
assignin('base', 'vel_ps_2',ppp2);
 
assignin('base', 'accel_ps_1',aaa1);
assignin('base', 'accel_ps_2',aaa2); 

if(nb<=2)
    assignin('base', 'accel_psd_1',psd1);
    assignin('base', 'accel_psd_2',psd2);     
    disp(' Power Spectral Densities: accel_psd_1, accel_psd_2 ');
end    

disp(' ');
disp(' Velocity Response Amplification: vra_dB_1, vra_dB_2 ');
disp(' ');
assignin('base', 'vra_dB_1',broadband1);
assignin('base', 'vra_dB_2',broadband2);
 
msgbox('Results written to Command Window');



% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_view,'Value');

if(n==1)
    A = imread('velox_two_subsystems.jpg');
end
if(n==2)
    A = imread('clf_line_joint_plates.jpg');    
end
if(n==3)
    A = imread('equivalent_acoustic_power_cylinder.jpg');
end
if(n==4)
    A = imread('re_sandwich_cylinder.jpg');
end
if(n==5)
    A = imread('modal_density_sandwich_cylinder.jpg');  
end
if(n==6)
    A = imread('wavespeed_sandwich.jpg'); 
end


figure(999)
imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on selection change in listbox_view.
function listbox_view_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_view contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_view


% --- Executes during object creation, after setting all properties.
function listbox_view_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_shear_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_shear_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_shear_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_shear_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_shear_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_shear_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md_c as text
%        str2double(get(hObject,'String')) returns contents of edit_md_c as a double


% --- Executes during object creation, after setting all properties.
function edit_md_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function change(hObject, eventdata, handles)

iu=get(handles.listbox_units,'Value');
ng=get(handles.listbox_gas,'Value');
%

%%%%%%%%%%%%%   

if(iu==1)
    
    set(handles.text_L1,'String','Subsystem 1  Length (in)');
    set(handles.text_L2,'String','Subsystem 2  Length (in)');    
    
    set(handles.text_diam1,'String','Subsystem 1  Diameter (in)');    
    set(handles.text_diam2,'String','Subsystem 2  Diameter (in)');      


    set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)'); 
    set(handles.text_gas_md,'String','Gas Mass Density (lbm/ft^3)');
    
    if(ng==1)
        set(handles.edit_c,'String','1125');
        set(handles.edit_gas_md,'String','0.076487');       
    else
        set(handles.edit_c,'String',' ');   
        set(handles.edit_gas_md,'String',' ');        
    end

    
else
    
    set(handles.text_L1,'String','Subsystem 1  Length (m)');
    set(handles.text_L2,'String','Subsystem 2  Length (m)'); 
    set(handles.text_diam1,'String','Subsystem 1  Diameter (m)');    
    set(handles.text_diam2,'String','Subsystem 2  Diameter (m)');
    
    set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
    set(handles.text_gas_md,'String','Gas Mass Density (kg/m^3)');   
        
    if(ng==1)
        set(handles.edit_c,'String','343');  
        set(handles.edit_gas_md,'String','1.225');         
    else
        set(handles.edit_c,'String',' ');      
        set(handles.edit_gas_md,'String',' ');          
    end    
    
end

 
%%%%


%%%%



% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material
change(hObject, eventdata, handles);

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



function edit_em_Callback(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_em as text
%        str2double(get(hObject,'String')) returns contents of edit_em as a double


% --- Executes during object creation, after setting all properties.
function edit_em_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_f_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md_f as text
%        str2double(get(hObject,'String')) returns contents of edit_md_f as a double


% --- Executes during object creation, after setting all properties.
function edit_md_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mu as text
%        str2double(get(hObject,'String')) returns contents of edit_mu as a double


% --- Executes during object creation, after setting all properties.
function edit_mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_gas.
function listbox_gas_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_gas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_gas
change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_gas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c as text
%        str2double(get(hObject,'String')) returns contents of edit_c as a double


% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thick_f_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thick_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thick_f as text
%        str2double(get(hObject,'String')) returns contents of edit_thick_f as a double


% --- Executes during object creation, after setting all properties.
function edit_thick_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thick_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thick_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thick_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thick_c as text
%        str2double(get(hObject,'String')) returns contents of edit_thick_c as a double


% --- Executes during object creation, after setting all properties.
function edit_thick_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thick_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L1 as text
%        str2double(get(hObject,'String')) returns contents of edit_L1 as a double


% --- Executes during object creation, after setting all properties.
function edit_L1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L2 as text
%        str2double(get(hObject,'String')) returns contents of edit_L2 as a double


% --- Executes during object creation, after setting all properties.
function edit_L2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diam1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diam1 as text
%        str2double(get(hObject,'String')) returns contents of edit_diam1 as a double


% --- Executes during object creation, after setting all properties.
function edit_diam1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diam2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diam2 as text
%        str2double(get(hObject,'String')) returns contents of edit_diam2 as a double


% --- Executes during object creation, after setting all properties.
function edit_diam2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function edit_gas_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gas_md as text
%        str2double(get(hObject,'String')) returns contents of edit_gas_md as a double


% --- Executes during object creation, after setting all properties.
function edit_gas_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_SPL.
function pushbutton_SPL_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SPL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=SEA_two_honeycomb_cylindrical_shells_SPL;

set(handles.s,'Visible','on');

  
set(handles.pushbutton_sandwich,'Enable','on');




function edit_fstart_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fstart as text
%        str2double(get(hObject,'String')) returns contents of edit_fstart as a double


% --- Executes during object creation, after setting all properties.
function edit_fstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_sandwich.
function pushbutton_sandwich_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sandwich (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');

setappdata(0,'iu',iu);


L1=str2num(get(handles.edit_L1,'String'));
L2=str2num(get(handles.edit_L2,'String'));

diam1=str2num(get(handles.edit_diam1,'String'));
diam2=str2num(get(handles.edit_diam2,'String'));

if(isempty(L1))
    warndlg('Enter Subystem 1 Length');
    return;
end
if(isempty(L2))
    warndlg('Enter Subystem 2 Length');
    return;
end
if(isempty(diam1))
    warndlg('Enter Subystem 1 Diameter');
    return;
end
if(isempty(diam2))
    warndlg('Enter Subystem 2 Diameter');
    return;
end



handles.s=SEA_honeycomb_sandwich_two;
set(handles.s,'Visible','on');

set(handles.pushbutton_calculate,'Enable','on');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    
    sname_1=get(handles.edit_sname_1,'String');
    sname_2=get(handles.edit_sname_2,'String');

    SEA_two_shells_hs.sname_1=sname_1;
    SEA_two_shells_hs.sname_2=sname_2;

catch
end

try
    gas_c=getappdata(0,'gas_c_orig');        
    SEA_two_shells_hs.gas_c=gas_c;
catch
end

try
    gas_md=getappdata(0,'gas_md_orig');
    SEA_two_shells_hs.gas_md=gas_md;
catch
end

try
    fstart=getappdata(0,'fstart_orig'); 
    SEA_two_shells_hs.fstart=fstart;
catch
end

try
    iu=getappdata(0,'iu');
    SEA_two_shells_hs.iu=iu;
catch
end

try
    ng=getappdata(0,'ng');
    SEA_two_shells_hs.ng=ng;
catch
end

try
    njd=getappdata(0,'njd');
    SEA_two_shells_hs.njd=njd;
catch
end

try
    L1=getappdata(0,'L1_orig');
    SEA_two_shells_hs.L1=L1;
catch
end

try
    L2=getappdata(0,'L2_orig');
    SEA_two_shells_hs.L2=L2;
catch
end

try
    diam1=getappdata(0,'diam1_orig');  
    SEA_two_shells_hs.diam1=diam1;
catch
end

try
    diam2=getappdata(0,'diam2_orig');  
    SEA_two_shells_hs.diam2=diam2;
catch
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    imat=getappdata(0,'imat_orig');
    SEA_two_shells_hs.imat=imat;
catch
end    
try
    E=getappdata(0,'E_orig');
    SEA_two_shells_hs.E=E;
catch
end
try
    mu=getappdata(0,'mu_orig');
    SEA_two_shells_hs.mu=mu;
catch
end
try
    G=getappdata(0,'G_orig');
    SEA_two_shells_hs.G=G;
catch
end
try
    rhoc=getappdata(0,'rhoc_orig');
    SEA_two_shells_hs.rhoc=rhoc;
catch
end
try
    hc=getappdata(0,'hc_orig');
    SEA_two_shells_hs.hc=hc;
catch
end
try
    tf=getappdata(0,'tf_orig');
    SEA_two_shells_hs.tf=tf;
catch
end 
try
    rhof=getappdata(0,'rhof_orig');
    SEA_two_shells_hs.rhof=rhof;
catch
end 

try
    smd=getappdata(0,'smd_orig');
    SEA_two_shells_hs.smd=smd;
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    SPL_five=getappdata(0,'SPL_five');         
    SEA_two_shells_hs.SPL_five=SPL_five;
catch
end

try
    SPL_five_name=getappdata(0,'SPL_five_name');       
    SEA_two_shells_hs.SPL_five_name=SPL_five_name;
catch
end

try
    SPL_three=getappdata(0,'SPL_three');         
    SEA_two_shells_hs.SPL_three=SPL_three;
catch
end

try
    SPL_three_name=getappdata(0,'SPL_three_name');       
    SEA_two_shells_hs.SPL_three_name=SPL_three_name;
catch
end

try
    listbox_array_type=getappdata(0,'listbox_array_type');        
    SEA_two_shells_hs.listbox_array_type=listbox_array_type;
catch
end



% % %

structnames = fieldnames(SEA_two_shells_hs, '-full'); % fields in the struct


% % %

   [writefname, writepname] = uiputfile('*.mat','Save data as');

   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    try
 
        save(elk, 'SEA_two_shells_hs'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)

%%%%%%%%%%
%%%%%%%%%%

% Construct a questdlg with two options
choice = questdlg('Save Complete.  Reset Workspace?', ...
    'Options', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
%%        disp([choice ' Reseting'])
%%        pushbutton_reset_Callback(hObject, eventdata, handles)
        appdata = get(0,'ApplicationData');
        fnsx = fieldnames(appdata);
        for ii = 1:numel(fnsx)
            rmappdata(0,fnsx{ii});
        end
end  


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ref 1');

[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

disp(' ref 2');
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

disp(' ref 3');

structnames
 

% struct

try
    SEA_two_shells_hs=evalin('base','SEA_two_shells_hs');
catch
   warndlg(' evalin failed ');
   return;
end
 
SEA_two_shells_hs
 
disp(' ref 4');


%%%

try
    gas_c=SEA_two_shells_hs.gas_c;    
    setappdata(0,'gas_c_orig',gas_c);
    ss=sprintf('%8.4g',gas_c);
    set(handles.edit_c,'String',ss);
catch
end

try
    gas_md=SEA_two_shells_hs.gas_md;    
    setappdata(0,'gas_md_orig',gas_md);
    ss=sprintf('%8.4g',gas_md);
    set(handles.edit_gas_md,'String',ss);
catch
end

try
    fstart=SEA_two_shells_hs.fstart;    
    setappdata(0,'fstart_orig',fstart); 
    ss=sprintf('%8.4g',fstart);
    set(handles.edit_fstart,'String',ss);    
catch
end

try
    iu=SEA_two_shells_hs.iu;    
    setappdata(0,'iu',iu);
    set(handles.listbox_units,'Value',iu);
catch
end

try
    ng=SEA_two_shells_hs.ng;    
    setappdata(0,'ng',ng);
    set(handles.listbox_gas,'Value',ng);
catch
end


try
    njd=SEA_two_shells_hs.njd;    
    setappdata(0,'njd',njd);
    set(handles.listbox_jd,'Value',njd);
catch
end

try
    L1=SEA_two_shells_hs.L1;    
    setappdata(0,'L1_orig',L1);
    ss=sprintf('%8.4g',L1);
    set(handles.edit_L1,'String',ss);    
catch
end

try
    L2=SEA_two_shells_hs.L2;    
    setappdata(0,'L2_orig',L2);
    ss=sprintf('%8.4g',L2);
    set(handles.edit_L2,'String',ss);   
catch
end

try
    diam1=SEA_two_shells_hs.diam1;    
    setappdata(0,'diam1_orig',diam1);  
    ss=sprintf('%8.4g',diam1);
    set(handles.edit_diam1,'String',ss);     
catch
end

try
    diam2=SEA_two_shells_hs.diam2;    
    setappdata(0,'diam2_orig',diam2);  
    ss=sprintf('%8.4g',diam2);
    set(handles.edit_diam2,'String',ss);     
catch
end

%%

try
    SPL_five=SEA_two_shells_hs.SPL_five;    
    setappdata(0,'SPL_five',SPL_five);
catch
end

try
    SPL_five_name=SEA_two_shells_hs.SPL_five_name;    
    setappdata(0,'SPL_five_name',SPL_five_name);          
catch
end

try
    assignin('base',SPL_five_name,SPL_five);    
catch
end


%%

try
    SPL_three=SEA_two_shells_hs.SPL_three;    
    setappdata(0,'SPL_three',SPL_three);
catch
end

try
    SPL_three_name=SEA_two_shells_hs.SPL_three_name;    
    setappdata(0,'SPL_three_name',SPL_three_name);          
catch
end

try
    assignin('base',SPL_three_name,SPL_three);    
catch
end

%%%%

try
    listbox_array_type=SEA_two_shells_hs.listbox_array_type;    
    setappdata(0,'listbox_array_type',listbox_array_type);    
    
catch
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    imat=SEA_two_shells_hs.imat;
    setappdata(0,'imat_orig',imat);    
catch
end    
try
    E=SEA_two_shells_hs.E;
    setappdata(0,'E_orig',E);    
catch
end
try
    mu=SEA_two_shells_hs.mu;
    setappdata(0,'mu_orig',mu);    
catch
end
try
    G=SEA_two_shells_hs.G;
    setappdata(0,'G_orig',G);    
catch
end
try
    rhoc=SEA_two_shells_hs.rhoc;
    setappdata(0,'rhoc_orig',rhoc);    
catch
end
try
    hc=SEA_two_shells_hs.hc;
    setappdata(0,'hc_orig',hc);
catch
end
try
    tf=SEA_two_shells_hs.tf;    
    setappdata(0,'tf_orig',tf);       
catch
end

try
    rhof=SEA_two_shells_hs.rhof;    
    setappdata(0,'rhof_orig',rhof);          
catch
end


try
    sname_1=SEA_two_shells_hs.sname_1;    
    set(handles.edit_sname_1,'String',sname_1);            
catch
end

try
    sname_2=SEA_two_shells_hs.sname_2;    
    set(handles.edit_sname_2,'String',sname_2);            
catch
end

try
    smd=SEA_two_shells_hs.smd;
    setappdata(0,'smd_orig',smd);
catch
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% --- Executes on selection change in listbox_jd.
function listbox_jd_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_jd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_jd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_jd


% --- Executes during object creation, after setting all properties.
function listbox_jd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_jd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_sname_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sname_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sname_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_sname_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_sname_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sname_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sname_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sname_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sname_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_sname_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_sname_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sname_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
