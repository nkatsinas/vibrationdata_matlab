function varargout = radiation_efficiency_cylinder(varargin)
% RADIATION_EFFICIENCY_CYLINDER MATLAB code for radiation_efficiency_cylinder.fig
%      RADIATION_EFFICIENCY_CYLINDER, by itself, creates a new RADIATION_EFFICIENCY_CYLINDER or raises the existing
%      singleton*.
%
%      H = RADIATION_EFFICIENCY_CYLINDER returns the handle to a new RADIATION_EFFICIENCY_CYLINDER or the handle to
%      the existing singleton*.
%
%      RADIATION_EFFICIENCY_CYLINDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RADIATION_EFFICIENCY_CYLINDER.M with the given input arguments.
%
%      RADIATION_EFFICIENCY_CYLINDER('Property','Value',...) creates a new RADIATION_EFFICIENCY_CYLINDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before radiation_efficiency_cylinder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to radiation_efficiency_cylinder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help radiation_efficiency_cylinder

% Last Modified by GUIDE v2.5 10-May-2016 17:44:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @radiation_efficiency_cylinder_OpeningFcn, ...
                   'gui_OutputFcn',  @radiation_efficiency_cylinder_OutputFcn, ...
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


% --- Executes just before radiation_efficiency_cylinder is made visible.
function radiation_efficiency_cylinder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to radiation_efficiency_cylinder (see VARARGIN)

% Choose default command line output for radiation_efficiency_cylinder
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes radiation_efficiency_cylinder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = radiation_efficiency_cylinder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(radiation_efficiency_honeycomb_sandwich_cylinder);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

iu=get(handles.listbox_units,'Value');

ni=get(handles.listbox_incidence,'Value');

L=str2num(get(handles.edit_L,'String'));
diam=str2num(get(handles.edit_diam,'String'));
h=str2num(get(handles.edit_thick,'String'));

em=str2num(get(handles.edit_em,'String'));
mu=str2num(get(handles.edit_mu,'String'));

rho=str2num(get(handles.edit_md,'String'));

bc=get(handles.listbox_bc,'Value');

air_c=str2num(get(handles.edit_c,'String')); 

gas_md=str2num(get(handles.edit_gas_md,'String'));


if(iu==1)
   rho=rho/386;
   air_c=air_c*12;
   gas_md=gas_md/(386*12^3);   
else
   [em]=GPa_to_Pa(em);
   h=h/1000;
end

rho_c_air=gas_md*air_c;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[D,K,mpa,fcr,fring,~]=cylinder_properties_wave(em,mu,h,diam,rho,air_c);

mmax=160;
nmax=160;

v=mu;

[fc,rad_eff,nun]=...
        re_sandwich_cylinder_engine(D,K,v,diam,L,mpa,bc,mmax,nmax,air_c,fcr,fring);
          
fc=fix_size(fc);
rad_eff=fix_size(rad_eff);
nun=fix_size(nun);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pdiam=diam*pi;

Ap=L*pdiam;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NL=length(rad_eff);

radiation_resistance=zeros(NL,1);


for i=1:NL
    radiation_resistance(i)=gas_md*Ap*rad_eff(i); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
fc=fix_size(fc);
rad_eff=fix_size(rad_eff);
nun=fix_size(nun);

disp(' ');
disp(' The modal density shown here is for bending modes only. ');
disp(' ');
disp('           Modal                ');
disp('  Freq    Density    Radiation    Transsmission');
disp('  (Hz)   (modes/Hz)  Efficiency     Loss (dB)');

nfc=length(fc);

TL=zeros(nfc,1);


for i=1:nfc
     
     omega=tpi*fc(i);

     [TL(i)]=mass_law_transmission_loss(omega,mpa,rho_c_air,ni);

     out1=sprintf(' %8.1f   %8.4f    %8.4f    %8.2f',fc(i),nun(i),rad_eff(i),TL(i));
     disp(out1);     
end

rad_eff=[fc rad_eff];              
modal_dens=[fc nun];
trans_loss_dB=[fc TL];

ppp=rad_eff;

while(1)
    if(ppp(1,2)==0 || ppp(2,2)==0 || ppp(3,2)==0)
        ppp(1,:)=[];
    else
       break;
    end
end


%%%%
    
    disp(' ');
    out1=sprintf(' Critical Frequency = %8.4g Hz ',fcr);
    disp(out1);
    disp(' ');
    out1=sprintf(' Ring Frequency     = %8.4g Hz ',fring);
    disp(out1);


    if(iu==1)
        out1=sprintf('\n mass/area = %8.4g lbm/in^2',mpa*386);
    else
        out1=sprintf('\n mass/area = %8.4g kg/m^2',mpa);   
    end
    disp(out1);
    
    assignin('base', 'rad_eff', rad_eff);      
    assignin('base', 'modal_dens', modal_dens); 
    assignin('base', 'trans_loss_dB',trans_loss_dB);
    
    disp(' ');
    disp(' Output arrays: ');
    disp('  ');
    disp('         rad_eff - freq (Hz) & radiation efficiency ');
    disp('   trans_loss_dB - freq (Hz) & transmission loss    ');    
    disp(' ');
 
%%%%
    
fig_num=1;

t_string='Cylinder Radiation Efficiency';
     
y_label='Rad Eff';
x_label='Frequency (Hz)';

md=3;

fmin=min(fc);
fmax=max(fc);

[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%

if(ni==1)
         t_string='Transmission Loss, Normal Incidence';
end
if(ni==2)
         t_string='Transmission Loss, Field Incidence';
end
if(ni==3)
         t_string='Transmission Loss, Random Incidence';
end


y_label='TL (dB)';

[fig_num,h2]=...
    plot_loglin_function_h2(fig_num,x_label,y_label,t_string,trans_loss_dB,fmin,fmax);

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



function edit_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md as text
%        str2double(get(hObject,'String')) returns contents of edit_md as a double


% --- Executes during object creation, after setting all properties.
function edit_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
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



function edit_thick_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thick as text
%        str2double(get(hObject,'String')) returns contents of edit_thick as a double


% --- Executes during object creation, after setting all properties.
function edit_thick_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thick (see GCBO)
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
iu=get(handles.listbox_units,'Value');
imat=get(handles.listbox_material,'Value');
ng=get(handles.listbox_gas,'Value');
%

if(iu==1)
    
    set(handles.text_L,'String','Length (in)');

    set(handles.text_thick,'String','Thickness (in)');
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)');
    set(handles.text_diam,'String','Diameter (in)');
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
    
    set(handles.text_L,'String','Length (m)');

    set(handles.text_thick,'String','Thickness (mm)');
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');   
    set(handles.text_diam,'String','Diameter (m)');    
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
set(handles.edit_md,'String',ss2); 
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq_TL.
function pushbutton_eq_TL_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq_TL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    A = imread('TL_mass_law.jpg');
    figure(998) 
    imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on selection change in listbox_incidence.
function listbox_incidence_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_incidence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_incidence contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_incidence


% --- Executes during object creation, after setting all properties.
function listbox_incidence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_incidence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
