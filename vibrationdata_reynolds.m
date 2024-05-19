function varargout = vibrationdata_reynolds(varargin)
% VIBRATIONDATA_REYNOLDS MATLAB code for vibrationdata_reynolds.fig
%      VIBRATIONDATA_REYNOLDS, by itself, creates a new VIBRATIONDATA_REYNOLDS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_REYNOLDS returns the handle to a new VIBRATIONDATA_REYNOLDS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_REYNOLDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_REYNOLDS.M with the given input arguments.
%
%      VIBRATIONDATA_REYNOLDS('Property','Value',...) creates a new VIBRATIONDATA_REYNOLDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_reynolds_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_reynolds_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_reynolds

% Last Modified by GUIDE v2.5 22-Dec-2017 10:59:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_reynolds_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_reynolds_OutputFcn, ...
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


% --- Executes just before vibrationdata_reynolds is made visible.
function vibrationdata_reynolds_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_reynolds (see VARARGIN)

% Choose default command line output for vibrationdata_reynolds
handles.output = hObject;

change(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_reynolds wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_reynolds_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function change(hObject, eventdata, handles)

iu=get(handles.listbox_units,'Value');

igeo=get(handles.listbox_geometry,'Value');

ifluid=get(handles.listbox_fluid,'Value');


% set(handles.listbox_temperature,'Visible','off');
% set(handles.edit_temperature,'Visible','off');
% set(handles.text_temperature,'Visible','off');

set(handles.edit_altitude,'Visible','off');
set(handles.text_altitude,'Visible','off');

set(handles.text_diam,'Visible','off');
set(handles.edit_diam,'Visible','off');
set(handles.text_x,'Visible','off');
set(handles.edit_x,'Visible','off');


set(handles.text_kvisc,'Visible','on','Enable','on');
set(handles.edit_kvisc,'Visible','on','Enable','on');

set(handles.edit_tempC,'Visible','off');
set(handles.text_tempC,'Visible','off');

if(ifluid==1 || ifluid==3)
    set(handles.edit_tempC,'Visible','on');
    set(handles.text_tempC,'Visible','on');
end

if(ifluid<=3)
    set(handles.text_kvisc,'Visible','off','Enable','off');
    set(handles.edit_kvisc,'Visible','off','Enable','off');       
end    

if(ifluid==2)
   
    set(handles.edit_altitude,'Visible','on');
    set(handles.text_altitude,'Visible','on');     
    
    if(iu==1)
            ss='Altitude (ft)'; 
    else
            ss='Altitude (m)';  
    end
    
    set(handles.text_altitude,'String',ss)     
    
end    

if(igeo==1)
    sv='Mean Velocity';
else
    sv='Freestream';    
end
set(handles.text_velox,'String',sv); 

if(igeo==1 || igeo==3)
   
    set(handles.text_diam,'Visible','on');
    set(handles.edit_diam,'Visible','on');
    
    if(iu==1)
        ss='Diameter (in)';
    else
        ss='Diameter (m)';
    end
    
    set(handles.text_diam,'String',ss);
    
else    

    set(handles.text_x,'Visible','on');
    set(handles.edit_x,'Visible','on'); 
    
    if(iu==1)
        ss='Length (in)';
    else
        ss='Length (m)';
    end
    
    set(handles.text_x,'String',ss);    
    
end

if(iu==1)
   s{1}='ft/sec';
   s{2}='miles/hr';
   sk='Kinematic Viscosity (ft^2/sec)';
else
   s{1}='m/sec';
   s{2}='km/hr';
   sk='Kinematic Viscosity (m^2/sec)';
end


set(handles.listbox_velox,'String',s);

set(handles.text_kvisc,'String',sk);

set(handles.uipanel_rey,'Visible','off');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_reynolds);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * ');
disp(' ');


iu=get(handles.listbox_units,'Value');

igeo=get(handles.listbox_geometry,'Value');

ifluid=get(handles.listbox_fluid,'Value');

% itemp=get(handles.listbox_temperature,'Value');

ivelox=get(handles.listbox_velox,'Value');

velox=str2num(get(handles.edit_velox,'String'));

if(iu==1)
   if(ivelox==1) % convert ft/sec to in/sec
        velox=velox*12;
   else  % convert miles/hr to in/sec
        velox=velox*17.6;       
   end
else
   if(ivelox==1)
   else  % convert km/hr to m/sec
        velox=velox*0.27778;       
   end    
end

if(iu==1)
    out1=sprintf(' Velocity = %8.4g ft/sec ',velox/12);
    out2=sprintf('          = %8.4g in/sec ',velox); 
    disp(out1);
    disp(out2);
else
    out1=sprintf(' Velocity = %8.4g m/sec ',velox); 
    disp(out1);
end


if(igeo==1 || igeo==3)
    diam=str2num(get(handles.edit_diam,'String'));   
    
    if(iu==1)
        out1=sprintf(' Diameter = %8.4g in \n',diam);
    else
        out1=sprintf(' Diameter = %8.4g m \n',diam);        
    end
    
    disp(out1);
    
else
    x=str2num(get(handles.edit_x,'String'));
    
    if(iu==1)
        out1=sprintf('   Length = %8.4g in',x);
    else
        out1=sprintf('   Length = %8.4g m',x);        
    end
    disp(out1);
    
end



if(ifluid==1)
    tempC=str2num(get(handles.edit_tempC,'String'));
    
    if(tempC < -25 || tempC > 35)
        warndlg(' Temperature must be from -25 to 35 deg C');
        return;
    end    
    
    [~,kvisc]=Sutherland_air_one_atm(tempC);
    
    if(iu==1)  % convert m^2/sec to ft^2/sec
        kvisc=kvisc*10.764;
    end    
end
if(ifluid==2)
    alt=str2num(get(handles.edit_altitude,'String')); 
end    
if(ifluid==2)
    if(iu==1)
        out1=sprintf(' Altitude = %8.4g ft',alt);
    else
        out1=sprintf(' Altitude = %8.4g m',alt);            
    end        
    disp(out1);
    [~,~,~,~,~,~,kvisc]=atmospheric_properties_1976(alt,iu);      
end
if(ifluid==3)
    
    tempC=str2num(get(handles.edit_tempC,'String'));
    
    if(tempC <2 || tempC > 80)
        warndlg(' Temperature must be from 2 to 80 deg C');
        return;
    end
    
    [~,kvisc,~]=fresh_water_properties(tempC);
    
    if(iu==1)  % convert mm^2/sec to ft^2/sec
        kvisc=kvisc*1.0764e-05;
    else       % convert mm^2/sec to m^2/sec
        kvisc=kvisc*1e-06;        
    end
     
end        
if(ifluid<=3)
    set(handles.text_kvisc,'Visible','on','Enable','off');
    set(handles.edit_kvisc,'Visible','on','Enable','off');
    
    ss=sprintf('%8.4g',kvisc);
    set(handles.edit_kvisc,'String',ss); 
end
if(ifluid==4)
    kvisc=str2num(get(handles.edit_kvisc,'String'));
end

if(iu==1)
    out1=sprintf('\n Kinematic viscosity = %8.4g ft^2/sec ',kvisc);
else
    out1=sprintf('\n Kinematic viscosity = %8.4g m^2/sec  ',kvisc);    
end
disp(out1);


if(ifluid==1 || ifluid==3)
    out1=sprintf(' Temperature = %8.4g deg C',tempC);
    disp(out1);
end    


if(iu==1)   % convert ft^2/sec to in^2/sec
    kvisc=kvisc*144;
end

if(igeo==1) % internal flow through circular pipe
    Rey=velox*diam/kvisc;
end
if(igeo==2) % external flow over flat plate
    Rey=velox*x/kvisc;   
end
if(igeo==3) % external flow around cylinder (perpendicular)
    Rey=velox*diam/kvisc;   
end

set(handles.text_kvisc,'Enable','on');

sr=sprintf('%9.5g',Rey);


out1=sprintf(' Reynolds number = %8.4g ',Rey);
disp(out1);

set(handles.edit_rey,'String',sr);

set(handles.uipanel_rey,'Visible','on');


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


% --- Executes on selection change in listbox_geometry.
function listbox_geometry_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_geometry contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_geometry

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_geometry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_fluid.
function listbox_fluid_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fluid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fluid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fluid

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_fluid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fluid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_temperature.
function listbox_temperature_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_temperature contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_temperature
set(handles.uipanel_rey,'Visible','off');



% --- Executes during object creation, after setting all properties.
function listbox_temperature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_temperature_Callback(hObject, eventdata, handles)
% hObject    handle to edit_temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_temperature as text
%        str2double(get(hObject,'String')) returns contents of edit_temperature as a double


% --- Executes during object creation, after setting all properties.
function edit_temperature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_altitude_Callback(hObject, eventdata, handles)
% hObject    handle to edit_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_altitude as text
%        str2double(get(hObject,'String')) returns contents of edit_altitude as a double


% --- Executes during object creation, after setting all properties.
function edit_altitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_velox_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velox as text
%        str2double(get(hObject,'String')) returns contents of edit_velox as a double


% --- Executes during object creation, after setting all properties.
function edit_velox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_velox.
function listbox_velox_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_velox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_velox
set(handles.uipanel_rey,'Visible','off');



% --- Executes during object creation, after setting all properties.
function listbox_velox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kvisc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kvisc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kvisc as text
%        str2double(get(hObject,'String')) returns contents of edit_kvisc as a double


% --- Executes during object creation, after setting all properties.
function edit_kvisc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kvisc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function edit_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x as text
%        str2double(get(hObject,'String')) returns contents of edit_x as a double


% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_velox and none of its controls.
function edit_velox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_rey,'Visible','off');


% --- Executes on key press with focus on edit_kvisc and none of its controls.
function edit_kvisc_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_kvisc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_rey,'Visible','off');


% --- Executes on key press with focus on edit_diam and none of its controls.
function edit_diam_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_rey,'Visible','off');


% --- Executes on key press with focus on edit_x and none of its controls.
function edit_x_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_rey,'Visible','off');


% --- Executes on key press with focus on edit_temperature and none of its controls.
function edit_temperature_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_temperature (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_rey,'Visible','off');


% --- Executes on key press with focus on edit_altitude and none of its controls.
function edit_altitude_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_altitude (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_rey,'Visible','off');



function edit_rey_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rey as text
%        str2double(get(hObject,'String')) returns contents of edit_rey as a double


% --- Executes during object creation, after setting all properties.
function edit_rey_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tempC_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tempC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tempC as text
%        str2double(get(hObject,'String')) returns contents of edit_tempC as a double


% --- Executes during object creation, after setting all properties.
function edit_tempC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tempC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
