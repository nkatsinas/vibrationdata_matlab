function varargout = multispan_beam_bends_FEA2(varargin)
% MULTISPAN_BEAM_BENDS_FEA2 MATLAB code for multispan_beam_bends_FEA2.fig
%      MULTISPAN_BEAM_BENDS_FEA2, by itself, creates a new MULTISPAN_BEAM_BENDS_FEA2 or raises the existing
%      singleton*.
%
%      H = MULTISPAN_BEAM_BENDS_FEA2 returns the handle to a new MULTISPAN_BEAM_BENDS_FEA2 or the handle to
%      the existing singleton*.
%
%      MULTISPAN_BEAM_BENDS_FEA2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTISPAN_BEAM_BENDS_FEA2.M with the given input arguments.
%
%      MULTISPAN_BEAM_BENDS_FEA2('Property','Value',...) creates a new MULTISPAN_BEAM_BENDS_FEA2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multispan_beam_bends_FEA2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multispan_beam_bends_FEA2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multispan_beam_bends_FEA2

% Last Modified by GUIDE v2.5 25-Jun-2021 12:07:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multispan_beam_bends_FEA2_OpeningFcn, ...
                   'gui_OutputFcn',  @multispan_beam_bends_FEA2_OutputFcn, ...
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


% --- Executes just before multispan_beam_bends_FEA2 is made visible.
function multispan_beam_bends_FEA2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multispan_beam_bends_FEA2 (see VARARGIN)

% Choose default command line output for multispan_beam_bends_FEA2
handles.output = hObject;

set(handles.calculatebutton,'Enable','off');

listbox_numi_Callback(hObject, eventdata, handles);

listbox_configuration_Callback(hObject, eventdata, handles);

set(handles.unitslistbox,'Value',1,'Enable','off');


set(handles.pushbutton_base_psd,'Enable','off');




set(handles.crosssectionlistbox,'Value',1);
set(handles.materiallistbox,'Value',1);

clear_buttons(hObject, eventdata, handles);


clc;
axes(handles.axes1);
bg = imread('beam_image_2.jpg');
image(bg);
axis off; 


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
handles.n=4;
 
handles.mode_number=1;
 
setappdata(0,'fig_num',1);
 

% set(handles.edit_neutral_axis,'Visible','off');
% set(handles.text_neutral_axis,'Visible','off');


% Update handles structure
guidata(hObject, handles);
 
material_change(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);
unitslistbox_Callback(hObject, eventdata, handles);


% UIWAIT makes multispan_beam_bends_FEA2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = multispan_beam_bends_FEA2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculatebutton.
function calculatebutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculatebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% set(handles.edit_neutral_axis,'Visible','on');
% set(handles.text_neutral_axis,'Visible','on');
 
xx=getappdata(0,'xx');
L=getappdata(0,'L');
cdof=getappdata(0,'cdof');
total_ne=getappdata(0,'total_ne');

handles.cross_section=get(handles.crosssectionlistbox,'Value');
handles.unit=get(handles.unitslistbox,'Value');
 
iu=1;
handles.unit=iu;
 
E=str2num(get(handles.elasticmoduluseditbox,'String'));
rho=str2num(get(handles.massdensityeditbox,'String'));
 
mu=str2num(get(handles.edit_mu,'String'));
G=E/(2*(1+mu));
 
nsm=str2num(get(handles.edit_nsm,'String'));
 
LBC=get(handles.leftBClistbox,'Value');
RBC=get(handles.rightBClistbox,'Value');
 
fprintf('\n  E=%8.4g   rho=%8.4g   nsm=%8.4g\n',E,rho,nsm);
fprintf(' LBC=%d RBC=%d \n',LBC,RBC);
   
    if(handles.unit==1) % English
        rho=rho/386;
        nsm=nsm/386;
    else                % metric
        [E]=GPa_to_Pa(E);
        thick=thick/1000;
        width=width/1000;
        diameter=diameter/1000;
        wall_thick=wall_thick/1000;
    end
    
    setappdata(0,'rho',rho);
    setappdata(0,'cross_section',handles.cross_section);
    
    setappdata(0,'unit',handles.unit);
 
    box1=str2num(get(handles.crosssectioneditbox1,'String'));
    box2=str2num(get(handles.crosssectioneditbox2,'String'));
    get(handles.crosssectioneditbox2,'String');
 
 
    handles.cross_section=get(handles.crosssectionlistbox,'Value');
 
    setappdata(0,'cross',handles.cross_section);
    
    if(handles.cross_section==1) % rectangular,
        
        thick=box1;
        width=box2;
        
        if(thick>width)
            warndlg('Thickness > Width');
        end
        [area,MOI,cna]=beam_rectangular_geometry(width,thick); 
        setappdata(0,'cnaz',cna)
        setappdata(0,'cnax',width*0.5)
        Iyy=(1/12)*width*(thick^3);
        Izz=(1/12)*thick*(width^3);
        J=Iyy+Izz;  % perpendicular axis theorem        
    end
    if(handles.cross_section==2) % pipe
        diameter=box1;
        wall_thick=box2;
        [area,MOI,cna]=pipe_geometry_wall(diameter,wall_thick); 
        setappdata(0,'cna',cna)
        Iyy=MOI;
        Izz=Iyy;
        J=Iyy+Izz;  % perpendicular axis theorem
    end
    if(handles.cross_section==3) % solid cylinder
        diameter=box1;
        [area,MOI,cna]=cylinder_geometry(diameter);
        setappdata(0,'cna',cna)
        Iyy=(pi/64)*(diameter^4);
        Izz=Iyy;
        J=Iyy+Izz;  % perpendicular axis theorem
    end
 
if isempty(area)
    warndlg('Enter Cross Section dimensions');
    return;
end
if isempty(J)
    warndlg('Enter Cross Section dimensions');
    return;
end


mass_per_length=rho*area+(nsm/L);   % mass per unit length
    
tmass=mass_per_length*L;
   
fprintf('\n Total mass = %8.4g lbm \n',tmass*386);

rho=tmass/(area*L);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_nodes=length(xx(:,1));

nodex=xx(:,1);
nodey=xx(:,2);
nodez=zeros(num_nodes,1);

setappdata(0,'nodex',nodex);
setappdata(0,'nodey',nodey);
setappdata(0,'nodez',nodez);

nnum=length(nodex);
ndof=nnum*6;
Stiff=zeros(ndof,ndof);
Mass =zeros(ndof,ndof);
%
disp(' ');
disp('       Node Table ');
disp(' Number     X       Y  ');
%
for(i=1:nnum)
    fprintf(' %4d  %8.3f  %8.3f \n',i,nodex(i),nodey(i));
end
%

% element table

node1=zeros(total_ne,1);
node2=zeros(total_ne,2);

for i=1:num_nodes-1
    node1(i)=i;
    node2(i)=i+1;
end

setappdata(0,'node1',node1);
setappdata(0,'node2',node2);
    
enum=length(node1);
%
disp(' ');
disp('       Element Table ');
disp('   Number    N1    N2   Length');
%
LEN=zeros(enum,1);

for i=1:enum
    dx=nodex(node1(i))-nodex(node2(i));
    dy=nodey(node1(i))-nodey(node2(i));
    dz=nodez(node1(i))-nodez(node2(i));
    LEN(i)=sqrt(dx^2+dy^2+dz^2);
    fprintf('    %4d   %4d    %4d  %7.3f \n',i,node1(i),node2(i),LEN(i));
end

A=area;

ndof=num_nodes*6;

[Mass,Stiff,theta]=mass_stiffness_matrices(enum,ndof,LEN,rho,E,G,Iyy,Izz,J,A,nodex,nodey,nodez,node1,node2);
setappdata(0,'theta',theta);

stiff_unc=Stiff;
 mass_unc=Mass;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    cdof=unique(cdof);
    cdof=sort(cdof);
    temp=cdof(end:-1:1);
    cdof=temp;
    num_con=length(cdof);
    
    setappdata(0,'cdof',cdof);
%
%   Apply constraints to global matrices
%
    for i=1:num_con
        Stiff(cdof(i),:)=[];
        Stiff(:,cdof(i))=[];
        Mass(cdof(i),:)=[];
        Mass(:,cdof(i))=[];
    end

    
% dof=total degrees-of-freedom for constrained system    

sz=size(Mass);
dof=sz(1);
setappdata(0,'dof',dof);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[fn,~,ModeShapes,~]=Generalized_Eigen(Stiff,Mass,2);

fn=abs(fn);

NJ=min([16 length(fn)]);

disp(' ');
disp('Mode   fn(Hz)');

for i=1:NJ
    fprintf(' %d  %8.4g \n',i,fn(i));
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


setappdata(0,'stiff_unc',stiff_unc);
setappdata(0,'mass_unc',mass_unc);

setappdata(0,'stiff',Stiff);
setappdata(0,'mass',Mass);

setappdata(0,'fn_full',fn);
setappdata(0,'fn',fn);
setappdata(0,'ModeShapes_full',ModeShapes);
setappdata(0,'ModeShapes',ModeShapes);

%
setappdata(0,'rho',rho);
setappdata(0,'E',E);
setappdata(0,'I',MOI);    
setappdata(0,'cna',cna); 
setappdata(0,'area',area);  
setappdata(0,'LEN',LEN); 

enum=getappdata(0,'total_ne');
setappdata(0,'num_elem',enum);

%%%%%%%%%%%%%%%%%%

if(length(fn)>=12)
    setappdata(0,'fn',fn(1:12));    
    setappdata(0,'ModeShapes',ModeShapes(:,1:12));    
else
    setappdata(0,'fn',fn);
    setappdata(0,'ModeShapes',ModeShapes);    
end

setappdata(0,'LBC',LBC);
setappdata(0,'RBC',RBC);
setappdata(0,'dx',dx);
setappdata(0,'L',L);

set(handles.pushbutton_view_mode_shapes,'Visible','on');
set(handles.uipanel_mode_number,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn=fix_size(fn);

disp(' ');
disp(' Output arrays saved as: ');
disp(' ');
disp('    beam_fn ');
disp('    beam_modeshapes ');

disp(' ');
disp(' Mass & Stiffness arrays saved as:  ');
disp(' ');
disp('    beam_mass');
disp('    beam_stiffness');

assignin('base', 'beam_fn', fn);
assignin('base', 'beam_modeshapes', ModeShapes);

assignin('base', 'beam_stiffness', Stiff);
assignin('base', 'beam_mass', Mass);

assignin('base', 'beam_stiffness_unc', stiff_unc);
assignin('base', 'beam_mass_unc', mass_unc);

set(handles.pushbutton_base_psd,'Enable','on');

msgbox('Natural Frequencies written to Command Window');


setappdata(0,'xx',xx);
setappdata(0,'ne',total_ne);
setappdata(0,'L',L);
% setappdata(0,'dof_status',dof_status);

set(handles.calculatebutton,'Enable','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
% --- Executes on selection change in leftBClistbox.
function leftBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns leftBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from leftBClistbox
clear_buttons(hObject, eventdata, handles);

set(handles.pushbutton_base_psd,'Enable','off');

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


% --- Executes on selection change in crosssectionlistbox.
function crosssectionlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectionlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns crosssectionlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from crosssectionlistbox

clear_buttons(hObject, eventdata, handles);
handles.cross_section=get(hObject,'Value');
guidata(hObject, handles);
geometry_change(hObject, eventdata, handles)

set(handles.pushbutton_base_psd,'Enable','off');


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

clear_buttons(hObject, eventdata, handles);
set(handles.pushbutton_base_psd,'Enable','off');

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



function crosssectioneditbox2_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crosssectioneditbox2 as text
%        str2double(get(hObject,'String')) returns contents of crosssectioneditbox2 as a double

clear_buttons(hObject, eventdata, handles);
set(handles.pushbutton_base_psd,'Enable','off');

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


% --- Executes on selection change in materiallistbox.
function materiallistbox_Callback(hObject, eventdata, handles)
% hObject    handle to materiallistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns materiallistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from materiallistbox
clear_buttons(hObject, eventdata, handles);
handles.material=get(hObject,'Value');
material_change(hObject, eventdata, handles);
guidata(hObject, handles);

set(handles.pushbutton_base_psd,'Enable','off');

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

clear_buttons(hObject, eventdata, handles);
set(handles.pushbutton_base_psd,'Enable','off');

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

set(handles.pushbutton_base_psd,'Enable','off');
clear_buttons(hObject, eventdata, handles);

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




function lengtheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lengtheditbox as text
%        str2double(get(hObject,'String')) returns contents of lengtheditbox as a double
clear_buttons(hObject, eventdata, handles);
set(handles.pushbutton_base_psd,'Enable','off');

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

clear_buttons(hObject, eventdata, handles);

handles.unit=get(handles.unitslistbox,'Value');

guidata(hObject, handles);

material_change(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);
listbox_numi_Callback(hObject, eventdata, handles);

if(handles.unit==1)
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (lbf/in^2)');
    set(handles.massdensitylabel,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_nsm,'String','lbm');      
else
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (GPa)'); 
    set(handles.massdensitylabel,'String','Mass Density (kg/m^3)');
    set(handles.text_nsm,'String','kg'); 
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



function edit_k2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_k2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_k2 as text
%        str2double(get(hObject,'String')) returns contents of edit_k2 as a double
clear_buttons(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_k2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_k2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_k1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_k1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_k1 as text
%        str2double(get(hObject,'String')) returns contents of edit_k1 as a double
clear_buttons(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_k1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_k1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rightBClistbox.
function rightBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rightBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rightBClistbox
clear_buttons(hObject, eventdata, handles);
set(handles.pushbutton_base_psd,'Enable','off');

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


function geometry_change(hObject, eventdata, handles)

% set(handles.edit_neutral_axis,'Visible','off');
% set(handles.edit_neutral_axis,'String','');
% set(handles.edit_neutral_axis,'Enable','off');

% set(handles.text_neutral_axis,'Visible','off');

handles.unit=1;
handles.cross_section=get(handles.crosssectionlistbox,'Value');

set(handles.crosssectioneditbox2,'Enable','on');

% if(handles.cross_section==4) % other
%    set(handles.edit_neutral_axis,'Visible','on');
%    set(handles.edit_neutral_axis,'Enable','on');    
%    set(handles.text_neutral_axis,'Visible','on');
% end

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
%        set(handles.text_neutral_axis,'String','Distance from Neutral Axis (inches)');
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
%        set(handles.text_neutral_axis,'String','Distance from Neutral Axis (mm)');        
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


handles.material=get(handles.materiallistbox,'Value');
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
function listbox6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ne.
function listbox_ne_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ne contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ne
clear_buttons(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_ne_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function clear_buttons(hObject, eventdata, handles)
%

set(handles.pushbutton_view_mode_shapes,'Visible','off');
set(handles.uipanel_mode_number,'Visible','off');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(multispan_beam_FEA);

% --- Executes on button press in pushbutton_view_mode_shapes.
function pushbutton_view_mode_shapes_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_mode_shapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

scale=str2num(get(handles.edit_scale,'String'));

kjv=get(handles.listbox_mode_number,'Value');

nodex=getappdata(0,'nodex');
nodey=getappdata(0,'nodey');
nodez=getappdata(0,'nodez');

node1=getappdata(0,'node1');
node2=getappdata(0,'node2');

enum=getappdata(0,'total_ne');
cdof=getappdata(0,'cdof');
nnum=length(nodex);

ModeShapes=getappdata(0,'ModeShapes');
fn=getappdata(0,'fn');


figure(10);
plot3(nodex,nodey,nodez,'bs');
hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
for i=1:length(node1)
  x=[nodex(node1(i)),nodex(node2(i))];
  y=[nodey(node1(i)),nodey(node2(i))];
  z=[nodez(node1(i)),nodez(node2(i))];
  plot3(x,y,z,'b');    
end
%
max_ux=max(nodex);
max_uy=max(nodey);
max_uz=max(nodez);
min_ux=min(nodex);
min_uy=min(nodey);
min_uz=min(nodez);
%
distance_u=sqrt( (max_ux-min_ux)^2 + (max_uy-min_uy)^2 + (max_uz-min_uz)^2 );
%
ux=max_ux-min_ux;
uy=max_uy-min_uy;
uz=max_uz-min_uz;
%
avex=(max_ux+min_ux)/2;
avey=(max_uy+min_uy)/2;
avez=(max_uz+min_uz)/2;
%
ddd=[ux,uy,uz];
dmax=max(ddd);
dmax=dmax*1.2;
%
xmin=avex-dmax/2;
xmax=avex+dmax/2;
ymin=avey-dmax/2;
ymax=avey+dmax/2;
zmin=avez-dmax/2;
zmax=avez+dmax/2;
%
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
%
clear MS;
j=1;
sz=max(size(cdof));
dof=nnum*6;
for k=1:dof
%    
    iflag=0;
    for i=1:sz
        if(k==cdof(i))
            iflag=1;
            break;
        end
    end
%
    if(iflag==1)
        MS(k)=0;
    else
        MS(k)=ModeShapes(j,kjv);
        j=j+1;
    end
%        
end
%
j=1;
clear mx;
clear my;
clear mz;
mx=zeros(nnum,1);
my=zeros(nnum,1);
mz=zeros(nnum,1);
%
for(i=1:nnum)
    mx(i)=scale*MS(j);
    my(i)=scale*MS(j+1);
    mz(i)=scale*MS(j+2);
    j=j+6;
end
sz=size(nodex);
if(sz(2)>sz(1))
  nodex=nodex';
  nodey=nodey';
  nodez=nodez';
end
%
mx=mx+nodex;
my=my+nodey;
mz=mz+nodez;
%
nodexx=mx;
nodeyy=my;
nodezz=mz;
%
%****** Find Scale **************************************
%
if( abs(scale-1)<0.01)
%    
    max_mx=max(mx);
    max_my=max(my);
    max_mz=max(mz);
%
    min_mx=min(mx);
    min_my=min(my);
    min_mz=min(mz);
%
    distance_m=sqrt( (max_mx-min_mx)^2 + (max_my-min_my)^2 + (max_mz-min_mz)^2 );
    scale=(distance_u/distance_m);    
%
    j=1;
    for i=1:length(mx)
        mx(i)=scale*MS(j);
        my(i)=scale*MS(j+1);
        mz(i)=scale*MS(j+2);
        j=j+6;
    end
    sz=size(nodex);
    if(sz(2)>(1))
        nodex=nodex';
        nodey=nodey';
        nodez=nodez';
    end
%
    mx=mx+nodex;
    my=my+nodey;
    mz=mz+nodez;
%
    nodexx=mx;
    nodeyy=my;
    nodezz=mz;
end    
%
%
%**********************************************************
%
plot3(mx,my,mz,'r-*'); 
for i=1:length(node1)
  x=[nodexx(node1(i)),nodexx(node2(i))];
  y=[nodeyy(node1(i)),nodeyy(node2(i))];
  z=[nodezz(node1(i)),nodezz(node2(i))];
  plot3(x,y,z,'r');     
end
%
max_nx=max(nodexx);
max_ny=max(nodeyy);
max_nz=max(nodezz);
min_nx=min(nodexx);
min_ny=min(nodeyy);
min_nz=min(nodezz);
dx=max_nx-min_nx;
dy=max_ny-min_ny;
dz=max_nz-min_nz;
%
avex=(max_nx+min_nx)/2;
avey=(max_ny+min_ny)/2;
avez=(max_nz+min_nz)/2;
%
ddd=[dx,dy,dz,ux,uy,uz];
dmax=max(ddd);
dmax=dmax*1.2;
%
xmin=avex-dmax/2;
xmax=avex+dmax/2;
ymin=avey-dmax/2;
ymax=avey+dmax/2;
zmin=avez-dmax/2;
zmax=avez+dmax/2;
%
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
%
out1=sprintf(' Mode %d   fn=%8.4g Hz',kjv,fn(kjv));
title(out1);
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',12);
hold off;



% --- Executes on selection change in listbox_mode_number.
function listbox_mode_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mode_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mode_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mode_number


% --- Executes during object creation, after setting all properties.
function listbox_mode_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mode_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_damping.
function pushbutton_damping_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=generic_damping;    
set(handles.s,'Visible','on'); 

set(handles.pushbutton_transfer,'Visible','on');



% --- Executes on button press in pushbutton_transfer.
function pushbutton_transfer_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_transfer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=beam_spring_force_frf;    
set(handles.s,'Visible','on'); 



function edit_nsm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nsm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nsm as text
%        str2double(get(hObject,'String')) returns contents of edit_nsm as a double


% --- Executes during object creation, after setting all properties.
function edit_nsm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nsm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_sine.
function pushbutton_sine_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=beam_spring_sine;    
set(handles.s,'Visible','on'); 



function edit_pml1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pml1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pml1 as text
%        str2double(get(hObject,'String')) returns contents of edit_pml1 as a double


% --- Executes during object creation, after setting all properties.
function edit_pml1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pml1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pm1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pm1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pm1 as text
%        str2double(get(hObject,'String')) returns contents of edit_pm1 as a double


% --- Executes during object creation, after setting all properties.
function edit_pm1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pm1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pml2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pml2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pml2 as text
%        str2double(get(hObject,'String')) returns contents of edit_pml2 as a double


% --- Executes during object creation, after setting all properties.
function edit_pml2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pml2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pml3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pml3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pml3 as text
%        str2double(get(hObject,'String')) returns contents of edit_pml3 as a double


% --- Executes during object creation, after setting all properties.
function edit_pml3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pml3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pm2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pm2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pm2 as text
%        str2double(get(hObject,'String')) returns contents of edit_pm2 as a double


% --- Executes during object creation, after setting all properties.
function edit_pm2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pm2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pm3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pm3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pm3 as text
%        str2double(get(hObject,'String')) returns contents of edit_pm3 as a double


% --- Executes during object creation, after setting all properties.
function edit_pm3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pm3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_npm.
function listbox_npm_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_npm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_npm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_npm


n=get(handles.listbox_npm,'Value');
n=n-1;

if(n==0)
    set(handles.text_pmloc,'Visible','off');
    set(handles.text_pm,'Visible','off');
else
    set(handles.text_pmloc,'Visible','on');
    set(handles.text_pm,'Visible','on');    
end    

set(handles.edit_pm1,'Visible','off');
set(handles.edit_pm2,'Visible','off');
set(handles.edit_pm3,'Visible','off');

set(handles.edit_pml1,'Visible','off');
set(handles.edit_pml2,'Visible','off');
set(handles.edit_pml3,'Visible','off');

if(n>=1)
    set(handles.edit_pm1,'Visible','on');
    set(handles.edit_pml1,'Visible','on');    
end
if(n>=2)
    set(handles.edit_pm2,'Visible','on');
    set(handles.edit_pml2,'Visible','on');     
end
if(n==3)
    set(handles.edit_pm3,'Visible','on');
    set(handles.edit_pml3,'Visible','on');     
end
    






% --- Executes during object creation, after setting all properties.
function listbox_npm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_npm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox_numi.
function listbox_numi_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numi contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numi

n=get(handles.listbox_numi,'Value');

iu=get(handles.unitslistbox,'Value');

n=n-1;

if(n==0)
    
    set(handles.uitable_coordinates,'Visible','off'); 
    set(handles.text_coordinates,'Visible','off');     
else    
    
    set(handles.uitable_coordinates,'Visible','on');  
    set(handles.text_coordinates,'Visible','on');

    for i = 1:n
        for j=1:2
            data_s{i,j} = ''; 
        end    
    end
    
    cn={'X','Y'};
    set(handles.uitable_coordinates,'Data',data_s,'ColumnName',cn)

end

set(handles.pushbutton_base_psd,'Enable','off');
set(handles.pushbutton_base_psd,'Enable','off');

% --- Executes during object creation, after setting all properties.
function listbox_numi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ns_elements_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ns_elements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ns_elements as text
%        str2double(get(hObject,'String')) returns contents of edit_ns_elements as a double
set(handles.pushbutton_base_psd,'Enable','off');

% --- Executes during object creation, after setting all properties.
function edit_ns_elements_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ns_elements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_base_psd.
function pushbutton_base_psd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_base_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cross_section=get(handles.crosssectionlistbox,'Value');

if(handles.cross_section==4)
    msgbox('Base excitation unavailable for this case');
else

    handles.s=mspan_bends_base_input_psd; 
    set(handles.s,'Visible','on');
end

% --- Executes on key press with focus on edit_ns_elements and none of its controls.
function edit_ns_elements_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ns_elements (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_base_psd,'Enable','off');


% --- Executes on key press with focus on lengtheditbox and none of its controls.
function lengtheditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_base_psd,'Enable','off');


% --- Executes on key press with focus on elasticmoduluseditbox and none of its controls.
function elasticmoduluseditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_base_psd,'Enable','off');


% --- Executes on key press with focus on massdensityeditbox and none of its controls.
function massdensityeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_base_psd,'Enable','off');


% --- Executes on key press with focus on crosssectioneditbox1 and none of its controls.
function crosssectioneditbox1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_base_psd,'Enable','off');


% --- Executes on key press with focus on crosssectioneditbox2 and none of its controls.
function crosssectioneditbox2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_base_psd,'Enable','off');


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    LBC=get(handles.leftBClistbox,'Value');
    multispan_beam_FEA.LBC=LBC;
catch
end
try
    RBC=get(handles.rightBClistbox,'Value');
    multispan_beam_FEA.RBC=RBC;
catch
end


try
    nsm=get(handles.edit_nsm,'String');
    multispan_beam_FEA.nsm=nsm;
catch
end
try
    numi=get(handles.listbox_numi,'Value');
    multispan_beam_FEA.numi=numi;
catch
end

try
    config=get(handles.listbox_configuration,'Value');
    multispan_beam_FEA.config=config;
catch
end
try
    data=get(handles.uitable_data,'data');
    multispan_beam_FEA.data=data;
catch
end
try
    coordinates=get(handles.uitable_coordinates,'data');
    multispan_beam_FEA.coordinates=coordinates;
catch
end

try    
    bend_elements=get(handles.uitable_bend_elements,'data');
    multispan_beam_FEA.bend_elements=bend_elements;
catch
end

try
    ns_elements=get(handles.edit_ns_elements,'String');
    multispan_beam_FEA.ns_elements=ns_elements;
catch
end
try
    cross=get(handles.crosssectionlistbox,'Value');
    multispan_beam_FEA.cross=cross;
catch
end
try
    box1=get(handles.crosssectioneditbox1,'String');
    multispan_beam_FEA.box1=box1;
catch
end
try
    box2=get(handles.crosssectioneditbox2,'String');
    multispan_beam_FEA.box2=box2;
catch
end

%

try
    mat=get(handles.materiallistbox,'Value');
    multispan_beam_FEA.mat=mat;
catch
end
try
    E=get(handles.elasticmoduluseditbox,'String');
    multispan_beam_FEA.E=E;
catch
end
try
    rho=get(handles.massdensityeditbox,'String');
    multispan_beam_FEA.rho=rho;
catch
end
try
    mu=get(handles.edit_mu,'String');
    multispan_beam_FEA.mu=mu;
catch
end


% % %
 
 structnames = fieldnames(multispan_beam_FEA, '-full'); % fields in the struct
  
% % %
 
    [writefname, writepname] = uiputfile('*.mat','Save data as');
   
    elk=sprintf('%s%s',writepname,writefname);

try
    save(elk, 'multispan_beam_FEA'); 
catch
    warndlg('Save error');
    return;
end
 
disp(' ');
out1=sprintf('Save Complete: %s',writefname);
disp(out1);
msgbox(out1);




% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat', 'Select plot save file');

NAME = [pathname,filename];

struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try
   multispan_beam_FEA=evalin('base','multispan_beam_FEA');
catch
   warndlg(' evalin failed ');
   setappdata(0,'eflag',1);   
   return;
end

%%%%%%%%%%%%

%%%%%

try
    LBC=multispan_beam_FEA.LBC;
    set(handles.leftBClistbox,'Value',LBC);
catch
end
try
    RBC=multispan_beam_FEA.RBC;    
    set(handles.rightBClistbox,'Value',RBC);
catch
end

try
    mu=multispan_beam_FEA.mu;    
    set(handles.lengtheditbox,'String',mu);
catch
end
try
    nsm=multispan_beam_FEA.nsm;    
    set(handles.edit_nsm,'String',nsm);
catch
end
try
    numi=multispan_beam_FEA.numi;    
    set(handles.listbox_numi,'Value',numi);
catch
end
try
    ns_elements=multispan_beam_FEA.ns_elements;    
    set(handles.edit_ns_elements,'String',ns_elements);
catch
end
try
    cross=multispan_beam_FEA.cross;    
    set(handles.crosssectionlistbox,'Value',cross);
catch
end

try    
    bend_elements=multispan_beam_FEA.bend_elements;    
    set(handles.uitable_bend_elements,'data',bend_elements);
catch
end


%

try
    mat=multispan_beam_FEA.mat;    
    set(handles.materiallistbox,'Value',mat);
catch
end


listbox_numi_Callback(hObject, eventdata, handles);



try
    config=multispan_beam_FEA.config;    
    set(handles.listbox_configuration,'Value',config);
catch
end
try
    data=multispan_beam_FEA.data;    
    set(handles.uitable_data,'data',data);
catch
end
try
    coordinates=multispan_beam_FEA.coordinates;    
    set(handles.uitable_coordinates,'data',coordinates);
catch
end




try
    E=multispan_beam_FEA.E;    
    set(handles.elasticmoduluseditbox,'String',E);
catch
end
try
    rho=multispan_beam_FEA.rho;    
    set(handles.massdensityeditbox,'String',rho);
catch
end

crosssectionlistbox_Callback(hObject, eventdata, handles);
materiallistbox_Callback(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);

try
    box1=multispan_beam_FEA.box1;    
    set(handles.crosssectioneditbox1,'String',box1);
catch
end
try
    box2=multispan_beam_FEA.box2;    
    set(handles.crosssectioneditbox2,'String',box2);
catch
end

listbox_configuration_Callback(hObject, eventdata, handles);


% --- Executes on selection change in listbox_configuration.
function listbox_configuration_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_configuration contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_configuration

set(handles.calculatebutton,'Enable','off');

n=get(handles.listbox_configuration,'Value');

set(handles.uipanel_bend_elements,'Visible','on');

N_bend_rows=0;

if(n==1)
    m=1;
    set(handles.uipanel_bend_elements,'Visible','off');
end

m=n;
N_bend_rows=n-1;

N_straight_rows=n;
 
A=get(handles.uitable_data,'Data');
B=get(handles.uitable_bend_elements,'Data');

for i=1:N_straight_rows
    data_s{i,1}='';
    data_s{i,2}='';
    data_s{i,3}='';        
    data_s{i,4}='';
    data_s{i,5}='';    
end

for i=1:N_bend_rows
    data_b{i,1}='';    
end

if(~isempty(A))
    
    sz=size(A);
    Arows=sz(1);  
    Ncolumns=sz(2);
    
    M=min([ Arows N_straight_rows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end

if(~isempty(B))
    
    sz=size(B);
    Brows=sz(1);    
    
    M=min([ Brows N_bend_rows ]);

    for i=1:M
        data_b{i,1}=B{i,1};  
    end   
    for i=M+1:N_bend_rows
        data_b{i,1}=[];
    end
 
end


try
    set(handles.uitable_data,'Data',data_s);
catch
end
try
    cn={'Num of Elements'};
    set(handles.uitable_bend_elements,'Data',data_b,'ColumnName',cn);
catch
end    



% --- Executes during object creation, after setting all properties.
function listbox_configuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bend_elem_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bend_elem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bend_elem as text
%        str2double(get(hObject,'String')) returns contents of edit_bend_elem as a double


% --- Executes during object creation, after setting all properties.
function edit_bend_elem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bend_elem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit34 as text
%        str2double(get(hObject,'String')) returns contents of edit34 as a double


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
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


% --- Executes on button press in pushbutton_display.
function pushbutton_display_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    

disp(' ');
disp(' * * * * * * * * * ');
disp(' ');

setappdata(0,'fig_num',1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A=char(get(handles.uitable_data,'Data'));

N=get(handles.listbox_configuration,'Value');

x1=zeros(N,1);
y1=zeros(N,1);
x2=zeros(N,1);
y2=zeros(N,1);
ns_elem=zeros(N,1);

k=1;

for i=1:N
    aaa=A(k,:); k=k+1;
    aaa = strtrim(aaa);
    x1(i)=str2double(aaa);
end 
for i=1:N
    aaa=A(k,:); k=k+1;
    aaa = strtrim(aaa);
    y1(i)=str2double(aaa);
end
for i=1:N
    aaa=A(k,:); k=k+1;
    aaa = strtrim(aaa);
    x2(i)=str2double(aaa);
end 
for i=1:N
    aaa=A(k,:); k=k+1;
    aaa = strtrim(aaa);
    y2(i)=str2double(aaa);
end
for i=1:N
    aaa=A(k,:); k=k+1;
    aaa = strtrim(aaa);
    ns_elem(i)=str2double(aaa);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if(N==1)
    nb_elem=0;
else
    A=char(get(handles.uitable_bend_elements,'Data'));

    sz=size(A);

    NB=sz(1);
    nb_elem=zeros(NB,1);

    k=1;

    for i=1:NB
        aaa=A(k,:); k=k+1;
        aaa = strtrim(aaa);
        nb_elem(i)=str2double(aaa);
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numi=get(handles.listbox_numi,'Value');

numi=numi-1;

if(numi>=1)
    
    A=char(get(handles.uitable_coordinates,'Data'));
   
    xp=zeros(numi,1);
    yp=zeros(numi,1);
  
    k=1;
    for i=1:numi
        aaa=A(k,:); k=k+1;
        aaa = strtrim(aaa);
        xp(i)=str2double(aaa);
    end
    for i=1:numi     
        aaa=A(k,:); k=k+1;
        aaa = strtrim(aaa);
        yp(i)=str2double(aaa);
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% N=1 straight
% N=2 straight-bend-straight
% N=3 straight-bend-straight-bend-straight
% N=4 straight-bend-straight-bend-straight-bend-straight

total_ne=sum(ns_elem)+sum(nb_elem);

setappdata(0,'total_ne',total_ne);

xx=zeros((total_ne+1),2);

k=1;
L=0;

[k,L,xx]=straight(k,L,xx,x1,x2,y1,y2,ns_elem,1);  % straight 1

for i=2:N
    [k,L,xx]=bend(k,L,xx,x1,x2,y1,y2,nb_elem,i-1);   
    [k,L,xx]=straight(k,L,xx,x1,x2,y1,y2,ns_elem,i);     
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_nodes=length(xx);

%   Value=0 for fixed
%         1 for free

pinned_node=zeros(numi,1);

nL=0;
nR=0;

LBC=get(handles.leftBClistbox,'Value');
RBC=get(handles.rightBClistbox,'Value');

if(LBC==2)
   nL=3;
end
if(LBC==3)
   nL=6;
end

if(RBC==2)
   nR=3;
end
if(RBC==3)
   nR=6;
end

tnc=(3*numi)+nL+nR;

cdof=zeros(tnc,1);

k=1;

% Left BC

if(LBC>=2)
    ncon=1;
    cdof(k)=ncon*6-5;
    k=k+1;
    cdof(k)=ncon*6-4;
    k=k+1;    
    cdof(k)=ncon*6-3;
    k=k+1;
    
    if(LBC==3)
        cdof(k)=ncon*6-2;
        k=k+1;
        cdof(k)=ncon*6-1;
        k=k+1;    
        cdof(k)=ncon*6;
        k=k+1;        
    end    
end

% Right BC

if(RBC>=2)
    ncon=num_nodes;
    cdof(k)=ncon*6-5;
    k=k+1;
    cdof(k)=ncon*6-4;
    k=k+1;    
    cdof(k)=ncon*6-3;
    k=k+1;  

    if(RBC==3)
        cdof(k)=ncon*6-2;
        k=k+1;
        cdof(k)=ncon*6-1;
        k=k+1;    
        cdof(k)=ncon*6;
        k=k+1;        
    end    
end

% Intermediate Pinned
for i=1:numi
    D=zeros(num_nodes,1);
    
    for j=1:num_nodes
        D(j)=norm([ xx(j,1)-xp(i) , xx(j,2)-yp(i) ]);
    end
    
    [~,I] = min(D);
    
    pinned_node(i)=I;
    ncon=I;
    
    cdof(k)=ncon*6-5;
    k=k+1;
    cdof(k)=ncon*6-4;
    k=k+1;    
    cdof(k)=ncon*6-3;
    k=k+1;
end


for i=1:num_nodes
    cdof(k)=6*i-4; % Ty
    k=k+1;
    cdof(k)=6*i-5; % Tx
    k=k+1;
    cdof(k)=6*i-2; % Rx
    k=k+1;
    cdof(k)=6*i; % Rz
    k=k+1;    
end    

cdof=unique(sort(cdof));
setappdata(0,'cdof',cdof);


dof_status=ones(num_nodes,6);
% 0 fixed
% 1 free


k=1;

for i=1:num_nodes
    for j=1:6
        if(ismember(k,cdof))
%            fprintf(' i=%d j=%d k=%d \n',i,j,k);
            dof_status(i,j)=0;
        end
        k=k+1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
plot(xx(:,1),xx(:,2));
grid on;
xlabel('X (in)');
ylabel('Y (in)');
title('Elements');

setappdata(0,'xx',xx);
setappdata(0,'ne',total_ne);
setappdata(0,'L',L);

figure(2)
plot(xx(:,1),xx(:,2),xx(:,1),xx(:,2),'o','MarkerSize',3);
grid on;
xlabel('X (in)');
ylabel('Y (in)');
title('Elements & Nodes');

setappdata(0,'xx',xx);
setappdata(0,'ne',total_ne);
setappdata(0,'L',L);

figure(3)
hold on
plot(xx(:,1),xx(:,2),xx(:,1),xx(:,2),'o','MarkerSize',3);
for i=1:numi
    j=pinned_node(i);
    plot(xx(j,1),xx(j,2),'kx','MarkerSize',10);    
end
if(LBC==2)
   plot(xx(1,1),xx(1,2),'kx','MarkerSize',10);
end
if(LBC==3)
   plot(xx(1,1),xx(1,2),'k*','MarkerSize',10);    
end
if(RBC==2)
   plot(xx(end,1),xx(end,2),'kx','MarkerSize',10);
end
if(RBC==3)
   plot(xx(end,1),xx(end,2),'k*','MarkerSize',10);    
end
grid on;
xlabel('X (in)');
ylabel('Y (in)');
title('Elements, Nodes & Constraints  (x Pinned, * fixed)');
hold off;

setappdata(0,'xx',xx);
setappdata(0,'ne',total_ne);
setappdata(0,'L',L);
setappdata(0,'dof_status',dof_status);

set(handles.calculatebutton,'Enable','on');

fprintf('\n  total_ne=%d  num_nodes=%d \n',total_ne,num_nodes);


% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.calculatebutton,'Enable','off');


% --- Executes when entered data in editable cell(s) in uitable_data.
function uitable_data_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
set(handles.calculatebutton,'Enable','off');


% --- Executes on key press with focus on uitable_coordinates and none of its controls.
function uitable_coordinates_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_coordinates (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in uitable_coordinates.
function uitable_coordinates_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_coordinates (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



function edit_scale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale as text
%        str2double(get(hObject,'String')) returns contents of edit_scale as a double


% --- Executes during object creation, after setting all properties.
function edit_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[k,L,xx]=straight(k,L,xx,x1,x2,y1,y2,ns_elem,j)

    ne=ns_elem(j);
    deltax=x2(j)-x1(j);
    deltay=y2(j)-y1(j);
    dx=deltax/ne;
    dy=deltay/ne;
    
    L=L+norm([ deltax,deltay]);    
    
    xx(k,:)=[ x1(j) y1(j) ];
    k=k+1;
    
    for i=2:(ne+1)
        xx(k,1)=xx(k-1,1)+dx;
        xx(k,2)=xx(k-1,2)+dy;
        k=k+1;
    end 



function[k,L,xx]=bend(k,L,xx,x1,x2,y1,y2,nb_elem,j)

    xa=x2(j);
    xb=x1(j+1);
    ya=y2(j);
    yb=y1(j+1);
    
    A=zeros(4,4);
    A(1,:)=[ xa^3  xa^2  xa  1];
    A(2,:)=[ xb^3  xb^2  xb  1];
    A(3,:)=[ 3*xa^2  2*xa  1  0];
    A(4,:)=[ 3*xb^2  2*xb  1  0];     

    deltax=x2(j)-x1(j);
    deltay=y2(j)-y1(j);
    s1=deltay/deltax;
    
    deltax=x2(j+1)-x1(j+1);
    deltay=y2(j+1)-y1(j+1);
    s2=deltay/deltax;   

    B=[ya yb s1 s2]';
    
    cv=pinv(A)*B;
    
    ne=nb_elem(j);
   
    a=cv(1);
    b=cv(2);
    c=cv(3);
    d=cv(4);
    
    cube=@(x) a*x.^3+b*x.^2+c*x+d;
    core=@(x) sqrt( 1+ (3*a*x.^2+2*b*x+c).^2);
    
    alen=integral(core,xa,xb);
    L=L+alen;
    
    dL=alen/ne;
    
    nnn=1000;
    
    dxx=(xb-xa)/nnn;
    
    aa=zeros(nnn,1);
    xbb=zeros(nnn,1);

    for i=1:nnn
        xbb(i)=xa+i*dxx;
        aa(i)=integral(core,xa,xbb(i));
    end
       
    for i=1:(ne-1)
        dLi=i*dL;
        [~,ijk]=min(abs(aa-dLi));
        xx(k,1)=xbb(ijk);
        xx(k,2)=cube(xx(k,1));
        k=k+1;
    end    
    
function[Mass,Stiff,theta]=mass_stiffness_matrices(enum,ndof,LEN,rho,E,G,Iyy,Izz,J,A,nodex,nodey,nodez,node1,node2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%     Form local mass
%
mlocal=zeros(enum,12,12);
%     
for k=1:enum
     L=LEN(k);
     L2=L^2;
%
     mlocal(k,1,1) =140;  
     mlocal(k,1,7) =70;
%     
     mlocal(k,2,2) =156;  
     mlocal(k,2,6) =-22*L;  
     mlocal(k,2,8) =54;
     mlocal(k,2,12)=13*L;
%     
     mlocal(k,3,3) = mlocal(k,2,2);
     mlocal(k,3,5) =-mlocal(k,2,6);  
     mlocal(k,3,9) = mlocal(k,2,8);  
     mlocal(k,3,11)=-mlocal(k,2,12);
%     
     mlocal(k,4,4) =140*J/A;       
     mlocal(k,4,10)= 70*J/A;
%     
     mlocal(k,5,5) = 4*L2;
     mlocal(k,5,9) = mlocal(k,2,12);
     mlocal(k,5,11)=-3*L2;     
%     
     mlocal(k,6,6) = mlocal(k,5,5);  
     mlocal(k,6,8) =-mlocal(k,2,12);
     mlocal(k,6,12)= mlocal(k,5,11);  
%      
     mlocal(k,7,7)  =mlocal(k,1,1);       
%
     mlocal(k,8,8) = mlocal(k,2,2);  
     mlocal(k,8,12)=-mlocal(k,2,6); 
%
     mlocal(k,9,9)  =mlocal(k,2,2);  
     mlocal(k,9,11) =mlocal(k,2,6); 
%
     mlocal(k,10,10)=mlocal(k,4,4);  
%
     mlocal(k,11,11)=mlocal(k,5,5); 
%
     mlocal(k,12,12)=mlocal(k,5,5); 
%
%    symmetry
%
     for i=1:12
         for(j=i:12)
            mlocal(k,i,j)=mlocal(k,i,j)*L*rho*A/420.; 
            mlocal(k,j,i)=mlocal(k,i,j);
         end
     end
%    
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Form local stiffness
%
% 
%
klocal=zeros(enum,12,12);

for k=1:enum
%
     L=LEN(k);
     L2=L^2;
     L3=L^3;
     klocal(k,1,1) = E*A/L;  % TX
     klocal(k,1,7) =-klocal(k,1,1);
%     
     klocal(k,2,2) = 12*E*Izz/L3;  % TY  
     klocal(k,2,6) =  -6*E*Izz/L2;  
     klocal(k,2,8) =-klocal(k,2,2);
     klocal(k,2,12)= klocal(k,2,6);
%     
     klocal(k,3,3) = 12*E*Iyy/L3;  % TZ
     klocal(k,3,5) = 6*E*Iyy/L2;  
     klocal(k,3,9) = -klocal(k,3,3);  
     klocal(k,3,11)=  klocal(k,3,5);
%     
     klocal(k,4,4) =  G*J/L;       % RX
     klocal(k,4,10)= -klocal(k,4,4);
%     
     klocal(k,5,5) =  4*E*Iyy/L;  % RY
     klocal(k,5,9) = -klocal(k,3,5);
     klocal(k,5,11)=  0.5*klocal(k,5,5);     
%     
     klocal(k,6,6) =  4*E*Izz/L;  % RZ
     klocal(k,6,8) = -klocal(k,2,6);
     klocal(k,6,12)=  0.5*klocal(k,6,6);  
%      
     klocal(k,7,7) = klocal(k,1,1);       
%
     klocal(k,8,8)  = klocal(k,2,2);  
     klocal(k,8,12) = klocal(k,6,8); 
%
     klocal(k,9,9)  =  klocal(k,3,3);  
     klocal(k,9,11) = -klocal(k,3,5); 
%
     klocal(k,10,10)=klocal(k,4,4);  
%
     klocal(k,11,11)=klocal(k,5,5); 
%
     klocal(k,12,12)=klocal(k,6,6);   
%     
%    symmetry
%
     for i=1:12
         for(j=i:12) 
            klocal(k,j,i)=klocal(k,i,j);
         end
     end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Coordinate transformations
%
theta=zeros(k,1);

for k=1:enum
%
     xi=nodex(node1(k));
     xj=nodex(node2(k));
     yi=nodey(node1(k));
     yj=nodey(node2(k));     

%
    dy=yj-yi;
    dx=xj-xi;

    theta(k)=atan2(dy,dx);

    R=rotz(-theta(k));

    T=zeros(12,12);
    T(1:3,1:3)=R;
    T(4:6,4:6)=R;
    T(7:9,7:9)=R;
    T(10:12,10:12)=R;
     T
%
     clear ml;
     clear kl;
     ml((1:12),(1:12))=mlocal(k,(1:12),(1:12));
     kl((1:12),(1:12))=klocal(k,(1:12),(1:12));
%
     mlocal_ct=T'*ml*T;
     klocal_ct=T'*kl*T;
% 
     mct(k,(1:12),(1:12))=mlocal_ct;
     kct(k,(1:12),(1:12))=klocal_ct;
%    
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Assembly global mass & stiffness
%

Mass=zeros(ndof,ndof);
Stiff=zeros(ndof,ndof);

for k=1:enum
     clear TT;
     TT=zeros(12,ndof);
%     
     dof=node1(k)*6-5;
     for i=1:6
       TT(i,dof)=1;
       dof=dof+1;
     end
%     
     dof=node2(k)*6-5;
     for i=7:12
       TT(i,dof)=1; 
       dof=dof+1;       
     end
%
     clear mlocal_ct;
     clear klocal_ct;
     mlocal_ct((1:12),(1:12))=mct(k,(1:12),(1:12));
     klocal_ct((1:12),(1:12))=kct(k,(1:12),(1:12));
%
     Mass=Mass +TT'*mlocal_ct*TT;
    Stiff=Stiff+TT'*klocal_ct*TT;
end
%
