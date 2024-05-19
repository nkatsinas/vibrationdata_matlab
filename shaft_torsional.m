function varargout = shaft_torsional(varargin)
% SHAFT_TORSIONAL MATLAB code for shaft_torsional.fig
%      SHAFT_TORSIONAL, by itself, creates a new SHAFT_TORSIONAL or raises the existing
%      singleton*.
%
%      H = SHAFT_TORSIONAL returns the handle to a new SHAFT_TORSIONAL or the handle to
%      the existing singleton*.
%
%      SHAFT_TORSIONAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHAFT_TORSIONAL.M with the given input arguments.
%
%      SHAFT_TORSIONAL('Property','Value',...) creates a new SHAFT_TORSIONAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shaft_torsional_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shaft_torsional_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shaft_torsional

% Last Modified by GUIDE v2.5 09-Oct-2014 11:51:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shaft_torsional_OpeningFcn, ...
                   'gui_OutputFcn',  @shaft_torsional_OutputFcn, ...
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


% --- Executes just before shaft_torsional is made visible.
function shaft_torsional_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shaft_torsional (see VARARGIN)

% Choose default command line output for shaft_torsional
handles.output = hObject;

set(handles.uipanel_results,'Visible','off');

handles.unit=1;
handles.material=1;

handles.thick=0;
handles.width=0;
handles.diameter=0;
handles.wall_thick=0;

units_change(hObject,eventdata,handles)
clear_answer(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes shaft_torsional wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = shaft_torsional_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculate_pushbutton.
function calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

iu=get(handles.unit_listbox,'Value');

i_cross=get(handles.listbox_cross_section,'Value');

clear_answer(hObject, eventdata, handles)

set(handles.Answer,'Enable','on');
set(handles.uipanel_results,'Visible','on');

BC=get(handles.BC_listbox,'Value');


E=str2num(get(handles.elastic_modulus_edit,'String'));
rho=str2num(get(handles.mass_density_edit,'String'));
L=str2num(get(handles.length_edit,'String'));
mu=str2num(get(handles.edit_mu,'String'));

c1=str2num(get(handles.crosssectioneditbox1,'String'));
c2=str2num(get(handles.crosssectioneditbox2,'String'));

if(i_cross==1) % rectangular
    thick=c1;
    width=c2;
end
if(i_cross==2) % piple
    diameter=c1;
    wall_thick=c2;    
end
if(i_cross==3) % solid cylinder
    diameter=c1;    
end
if(i_cross==4) % other
    MOI=c2;
end
 


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

if(iu==1) % English
%    
    rho=rho/386;
%    
else      % metric
%    
    [E]=GPa_to_Pa(E);
    
    if(i_cross==1)
        thick=thick/1000;
        width=width/1000;
    end
    if(i_cross==2)
        diameter=diameter/1000;
        wall_thick=wall_thick/1000;
    end    
    if(i_cross==3)
        diameter=diameter/1000;
    end     
%    
end
    
    
if(i_cross==1) % rectangular
   [J]=rectangular_polar(width,thick);
end
if(i_cross==2) % pipe
   [~,J,~]=pipe_geometry_wall_polar(diameter,wall_thick);  
end
if(i_cross==3) % solid cylinder
    J=pi*diameter^4/32;      
end

        
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
G=E/(2*(1+mu));
%
Jm=J*(rho*L);
%
kr=G*J/L;
%
term=sqrt(kr/Jm);

out1=sprintf('\n J=%7.3g  G=%7.3g  kr=%7.3g  term=%7.3g \n',J,G,kr,term);
disp(out1);

%
if(BC==1 || BC==3)
   omegan(1)=1;
   omegan(2)=2;
   omegan(3)=3;
end
if(BC==2)
   omegan(1)=1/2;
   omegan(2)=3/2;
   omegan(3)=5/2;
end

omegan=omegan*pi*term;

fn=omegan/tpi;
disp(' ');
disp('    Natural ')
disp(' Frequency Hz) ');
out1=sprintf(' %9.5g \n %9.5g \n %9.5g \n',fn(1),fn(2),fn(3));
disp(out1);

fn_string=sprintf('%8.4g \n%8.4g \n%8.4g ',fn(1),fn(2),fn(3));
set(handles.Answer,'String',fn_string);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(shaft_torsional);



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


% --- Executes on selection change in unit_listbox.
function unit_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to unit_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unit_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unit_listbox
clear_answer(hObject, eventdata, handles);

handles.unit=get(hObject,'Value');

guidata(hObject, handles);

units_change(hObject,eventdata,handles);
geometry_change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function unit_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unit_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function length_edit_Callback(hObject, eventdata, handles)
% hObject    handle to length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of length_edit as text
%        str2double(get(hObject,'String')) returns contents of length_edit as a double


% --- Executes during object creation, after setting all properties.
function length_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in materials_listbox.
function materials_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to materials_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns materials_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from materials_listbox

clear_answer(hObject, eventdata, handles)

handles.material=get(hObject,'Value');

guidata(hObject, handles);

material_change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function materials_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to materials_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in BC_listbox.
function BC_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BC_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BC_listbox
set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function BC_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function units_change(hObject,eventdata,handles)

% disp(' units_change ');



if(handles.unit==1)
   set(handles.elastic_modulus_text,'String','Elastic Modulus (psi)');
   set(handles.mass_density_text,'String','Mass Density (lbm/in^3)');
   set(handles.length_text,'String','inch');
else
   set(handles.elastic_modulus_text,'String','Elastic Modulus (GPa)'); 
   set(handles.mass_density_text,'String','Mass Density (kg/m^3)');
   set(handles.length_text,'String','meters');   
end

material_change(hObject, eventdata, handles);

guidata(hObject, handles)


function clear_answer(hObject, eventdata, handles)

set(handles.uipanel_results,'Visible','off');

set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');
% Update handles structure
guidata(hObject, handles);

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

if(handles.material<=3)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density); 
 
else
    handles.elastic_modulus=0;
    handles.mass_density=   0;
    
    ss1=' ';
    ss2=' ';
end

set(handles.elastic_modulus_edit,'String',ss1);
set(handles.mass_density_edit,'String',ss2);  

guidata(hObject, handles);
 


% --- Executes on key press with focus on length_edit and none of its controls.
function length_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to length_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


% --- Executes on key press with focus on elastic_modulus_edit and none of its controls.
function elastic_modulus_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


% --- Executes on key press with focus on mass_density_edit and none of its controls.
function mass_density_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


% --- Executes on key press with focus on BC_listbox and none of its controls.
function BC_listbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to BC_listbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);



function edit_mu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mu as text
%        str2double(get(hObject,'String')) returns contents of edit_mu as a double
clear_answer(hObject, eventdata, handles);

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


% --- Executes on selection change in listbox_cross_section.
function listbox_cross_section_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cross_section (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cross_section contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cross_section
clear_answer(hObject, eventdata, handles);

handles.cross_section=get(hObject,'Value');

geometry_change(hObject, eventdata, handles)

units_change(hObject,eventdata,handles)

guidata(hObject, handles);


function geometry_change(hObject, eventdata, handles)

        
set(handles.crosssectioneditbox2,'Enable','on');

handles.cross_section=get(handles.listbox_cross_section,'Value');


if(handles.unit==1)
    if(handles.cross_section==1) % rectangular
        set(handles.crosssectionlabel1,'String','Thickness (in)');
        set(handles.crosssectionlabel2','String','Width (in)');
    end
    if(handles.cross_section==2) % pipe 
        set(handles.crosssectionlabel1,'String','Outer Diameter (in)');
        set(handles.crosssectionlabel2,'String','Wall Thickness (in)');    
    end
    if(handles.cross_section==3) % solid cylinder
        set(handles.crosssectionlabel1,'String','Diameter (in)');
        set(handles.crosssectionlabel2,'String',''); 
        set(handles.crosssectioneditbox2,'Enable','off');
    end
    if(handles.cross_section==4) % other
        set(handles.crosssectionlabel1,'String','Area (in^2)');
        set(handles.crosssectionlabel2,'String','Area Moment of Inertia(in^4)');
    end
else
    if(handles.cross_section==1) % rectangular
        set(handles.crosssectionlabel1,'String','Thickness (mm)');
        set(handles.crosssectionlabel2','String','Width (mm)');
    end
    if(handles.cross_section==2) % pipe 
        set(handles.crosssectionlabel1,'String','Outer Diameter (mm)');
        set(handles.crosssectionlabel2,'String','Wall Thickness (mm)');    
    end
    if(handles.cross_section==3) % solid cylinder
        set(handles.crosssectionlabel1,'String','Diameter (mm)');
        set(handles.crosssectionlabel2,'String',''); 
        set(handles.crosssectioneditbox2,'Enable','off');
    end
    if(handles.cross_section==4) % other
        set(handles.crosssectionlabel1,'String','Area (mm^2)');
        set(handles.crosssectionlabel2,'String','Area Moment of Inertia(mm^4)');        
    end
end

set(handles.crosssectioneditbox1,'String',' ');
set(handles.crosssectioneditbox2,'String',' ');

handles.thick=0;
handles.width=0;

handles.diameter=0;
handles.wall_thick=0;

handles.MOI=0;
handles.area=0;

clear_answer(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_cross_section_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cross_section (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crosssectioneditbox1_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crosssectioneditbox1 as text
%        str2double(get(hObject,'String')) returns contents of crosssectioneditbox1 as a double
handles.thick=0;
handles.diameter=0;
handles.area=0;

i_cross=get(handles.listbox_cross_section,'Value');

string=get(hObject,'String');

if(i_cross==1) % rectangular
    handles.thick=str2num(string);
end
if(i_cross==2) % pipe
    handles.diameter=str2num(string);   
end
if(i_cross==3) % solid cylinder
    handles.diameter=str2num(string);    
end
if(i_cross==4) % other
    handles.area=str2num(string);     
end


guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function crosssectioneditbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crosssectioneditbox2_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crosssectioneditbox2 as text
%        str2double(get(hObject,'String')) returns contents of crosssectioneditbox2 as a double
string=get(hObject,'String');

i_cross=get(handles.listbox_cross_section,'Value');

if(i_cross==1) % rectangular
    handles.width=str2num(string);
end
if(i_cross==2) % pipe
    handles.wall_thick=str2num(string);   
end
if(i_cross==3) % solid cylinder
    % nothing to do    
end
if(i_cross==4) % other
    handles.MOI=str2num(string);     
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function crosssectioneditbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on crosssectioneditbox1 and none of its controls.
function crosssectioneditbox1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


% --- Executes on key press with focus on crosssectioneditbox2 and none of its controls.
function crosssectioneditbox2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);
