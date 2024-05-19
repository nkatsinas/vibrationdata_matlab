function varargout = annular_honeycomb(varargin)
% ANNULAR_HONEYCOMB MATLAB code for annular_honeycomb.fig
%      ANNULAR_HONEYCOMB, by itself, creates a new ANNULAR_HONEYCOMB or raises the existing
%      singleton*.
%
%      H = ANNULAR_HONEYCOMB returns the handle to a new ANNULAR_HONEYCOMB or the handle to
%      the existing singleton*.
%
%      ANNULAR_HONEYCOMB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANNULAR_HONEYCOMB.M with the given input arguments.
%
%      ANNULAR_HONEYCOMB('Property','Value',...) creates a new ANNULAR_HONEYCOMB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before annular_honeycomb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to annular_honeycomb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help annular_honeycomb

% Last Modified by GUIDE v2.5 27-Dec-2012 11:35:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @annular_honeycomb_OpeningFcn, ...
                   'gui_OutputFcn',  @annular_honeycomb_OutputFcn, ...
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


% --- Executes just before annular_honeycomb is made visible.
function annular_honeycomb_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to annular_honeycomb (see VARARGIN)

% Choose default command line output for annular_honeycomb
handles.output = hObject;

handles.unit=1;
handles.material=1;

% Update handles structure
guidata(hObject, handles);

units_change(hObject,eventdata,handles)

clear_answer(hObject, eventdata, handles)



% --- Outputs from this function are returned to the command line.
function varargout = annular_honeycomb_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in return_pushbutton.
function return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(annular_honeycomb)


% --- Executes on button press in calculate_button.
function calculate_button_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer,'Enable','on');

outer_BC=get(handles.outer_BC_listbox,'Value');
inner_BC=get(handles.inner_BC_listbox,'Value');


E=str2num(get(handles.elastic_modulus_edit,'String'));

rho=str2num(get(handles.mass_density_edit,'String'));
core_rho=str2num(get(handles.core_mass_density_edit,'String'));

mu=str2num(get(handles.poisson_edit,'String'));

outer_diameter=str2num(get(handles.outer_diameter_edit,'String'));
inner_diameter=str2num(get(handles.inner_diameter_edit,'String'));

t1=str2num(get(handles.top_thickness_edit,'String'));
hc=str2num(get(handles.core_thickness_edit,'String'));
t2=str2num(get(handles.bottom_thickness_edit,'String'));


NSM=str2num(get(handles.NSM_edit,'String'));

if(handles.unit==1)
    rho=rho/386;
    core_rho=core_rho/386;
    NSM=NSM/386;
else
    [E]=GPa_to_Pa(E);
    outer_diameter=outer_diameter/1000;
    inner_diameter=inner_diameter/1000;
    t1=t1/1000;
    hc=hc/1000;
    t2=t2/1000;
end

h=hc+(1/2)*(t1+t2);

num=t1*t2*h^2;
den=t1+t2;

D=(E/(1-mu^2))*num/den;



tpi=2*pi;

r=outer_diameter/2;


area=pi*(outer_diameter^2-inner_diameter^2)/4;

rho_area=rho*(t1+t2) + core_rho*hc + NSM/area;

total_mass=rho_area*area;

term=sqrt(D/rho_area)/(tpi*r^2);



x=[ 0.1 0.3 0.5 0.7 ];

if(outer_BC==1 && inner_BC==1)  % fixed-fixed
   y1=[ 27.3  45.2  89.2  248];
   y2=[ 28.4  45.6  90.2  249 ];
end

if(outer_BC==1 && inner_BC==2)  % fixed-ss
   y1=[ 22.6  33.7  63.9  175]; 
   y2=[ 25.1  35.8  65.4  175 ];
end

if(outer_BC==1 && inner_BC==3)  % fixed-free
   y1=[ 10.2  11.4   17.7  43.1];
   y2=[ 21.1  19.5   22.1  45.3 ];
end

if(outer_BC==2 && inner_BC==1)  % ss-fixed
   y1=[ 17.8  29.9  59.8   168];
   y2=[ 19.0  31.4  61.0   170];
end

if(outer_BC==2 && inner_BC==2)  % ss-ss
    y1=[ 14.5  21.1   40.0  110];  
    y2=[ 16.7  23.3   41.8  112];
end

if(outer_BC==2 && inner_BC==3)  % ss-free
    y1=[ 4.86  4.66   5.07   6.94]; 
    y2=[ 13.9  12.8   11.6  13.3 ];
end


if(outer_BC==3 && inner_BC==1)  % free-fixed
    y1=[ 4.23    6.66   13.0   37.0]; 
    y2=[ 3.14    6.33   13.3   37.5];
end

if(outer_BC==3 && inner_BC==2)  % free-ss
    y1=[ 3.45   3.42    4.11    6.18]; 
    y2=[ 2.30   3.32    4.86    8.34];
end

if(outer_BC==3 && inner_BC==3)  % free-free
    y1=[ 5.30  4.91   4.28  3.57]; 
    y2=[ 8.77  8.36   9.32  13.2];
end


iflag=0;

z=inner_diameter/outer_diameter;

if(z>=1)
    iflag=1;
end

if(z<0.1)
    iflag=2;
end

p = polyfit(x,y1,3);
L=p(1)*z^3+p(2)*z^2+p(3)*z+p(4);
fn(1)=L*term;

p = polyfit(x,y2,3);
L=p(1)*z^3+p(2)*z^2+p(3)*z+p(4);
fn(2)=L*term;


if(fn(2)<fn(1))
    temp=fn(1);
    fn(1)=fn(2);
    fn(2)=temp;
end

if(iflag==0)    

    ss1=sprintf('natural frequencies = \n\n %8.4g Hz\n %8.4g Hz',...
                                                            fn(1),fn(2));
                                                    
    if(handles.unit==1)
        ss2=sprintf('total mass = \n\n %8.4g lbm',total_mass*386);
    else
        ss2=sprintf('total mass = \n\n %8.4g kg',total_mass);
    end

    ss3=sprintf('%s \n\n %s',ss1,ss2);

end
if(iflag==1)
    ss3='Error: inner diameter >= outer diameter ';
end

if(iflag==2)
    ss3='Error: diameter ratio < 0.1 ';
end
                                                    
set(handles.Answer,'String',ss3);





% --- Executes on selection change in outer_BC_listbox.
function outer_BC_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to outer_BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns outer_BC_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from outer_BC_listbox
clear_answer(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function outer_BC_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outer_BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in material_listbox.
function material_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to material_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns material_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from material_listbox
clear_answer(hObject, eventdata, handles)

handles.material=get(hObject,'Value');

guidata(hObject, handles);

material_change(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function material_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to material_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function outer_diameter_edit_Callback(hObject, eventdata, handles)
% hObject    handle to outer_diameter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outer_diameter_edit as text
%        str2double(get(hObject,'String')) returns contents of outer_diameter_edit as a double


% --- Executes during object creation, after setting all properties.
function outer_diameter_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outer_diameter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function core_thickness_edit_Callback(hObject, eventdata, handles)
% hObject    handle to core_thickness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of core_thickness_edit as text
%        str2double(get(hObject,'String')) returns contents of core_thickness_edit as a double


% --- Executes during object creation, after setting all properties.
function core_thickness_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to core_thickness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bottom_thickness_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bottom_thickness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bottom_thickness_edit as text
%        str2double(get(hObject,'String')) returns contents of bottom_thickness_edit as a double


% --- Executes during object creation, after setting all properties.
function bottom_thickness_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bottom_thickness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function top_thickness_edit_Callback(hObject, eventdata, handles)
% hObject    handle to top_thickness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of top_thickness_edit as text
%        str2double(get(hObject,'String')) returns contents of top_thickness_edit as a double


% --- Executes during object creation, after setting all properties.
function top_thickness_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to top_thickness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox

clear_answer(hObject, eventdata, handles)

handles.unit=get(hObject,'Value');

guidata(hObject, handles);

units_change(hObject,eventdata,handles);
materials_listbox_Callback(hObject, eventdata, handles);





% --- Executes during object creation, after setting all properties.
function units_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Answer_Callback(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Answer as text
%        str2double(get(hObject,'String')) returns contents of Answer as a double


% --- Executes during object creation, after setting all properties.
function Answer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
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



function elastic_modulus_edit_Callback(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elastic_modulus_edit as text
%        str2double(get(hObject,'String')) returns contents of elastic_modulus_edit as a double


% --- Executes during object creation, after setting all properties.
function elastic_modulus_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass_density_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass_density_edit as text
%        str2double(get(hObject,'String')) returns contents of mass_density_edit as a double


% --- Executes during object creation, after setting all properties.
function mass_density_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poisson_edit_Callback(hObject, eventdata, handles)
% hObject    handle to poisson_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poisson_edit as text
%        str2double(get(hObject,'String')) returns contents of poisson_edit as a double


% --- Executes during object creation, after setting all properties.
function poisson_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poisson_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function core_mass_density_edit_Callback(hObject, eventdata, handles)
% hObject    handle to core_mass_density_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of core_mass_density_edit as text
%        str2double(get(hObject,'String')) returns contents of core_mass_density_edit as a double


% --- Executes during object creation, after setting all properties.
function core_mass_density_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to core_mass_density_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function clear_answer(hObject, eventdata, handles)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');
% Update handles structure
guidata(hObject, handles);


% --- Executes on key press with focus on elastic_modulus_edit and none of its controls.
function elastic_modulus_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


% --- Executes on key press with focus on mass_density_edit and none of its controls.
function mass_density_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


% --- Executes on key press with focus on poisson_edit and none of its controls.
function poisson_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to poisson_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


% --- Executes on key press with focus on core_mass_density_edit and none of its controls.
function core_mass_density_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to core_mass_density_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


% --- Executes on key press with focus on NSM_edit and none of its controls.
function NSM_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to NSM_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


% --- Executes on key press with focus on outer_diameter_edit and none of its controls.
function outer_diameter_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to outer_diameter_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


% --- Executes on key press with focus on top_thickness_edit and none of its controls.
function top_thickness_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to top_thickness_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


% --- Executes on key press with focus on core_thickness_edit and none of its controls.
function core_thickness_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to core_thickness_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


% --- Executes on key press with focus on bottom_thickness_edit and none of its controls.
function bottom_thickness_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to bottom_thickness_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)

function material_change(hObject, eventdata, handles)

if(handles.unit==1)  % English
    if(handles.material==1) % aluminum
        handles.elastic_modulus=1e+007;
        handles.mass_density=0.1;  
    end  
    if(handles.material==2)  % steel
        handles.elastic_modulus=3e+007;
        handles.mass_density= 0.28;         
    end
    if(handles.material==3)  % copper
        handles.elastic_modulus=1.6e+007;
        handles.mass_density=  0.322;
    end
else                 % metric
    if(handles.material==1)  % aluminum
        handles.elastic_modulus=70;
        handles.mass_density=  2700;
    end
    if(handles.material==2)  % steel
        handles.elastic_modulus=205;
        handles.mass_density=  7700;        
    end
    if(handles.material==3)   % copper
        handles.elastic_modulus=110;
        handles.mass_density=  8900;
    end
end

if(handles.material==1)  % aluminum
       handles.poisson=0.33;  
end
if(handles.material==2)  % steel
       handles.poisson=0.30;      
end
if(handles.material==3)   % copper
       handles.poisson=0.33; 
end

if(handles.material<=3)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density); 
    ss3=sprintf('%8.4g',handles.poisson); 
    
else
    handles.elastic_modulus=0;
    handles.mass_density=   0;
    handles.poisson=   0;
    
    ss1=' ';
    ss2=' ';
    ss3=' ';
end

set(handles.elastic_modulus_edit,'String',ss1);
set(handles.mass_density_edit,'String',ss2);  
set(handles.poisson_edit,'String',ss3);  


guidata(hObject, handles);


function units_change(hObject,eventdata,handles)

% disp(' units_change ');

if(handles.unit==1)
   set(handles.elastic_modulus_text,'String','Elastic Modulus (psi)');
   set(handles.mass_density_text,'String','Mass Density (lbm/in^3)');
   set(handles.core_mass_density_text,'String','lbm/in^3');
   set(handles.mass_text,'String','lbm');
   set(handles.d1,'String','inch');
   set(handles.d2,'String','inch');
   set(handles.d3,'String','inch');
   set(handles.d4,'String','inch');
   set(handles.d5,'String','inch');
else
   set(handles.elastic_modulus_text,'String','Elastic Modulus (GPa)'); 
   set(handles.mass_density_text,'String','Mass Density (kg/m^3)');
   set(handles.core_mass_density_text,'String','kg/m^3');
   set(handles.mass_text,'String','kg');
   set(handles.d1,'String','mm');
   set(handles.d2,'String','mm');
   set(handles.d3,'String','mm');
   set(handles.d4,'String','mm');
   set(handles.d5,'String','mm');
end

material_change(hObject, eventdata, handles);

guidata(hObject, handles)


% --- Executes on selection change in inner_BC_listbox.
function inner_BC_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to inner_BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns inner_BC_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from inner_BC_listbox
clear_answer(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function inner_BC_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inner_BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inner_diameter_edit_Callback(hObject, eventdata, handles)
% hObject    handle to inner_diameter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inner_diameter_edit as text
%        str2double(get(hObject,'String')) returns contents of inner_diameter_edit as a double


% --- Executes during object creation, after setting all properties.
function inner_diameter_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inner_diameter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on inner_diameter_edit and none of its controls.
function inner_diameter_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to inner_diameter_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)
