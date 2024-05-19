function varargout = SEA_cylindrical_shell_shelf(varargin)
% SEA_CYLINDRICAL_SHELL_SHELF MATLAB code for SEA_cylindrical_shell_shelf.fig
%      SEA_CYLINDRICAL_SHELL_SHELF, by itself, creates a new SEA_CYLINDRICAL_SHELL_SHELF or raises the existing
%      singleton*.
%
%      H = SEA_CYLINDRICAL_SHELL_SHELF returns the handle to a new SEA_CYLINDRICAL_SHELL_SHELF or the handle to
%      the existing singleton*.
%
%      SEA_CYLINDRICAL_SHELL_SHELF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_CYLINDRICAL_SHELL_SHELF.M with the given input arguments.
%
%      SEA_CYLINDRICAL_SHELL_SHELF('Property','Value',...) creates a new SEA_CYLINDRICAL_SHELL_SHELF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_cylindrical_shell_shelf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_cylindrical_shell_shelf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_cylindrical_shell_shelf

% Last Modified by GUIDE v2.5 10-Jun-2016 08:48:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_cylindrical_shell_shelf_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_cylindrical_shell_shelf_OutputFcn, ...
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


% --- Executes just before SEA_cylindrical_shell_shelf is made visible.
function SEA_cylindrical_shell_shelf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_cylindrical_shell_shelf (see VARARGIN)

% Choose default command line output for SEA_cylindrical_shell_shelf
handles.output = hObject;

clc;

fstr='cylindrical_shell_shelf.jpg';

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



set(handles.listbox_iu,'Enable','on');

listbox_iu_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_cylindrical_shell_shelf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_cylindrical_shell_shelf_OutputFcn(hObject, eventdata, handles) 
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

     A = imread('cylindrical_shell_shelf_eq.jpg');
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
%        1=cylindrical shell
%        2=acoustic cavity
%        3=shelf 


disp(' ');
disp(' * * * * * * * * * * * * * ');
disp(' ');

tpi=2*pi;

iu=get(handles.listbox_iu,'Value');

% % %

            power=getappdata(0,'external_acoustic_power');
     external_SPL=getappdata(0,'external_SPL');
            
    cylindrical_shell_modal_density=getappdata(0,'cylindrical_shell_modal_density');
  cylindrical_shell_rad_eff=getappdata(0,'cylindrical_shell_rad_eff');
      cylindrical_shell_dlf=getappdata(0,'cylindrical_shell_dlf');
     cylindrical_shell_mass=getappdata(0,'cylindrical_shell_mass');
       cylindrical_shell_md=getappdata(0,'cylindrical_shell_md');
    cylindrical_shell_thick=getappdata(0,'cylindrical_shell_thick');
       cylindrical_shell_cL=getappdata(0,'cylindrical_shell_cL');     
     cylindrical_shell_area=getappdata(0,'cylindrical_shell_area');    
     cylindrical_shell_diam=getappdata(0,'cylindrical_shell_diam');
     
    cylindrical_shell_fring=getappdata(0,'cylindrical_shell_fring');     
      cylindrical_shell_fcr=getappdata(0,'cylindrical_shell_fcr');      
     
            ecd=cylindrical_shell_dlf;        

%            
            
if isempty(cylindrical_shell_fring)
   warndlg('cylindrical_shell_fring missing. Run cylindrical_shell'); 
   return;
end

if isempty(cylindrical_shell_fcr)
   warndlg('cylindrical_shell_fcr missing. Run cylindrical_shell'); 
   return;
end            

                        
if isempty(power)
   warndlg('power missing. Run cylindrical_shell'); 
   return;
end
if isempty(external_SPL)
   warndlg('external_SPL missing. Run cylindrical_shell'); 
   return;
end
            
if isempty(cylindrical_shell_modal_density)
   warndlg('cylindrical_shell_modal_density missing. Run cylindrical_shell'); 
   return;
end
if isempty(cylindrical_shell_rad_eff)
   warndlg('cylindrical_shell_rad_eff missing. Run cylindrical_shell'); 
   return;
end   
if isempty(cylindrical_shell_dlf)
   warndlg('cylindrical_shell_dlf missing. Run cylindrical_shell'); 
   return;
end   
if isempty(cylindrical_shell_mass)
   warndlg('cylindrical_shell_mass missing. Run cylindrical_shell'); 
   return;
end   
if isempty(cylindrical_shell_md)
   warndlg('cylindrical_shell_md missing. Run cylindrical_shell'); 
   return;
end
if isempty(cylindrical_shell_thick)
   warndlg('cylindrical_shell_thick missing. Run cylindrical_shell'); 
   return;
end   
if isempty(cylindrical_shell_cL)
   warndlg('cylindrical_shell_cL missing. Run cylindrical_shell'); 
   return;
end   
if isempty(cylindrical_shell_area)
   warndlg('cylindrical_shell_area missing. Run cylindrical Shelf'); 
   return;
end  
if isempty(cylindrical_shell_diam)
   warndlg('cylindrical_shell_diam missing. Run cylindrical Shelf'); 
   return;
end   

            
% % %

              acoustic_cavity_dlf=getappdata(0,'acoustic_cavity_dlf');
            acoustic_modal_density=getappdata(0,'acoustic_cavity_modal_density');
    acoustic_cavity_volume=getappdata(0,'acoustic_cavity_volume');          
 acoustic_cavity_gas_rho_c=getappdata(0,'acoustic_cavity_gas_rho_c');
   acoustic_cavity_gas_rho=getappdata(0,'acoustic_cavity_gas_rho');
     acoustic_cavity_gas_c=getappdata(0,'acoustic_cavity_gas_c');
 
            ead=acoustic_cavity_dlf;
      
          
            
if isempty(acoustic_cavity_dlf)
   warndlg('acoustic_cavity_dlf missing. Run Acoustic Cavity'); 
   return;
end  
if isempty(acoustic_modal_density)
   warndlg('acoustic_modal_density missing. Run Acoustic Cavity'); 
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

 shelf_modal_density=getappdata(0,'shelf_modal_density');
           shelf_dlf=getappdata(0,'shelf_dlf');
          shelf_mass=getappdata(0,'shelf_mass');

    
 total_shelf_thick=getappdata(0,'total_shelf_thick');
    total_shelf_md=getappdata(0,'total_shelf_md');
          shelf_cL=getappdata(0,'shelf_cL');
        shelf_area=getappdata(0,'shelf_area');         
     shelf_rad_eff=getappdata(0,'shelf_rad_eff');      
         shelf_fcr=getappdata(0,'shelf_fcr');  
    
              esd=shelf_dlf;     
              
if isempty(shelf_fcr)
   warndlg('shelf_fcr missing. Run Equipment Shelf'); 
   return;
end                     
              
if isempty(shelf_modal_density)
   warndlg('shelf_modal_density missing. Run Equipment Shelf'); 
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
if isempty(total_shelf_thick)
   warndlg('total_shelf_thick missing. Run Equipment Shelf'); 
   return;
end     
if isempty(shelf_cL)
   warndlg('shelf_cL missing. Run Equipment Shelf'); 
   return;
end     
if isempty(total_shelf_md)
   warndlg('total_shelf_md missing. Run Equipment Shelf'); 
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
 cylindrical_shell_rad_res=cylindrical_shell_rad_eff*acoustic_cavity_gas_rho_c*cylindrical_shell_area;

 
% % %

fc=power(:,1);

nfc=length(power(:,1));

E=zeros(3,nfc);

eca=zeros(nfc,1);
eac=zeros(nfc,1);

ecs=zeros(nfc,1);
esc=zeros(nfc,1);

eas=zeros(nfc,1);
esa=zeros(nfc,1);

cylindrical_shell_mo=zeros(nfc,1);
shelf_mo=zeros(nfc,1);

power_cavity_shelf=zeros(nfc,1);
power_shelf_cavity=zeros(nfc,1);

power_cylindrical_shell_shelf=zeros(nfc,1);
power_cylindrical_shell_cavity=zeros(nfc,1);

cylindrical_shell_tlf=zeros(nfc,1);
shelf_tlf=zeros(nfc,1);

% % %
% % %

omega=tpi*fc;

N=str2num(get(handles.edit_nbolts,'String'));

if isempty(N)
   warndlg('Enter number of bolts.'); 
   return;
end

S_1=cylindrical_shell_area;
S_2=shelf_area;
md_1=cylindrical_shell_md;
md_2=total_shelf_md;
thick_1=cylindrical_shell_thick;
thick_2=total_shelf_thick;
cL_1=cylindrical_shell_cL;
cL_2=shelf_cL;

for i=1:nfc
    
    P=[ power(i,2)  0  0  ]';
    P=P/omega(i);

%%%

    eca(i)=(cylindrical_shell_rad_res(i)/cylindrical_shell_mass)/omega(i);
    eac(i)=eca(i)*(cylindrical_shell_modal_density(i)/acoustic_modal_density(i));    

    esa(i)=(shelf_rad_res(i)/shelf_mass)/omega(i);
    eas(i)=esa(i)*(shelf_modal_density(i)/acoustic_modal_density(i));    
    
    [clf_12,~]=clf_bolted_joint_alt(N,fc(i),S_1,S_2,md_1,md_2,thick_1,thick_2,cL_1,cL_2);
    
    ecs(i)=clf_12;
    esc(i)=ecs(i)*(cylindrical_shell_modal_density(i)/shelf_modal_density(i));
%%%
    A=zeros(3,3);
    
    A(1,1)=  ecd(i)+eca(i)+ecs(i);
    A(1,2)= -eac(i);
    A(1,3)= -esc(i);
    
    A(2,1)= -eca(i);
    A(2,2)=  ead(i)+eac(i)+eas(i);
    A(2,3)= -esa(i);
    
    A(3,1)= -ecs(i);
    A(3,2)= -eas(i);
    A(3,3)=  esd(i)+esa(i)+esc(i);
        
    E(:,i)=A\P;
    
    
    cylindrical_shell_tlf(i)=A(1,1);
    shelf_tlf(i)=A(3,3);

    cylindrical_shell_mo(i)=A(1,1)*cylindrical_shell_modal_density(i)*fc(i);
                shelf_mo(i)=A(3,3)*shelf_modal_density(i)*fc(i);
   
                
power_cylindrical_shell_cavity(i)=(eca(i)*E(1,i)-eac(i)*E(2,i))*omega(i);

 power_cylindrical_shell_shelf(i)=(ecs(i)*E(1,i)-esc(i)*E(3,i))*omega(i);
            power_cavity_shelf(i)=(eas(i)*E(2,i)-esa(i)*E(3,i))*omega(i);
            power_shelf_cavity(i)=(esa(i)*E(3,i)-eas(i)*E(2,i))*omega(i);                
                
end

    disp(' ');

  [cylindrical_shell_fmo,cyl_index1]=find_mo_freq(fc,cylindrical_shell_mo);
                      [shelf_fmo,cyl_index3]=find_mo_freq(fc,shelf_mo);
 
                      
cylindrical_shell_fmo=max([ cylindrical_shell_fmo  cylindrical_shell_fring*0.8909  ]);  
                                  
if(shelf_fmo<cylindrical_shell_fmo)
    shelf_fmo=cylindrical_shell_fmo;
end
 
cyl_index=1;

for i=1:nfc
    if(fc(i)>=cylindrical_shell_fmo)
        cyl_index=i;
        break;
    end    
end
                      
                  
E=abs(E);


 feng=fc(cyl_index:nfc);

 E=E(:,cyl_index:nfc);   

xpower=power(cyl_index:nfc,:);

xpower_cylindrical_shell_cavity=power_cylindrical_shell_cavity(cyl_index:nfc,:);

 xpower_cylindrical_shell_shelf=power_cylindrical_shell_shelf(cyl_index:nfc,:);
            xpower_cavity_shelf=power_cavity_shelf(cyl_index:nfc,:);
            xpower_shelf_cavity=power_shelf_cavity(cyl_index:nfc,:);

ppp=(E(2,:)/acoustic_cavity_volume)*(acoustic_cavity_gas_rho*acoustic_cavity_gas_c^2);


pressure_cavity=sqrt(ppp);



if(iu==1)  % convert psi to Pa
    pressure_cavity=pressure_cavity*6891.2;
end

ref=20e-06;
pressure_cavity_dB=20*log10(pressure_cavity/ref);


% % % % % % % % %

ffc=feng;

while(1)
    if(E(1,1)>1.0e-10)
        break;
    else
        ffc(1)=[];
        E(:,1)=[];
        power_cavity_shelf(1)=[];
        power_cylindrical_shell_shelf(1)=[];
        power_cylindrical_shell_cavity(1)=[];
    end
end


% % % % % % % % %

nb=1;   % one-third octave

omega=tpi*ffc;

[velox_c,accel_c,~,~]=...
         energy_to_velox_accel_alt(iu,E(1,:),cylindrical_shell_mass,omega);
     
[velox_s,accel_s,v_label,vpsd_label]=...
         energy_to_velox_accel_alt(iu,E(3,:),shelf_mass,omega);

[vpsd_c,~]=psd_from_spectrum(nb,ffc,velox_c);  
[vpsd_s,~]=psd_from_spectrum(nb,ffc,velox_s);



% % % % % % % % % 

[apsd_c,~]=psd_from_spectrum(nb,ffc,accel_c);  
[apsd_s,~]=psd_from_spectrum(nb,ffc,accel_s);  


% % % % % % % % % 
% % % % % % % % % 



fig_num=1;

x_label='Frequency (Hz)';

legm1='Cylindrical Shell';
legm2='Acoustic Cavity';
legm3='Equipment Shelf';


% % % % % % % % % 
% % % % % % % % % 

% input spl & aco cavity spl    figure 1

f1=fc;
dB1=external_SPL(:,2);
f2=ffc;
dB2=fix_size(pressure_cavity_dB);

[fcp,xdB2]=remove_zeros(f2,dB2);

string_1='Cylindrical Shell External';
string_2='Acoustic Cavity';

n_type=1;  % one-third octave

[fig_num]=spl_plot_two(fig_num,n_type,f1,dB1,fcp,xdB2,string_1,string_2);


output_name_11='acoustic_cavity_spl';
assignin('base',output_name_11,[ffc dB2]);
%%% disp(output_name_11);
 

% disp('ref 1');

% % % % % % % % %

Nf1=length(f1);
Ncp=length(fcp);

TL_dB=zeros(Ncp,1);

for i=1:Ncp
    
    for j=1:Nf1
        if( abs(f1(j)-fcp(i))<1)
            TL_dB(i)=dB1(j)-xdB2(i);
            break;
        end
    end
    
end

[fig_num]=tl_plot(fig_num,fcp,TL_dB);

output_name_21='transmission_loss';
assignin('base',output_name_21,[ffc dB2]);
%%% disp(output_name_21);

% % % % % % % % %

% modal overlap

md=4;

t_string='Modal Overlap';
y_label='Modal Overlap';

[fmo1,xmo1]=remove_zeros(fc, cylindrical_shell_mo);
[fmo2,xmo2]=remove_zeros(fc, shelf_mo);


if(length(xmo1)==0)
    warndlg('Cylindrical shell has modal overlap < 1 across all frequencies.');
    return;
end
if(length(xmo2)==0)
    warndlg('Equipment shelf has modal overlap < 1 across all frequencies.');    
    return;
end

ppp1=[fmo1 xmo1];
ppp2=[fmo2 xmo2];

minf=min([ min(fmo1) min(fmo2)]);
maxf=max([ max(fmo1) max(fmo2)]);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
y_label,t_string,ppp1,ppp2,legm1,legm3,minf,maxf,md);

    
output_name_31='cylindrical_shell_modal_overlap';
output_name_32='equipment_shelf_modal_overlap';

assignin('base',output_name_31,ppp1);
assignin('base',output_name_32,ppp2);

%%% disp(output_name_31);
%%% disp(output_name_32);  




% disp('ref 4');

% % % % % % % % % 

% power, ext & int flows   figure 2

md=8;

t_string='Power Flow';

[fpf1,pf1]=remove_zeros(xpower(:,1),xpower(:,2));
[fpf2,pf2]=remove_zeros(ffc, xpower_cylindrical_shell_cavity);
[fpf3,pf3]=remove_zeros(ffc, xpower_cylindrical_shell_shelf);
[fpf4,pf4]=remove_zeros_all(ffc, xpower_cavity_shelf);
[fpf5,pf5]=remove_zeros_all(ffc, xpower_shelf_cavity);

%

ppp1=[fpf1 pf1];
ppp2=[fpf2 pf2];
ppp3=[fpf3 pf3];
ppp4=[fpf4 pf4];
ppp5=[fpf5 pf5];

leg1='External->Cylinder';
leg2='Cylinder->Cavity';
leg3='Cylinder->Shelf';
leg4='Cavity->Shelf';
leg5='Shelf->Cavity';

output_name_41='external_to_cylinder_power';
output_name_42='cylinder_to_cavity_power';
output_name_43='cylinder_to_shelf_power';
output_name_44='cavity_to_shelf_power';
output_name_45='shelf_to_cavity_power';

assignin('base',output_name_41,ppp1);
assignin('base',output_name_42,ppp2);
assignin('base',output_name_43,ppp3);
assignin('base',output_name_44,ppp4); 
assignin('base',output_name_45,ppp5);

%%% disp(output_name_41);
%%% disp(output_name_42);  
%%% disp(output_name_43);
%%% disp(output_name_44);
%%% disp(output_name_45);


if(iu==1)
    y_label='Power (in-lbf/sec)';    
else
    y_label='Power (W)';    
end

minf=min(fpf1);
maxf=max(fpf1);

sz1=size(ppp1);
sz2=size(ppp2);
sz3=size(ppp3);
sz4=size(ppp4);
sz5=size(ppp5);


if(sz1(2)==0)
   warndlg('Transmitted Power error 1'); 
   return; 
end
if(sz2(2)==0)
   warndlg('Transmitted Power error 2');     
   return; 
end
if(sz3(2)==0)
   warndlg('Transmitted Power error 3');     
   return; 
end



if( sz4(1)>1 && sz5(1)>1)
    [fig_num,h2]=plot_loglog_function_md_five_h2(fig_num,x_label,...
    y_label,t_string,ppp1,ppp2,ppp3,ppp4,ppp5,leg1,leg2,leg3,leg4,leg5,minf,maxf,md);   
end
if( sz4(1)>1 && sz5(1)<=1) 
    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
    y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,minf,maxf,md);        
 
end
if( sz4(1)<=1 && sz5(1)>1) 
    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
    y_label,t_string,ppp1,ppp2,ppp3,ppp5,leg1,leg2,leg3,leg5,minf,maxf,md);        
end
if(sz4(1)<=1 && sz5(1)<=1) 
    [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
    y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,minf,maxf,md);        
 
end
 
% % % % % % % % % 
     
% modal_density  figure 3

md=7;

t_string='Modal Density';
y_label='n (modes/Hz)';


[fmodal_density1,xmodal_density1]=remove_zeros(fc, cylindrical_shell_modal_density);
[fmodal_density2,xmodal_density2]=remove_zeros(fc, acoustic_modal_density);
[fmodal_density3,xmodal_density3]=remove_zeros(fc, shelf_modal_density);

ppp1=[fmodal_density1 xmodal_density1];
ppp2=[fmodal_density2 xmodal_density2];
ppp3=[fmodal_density3 xmodal_density3];

minf=min([ min(fmodal_density1) min(fmodal_density2)  min(fmodal_density3) ]);
maxf=max([ max(fmodal_density1) max(fmodal_density2)  max(fmodal_density3) ]);

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
y_label,t_string,ppp1,ppp2,ppp3,legm1,legm2,legm3,minf,maxf,md);


output_name_51='cylindrical_shell_modal_dens';
output_name_52='acoustic_cavity_modal_dens';
output_name_53='equipment_shelf_modal_dens';

assignin('base',output_name_51,ppp1);
assignin('base',output_name_52,ppp2);
assignin('base',output_name_53,ppp2);

%%% disp(output_name_51);
%%% disp(output_name_52);  
%%% disp(output_name_53);  


% disp('ref 3');

% % % % % % % % %

% rad eff

md=6;

t_string='Radiation Efficiency';
y_label='Rad Eff';

[fxre1,xre1]=remove_zeros(fc, cylindrical_shell_rad_eff);
[fxre2,xre2]=remove_zeros(fc, shelf_rad_eff);

ppp1=[fxre1 xre1];
ppp2=[fxre2 xre2];


[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,legm1,legm3,min(ffc),max(ffc),md);
     

output_name_61='cylindrical_shell_rad_eff';
output_name_62='equipment_shelf_rad_eff';

assignin('base',output_name_61,ppp1);
assignin('base',output_name_62,ppp2);

%%% disp(output_name_61);
%%% disp(output_name_62);         
         
         
% disp('ref 5');         

% % % % % % % % % 

% dlf2

md=4;

t_string='Dissipation Loss Factors';
y_label='dlf';

ppp1=[fc cylindrical_shell_dlf];
ppp2=[fc acoustic_cavity_dlf];
ppp3=[fc shelf_dlf];

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...             
   y_label,t_string,ppp1,ppp2,ppp3,legm1,legm2,legm3,min(fc),max(fc),md);


output_name_71='cylindrical_shell_dlf';
output_name_72='acoustic_cavity_dlf';
output_name_73='equipment_shelf_dlf';

assignin('base',output_name_71,ppp1);
assignin('base',output_name_72,ppp2);
assignin('base',output_name_73,ppp3);

%%% disp(output_name_71);
%%% disp(output_name_72);         
%%% disp(output_name_73);

% disp('ref 5');

% % % % % % % % % 
           

% disp('ref 6');

% % % % % % % % % 

% clf shelf

md=7;


[fclf1,xeca]=remove_zeros(fc,eca);
[fclf2,xecs]=remove_zeros(fc,ecs);
[fclf3,xeas]=remove_zeros(fc,eas);
[fclf4,xesa]=remove_zeros(fc,esa);

ppp1=[fclf1,xeca];
ppp2=[fclf2,xecs];
ppp3=[fclf3,xeas];   
ppp4=[fclf4,xesa]; 
    
leg1='Cylinder->Cavity';
leg2='Cylinder->Shelf';
leg3='Cavity->Shelf';
leg4='Shelf->Cavity';

minf=min([ min(fclf1) min(fclf2)  min(fclf3)  min(fclf4) ]);
maxf=max([ max(fclf1) max(fclf2)  max(fclf3)  max(fclf4)]);


t_string='Coupling Loss Factors';
y_label='clf';

[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...             
   y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,minf,maxf,md);    
    

output_name_81='cylinder_to_cavity_clf';
output_name_82='cylinder_to_shelf_clf';
output_name_83='cavity_to_shelf_clf';
output_name_84='shelf_to_cavity_clf';

assignin('base',output_name_81,ppp1);
assignin('base',output_name_82,ppp2);
assignin('base',output_name_83,ppp3);
assignin('base',output_name_84,ppp4);

%%% disp(output_name_81);
%%% disp(output_name_82);         
%%% disp(output_name_83);
%%% disp(output_name_84);

% disp('ref 7');

% % % % % % % % % 

t_string='Energy  Cylindrical Shell, Equipment Shelf Example';

if(iu==1)
    y_label='Energy (in-lbf)';       
else
    y_label='Energy (J)';       
end

[fe1,xE1]=remove_zeros(ffc,E(1,:)');
[fe2,xE2]=remove_zeros(ffc,E(2,:)');
[fe3,xE3]=remove_zeros(ffc,E(3,:)');

ppp1=[fe1 xE1];
ppp2=[fe2 xE2];
ppp3=[fe3 xE3];

md=6;

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,ppp3,legm1,legm2,legm3,min(fe1),max(fe1),md);

output_name_91='cylindrical_shell_energy';
output_name_92='acoustic_cavity_energy';
output_name_93='equipment_shelf_energy';

assignin('base',output_name_91,ppp1);
assignin('base',output_name_92,ppp2);
assignin('base',output_name_93,ppp3);

%%% disp(output_name_91);
%%% disp(output_name_92);         
%%% disp(output_name_93);
 
% % % % % % % % % 

% velox psd

md=6;

t_string='Velocity Power Spectral Density';

y_label=sprintf('%s',vpsd_label);

[fvc,xvpsd_c]=remove_zeros(ffc,vpsd_c);
[fvs,xvpsd_s]=remove_zeros(ffc,vpsd_s);

ppp1=[fvc xvpsd_c];
ppp2=[fvs xvpsd_s];

[~,vrms_c] = calculate_PSD_slopes(fvc,xvpsd_c);
[~,vrms_s] = calculate_PSD_slopes(fvs,xvpsd_s);


leg1=sprintf('Cylindrical Shell %6.3g %s rms',vrms_c,v_label);
leg2=sprintf('Shelf %6.3g %s rms',vrms_s,v_label);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,leg1,leg2,min(fvc),max(fvc),md);

output_name_101='cylindrical_shell_vel_psd';
output_name_102='equipment_shelf_vel_psd';

assignin('base',output_name_101,ppp1);
assignin('base',output_name_102,ppp2);

%%% disp(output_name_101);
%%% disp(output_name_102);         
         
% % % % % % % % % 

% accel psd

md=6;

t_string='Acceleration Power Spectral Density';
y_label='Accel (G^2/Hz)';

[fpsdc,xapsd_c]=remove_zeros(ffc,apsd_c);
[fpsds,xapsd_s]=remove_zeros(ffc,apsd_s);

ppp1=[fpsdc xapsd_c];
ppp2=[fpsds xapsd_s];

[~,grms_c] = calculate_PSD_slopes(fpsdc,xapsd_c);
[~,grms_s] = calculate_PSD_slopes(fpsds,xapsd_s);

leg1=sprintf('Cylindrical Shell %6.3g GRMS',grms_c);
leg2=sprintf('Shelf %6.3g GRMS',grms_s);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,leg1,leg2,min(fpsdc),max(fpsdc),md);

output_name_111='cylindrical_shell_accel_psd';
output_name_112='equipment_shelf_accel_psd';

assignin('base',output_name_111,ppp1);
assignin('base',output_name_112,ppp2);

%%% disp(output_name_111);
%%% disp(output_name_112);

% % % % % % % % % 

feet_per_meter=3.28084;
feet_per_inch=1/12;
kg_per_lbm=2.205;

if(iu==1)
    c_mass=cylindrical_shell_mass*386;
    c_area=cylindrical_shell_area/12^2;
else
    c_mass=cylindrical_shell_mass*kg_per_lbm;
    c_area=cylindrical_shell_area*feet_per_meter^2;
end 

W_lbm_per_ft2=c_mass/c_area;

if(iu==1)
     stationdiam_ft=cylindrical_shell_diam*feet_per_inch;
    cmat_ft_per_sec=cylindrical_shell_cL*feet_per_inch;    
else
     stationdiam_ft=cylindrical_shell_diam*feet_per_meter;
    cmat_ft_per_sec=cylindrical_shell_cL*feet_per_meter;      
end    

 
f=external_SPL(:,1);
spl=external_SPL(:,2);

[Franken_psd]=Franken_function(stationdiam_ft,W_lbm_per_ft2,cmat_ft_per_sec,f,spl);

md=6;  

t_string='Acceleration PSD  Cylindrical Shell';
y_label='Accel (G^2/Hz)';


ppp1=[fpsdc xapsd_c];
ppp2=[f Franken_psd];
  

[~,grms_c] = calculate_PSD_slopes(fpsdc,xapsd_c);
[~,grms_f] = calculate_PSD_slopes(f,Franken_psd);

leg1=sprintf('    SEA %6.3g GRMS',grms_c);
leg2=sprintf('Franken %6.3g GRMS',grms_f);
  

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,leg1,leg2,min(f),max(f),md);         
       
         
% % % % % % % % %

disp('  ');
disp(' Cylindrical Shell ');

disp('         Modal      Total              '); 
disp(' Freq   Density     Loss      Modal    ');  
disp(' (Hz)  (modes/Hz)   Factor   Overlap   ');

for i=1:nfc
   out1=sprintf('%7.1f  %6.3f    %6.3f   %6.3f ',...
         fc(i),cylindrical_shell_modal_density(i),...
               cylindrical_shell_tlf(i),...
               cylindrical_shell_mo(i)); 
   disp(out1); 
end

% % % % % % % % %

disp('  ');
disp(' Equipment Shelf ');

disp('         Modal      Total              '); 
disp(' Freq   Density     Loss      Modal    ');  
disp(' (Hz)  (modes/Hz)   Factor   Overlap   ');

for i=1:nfc
   out1=sprintf('%7.1f  %6.3f    %6.3f   %6.3f ',...
                    fc(i),shelf_modal_density(i),shelf_tlf(i),shelf_mo(i)); 
   disp(out1); 
end

% %

disp('  ');
disp('  Dissipation Loss Factors ');
disp(' ');
disp(' Freq     Cyl    Acou    Equip ');
disp(' (Hz)    Shell  Cavity   Shelf ');

for i=1:nfc
   out1=sprintf('%7.3f  %6.4f  %6.4f  %6.4f',...
            fc(i),cylindrical_shell_dlf(i),acoustic_cavity_dlf(i),shelf_dlf(i)); 
   disp(out1); 
end

%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Output array names for Matlab Workspace ');
disp(' ');

disp(output_name_11);
disp(output_name_21);

disp(output_name_31);
disp(output_name_32);

disp(output_name_41);
disp(output_name_42);  
disp(output_name_43);
disp(output_name_44);
disp(output_name_45);

disp(output_name_51);
disp(output_name_52);  
disp(output_name_53);

disp(output_name_61);
disp(output_name_62);

disp(output_name_71);
disp(output_name_72);         
disp(output_name_73);

disp(output_name_81);
disp(output_name_82);         
disp(output_name_83);
disp(output_name_84);

disp(output_name_91);
disp(output_name_92);        
disp(output_name_93);

disp(output_name_101);
disp(output_name_102); 

disp(output_name_111);
disp(output_name_112);


%%%%%%%%%%%%%%%%%

disp('  ');
if(iu==1)
    out1=sprintf(' Cylindrical Shell mass = %8.4g lbm ',cylindrical_shell_mass*386);
    out2=sprintf('             Shelf mass = %8.4g lbm  ',shelf_mass*386);   
else
    out1=sprintf(' Cylindrical Shell mass = %8.4g kg ',cylindrical_shell_mass);
    out2=sprintf('             Shelf mass = %8.4g kg  ',shelf_mass);    
end
disp(out1);
disp(out2);

%%%%%%%%%%%%%%%%%

disp('   ');
out1=sprintf('     Cylindrical Shell Ring Frequency = %7.4g Hz \n',cylindrical_shell_fring);
out2=sprintf(' Cylindrical Shell Critical Frequency = %7.4g Hz',cylindrical_shell_fcr);
out3=sprintf('   Equipment Shelf Critical Frequency = %7.4g Hz',shelf_fcr);
disp(out1);
disp(out2);
disp(out3);

disp('   ');
disp(' Overall Velocity Levels ');
disp('   ');
out1=sprintf('   Cylindrical Shell = %6.3g %s rms',vrms_c,v_label);
out2=sprintf('     Equipment Shelf = %6.3g %s rms',vrms_s,v_label);
disp(out1);
disp(out2);


disp('   ');
disp(' Overall Acceleration Levels ');
disp('   ');
out1=sprintf('   Cylindrical Shell = %6.3g G rms',grms_c);
out2=sprintf('     Equipment Shelf = %6.3g G rms',grms_s);
disp(out1);
disp(out2);


msgbox('Calculation complete. Results written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(SEA_cylindrical_shell_shelf);


% --- Executes on button press in pushbutton_cylindrical_shell.
function pushbutton_cylindrical_shell_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cylindrical_shell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_iu,'Value');
setappdata(0,'iu',iu);


f_construction=get(handles.listbox_cylindrical_shell,'Value');
setappdata(0,'f_construction',f_construction);


if(f_construction==1) % homogeneous
    
    handles.s=SEA_equiv_aco_power_cylindrical_shell_example;

else                  % honeycomb sandwich
    
    handles.s=SEA_equiv_aco_power_sandwich_cylindrical_shell_ex;    
end

set(handles.s,'Visible','on'); 




% --- Executes on button press in pushbutton_acoustic_cavity.
function pushbutton_acoustic_cavity_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_acoustic_cavity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_iu,'Value');
setappdata(0,'iu',iu);

handles.s=acoustic_cavity_cylindrical_shell_example;

set(handles.s,'Visible','on'); 






% --- Executes on button press in pushbutton_shelf.
function pushbutton_shelf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_shelf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_iu,'Value');
setappdata(0,'iu',iu);

s_construction=get(handles.listbox_shelf_construction,'Value');
s_geometry=get(handles.listbox_shelf_geometry,'Value');


setappdata(0,'s_construction',s_construction);
setappdata(0,'s_geometry',s_geometry);

%%%
%
if(s_construction==1 && s_geometry==1) % homogeneous circular
    handles.s=circular_homogeneous_cylindrical_shell_example;
end
if(s_construction==2 && s_geometry==1) % honeycomb circular
    handles.s=circular_honeycomb_sandwich_cylindrical_shell_example;    
end
%
%%%
%
if(s_construction==1 && s_geometry==2) % homogeneous annular
    handles.s=annular_homogeneous_cylindrical_shell_example;    
end
if(s_construction==2 && s_geometry==2) % honeycomb annular
    handles.s=annular_honeycomb_sandwich_cylindrical_shell_example;       
end
%
%%%
%
if(s_construction==1 && s_geometry==3) % homogeneous other
    handles.s=other_homogeneous_cylindrical_shell_example;    
end
if(s_construction==2 && s_geometry==3) % honeycomb other
    handles.s=other_honeycomb_sandwich_cylindrical_shell_example;       
end
%
%%%
%

set(handles.s,'Visible','on'); 

set(handles.pushbutton_calculate,'Enable','on');




% --- Executes on selection change in listbox_cylindrical_shell.
function listbox_cylindrical_shell_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cylindrical_shell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cylindrical_shell contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cylindrical_shell
clear_cylindrical_shell(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_cylindrical_shell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cylindrical_shell (see GCBO)
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
clear_shelf(hObject, eventdata, handles);

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
clear_shelf(hObject, eventdata, handles);


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

     A = imread('cylindrical_shell_example_clf.jpg');
     figure(991) 
     imshow(A,'border','tight','InitialMagnification',100) 


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

clear_cylindrical_shell(hObject, eventdata, handles);
clear_acoustic(hObject, eventdata, handles);
clear_shelf(hObject, eventdata, handles);

iu=get(handles.listbox_iu,'Value');
setappdata(0,'iu',iu);




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

clear_cylindrical_shell(hObject, eventdata, handles);
clear_acoustic(hObject, eventdata, handles);
clear_shelf(hObject, eventdata, handles);
set(handles.edit_nbolts,'String','');

msgbox('Reset Complete');


function clear_cylindrical_shell(hObject, eventdata, handles)

setappdata(0,'external_acoustic_power','');
setappdata(0,'external_SPL','');
setappdata(0,'cylindrical_shell_modal_density','');
setappdata(0,'cylindrical_shell_rad_eff','');
setappdata(0,'cylindrical_shell_dlf','');
setappdata(0,'cylindrical_shell_mass','');
setappdata(0,'cylindrical_shell_md','');
setappdata(0,'cylindrical_shell_thick','');
setappdata(0,'cylindrical_shell_cL','');     
setappdata(0,'cylindrical_shell_area',''); 
setappdata(0,'cylindrical_shell_fring',''); 
setappdata(0,'cylindrical_shell_fcr','');     
setappdata(0,'cylindrical_shell_c','');

setappdata(0,'cylindrical_shell_gas_md','');
setappdata(0,'cylindrical_shell_diam','');
setappdata(0,'cylindrical_shell_L','');
setappdata(0,'cylindrical_shell_ng','');
setappdata(0,'cylindrical_shell_nd','');





setappdata(0,'cylindrical_homogeneous_shell_mat','');
setappdata(0,'cylindrical_homogeneous_shell_em','');
setappdata(0,'cylindrical_homogeneous_shell_rho','');
setappdata(0,'cylindrical_homogeneous_shell_mu','');

setappdata(0,'cylindrical_honeycomb_shell_mat','');
setappdata(0,'cylindrical_honeycomb_shell_bc','');
setappdata(0,'cylindrical_honeycomb_shell_nfa','');
setappdata(0,'cylindrical_honeycomb_shell_em','');
setappdata(0,'cylindrical_honeycomb_shell_md_f','');
setappdata(0,'cylindrical_honeycomb_shell_mu','');
setappdata(0,'cylindrical_honeycomb_shell_thick_f','');
setappdata(0,'cylindrical_honeycomb_shell_G','');
setappdata(0,'cylindrical_honeycomb_shell_md_c','');
setappdata(0,'cylindrical_honeycomb_shell_thick_c','');
setappdata(0,'cylindrical_shell_construction','');


function clear_acoustic(hObject, eventdata, handles)

setappdata(0,'acoustic_cavity_dlf','');
setappdata(0,'acoustic_cavity_modal_density',''); 
setappdata(0,'acoustic_cavity_volume','');  
setappdata(0,'acoustic_cavity_gas_rho_c','');
setappdata(0,'acoustic_cavity_gas_rho','');
setappdata(0,'acoustic_cavity_gas_c','');

setappdata(0,'acoustic_cavity_ns','');
setappdata(0,'acoustic_cavity_imed','');
setappdata(0,'acoustic_cavity_diameter','');
setappdata(0,'acoustic_cavity_H','');



function clear_shelf(hObject, eventdata, handles)

setappdata(0,'shelf_modal_density','');
setappdata(0,'shelf_dlf','');
setappdata(0,'shelf_mass','');
setappdata(0,'total_shelf_thick','');
setappdata(0,'shelf_cL','');
setappdata(0,'total_shelf_md','');
setappdata(0,'shelf_area',''); 
setappdata(0,'shelf_rad_eff',''); 
setappdata(0,'shelf_fcr','');  
setappdata(0,'shelf_NSM','');
setappdata(0,'shelf_ndlf','');


setappdata(0,'homogeneous_shelf_E','');
setappdata(0,'homogeneous_shelf_rho','');
setappdata(0,'homogeneous_shelf_mu','');
setappdata(0,'homogeneous_shelf_H','');
setappdata(0,'homogeneous_shelf_imat','');

setappdata(0,'circular_shelf_diam','');

setappdata(0,'annular_shelf_OD','');
setappdata(0,'annular_shelf_ID','');

setappdata(0,'honeycomb_shelf_em','');
setappdata(0,'honeycomb_shelf_md_f','');
setappdata(0,'honeycomb_shelf_mu','');
setappdata(0,'honeycomb_shelf_thick_f','');
setappdata(0,'honeycomb_shelf_G','');
setappdata(0,'honeycomb_shelf_md_c','');
setappdata(0,'honeycomb_shelf_thick_c','');


function edit_nbolts_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nbolts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nbolts as text
%        str2double(get(hObject,'String')) returns contents of edit_nbolts as a double


% --- Executes during object creation, after setting all properties.
function edit_nbolts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nbolts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_cylindrical_shell.
function listbox_fairing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cylindrical_shell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cylindrical_shell contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cylindrical_shell


% --- Executes during object creation, after setting all properties.
function listbox_fairing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cylindrical_shell (see GCBO)
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

%%%%%%%%%%
%%%%%%%%%%

k=1;
 
try  
    iu=get(handles.listbox_iu,'Value');
    iu_s=sprintf('%d',iu);
    str_array{k, 1} = 'iu';
    str_array{k, 2} = iu_s;
    k=k+1;
end
try  
    cylindrical_shell_construction=get(handles.listbox_cylindrical_shell,'Value');
    cylindrical_shell_construction_s=sprintf('%d',cylindrical_shell_construction);
    str_array{k, 1} = 'cylindrical_shell_construction';
    str_array{k, 2} = cylindrical_shell_construction_s;
    k=k+1;
    
end
try  
    shelf_geometry=get(handles.listbox_shelf_geometry,'Value');
    shelf_geometry_s=sprintf('%d',shelf_geometry);
    str_array{k, 1} = 'shelf_geometry';
    str_array{k, 2} = shelf_geometry_s;
    k=k+1;
end
try  
    shelf_construction=get(handles.listbox_shelf_construction,'Value');
    shelf_construction_s=sprintf('%d',shelf_construction);
    str_array{k, 1} = 'shelf_construction';
    str_array{k, 2} = shelf_construction_s;
    k=k+1;
end
try  
    nbolts=str2num(get(handles.edit_nbolts,'String'));
    nbolts_s=sprintf('%g',nbolts);
    str_array{k, 1} = 'nbolts';
    str_array{k, 2} = nbolts_s;
    k=k+1;
catch    
end
try  
    FS=getappdata(0,'external_spl_name');
    str_array{k, 1} = 'external_spl_name';
    str_array{k, 2} = FS;
    k=k+1;
catch    
end

try  
    cylindrical_shell_mass=getappdata(0,'cylindrical_shell_mass');
    str_array{k, 1} = 'cylindrical_shell_mass';
    str_array{k, 2} = cylindrical_shell_mass;
    k=k+1;
catch    
end

try  
    cylindrical_shell_md=getappdata(0,'cylindrical_shell_md');
    str_array{k, 1} = 'cylindrical_shell_md';
    str_array{k, 2} = cylindrical_shell_md;
    k=k+1;
catch    
end

try  
    cylindrical_shell_thick=getappdata(0,'cylindrical_shell_thick');
    str_array{k, 1} = 'cylindrical_shell_thick';
    str_array{k, 2} = cylindrical_shell_thick;
    k=k+1;
catch    
end

try  
    cylindrical_shell_cL=getappdata(0,'cylindrical_shell_cL');
    str_array{k, 1} = 'cylindrical_shell_cL';
    str_array{k, 2} = cylindrical_shell_cL;
    k=k+1;
catch    
end

try  
    cylindrical_shell_area=getappdata(0,'cylindrical_shell_area');
    str_array{k, 1} = 'cylindrical_shell_area';
    str_array{k, 2} = cylindrical_shell_area;
    k=k+1;
catch    
end

try  
    cylindrical_shell_fring=getappdata(0,'cylindrical_shell_fring');
    str_array{k, 1} = 'cylindrical_shell_fring';
    str_array{k, 2} = cylindrical_shell_fring;
    k=k+1;
catch    
end

try  
    cylindrical_shell_fcr=getappdata(0,'cylindrical_shell_fcr');
    str_array{k, 1} = 'cylindrical_shell_fcr';
    str_array{k, 2} = cylindrical_shell_fcr;
    k=k+1;
catch    
end

try  
    cylindrical_shell_L=getappdata(0,'cylindrical_shell_L');
    str_array{k, 1} = 'cylindrical_shell_L';
    str_array{k, 2} =cylindrical_shell_L;
    k=k+1;
catch    
end

try  
    cylindrical_shell_ng=getappdata(0,'cylindrical_shell_ng');
    str_array{k, 1} = 'cylindrical_shell_ng';
    str_array{k, 2} = cylindrical_shell_ng;
    k=k+1;
catch    
end

try  
    cylindrical_shell_nd=getappdata(0,'cylindrical_shell_nd');
    str_array{k, 1} = 'cylindrical_shell_nd';
    str_array{k, 2} = cylindrical_shell_nd;
    k=k+1;
catch    
end

try  
    cylindrical_shell_c=getappdata(0,'cylindrical_shell_c');
    str_array{k, 1} = 'cylindrical_shell_c';
    str_array{k, 2} = cylindrical_shell_c;
    k=k+1;
catch    
end


try  
    cylindrical_shell_gas_md=getappdata(0,'cylindrical_shell_gas_md');
    str_array{k, 1} = 'cylindrical_shell_gas_md';
    str_array{k, 2} = cylindrical_shell_gas_md;
    k=k+1;
catch    
end

try  
    cylindrical_shell_diam=getappdata(0,'cylindrical_shell_diam');
    str_array{k, 1} = 'cylindrical_shell_diam';
    str_array{k, 2} = cylindrical_shell_diam;
    k=k+1;
catch    
end

try  
    cylindrical_homogeneous_shell_mat=getappdata(0,'cylindrical_homogeneous_shell_mat');
    str_array{k, 1} = 'cylindrical_homogeneous_shell_mat';
    str_array{k, 2} = cylindrical_homogeneous_shell_mat;
    k=k+1;
catch    
end

try  
    cylindrical_homogeneous_shell_em=getappdata(0,'cylindrical_homogeneous_shell_em');
    str_array{k, 1} = 'cylindrical_homogeneous_shell_em';
    str_array{k, 2} = cylindrical_homogeneous_shell_em;
    k=k+1;
catch    
end

try  
    cylindrical_homogeneous_shell_rho=getappdata(0,'cylindrical_homogeneous_shell_rho');
    str_array{k, 1} = 'cylindrical_homogeneous_shell_rho';
    str_array{k, 2} = cylindrical_homogeneous_shell_rho;
    k=k+1;
catch    
end

try  
    cylindrical_homogeneous_shell_mu=getappdata(0,'cylindrical_homogeneous_shell_mu');
    str_array{k, 1} = 'cylindrical_homogeneous_shell_mu';
    str_array{k, 2} = cylindrical_homogeneous_shell_mu;
    k=k+1;
catch    
end

try  
    cylindrical_honeycomb_shell_mat=getappdata(0,'cylindrical_honeycomb_shell_mat');
    str_array{k, 1} = 'cylindrical_honeycomb_shell_mat';
    str_array{k, 2} = cylindrical_honeycomb_shell_mat;
    k=k+1;
catch    
end

try  
    cylindrical_honeycomb_shell_bc=getappdata(0,'cylindrical_honeycomb_shell_bc');
    str_array{k, 1} = 'cylindrical_honeycomb_shell_bc';
    str_array{k, 2} = cylindrical_honeycomb_shell_bc;
    k=k+1;
catch    
end

try  
    cylindrical_honeycomb_shell_nfa=getappdata(0,'cylindrical_honeycomb_shell_nfa');
    str_array{k, 1} = 'cylindrical_honeycomb_shell_nfa';
    str_array{k, 2} = cylindrical_honeycomb_shell_nfa;
    k=k+1;
catch    
end

try  
    cylindrical_honeycomb_shell_em=getappdata(0,'cylindrical_honeycomb_shell_em');
    str_array{k, 1} = 'cylindrical_honeycomb_shell_em';
    str_array{k, 2} = cylindrical_honeycomb_shell_em;
    k=k+1;
catch    
end

try  
    cylindrical_honeycomb_shell_md_f=getappdata(0,'cylindrical_honeycomb_shell_md_f');
    str_array{k, 1} = 'cylindrical_honeycomb_shell_md_f';
    str_array{k, 2} = cylindrical_honeycomb_shell_md_f;
    k=k+1;
catch    
end

try  
    cylindrical_honeycomb_shell_thick_f=getappdata(0,'cylindrical_honeycomb_shell_thick_f');
    str_array{k, 1} = 'cylindrical_honeycomb_shell_thick_f';
    str_array{k, 2} = cylindrical_honeycomb_shell_thick_f;
    k=k+1;
catch    
end

try  
    cylindrical_honeycomb_shell_mu=getappdata(0,'cylindrical_honeycomb_shell_mu');
    str_array{k, 1} = 'cylindrical_honeycomb_shell_mu';
    str_array{k, 2} = cylindrical_honeycomb_shell_mu;
    k=k+1;
catch    
end

try  
    cylindrical_honeycomb_shell_G=getappdata(0,'cylindrical_honeycomb_shell_G');
    str_array{k, 1} = 'cylindrical_honeycomb_shell_G';
    str_array{k, 2} = cylindrical_honeycomb_shell_G;
    k=k+1;
catch    
end

try  
    cylindrical_honeycomb_shell_md_c=getappdata(0,'cylindrical_honeycomb_shell_md_c');
    str_array{k, 1} = 'cylindrical_honeycomb_shell_md_c';
    str_array{k, 2} = cylindrical_honeycomb_shell_md_c;
    k=k+1;
catch    
end

try  
    cylindrical_honeycomb_shell_thick_c=getappdata(0,'cylindrical_honeycomb_shell_thick_c');
    str_array{k, 1} = 'cylindrical_honeycomb_shell_thick_c';
    str_array{k, 2} = cylindrical_honeycomb_shell_thick_c;
    k=k+1;
catch    
end

try  
    acoustic_cavity_volume=getappdata(0,'acoustic_cavity_volume');
    str_array{k, 1} = 'acoustic_cavity_volume';
    str_array{k, 2} = acoustic_cavity_volume;
    k=k+1;
catch    
end

try  
    acoustic_cavity_gas_rho_c=getappdata(0,'acoustic_cavity_gas_rho_c');
    str_array{k, 1} = 'acoustic_cavity_gas_rho_c';
    str_array{k, 2} = acoustic_cavity_gas_rho_c;
    k=k+1;
catch    
end


try  
    acoustic_cavity_gas_rho=getappdata(0,'acoustic_cavity_gas_rho');
    str_array{k, 1} = 'acoustic_cavity_gas_rho';
    str_array{k, 2} = acoustic_cavity_gas_rho;
    k=k+1;
catch    
end

try  
    acoustic_cavity_gas_c=getappdata(0,'acoustic_cavity_gas_c');
    str_array{k, 1} = 'acoustic_cavity_gas_c';
    str_array{k, 2} = acoustic_cavity_gas_c;
    k=k+1;
catch    
end



try  
    acoustic_cavity_ns=getappdata(0,'acoustic_cavity_ns');
    str_array{k, 1} = 'acoustic_cavity_ns';
    str_array{k, 2} = acoustic_cavity_ns;
    k=k+1;
catch    
end

try  
    acoustic_cavity_imed=getappdata(0,'acoustic_cavity_imed');
    str_array{k, 1} = 'acoustic_cavity_imed';
    str_array{k, 2} = acoustic_cavity_imed;
    k=k+1;
catch    
end



try  
    acoustic_cavity_diameter=getappdata(0,'acoustic_cavity_diameter');
    str_array{k, 1} = 'acoustic_cavity_diameter';
    str_array{k, 2} = acoustic_cavity_diameter;
    k=k+1;
catch    
end

try  
    acoustic_cavity_H=getappdata(0,'acoustic_cavity_H');
    str_array{k, 1} = 'acoustic_cavity_H';
    str_array{k, 2} = acoustic_cavity_H;
    k=k+1;
catch    
end



try  
    shelf_mass=getappdata(0,'shelf_mass');
    str_array{k, 1} = 'shelf_mass';
    str_array{k, 2} = shelf_mass;
    k=k+1;
catch    
end

try  
    total_shelf_thick=getappdata(0,'total_shelf_thick');
    str_array{k, 1} = 'total_shelf_thick';
    str_array{k, 2} = total_shelf_thick;
    k=k+1;
catch    
end



try  
    shelf_cL=getappdata(0,'shelf_cL');
    str_array{k, 1} = 'shelf_cL';
    str_array{k, 2} = shelf_cL;
    k=k+1;
catch    
end

try  
    total_shelf_md=getappdata(0,'total_shelf_md');
    str_array{k, 1} = 'total_shelf_md';
    str_array{k, 2} = total_shelf_md;
    k=k+1;
catch    
end



try  
    shelf_area=getappdata(0,'shelf_area');
    str_array{k, 1} = 'shelf_area';
    str_array{k, 2} = shelf_area;
    k=k+1;
catch    
end

try  
    homogeneous_shelf_E=getappdata(0,'homogeneous_shelf_E');
    str_array{k, 1} = 'homogeneous_shelf_E';
    str_array{k, 2} = homogeneous_shelf_E;
    k=k+1;
catch    
end



try  
    homogeneous_shelf_rho=getappdata(0,'homogeneous_shelf_rho');
    str_array{k, 1} = 'homogeneous_shelf_rho';
    str_array{k, 2} = homogeneous_shelf_rho;
    k=k+1;
catch    
end

try  
    homogeneous_shelf_mu=getappdata(0,'homogeneous_shelf_mu');
    str_array{k, 1} = 'homogeneous_shelf_mu';
    str_array{k, 2} = homogeneous_shelf_mu;
    k=k+1;
catch    
end



try  
    homogeneous_shelf_H=getappdata(0,'homogeneous_shelf_H');
    str_array{k, 1} = 'homogeneous_shelf_H';
    str_array{k, 2} = homogeneous_shelf_H;
    k=k+1;
catch    
end



try  
    homogeneous_shelf_imat=getappdata(0,'homogeneous_shelf_imat');
    str_array{k, 1} = 'homogeneous_shelf_imat';
    str_array{k, 2} = homogeneous_shelf_imat;
    k=k+1;
catch    
end

try  
    circular_shelf_diam=getappdata(0,'circular_shelf_diam');
    str_array{k, 1} = 'circular_shelf_diam';
    str_array{k, 2} = circular_shelf_diam;
    k=k+1;
catch    
end



try  
    annular_shelf_OD=getappdata(0,'annular_shelf_OD');
    str_array{k, 1} = 'annular_shelf_OD';
    str_array{k, 2} = annular_shelf_OD;
    k=k+1;
catch    
end

try  
    annular_shelf_ID=getappdata(0,'annular_shelf_ID');
    str_array{k, 1} = 'annular_shelf_ID';
    str_array{k, 2} =annular_shelf_ID ;
    k=k+1;
catch    
end



try  
    honeycomb_shelf_em=getappdata(0,'honeycomb_shelf_em');
    str_array{k, 1} = 'honeycomb_shelf_em';
    str_array{k, 2} = honeycomb_shelf_em;
    k=k+1;
catch    
end

try  
    honeycomb_shelf_md_f=getappdata(0,'honeycomb_shelf_md_f');
    str_array{k, 1} = 'honeycomb_shelf_md_f';
    str_array{k, 2} = honeycomb_shelf_md_f;
    k=k+1;
catch    
end



try  
    honeycomb_shelf_mu=getappdata(0,'honeycomb_shelf_mu');
    str_array{k, 1} = 'honeycomb_shelf_mu';
    str_array{k, 2} = honeycomb_shelf_mu;
    k=k+1;
catch    
end

try  
    honeycomb_shelf_thick_f=getappdata(0,'honeycomb_shelf_thick_f');
    str_array{k, 1} = 'honeycomb_shelf_thick_f';
    str_array{k, 2} = honeycomb_shelf_thick_f;
    k=k+1;
catch    
end



try  
    honeycomb_shelf_G=getappdata(0,'honeycomb_shelf_G');
    str_array{k, 1} = 'honeycomb_shelf_G';
    str_array{k, 2} =honeycomb_shelf_G ;
    k=k+1;
catch    
end

try  
    honeycomb_shelf_md_c=getappdata(0,'honeycomb_shelf_md_c');
    str_array{k, 1} = 'honeycomb_shelf_md_c';
    str_array{k, 2} = honeycomb_shelf_md_c;
    k=k+1;
catch    
end



try  
    honeycomb_shelf_thick_c=getappdata(0,'honeycomb_shelf_thick_c');
    str_array{k, 1} = 'honeycomb_shelf_thick_c';
    str_array{k, 2} = honeycomb_shelf_thick_c;
    k=k+1;
catch    
end

try  
    shelf_fcr=getappdata(0,'shelf_fcr');
    str_array{k, 1} = 'shelf_fcr';
    str_array{k, 2} = shelf_fcr;
    k=k+1;
catch    
end



try  
    shelf_NSM=getappdata(0,'shelf_NSM');
    str_array{k, 1} = 'shelf_NSM';
    str_array{k, 2} = shelf_NSM;
    k=k+1;
catch    
end

try  
    shelf_ndlf=getappdata(0,'shelf_ndlf');
    str_array{k, 1} = 'shelf_ndlf';
    str_array{k, 2} = shelf_ndlf;
    k=k+1;
catch    
end

try  
    percent=getappdata(0,'percent');
    str_array{k, 1} = 'percent';
    str_array{k, 2} = percent;
    k=k+1;
catch    
end


external_acoustic_power=getappdata(0,'external_acoustic_power');            
external_SPL=getappdata(0,'external_SPL');            



cylindrical_shell_modal_density=getappdata(0,'cylindrical_shell_modal_density');

cylindrical_shell_rad_eff=getappdata(0,'cylindrical_shell_rad_eff');  

cylindrical_shell_dlf=getappdata(0,'cylindrical_shell_dlf');   

acoustic_cavity_dlf=getappdata(0,'acoustic_cavity_dlf');

acoustic_cavity_modal_density=getappdata(0,'acoustic_cavity_modal_density');

shelf_modal_density=getappdata(0,'shelf_modal_density');

shelf_dlf=getappdata(0,'shelf_dlf');
 
shelf_rad_eff=getappdata(0,'shelf_rad_eff');  


% % %

   [writefname, writepname] = uiputfile('*.mat','Save data as');
    writepfname = fullfile(writepname, writefname);
    
    pattern = '.mat';
    replacement = '';
    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
   
    
    ss=sprintf('%s',sname);
    out1=sprintf('%s=str_array;',ss);
    eval(out1);

    ss_external_acoustic_power=sprintf('%s_external_acoustic_power',sname);
    out1=sprintf('%s_external_acoustic_power=external_acoustic_power;',ss);
    eval(out1);    
    
    ss_external_SPL=sprintf('%s_external_SPL',sname);
    out1=sprintf('%s_external_SPL=external_SPL;',ss);
    eval(out1); 

%%%%%%%%%%
%%%%%%%%%%


try

save(elk,ss,...
     'external_acoustic_power',...
     'external_SPL',...
     'cylindrical_shell_rad_eff',...
     'cylindrical_shell_modal_density',...
     'cylindrical_shell_dlf',...
     'acoustic_cavity_modal_density',...
     'acoustic_cavity_dlf',...     
     'shelf_rad_eff',...
     'shelf_modal_density',...     
     'shelf_dlf');
 
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
        disp([choice ' Reseting'])
        pushbutton_reset_Callback(hObject, eventdata, handles)
end  



% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear_cylindrical_shell(hObject, eventdata, handles);
clear_acoustic(hObject, eventdata, handles);
clear_shelf(hObject, eventdata, handles);
set(handles.edit_nbolts,'String','');


[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
struct=load(NAME);

structnames = fieldnames(struct, '-full'); % fields in the struct


k=length(structnames);


structnames

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

value=evalin('base',structnames{1});   
 
sz=size(value);

 
disp(' ');
disp(' Wait for completion message... ');

value

for i=1:sz(1)
 
    if( strfind(value{i,1},'iu')>=1)
        iu=str2num(value{i,2});
        setappdata(0,'iu',iu);
        set(handles.listbox_iu,'Value',iu);
    end
    if( strfind(value{i,1},'cylindrical_shell_construction')>=1)
        cylindrical_shell_construction=str2num(value{i,2});
        setappdata(0,'cylindrical_shell_construction',cylindrical_shell_construction);
        set(handles.listbox_cylindrical_shell,'Value',cylindrical_shell_construction);
    end
    if( strfind(value{i,1},'shelf_geometry')>=1)
        shelf_geometry=str2num(value{i,2});
        setappdata(0,'shelf_geometry',shelf_geometry);
        set(handles.listbox_shelf_geometry,'Value',shelf_geometry);
    end
    if( strfind(value{i,1},'shelf_construction')>=1)
        shelf_construction=str2num(value{i,2});
        setappdata(0,'shelf_construction',shelf_construction);
        set(handles.listbox_shelf_construction,'Value',shelf_construction);
    end
    if( strfind(value{i,1},'nbolts')>=1)
        nbolts=str2num(value{i,2});
        setappdata(0,'nbolts',nbolts);
        ss=sprintf('%g',nbolts);
        set(handles.edit_nbolts,'String',ss);
    end    
    if( strfind(value{i,1},'external_spl_name')>=1)
        FS=value{i,2};
        setappdata(0,'external_spl_name',FS);
    end     
    
        
    if( strfind(value{i,1},'cylindrical_shell_mass')>=1)
        cylindrical_shell_mass=value{i,2};
        setappdata(0,'cylindrical_shell_mass',cylindrical_shell_mass);
    end     
    
    
    if( strfind(value{i,1},'cylindrical_shell_md')>=1)
        cylindrical_shell_md=value{i,2};
        setappdata(0,'cylindrical_shell_md',cylindrical_shell_md);
 
    end     
    
        if( strfind(value{i,1},'cylindrical_shell_thick')>=1)
        cylindrical_shell_thick=value{i,2};
        setappdata(0,'cylindrical_shell_thick',cylindrical_shell_thick);

    end     
    
    
    if( strfind(value{i,1},'cylindrical_shell_area')>=1)
        cylindrical_shell_area=value{i,2};
        setappdata(0,'cylindrical_shell_area',cylindrical_shell_area);
    end     
        

    
    if( strfind(value{i,1},'cylindrical_shell_fring')>=1)
        cylindrical_shell_fring=value{i,2};
        setappdata(0,'cylindrical_shell_fring',cylindrical_shell_fring);
    end     
    
    if( strfind(value{i,1},'cylindrical_shell_fcr')>=1)
        cylindrical_shell_fcr=value{i,2};
        setappdata(0,'cylindrical_shell_fcr',cylindrical_shell_fcr);
    end     
    
    
    if( strfind(value{i,1},'cylindrical_shell_L')>=1)
        cylindrical_shell_L=value{i,2};
        setappdata(0,'cylindrical_shell_L',cylindrical_shell_L);
    end     
        
        
    
    
        
    if( strfind(value{i,1},'cylindrical_shell_ng')>=1)
        cylindrical_shell_ng=value{i,2};
        setappdata(0,'cylindrical_shell_ng',cylindrical_shell_ng);
        
        
    end     
    
    
    if( strfind(value{i,1},'cylindrical_shell_nd')>=1)
        cylindrical_shell_nd=value{i,2};
        setappdata(0,'cylindrical_shell_nd',cylindrical_shell_nd);
        
        
    end     
    
    if( strfind(value{i,1},'cylindrical_shell_c')>=1)
        cylindrical_shell_c=value{i,2};
        setappdata(0,'cylindrical_shell_c',cylindrical_shell_c);
    end     
    
    
    if( strfind(value{i,1},'cylindrical_shell_cL')>=1)
        cylindrical_shell_cL=value{i,2};
        setappdata(0,'cylindrical_shell_cL',cylindrical_shell_cL);
    end      
    
    if( strfind(value{i,1},'cylindrical_shell_gas_md')>=1)
        cylindrical_shell_gas_md=value{i,2};
        setappdata(0,'cylindrical_shell_gas_md',cylindrical_shell_gas_md);        
    end     
        
        
    
    
        
    if( strfind(value{i,1},'cylindrical_shell_diam')>=1)
        cylindrical_shell_diam=value{i,2};
        setappdata(0,'cylindrical_shell_diam',cylindrical_shell_diam);
    end     
    
    
    if( strfind(value{i,1},'cylindrical_homogeneous_shell_mat')>=1)
        cylindrical_homogeneous_shell_mat=value{i,2};
        setappdata(0,'cylindrical_homogeneous_shell_mat',cylindrical_homogeneous_shell_mat);
    end     
    
    if( strfind(value{i,1},'cylindrical_homogeneous_shell_em')>=1)
        cylindrical_homogeneous_shell_em=value{i,2};
        setappdata(0,'cylindrical_homogeneous_shell_em',cylindrical_homogeneous_shell_em);    
    end     
    
    
    if( strfind(value{i,1},'cylindrical_homogeneous_shell_rho')>=1)
        cylindrical_homogeneous_shell_rho=value{i,2};
        setappdata(0,'cylindrical_homogeneous_shell_rho',cylindrical_homogeneous_shell_rho);
    end     
        
        
    if( strfind(value{i,1},'cylindrical_homogeneous_shell_mu')>=1)
        cylindrical_homogeneous_shell_mu=value{i,2};
        setappdata(0,'cylindrical_homogeneous_shell_mu',cylindrical_homogeneous_shell_mu);
    end     
    
    
    if( strfind(value{i,1},'cylindrical_honeycomb_shell_mat')>=1)
        cylindrical_honeycomb_shell_mat=value{i,2};
        setappdata(0,'cylindrical_honeycomb_shell_mat',cylindrical_honeycomb_shell_mat);
    end     
    
    if( strfind(value{i,1},'cylindrical_honeycomb_shell_bc')>=1)
        cylindrical_honeycomb_shell_bc=value{i,2};
        setappdata(0,'cylindrical_honeycomb_shell_bc',cylindrical_honeycomb_shell_bc);
    end     
    
    
    if( strfind(value{i,1},'cylindrical_honeycomb_shell_nfa')>=1)
        cylindrical_honeycomb_shell_nfa=value{i,2};
        setappdata(0,'cylindrical_honeycomb_shell_nfa',cylindrical_honeycomb_shell_nfa);
    end     
        
        
    if( strfind(value{i,1},'cylindrical_honeycomb_shell_em')>=1)
        cylindrical_honeycomb_shell_em=value{i,2};
        setappdata(0,'cylindrical_honeycomb_shell_em',cylindrical_honeycomb_shell_em);
    end     
    
    
    if( strfind(value{i,1},'cylindrical_honeycomb_shell_md_f')>=1)
        cylindrical_honeycomb_shell_md_f=value{i,2};
        setappdata(0,'cylindrical_honeycomb_shell_md_f',cylindrical_honeycomb_shell_md_f);
    end     
    
    if( strfind(value{i,1},'cylindrical_honeycomb_shell_thick_f')>=1)
        cylindrical_honeycomb_shell_thick_f=value{i,2};
        setappdata(0,'cylindrical_honeycomb_shell_thick_f',cylindrical_honeycomb_shell_thick_f);    
    end     
    
    
    if( strfind(value{i,1},'cylindrical_honeycomb_shell_mu')>=1)
        cylindrical_honeycomb_shell_mu=value{i,2};
        setappdata(0,'cylindrical_honeycomb_shell_mu',cylindrical_honeycomb_shell_mu);
    end     
        
       
        
    if( strfind(value{i,1},'cylindrical_honeycomb_shell_G')>=1)
        cylindrical_honeycomb_shell_G=value{i,2};
        setappdata(0,'cylindrical_honeycomb_shell_G',cylindrical_honeycomb_shell_G); 
    end     
    
    
    if( strfind(value{i,1},'cylindrical_honeycomb_shell_md_c')>=1)
        cylindrical_honeycomb_shell_md_c=value{i,2};
        setappdata(0,'cylindrical_honeycomb_shell_md_c',cylindrical_honeycomb_shell_md_c);
    end     
    
    if( strfind(value{i,1},'cylindrical_honeycomb_shell_thick_c')>=1)
        cylindrical_honeycomb_shell_thick_c=value{i,2};
        setappdata(0,'cylindrical_honeycomb_shell_thick_c',cylindrical_honeycomb_shell_thick_c);
    end     
    
    
    if( strfind(value{i,1},'acoustic_cavity_volume')>=1)
        acoustic_cavity_volume=value{i,2};
        setappdata(0,'acoustic_cavity_volume',acoustic_cavity_volume);
    end     
        
    if( strfind(value{i,1},'acoustic_cavity_gas_rho_c')>=1)
        acoustic_cavity_gas_rho_c=value{i,2};
        setappdata(0,'acoustic_cavity_gas_rho_c',acoustic_cavity_gas_rho_c);
    end     
    
    
    if( strfind(value{i,1},'acoustic_cavity_gas_rho')>=1)
        acoustic_cavity_gas_rho=value{i,2};
        setappdata(0,'acoustic_cavity_gas_rho',acoustic_cavity_gas_rho);
    end     
    
    if( strfind(value{i,1},'acoustic_cavity_gas_c')>=1)
        acoustic_cavity_gas_c=value{i,2};
        setappdata(0,'acoustic_cavity_gas_c',acoustic_cavity_gas_c);    
    end     
    
    
    if( strfind(value{i,1},'acoustic_cavity_ns')>=1)
        acoustic_cavity_ns=value{i,2};
        setappdata(0,'acoustic_cavity_ns',acoustic_cavity_ns);
    end     
        
        
    
    
        
    if( strfind(value{i,1},'acoustic_cavity_imed')>=1)
        acoustic_cavity_imed=value{i,2};
        setappdata(0,'acoustic_cavity_imed',acoustic_cavity_imed);
    end     
    
    
    if( strfind(value{i,1},'acoustic_cavity_diameter')>=1)
        acoustic_cavity_diameter=value{i,2};
        setappdata(0,'acoustic_cavity_diameter',acoustic_cavity_diameter);
    end     
    
    if( strfind(value{i,1},'acoustic_cavity_H')>=1)
        acoustic_cavity_H=value{i,2};
        setappdata(0,'acoustic_cavity_H',acoustic_cavity_H);
    end     
    
    
    if( strfind(value{i,1},'shelf_mass')>=1)
        shelf_mass=value{i,2};
        setappdata(0,'shelf_mass',shelf_mass);
    end     
        
        
    if( strfind(value{i,1},'total_shelf_thick')>=1)
        total_shelf_thick=value{i,2};
        setappdata(0,'total_shelf_thick',total_shelf_thick);        
    end     
    
    
    if( strfind(value{i,1},'shelf_cL')>=1)
        shelf_cL=value{i,2};
        setappdata(0,'shelf_cL',shelf_cL);
    end     
    
    if( strfind(value{i,1},'total_shelf_md')>=1)
        total_shelf_md=value{i,2};
        setappdata(0,'total_shelf_md',total_shelf_md);
    end     
    
    
    if( strfind(value{i,1},'shelf_area')>=1)
        shelf_area=value{i,2};
        setappdata(0,'shelf_area',shelf_area);
    end     
        
        
    if( strfind(value{i,1},'shelf_fcr')>=1)
        shelf_fcr=value{i,2};
        setappdata(0,'shelf_fcr',shelf_fcr);
    end     
    
    
    if( strfind(value{i,1},'shelf_NSM')>=1)
        shelf_NSM=value{i,2};
        setappdata(0,'shelf_NSM',shelf_NSM);
    end     
    
    if( strfind(value{i,1},'shelf_ndlf')>=1)
        shelf_ndlf=value{i,2};
        setappdata(0,'shelf_ndlf',shelf_ndlf);
    end     

    if( strfind(value{i,1},'percent')>=1)
        percent=value{i,2};
        setappdata(0,'percent',percent);
    end         
    
        
    if( strfind(value{i,1},'homogeneous_shelf_E')>=1)
        homogeneous_shelf_E=value{i,2};
        setappdata(0,'homogeneous_shelf_E',homogeneous_shelf_E);
    end     
    
    
    if( strfind(value{i,1},'homogeneous_shelf_rho')>=1)
        homogeneous_shelf_rho=value{i,2};
        setappdata(0,'homogeneous_shelf_rho',homogeneous_shelf_rho);
    end     
    
    if( strfind(value{i,1},'homogeneous_shelf_mu')>=1)
        homogeneous_shelf_mu=value{i,2};
        setappdata(0,'homogeneous_shelf_mu',homogeneous_shelf_mu);
    end     
    
    
    if( strfind(value{i,1},'homogeneous_shelf_H')>=1)
        homogeneous_shelf_H=value{i,2};
        setappdata(0,'homogeneous_shelf_H',homogeneous_shelf_H);
    end     
        
        
    if( strfind(value{i,1},'homogeneous_shelf_imat')>=1)
        homogeneous_shelf_imat=value{i,2};
        setappdata(0,'homogeneous_shelf_imat',homogeneous_shelf_imat);
    end     
    

    if( strfind(value{i,1},'circular_shelf_diam')>=1)
        circular_shelf_diam=value{i,2};
        setappdata(0,'circular_shelf_diam',circular_shelf_diam);    
    end     
    
    
    if( strfind(value{i,1},'annular_shelf_OD')>=1)
        annular_shelf_OD=value{i,2};
        setappdata(0,'annular_shelf_OD',annular_shelf_OD);  
    end     
        
        
     
    if( strfind(value{i,1},'annular_shelf_ID')>=1)
        annular_shelf_ID=value{i,2};
        setappdata(0,'annular_shelf_ID',annular_shelf_ID);
    end     
    
    if( strfind(value{i,1},'honeycomb_shelf_em')>=1)
        honeycomb_shelf_em=value{i,2};
        setappdata(0,'honeycomb_shelf_em',honeycomb_shelf_em);
    end     
    
    
    if( strfind(value{i,1},'honeycomb_shelf_md_f')>=1)
        honeycomb_shelf_md_f=value{i,2};
        setappdata(0,'honeycomb_shelf_md_f',honeycomb_shelf_md_f);
    end     
        
        
 
        
    if( strfind(value{i,1},'honeycomb_shelf_mu')>=1)
        honeycomb_shelf_mu=value{i,2};
        setappdata(0,'honeycomb_shelf_mu',honeycomb_shelf_mu);
    end     
    
    
    if( strfind(value{i,1},'honeycomb_shelf_thick_f')>=1)
        honeycomb_shelf_thick_f=value{i,2};
        setappdata(0,'honeycomb_shelf_thick_f',honeycomb_shelf_thick_f);  
    end     
    
    if( strfind(value{i,1},'honeycomb_shelf_G')>=1)
        honeycomb_shelf_G=value{i,2};
        setappdata(0,'honeycomb_shelf_G',honeycomb_shelf_G);    
    end     
     
    if( strfind(value{i,1},'honeycomb_shelf_md_c')>=1)
        honeycomb_shelf_md_c=value{i,2};
        setappdata(0,'honeycomb_shelf_md_c',honeycomb_shelf_md_c);
    end     
        
    if( strfind(value{i,1},'honeycomb_shelf_thick_c')>=1)
        honeycomb_shelf_thick_c=value{i,2};
        setappdata(0,'honeycomb_shelf_thick_c',honeycomb_shelf_thick_c);
    end     
    
end


try
    external_acoustic_power=evalin('base','external_acoustic_power');  
    setappdata(0,'external_acoustic_power',external_acoustic_power);
catch  
    disp('cylindrical_shell_modal_density not found');
    return;
end

try
    external_SPL=evalin('base','external_SPL');  
    setappdata(0,'external_SPL',external_SPL);
catch  
    disp('cylindrical_shell_modal_density not found');
    return;
end



try
    cylindrical_shell_modal_density=evalin('base','cylindrical_shell_modal_density');  
    setappdata(0,'cylindrical_shell_modal_density',cylindrical_shell_modal_density);
catch  
    disp('cylindrical_shell_modal_density not found');
    return;
end


try
    cylindrical_shell_rad_eff=evalin('base','cylindrical_shell_rad_eff');
    setappdata(0,'cylindrical_shell_rad_eff',cylindrical_shell_rad_eff);
catch    
end


try
    cylindrical_shell_dlf=evalin('base','cylindrical_shell_dlf');
    setappdata(0,'cylindrical_shell_dlf',cylindrical_shell_dlf);
catch 
end




try
    cylindrical_shell_modal_density=evalin('base','cylindrical_shell_modal_density');
    setappdata(0,'cylindrical_shell_modal_density',cylindrical_shell_modal_density);
catch 
end


try
    cylindrical_shell_rad_eff=evalin('base','cylindrical_shell_rad_eff');
    setappdata(0,'cylindrical_shell_rad_eff',cylindrical_shell_rad_eff);
catch 
end


try
    cylindrical_shell_dlf=evalin('base','cylindrical_shell_dlf');
    setappdata(0,'cylindrical_shell_dlf',cylindrical_shell_dlf);
catch 
end

try
    acoustic_cavity_dlf=evalin('base','acoustic_cavity_dlf');
    setappdata(0,'acoustic_cavity_dlf',acoustic_cavity_dlf);
catch 
end




try
    acoustic_cavity_modal_density=evalin('base','acoustic_cavity_modal_density');
    setappdata(0,'acoustic_cavity_modal_density',acoustic_cavity_modal_density);

catch 
end



try
    shelf_modal_density=evalin('base','shelf_modal_density');
    setappdata(0,'shelf_modal_density',shelf_modal_density);
catch 
end


try
    shelf_dlf=evalin('base','shelf_dlf');
    setappdata(0,'shelf_dlf',shelf_dlf);
catch 
end


try
    shelf_rad_eff=evalin('base','shelf_rad_eff');
    setappdata(0,'shelf_rad_eff',shelf_rad_eff);
catch 
end



% % %

disp(' ');
disp('Load complete');
msgbox('Load Complete');


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function pushbutton_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
