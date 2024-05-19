function varargout = SEA_fairing_ring_shelf(varargin)
% SEA_FAIRING_RING_SHELF MATLAB code for SEA_fairing_ring_shelf.fig
%      SEA_FAIRING_RING_SHELF, by itself, creates a new SEA_FAIRING_RING_SHELF or raises the existing
%      singleton*.
%
%      H = SEA_FAIRING_RING_SHELF returns the handle to a new SEA_FAIRING_RING_SHELF or the handle to
%      the existing singleton*.
%
%      SEA_FAIRING_RING_SHELF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_FAIRING_RING_SHELF.M with the given input arguments.
%
%      SEA_FAIRING_RING_SHELF('Property','Value',...) creates a new SEA_FAIRING_RING_SHELF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_fairing_ring_shelf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_fairing_ring_shelf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_fairing_ring_shelf

% Last Modified by GUIDE v2.5 21-May-2016 14:44:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_fairing_ring_shelf_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_fairing_ring_shelf_OutputFcn, ...
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


% --- Executes just before SEA_fairing_ring_shelf is made visible.
function SEA_fairing_ring_shelf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_fairing_ring_shelf (see VARARGIN)

% Choose default command line output for SEA_fairing_ring_shelf
handles.output = hObject;

clc;

fstr='fairing_ring_shelf.jpg';

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
 


set(handles.pushbutton_acoustic_cavity,'Enable','off');

set(handles.pushbutton_ring_frame,'Enable','off');

set(handles.pushbutton_shelf,'Enable','off');
set(handles.listbox_shelf_construction,'Enable','off');
set(handles.listbox_shelf_geometry,'Enable','off');
set(handles.pushbutton_calculate,'Enable','off');
set(handles.text_scg,'Enable','off');

set(handles.listbox_iu,'Enable','on');

listbox_iu_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_fairing_ring_shelf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_fairing_ring_shelf_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('fairing_ring_shelf_eq.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%
%     Subsystems
%
%        1=fairing
%        2=ring frame 
%        3=acoustic cavity
%        4=shelf 


tpi=2*pi;

iu=get(handles.listbox_iu,'Value');

% % %

            power=getappdata(0,'external_acoustic_power');
     external_SPL=getappdata(0,'external_SPL');
            
    fairing_mdens=getappdata(0,'fairing_modal_density');
  fairing_rad_eff=getappdata(0,'fairing_rad_eff');
      fairing_dlf=getappdata(0,'fairing_dlf');
     fairing_mass=getappdata(0,'fairing_mass');
       fairing_md=getappdata(0,'fairing_md');
    fairing_thick=getappdata(0,'fairing_thick');
       fairing_cL=getappdata(0,'fairing_cL');     
     fairing_area=getappdata(0,'fairing_area');    
           
            efd=fairing_dlf;        

if isempty(power)
   warndlg('power missing. Run Fairing'); 
   return;
end
if isempty(external_SPL)
   warndlg('external_SPL missing. Run Fairing'); 
   return;
end
            
if isempty(fairing_mdens)
   warndlg('fairing_mdens missing. Run Fairing'); 
   return;
end
if isempty(fairing_rad_eff)
   warndlg('fairing_rad_eff missing. Run Fairing'); 
   return;
end   
if isempty(fairing_dlf)
   warndlg('fairing_dlf missing. Run Fairing'); 
   return;
end   
if isempty(fairing_mass)
   warndlg('fairing_mass missing. Run Fairing'); 
   return;
end   
if isempty(fairing_md)
   warndlg('fairing_md missing. Run Fairing'); 
   return;
end
if isempty(fairing_thick)
   warndlg('fairing_thick missing. Run Fairing'); 
   return;
end   
if isempty(fairing_cL)
   warndlg('fairing_cL missing. Run Fairing'); 
   return;
end   
if isempty(fairing_thick)
   warndlg('fairing_thick missing. Run Equipment Shelf'); 
   return;
end   

            
% % %

              acoustic_dlf=getappdata(0,'acoustic_cavity_dlf');
            acoustic_mdens=getappdata(0,'acoustic_cavity_modal_density');
    acoustic_cavity_volume=getappdata(0,'acoustic_cavity_volume');          
 acoustic_cavity_gas_rho_c=getappdata(0,'acoustic_cavity_gas_rho_c');
   acoustic_cavity_gas_rho=getappdata(0,'acoustic_cavity_gas_md');
     acoustic_cavity_gas_c=getappdata(0,'acoustic_cavity_gas_c');
 
            ead=acoustic_dlf;
      
            
if isempty(acoustic_dlf)
   warndlg('acoustic_dlf missing. Run Acoustic Cavity'); 
   return;
end  
if isempty(acoustic_mdens)
   warndlg('ring_a missing. Run Acoustic Cavity'); 
   return;
end   
if isempty(acoustic_cavity_volume)
   warndlg('acoustic_cavity_volume missing. Run Acoustic Cavity'); 
   return;
end   
if isempty(acoustic_cavity_gas_rho_c)
   warndlg('acoustic_cavity_gas_rho_c missing. Run Acoustic Cavity'); 
   return;
end              
if isempty(acoustic_cavity_gas_c)
   warndlg('acoustic_cavity_gas_c missing. Run Acoustic Cavity'); 
   return;
end              
if isempty(acoustic_cavity_gas_rho)
   warndlg('acoustic_cavity_gas_rho missing. Run Acoustic Cavity'); 
   return;
end  
            
% % %

  rf_cross_section=getappdata(0,'rf_cross_section');
            ring_a=getappdata(0,'a'); 
            ring_b=getappdata(0,'b');   
            ring_h=getappdata(0,'h');    
          ring_dlf=getappdata(0,'ring_dlf');
           ring_cL=getappdata(0,'ring_cL');
           ring_md=getappdata(0,'ring_md');
         ring_area=getappdata(0,'ring_area');             
              N_fr=getappdata(0,'N_fr');
              N_rs=getappdata(0,'N_rs');   
 
              
               erd=ring_dlf;       

if isempty(ring_area)
   warndlg('ring_area missing. Run Ring Frame'); 
   return;
end                 
if isempty(N_fr)
   warndlg('N_fr missing. Run Ring Frame'); 
   return;
end  
if isempty(N_rs)
   warndlg('N_rs missing. Run Ring Frame'); 
   return;
end  
%
if isempty(rf_cross_section)
   warndlg('rf_cross_section missing. Run Ring Frame'); 
   return;
end  
if isempty(ring_a)
   warndlg('ring_a missing. Run Ring Frame'); 
   return;
end   
if isempty(ring_b)
   warndlg('ring_b missing. Run Ring Frame'); 
   return;
end   
if isempty(ring_h)
   warndlg('ring_h missing. Run Ring Frame'); 
   return;
end   
if isempty(ring_dlf)
   warndlg('ring_dlf missing. Run Ring Frame'); 
   return;
end   
if isempty(ring_cL)
   warndlg('ring_cL missing. Run Ring Frame'); 
   return;
end   
if isempty(ring_md)
   warndlg('ring_md missing. Run Ring Frame '); 
   return;
end   
               
               
% % %

      shelf_mdens=getappdata(0,'shelf_mdens');
        shelf_dlf=getappdata(0,'shelf_dlf');
       shelf_mass=getappdata(0,'shelf_mass');
      shelf_thick=getappdata(0,'shelf_thick');
         shelf_cL=getappdata(0,'shelf_cL');
         shelf_md=getappdata(0,'shelf_md');
       shelf_area=getappdata(0,'shelf_area');         
    shelf_rad_eff=getappdata(0,'shelf_rad_eff');      
    
              esd=shelf_dlf;     
         
    
if isempty(shelf_mdens)
   warndlg('shelf_mdens missing. Run Equipment Shelf'); 
   return;
end    
if isempty(shelf_dlf)
   warndlg('shelf_dlf missing. Run Equipment Shelf'); 
   return;
end     
if isempty(shelf_mass)
   warndlg('shelf_mass missing. Run Equipment Shelf'); 
   return;
end     
if isempty(shelf_thick)
   warndlg('shelf_thick missing. Run Equipment Shelf'); 
   return;
end     
if isempty(shelf_cL)
   warndlg('shelf_cL missing. Run Equipment Shelf'); 
   return;
end     
if isempty(shelf_md)
   warndlg('shelf_md missing. Run Equipment Shelf'); 
   return;
end     
if isempty(shelf_area)
   warndlg('shelf_area missing. Run Equipment Shelf'); 
   return;
end     
if isempty(shelf_rad_eff)
   warndlg('shelf_rad_eff missing. Run Equipment Shelf'); 
   return;
end     

            
% % %

% Assume external acoustic impedance is same as internal

   shelf_rad_res=  shelf_rad_eff*acoustic_cavity_gas_rho_c*shelf_area;            
 fairing_rad_res=fairing_rad_eff*acoustic_cavity_gas_rho_c*fairing_area;

% % %

fc=power(:,1);

nfc=length(power(:,1));

E=zeros(4,nfc);

efa=zeros(nfc,1);
eaf=zeros(nfc,1);

efr=zeros(nfc,1);
erf=zeros(nfc,1);

ers=zeros(nfc,1);
esr=zeros(nfc,1);

eas=zeros(nfc,1);
esa=zeros(nfc,1);

power_ring_shelf=zeros(nfc,1);
power_air_shelf =zeros(nfc,1);

% % %
% % %

omega=tpi*fc;
 
for i=1:nfc
    
    P=[ power(i,2)  0  0  0]';
    P=P/omega(i);

%%%

    efa(i)=(fairing_rad_res(i)/fairing_mass)/omega(i);
    eaf(i)=efa(i)*(fairing_mdens(i)/acoustic_mdens(i));    

    esa(i)=(shelf_rad_res(i)/shelf_mass)/omega(i);
    eas(i)=esa(i)*(shelf_mdens(i)/acoustic_mdens(i));    
    
%%%

    N=N_fr;
  
    S_1=fairing_area;
    S_2=ring_area;
    md_1=fairing_md;
    md_2=ring_md;
    thick_1=fairing_thick;
    thick_2=ring_h;
    cL_1=fairing_cL;
    cL_2=ring_cL;

    [clf_12,clf_21]=clf_bolted_joint_alt(N,fc(i),S_1,S_2,md_1,md_2,thick_1,thick_2,cL_1,cL_2);

    efr(i)=clf_12;
    erf(i)=clf_21;

% % %

    N=N_rs;
    S_1=ring_area;
    S_2=shelf_area;
    md_1=ring_md;
    md_2=shelf_md;
    thick_1=ring_h;
    thick_2=shelf_thick;
    cL_1=ring_cL;
    cL_2=shelf_cL;

    [clf_12,clf_21]=clf_bolted_joint_alt(N,fc(i),S_1,S_2,md_1,md_2,thick_1,thick_2,cL_1,cL_2);

    ers(i)=clf_12;
    esr(i)=clf_21; 
%%%
    A=zeros(4,4);
    
    A(1,1)=  efd(i)+efr(i)+efa(i);
    A(1,2)= -erf(i);
    A(1,3)= -eaf(i);
    A(1,4)=    0;
    
    A(2,1)= -efr(i);
    A(2,2)=  erd(i)+erf(i)+ers(i);
    A(2,3)=    0;
    A(2,4)= -esr(i);
    
    A(3,1)= -efa(i);
    A(3,2)=    0;
    A(3,3)=  ead(i)+eaf(i)+eas(i);
    A(3,4)= -esa(i);
    
    A(4,1)=    0;
    A(4,2)= -ers(i);
    A(4,3)= -eas(i);
    A(4,4)=  esd(i)+esr(i)+esa(i);
        
    E(:,i)=A\P;
        
end

ring_mdens=zeros(nfc,1);

for i=1:nfc

    ring_mdens_1=fairing_mdens(i)*(efr(i)/erf(i));
    ring_mdens_2=  shelf_mdens(i)*(esr(i)/ers(i));

    ring_mdens(i)=mean([ring_mdens_1 ring_mdens_2]);
    
    power_ring_shelf(i)=omega(i)*ers(i)*( E(2,i)  -(     ring_mdens(i)/shelf_mdens(i))*E(4,i) );
     power_air_shelf(i)=omega(i)*eas(i)*( E(3,i)  -( acoustic_mdens(i)/shelf_mdens(i))*E(4,i) );

end

% % % % % % % % %

nb=1;   % one-third octave


[velox_f,accel_f]=energy_to_velox_accel(E(1,:),fairing_mass,omega);
[velox_s,accel_s]=energy_to_velox_accel(E(4,:),shelf_mass,omega);


[vpsd_f,vrms_f]=psd_from_spectrum(nb,fc,velox_f);  
[vpsd_s,vrms_s]=psd_from_spectrum(nb,fc,velox_s);

if(iu==1)
    v_label='in/sec';
    vpsd_label='Vel [(in/sec)^2/Hz]';
else
    v_label='mm/sec';
    vpsd_label='Vel [(mm/sec)^2/Hz]';    
    vrms_f=vrms_f*1000;
    vrms_s=vrms_s*1000;   
    vpsd_f=vpsd_f*1000;
    vpsd_s=vpsd_s*1000;
end


ppp=(E(3,:)/acoustic_cavity_volume)*(acoustic_cavity_gas_rho*acoustic_cavity_gas_c^2);

pressure_cavity=sqrt(ppp);

if(iu==1)  % convert psi to Pa
    pressure_cavity=pressure_cavity*6891.2;
end

ref=20e-06;
pressure_cavity_dB=20*log10(pressure_cavity/ref);


% % % % % % % % % 

if(iu==1)
   accel_f=accel_f/386;  
   accel_s=accel_s/386;    
else
   accel_f=accel_f/9.81; 
   accel_s=accel_s/9.81;    
end    

[apsd_f,grms_f]=psd_from_spectrum(nb,fc,accel_f);  
[apsd_s,grms_s]=psd_from_spectrum(nb,fc,accel_s);  


% % % % % % % % % 
% % % % % % % % % 

fig_num=1;

x_label='Frequency (Hz)';

legm1='Fairing';
legm2='Ring Frame';
legm3='Acoustic Cavity';
legm4='Equipment Shelf';

fmin=min(fc);
fmax=max(fc);

% % % % % % % % % 
% % % % % % % % % 

md=6;
t_string='Coupling Loss Factor';
y_label='clf';

ppp1=[fc efr];
ppp2=[fc erf];

leg1='efr';
leg2='erf';

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

% % % % % % % % % 
% % % % % % % % % 

% input spl & aco cavity spl    figure 1

f1=fc;
dB1=external_SPL(:,2);
f2=fc;
dB2=pressure_cavity_dB;

string_1='Fairing External';
string_2='Acoustic Cavity';

n_type=1;  % one-third octave


[fig_num]=spl_plot_two(fig_num,n_type,f1,dB1,f2,dB2,string_1,string_2);

% disp('ref 1');

% % % % % % % % % 

% power, ext & int flows   figure 2

md=6;

t_string='Power Flow';

ppp1=power;
ppp2=[fc power_ring_shelf];
ppp3=[fc power_air_shelf];

leg1='External->Fairing';
leg2='Ring->Shelf';
leg3='Cavity->Shelf';

if(iu==1)
    y_label='Power (in-lbf/sec)';    
else
    y_label='Power (W)';    
end

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);

% disp('ref 2');

% % % % % % % % % 
     
% mdens  figure 3

md=7;

t_string='Modal Density';
y_label='n (modes/Hz)';

ppp1=[fc fairing_mdens];
ppp2=[fc ring_mdens];
ppp3=[fc acoustic_mdens];
ppp4=[fc shelf_mdens];


[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
y_label,t_string,ppp1,ppp2,ppp3,ppp4,legm1,legm2,legm3,legm4,fmin,fmax,md);

% disp('ref 3');

% % % % % % % % %

% rad eff

md=4;

t_string='Radiation Efficiency';
y_label='Rad Eff';

ppp1=[fc fairing_rad_eff];
ppp2=[fc shelf_rad_eff];

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,legm1,legm4,fmin,fmax,md);

% disp('ref 4');         
         
% % % % % % % % % 

% dlf

md=4;

t_string='Dissipation Loss Factors';
y_label='dlf';

ppp1=[fc fairing_dlf];
ppp2=[fc ring_dlf];
ppp3=[fc acoustic_dlf];
ppp4=[fc shelf_dlf];

plot_loglog_function_md_four_h2(fig_num,x_label,...             
   y_label,t_string,ppp1,ppp2,ppp3,ppp4,legm1,legm2,legm3,legm4,fmin,fmax,md);

% disp('ref 5');

% % % % % % % % % 
           
% clf fairing

t_string='Coupling Loss Factors';
y_label='clf';


ppp1=[fc efr];
ppp2=[fc erf];
ppp3=[fc efa];
ppp4=[fc eaf];

leg1='fairing->ring';
leg2='ring->fairing';
leg3='fairing->cavity';
leg4='cavity->fairing';

plot_loglog_function_md_four_h2(fig_num,x_label,...             
   y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,fmin,fmax,md);

% disp('ref 6');

% % % % % % % % % 

% clf shelf

ppp1=[fc esr];
ppp2=[fc ers];
ppp3=[fc esa];
ppp4=[fc eas];

leg1='shelf->ring';
leg2='ring->shelf';
leg3='shelf->cavity';
leg4='cavity->shelf';

plot_loglog_function_md_four_h2(fig_num,x_label,...             
   y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,fmin,fmax,md);

% disp('ref 7');

% % % % % % % % % 

t_string='Energy  Fairing, Equipment Shelf Example';

if(iu==1)
    y_label='Energy (in-lbf)';       
else
    y_label='Energy (J)';       
end


ppp1=[fc E(1,:)'];
ppp2=[fc E(2,:)'];
ppp3=[fc E(3,:)'];
ppp4=[fc E(4,:)'];

md=6;

[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,ppp3,ppp4,legm1,legm2,legm3,legm4,fmin,fmax,md);

% % % % % % % % % 

% velox psd

md=6;

t_string='Velocity Power Spectral Density';

y_label=sprintf('%s',vpsd_label);

ppp1=[fc vpsd_f];
ppp2=[fc vpsd_s];

leg1=sprintf('Fairing %6.3g %s rms',vrms_f,v_label);
leg2=sprintf('Shelf %6.3g %s rms',vrms_s,v_label);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

% % % % % % % % % 

% accel psd

md=6;

t_string='Acceleration Power Spectral Density';
y_label='Accel (G^2/Hz)';

ppp1=[fc apsd_f];
ppp2=[fc apsd_s];

leg1=sprintf('Fairing %6.3g GRMS',grms_f);
leg2=sprintf('Shelf %6.3g GRMS',grms_s);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

% % % % % % % % % 

disp('  ');
disp('* * * * * * * * * ');
disp('  ');

if(iu==1)
    out1=sprintf(' Fairing mass = %8.4g lbm ',fairing_mass*386);
    out2=sprintf('   Shelf mass = %8.4g lbm  ',shelf_mass*386);   
else
    out1=sprintf(' Fairing mass = %8.4g kg ',fairing_mass);
    out2=sprintf('   Shelf mass = %8.4g kg  ',shelf_mass);    
end
disp(out1);
disp(out2);

disp('  ');
disp(' Dissipation Loss Factors ');
disp(' ');
disp(' Freq(Hz) Fairing  Ring  Cavity  Shelf ');

for i=1:nfc
   out1=sprintf('%7.3f  %6.4f  %6.4f  %6.4f  %6.4f',...
            fc(i),fairing_dlf(i),ring_dlf(i),acoustic_dlf(i),shelf_dlf(i)); 
   disp(out1); 
end

disp('   ');
disp(' Overall Velocity Levels ');
disp('   ');
out1=sprintf('   Fairing = %6.3g %s rms',vrms_f,v_label);
out2=sprintf('     Shelf = %6.3g %s rms',vrms_s,v_label);
disp(out1);
disp(out2);

disp('   ');
disp(' Overall Acceleration Levels ');
disp('   ');
out1=sprintf('   Fairing = %6.3g G rms',grms_f);
out2=sprintf('     Shelf = %6.3g G rms',grms_s);
disp(out1);
disp(out2);


msgbox('Calculation complete. Results written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(SEA_fairing_ring_shelf);


% --- Executes on button press in pushbutton_fairing.
function pushbutton_fairing_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fairing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



f_construction=get(handles.listbox_fairing,'Value');
setappdata(0,'f_construction',f_construction);


if(f_construction==1) % homogeneous
    
    handles.s=SEA_equiv_aco_power_cylinder_fairing_example;

else                  % honeycomb sandwich
    
    handles.s=SEA_equiv_aco_power_cyl_sandwich_fairing_example;    
end

set(handles.s,'Visible','on'); 

set(handles.pushbutton_acoustic_cavity,'Enable','on');
set(handles.pushbutton_calculate,'Enable','off');
set(handles.pushbutton_ring_frame,'Enable','off');
set(handles.pushbutton_shelf,'Enable','off');


% --- Executes on button press in pushbutton_acoustic_cavity.
function pushbutton_acoustic_cavity_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_acoustic_cavity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=acoustic_cavity_fairing_example;

set(handles.s,'Visible','on'); 

set(handles.pushbutton_ring_frame,'Enable','on');







% --- Executes on button press in pushbutton_ring_frame.
function pushbutton_ring_frame_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ring_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=ring_frame_fairing_example;
set(handles.s,'Visible','on');


set(handles.pushbutton_shelf,'Enable','on');
set(handles.listbox_shelf_construction,'Enable','on');
set(handles.listbox_shelf_geometry,'Enable','on');
set(handles.text_scg,'Enable','on');





% --- Executes on button press in pushbutton_shelf.
function pushbutton_shelf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_shelf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

s_construction=get(handles.listbox_shelf_construction,'Value');
s_geometry=get(handles.listbox_shelf_geometry,'Value');


setappdata(0,'s_construction',s_construction);
setappdata(0,'s_geometry',s_geometry);

%%%
%
if(s_construction==1 && s_geometry==1) % homogeneous circular
    handles.s=circular_homogeneous_fairing_example;
end
if(s_construction==1 && s_geometry==2) % honeycomb circular
    handles.s=circular_honeycomb_sandwich_fairing_example;    
end
%
%%%
%
if(s_construction==2 && s_geometry==1) % homogeneous annular
    handles.s=annular_homogeneous_fairing_example;    
end
if(s_construction==2 && s_geometry==2) % honeycomb annular
    handles.s=annular_honeycomb_sandwich_fairing_example;       
end
%
%%%
%
if(s_construction==3 && s_geometry==1) % homogeneous other
    handles.s=other_homogeneous_fairing_example;    
end
if(s_construction==3 && s_geometry==2) % honeycomb other
    handles.s=other_honeycomb_sandwich_fairing_example;       
end
%
%%%
%

set(handles.s,'Visible','on'); 

set(handles.pushbutton_calculate,'Enable','on');




% --- Executes on selection change in listbox_fairing.
function listbox_fairing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fairing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fairing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fairing



% --- Executes during object creation, after setting all properties.
function listbox_fairing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fairing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_shelf_construction.
function listbox_shelf_construction_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_shelf_construction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_shelf_construction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_shelf_construction


% --- Executes during object creation, after setting all properties.
function listbox_shelf_construction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_shelf_construction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_shelf_geometry.
function listbox_shelf_geometry_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_shelf_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_shelf_geometry contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_shelf_geometry



% --- Executes during object creation, after setting all properties.
function listbox_shelf_geometry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_shelf_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_clf.
function pushbutton_clf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_view_diagram.
function pushbutton_view_diagram_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_diagram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('fairing_ring_shelf_diagram.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on selection change in listbox_iu.
function listbox_iu_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_iu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_iu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_iu

pushbutton_reset_Callback(hObject, eventdata, handles);

iu=get(handles.listbox_iu,'Value');
setappdata(0,'iu',iu);

set(handles.pushbutton_acoustic_cavity,'Enable','off');
set(handles.pushbutton_calculate,'Enable','off');
set(handles.pushbutton_ring_frame,'Enable','off');
set(handles.pushbutton_shelf,'Enable','off');


% --- Executes during object creation, after setting all properties.
function listbox_iu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_iu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'external_acoustic_power','');

setappdata(0,'fairing_modal_density','');
setappdata(0,'fairing_rad_eff','');
setappdata(0,'fairing_dlf','');
setappdata(0,'fairing_mass','');
setappdata(0,'fairing_md','');
setappdata(0,'fairing_thick','');
setappdata(0,'fairing_cL','');     
setappdata(0,'fairing_area','');    

setappdata(0,'acoustic_dlf','');
setappdata(0,'acoustic_cavity_modal_density','');   
setappdata(0,'acoustic_cavity_gas_rho_c','');
setappdata(0,'rf_cross_section','');

setappdata(0,'a',''); 
setappdata(0,'b','');   
setappdata(0,'h','');    
setappdata(0,'ring_dlf','');
setappdata(0,'ring_cL','');
setappdata(0,'ring_md','');

setappdata(0,'shelf_mdens','');
setappdata(0,'shelf_dlf','');
setappdata(0,'shelf_mass','');
setappdata(0,'shelf_thick','');
setappdata(0,'shelf_cL','');
setappdata(0,'shelf_md','');
setappdata(0,'shelf_area',''); 
setappdata(0,'shelf_rad_eff',''); 
