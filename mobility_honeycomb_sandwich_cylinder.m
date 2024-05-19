function varargout = mobility_honeycomb_sandwich_cylinder(varargin)
% MOBILITY_HONEYCOMB_SANDWICH_CYLINDER MATLAB code for mobility_honeycomb_sandwich_cylinder.fig
%      MOBILITY_HONEYCOMB_SANDWICH_CYLINDER, by itself, creates a new MOBILITY_HONEYCOMB_SANDWICH_CYLINDER or raises the existing
%      singleton*.
%
%      H = MOBILITY_HONEYCOMB_SANDWICH_CYLINDER returns the handle to a new MOBILITY_HONEYCOMB_SANDWICH_CYLINDER or the handle to
%      the existing singleton*.
%
%      MOBILITY_HONEYCOMB_SANDWICH_CYLINDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOBILITY_HONEYCOMB_SANDWICH_CYLINDER.M with the given input arguments.
%
%      MOBILITY_HONEYCOMB_SANDWICH_CYLINDER('Property','Value',...) creates a new MOBILITY_HONEYCOMB_SANDWICH_CYLINDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mobility_honeycomb_sandwich_cylinder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mobility_honeycomb_sandwich_cylinder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mobility_honeycomb_sandwich_cylinder

% Last Modified by GUIDE v2.5 27-Jan-2016 11:54:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mobility_honeycomb_sandwich_cylinder_OpeningFcn, ...
                   'gui_OutputFcn',  @mobility_honeycomb_sandwich_cylinder_OutputFcn, ...
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


% --- Executes just before mobility_honeycomb_sandwich_cylinder is made visible.
function mobility_honeycomb_sandwich_cylinder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mobility_honeycomb_sandwich_cylinder (see VARARGIN)

% Choose default command line output for mobility_honeycomb_sandwich_cylinder
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mobility_honeycomb_sandwich_cylinder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mobility_honeycomb_sandwich_cylinder_OutputFcn(hObject, eventdata, handles) 
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

delete(mobility_honeycomb_sandwich_cylinder);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

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

Ap=pi*diam*L;

if(iu==1)
   rhoc=rhoc/386;
   rhof=rhof/386;
else
   [E]=GPa_to_Pa(E);
   [G]=GPa_to_Pa(G);
   tf=tf/1000;
   hc=hc/1000;
end

[~,fc,~,NL,fmin,fmax]=SEA_one_third_octave_frequencies_max_min();

mph=zeros(NL,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[D,K,S,mpa,fring]=honeycomb_sandwich_properties_wave(E,G,mu,tf,hc,diam,rhof,rhoc);

mass=mpa*L*pi*diam;

[f1,f2]=shear_frequencies(E,G,mu,tf,hc,rhof,rhoc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mmax=160;
nmax=160;

v=mu;
               
[ffb,~,~,kv,~]=sandwich_cylinder_engine(D,K,v,diam,L,mpa,bc,mmax,nmax);         
         
imax=NL;


nun=zeros([1 imax]);
for j=1:imax
    for i=1:(kv-1)
        if(ffb(i)>=fl(j) && ffb(i) < fu(j))
           nun(j)=nun(j)+1;    
 
        end
        if(ffb(i)>fu(j))
            break;
        end
    end    
end
%
for j=1:imax 
    nun(j)=nun(j)/(fu(j)-fl(j));         
end
%
fc=fix_size(fc);
nun=fix_size(nun);

wmd=[fc nun];
wmd=sortrows(wmd,1);               

%%%%%%%%%%%

fchange=max([fring f1]);

Y=zeros(NL,1);
Z=zeros(NL,1);

for i=1:NL
    
    omega=tpi*fc(i);
    
    if(fc(i)< fring)
     
        mph(i)=wmd(i,2);        
        
    else    
           
        [mdens]=Renji_modal_density(omega,Ap,S,D,mpa);
 
         mph(i)=mdens;                   

    end    
    
    Y(i)=mph(i)/(4*mass);
    
    if(Y(i)>1.0e-90)
        Z(i)=1/Y(i);
    end    
    
end

%%%%%%%%%%%

modal_density=[fc mph];
Y=[fc Y];
Z=[fc Z];

kk=0;

for i=1:NL
    if(modal_density(i,2)<1.0e-04)
        kk=i;
    end
end 


if(kk==0)
    ppp=modal_density;
    yyy=Y;
    zzz=Z;
else
    ppp(kk:NL,:)=modal_density(kk:NL,:);
    yyy(kk:NL,:)=Y(kk:NL,:);
    zzz(kk:NL,:)=Z(kk:NL,:);    
end

%%%%

if(iu==1)
   YU='(in/sec)/lbf'; 
   ZU='(lbf-sec)/in'; 
else
   YU='(m/sec)/N'; 
   ZU='(N-sec)/m';     
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    disp(' ');
    disp('  Honeycomb Sandwich Cylindrical Shell');
    disp('  ');
    disp('  Center     Modal                           ');
    disp('   Freq     Density     Mobility        Impedance ');
    
    out1=sprintf('    (Hz)  (modes/Hz)  [%s]   [%s]  ',YU,ZU);
    disp(out1);
    
    
    for i=1:NL
        if(Z(i,2)>1.0e-90)
            out1=sprintf('    %6.1f   %7.2e    %7.2e      %7.2e',fc(i),mph(i),Y(i,2),Z(i,2));
        else
            out1=sprintf('    %6.1f   %7.2e    %7.2e       - ',fc(i),mph(i),Y(i,2));            
        end
        disp(out1);
    end
    

    disp(' ');
    out1=sprintf(' Ring Frequency = %8.4g Hz ',fring);
    disp(out1);

    display_shear_frequencies(f1,f2);

    if(iu==1)
        out1=sprintf('\n mass/area = %8.4g lbm/in^2',mpa*386);
    else
        out1=sprintf('\n mass/area = %8.4g kg/m^2',mpa);   
    end
    disp(out1);    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

t_string='Honeycomb Sandwich Cylinder';
            
x_label='Frequency (Hz)';
y_label='Modal Density (modes/Hz)';

md=3;
 
fig_num=1;
x_label='Frequency (Hz) ';

[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%

    mobility=[fc Y];
    impedance=[fc Z];
    

    t_string='Mechanical Impedance';
    y_label=sprintf(' Z [%s] ',ZU);
    md=3;
    
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,zzz,fmin,fmax,md);
    
    t_string='Mobility';
    y_label=sprintf(' Y [%s] ',YU);    
  
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,yyy,fmin,fmax,md);

%%%%
    
    assignin('base', 'modal_density', modal_density);    
    assignin('base', 'mobility', Y);     
    assignin('base', 'impedance', Z);   

    disp(' ');
    disp(' Output arrays ');
    disp(' ');
    disp('    modal_density ');
    disp('    mobility ');
    disp('    impedance ');    
  
    
msgbox('Results written to command window');



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
    
else
    
    set(handles.text_L,'String','Length (m)');

    set(handles.text_thick_f,'String','Individual Face Sheet Thickness (mm)');
    set(handles.text_thick_c,'String','Core Thickness (mm)');
    set(handles.text_em_f,'String','Elastic Modulus (GPa)');
    set(handles.text_md_f,'String','Mass Density (kg/m^3)');
    set(handles.text_shear_modulus,'String','Shear Modulus (MPa)');
    set(handles.text_md_c,'String','Mass Density (kg/m^3)');     
    set(handles.text_diam,'String','Diameter (m)');    
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

    A = imread('modal_density_sandwich_cylinder.jpg');
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


% --- Executes on button press in pushbutton_mobility.
function pushbutton_mobility_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mobility (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    A = imread('mi_general.jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100)
