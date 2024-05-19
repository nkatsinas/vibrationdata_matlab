function varargout = SEA_honeycomb_sandwich(varargin)
% SEA_HONEYCOMB_SANDWICH MATLAB code for SEA_honeycomb_sandwich.fig
%      SEA_HONEYCOMB_SANDWICH, by itself, creates a new SEA_HONEYCOMB_SANDWICH or raises the existing
%      singleton*.
%
%      H = SEA_HONEYCOMB_SANDWICH returns the handle to a new SEA_HONEYCOMB_SANDWICH or the handle to
%      the existing singleton*.
%
%      SEA_HONEYCOMB_SANDWICH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_HONEYCOMB_SANDWICH.M with the given input arguments.
%
%      SEA_HONEYCOMB_SANDWICH('Property','Value',...) creates a new SEA_HONEYCOMB_SANDWICH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_honeycomb_sandwich_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_honeycomb_sandwich_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_honeycomb_sandwich

% Last Modified by GUIDE v2.5 01-Dec-2017 13:09:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_honeycomb_sandwich_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_honeycomb_sandwich_OutputFcn, ...
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


% --- Executes just before SEA_honeycomb_sandwich is made visible.
function SEA_honeycomb_sandwich_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_honeycomb_sandwich (see VARARGIN)

% Choose default command line output for SEA_honeycomb_sandwich
handles.output = hObject;




try
    imat=getappdata(0,'imat_orig');
    if(isempty(imat))
    else
        set(handles.listbox_material,'Value',imat);
    end
catch
end


try
    E=getappdata(0,'E_orig');
    if(isempty(E))
    else
        ss=sprintf('%8.4g',E);
        set(handles.edit_em,'String',ss);
    end
catch
end    

try
    mu=getappdata(0,'mu_orig');
    if(isempty(mu))
    else
        ss=sprintf('%8.4g',mu);        
        set(handles.edit_mu,'String',ss);        
    end    
catch
end

try
    G=getappdata(0,'G_orig');
    if(isempty(G))
    else
        ss=sprintf('%8.4g',G);        
        set(handles.edit_shear_modulus,'String',ss);        
    end    
catch
end

try
    rhoc=getappdata(0,'rhoc_orig');
    if(isempty(rhoc))
    else
        ss=sprintf('%8.4g',rhoc);
        set(handles.edit_md_c,'String',ss);       
    end    
catch
end

try
    hc=getappdata(0,'hc_orig');
    if(isempty(hc))
    else
        ss=sprintf('%8.4g',hc);        
        set(handles.edit_thick_c,'String',ss);       
    end    
catch
end

try
    tf=getappdata(0,'tf_orig');
    if(isempty(tf))
    else
        ss=sprintf('%8.4g',tf);        
        set(handles.edit_thick_f,'String',ss);        
    end    
catch
end

try
    rhof=getappdata(0,'rhof_orig');
    if(isempty(rhof))
    else
        ss=sprintf('%8.4g',rhof);        
        set(handles.edit_md_f,'String',ss);        
    end    
catch
end

change(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_honeycomb_sandwich wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)

iu=getappdata(0,'iu');

imat=get(handles.listbox_material,'Value');


%

%%%%%%%%%%%%%   

if(iu==1)
  
    set(handles.text_thick_f,'String','Individual Face Sheet Thickness (in)');
    set(handles.text_thick_c,'String','Core Thickness (in)');
    set(handles.text_em_f,'String','Elastic Modulus (psi)');
    set(handles.text_md_f,'String','Mass Density (lbm/in^3)');
    set(handles.text_shear_modulus,'String','Shear Modulus (psi)');
    set(handles.text_md_c,'String','Mass Density (lbm/in^3)'); 
    
    
    
else
     
    set(handles.text_thick_f,'String','Individual Face Sheet Thickness (mm)');
    set(handles.text_thick_c,'String','Core Thickness (mm)');
    set(handles.text_em_f,'String','Elastic Modulus (GPa)');
    set(handles.text_md_f,'String','Mass Density (kg/m^3)');
    set(handles.text_shear_modulus,'String','Shear Modulus (MPa)');
    set(handles.text_md_c,'String','Mass Density (kg/m^3)');     
      
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


% --- Outputs from this function are returned to the command line.
function varargout = SEA_honeycomb_sandwich_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in pushbutton_enter.
function pushbutton_enter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

meters_per_inch=0.0254;
Pa_per_psi = 6894.;
kgpm3_per_lbmpft3=16.016;
kgpm3_per_lbmpin3=27675;

imat=get(handles.listbox_material,'Value');

iu=getappdata(0,'iu');

E=str2num(get(handles.edit_em,'String'));
mu=str2num(get(handles.edit_mu,'String'));
G=str2num(get(handles.edit_shear_modulus,'String'));

rhoc=str2num(get(handles.edit_md_c,'String'));
hc=str2num(get(handles.edit_thick_c,'String'));

tf=str2num(get(handles.edit_thick_f,'String'));
rhof=str2num(get(handles.edit_md_f,'String'));

%%

setappdata(0,'imat_orig',imat);

setappdata(0,'E_orig',E);
setappdata(0,'mu_orig',mu);
setappdata(0,'G_orig',G);

setappdata(0,'rhoc_orig',rhoc);
setappdata(0,'hc_orig',hc);

setappdata(0,'tf_orig',tf);
setappdata(0,'rhof_orig',rhof);


%%

if(iu==1)  % convert English to metric
    
   rhoc=rhoc*kgpm3_per_lbmpin3;
   rhof=rhof*kgpm3_per_lbmpin3;
   
   tf=tf*meters_per_inch;
   hc=hc*meters_per_inch;
   
   E=E*Pa_per_psi;
   G=G*Pa_per_psi;
   
else
   [E]=GPa_to_Pa(E);
   [G]=GPa_to_Pa(G);
   tf=tf/1000;
   hc=hc/1000;
end

%%

setappdata(0,'E',E);
setappdata(0,'mu',mu);
setappdata(0,'G',G);

setappdata(0,'rhoc',rhoc);
setappdata(0,'hc',hc);

setappdata(0,'tf',tf);
setappdata(0,'rhof',rhof);

setappdata(0,'imat_orig',imat);

delete(SEA_honeycomb_sandwich);





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
