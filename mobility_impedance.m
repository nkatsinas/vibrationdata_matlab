function varargout = mobility_impedance(varargin)
% MOBILITY_IMPEDANCE MATLAB code for mobility_impedance.fig
%      MOBILITY_IMPEDANCE, by itself, creates a new MOBILITY_IMPEDANCE or raises the existing
%      singleton*.
%
%      H = MOBILITY_IMPEDANCE returns the handle to a new MOBILITY_IMPEDANCE or the handle to
%      the existing singleton*.
%
%      MOBILITY_IMPEDANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOBILITY_IMPEDANCE.M with the given input arguments.
%
%      MOBILITY_IMPEDANCE('Property','Value',...) creates a new MOBILITY_IMPEDANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mobility_impedance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mobility_impedance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mobility_impedance

% Last Modified by GUIDE v2.5 23-Aug-2016 11:53:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mobility_impedance_OpeningFcn, ...
                   'gui_OutputFcn',  @mobility_impedance_OutputFcn, ...
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


% --- Executes just before mobility_impedance is made visible.
function mobility_impedance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mobility_impedance (see VARARGIN)

% Choose default command line output for mobility_impedance
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mobility_impedance wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mobility_impedance_OutputFcn(hObject, eventdata, handles) 
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

delete(mobility_impedance);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');
ns=get(handles.listbox_structure,'Value');

if(ns<=4)    

    E=str2num(get(handles.edit_em,'String'));
    rho=str2num(get(handles.edit_md,'String'));
    mu=str2num(get(handles.edit_mu,'String'));      
    h=str2num(get(handles.edit_thick,'String'));
        
    if(iu==1)
       rho=rho/386; 
    else
       h=h/1000;
       [E]=GPa_to_Pa(E);
    end

end    


if(ns==1 || ns==2)  % Thin Plate
       
    [B]=flexural_rigidity(E,h,mu);
    
    Z=sqrt(B*rho*h);
    
    if(ns==1) % Middle 
        Z=Z*8;
    else      % Edge
        Z=Z*3.5;
    end
    Y=1/Z;
end

if(ns==3)  % Unstiffened Cylindrical Shell
    
   d=str2num(get(handles.edit_diameter,'String')); 
   L=str2num(get(handles.edit_length,'String'));   
   
   em=E;

   [~,fc,~,NL,fmin,fmax]=SEA_one_third_octave_frequencies_max_min();   

   [fr,~,Y,Z]=cylinder_mobility(em,rho,d,L,h,fc);
end

if(ns==4)  % Longitudinal, Thin Rod
    
   A=str2num(get(handles.edit_area,'String'));
   
   if(iu==2)
      A=A/1000^2; 
   end
   
   Z=A*sqrt(E*rho);
   Y=1/Z;   
    
end

if(ns==5)  % general

    mass=str2num(get(handles.edit_mass,'String'));
    mdens=str2num(get(handles.edit_mdens,'String'));
    
    if(iu==1)
       mass=mass/386;       
    end
    
    Y=mdens/(4*mass);  
    Z=1/Y; 
end

  
if(iu==1)
   YU='(in/sec)/lbf'; 
   ZU='(lbf-sec)/in';
   ZUm='N-sec/m';
else
   YU='(m/sec)/N'; 
   ZU='(N-sec)/m';     
end

disp(' ');
disp(' * * * ');
disp(' ');
disp(' Driving Point Real Values ');
disp(' ');

if(ns~=3)  % Unstiffened Cylindrical Shell

    fprintf('  Mobility = %8.4g %s\n\n',Y,YU);
    fprintf(' Impedance = %8.4g %s \n',Z,ZU);

    if(iu==1)
        fprintf(' Impedance = %8.4g %s \n\n',Z*175.13,ZUm);
    end

else
    
    disp('    Freq       Mobility       Impedance ');
    out1=sprintf('    (Hz)     [%s]   [%s]  ',YU,ZU);
    disp(out1);
    
    for i=1:NL
        out1=sprintf(' %8g     %8.4g     %8.4g ',fc(i),Y(i),Z(i));
        disp(out1);
    end
    
    disp(' ');
    out1=sprintf(' Ring Frequency = %8.4g Hz ',fr);
    disp(out1);
    
    fc=fix_size(fc);
    
    mobility=[fc Y];
    impedance=[fc Z];
    
    fig_num=1;
    x_label='Frequency (Hz) ';
    t_string='Mechanical Impedance';
    y_label=sprintf(' Z [%s] ',ZU);
    md=3;
    
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,impedance,fmin,fmax,md);
    
    t_string='Mobility';
    y_label=sprintf(' Y [%s] ',YU);    
  
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,mobility,fmin,fmax,md);

    disp(' ');
    disp(' Output Arrays:  mobility & impedance ');
    assignin('base', 'mobility', mobility);     
    assignin('base', 'impedance', impedance); 
    
end    

msgbox('Results written to command window');



% --- Executes on selection change in listbox_structure.
function listbox_structure_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_structure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_structure
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_structure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


function change(hObject, eventdata, handles)
%
iu=get(handles.listbox_units,'Value');
ns=get(handles.listbox_structure,'Value');
imat=get(handles.listbox_material,'Value');

if(iu==1)  % English
    set(handles.text_mass,'String','Mass (lbm)');        
    set(handles.text_thick,'String','Thickness (in)');    
    set(handles.text_length,'String','Length (in)');     
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)');   
    set(handles.text_diameter,'String','Diameter(in)');      
else
    set(handles.text_mass,'String','Mass (kg)');    
    set(handles.text_thick,'String','Thickness (mm)');  
    set(handles.text_length,'String','Length (in)');   
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');     
    set(handles.text_diameter,'String','Diameter (m)');       
end


set(handles.text_mass,'Visible','off');
set(handles.edit_mass,'Visible','off');
set(handles.text_mdens,'Visible','off');
set(handles.edit_mdens,'Visible','off');

set(handles.text_material,'Visible','off');
set(handles.listbox_material,'Visible','off');
set(handles.text_em,'Visible','off');
set(handles.edit_em,'Visible','off');
set(handles.text_md,'Visible','off');
set(handles.edit_md,'Visible','off');
set(handles.text_mu,'Visible','off');
set(handles.edit_mu,'Visible','off');
set(handles.text_thick,'Visible','off');   
set(handles.edit_thick,'Visible','off'); 

set(handles.text_diameter,'Visible','off');
set(handles.edit_diameter,'Visible','off');
set(handles.text_length,'Visible','off');
set(handles.edit_length,'Visible','off');

set(handles.text_area,'Visible','off');
set(handles.edit_area,'Visible','off'); 


if(ns<=4)  % Thin Plate, cylinder or rod
    set(handles.text_material,'Visible','on');
    set(handles.listbox_material,'Visible','on');
    set(handles.text_em,'Visible','on');
    set(handles.edit_em,'Visible','on');
    set(handles.text_md,'Visible','on');
    set(handles.edit_md,'Visible','on');     
end    

if(ns<=3)  % Thin Plate or cylinder
      
    set(handles.text_thick,'Visible','on');   
    set(handles.edit_thick,'Visible','on');    
    set(handles.text_mu,'Visible','on');
    set(handles.edit_mu,'Visible','on');    
end

if(ns==3) % cylinder
    set(handles.text_diameter,'Visible','on');
    set(handles.edit_diameter,'Visible','on');    
    set(handles.text_length,'Visible','on');
    set(handles.edit_length,'Visible','on');        
end

if(ns==4) % rod
    set(handles.text_area,'Visible','on');
    set(handles.edit_area,'Visible','on');   
    
    if(iu==1)
        set(handles.text_area,'String','Area (in^2)');        
    else
        set(handles.text_area,'String','Area (mm^2)');          
    end
end    

if(ns==5)  % general
    set(handles.text_mass,'Visible','on');
    set(handles.edit_mass,'Visible','on');
    
    set(handles.text_mdens,'Visible','on');
    set(handles.edit_mdens,'Visible','on');    
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



function edit_mdens_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mdens as text
%        str2double(get(hObject,'String')) returns contents of edit_mdens as a double


% --- Executes during object creation, after setting all properties.
function edit_mdens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ns=get(handles.listbox_structure,'Value');

if(ns==1 || ns==2)
    A = imread('mi_thin_plate.jpg');
    figure(996)    
end
if(ns==3)
    A = imread('mobility_cylinder.jpg');
    figure(997) 
  
end
if(ns==4)
    A = imread('mi_rod.jpg');
    figure(999)    
end    
if(ns==5)
    A = imread('mi_general.jpg');
    figure(999)  
end

imshow(A,'border','tight','InitialMagnification',100)    


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



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_area_Callback(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_area as text
%        str2double(get(hObject,'String')) returns contents of edit_area as a double


% --- Executes during object creation, after setting all properties.
function edit_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_eq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
