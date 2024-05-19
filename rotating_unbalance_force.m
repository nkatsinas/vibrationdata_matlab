function varargout = rotating_unbalance_force(varargin)
% ROTATING_UNBALANCE_FORCE MATLAB code for rotating_unbalance_force.fig
%      ROTATING_UNBALANCE_FORCE, by itself, creates a new ROTATING_UNBALANCE_FORCE or raises the existing
%      singleton*.
%
%      H = ROTATING_UNBALANCE_FORCE returns the handle to a new ROTATING_UNBALANCE_FORCE or the handle to
%      the existing singleton*.
%
%      ROTATING_UNBALANCE_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTATING_UNBALANCE_FORCE.M with the given input arguments.
%
%      ROTATING_UNBALANCE_FORCE('Property','Value',...) creates a new ROTATING_UNBALANCE_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rotating_unbalance_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rotating_unbalance_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rotating_unbalance_force

% Last Modified by GUIDE v2.5 16-Aug-2014 15:10:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rotating_unbalance_force_OpeningFcn, ...
                   'gui_OutputFcn',  @rotating_unbalance_force_OutputFcn, ...
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


% --- Executes just before rotating_unbalance_force is made visible.
function rotating_unbalance_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rotating_unbalance_force (see VARARGIN)

% Choose default command line output for rotating_unbalance_force
handles.output = hObject;

set(handles.listbox_analysis,'Value',1);
set(handles.listbox_force_unit,'Value',1);
set(handles.listbox_eccentric_mass_unit,'Value',1);
set(handles.listbox_eccentricity,'Value',1);
set(handles.listbox_frequency,'Value',1);

set(handles.pushbutton_calculate_sdof_response,'Enable','off');

clear_results(hObject, eventdata, handles); 

listbox_analysis_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rotating_unbalance_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles) 
%
set(handles.edit_results,'Visible','off');
set(handles.edit_results,'String',' ');


% --- Outputs from this function are returned to the command line.
function varargout = rotating_unbalance_force_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

set(handles.edit_results,'Visible','on');

n_analysis=get(handles.listbox_analysis,'Value');

%%%

N_per_lbf=4.448;
lbf_per_N=1/N_per_lbf;


if(n_analysis~=1)
    force=str2num(get(handles.edit_force,'String'));
    n_force_unit=get(handles.listbox_force_unit,'Value');
%
    if(n_force_unit==1)
        F=force*N_per_lbf;
    else
        F=force;
    end
%
end

kg_per_oz=0.0283495;
oz_per_kg=1/kg_per_oz;


if(n_analysis~=2)
    mass=str2num(get(handles.edit_eccentric_mass,'String'));
    n_eccentric_mass_unit=get(handles.listbox_eccentric_mass_unit,'Value');    
%
    if(n_eccentric_mass_unit==1)  % oz
       m=mass*kg_per_oz;
    else  % g
       m=mass/1000;
    end
%
end

mils_per_meter=39.3701*1000;
meters_per_mil=1/mils_per_meter;

if(n_analysis~=3)
    r=str2num(get(handles.edit_eccentricity,'String'));
    n_eccentricty_unit=get(handles.listbox_eccentricity,'Value');    
%
    if(n_eccentricty_unit==1)  % mils
       e=r*meters_per_mil;
    else  % mm
       e=r/1000; 
    end
%
end

if(n_analysis~=4)
    f=str2num(get(handles.edit_frequency,'String'));
    n_frequency_unit=get(handles.listbox_frequency,'Value');    
%
    if(n_frequency_unit==1) % RPM
        omega=tpi*f/60'
    end
    if(n_frequency_unit==2) % Hz
        omega=tpi*f;
    end
    if(n_frequency_unit==3) % rad/sec
        omega=f;
    end    
%
end

%%%

set(handles.edit_results,'Max',6);

if(n_analysis==1) % calculate force
   F=m*e*omega^2;
   lbf=F*lbf_per_N;
   N=F;
   s1=sprintf(' %8.4g lbf \n %8.4g N ',lbf,N);       
end
if(n_analysis==2) % calculate eccentric mass
   m = F / (e*omega^2);
   grams=m*1000;
   oz=m*oz_per_kg; 
   s1=sprintf(' %8.4g oz \n %8.4g grams ',oz,grams);      
end
if(n_analysis==3) % calculate eccentricity
   e = F / (m*omega^2); 
   mm=e*1000;
   mils=e*mils_per_meter;
   s1=sprintf(' %8.4g mils \n %8.4g mm ',mils,mm);   
end
if(n_analysis==4) % calculate frequency
   omega=sqrt(F/(m*e));
   Hz=omega/tpi;
   rpm=Hz*60;
   s1=sprintf(' %8.4g RPM \n %8.4g Hz \n %8.4g rad/sec',rpm,Hz,omega);
end

if(n_analysis==1)
    setappdata(0,'force_lbf',lbf);
    setappdata(0,'force_N',N);      
else
    N=F;
    lbf=N*lbf_per_N;
    setappdata(0,'force_lbf',lbf);
    setappdata(0,'force_N',N);        
end

set(handles.edit_results,'String',s1);

set(handles.pushbutton_calculate_sdof_response,'Enable','on');


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis

clear_results(hObject, eventdata, handles); 

n=get(handles.listbox_analysis,'Value');

if(n==1)
    set(handles.edit_force,'Visible','off');
    set(handles.listbox_force_unit,'Visible','off');
    set(handles.uipanel_enter_force,'Visible','off');
    set(handles.pushbutton_calculate,'String','Calculate Force');
else
    set(handles.edit_force,'Visible','on');
    set(handles.listbox_force_unit,'Visible','on');
    set(handles.uipanel_enter_force,'Visible','on');    
end

if(n==2)
    set(handles.uipanel_eccentric_mass,'Visible','off');
    set(handles.edit_eccentric_mass,'Visible','off');
    set(handles.listbox_eccentric_mass_unit,'Visible','off'); 
    set(handles.pushbutton_calculate,'String','Calculate Eccentric Mass');    
else
    set(handles.uipanel_eccentric_mass,'Visible','on');
    set(handles.edit_eccentric_mass,'Visible','on');
    set(handles.listbox_eccentric_mass_unit,'Visible','on');    
end

if(n==3)
    set(handles.uipanel_eccentricity,'Visible','off');
    set(handles.edit_eccentricity,'Visible','off');
    set(handles.listbox_eccentricity,'Visible','off');
    set(handles.pushbutton_calculate,'String','Calculate Eccentricity');    
else
    set(handles.uipanel_eccentricity,'Visible','on');
    set(handles.edit_eccentricity,'Visible','on');
    set(handles.listbox_eccentricity,'Visible','on');    
end

if(n==4)
    set(handles.uipanel_frequency,'Visible','off');
    set(handles.edit_frequency,'Visible','off');
    set(handles.listbox_frequency,'Visible','off');
    set(handles.pushbutton_calculate,'String','Calculate Frequency');    
else
    set(handles.uipanel_frequency,'Visible','on');
    set(handles.edit_frequency,'Visible','on');
    set(handles.listbox_frequency,'Visible','on');    
end



% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_force_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force as text
%        str2double(get(hObject,'String')) returns contents of edit_force as a double


% --- Executes during object creation, after setting all properties.
function edit_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_force and none of its controls.
function edit_force_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_force (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles); 

% --- Executes on selection change in listbox_force_unit.
function listbox_force_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_unit
clear_results(hObject, eventdata, handles); 

% --- Executes during object creation, after setting all properties.
function listbox_force_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_eccentric_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eccentric_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eccentric_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_eccentric_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_eccentric_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eccentric_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_eccentric_mass_unit.
function listbox_eccentric_mass_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_eccentric_mass_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_eccentric_mass_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_eccentric_mass_unit
clear_results(hObject, eventdata, handles); 

% --- Executes during object creation, after setting all properties.
function listbox_eccentric_mass_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_eccentric_mass_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_eccentric_mass and none of its controls.
function edit_eccentric_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_eccentric_mass (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles); 



function edit_eccentricity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eccentricity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eccentricity as text
%        str2double(get(hObject,'String')) returns contents of edit_eccentricity as a double


% --- Executes during object creation, after setting all properties.
function edit_eccentricity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eccentricity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_eccentricity and none of its controls.
function edit_eccentricity_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_eccentricity (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles); 

% --- Executes on selection change in listbox_eccentricity.
function listbox_eccentricity_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_eccentricity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles); 

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_eccentricity contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_eccentricity


% --- Executes during object creation, after setting all properties.
function listbox_eccentricity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_eccentricity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency.
function listbox_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency
clear_results(hObject, eventdata, handles); 

% --- Executes during object creation, after setting all properties.
function listbox_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_frequency and none of its controls.
function edit_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles); 


% --- Executes on button press in pushbutton_calculate_sdof_response.
function pushbutton_calculate_sdof_response_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate_sdof_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=SDOF_response_unbalance;    

set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(rotating_unbalance_force);
