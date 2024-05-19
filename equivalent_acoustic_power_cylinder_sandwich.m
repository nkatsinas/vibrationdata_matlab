function varargout = equivalent_acoustic_power_cylinder_sandwich(varargin)
% EQUIVALENT_ACOUSTIC_POWER_CYLINDER_SANDWICH MATLAB code for equivalent_acoustic_power_cylinder_sandwich.fig
%      EQUIVALENT_ACOUSTIC_POWER_CYLINDER_SANDWICH, by itself, creates a new EQUIVALENT_ACOUSTIC_POWER_CYLINDER_SANDWICH or raises the existing
%      singleton*.
%
%      H = EQUIVALENT_ACOUSTIC_POWER_CYLINDER_SANDWICH returns the handle to a new EQUIVALENT_ACOUSTIC_POWER_CYLINDER_SANDWICH or the handle to
%      the existing singleton*.
%
%      EQUIVALENT_ACOUSTIC_POWER_CYLINDER_SANDWICH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EQUIVALENT_ACOUSTIC_POWER_CYLINDER_SANDWICH.M with the given input arguments.
%
%      EQUIVALENT_ACOUSTIC_POWER_CYLINDER_SANDWICH('Property','Value',...) creates a new EQUIVALENT_ACOUSTIC_POWER_CYLINDER_SANDWICH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before equivalent_acoustic_power_cylinder_sandwich_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to equivalent_acoustic_power_cylinder_sandwich_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help equivalent_acoustic_power_cylinder_sandwich

% Last Modified by GUIDE v2.5 27-Jan-2016 15:05:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @equivalent_acoustic_power_cylinder_sandwich_OpeningFcn, ...
                   'gui_OutputFcn',  @equivalent_acoustic_power_cylinder_sandwich_OutputFcn, ...
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


% --- Executes just before equivalent_acoustic_power_cylinder_sandwich is made visible.
function equivalent_acoustic_power_cylinder_sandwich_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to equivalent_acoustic_power_cylinder_sandwich (see VARARGIN)

% Choose default command line output for equivalent_acoustic_power_cylinder_sandwich
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes equivalent_acoustic_power_cylinder_sandwich wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = equivalent_acoustic_power_cylinder_sandwich_OutputFcn(hObject, eventdata, handles) 
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

delete(equivalent_acoustic_power_cylinder_sandwich);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');


L=str2num(get(handles.edit_L,'String'));
diam=str2num(get(handles.edit_diam,'String'));

E=str2num(get(handles.edit_em,'String'));
mu=str2num(get(handles.edit_mu,'String'));
G=str2num(get(handles.edit_shear_modulus,'String'));

rhoc=str2num(get(handles.edit_md_c,'String'));
hc=str2num(get(handles.edit_thick_c,'String'));

tf=str2num(get(handles.edit_thick_f,'String'));
rhof=str2num(get(handles.edit_md_f,'String'));

bc=get(handles.listbox_bc,'Value');

air_c=str2num(get(handles.edit_c,'String')); 

if(iu==1)
   rhoc=rhoc/386;
   rhof=rhof/386;
   air_c=air_c*12;
else
   [E]=GPa_to_Pa(E);
   [G]=GPa_to_Pa(G);
   tf=tf/1000;
   hc=hc/1000;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[D,K,~,~,fring]=honeycomb_sandwich_properties_wave(E,G,mu,tf,hc,diam,rhof,rhoc);

[f1,f2]=shear_frequencies(E,G,mu,tf,hc,rhof,rhoc);

 NSM_per_area=0;

[fcr,mpa,kflag]=...
          honeycomb_sandwich_critical_frequency(E,G,mu,tf,hc,rhof,rhoc,air_c,NSM_per_area);

if(kflag==1)
    warndlg('Critical frequency does not exist for this case');
    return;
end
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mmax=160;
nmax=160;

v=mu;

[fc,rad_eff,nun]=...
        re_sandwich_cylinder_engine(D,K,v,diam,L,mpa,bc,mmax,nmax,air_c,fcr,fring);
         
fc=fix_size(fc);
rad_eff=fix_size(rad_eff);
nun=fix_size(nun);

disp(' ');
disp(' The modal density shown here is for bending modes only. ');
disp(' ');
disp('           Modal                ');
disp('  Freq    Density    Radiation  ');
disp('  (Hz)   (modes/Hz)  Efficiency ');

for i=1:length(fc)
     out1=sprintf(' %g  %8.4g  %8.4g  ',fc(i),nun(i),rad_eff(i));
     disp(out1);
end

rad_eff=[fc rad_eff];              
modal_dens=[fc nun];

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

    display_shear_frequencies(f1,f2);

    if(iu==1)
        out1=sprintf('\n mass/area = %8.4g lbm/in^2',mpa*386);
    else
        out1=sprintf('\n mass/area = %8.4g kg/m^2',mpa);   
    end
    disp(out1);
    
    assignin('base', 'rad_eff', rad_eff);      
    assignin('base', 'modal_dens', modal_dens); 
    
    disp(' ');
    disp(' Output array: ');
    disp('  ');
    disp('      rad_eff - freq (Hz) & radiation efficiency ');
    disp(' ');
 
%%%%
    
fig_num=1;

t_string='Honeycomb Sandwich Cylinder Radiation Efficiency';
     
y_label='Rad Eff';
x_label='Frequency (Hz)';

md=3;

fmin=min(fc);
fmax=max(fc);

[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
     



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
iu=get(handles.listbox_units,'Value');
imat=get(handles.listbox_material,'Value');
ng=get(handles.listbox_gas,'Value');
%

if(iu==1)
    
    set(handles.text_L,'String','Length (in)');

    set(handles.text_thick_f,'String','Individual Face Sheet Thickness (in)');
    set(handles.text_thick_c,'String','Core Thickness (in)');
    set(handles.text_em_f,'String','Elastic Modulus (psi)');
    set(handles.text_md_f,'String','Mass Density (lbm/in^3)');
    set(handles.text_shear_modulus,'String','Shear Modulus (psi)');
    set(handles.text_md_c,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_diam,'String','Diameter (in)');
    set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)'); 
    
    if(ng==1)
        set(handles.edit_c,'String','1125');     
    else
        set(handles.edit_c,'String',' ');           
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
    set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
    
    if(ng==1)
        set(handles.edit_c,'String','343');          
    else
        set(handles.edit_c,'String',' ');      
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
