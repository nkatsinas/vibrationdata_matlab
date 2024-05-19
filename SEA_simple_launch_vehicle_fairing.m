function varargout = SEA_simple_launch_vehicle_fairing(varargin)
% SEA_SIMPLE_LAUNCH_VEHICLE_FAIRING MATLAB code for SEA_simple_launch_vehicle_fairing.fig
%      SEA_SIMPLE_LAUNCH_VEHICLE_FAIRING, by itself, creates a new SEA_SIMPLE_LAUNCH_VEHICLE_FAIRING or raises the existing
%      singleton*.
%
%      H = SEA_SIMPLE_LAUNCH_VEHICLE_FAIRING returns the handle to a new SEA_SIMPLE_LAUNCH_VEHICLE_FAIRING or the handle to
%      the existing singleton*.
%
%      SEA_SIMPLE_LAUNCH_VEHICLE_FAIRING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_SIMPLE_LAUNCH_VEHICLE_FAIRING.M with the given input arguments.
%
%      SEA_SIMPLE_LAUNCH_VEHICLE_FAIRING('Property','Value',...) creates a new SEA_SIMPLE_LAUNCH_VEHICLE_FAIRING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_simple_launch_vehicle_fairing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_simple_launch_vehicle_fairing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_simple_launch_vehicle_fairing

% Last Modified by GUIDE v2.5 11-Mar-2017 14:26:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_simple_launch_vehicle_fairing_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_simple_launch_vehicle_fairing_OutputFcn, ...
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


% --- Executes just before SEA_simple_launch_vehicle_fairing is made visible.
function SEA_simple_launch_vehicle_fairing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_simple_launch_vehicle_fairing (see VARARGIN)

% Choose default command line output for SEA_simple_launch_vehicle_fairing
handles.output = hObject;

clc;

fstr='simple_launch_vehicle_fairing_diagram.jpg';

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


setappdata(0,'fairing_construction',1);
setappdata(0,'blanket_status',1);


set(handles.listbox_iu,'Enable','on');

listbox_iu_Callback(hObject, eventdata, handles);
listbox_blanket_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_simple_launch_vehicle_fairing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_simple_launch_vehicle_fairing_OutputFcn(hObject, eventdata, handles) 
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

     A = imread('simple_launch_vehicle_fairing_eq.jpg');
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
%        1=External Acoustic Space
%        2=Payload Fairing
%        3=Interior Acoustic Space

disp(' ');
disp(' * * * * * * * * * * * * * ');
disp(' ');

tpi=2*pi;

fig_num=1;

iu=get(handles.listbox_iu,'Value');

% % %

            power=getappdata(0,'external_acoustic_power');
     external_SPL=getappdata(0,'external_spl_data');
            
    fairing_modal_density=getappdata(0,'fairing_modal_density');
  fairing_rad_eff=getappdata(0,'fairing_rad_eff');
      fairing_dlf=getappdata(0,'fairing_dlf');
     fairing_mass=getappdata(0,'fairing_mass');
       fairing_md=getappdata(0,'fairing_md');
    fairing_thick=getappdata(0,'fairing_thick');
       fairing_cL=getappdata(0,'fairing_cL');     
     fairing_area=getappdata(0,'fairing_area');    
     
    fairing_fring=getappdata(0,'fairing_fring');     
      fairing_fcr=getappdata(0,'fairing_fcr');           
            
      fairing_mass_area= fairing_mass/fairing_area;    

%            
            
if isempty(fairing_fring)
   warndlg('fairing_fring missing. Run fairing'); 
   return;
end

if isempty(fairing_fcr)
   warndlg('fairing_fcr missing. Run fairing'); 
   return;
end            

                        
if isempty(power)
   warndlg('power missing. Run fairing'); 
   return;
end
if isempty(external_SPL)
   warndlg('external_SPL missing. Run fairing'); 
   return;
else
   external_spl_dB=external_SPL(:,2);
end
            
if isempty(fairing_modal_density)
   warndlg('fairing_modal_density missing. Run fairing'); 
   return;
end
if isempty(fairing_rad_eff)
   warndlg('fairing_rad_eff missing. Run fairing'); 
   return;
end   
if isempty(fairing_dlf)
   warndlg('fairing_dlf missing. Run fairing'); 
   return;
end   
if isempty(fairing_mass)
   warndlg('fairing_mass missing. Run fairing'); 
   return;
end   
if isempty(fairing_md)
   warndlg('fairing_md missing. Run fairing'); 
   return;
end
if isempty(fairing_thick)
   warndlg('fairing_thick missing. Run fairing'); 
   return;
end   
if isempty(fairing_cL)
   warndlg('fairing_cL missing. Run fairing'); 
   return;
end   

start_index=1;

for ij=1:length(fairing_rad_eff)
    if(fairing_rad_eff(ij)>0)
        start_index=ij;
        break
    end
end    

start_index=1;  % revisit later

            
% % %

            acoustic_cavity_dlf=getappdata(0,'acoustic_cavity_dlf');
         acoustic_modal_density=getappdata(0,'acoustic_cavity_modal_density');
         acoustic_cavity_volume=getappdata(0,'acoustic_cavity_volume');          
      acoustic_cavity_gas_rho_c=getappdata(0,'acoustic_cavity_gas_rho_c');
        acoustic_cavity_gas_rho=getappdata(0,'acoustic_cavity_gas_rho');
          acoustic_cavity_gas_c=getappdata(0,'acoustic_cavity_gas_c');
   acoustic_cavity_surface_area=getappdata(0,'acoustic_cavity_surface_area');
acoustic_cavity_bare_wall_alpha=getappdata(0,'acoustic_cavity_bare_wall_alpha');      
    acoustic_cavity_fill_factor=getappdata(0,'acoustic_cavity_fill_factor');
           
%            ead=acoustic_cavity_dlf;
    
if isempty(acoustic_cavity_fill_factor)
   warndlg('fill_factor missing. Run Acoustic Cavity'); 
   return;
else
    fill_factor=acoustic_cavity_fill_factor;
end 
if isempty(acoustic_cavity_bare_wall_alpha)
   warndlg('bare_wall_alpha missing. Run Acoustic Cavity'); 
   return;
else
   bare_wall_alpha=acoustic_cavity_bare_wall_alpha;    
end 
if isempty(acoustic_cavity_surface_area)
   warndlg('acoustic_cavity_surface_area missing. Run Acoustic Cavity'); 
   return;
else
    fairing_area=acoustic_cavity_surface_area;
end 
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

fc=power(:,1);

nfc=length(power(:,1));

nk=get(handles.listbox_blanket,'Value');

if(nk==1) % blanket
    
    blanket_mass_area=getappdata(0,'blanket_mass_area');
    percent_coverage=getappdata(0,'blanket_percent_coverage');
    freq_alpha=getappdata(0,'blanket_freq_alpha');
    freq_iloss=getappdata(0,'blanket_insertion_loss');
     
    if isempty(blanket_mass_area)
        warndlg('blanket_mass_area. Run Blanket'); 
        return;
    end    
    if isempty(percent_coverage)
        warndlg('percent_coverage. Run Blanket'); 
        return;
    end        
    if isempty(freq_alpha)
        warndlg('freq_alpha. Run Blanket'); 
        return;
    end   
    if isempty(freq_iloss)
        warndlg('freq_iloss. Run Blanket'); 
        return;
    end       
    
    pcov=percent_coverage/100;
    
    fairing_blanket_mass_area=fairing_mass_area+(blanket_mass_area*percent_coverage);
    
end

max_NR=str2num(get(handles.edit_max_NR','String'));

if(isempty(max_NR))
   warndlg(' Enter max NR '); 
   return; 
end

setappdata(0,'max_NR',max_NR);

%% A=8*pi*acoustic_cavity_volume/(acoustic_cavity_gas_c*fairing_area);

e_ext_int=zeros(nfc,1);
%% e_ext_plf=zeros(nfc,1);

e_plf_int=zeros(nfc,1);
%% e_int_plf=zeros(nfc,1);


tau=zeros(nfc,1);
tau_average=zeros(nfc,1);

RR=zeros(nfc,1);

tt1=zeros(nfc,1);

tau1=zeros(nfc,1);
tau2=zeros(nfc,1);
tau4=zeros(nfc,1);

kk=1;

jj=1;

fc_p=0;
e_plf_int_p=0;

for i=1:nfc
    
    omega=tpi*fc(i);
    
    fmao=fairing_mass_area*omega;
    e_plf_int(i)=acoustic_cavity_gas_rho_c*fairing_rad_eff(i)/fmao;
    B=fmao/(2*acoustic_cavity_gas_rho_c);
    
    
    RN = 10*log10(1+B^2);
    
    RR(i)=RN-10*log10(0.23*RN);
    
    t_mass_law=10^(-RR(i)/10);
    
    num=acoustic_cavity_gas_c*fairing_area*t_mass_law;
    den=8*pi*fc(i)*acoustic_cavity_volume;
     
    e_ext_int(i)=num/den;
    

%    out1=sprintf(' fc=%8.4g  e_ext_int=%8.4g  %8.4g  %8.4g  %8.4g ',fc(i),e_ext_int(i),acoustic_cavity_gas_rho_c,fairing_rad_eff(i),fmao);
    
%     out1=sprintf(' fc=%8.4g   e_ext_int=%8.4g   e_plf_int=%8.4g  ',fc(i),e_ext_int(i),e_plf_int(i));    
%     disp(out1);
    
    if( e_plf_int(i) >1.e-20)
       
        fc_p(kk)=fc(i);
        e_plf_int_p(kk)=e_plf_int(i);
        kk=kk+1;
        
    end
    
%    out1=sprintf(' fc=%7.3g epi=%7.3g acgrc=%7.3g  fre=%7.3g fmao=%7.3g ',fc(i),e_plf_int(i),acoustic_cavity_gas_rho_c,fairing_rad_eff(i),fmao);
%    disp(out1);
    
    tt1(i)=e_ext_int(i);
    
       
    tt2t=(e_plf_int(i))^2 / fairing_dlf(i);
    
    if( tt2t>0)
        fct2(jj)=fc(i);
        tt2(jj)=tt2t;
        jj=jj+1;   
    end
    
   
%     term=e_ext_int(i)+ ( e_plf_int(i)*e_plf_int(i)/ fairing_dlf(i) );
    
    tau1(i)=e_ext_int(i);
    
    term=(e_plf_int(i))^2 / fairing_dlf(i) ;
 
    tau2(i)=8*pi*fc(i)*acoustic_cavity_volume*term/( acoustic_cavity_gas_c*acoustic_cavity_surface_area );

    if(nk==1)  % blanket case
        
        tx= (1-pcov) + pcov*freq_iloss(i,2);
        
        tau4(i)=tau2(i)*tx;
    
        tau_average(i)=tau1(i)+tau4(i); 
        
    else  
        tau_average(i)=tau1(i)+tau2(i);        
    end     
    
    if(tau_average(i)>1)
        tau_average(i)=1;
    end
    
end

%%% figure(1000);
%%% plot(fc,tau1,fc,tau2,fc,tau4,fc,tau_average);
%%% legend('tau1','tau2','tau4','tau_ave');
%%% set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
%%%                      'YScale','log','XminorTick','off','YminorTick','off');
%
%%% set(gca,'XGrid','on','GridLineStyle',':');
%%% set(gca,'YGrid','on','GridLineStyle',':');

%


%%% for i=1:nfc
%%%   out1=sprintf(' %g  %8.4g  %8.4g  %8.4g   il=%8.4g ',fc(i),tau1(i),tau2(i),tau4(i),freq_iloss(i,2));
%%%   disp(out1); 
%%% end

%%%
x_label='Center Frequency (Hz)';
fmin=fc(1);
fmax=fc(nfc);
%%%

%%% ppp1=[fc   tt1];


%%% fct2=fix_size(fct2);
%%% tt2=fix_size(tt2);

%%% ppp2=[fct2   tt2];

%%% leg1='mass law';
%%% leg2='fairing modes';

%%% y_label='ratio';
%%% t_string='trans terms';



%%% md=7;

%%% [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
%%%               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);




ppp=[fc RR];
y_label='R (dB)';
t_string='Transmission Loss Mass Law Random Incidence';

[fig_num,h2]=...
    plot_loglin_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

%%%

fc_p=fix_size(fc_p);
e_plf_int_p=fix_size(e_plf_int_p);

ppp1=[fc   e_ext_int];
ppp2=[fc_p e_plf_int_p];

leg1='CLF ext,int';
leg2='CLF plf,int';

y_label='CLF';
t_string='Coupling Loss Factors';



md=7;

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%

ppp=[fc tau_average];
y_label='tau';
t_string='Transmission Coefficient Combined Mass Law & Fairing Modes';

[fig_num,h2]=...
    plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nk=get(handles.listbox_blanket,'Value');

alpha_average=zeros(nfc,1);

if(nk==1)  % Blanket
    
    
    alpha=freq_alpha(:,2);
    
    
    if(length(alpha)~=nfc)
        warndlg(' alpha size error ');
        return;
    end
    
    
%%    
    for i=1:nfc
        
        aa1=pcov*alpha(i);
        bb1=(1-pcov)*acoustic_cavity_bare_wall_alpha;

        alpha_average(i)=aa1 + bb1;  
 
%%%        out1=sprintf(' %g  %8.4g  %8.4g  %8.4g  ',fc(i),alpha(i),aa1,bb1);
%%%        disp(out1);
                
    end    
%%    

else  % No Blanket

    alpha_average=bare_wall_alpha*ones(nfc,1);

end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_label='Fill Factor (dB)';
t_string='Payload Fill Factor';
ppp=[fc fill_factor];


fmin=min(fc);
fmax=max(fc);
    
[fig_num]=plot_loglin_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


y_label='ratio';
t_string='alpha & tau, average values';

ppp1=[fc alpha_average];
ppp2=[fc tau_average];

leg1='alpha';
leg2='tau';

md=3;

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);


%%%

NR=zeros(nfc,1);
cavity_spl_dB=zeros(nfc,1);

NRmFF=zeros(nfc,1);

disp(' ');
disp(' zero dB reference = 20 micro Pa');
disp('   ');
disp(' freq   External   Internal ');
disp(' (Hz)   SPL (dB)   SPL (dB) ');

for i=start_index:nfc
    
    NR(i)=10*log10(1 + alpha_average(i)/tau_average(i));
    
    if(NR(i)>max_NR)
        NR(i)=max_NR;
    end
    
    NRmFF(i)=NR(i)-fill_factor(i);
    
    if(  NRmFF(i)<0 )
         NRmFF(i)=NR(i);
    end
    
    cavity_spl_dB(i)=external_spl_dB(i)-NRmFF(i);

    out1=sprintf(' %7.0f    %5.1f     %5.1f  ',fc(i),external_spl_dB(i),cavity_spl_dB(i));
    disp(out1);
    
end
disp(' ');

[oaspl_in]=oaspl_function(cavity_spl_dB);
[oaspl_ext]=oaspl_function(external_spl_dB);

disp(' ');
disp('   Overall Levels ');
out1=sprintf('   External %7.4g dB',oaspl_ext);
out2=sprintf('   Internal %7.4g dB',oaspl_in);
disp(out1);
disp(out2);


%%%

disp('  ');
out1=sprintf('     Fairing Ring Frequency = %8.4g Hz ',fairing_fring);
disp(out1);

%% out2=sprintf(' Fairing Critical Frequency = %8.4g Hz ',fairing_fcr);
%% disp(out2);

%%%

ppp1=[fc NRmFF];

y_label='NR(dB)';
t_string='Net Noise Reduction';

%%% 
%%% ppp2=[fc NRmFF];

%%% leg1='NR ';
%%% leg2='NR - Fill Factor ';

%%% [fig_num,h2]=plot_loglin_function_two_NW_h2(fig_num,x_label,...
%%%                y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax);


ymin=0;
ymax=100;
nmax=max(NRmFF);

for i=0:5:120
    if(nmax<i)
        ymax=i;
        break;
    end
end

[fig_num]=plot_loglin_function_h2_ymax(fig_num,x_label,y_label,t_string,ppp1,fmin,fmax,ymin,ymax);           

setappdata(0,'net_NR',[fc NRmFF]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_label='SPL(dB)';
t_string='One-Third Octave Band Sound Pressure Level \n Fairing, Ref 20 micro Pa';


ppp1=[fc external_spl_dB];
ppp2=[fc cavity_spl_dB];

leg1=sprintf('External oaspl %5.1f dB',oaspl_ext);
leg2=sprintf('Internal oaspl %5.1f dB',oaspl_in);


[fig_num,h2]=plot_loglin_function_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax);

           
setappdata(0,'cavity_spl_dB',[ fc cavity_spl_dB ]);           
           
%%%%%
disp(' ');
disp(' Output array names for Matlab Workspace ');


output_name_11='acoustic_cavity_spl';
assignin('base',output_name_11,[fc cavity_spl_dB ]);
out11=sprintf('  acoustic_cavity_spl');
disp(out11);

output_name_12='net_noise_reduction';
assignin('base',output_name_12,[fc [fc NRmFF] ]);
out12=sprintf('  net_noise_reduction');
disp(out12);


disp(' ');


msgbox('Calculation complete. Results written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(SEA_simple_launch_vehicle_fairing);


% --- Executes on button press in pushbutton_fairing_construction.
function pushbutton_fairing_construction_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fairing_construction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



fairing_construction=get(handles.listbox_fairing,'Value');
setappdata(0,'fairing_construction',fairing_construction);


if(fairing_construction==1) % homogeneous
    
    handles.s=SEA_equiv_aco_power_fairing_example;

else                  % honeycomb sandwich
    
    handles.s=SEA_equiv_aco_power_sandwich_fairing_example;    
end

set(handles.s,'Visible','on'); 




% --- Executes on button press in pushbutton_acoustic_cavity.
function pushbutton_acoustic_cavity_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_acoustic_cavity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=acoustic_cavity_fairing_example;

set(handles.s,'Visible','on'); 






% --- Executes on button press in pushbutton_shelf.
function pushbutton_shelf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_shelf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on selection change in listbox_fairing.
function listbox_fairing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fairing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fairing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fairing
clear_fairing(hObject, eventdata, handles);



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


% --- Executes on selection change in listbox_shelfairing_construction.
function listbox_shelfairing_construction_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_shelfairing_construction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_shelfairing_construction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_shelfairing_construction


% --- Executes during object creation, after setting all properties.
function listbox_shelfairing_construction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_shelfairing_construction (see GCBO)
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
clear_blankets(hObject, eventdata, handles);


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

     A = imread('fairing_example_clf.jpg');
     figure(991) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on button press in pushbutton_view_diagram.
function pushbutton_view_diagram_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_diagram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('payload_fairing.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on selection change in listbox_iu.
function listbox_iu_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_iu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_iu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_iu

clear_fairing(hObject, eventdata, handles);
clear_acoustic(hObject, eventdata, handles);
clear_blankets(hObject, eventdata, handles);




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

clear_fairing(hObject, eventdata, handles);
clear_acoustic(hObject, eventdata, handles);
clear_blankets(hObject, eventdata, handles);


msgbox('Reset Complete');


function clear_fairing(hObject, eventdata, handles)

setappdata(0,'external_acoustic_power','');
setappdata(0,'external_spl_data','');
setappdata(0,'fairing_modal_density','');
setappdata(0,'fairing_rad_eff','');
setappdata(0,'fairing_dlf','');
setappdata(0,'fairing_mass','');
setappdata(0,'fairing_md','');
setappdata(0,'fairing_thick','');
setappdata(0,'fairing_cL','');     
setappdata(0,'fairing_area',''); 
setappdata(0,'fairing_fring',''); 
setappdata(0,'fairing_fcr','');     
setappdata(0,'fairing_c','');

setappdata(0,'fairing_gas_md','');
setappdata(0,'fairing_diam','');
setappdata(0,'fairing_L','');
setappdata(0,'fairing_ng','');
setappdata(0,'fairing_nd','');





setappdata(0,'fairing_homogeneous_mat','');
setappdata(0,'fairing_homogeneous_em','');
setappdata(0,'fairing_homogeneous_rho','');
setappdata(0,'fairing_homogeneous_mu','');

setappdata(0,'fairing_honeycomb_shell_mat','');
setappdata(0,'fairing_honeycomb_shell_bc','');
setappdata(0,'fairing_honeycomb_shell_nfa','');
setappdata(0,'fairing_honeycomb_shell_em','');
setappdata(0,'fairing_honeycomb_shell_md_f','');
setappdata(0,'fairing_honeycomb_shell_mu','');
setappdata(0,'fairing_honeycomb_shell_thick_f','');
setappdata(0,'fairing_honeycomb_shell_G','');
setappdata(0,'fairing_honeycomb_shell_md_c','');
setappdata(0,'fairing_honeycomb_shell_thick_c','');
setappdata(0,'fairing_construction','');


function clear_acoustic(hObject, eventdata, handles)

setappdata(0,'fc','');
setappdata(0,'acoustic_cavity_bare_wall_alpha','');
setappdata(0,'acoustic_cavity_surface_area','');
setappdata(0,'acoustic_cavity_percent_payload','');
setappdata(0,'acoustic_cavity_clearance','');
setappdata(0,'acoustic_cavity_dlf','');
setappdata(0,'acoustic_cavity_volume','');
setappdata(0,'acoustic_cavity_ns','');
setappdata(0,'acoustic_cavity_imed','');
setappdata(0,'acoustic_cavity_diameter','');
setappdata(0,'acoustic_cavity_H','');
setappdata(0,'acoustic_cavity_gas_rho','');
setappdata(0,'acoustic_cavity_c','');
setappdata(0,'acoustic_cavity_fill_factor','');
setappdata(0,'coustic_modal_density','');


function clear_blankets(hObject, eventdata, handles)

setappdata(0,'blanket_thickness','');
setappdata(0,'blanket_percent_coverage','');
setappdata(0,'blanket_mass_area','');
setappdata(0,'blanket_freq_alpha','');



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




% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%
%%%%%%%%%%

%%%UserSettings=struct('iu',{},...
 %%%                   'fairing_construction',{},...
 %%%                   'blanket_status',{});    

              
try  
    iu=get(handles.listbox_iu,'Value');       
    UserSettings.iu=iu;
end

try
    fairing_construction=get(handles.listbox_fairing,'Value');     
    UserSettings.fairing_construction=fairing_construction;
end
try
    blanket_status=get(handles.listbox_blanket,'Value');    
    UserSettings.blanket_status=blanket_status;    
end

% % % 

try  
    acoustic_cavity_fill_factor=getappdata(0,'acoustic_cavity_fill_factor');   
    UserSettings.acoustic_cavity_fill_factor=acoustic_cavity_fill_factor;        
catch    
end

try  
    external_acoustic_power=getappdata(0,'external_acoustic_power');   
    UserSettings.external_acoustic_power=external_acoustic_power;        
catch    
end

try  
    fairing_rad_eff=getappdata(0,'fairing_rad_eff');   
    UserSettings.fairing_rad_eff=fairing_rad_eff;        
catch    
end

try  
    fairing_modal_density=getappdata(0,'fairing_modal_density');   
    UserSettings.fairing_modal_density=fairing_modal_density;        
catch    
end

try  
    acoustic_cavity_dlf=getappdata(0,'acoustic_cavity_dlf');   
    UserSettings.acoustic_cavity_dlf=acoustic_cavity_dlf;        
catch    
end



% % % 



try  
    fairing_homogeneous_shell_mat=getappdata(0,'fairing_homogeneous_shell_mat');   
    UserSettings.fairing_homogeneous_shell_mat=fairing_homogeneous_shell_mat;        
catch    
end

try  
    fairing_homogeneous_shell_em=getappdata(0,'fairing_homogeneous_shell_em');   
    UserSettings.fairing_homogeneous_shell_em=fairing_homogeneous_shell_em;        
catch    
end

try  
    fairing_homogeneous_shell_rho=getappdata(0,'fairing_homogeneous_shell_rho');   
    UserSettings.fairing_homogeneous_shell_rho=fairing_homogeneous_shell_rho;        
catch    
end

try  
    fairing_homogeneous_shell_mu=getappdata(0,'fairing_homogeneous_shell_mu');   
    UserSettings.fairing_homogeneous_shell_mu=fairing_homogeneous_shell_mu;        
catch    
end



% % %
 
try  
    external_spl_name=getappdata(0,'external_spl_name');   
    UserSettings.external_spl_name=external_spl_name;        
catch    
end
try  
    external_spl_data=getappdata(0,'external_spl_data');   
    UserSettings.external_spl_data=external_spl_data;        
catch    
end
 
try  
    fairing_mass=getappdata(0,'fairing_mass');   
    UserSettings.fairing_mass=fairing_mass;       
catch    
end
 
try  
    fairing_md=getappdata(0,'fairing_md');   
    UserSettings.fairing_md=fairing_md;         
catch    
end
 
try  
    fairing_thick=getappdata(0,'fairing_thick');   
    UserSettings.fairing_thick=fairing_thick;     
catch    
end
 
try  
    fairing_cL=getappdata(0,'fairing_cL');   
    UserSettings.fairing_cL=fairing_cL;   
catch    
end
 
try     
    fairing_area=getappdata(0,'fairing_area');   
    UserSettings.fairing_area=fairing_area;   
catch    
end
 
try  
    fairing_fring=getappdata(0,'fairing_fring');   
    UserSettings.fairing_fring=fairing_fring; 
    
catch    
    
    disp('Fairing ring not found');
end
 
try     
    fairing_fcr=getappdata(0,'fairing_fcr');   
    UserSettings.fairing_fcr=fairing_fcr;      
catch    
end
 
try  
    fairing_L=getappdata(0,'fairing_L');   
    UserSettings.fairing_L=fairing_L;      
catch    
end
 
try  
    fairing_ng=getappdata(0,'fairing_ng');   
    UserSettings.fairing_ng=fairing_ng;    
catch    
end
 
try  
    fairing_nd=getappdata(0,'fairing_nd');   
    UserSettings.fairing_nd=fairing_nd;    
catch    
end

try  
    fairing_dlf=getappdata(0,'fairing_dlf');   
    UserSettings.fairing_dlf=fairing_dlf;    
catch    
end
 
try  
    fairing_nc=getappdata(0,'fairing_nc');   
    UserSettings.fairing_nc=fairing_nc;      
catch    
end
 
try  
    fairing_gas_md=getappdata(0,'fairing_gas_md');   
    UserSettings.fairing_gas_md=fairing_gas_md;     
catch    
end
 
try  
    fairing_diam=getappdata(0,'fairing_diam');   
    UserSettings.fairing_diam=fairing_diam;        
catch    
end
 
try  
    fairing_homogeneous_mat=getappdata(0,'fairing_homogeneous_mat');   
    UserSettings.fairing_homogeneous_mat=fairing_homogeneous_mat;      
catch    
end
 
try  
    fairing_homogeneous_em=getappdata(0,'fairing_homogeneous_em');   
    UserSettings.fairing_homogeneous_em=fairing_homogeneous_em;       
catch    
end
 
try  
    fairing_homogeneous_rho=getappdata(0,'fairing_homogeneous_rho');   
    UserSettings.fairing_homogeneous_rho=fairing_homogeneous_rho;         
catch    
end
 
try  
    fairing_homogeneous_mu=getappdata(0,'fairing_homogeneous_mu');   
    UserSettings.fairing_homogeneous_mu=fairing_homogeneous_mu;        
catch    
end
 
try  
    fairing_honeycomb_shell_mat=getappdata(0,'fairing_honeycomb_shell_mat');   
    UserSettings.fairing_honeycomb_shell_mat=fairing_honeycomb_shell_mat;      
catch    
end
 
try  
    fairing_honeycomb_shell_bc=getappdata(0,'fairing_honeycomb_shell_bc');   
    UserSettings.fairing_honeycomb_shell_bc=fairing_honeycomb_shell_bc;        
catch    
end
 
try  
    fairing_honeycomb_shell_nfa=getappdata(0,'fairing_honeycomb_shell_nfa');   
    UserSettings.fairing_honeycomb_shell_nfa=fairing_honeycomb_shell_nfa;        
catch    
end
 
try  
    fairing_honeycomb_shell_em=getappdata(0,'fairing_honeycomb_shell_em');   
    UserSettings.fairing_honeycomb_shell_em=fairing_honeycomb_shell_em;     
catch    
end
 
try  
    fairing_honeycomb_shell_md_f=getappdata(0,'fairing_honeycomb_shell_md_f');   
    UserSettings.fairing_honeycomb_shell_md_f=fairing_honeycomb_shell_md_f;        
catch    
end
 
try  
    fairing_honeycomb_shell_thick_f=getappdata(0,'fairing_honeycomb_shell_thick_f');   
    UserSettings.fairing_honeycomb_shell_thick_f=fairing_honeycomb_shell_thick_f;      
catch    
end
 
try  
    fairing_honeycomb_shell_mu=getappdata(0,'fairing_honeycomb_shell_mu');   
    UserSettings.fairing_honeycomb_shell_mu=fairing_honeycomb_shell_mu;       
catch    
end
 
try  
    fairing_honeycomb_shell_G=getappdata(0,'fairing_honeycomb_shell_G');   
    UserSettings.fairing_honeycomb_shell_G=fairing_honeycomb_shell_G;      
catch    
end
 
try  
    fairing_honeycomb_shell_md_c=getappdata(0,'fairing_honeycomb_shell_md_c');   
    UserSettings.fairing_honeycomb_shell_md_c=fairing_honeycomb_shell_md_c;    
catch    
end
 
try  
    fairing_honeycomb_shell_thick_c=getappdata(0,'fairing_honeycomb_shell_thick_c');   
    UserSettings.fairing_honeycomb_shell_thick_c=fairing_honeycomb_shell_thick_c;      
catch    
end
 
%%%%%%%%%%%%%%%%%


% % %
   
try  
    acoustic_cavity_bare_wall_alpha=getappdata(0,'acoustic_cavity_bare_wall_alpha');   
    UserSettings.acoustic_cavity_bare_wall_alpha=acoustic_cavity_bare_wall_alpha;    
catch    
end
 
try  
    acoustic_cavity_surface_area=getappdata(0,'acoustic_cavity_surface_area');   
    UserSettings.acoustic_cavity_surface_area=acoustic_cavity_surface_area;     
catch    
end
 
try  
    acoustic_cavity_percent_payload=getappdata(0,'acoustic_cavity_percent_payload');   
    UserSettings.acoustic_cavity_percent_payload=acoustic_cavity_percent_payload;         
catch    
end
 
try    
    acoustic_cavity_clearance=getappdata(0,'acoustic_cavity_clearance');   
    UserSettings.acoustic_cavity_clearance=acoustic_cavity_clearance;    
catch    
end
 
 
try  
    acoustic_cavity_volume=getappdata(0,'acoustic_cavity_volume');   
    UserSettings.acoustic_cavity_volume=acoustic_cavity_volume;    
catch    
end
 
try  
    acoustic_cavity_gas_rho_c=getappdata(0,'acoustic_cavity_gas_rho_c');   
    UserSettings.acoustic_cavity_gas_rho_c=acoustic_cavity_gas_rho_c;       
catch    
end
 
try  
    acoustic_cavity_gas_rho=getappdata(0,'acoustic_cavity_gas_rho');   
    UserSettings.acoustic_cavity_gas_rho=acoustic_cavity_gas_rho;     
catch    
end
try  
    acoustic_cavity_gas_md=getappdata(0,'acoustic_cavity_gas_md');   
    UserSettings.acoustic_cavity_gas_md=acoustic_cavity_gas_md;     
catch    
end
 
try  
    acoustic_cavity_gas_c=getappdata(0,'acoustic_cavity_gas_c');   
    UserSettings.acoustic_cavity_gas_c=acoustic_cavity_gas_c;      
catch    
end
 
try  
    acoustic_cavity_ns=getappdata(0,'acoustic_cavity_ns');   
    UserSettings.acoustic_cavity_ns=acoustic_cavity_ns;      
catch    
end
 
try  
    acoustic_cavity_imed=getappdata(0,'acoustic_cavity_imed');   
    UserSettings.acoustic_cavity_imed=acoustic_cavity_imed;      
catch    
end
 
try  
    acoustic_cavity_diameter=getappdata(0,'acoustic_cavity_diameter');   
    UserSettings.acoustic_cavity_diameter=acoustic_cavity_diameter;     
catch    
end
 
try  
    acoustic_cavity_H=getappdata(0,'acoustic_cavity_H');   
    UserSettings.acoustic_cavity_H=acoustic_cavity_H;      
catch    
end

try
    acoustic_modal_density=getappdata(0,'acoustic_modal_density');   
    UserSettings.acoustic_modal_density= acoustic_modal_density;         
catch
end
 
%%%%%%%%%%%%%%%%%
 
% % %


try
    blanket_thickness=getappdata(0,'blanket_thickness');   
    UserSettings.blanket_thickness=blanket_thickness;    
end
try
    blanket_percent_coverage=getappdata(0,'blanket_percent_coverage');   
    UserSettings.blanket_percent_coverage=blanket_percent_coverage;    
end
try
    blanket_mass_area=getappdata(0,'blanket_mass_area');  
    UserSettings.blanket_mass_area=blanket_mass_area;
end
try
    blanket_density_orig=getappdata(0,'blanket_density_orig');  
    UserSettings.blanket_density_orig=blanket_density_orig;
end
try
    blanket_freq_alpha=getappdata(0,'blanket_freq_alpha');     
    UserSettings.blanket_freq_alpha=blanket_freq_alpha;
end
try
    blanket_insertion_loss=getappdata(0,'blanket_insertion_loss');     
    UserSettings.blanket_insertion_loss=blanket_insertion_loss;
end

try
    i_iloss_choice=getappdata(0,'i_iloss_choice');     
    UserSettings.i_iloss_choice=i_iloss_choice;
end
try
    i_alpha_choice=getappdata(0,'i_alpha_choice');     
    UserSettings.i_alpha_choice=i_alpha_choice;
end

try
    alpha_array_name=getappdata(0,'alpha_array_name');     
    UserSettings.alpha_array_name=alpha_array_name;
end
try
    iloss_array_name=getappdata(0,'iloss_array_name');     
    UserSettings.iloss_array_name=iloss_array_name;
end

%%

try
    max_NR=str2num(get(handles.edit_max_NR,'String'));    
    UserSettings.max_NR=max_NR;
    
catch
    disp(' UserSettings.max_NR failed   ');
end



% % %

structnames = fieldnames(UserSettings, '-full') % fields in the struct


% % %

   [writefname, writepname] = uiputfile('*.mat','Save data as');

   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    try
 
        save(elk, 'UserSettings'); 
 
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

clear_fairing(hObject, eventdata, handles);
clear_acoustic(hObject, eventdata, handles);
clear_blankets(hObject, eventdata, handles);



[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];

struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try

   UserSettings=evalin('base','UserSettings');

catch
   warndlg(' evalin failed ');
   return;
end
   

%% UserSettings = fieldnames(struct, '-full'); % fields in the struct

%% UserSettings.iu

UserSettings

try
    set(handles.listbox_iu,'Value',UserSettings.iu);
    setappdata(0,'iu',UserSettings.iu);
end
try
    set(handles.listbox_fairing,'Value',UserSettings.fairing_construction); 
end
try
    set(handles.listbox_blanket,'Value',UserSettings.blanket_status);   
end


try  
    setappdata(0,'fairing_rad_eff',UserSettings.fairing_rad_eff);        
catch    
end


% % %

try  
    setappdata(0,'fairing_modal_density',UserSettings.fairing_modal_density);        
catch    
end

try  
    setappdata(0,'acoustic_cavity_dlf',UserSettings.acoustic_cavity_dlf);        
catch    
end


% % %

try  
    setappdata(0,'acoustic_cavity_fill_factor',UserSettings.acoustic_cavity_fill_factor);        
catch    
end

try  
    setappdata(0,'external_acoustic_power',UserSettings.external_acoustic_power);        
catch    
end

% % % 

try   
    setappdata(0,'blanket_thickness',UserSettings.blanket_thickness);  
end
try   
    setappdata(0,'blanket_percent_coverage',UserSettings.blanket_percent_coverage);     
end
try   
    setappdata(0,'blanket_density_orig',UserSettings.blanket_density_orig);     
end
try   
    setappdata(0,'blanket_mass_area',UserSettings.blanket_mass_area);   
end
try   
    setappdata(0,'blanket_freq_alpha',UserSettings.blanket_freq_alpha);
end
try   
    setappdata(0,'blanket_insertion_loss',UserSettings.insertion_loss);
end
try   
    setappdata(0,'alpha_array_name',UserSettings.alpha_array_name);
end
try   
    setappdata(0,'i_iloss_choice',UserSettings.i_iloss_choice);
end
try   
    setappdata(0,'i_alpha_choice',UserSettings.i_alpha_choice);
end



% % %

try  
    setappdata(0,'external_spl_name',UserSettings.external_spl_name);       
catch    
end
try  
    setappdata(0,'external_spl_data',UserSettings.external_spl_data);       
catch    
end
 
try  
    setappdata(0,'fairing_mass',UserSettings.fairing_mass);   
catch    
end
 
try  
    setappdata(0,'fairing_md',UserSettings.fairing_md);      
catch    
end
 
try  
    setappdata(0,'fairing_thick',UserSettings.fairing_thick);       
catch    
end
 
try  
    setappdata(0,'fairing_cL',UserSettings.fairing_cL);   
catch    
end
 
try     
    setappdata(0,'fairing_area',UserSettings.fairing_area);     
catch    
end
 
try  
    setappdata(0,'fairing_fring',UserSettings.fairing_fring);    
catch    
end
 
try     
    setappdata(0,'fairing_fcr',UserSettings.fairing_fcr);   
catch    
end
 
try  
    setappdata(0,'fairing_L',UserSettings.fairing_L);      
catch    
end
 
try  
    setappdata(0,'fairing_ng',UserSettings.fairing_ng);     
catch    
end
 
try  
    setappdata(0,'fairing_nd',UserSettings.fairing_nd);     
catch    
end

try  
    setappdata(0,'fairing_dlf',UserSettings.fairing_dlf);    
catch    
end
 


try  
    setappdata(0,'fairing_nc',UserSettings.fairing_nc);    
catch    
end
 
try  
    setappdata(0,'fairing_gas_md',UserSettings.fairing_gas_md);     
catch    
end
 
try  
    setappdata(0,'fairing_diam',UserSettings.fairing_diam);          
catch    
end
 
try  
    setappdata(0,'fairing_homogeneous_mat',UserSettings.fairing_homogeneous_mat);       
catch    
end
 
try  
    setappdata(0,'fairing_homogeneous_em',UserSettings.fairing_homogeneous_em);        
catch    
end
 
try  
    setappdata(0,'fairing_homogeneous_rho',UserSettings.fairing_homogeneous_rho);       
catch    
end
 
try  
    setappdata(0,'fairing_homogeneous_mu',UserSettings.fairing_homogeneous_mu);  
catch    
end
 
try  
    setappdata(0,'fairing_honeycomb_shell_mat',UserSettings.fairing_honeycomb_shell_mat);         
catch    
end
 
try  
    setappdata(0,'fairing_honeycomb_shell_bc',UserSettings.fairing_honeycomb_shell_bc); 
catch    
end
 
try  
    setappdata(0,'fairing_honeycomb_shell_nfa',UserSettings.fairing_honeycomb_shell_nfa); 
catch    
end
 
try  
    setappdata(0,'fairing_honeycomb_shell_em',UserSettings.fairing_honeycomb_shell_em);   
catch    
end
 
try  
    setappdata(0,'fairing_honeycomb_shell_md_f',UserSettings.fairing_honeycomb_shell_md_f); 
catch    
end
 
try  
    setappdata(0,'fairing_honeycomb_shell_thick_f',UserSettings.fairing_honeycomb_shell_thick_f); 
catch    
end
 
try  
    setappdata(0,'fairing_honeycomb_shell_mu',UserSettings.fairing_honeycomb_shell_mu);  
catch    
end
 
try  
    setappdata(0,'fairing_honeycomb_shell_G',UserSettings.fairing_honeycomb_shell_G); 
catch    
end
 
try  
    setappdata(0,'fairing_honeycomb_shell_md_c',UserSettings.fairing_honeycomb_shell_md_c);  
catch    
end
 
try  
    setappdata(0,'fairing_honeycomb_shell_thick_c',UserSettings.fairing_honeycomb_shell_thick_c); 
catch    
end

% % %

   
try  
    setappdata(0,'acoustic_cavity_bare_wall_alpha',UserSettings.acoustic_cavity_bare_wall_alpha);  
catch    
end
 
try  
    setappdata(0,'acoustic_cavity_surface_area',UserSettings.acoustic_cavity_surface_area); 
catch    
end
 
try  
    setappdata(0,'acoustic_cavity_percent_payload',UserSettings.acoustic_cavity_percent_payload);   
catch    
end
 
try    
    setappdata(0,'acoustic_cavity_clearance',UserSettings.acoustic_cavity_clearance);   
catch    
end
 
 
try  
    setappdata(0,'acoustic_cavity_volume',UserSettings.acoustic_cavity_volume);   
catch    
end
 
try  
    setappdata(0,'acoustic_cavity_gas_rho_c',UserSettings.acoustic_cavity_gas_rho_c);   
catch    
end
 
try  
    setappdata(0,'acoustic_cavity_gas_rho',UserSettings.acoustic_cavity_gas_rho);    
catch    
end

try  
    setappdata(0,'acoustic_cavity_gas_md',UserSettings.acoustic_cavity_gas_md);     
catch    
end

try  
    setappdata(0,'acoustic_cavity_gas_c',UserSettings.acoustic_cavity_gas_c);       
catch    
end
 
try  
    setappdata(0,'acoustic_cavity_ns',UserSettings.acoustic_cavity_ns);   
catch    
end
 
try  
    setappdata(0,'acoustic_cavity_imed',UserSettings.acoustic_cavity_imed);      
catch    
end
 
try  
    setappdata(0,'acoustic_cavity_diameter',UserSettings.acoustic_cavity_diameter);       
catch    
end
 
try  
    setappdata(0,'acoustic_cavity_H',UserSettings.acoustic_cavity_H);        
catch    
end

try
    setappdata(0,'acoustic_modal_density',UserSettings.acoustic_modal_density);
catch
end


% % %

try  
    setappdata(0,'fairing_homogeneous_shell_mat',UserSettings.fairing_homogeneous_shell_mat);        
catch    
end

try  
    setappdata(0,'fairing_homogeneous_shell_em',UserSettings.fairing_homogeneous_shell_em);        
catch    
end

try  
    setappdata(0,'fairing_homogeneous_shell_rho',UserSettings.fairing_homogeneous_shell_rho);        
catch    
end

try  
    setappdata(0,'fairing_homogeneous_shell_mu',UserSettings.fairing_homogeneous_shell_mu);        
catch    
end

% % %

try
    
    disp(' max_NR');
    UserSettings.max_NR
    
    setappdata(0,'max_NR',UserSettings.max_NR);
    ss=sprintf('%g',UserSettings.max_NR);
    set(handles.edit_max_NR,'String',ss);    
    
catch
    
    disp(' set edit_max_NR  failed ');
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


% --- Executes on selection change in listbox_blanket.
function listbox_blanket_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_blanket (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_blanket contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_blanket

n=get(handles.listbox_blanket,'Value');
setappdata(0,'blanket_status',n);

if(n==1)

    set(handles.text_3,'Visible','on');
    set(handles.pushbutton_blanket,'Visible','on');
  
else

    set(handles.text_3,'Visible','off');
    set(handles.pushbutton_blanket,'Visible','off');    

end



% --- Executes during object creation, after setting all properties.
function listbox_blanket_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_blanket (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mass_law.
function pushbutton_mass_law_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mass_law (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('mass_law_eq.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 
     
     



function edit_blanket_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_blanket_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_blanket_md as text
%        str2double(get(hObject,'String')) returns contents of edit_blanket_md as a double


% --- Executes during object creation, after setting all properties.
function edit_blanket_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_blanket_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_percent_cover_Callback(hObject, eventdata, handles)
% hObject    handle to edit_percent_cover (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_percent_cover as text
%        str2double(get(hObject,'String')) returns contents of edit_percent_cover as a double


% --- Executes during object creation, after setting all properties.
function edit_percent_cover_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_percent_cover (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox6.
function listbox6_Callback(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox6


% --- Executes during object creation, after setting all properties.
function listbox6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton_blanket.
function pushbutton_blanket_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_blanket (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=acoustic_cavity_blanket_example;

set(handles.s,'Visible','on'); 




% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('vent_noise.jpg');
figure(990) 
imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on button press in pushbutton_fill_factor.
function pushbutton_fill_factor_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fill_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('fill_factor.jpg');
figure(899) 
imshow(A,'border','tight','InitialMagnification',100) 
     






% --- Executes on button press in pushbutton_payload_fairing.
function pushbutton_payload_fairing_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_payload_fairing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_iu,'Value');

setappdata(0,'iu',iu);

n=get(handles.listbox_fairing,'Value');
setappdata(0,'listbox_fairing','Value');

if(n==1)
    handles.s=SEA_equiv_aco_power_fairing_ex;
else
    handles.s=SEA_equiv_aco_power_sandwich_fairing_ex;    
end


set(handles.s,'Visible','on'); 



function edit_max_NR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max_NR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max_NR as text
%        str2double(get(hObject,'String')) returns contents of edit_max_NR as a double


% --- Executes during object creation, after setting all properties.
function edit_max_NR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max_NR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
