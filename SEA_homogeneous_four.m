function varargout = SEA_homogeneous_four(varargin)
% SEA_HOMOGENEOUS_FOUR MATLAB code for SEA_homogeneous_four.fig
%      SEA_HOMOGENEOUS_FOUR, by itself, creates a new SEA_HOMOGENEOUS_FOUR or raises the existing
%      singleton*.
%
%      H = SEA_HOMOGENEOUS_FOUR returns the handle to a new SEA_HOMOGENEOUS_FOUR or the handle to
%      the existing singleton*.
%
%      SEA_HOMOGENEOUS_FOUR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_HOMOGENEOUS_FOUR.M with the given input arguments.
%
%      SEA_HOMOGENEOUS_FOUR('Property','Value',...) creates a new SEA_HOMOGENEOUS_FOUR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_homogeneous_four_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_homogeneous_four_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_homogeneous_four

% Last Modified by GUIDE v2.5 05-Nov-2021 16:52:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_homogeneous_four_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_homogeneous_four_OutputFcn, ...
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


% --- Executes just before SEA_homogeneous_four is made visible.
function SEA_homogeneous_four_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_homogeneous_four (see VARARGIN)

% Choose default command line output for SEA_homogeneous_four
handles.output = hObject;

%%

for i=1:4
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
catch    
end 

%%%%%%

try
    E=getappdata(0,'E_orig');
    for i=1:4
        if(~isempty(E(i)))
            data_s{2,i+1}=sprintf('%g',E(i));
        end
    end
catch    
end 

%%%%%%

try
    rhof=getappdata(0,'rhof_orig');
    for i=1:4
        if(~isempty(rhof(i)))
            data_s{3,i+1}=sprintf('%g',rhof(i));
        end
    end
catch    
end 

%%%%%%

try
    mu=getappdata(0,'mu_orig');
    for i=1:4
        if(~isempty(mu(i)))
            data_s{4,i+1}=sprintf('%g',mu(i));
        end
    end
catch    
end 

%%%%%%

set(handles.uitable_data,'Data',data_s);

%%


change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_homogeneous_four wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_homogeneous_four_OutputFcn(hObject, eventdata, handles) 
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
    data_s{1,1} = 'Thickness (in)';  
    data_s{2,1} = 'Elastic Modulus (psi)'; 
    data_s{3,1} = 'Mass Density (lbm/in^3)'; 
    data_s{4,1} = 'Poisson Ratio'; 
else
    data_s{1,1} = 'Thickness (mm)';  
    data_s{2,1} = 'Elastic Modulus (GPa)'; 
    data_s{3,1} = 'Mass Density (kg/m^3)'; 
    data_s{4,1} = 'Poisson Ratio';     
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

tf=zeros(4,1);
E=zeros(4,1);
rhof=zeros(4,1);
mu=zeros(4,1);

try    
    for i=1:4
        tf(i)=str2num(char(AA{1,i+1}));      
    end     
catch
    warndlg('Enter Thickness');
    return; 
end
    
try
    for i=1:4
        E(i)=str2num(char(AA{2,i+1}));      
    end 
catch
    warndlg('Enter Elastic Modulus');
    return; 
end

try
    for i=1:4
        rhof(i)=str2num(char(AA{3,i+1}));      
    end   
catch
    warndlg('Enter Mass Density');
    return;     
end    
    
try
    for i=1:4
        mu(i)=str2num(char(AA{4,i+1}));      
    end 
catch
    warndlg('Enter Poisson Ratio');
    return;     
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'imat_orig',imat);
 
setappdata(0,'E_orig',E);
setappdata(0,'mu_orig',mu);
setappdata(0,'tf_orig',tf);
setappdata(0,'rhof_orig',rhof);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)  % convert English to metric
    
   rhof=rhof*kgpm3_per_lbmpin3;
   
   tf=tf*meters_per_inch;
   
   E=E*Pa_per_psi;
     
else
   [E]=GPa_to_Pa(E);
   [G]=GPa_to_Pa(G);
   tf=tf/1000;
end

%%%
 
setappdata(0,'E',E);
setappdata(0,'mu',mu);
setappdata(0,'tf',tf);
setappdata(0,'rhof',rhof);

delete(SEA_homogeneous_four);


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
