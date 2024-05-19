function varargout = annular_honeycomb_sandwich_cylindrical_shell_example(varargin)
% ANNULAR_HONEYCOMB_SANDWICH_CYLINDRICAL_SHELL_EXAMPLE MATLAB code for annular_honeycomb_sandwich_cylindrical_shell_example.fig
%      ANNULAR_HONEYCOMB_SANDWICH_CYLINDRICAL_SHELL_EXAMPLE, by itself, creates a new ANNULAR_HONEYCOMB_SANDWICH_CYLINDRICAL_SHELL_EXAMPLE or raises the existing
%      singleton*.
%
%      H = ANNULAR_HONEYCOMB_SANDWICH_CYLINDRICAL_SHELL_EXAMPLE returns the handle to a new ANNULAR_HONEYCOMB_SANDWICH_CYLINDRICAL_SHELL_EXAMPLE or the handle to
%      the existing singleton*.
%
%      ANNULAR_HONEYCOMB_SANDWICH_CYLINDRICAL_SHELL_EXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANNULAR_HONEYCOMB_SANDWICH_CYLINDRICAL_SHELL_EXAMPLE.M with the given input arguments.
%
%      ANNULAR_HONEYCOMB_SANDWICH_CYLINDRICAL_SHELL_EXAMPLE('Property','Value',...) creates a new ANNULAR_HONEYCOMB_SANDWICH_CYLINDRICAL_SHELL_EXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before annular_honeycomb_sandwich_cylindrical_shell_example_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to annular_honeycomb_sandwich_cylindrical_shell_example_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help annular_honeycomb_sandwich_cylindrical_shell_example

% Last Modified by GUIDE v2.5 26-May-2016 15:08:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @annular_honeycomb_sandwich_cylindrical_shell_example_OpeningFcn, ...
                   'gui_OutputFcn',  @annular_honeycomb_sandwich_cylindrical_shell_example_OutputFcn, ...
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


% --- Executes just before annular_honeycomb_sandwich_cylindrical_shell_example is made visible.
function annular_honeycomb_sandwich_cylindrical_shell_example_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to annular_honeycomb_sandwich_cylindrical_shell_example (see VARARGIN)

% Choose default command line output for annular_honeycomb_sandwich_cylindrical_shell_example
handles.output = hObject;

ndlf=getappdata(0,'shelf_ndlf');
if(isempty(ndlf)==0)
    if(ndlf>=1 && ndlf<=3)
        set(handles.listbox_dlf,'Value',ndlf);
    else
        set(handles.listbox_dlf,'Value',1);        
    end
end 

imat=getappdata(0,'homogeneous_shelf_imat');
if(isempty(imat)==0)
    if(imat>=1 && imat<=7)
        set(handles.listbox_material,'Value',imat);
    else
        set(handles.listbox_material,'Value',1);        
    end
end 

E=getappdata(0,'honeycomb_shelf_em');
if(isempty(E)==0)
    ss=sprintf('%g',E);
    set(handles.edit_em,'String',ss);
end 

rhof=getappdata(0,'honeycomb_shelf_md_f');
if(isempty(rhof)==0)
    ss=sprintf('%g',rhof);
    set(handles.edit_md_f,'String',ss);
end 

mu=getappdata(0,'honeycomb_shelf_mu');
if(isempty(mu)==0)
    ss=sprintf('%g',mu);
    set(handles.edit_mu,'String',ss);
end 

tf=getappdata(0,'honeycomb_shelf_thick_f');
if(isempty(tf)==0)
    ss=sprintf('%g',tf);
    set(handles.edit_thick_f,'String',ss);
end 

G=getappdata(0,'honeycomb_shelf_G');
if(isempty(G)==0)
    ss=sprintf('%g',G);
    set(handles.edit_shear_modulus,'String',ss);
end 

rhoc=getappdata(0,'honeycomb_shelf_md_c');
if(isempty(rhoc)==0)
    ss=sprintf('%g',rhoc);
    set(handles.edit_md_c,'String',ss);
end 

hc=getappdata(0,'honeycomb_shelf_thick_c');
if(isempty(hc)==0)
    ss=sprintf('%g',hc);
    set(handles.edit_thick_c,'String',ss);
end  

dlf=getappdata(0,'shelf_dlf');
if(isempty(dlf)==0)
    ss=sprintf('%g',mean(dlf));
    set(handles.edit_ulf,'String',ss);
end 

NSM=getappdata(0,'shelf_NSM');
if(isempty(NSM)==0)
    ss=sprintf('%g',NSM);
    set(handles.NSM_edit,'String',ss);
end 

OD=getappdata(0,'annular_shelf_OD');
if(isempty(OD)==0)
    ss=sprintf('%g',OD);
    set(handles.edit_OD,'String',ss);
end 

ID=getappdata(0,'annular_shelf_ID');
if(isempty(ID)==0)
    ss=sprintf('%g',ID);
    set(handles.edit_ID,'String',ss);
end 


change(hObject, eventdata, handles);
listbox_dlf_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes annular_honeycomb_sandwich_cylindrical_shell_example wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = annular_honeycomb_sandwich_cylindrical_shell_example_OutputFcn(hObject, eventdata, handles) 
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

delete(annular_honeycomb_sandwich_cylindrical_shell_example);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=getappdata(0,'iu');

c=getappdata(0,'acoustic_cavity_gas_c');
 
if isempty(c)
   warndlg('acoustic_cavity_gas_c missing. Run Acoustic Cavity'); 
   return;
end 


fc=getappdata(0,'fc');
nfc=length(fc); 
if(nfc==0)
    warndlg(' Frequency bands undefined. ');
    return;
end
f=fc;

OD=str2num(get(handles.edit_OD,'String'));
ID=str2num(get(handles.edit_ID,'String'));

if(ID>=OD)
  warndlg('Diameter error');  
  return;  
end

setappdata(0,'annular_shelf_OD',OD);
setappdata(0,'annular_shelf_ID',ID);

[Ap]=area_annular_plate(OD,ID);

E=str2num(get(handles.edit_em,'String'));
v=str2num(get(handles.edit_mu,'String'));
mu=v;
G=str2num(get(handles.edit_shear_modulus,'String'));

rhoc=str2num(get(handles.edit_md_c,'String'));
hc=str2num(get(handles.edit_thick_c,'String'));


tf=str2num(get(handles.edit_thick_f,'String'));
rhof=str2num(get(handles.edit_md_f,'String'));

[CL]=CL_plate(E,rhof,v);

NSM=str2num(get(handles.NSM_edit,'String'));

setappdata(0,'honeycomb_shelf_em',E);
setappdata(0,'honeycomb_shelf_md_f',rhof);
setappdata(0,'honeycomb_shelf_mu',mu);
setappdata(0,'honeycomb_shelf_thick_f',tf);
setappdata(0,'honeycomb_shelf_G',G);
setappdata(0,'honeycomb_shelf_md_c',rhoc);
setappdata(0,'honeycomb_shelf_thick_c',hc);
setappdata(0,'shelf_NSM',NSM);

if(iu==1)
   rhoc=rhoc/386;
   rhof=rhof/386;
   NSM=NSM/386;
else
   [E]=GPa_to_Pa(E);
   [G]=GPa_to_Pa(G);
   tf=tf/1000;
   hc=hc/1000;
end

total_thick=hc+2*tf;
volume=Ap*total_thick;

% Renji method in Wijker book


[mph,fcr,f1,f2,rad_eff,total_mass,mpa_total]=...
             SEA_honeycomb_sandwich_all(E,G,v,Ap,tf,hc,rhof,rhoc,NSM,fc,c);
                                     
setappdata(0,'shelf_fcr',fcr); 

mph=(8/pi^2)*mph;  % Annular 



%%%    

ndlf=get(handles.listbox_dlf,'Value');


if(ndlf==3)
   ulf=str2num(get(handles.edit_ulf,'String')); 
   
   if( isempty(ulf)==1)
       warndlg('Enter loss factor');
       return;
   end   
   
end
 
dlf=zeros(ndlf,1);


for i=1:nfc
 
    if(ndlf==1)
        [dlf(i)]=sandwich_panel_bare_lf(fc(i));
    end
    if(ndlf==2)    
        [dlf(i)]=sandwich_panel_built_up_lf(fc(i));              
    end
    if(ndlf==3)        
        dlf(i)=ulf;
    end
end
    
%%%

dlf=fix_size(dlf); % keep

total_md=total_mass/volume;


setappdata(0,'shelf_mass',total_mass);
setappdata(0,'shelf_modal_density',mph);
setappdata(0,'shelf_ndlf',ndlf);
setappdata(0,'shelf_dlf',dlf);
setappdata(0,'total_shelf_thick',total_thick);
setappdata(0,'shelf_cL',CL);
setappdata(0,'total_shelf_md',total_md);
setappdata(0,'shelf_area',Ap);
setappdata(0,'shelf_rad_eff',rad_eff);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

display_freq_mdens_dlf(fc,mph,dlf);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;
x_label='Frequency (Hz)';
y_label='Modal Density (modes/Hz)';
t_string='Modal Density  Annular Sandwich Plate';
ppp=[fc mph];
fmin=min(fc);
fmax=max(fc);

[fig_num,h2]=...
   plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);


y_label='Loss Factor';
t_string='Loss Factor  Annular Sandwich Plate';
ppp=[fc dlf];

[fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);


t_string='Radiation Efficiency  Annular Sandwich Plate';
ppp=[fc rad_eff];

[fig_num,h2]=plot_loglog_function_h2_rad_eff(fig_num,x_label,t_string,ppp,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

display_shear_frequencies(f1,f2)
 
display_mass_per_area(mpa_total,iu);

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
%

if(iu==1)
    
    set(handles.text_thick_f,'String','Individual Face Sheet Thickness (in)');
    set(handles.text_thick_c,'String','Core Thickness (in)');
    set(handles.text_em_f,'String','Elastic Modulus (psi)');
    set(handles.text_md_f,'String','Mass Density (lbm/in^3)');
    set(handles.text_shear_modulus,'String','Shear Modulus (psi)');
    set(handles.text_md_c,'String','Mass Density (lbm/in^3)'); 
    set(handles.mass_text,'String','lbm');    
 
else
    
    set(handles.text_thick_f,'String','Individual Face Sheet Thickness (mm)');
    set(handles.text_thick_c,'String','Core Thickness (mm)');
    set(handles.text_em_f,'String','Elastic Modulus (GPa)');
    set(handles.text_md_f,'String','Mass Density (kg/m^3)');
    set(handles.text_shear_modulus,'String','Shear Modulus (MPa)');
    set(handles.text_md_c,'String','Mass Density (kg/m^3)');     
    set(handles.mass_text,'String','kg');   
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
    
if(iu==1)
    set(handles.text_OD,'String','Outer Diameter (in)');   
    set(handles.text_ID,'String','Inner Diameter (in)');      
else
    set(handles.text_OD,'String','Outer Diameter (m)');     
    set(handles.text_ID,'String','Inner Diameter (m)');     
end




% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    A = imread('Honeycomb_sandwich_md.jpg');
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



function edit_OD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_OD as text
%        str2double(get(hObject,'String')) returns contents of edit_OD as a double


% --- Executes during object creation, after setting all properties.
function edit_OD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ID_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ID as text
%        str2double(get(hObject,'String')) returns contents of edit_ID as a double


% --- Executes during object creation, after setting all properties.
function edit_ID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_dlf.
function pushbutton_dlf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dlf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('sandwich_lf.jpg');
figure(995) 
imshow(A,'border','tight','InitialMagnification',100)       


% --- Executes on selection change in listbox_dlf.
function listbox_dlf_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dlf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dlf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dlf

nd=get(handles.listbox_dlf,'Value'); 

set(handles.text_ulf1,'Visible','on');
set(handles.text_ulf2,'Visible','on');
set(handles.edit_ulf,'Visible','on'); 

if(nd~=3)
    set(handles.text_ulf1,'Visible','off');    
    set(handles.text_ulf2,'Visible','off');
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



function NSM_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NSM_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NSM_edit as text
%        str2double(get(hObject,'String')) returns contents of NSM_edit as a double


% --- Executes during object creation, after setting all properties.
function NSM_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NSM_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_re.
function pushbutton_re_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_re (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure(999);
A = imread('re_honeycomb_sandwich_panel.jpg');  
imshow(A,'border','tight','InitialMagnification',100); 
