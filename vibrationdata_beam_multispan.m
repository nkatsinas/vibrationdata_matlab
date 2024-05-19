function varargout = vibrationdata_beam_multispan(varargin)
% VIBRATIONDATA_BEAM_MULTISPAN MATLAB code for vibrationdata_beam_multispan.fig
%      VIBRATIONDATA_BEAM_MULTISPAN, by itself, creates a new VIBRATIONDATA_BEAM_MULTISPAN or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_BEAM_MULTISPAN returns the handle to a new VIBRATIONDATA_BEAM_MULTISPAN or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_BEAM_MULTISPAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_BEAM_MULTISPAN.M with the given input arguments.
%
%      VIBRATIONDATA_BEAM_MULTISPAN('Property','Value',...) creates a new VIBRATIONDATA_BEAM_MULTISPAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_beam_multispan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_beam_multispan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_beam_multispan

% Last Modified by GUIDE v2.5 08-Oct-2014 16:35:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_beam_multispan_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_beam_multispan_OutputFcn, ...
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


% --- Executes just before vibrationdata_beam_multispan is made visible.
function vibrationdata_beam_multispan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_beam_multispan (see VARARGIN)

% Choose default command line output for vibrationdata_beam_multispan
handles.output = hObject;

unitslistbox_Callback(hObject, eventdata, handles);

handles.thick=0;
handles.width=0;

handles.diameter=0;
handles.wall_thick=0;

handles.MOI=0;
handles.area=0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_beam_multispan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_beam_multispan_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_beam_multispan);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

tpi=2*pi;

handles.unit=get(handles.unitslistbox,'Value');

E=str2num(get(handles.elasticmoduluseditbox,'String'));
rho=str2num(get(handles.massdensityeditbox,'String'));

BC=get(handles.BClistbox,'Value');

L1=str2num(get(handles.lengtheditbox_1,'String'));
L2=str2num(get(handles.lengtheditbox_2,'String'));

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


if(handles.cross_section==1) % rectangular
        [area,MOI,~]=beam_rectangular_geometry(width,thick); 
end
if(handles.cross_section==2) % pipe
        [area,MOI,~]=pipe_geometry_wall(diameter,wall_thick);
end
if(handles.cross_section==3) % solid cylinder
        [area,MOI,~]=cylinder_geometry(diameter); 
end
if(handles.cross_section==4) % other
        area=handles.area;
        MOI=handles.MOI; 
end

%%%

I=MOI;
A=area;


mass_per_length=rho*A;

%%%

a=L1;
L=L1+L2;

a_orig=a;
%
b=(L-a);
%
x=0.1+linspace(0,24,1001);
%
a=a/L;
b=1-a;
LL=1;


beam_type=BC;

[beta_L]=find_root_mbeam(x,a,b,beam_type);

beta_L=beta_L';
%
n=length(beta_L);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear x;
%
x=linspace(0,L,501);
%
numx=length(x);
%
y=zeros(numx,n);
%
a=a_orig;
b=L-a;
%
disp(' ');
disp(' Natural Freq (Hz) ');
%
for i=1:4
    beta=beta_L(i)/L;
    omega=beta^2*sqrt(E*I/mass_per_length);
    fn(i)=omega/tpi;
%
    beta_a=beta_L(i)*a/L;
    beta_b=beta_L(i)*b/L;
    [q,C,B]=cpf_C_coefficients(beta_a,beta_b);
%
    for j=1:numx
        if(x(j)<=a)
            W=beta_a*x(j)/a;
            y(j,i)=q(1)*sinh(W)+q(2)*cosh(W)+q(3)*sin(W)+q(4)*cos(W);
        else
            W=beta_b*(x(j)-a)/b;
            y(j,i)=q(5)*sinh(W)+q(6)*cosh(W)+q(7)*sin(W)+q(8)*cos(W);            
        end
    end
%
    Z=max(abs(y(:,i)));
    y(:,i)=y(:,i)/Z;
%
    out1=sprintf(' %8.4g ',fn(i));
    disp(out1);
%
    figure(fig_num);
    plot(x,y(:,i));
    out1=sprintf(' Mode %i  Freq=%8.4g Hz',i,fn(i));
    title(out1);
    ylabel('Modal Displacement');
    
    if(handles.unit==1)    
        xlabel('x(in)');
    else
        xlabel('x(m)');        
    end
    
    grid on;
    axis([0,L,-1.2,1.2]);
    fig_num=fig_num+1;
    ModeShapes(:,i+1)=y(:,i);
end
%
ModeShapes(:,1)=x(:);


set(handles.uipanel_fn,'Visible','on');

    fn_string=sprintf('%8.4g \n%8.4g \n%8.4g \n%8.4g ',fn(1),fn(2),fn(3),fn(4));    
%
    set(handles.Answer,'String',fn_string);
    set(handles.uipanel_fn,'Visible','on'); 



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


% --- Executes on selection change in BClistbox.
function BClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to BClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BClistbox
set(handles.uipanel_fn,'Visible','off');

% --- Executes during object creation, after setting all properties.
function BClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BClistbox (see GCBO)
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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

handles.unit=get(handles.unitslistbox,'Value');
handles.material=get(handles.listbox_material,'Value');

set(handles.uipanel_fn,'Visible','off');
 
material_change(hObject, eventdata, handles);
 
guidata(hObject, handles);


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



function lengtheditbox_1_Callback(hObject, eventdata, handles)
% hObject    handle to lengtheditbox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lengtheditbox_1 as text
%        str2double(get(hObject,'String')) returns contents of lengtheditbox_1 as a double


% --- Executes during object creation, after setting all properties.
function lengtheditbox_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox_1 (see GCBO)
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

handles.unit=get(handles.unitslistbox,'Value');
handles.cross_section=get(handles.crosssectionlistbox,'Value');
guidata(hObject, handles);

set(handles.uipanel_fn,'Visible','off');
geometry_change(hObject, eventdata, handles)


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



function crosssectioneditbox1_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crosssectioneditbox1 as text
%        str2double(get(hObject,'String')) returns contents of crosssectioneditbox1 as a double

handles.thick=0;
handles.diameter=0;
handles.area=0;

string=get(hObject,'String');

handles.cross_section=get(handles.crosssectionlistbox,'Value');

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
string=get(hObject,'String');

handles.cross_section=get(handles.crosssectionlistbox,'Value');

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


% --- Executes on selection change in unitslistbox.
function unitslistbox_Callback(hObject, eventdata, handles)
% hObject    handle to unitslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unitslistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unitslistbox

set(handles.uipanel_fn,'Visible','off');

handles.unit=get(handles.unitslistbox,'Value');

guidata(hObject, handles);

material_change(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);


if(handles.unit==1)
    set(handles.uipanel_lengths,'title','Length (inch)');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (lbf/in^2)');
    set(handles.massdensitylabel,'String','Mass Density (lbm/in^3)');
else
    set(handles.uipanel_lengths,'title','Length (meter)');
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



function lengtheditbox_2_Callback(hObject, eventdata, handles)
% hObject    handle to lengtheditbox_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lengtheditbox_2 as text
%        str2double(get(hObject,'String')) returns contents of lengtheditbox_2 as a double


% --- Executes during object creation, after setting all properties.
function lengtheditbox_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function geometry_change(hObject, eventdata, handles)        

handles.unit=get(handles.unitslistbox,'Value');
handles.cross_section=get(handles.crosssectionlistbox,'Value');

set(handles.crosssectioneditbox2,'Enable','on');

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

% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function material_change(hObject, eventdata, handles)


handles.material=get(handles.listbox_material,'Value');

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


% --- Executes on key press with focus on crosssectioneditbox1 and none of its controls.
function crosssectioneditbox1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');


% --- Executes on key press with focus on crosssectioneditbox2 and none of its controls.
function crosssectioneditbox2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');


% --- Executes on key press with focus on lengtheditbox_1 and none of its controls.
function lengtheditbox_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox_1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');


% --- Executes on key press with focus on lengtheditbox_2 and none of its controls.
function lengtheditbox_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox_2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');


% --- Executes on key press with focus on elasticmoduluseditbox and none of its controls.
function elasticmoduluseditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');


% --- Executes on key press with focus on massdensityeditbox and none of its controls.
function massdensityeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');
