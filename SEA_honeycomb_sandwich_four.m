function varargout = SEA_honeycomb_sandwich_four(varargin)
% SEA_HONEYCOMB_SANDWICH_FOUR MATLAB code for SEA_honeycomb_sandwich_four.fig
%      SEA_HONEYCOMB_SANDWICH_FOUR, by itself, creates a new SEA_HONEYCOMB_SANDWICH_FOUR or raises the existing
%      singleton*.
%
%      H = SEA_HONEYCOMB_SANDWICH_FOUR returns the handle to a new SEA_HONEYCOMB_SANDWICH_FOUR or the handle to
%      the existing singleton*.
%
%      SEA_HONEYCOMB_SANDWICH_FOUR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_HONEYCOMB_SANDWICH_FOUR.M with the given input arguments.
%
%      SEA_HONEYCOMB_SANDWICH_FOUR('Property','Value',...) creates a new SEA_HONEYCOMB_SANDWICH_FOUR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_honeycomb_sandwich_four_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_honeycomb_sandwich_four_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_honeycomb_sandwich_four

% Last Modified by GUIDE v2.5 01-May-2018 15:13:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_honeycomb_sandwich_four_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_honeycomb_sandwich_four_OutputFcn, ...
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


% --- Executes just before SEA_honeycomb_sandwich_four is made visible.
function SEA_honeycomb_sandwich_four_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_honeycomb_sandwich_four (see VARARGIN)

% Choose default command line output for SEA_honeycomb_sandwich_four
handles.output = hObject;

%%

for i=1:7
    for j=1:5
        data_s{i,j}='';
    end
end



%%%%%%

try
    imat=getappdata(0,'imat_orig');
    if(~isempty(imat(1)))
        set(handles.listbox_material_1,'Value',imat(1));
    end
    if(~isempty(imat(2)))
        set(handles.listbox_material_2,'Value',imat(2));
    end    
    if(~isempty(imat(3)))
        set(handles.listbox_material_3,'Value',imat(3));
    end  
    if(~isempty(imat(4)))
        set(handles.listbox_material_4,'Value',imat(4));
    end      
catch
end

%%%%%%

try
    tf=getappdata(0,'tf_orig');
    for i=1:4
        if(~isempty(tf(i)))
            data_s{1,i+1}=sprintf('%g',tf(i));
        end
    end
end 

%%%%%%

try
    E=getappdata(0,'E_orig');
    for i=1:4
        if(~isempty(E(i)))
            data_s{2,i+1}=sprintf('%g',E(i));
        end
    end  
end 

%%%%%%

try
    rhof=getappdata(0,'rhof_orig');
    for i=1:4
        if(~isempty(rhof(i)))
            data_s{3,i+1}=sprintf('%g',rhof(i));
        end
    end 
end 

%%%%%%

try
    mu=getappdata(0,'mu_orig');
    for i=1:4
        if(~isempty(mu(i)))
            data_s{4,i+1}=sprintf('%g',mu(i));
        end
    end   
end 

%%%%%%

try
    G=getappdata(0,'G_orig');
    for i=1:4
        if(~isempty(G(i)))
            data_s{5,i+1}=sprintf('%g',G(i));
        end
    end   
end 

%%%%%%

try
    rhoc=getappdata(0,'rhoc_orig');
    for i=1:4
        if(~isempty(rhoc(i)))
            data_s{6,i+1}=sprintf('%g',rhoc(i));
        end
    end 
end 

%%%%%%

try
    hc=getappdata(0,'hc_orig');
    for i=1:4
        if(~isempty(hc(i)))
            data_s{7,i+1}=sprintf('%g',hc(i));
        end
    end     
end 

%%%%%%

try
    smd=getappdata(0,'smd_orig');
    if(~isempty(smd(1)))
        data_s{8,2}=sprintf('%g',smd(1));
    end
    if(~isempty(smd(2)))
        data_s{8,3}=sprintf('%g',smd(2));
    end    
    if(~isempty(smd(3)))
        data_s{8,4}=sprintf('%g',smd(3));
    end 
    if(~isempty(smd(4)))
        data_s{8,5}=sprintf('%g',smd(4));
    end     
end 

%%%%%%

set(handles.uitable_data,'Data',data_s);

%%


change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_honeycomb_sandwich_four wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_honeycomb_sandwich_four_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function change(hObject, eventdata, handles)
%

iu=getappdata(0,'iu');


data_s=get(handles.uitable_data,'Data');


if(iu==1)
    data_s{1,1} = 'Face Sheet: Individual Thickness (in)';  
    data_s{2,1} = 'Face Sheet: Elastic Modulus (psi)'; 
    data_s{3,1} = 'Face Sheet: Mass Density (lbm/in^3)'; 
    data_s{4,1} = 'Face Sheet: Poisson Ratio'; 
    data_s{5,1} = 'Core: Shear Modulus (psi)'; 
    data_s{6,1} = 'Core: Mass Density (lbm/in^3)'; 
    data_s{7,1} = 'Core: Thickness (in)';    
    data_s{8,1} = 'Total Surface Mass Density (lbm/in^2)';       
else
    data_s{1,1} = 'Face Sheet: Individual Thickness (mm)';  
    data_s{2,1} = 'Face Sheet: Elastic Modulus (GPa)'; 
    data_s{3,1} = 'Face Sheet: Mass Density (kg/m^3)'; 
    data_s{4,1} = 'Face Sheet: Poisson Ratio'; 
    data_s{5,1} = 'Core: Shear Modulus (MPa)'; 
    data_s{6,1} = 'Core: Mass Density (kg/m^3)'; 
    data_s{7,1} = 'Core: Thickness (mm)';  
    data_s{8,1} = 'Total Surface Mass Density (kg/m^2)';     
end

%%

imat_1=get(handles.listbox_material_1,'Value');
imat_2=get(handles.listbox_material_2,'Value');
imat_3=get(handles.listbox_material_3,'Value');
imat_4=get(handles.listbox_material_4,'Value');

%%

[elastic_modulus_1,mass_density_1,poisson_1]=six_materials(iu,imat_1);
[elastic_modulus_2,mass_density_2,poisson_2]=six_materials(iu,imat_2);
[elastic_modulus_3,mass_density_3,poisson_3]=six_materials(iu,imat_3);
[elastic_modulus_4,mass_density_4,poisson_4]=six_materials(iu,imat_4);

%%

if(imat_1<=6)
    data_s{2,2} =sprintf('%g',elastic_modulus_1);
    data_s{3,2} =sprintf('%g',mass_density_1); 
    data_s{4,2} =sprintf('%g',poisson_1);      
end

if(imat_2<=6)
    data_s{2,3} =sprintf('%g',elastic_modulus_2);
    data_s{3,3} =sprintf('%g',mass_density_2); 
    data_s{4,3} =sprintf('%g',poisson_2);      
end

if(imat_3<=6)
    data_s{2,4} =sprintf('%g',elastic_modulus_3);
    data_s{3,4} =sprintf('%g',mass_density_3); 
    data_s{4,4} =sprintf('%g',poisson_3);      
end

if(imat_4<=6)
    data_s{2,5} =sprintf('%g',elastic_modulus_4);
    data_s{3,5} =sprintf('%g',mass_density_4); 
    data_s{4,5} =sprintf('%g',poisson_4);      
end


set(handles.uitable_data,'Data',data_s);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=getappdata(0,'iu');

[meters_per_inch,Pa_per_psi,kgpm3_per_lbmpft3,kgpm3_per_lbmpin3,...
                                    kgpm2_per_lbmpft2,kgpm2_per_lbmpin2,...
                                                             kg_per_lbm]...
                                                   =mass_unit_conversion();


imat(1)=get(handles.listbox_material_1,'Value');
imat(2)=get(handles.listbox_material_2,'Value');
imat(3)=get(handles.listbox_material_3,'Value');
imat(4)=get(handles.listbox_material_4,'Value');

%%%

AA=get(handles.uitable_data,'Data');

try    
    for i=1:4
        tf(i)=str2num(char(AA{1,i+1}));      
    end     
catch
    warndlg('Enter Face Sheet Thickness');
    return; 
end
    
try
    for i=1:4
        E(i)=str2num(char(AA{2,i+1}));      
    end 
catch
    warndlg('Enter Face Sheet Elastic Modulus');
    return; 
end


try
    for i=1:4
        rhof(i)=str2num(char(AA{3,i+1}));      
    end   
catch
    warndlg('Enter Face Sheet Mass Density');
    return;     
end    
    
try
    for i=1:4
        mu(i)=str2num(char(AA{4,i+1}));      
    end 
catch
    warndlg('Enter Face Sheet Poisson Ratio');
    return;     
end  

try
    for i=1:4
        G(i)=str2num(char(AA{5,i+1}));      
    end 
catch
    warndlg('Enter Core Shear Modulus');
    return;     
end  

try
    for i=1:4
        rhoc(i)=str2num(char(AA{6,i+1}));      
    end 
catch
    warndlg('Enter Core Mass Density');
    return;     
end  


try
    for i=1:4
        hc(i)=str2num(char(AA{7,i+1}));      
    end 
catch
    warndlg('Enter Core Thickness');
    return;     
end  


try
    smd(1)=str2num(char(AA{8,2}));   
    smd(2)=str2num(char(AA{8,3}));
    smd(3)=str2num(char(AA{8,4}));   
    smd(4)=str2num(char(AA{8,5}));      
catch
    warndlg('Enter Total Surface Mass Density');
    return;     
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'imat_orig',imat);
 
setappdata(0,'E_orig',E);
setappdata(0,'mu_orig',mu);
setappdata(0,'G_orig',G);
 
setappdata(0,'rhoc_orig',rhoc);
setappdata(0,'hc_orig',hc);
 
setappdata(0,'tf_orig',tf);
setappdata(0,'rhof_orig',rhof);

setappdata(0,'smd_orig',smd);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)  % convert English to metric
    
   rhoc=rhoc*kgpm3_per_lbmpin3;
   rhof=rhof*kgpm3_per_lbmpin3;
   
   tf=tf*meters_per_inch;
   hc=hc*meters_per_inch;
   
   E=E*Pa_per_psi;
   G=G*Pa_per_psi;
   
   smd=smd*kgpm2_per_lbmpin2;   
   
else
   [E]=GPa_to_Pa(E);
   [G]=GPa_to_Pa(G);
   tf=tf/1000;
   hc=hc/1000;
end

%%%


 
setappdata(0,'E',E);
setappdata(0,'mu',mu);
setappdata(0,'G',G);
 
setappdata(0,'rhoc',rhoc);
setappdata(0,'hc',hc);
 
setappdata(0,'tf',tf);
setappdata(0,'rhof',rhof);

setappdata(0,'smd',smd);

delete(SEA_honeycomb_sandwich_four);


% --- Executes on selection change in listbox_material_1.
function listbox_material_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material_1
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_material_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material_2.
function listbox_material_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material_2
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_material_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material_3.
function listbox_material_3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material_3
change(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox_material_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material_4.
function listbox_material_4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material_4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material_4
change(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox_material_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
