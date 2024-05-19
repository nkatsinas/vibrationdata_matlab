function varargout = thin_ring(varargin)
% THIN_RING MATLAB code for thin_ring.fig
%      THIN_RING, by itself, creates a new THIN_RING or raises the existing
%      singleton*.
%
%      H = THIN_RING returns the handle to a new THIN_RING or the handle to
%      the existing singleton*.
%
%      THIN_RING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THIN_RING.M with the given input arguments.
%
%      THIN_RING('Property','Value',...) creates a new THIN_RING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before thin_ring_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to thin_ring_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help thin_ring

% Last Modified by GUIDE v2.5 30-Apr-2014 14:12:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @thin_ring_OpeningFcn, ...
                   'gui_OutputFcn',  @thin_ring_OutputFcn, ...
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


% --- Executes just before thin_ring is made visible.
function thin_ring_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to thin_ring (see VARARGIN)

% Choose default command line output for thin_ring
handles.output = hObject;

set(handles.listbox_units,'Value',1);
set(handles.listbox_materials,'Value',1);

set(handles.listbox_inplane,'Value',2);
set(handles.listbox_outplane,'Value',2);

change_material_units(hObject, eventdata, handles);

change_thickness(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes thin_ring wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = thin_ring_OutputFcn(hObject, eventdata, handles) 
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

delete(thin_ring);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change_material_units(hObject, eventdata, handles);


% --- Executes on selection change in listbox_units.
function change_material_units(hObject, eventdata, handles)
%

clear_results(hObject, eventdata, handles);

n=get(handles.listbox_units,'Value');

if(n==1)
    s1='Diameter (in)';
    sem='Elastic Modulus (psi)';
    smd='Mass Density (lbm/in^3)';
    sth='Thickness (in)';  
    sh='height (in)';
   
else
    s1='Diameter (m)';
    sem='Elastic Modulus (GPa)';
    smd='Mass Density (kg/m^3)'; 
    sth='Thickness (mm)';    
    sh='height (mm)';    
end

set(handles.text_diameter,'String',s1);
set(handles.text_elastic_modulus,'String',sem);
set(handles.text_mass_density,'String',smd);
set(handles.text_thickness,'String',sth);
set(handles.text_height,'String',sh);

m=get(handles.listbox_materials,'Value');


if(n==1)  % English
    if(m==1) % aluminum
        E=1e+007;
        rho=0.1;  
    end  
    if(m==2)  % steel
        E=3e+007;
        rho= 0.28;         
    end
    if(m==3)  % copper
        E=1.6e+007;
        rho=  0.322;
    end
else                 % metric
    if(m==1)  % aluminum
        E=70;
        rho=  2700;
    end
    if(m==2)  % steel
        E=205;
        rho=  7700;        
    end
    if(m==3)   % copper
        E=110;
        rho=  8900;
    end
end


if(m==1)    % aluminum
   mu=0.33; 
end    
if(m==2)    % steel
   mu=0.3; 
end
if(m==3)    % copper
   mu=0.33; 
end    


if(m<=3)

    string_E=sprintf('%8.4g',E);
    string_rho=sprintf('%8.4g',rho);
    string_po=sprintf('%4.2f',mu);

    set(handles.edit_elastic_modulus,'String',string_E);
    set(handles.edit_mass_density,'String',string_rho);
    set(handles.edit_poisson,'String',string_po);

end


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


% --- Executes on selection change in listbox_materials.
function listbox_materials_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_materials contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_materials

change_material_units(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_materials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'String','','Enable','off');


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n_unit=get(handles.listbox_units,'Value');

n_ip=get(handles.listbox_inplane,'Value');
n_op=get(handles.listbox_outplane,'Value');


E=str2num(get(handles.edit_elastic_modulus,'String'));
rho=str2num(get(handles.edit_mass_density,'String'));
mu=str2num(get(handles.edit_poisson,'String'));
t=str2num(get(handles.edit_thickness,'String'));
h=str2num(get(handles.edit_height,'String'));

diam=str2num(get(handles.edit_diameter,'String'));

if(n_unit==1)     % English
    rho=rho/386.;
else              % metric
    [E]=GPa_to_Pa(E);
    t=t/1000;
    h=h/1000;
end

c=sqrt(E/rho);

fr=c/(pi*diam);

NL=1;
s1=sprintf('Ring Frequency = %8.4g Hz',fr);


if(n_ip==1)
 
    s2 = ' in-plane modes ';            
    s3 = '    fn(Hz)  ';
    
    s1=sprintf('%s \n\n %s \n %s ',s1,s2,s3);    
    
    NL=NL+3;
    
    A=sqrt(E*t^2/(3*rho));
    B=A/(pi*diam^2);
%
    NP=5;
    fn_in=zeros(NP,1);
 
    for n=1:NP
        num=n*(n^2-1);
        den=sqrt(n^2+1);
        fn_in(n)=(num/den)*B;
        out1=sprintf('%8.4g ',fn_in(n));    
        s1 = sprintf('%s \n %s ',s1,out1);
    end
    
    NL=NL+NP;

end

if(n_op==1)

    s2 = ' out-of-plane modes ';            
    s3 = '    fn(Hz)  ';
    
    s1=sprintf('%s \n\n %s \n %s ',s1,s2,s3);    
    
    NL=NL+3;    
    
%
    NP=5;
    
    fn_out=zeros(NP,1);

    for n=1:NP
        A=2*n*(n^2-1)*h/(pi*diam^2);
        B=rho*(12*n^2 + 6.667*( 1+ (h/t)^2 )*(1+mu));
        fn_out(n)=A*sqrt(E/B);
        out1=sprintf('%8.4g',fn_out(n));
        s1 = sprintf('%s \n %s ',s1,out1);        
    end    
    
    NL=NL+NP; 
end    


set(handles.edit_results,'Enable','on','Max',NL,'String',s1);




if(n_ip==1)
%
    B=1;
    N=1000;
    delta=2*pi/N;
    theta=0:delta:2*pi;
%
    for n=2:4
        figure(n);    
        clear V;
        clear Wa;
        clear Wb;
        clear Ra;
        clear und;
        V(1:length(theta))=0.;   
        Wa(1:length(theta))=0.;
        arg=n*theta;
%
        V=-B*sin(arg);
        R=4*n;
        Wa=R+n*cos(arg);
%    
        Ra=sqrt(V.^2+Wa.^2)/R;   
%
        alpha=theta+atan2(V,Wa);
%
        und(1:length(theta))=1;
%
        scale=1;
        Ra=Ra*scale;
        polar(alpha,Ra);
%         
        out5 = sprintf(' In-Plane Mode  n=%d  fn= %9.4g Hz',n,fn_in(n));
        title(out5);
        hold on;
        polar(theta,und,'-.');
        disp(' ')
        hold off;
    end
%
end



function edit_elastic_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_elastic_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_poisson_Callback(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poisson as text
%        str2double(get(hObject,'String')) returns contents of edit_poisson as a double


% --- Executes during object creation, after setting all properties.
function edit_poisson_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_mass_density and none of its controls.
function edit_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_poisson and none of its controls.
function edit_poisson_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_diameter and none of its controls.
function edit_diameter_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on selection change in listbox_inplane.
function listbox_inplane_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_inplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_inplane contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_inplane


change_thickness(hObject, eventdata, handles);


function change_thickness(hObject, eventdata, handles)

set(handles.edit_thickness,'Enable','off');  

nip=get(handles.listbox_inplane,'Value');
nop=get(handles.listbox_outplane,'Value');

if(nip==1 || nop==1)
   set(handles.edit_thickness,'Enable','on');    
end

if(nip==2 && nop==2)
   set(handles.edit_thickness,'Enable','off');    
   set(handles.edit_thickness,'String','');    
end

if(nop==2)
    set(handles.edit_height,'Enable','off');
    set(handles.edit_height,'String','');
else
    set(handles.edit_height,'Enable','on');
end    
    


% --- Executes during object creation, after setting all properties.
function listbox_inplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_inplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);


% --- Executes on selection change in listbox_outplane.
function listbox_outplane_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_outplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_outplane contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_outplane

change_thickness(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_outplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_outplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_height as text
%        str2double(get(hObject,'String')) returns contents of edit_height as a double


% --- Executes during object creation, after setting all properties.
function edit_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_height and none of its controls.
function edit_height_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_height (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);
