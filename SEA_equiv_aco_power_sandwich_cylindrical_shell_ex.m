function varargout = SEA_equiv_aco_power_sandwich_cylindrical_shell_ex(varargin)
% SEA_EQUIV_ACO_POWER_SANDWICH_CYLINDRICAL_SHELL_EX MATLAB code for SEA_equiv_aco_power_sandwich_cylindrical_shell_ex.fig
%      SEA_EQUIV_ACO_POWER_SANDWICH_CYLINDRICAL_SHELL_EX, by itself, creates a new SEA_EQUIV_ACO_POWER_SANDWICH_CYLINDRICAL_SHELL_EX or raises the existing
%      singleton*.
%
%      H = SEA_EQUIV_ACO_POWER_SANDWICH_CYLINDRICAL_SHELL_EX returns the handle to a new SEA_EQUIV_ACO_POWER_SANDWICH_CYLINDRICAL_SHELL_EX or the handle to
%      the existing singleton*.
%
%      SEA_EQUIV_ACO_POWER_SANDWICH_CYLINDRICAL_SHELL_EX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_EQUIV_ACO_POWER_SANDWICH_CYLINDRICAL_SHELL_EX.M with the given input arguments.
%
%      SEA_EQUIV_ACO_POWER_SANDWICH_CYLINDRICAL_SHELL_EX('Property','Value',...) creates a new SEA_EQUIV_ACO_POWER_SANDWICH_CYLINDRICAL_SHELL_EX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_equiv_aco_power_sandwich_cylindrical_shell_ex_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_equiv_aco_power_sandwich_cylindrical_shell_ex_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_equiv_aco_power_sandwich_cylindrical_shell_ex

% Last Modified by GUIDE v2.5 15-Feb-2017 15:49:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_equiv_aco_power_sandwich_cylindrical_shell_ex_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_equiv_aco_power_sandwich_cylindrical_shell_ex_OutputFcn, ...
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


% --- Executes just before SEA_equiv_aco_power_sandwich_cylindrical_shell_ex is made visible.
function SEA_equiv_aco_power_sandwich_cylindrical_shell_ex_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_equiv_aco_power_sandwich_cylindrical_shell_ex (see VARARGIN)

% Choose default command line output for SEA_equiv_aco_power_sandwich_cylindrical_shell_ex
handles.output = hObject;


ng=getappdata(0,'cylindrical_shell_ng');
nd=getappdata(0,'cylindrical_shell_nd');

imat=getappdata(0,'cylindrical_honeycomb_shell_mat');
bc=getappdata(0,'cylindrical_honeycomb_shell_bc');
nfa=getappdata(0,'cylindrical_honeycomb_shell_nfa');


dlf=getappdata(0,'cylindrical_shell_dlf');
diameter=getappdata(0,'cylindrical_shell_diam');

L=getappdata(0,'cylindrical_shell_L');

E=getappdata(0,'cylindrical_honeycomb_shell_em');
rho_f=getappdata(0,'cylindrical_honeycomb_shell_md_f');
mu=getappdata(0,'cylindrical_honeycomb_shell_mu');
tf=getappdata(0,'cylindrical_honeycomb_shell_thick_f');
G=getappdata(0,'cylindrical_honeycomb_shell_G');
rho_c=getappdata(0,'cylindrical_honeycomb_shell_md_c');
hc=getappdata(0,'cylindrical_honeycomb_shell_thick_c');
 
gas_c=getappdata(0,'cylindrical_shell_c');
gas_md=getappdata(0,'cylindrical_shell_gas_md');

%

FS=getappdata(0,'external_spl_name');

%%

if(isempty(dlf)==0)
    ss=sprintf('%g',mean(dlf));
    set(handles.edit_ulf,'String',ss);
end
 
if(isempty(diameter)==0)
    ss=sprintf('%g',diameter);
    set(handles.edit_diam,'String',ss);
end



if(isempty(FS)==0)
    set(handles.edit_input_array,'String',FS);
end

if(isempty(nd)==0)
    if(nd==1 || nd==2)
        set(handles.listbox_dlf,'Value',nd);
    else
        set(handles.listbox_dlf,'Value',1);       
    end
end

if(isempty(ng)==0)
    if(ng==1 || ng==2)
        set(handles.listbox_gas,'Value',ng);
    else
        set(handles.listbox_gas,'Value',1);       
    end    
end

if(isempty(imat)==0)
    if(imat>=1 && imat <=7)
 
       set(handles.listbox_material,'Value',imat);
    else
       set(handles.listbox_material,'Value',1);       
    end     
end


if(isempty(bc)==0)
    if(bc>=1 && bc <=4)
        set(handles.listbox_bc,'Value',bc);
    else
        set(handles.listbox_bc,'Value',1);        
    end
end


if(isempty(nfa)==0)
    if(nfa>=1 && nfa <=2)
        set(handles.listbox_cylindrical_shell_assembly,'Value',nfa);
    else
        set(handles.listbox_cylindrical_shell_assembly,'Value',1);        
    end
end

%

if(isempty(L)==0)
    set(handles.edit_L,'String',L);
end
if(isempty(E)==0)
    set(handles.edit_em,'String',E);
end
if(isempty(rho_f)==0)
    set(handles.edit_md_f,'String',rho_f);
end
if(isempty(mu)==0)
    set(handles.edit_mu,'String',mu);
end
if(isempty(tf)==0)
    set(handles.edit_thick_f,'String',tf);
end
if(isempty(G)==0)
    set(handles.edit_shear_modulus,'String',G);
end
if(isempty(rho_c)==0)
    set(handles.edit_md_c,'String',rho_c);
end
if(isempty(hc)==0)
    set(handles.edit_thick_c,'String',hc);
end
if(isempty(gas_c)==0)
    set(handles.edit_c,'String',gas_c);
end
if(isempty(gas_md)==0)
    set(handles.edit_gas_md,'String',gas_md);
end




change(hObject, eventdata, handles);
listbox_dlf_Callback(hObject, eventdata, handles);








% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_equiv_aco_power_sandwich_cylindrical_shell_ex wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_equiv_aco_power_sandwich_cylindrical_shell_ex_OutputFcn(hObject, eventdata, handles) 
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

delete(SEA_equiv_aco_power_sandwich_cylindrical_shell_ex);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=getappdata(0,'iu');

nd=get(handles.listbox_dlf,'Value');
ng=get(handles.listbox_gas,'Value');

setappdata(0,'cylindrical_shell_ng',ng);
setappdata(0,'cylindrical_shell_nd',nd);

imat=get(handles.listbox_material,'Value');
setappdata(0,'cylindrical_honeycomb_shell_mat',imat);

bc=get(handles.listbox_bc,'Value');
nfa=get(handles.listbox_cylindrical_shell_assembly,'Value');

setappdata(0,'cylindrical_honeycomb_shell_mat',imat);
setappdata(0,'cylindrical_honeycomb_shell_bc',bc);
setappdata(0,'cylindrical_honeycomb_shell_nfa',nfa);


L=str2num(get(handles.edit_L,'String'));

if isempty(L)
   warndlg('Length missing.'); 
   return;
end
setappdata(0,'cylindrical_shell_L',L);

diam=str2num(get(handles.edit_diam,'String'));

if isempty(diam)
   warndlg('Diameter missing.'); 
   return;
end

E=str2num(get(handles.edit_em,'String'));
mu=str2num(get(handles.edit_mu,'String'));
G=str2num(get(handles.edit_shear_modulus,'String'));

rhoc=str2num(get(handles.edit_md_c,'String'));

hc=str2num(get(handles.edit_thick_c,'String'));

if isempty(hc)
   warndlg('Core Thickness missing.'); 
   return;
end

tf=str2num(get(handles.edit_thick_f,'String'));

if isempty(tf)
   warndlg('Face Sheet thickness missing.'); 
   return;
end

setappdata(0,'cylindrical_honeycomb_shell_thick_f',tf);

setappdata(0,'cylindrical_honeycomb_shell_G',G);
setappdata(0,'cylindrical_honeycomb_shell_md_c',rhoc);
setappdata(0,'cylindrical_honeycomb_shell_thick_c',hc);



rhof=str2num(get(handles.edit_md_f,'String'));


setappdata(0,'cylindrical_honeycomb_shell_em',E);
setappdata(0,'cylindrical_honeycomb_shell_md_f',rhof);
setappdata(0,'cylindrical_honeycomb_shell_mu',mu);
setappdata(0,'cylindrical_honeycomb_shell_thick_f',tf);
setappdata(0,'cylindrical_honeycomb_shell_G',G);
setappdata(0,'cylindrical_honeycomb_shell_md_c',rhoc);
setappdata(0,'cylindrical_honeycomb_shell_thick_c',hc);


gas_c=str2num(get(handles.edit_c,'String')); 
gas_md=str2num(get(handles.edit_gas_md,'String'));

setappdata(0,'cylindrical_shell_c',gas_c);
setappdata(0,'cylindrical_shell_gas_md',gas_md);


% % %

if(iu==1)
   rhoc=rhoc/386;
   rhof=rhof/386;
   gas_c=gas_c*12;
   gas_md=gas_md/(12^3*386);
else
   [E]=GPa_to_Pa(E);
   [G]=GPa_to_Pa(G);
   tf=tf/1000;
   hc=hc/1000;
end

gas_rho_c=gas_c*gas_md;

thick=hc+2*tf;

area=pi*diam*L;

[CL]=CL_plate(E,rhof,mu);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    external_SPL=getappdata(0,'external_SPL');
    
    if(isempty(external_SPL)==0)
    
        ss=getappdata(0,'external_spl_name');
        out1=sprintf('%s_=external_SPL;',ss);
        eval(out1); 
        THM=external_SPL;
        iflag=1;
        
    else
       iflag=0; 
    end
catch
    iflag=0;
end

if(iflag==0)
    try  
        FS=get(handles.edit_input_array,'String');
        THM=evalin('base',FS);  
        setappdata(0,'external_spl_name',FS);
    catch  
        warndlg('Input Array does not exist.  Try again.')
        return;
    end
end

sz=size(THM);

if(sz(2)~=2)
    warndlg('Input file must have 2 columns ');
    return;
end

%%%%%%

fc=THM(:,1);
dB=THM(:,2);

setappdata(0,'fc',fc);

NL=length(fc);

pressure=zeros(NL,1);

for i=1:NL

    [psi_rms,Pa_rms]=convert_dB_pressure(dB(i));

    if(iu==1)
        pressure(i)=psi_rms; 
    else
        pressure(i)=Pa_rms;     
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[D,K,~,~,fring]=honeycomb_sandwich_properties_wave(E,G,mu,tf,hc,diam,rhof,rhoc);


[f1,f2]=shear_frequencies(E,G,mu,tf,hc,rhof,rhoc);

NSM_per_area=0;

[fcr,mpa,kflag]=...
          honeycomb_sandwich_critical_frequency(E,G,mu,tf,hc,rhof,rhoc,gas_c,NSM_per_area);

      
setappdata(0,'cylindrical_shell_fring',fring);     
setappdata(0,'cylindrical_shell_fcr',fcr); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mmax=160;
nmax=160;

v=mu;

P=zeros(NL,1);

dlf=zeros(NL,1);

if(nd==2)
    ulf=str2num(get(handles.edit_ulf,'String'));
    
   if( isempty(ulf)==1)
       warndlg('Enter loss factor');
       return;
   end    
    
end


[rad_eff,mph]=...
   re_sandwich_cylinder_engine_alt(D,K,v,diam,L,mpa,bc,mmax,nmax,gas_c,fcr,fring,fc);


fp=500;

for i=1:NL
         
    [P(i)]=equivalent_acoustic_power_alt(mph(i),gas_c,rad_eff(i),pressure(i),mpa,fc(i));   
    
    
    if(nd==1)
    
        if(nfa==1)  % bare
    
            dlf(i)=0.3/(fc(i)^0.63);
    
        else        % built-up
        
            if(f(i)<=fp)
                dlf(i)=0.05;
            else
                dlf(i)=0.050*sqrt(fp/fc(i));
            end
            
        end
    
    else
        dlf(i)=ulf;
    end    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' Input Power from Diffuse Acoustic Field into Sandwich Cylindrical Shell');
disp(' ');

    disp('  Center     Modal  ');
    disp(' Frequency  Density     Radiation       Power ');
    
if(iu==1)
    disp('    (Hz)   (modes/Hz)   Efficiency    (in-lbf/sec) ');
else
    disp('    (Hz)   (modes/Hz)   Efficiency        (W) ');    
end    

for i=1:NL
   out1=sprintf('     %g   %8.4g     %8.4g    %8.4g',fc(i),mph(i),rad_eff(i),P(i));
   disp(out1);
end
power=P;


mass=mpa*area;
volume=area*thick;
md=mass/volume;

rad_res=rad_eff*gas_rho_c*area;

power=[fc power];

setappdata(0,'external_acoustic_power',power);
setappdata(0,'external_SPL',THM);
setappdata(0,'cylindrical_shell_modal_density',mph);
setappdata(0,'cylindrical_shell_rad_eff',rad_eff);
setappdata(0,'cylindrical_shell_rad_res',rad_res);
setappdata(0,'cylindrical_shell_dlf',dlf);
setappdata(0,'cylindrical_shell_mass',mass);
setappdata(0,'cylindrical_shell_diam',diam);
setappdata(0,'cylindrical_shell_thick',thick);
setappdata(0,'cylindrical_shell_area',area);
setappdata(0,'cylindrical_shell_md',md);
setappdata(0,'cylindrical_shell_cL',CL);

mdens=[fc mph];   % keep after setappdata
rad_eff=[fc rad_eff];
rad_res=[fc rad_res];
dlf=[fc dlf];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=200;
[fig_num]=acoustic_power_cylinder_plots(fig_num,power,mdens,rad_eff,dlf,iu);
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('  ');
out2=sprintf('     Ring Frequency = %7.4g Hz ',fring);
out3=sprintf(' Critical Frequency = %7.4g Hz ',fcr);

disp(out2);
disp(out3);

display_shear_frequencies(f1,f2);
disp(' ');

msgbox('Results written to Command Window');
    
    


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



function edit_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L as text
%        str2double(get(hObject,'String')) returns contents of edit_L as a double


% --- Executes during object creation, after setting all properties.
function edit_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_width as text
%        str2double(get(hObject,'String')) returns contents of edit_width as a double


% --- Executes during object creation, after setting all properties.
function edit_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
%
iu=getappdata(0,'iu');

imat=get(handles.listbox_material,'Value');
ng=get(handles.listbox_gas,'Value');
%

%%%%%%%%%%%%%   

if(iu==1)
    
    set(handles.text_L,'String','Length (in)');

    set(handles.text_thick_f,'String','Individual Face Sheet Thickness (in)');
    set(handles.text_thick_c,'String','Core Thickness (in)');
    set(handles.text_em_f,'String','Elastic Modulus (psi)');
    set(handles.text_md_f,'String','Mass Density (lbm/in^3)');
    set(handles.text_shear_modulus,'String','Shear Modulus (psi)');
    set(handles.text_md_c,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_diam,'String','Diameter (in)');
    
    set(handles.text_gas_md,'String','Gas Mass Density (lbm/ft^3)'); 
    set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)');     
  
    if(ng==1)
        set(handles.edit_c,'String','1125');
        set(handles.edit_gas_md,'String','0.076487');       
    else
        set(handles.edit_c,'String',' ');   
        set(handles.edit_gas_md,'String',' ');        
    end
    
    
else
    
    set(handles.text_L,'String','Length (m)');

    set(handles.text_thick_f,'String','Individual Face Sheet Thickness (mm)');
    set(handles.text_thick_c,'String','Core Thickness (mm)');
    set(handles.text_em_f,'String','Elastic Modulus (GPa)');
    set(handles.text_md_f,'String','Mass Density (kg/m^3)');
    set(handles.text_shear_modulus,'String','Shear Modulus (MPa)');
    set(handles.text_md_c,'String','Mass Density (kg/m^3)');     
    set(handles.text_diam,'String','Diameter (m)');    
    
    set(handles.text_gas_md,'String','Gas Mass Density (kg/m^3)');    
    set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
    
    if(ng==1)
        set(handles.edit_c,'String','343');  
        set(handles.edit_gas_md,'String','1.225');         
    else
        set(handles.edit_c,'String',' ');      
        set(handles.edit_gas_md,'String',' ');          
    end    
    
end

%%%%
 
[elastic_modulus,mass_density,poisson]=six_materials(iu,imat);
 
%%%%
 
if(imat<=6)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
        ss3=sprintf('%8.4g',poisson);
else
        ss1=' ';
        ss2=' ';
        ss3=' ';        
end
 
set(handles.edit_em,'String',ss1);
set(handles.edit_md_f,'String',ss2); 
set(handles.edit_mu,'String',ss3);

%%%%





% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    A = imread('re_sandwich_cylinder.jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100)  


% --- Executes on selection change in listbox_geo.
function listbox_geo_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_geo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_geo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_geo
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_geo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_geo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diam_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diam as text
%        str2double(get(hObject,'String')) returns contents of edit_diam as a double


% --- Executes during object creation, after setting all properties.
function edit_diam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_bc.
function listbox_bc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bc


% --- Executes during object creation, after setting all properties.
function listbox_bc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pressure_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pressure as text
%        str2double(get(hObject,'String')) returns contents of edit_pressure as a double


% --- Executes during object creation, after setting all properties.
function edit_pressure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_pu.
function listbox_pu_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pu


% --- Executes during object creation, after setting all properties.
function listbox_pu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pu (see GCBO)
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


% --- Executes on selection change in listbox_eq.
function listbox_eq_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_eq contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_eq


% --- Executes during object creation, after setting all properties.
function listbox_eq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_view_eq.
function pushbutton_view_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_eq,'Value');

if(n==1)
    A = imread('modal_density_sandwich_cylinder.jpg');
    figure(997)    
end
if(n==2)
    A = imread('re_sandwich_cylinder.jpg');
    figure(998)     
end
if(n==3)
    A = imread('equivalent_acoustic_power_cylinder.jpg');
    figure(999)     
end
if(n==4)
    A = imread('sandwich_lf.jpg');
    figure(996) 
    imshow(A,'border','tight','InitialMagnification',100)        
end

imshow(A,'border','tight','InitialMagnification',100); 


% --- Executes on selection change in listbox_cylindrical_shell_assembly.
function listbox_cylindrical_shell_assembly_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cylindrical_shell_assembly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cylindrical_shell_assembly contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cylindrical_shell_assembly


% --- Executes during object creation, after setting all properties.
function listbox_cylindrical_shell_assembly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cylindrical_shell_assembly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_dlf.
function listbox_dlf_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dlf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dlf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dlf

nd=get(handles.listbox_dlf,'Value'); 
 
set(handles.text_ulf,'Visible','on');
set(handles.edit_ulf,'Visible','on'); 
 
if(nd==1)
    set(handles.text_ulf,'Visible','off');
    set(handles.edit_ulf,'Visible','off');    
end    


% --- Executes during object creation, after setting all properties.
function listbox_dlf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dlf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ulf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ulf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ulf as text
%        str2double(get(hObject,'String')) returns contents of edit_ulf as a double


% --- Executes during object creation, after setting all properties.
function edit_ulf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ulf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_cylindrical_shell_assembly.
function listbox_fairing_assembly_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cylindrical_shell_assembly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cylindrical_shell_assembly contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cylindrical_shell_assembly


% --- Executes during object creation, after setting all properties.
function listbox_fairing_assembly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cylindrical_shell_assembly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
