function varargout = beam_bending_extended(varargin)
% BEAM_BENDING_EXTENDED MATLAB code for beam_bending_extended.fig
%      BEAM_BENDING_EXTENDED, by itself, creates a new BEAM_BENDING_EXTENDED or raises the existing
%      singleton*.
%
%      H = BEAM_BENDING_EXTENDED returns the handle to a new BEAM_BENDING_EXTENDED or the handle to
%      the existing singleton*.
%
%      BEAM_BENDING_EXTENDED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_BENDING_EXTENDED.M with the given input arguments.
%
%      BEAM_BENDING_EXTENDED('Property','Value',...) creates a new BEAM_BENDING_EXTENDED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_bending_extended_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_bending_extended_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_bending_extended

% Last Modified by GUIDE v2.5 24-Feb-2017 15:46:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_bending_extended_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_bending_extended_OutputFcn, ...
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


% --- Executes just before beam_bending_extended is made visible.
function beam_bending_extended_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_bending_extended (see VARARGIN)

% Choose default command line output for beam_bending_extended
handles.output = hObject;

handles.leftBC=1;
handles.rightBC=1;
handles.unit=1;
handles.material=1;
handles.cross_section=1;

handles.length=0;
handles.elastic_modulus=0;
handles.mass_density=0;

handles.thick=0;
handles.width=0;

handles.diameter=0;
handles.wall_thick=0;

handles.MOI=0;
handles.area=0;

handles.num=100;
handles.n=5;

handles.mode_number=1;

handles.mode_shapes=zeros(handles.num+1,handles.n);

handles.x=zeros(handles.num+1,1);

clc;
axes(handles.axes_beam_image);
bg = imread('beam_image_2.jpg');
image(bg);
axis off; 

set(handles.apply_base_pushbutton,'Enable','off');
set(handles.apply_force_pushbutton,'Enable','off');

setappdata(0,'fig_num',1);

set(handles.Answer,'Enable','off');
set(handles.modelistbox,'Enable','off');

set(handles.edit_neutral_axis,'Visible','off');
set(handles.text_neutral_axis,'Visible','off');

set(handles.lengtheditbox,'String','');

% Update handles structure
guidata(hObject, handles);

material_change(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);
crosssectionlistbox_Callback(hObject, eventdata, handles);

% UIWAIT makes beam_bending_extended wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_bending_extended_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in leftBClistbox.
function leftBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns leftBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from leftBClistbox
clear_answer(hObject, eventdata, handles);
set(handles.modelistbox,'Enable','off');
axes(handles.mode_axis);
cla;

handles.leftBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function leftBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function clear_answer(hObject, eventdata, handles)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');
set(handles.apply_base_pushbutton,'Enable','off');
set(handles.apply_force_pushbutton,'Enable','off');


% --- Executes on selection change in rightBClistbox.
function rightBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rightBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rightBClistbox

axes(handles.mode_axis);
cla;
clear_answer(hObject, eventdata, handles)
handles.rightBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rightBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in materiallistbox.
function materiallistbox_Callback(hObject, eventdata, handles)
% hObject    handle to materiallistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns materiallistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from materiallistbox

clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;
handles.material=get(hObject,'Value');

material_change(hObject, eventdata, handles);

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
    if(handles.material==4)  % G10
        handles.elastic_modulus=2.7e+006;
        handles.mass_density=  0.065;
    end
    if(handles.material==5)  % PVC
        handles.elastic_modulus=3.5e+005;
        handles.mass_density=  0.052;
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
    if(handles.material==4)  % G10
        handles.elastic_modulus=18.6;
        handles.mass_density=  1800;
    end
    if(handles.material==5)  % PVC
        handles.elastic_modulus=24.1;
        handles.mass_density=  1440;
    end
end

if(handles.material<6)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density);

    set(handles.elasticmoduluseditbox,'String',ss1);
    set(handles.massdensityeditbox,'String',ss2);    
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function materiallistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to materiallistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elasticmoduluseditbox_Callback(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elasticmoduluseditbox as text
%        str2double(get(hObject,'String')) returns contents of elasticmoduluseditbox as a double
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;

string=get(hObject,'String');
handles.elastic_modulus=str2num(string);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function elasticmoduluseditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function massdensityeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of massdensityeditbox as text
%        str2double(get(hObject,'String')) returns contents of massdensityeditbox as a double
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;
string=get(hObject,'String');

handles.mass_density=str2num(string);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function massdensityeditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;

handles.thick=0;
handles.diameter=0;
handles.area=0;

string=get(hObject,'String');

if(handles.cross_section==1) % rectangular
    handles.thick=str2num(string);
end
if(handles.cross_section==2) % pipe
    handles.diameter=str2num(string);   
end
if(handles.cross_section==3) % solid cylinder
    handles.diameter=str2num(string);    
end
if(handles.cross_section==4) % other
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
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;



string=get(hObject,'String');

if(handles.cross_section==1) % rectangular
    handles.width=str2num(string);
end
if(handles.cross_section==2) % pipe
    handles.wall_thick=str2num(string);   
end
if(handles.cross_section==3) % solid cylinder
    % nothing to do    
end
if(handles.cross_section==4) % other
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


% --- Executes on selection change in crosssectionlistbox.
function crosssectionlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectionlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns crosssectionlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from crosssectionlistbox
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;

handles.cross_section=get(handles.crosssectionlistbox,'Value');

guidata(hObject, handles);

geometry_change(hObject, eventdata, handles)


function geometry_change(hObject, eventdata, handles)

set(handles.edit_neutral_axis,'Visible','off');
set(handles.edit_neutral_axis,'String','');
set(handles.edit_neutral_axis,'Enable','off');

set(handles.text_neutral_axis,'Visible','off');

        

set(handles.crosssectioneditbox2,'Enable','on');

if(handles.cross_section==4) % other
    set(handles.edit_neutral_axis,'Visible','on');
    set(handles.edit_neutral_axis,'Enable','on');    
    set(handles.text_neutral_axis,'Visible','on');
end

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
        set(handles.text_neutral_axis,'String','Distance from Neutral Axis (inches)');
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
        set(handles.text_neutral_axis,'String','Distance from Neutral Axis (mm)');        
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
axes(handles.mode_axis);
cla;





% --- Executes during object creation, after setting all properties.
function crosssectionlistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectionlistbox (see GCBO)
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



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lengtheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lengtheditbox as text
%        str2double(get(hObject,'String')) returns contents of lengtheditbox as a double
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;

string=get(hObject,'String');

handles.length=str2num(string);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function lengtheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in unitslistbox.
function unitslistbox_Callback(hObject, eventdata, handles)
% hObject    handle to unitslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unitslistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unitslistbox
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;

handles.unit=get(hObject,'Value');

guidata(hObject, handles);

material_change(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);




if(handles.unit==1)
    set(handles.lengthlabel,'String','inch');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (lbf/in^2)');
    set(handles.massdensitylabel,'String','Mass Density (lbm/in^3)');
else
    set(handles.lengthlabel,'String','meter');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (GPa)'); 
    set(handles.massdensitylabel,'String','Mass Density (kg/m^3)');    
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function unitslistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unitslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calculatebutton.
function calculatebutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculatebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * ');
disp('  ');

set(handles.Answer,'Enable','on');
set(handles.modelistbox,'Enable','on');

set(handles.edit_neutral_axis,'Visible','on');
set(handles.text_neutral_axis,'Visible','on');



E=str2num(get(handles.elasticmoduluseditbox,'String'));
rho=str2num(get(handles.massdensityeditbox,'String'));

LBC=get(handles.leftBClistbox,'Value');
RBC=get(handles.rightBClistbox,'Value');

if((LBC==2 && RBC==3) || (LBC==3 && RBC==2)) % pinned-free
    warndlg('case unavailable');
    return;
end    


L=str2num(get(handles.lengtheditbox,'String'));



iflag=0;

if((LBC==2 && RBC==3) || (LBC==3 && RBC==2)) % pinned-free
    warndlg('pinned-free case unavailable');
    return;
end

[root]=beam_bending_roots_extended(LBC,RBC);

if(L>1.0e-20 && L<1.0e+20)
else
    iflag=2;
end


if(iflag==0)

    thick=handles.thick;
    width=handles.width;
    diameter=handles.diameter;
    wall_thick=handles.wall_thick;
    

    if(handles.unit==1) % English
        rho=rho/386;
    end
    if(handles.unit==2) % metric
        [E]=GPa_to_Pa(E);
        thick=thick/1000;
        width=width/1000;
        diameter=diameter/1000;
        wall_thick=wall_thick/1000;
    end
    
    if(handles.cross_section==4) % other
        set(handles.edit_neutral_axis,'Enable','on');
    else
        set(handles.edit_neutral_axis,'Enable','off');        
    end
    

    if(handles.cross_section==1) % rectangular
        [area,MOI,cna]=beam_rectangular_geometry(width,thick); 
    end
    if(handles.cross_section==2) % pipe
        [area,MOI,cna]=pipe_geometry_wall(diameter,wall_thick);         
    end
    if(handles.cross_section==3) % solid cylinder
        [area,MOI,cna]=cylinder_geometry(diameter);          
    end
    if(handles.cross_section==4) % other
        area=handles.area;
        MOI=handles.MOI;
        cna=str2num(get(handles.edit_neutral_axis,'String'));
    end
    
    ss=sprintf('%8.4g',cna);
    set(handles.edit_neutral_axis,'String',ss);      
    setappdata(0,'cna',cna);
    
    out1=sprintf('\n area=%8.4g MOI=%8.4g \n',area,MOI);
    disp(out1);

    rho=rho*area;   % mass per unit length
    
    mass=rho*L;
%
    sq_mass=sqrt(mass);
%
    EI_term = sqrt(E*MOI/rho);
    

    
    out1=sprintf('  E=%8.4g  MOI=%8.4g  area=%8.4g',E,MOI,area);
%    disp(out1);
 
    out1=sprintf('  EI_term=%8.4g  rho=%8.4g  L=%8.4g  ',EI_term,rho,L);
%     disp(out1);
    
    
    n=length(root);
    
    fn=zeros(n,1);
    beta=zeros(n,1);    
    
    for i=1:n
        beta(i)=root(i)/L;
        omegan=beta(i)^2*EI_term;
        fn(i)=omegan/(2*pi);
    end

    fn_string=sprintf('%8.4g \n%8.4g \n%8.4g \n%8.4g \n%8.4g \n%8.4g \n%8.4g \n%8.4g',...
                                     fn(1),fn(2),fn(3),fn(4),fn(5),fn(6),fn(7),fn(8));

    C=zeros(n,1);
    
    part=zeros(n,1);
    emm=zeros(n,1);
%   
    if(LBC==1 && RBC==1) % fixed-fixed
        for i=1:n
            bL=root(i);
            C(i)=(sinh(bL)+sin(bL))/(cosh(bL)-cos(bL));
            arg=root(i);
            p2=(sinh(arg)-sin(arg))-C(i)*(cosh(arg)+cos(arg));
            arg=0;
            p1=(sinh(arg)-sin(arg))-C(i)*(cosh(arg)+cos(arg));
            part(i)=(p2-p1)/beta(i);
        end
        ModeShape=@(arg,Co)((cosh(arg)-cos(arg))-Co*(sinh(arg)-sin(arg)));
        kflag=1;
        part=part*sqrt(mass/L^2);
    end
%
    if((LBC==1 && RBC==2) || (LBC==2 && RBC==1)) % fixed-pinned

        for i=1:n
           C(i)=-(sinh(root(i))+sin(root(i)))/(cosh(root(i))+cos(root(i)));
           arg=root(i);
           p2=(cosh(arg)+cos(arg))-C(i)*(sinh(arg)-sin(arg));
           arg=0;
           p1=(cosh(arg)+cos(arg))-C(i)*(sinh(arg)-sin(arg));
           part(i)=(p2-p1)/beta(i);
        end      
        ModeShape=@(arg,Co)((sinh(arg)-sin(arg))+Co*(cosh(arg)-cos(arg)));
        kflag=1;
        part=part*sqrt(mass/L^2);       
    end
%   
    if((LBC==1 && RBC==3) || (LBC==3 && RBC==1)) % fixed-free

        for i=1:n
           C(i)=-(cos(root(i))+cosh(root(i)))/(sin(root(i))+sinh(root(i)));
           arg=root(i);
           p2=(sinh(arg)-sin(arg))+C(i)*(cosh(arg)+cos(arg));
           arg=0;
           p1=(sinh(arg)-sin(arg))+C(i)*(cosh(arg)+cos(arg));
           part(i)=(p2-p1)/beta(i);           
        end
        
        ModeShape=@(arg,Co)((cosh(arg)-cos(arg))+Co*(sinh(arg)-sin(arg)));
        kflag=1;
        part=part*sqrt(mass/L^2);
    end
%    
    if(LBC==2 && RBC==2) % pinned-pinned
        C=sqrt(2)*ones(n,1);
        ModeShape=@(arg,Co)(Co*sin(arg));
        kflag=1;
%      
        for i=1:n
           part(i)=(-1/(i*pi))*sqrt(2*mass)*(cos(i*pi)-1);
        end
%       
    end 
%    
    iflag=0;
    if(LBC==3 && RBC==3) % free-free
        for i=1:n
            bL=root(i);
            C(i)=(-cosh(bL)+cos(bL))/(sinh(bL)+sin(bL));
        end
        ModeShape=@(arg,Co)((sinh(arg)+sin(arg))+Co*(cosh(arg)+cos(arg)));
        iflag=1;
    end     
%%
%%
%%%
%%%
    if(iflag==0)
        sum=0;
%
        disp('        Natural    Participation    Effective  ');
        disp('Mode   Frequency      Factor        Modal Mass ');
%
        for i=1:n
            emm(i)=part(i)^2;
            out1 = sprintf('%d  %10.4g Hz   %10.4g      %10.4g',i,fn(i),part(i),emm(i) );
            disp(out1)
            sum=sum+emm(i);
        end
        out1=sprintf('\n modal mass sum = %8.4g \n',sum);
        disp(out1)
    
    else  % free-free
%
        disp('        Natural  ');
        disp('Mode   Frequency ');
%
        for i=1:n
            out1 = sprintf('%d  %10.4g Hz',i,fn(i) );
            disp(out1)
        end
        
    end    

%%%
%%%
%%
%%
    num=handles.num;
    
    num=1000;
    
    dx=L/num;
    
    NN=10000;
    
    for i=1:(NN-1)
        x(i)=L*(i-1)/NN;
        
        for j=1:n
            arg=beta(j)*x(i);
            y(i,j)=ModeShape(arg,C(j));
        end
    end
    
    for j=1:n
        my=max(abs(y(:,j)));     
        y(:,j)=y(:,j)/my;
    end
    
    
    handles.mode_shapes=y;
    handles.x=x;
    
    mode_shape_plot(hObject, eventdata, handles)
    
    setappdata(0,'unit',handles.unit);
    setappdata(0,'fn',fn(1:5));
    setappdata(0,'root',root(1:5));
    setappdata(0,'beta',beta(1:5));
    setappdata(0,'length',L);    
    setappdata(0,'C',C);
    setappdata(0,'LBC',LBC);    
    setappdata(0,'RBC',RBC);
    setappdata(0,'sq_mass',sq_mass);    
    setappdata(0,'part',part(1:5));   
    setappdata(0,'E',E);  
    setappdata(0,'I',MOI);  
end



if((LBC==2 && RBC==3) || (LBC==3 && RBC==2)) % pinned-free
    fn_string='case unavailable';
end    
    
    
if(iflag==2)
    fn_string='length error';
end
    
set(handles.Answer,'String',fn_string);


if((LBC==2 && RBC==3) || (LBC==3 && RBC==2) || (LBC==3 && RBC==3) ) % pinned-free

    set(handles.apply_base_pushbutton,'Enable','off');
    set(handles.apply_force_pushbutton,'Enable','off');    
else
    
    if(handles.cross_section==1) % rectangular
        if(thick>width)
            msgbox('Thickness > Width');
        end
    end 
    
    set(handles.apply_base_pushbutton,'Enable','on');
    set(handles.apply_force_pushbutton,'Enable','on');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% do not put in separate function

    if(LBC==1 && RBC==1) % fixed-fixed
        ModeShape=@(arg,Co,sq_mass)(((cosh(arg)-cos(arg))+Co*(sinh(arg)-sin(arg)))/sq_mass);
        ModeShape_dd=@(arg,Co,beta,sq_mass)...
        (((cosh(arg)+cos(arg))-Co*(sinh(arg)+sin(arg)))*(beta^2/sq_mass));      
    end
    if((LBC==1 && RBC==2) || (LBC==2 && RBC==1)) % fixed-pinned  
        ModeShape=@(arg,Co,sq_mass)(((sinh(arg)-sin(arg))+Co*(cosh(arg)-cos(arg)))/sq_mass);
        ModeShape_dd=@(arg,Co,beta,sq_mass)...
        (((sinh(arg)+sin(arg))+Co*(cosh(arg)+cos(arg)))*(beta^2/sq_mass));         
    end
    if((LBC==1 && RBC==3) || (LBC==3 && RBC==1)) % fixed-free
        ModeShape=@(arg,Co,sq_mass)(((cosh(arg)-cos(arg))+Co*(sinh(arg)-sin(arg)))/sq_mass);
        ModeShape_dd=@(arg,Co,beta,sq_mass)...
        ((beta^2*((cosh(arg)+cos(arg))+Co*(sinh(arg)+sin(arg))))/sq_mass);
    end
    if(LBC==2 && RBC==2) % pinned-pinned
        ModeShape=@(arg,Co,sq_mass)((Co*sin(arg))/sq_mass);
       ModeShape_dd=@(arg,Co,beta,sq_mass)(beta^2*(-sqrt(2)*sin(arg))/sq_mass);        
    end  
    if(LBC==3 && RBC==3) % free-free
        ModeShape=@(arg,Co,sq_mass)(((sinh(arg)+sin(arg))+Co*(cosh(arg)+cos(arg)))/sq_mass);
    end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
xx=L*[0 0.5 1.0];

nxx=length(xx);

num_fn=length(fn);

ZZ=zeros(nxx,num_fn);
%
num_fn=length(fn);

xx
nxx

%
for j=1:num_fn
%
    for k=1:nxx      
        arg=beta(j)*xx(k);
        ZZ(k,j)=ModeShape(arg,C(j),sq_mass);
    end
%        
end
setappdata(0,'ZZ',ZZ);
setappdata(0,'xx',xx);

guidata(hObject, handles);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;


% --- Executes on key press with focus on lengtheditbox and none of its controls.
function lengtheditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;


% --- Executes on key press with focus on crosssectioneditbox1 and none of its controls.
function crosssectioneditbox1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;


% --- Executes on key press with focus on crosssectioneditbox2 and none of its controls.
function crosssectioneditbox2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;


% --- Executes on key press with focus on elasticmoduluseditbox and none of its controls.
function elasticmoduluseditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;


% --- Executes on key press with focus on massdensityeditbox and none of its controls.
function massdensityeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);
axes(handles.mode_axis);
cla;


% --- Executes on selection change in modelistbox.
function modelistbox_Callback(hObject, eventdata, handles)
% hObject    handle to modelistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns modelistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from modelistbox

mode_shape_plot(hObject, eventdata, handles)


function mode_shape_plot(hObject, eventdata, handles)

i=get(hObject,'Value');

x=handles.x;
y=handles.mode_shapes;

L=handles.length;

axes(handles.mode_axis);
cla;
plot(x,y(:,i));
grid on;
axis([0,L,-1.1,1.1]);

if(handles.unit==1)
    xlabel('x (inch) ');
else
    xlabel('x (meters) ');
end


% --- Executes during object creation, after setting all properties.
function modelistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modelistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in apply_base_pushbutton.
function apply_base_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to apply_base_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s1= beam_bending_damping;
set(handles.s1,'Visible','on');


% --- Executes during object creation, after setting all properties.
function axes_beam_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_beam_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_beam_image



function edit_neutral_axis_Callback(hObject, eventdata, handles)
% hObject    handle to edit_neutral_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_neutral_axis as text
%        str2double(get(hObject,'String')) returns contents of edit_neutral_axis as a double


% --- Executes during object creation, after setting all properties.
function edit_neutral_axis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_neutral_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in apply_force_pushbutton.
function apply_force_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to apply_force_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s1= beam_bending_damping_force;
set(handles.s1,'Visible','on');
