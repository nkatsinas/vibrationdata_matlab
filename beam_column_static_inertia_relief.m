function varargout = beam_column_static_inertia_relief(varargin)
% BEAM_COLUMN_STATIC_INERTIA_RELIEF MATLAB code for beam_column_static_inertia_relief.fig
%      BEAM_COLUMN_STATIC_INERTIA_RELIEF, by itself, creates a new BEAM_COLUMN_STATIC_INERTIA_RELIEF or raises the existing
%      singleton*.
%
%      H = BEAM_COLUMN_STATIC_INERTIA_RELIEF returns the handle to a new BEAM_COLUMN_STATIC_INERTIA_RELIEF or the handle to
%      the existing singleton*.
%
%      BEAM_COLUMN_STATIC_INERTIA_RELIEF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_COLUMN_STATIC_INERTIA_RELIEF.M with the given input arguments.
%
%      BEAM_COLUMN_STATIC_INERTIA_RELIEF('Property','Value',...) creates a new BEAM_COLUMN_STATIC_INERTIA_RELIEF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_column_static_inertia_relief_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_column_static_inertia_relief_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_column_static_inertia_relief

% Last Modified by GUIDE v2.5 18-Aug-2017 11:12:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_column_static_inertia_relief_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_column_static_inertia_relief_OutputFcn, ...
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


% --- Executes just before beam_column_static_inertia_relief is made visible.
function beam_column_static_inertia_relief_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_column_static_inertia_relief (see VARARGIN)

% Choose default command line output for beam_column_static_inertia_relief
handles.output = hObject;

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
 

set(handles.listbox_npm,'Value',1);
listbox_npm_Callback(hObject, eventdata, handles);
 
set(handles.edit_neutral_axis,'Visible','off');
set(handles.text_neutral_axis,'Visible','off');
 
set(handles.lengtheditbox,'String','');


% Update handles structure
guidata(hObject, handles);
 
material_change(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);
unitslistbox_Callback(hObject, eventdata, handles);

edit_num_elem_KeyPressFcn(hObject, eventdata, handles);


% UIWAIT makes beam_column_static_inertia_relief wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_column_static_inertia_relief_OutputFcn(hObject, eventdata, handles) 
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

setappdata(0,'fig_num',1);

ne=str2num(get(handles.edit_num_elem,'String'));   

if(isempty(ne))
   warndlg('Enter number of elements'); 
   return; 
end

setappdata(0,'ne',ne);


handles.cross_section=get(handles.crosssectionlistbox,'Value');

%% set(handles.edit_neutral_axis,'Visible','off');
%% set(handles.text_neutral_axis,'Visible','off');


handles.unit=get(handles.unitslistbox,'Value');

iu=handles.unit;

E=str2num(get(handles.elasticmoduluseditbox,'String'));
rho=str2num(get(handles.massdensityeditbox,'String'));

nsm=str2num(get(handles.edit_nsm,'String'));

%% LBC=get(handles.leftBClistbox,'Value');
%% RBC=get(handles.rightBClistbox,'Value');

LBC=1;     % free
RBC=LBC;

L=str2num(get(handles.lengtheditbox,'String'));

if(isempty(L))
    warndlg('Enter Length');
    return;
end

if(L>1.0e-20 && L<1.0e+20)
else
    warndlg('Enter Valid length');
    return;
end


    thick=handles.thick;
    width=handles.width;
    
    
    diameter=handles.diameter;
    wall_thick=handles.wall_thick;
    
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
    
    setappdata(0,'unit',handles.unit);
    
    
    if(handles.cross_section==4) % other
        area=str2num(get(handles.crosssectioneditbox1,'string'));
        MOI= str2num(get(handles.crosssectioneditbox2,'string'));
        cna= str2num(get(handles.edit_neutral_axis,'string'));
    end
    
    if(handles.cross_section==1) % rectangular
        
        if(thick>width)
            warndlg('Thickness > Width');
        end
        [area,MOI,cna]=beam_rectangular_geometry(width,thick); 
    end
    if(handles.cross_section==2) % pipe
        [area,MOI,cna]=pipe_geometry_wall(diameter,wall_thick);     
    end
    if(handles.cross_section==3) % solid cylinder
        [area,MOI,cna]=cylinder_geometry(diameter);       
    end
    if(handles.cross_section==4) % other
        area=str2num(get(handles.crosssectioneditbox1,'string'));
        MOI= str2num(get(handles.crosssectioneditbox2,'string'));
        cna= str2num(get(handles.edit_neutral_axis,'string'));
    end    
    
    
    ss=sprintf('%8.4g',cna);
    set(handles.edit_neutral_axis,'String',ss);       
    setappdata(0,'cna',cna);
    
    setappdata(0,'area',area);
    
    out1=sprintf('area=%8.4g MOI=%8.4g',area,MOI);
    disp(out1);

    rho=rho*area+(nsm/L);   % mass per unit length
    
    tmass=rho*L;
    
    
    out1=sprintf('\n area=%8.4g L=%g Vol=%8.4g rho=%8.4g mass/length  \n',area,L,area*L,rho);
    disp(out1);

%


%%%

deltax=L/ne;

dx=zeros(ne,1);

for i=1:ne
    dx(i)=deltax;
end

xx=zeros((ne+1),1);

for i=2:(ne+1)
   xx(i)=xx(i-1)+deltax; 
end

setappdata(0,'xx',xx);

dof=3*(ne+1);
orig_dof=dof;

setappdata(0,'dof',dof);


%
I=MOI;

EI=E*I;
setappdata(0,'EI',EI);
setappdata(0,'MOI',MOI);
setappdata(0,'elastic_modulus',E);


[klocal] = beam_column_local_stiffness(E,I,area,ne,dx);
[mlocal] = beam_column_local_mass(rho,ne,dx);


kk=zeros(6,6);
mm=zeros(6,6);

for i=1:6
    for j=1:6
        kk(i,j)=klocal(1,i,j);
        mm(i,j)=mlocal(1,i,j);
    end
end    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
npm=-1+get(handles.listbox_npm,'Value');

pmloc=zeros(3,1);
pm=zeros(3,1);

if(npm>=1)
    pmloc(1)=str2num(get(handles.edit_pml1,'String'));
       pm(1)=str2num(get(handles.edit_pm1,'String'));
end
if(npm>=2)
    pmloc(2)=str2num(get(handles.edit_pml2,'String'));
       pm(2)=str2num(get(handles.edit_pm2,'String'));    
end
if(npm>=3)
    pmloc(3)=str2num(get(handles.edit_pml3,'String'));
       pm(3)=str2num(get(handles.edit_pm3,'String'));    
end

if(handles.unit==1) % English
    pm=pm/386;
end    



[stiff,mass,stiff_unc,mass_unc,dof,dof_status,XL,ivector_x,ivector_y]=...
               beam_column_assembly(ne,klocal,mlocal,LBC,RBC,dof,npm,pmloc,pm,xx);  
           

if(ne==1)
    
    stiff
    mass
    
end           

dtype=1;
etype=2;

mass_2=mass_unc;
mass_2(:,3)=[];
mass_2(3,:)=[];
mass_2(:,2)=[];
mass_2(2,:)=[];

stiff_2=stiff_unc;
stiff_2(:,3)=[];
stiff_2(3,:)=[];
stiff_2(:,2)=[];
stiff_2(2,:)=[];

sz=size(mass_2);
num=sz(1);
ea(1)=1;  % axial only


           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(npm>=1)
 
    disp(' ');
    disp(' Point mass ');
 
   for i=1:npm

        if(handles.unit==1) % English   
            out1=sprintf('%7.3g  %7.3g',XL(i),pm(i)*386);
        else
            out1=sprintf('%7.3g  %7.3g',XL(i),pm(i));       
        end
   
        disp(out1);
   
   end
end
                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          

    clear sum; 
    pms=sum(pm);
    

    tmass=tmass+pms;
    total_mass=tmass;


    if(handles.unit==1) % English    
        out1=sprintf('\n Total mass = %8.4g lbm ',tmass*386);
    else
        out1=sprintf('\n Total mass = %8.4g kg ',tmass);        
    end
    
    disp(out1);    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiff,mass,2);
%
setappdata(0,'stiff',stiff);
setappdata(0,'mass',mass);

setappdata(0,'fn_full',fn);
setappdata(0,'ModeShapes_full',ModeShapes);
%


%%%%%%%%%%%%%%%%%%

[pf]=beam_column_fn_pf_emm(iu,total_mass,dof,fn,mass,ModeShapes,MST,ivector_x,ivector_y);  % function

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
setappdata(0,'dof_status',dof_status);

set(handles.pushbutton_view_mode_shapes,'Visible','on');
set(handles.uipanel_mode_number,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fn=fix_size(fn);

disp(' ');
disp(' Output arrays saved as: ');
disp(' ');
disp('    beam_fn ');
disp('    beam_pf ');
disp('    beam_modeshapes ');

disp(' ');
disp(' Mass & Stiffness arrays saved as:  ');
disp(' ');
disp('    beam_mass');
disp('    beam_stiffness');

assignin('base', 'beam_fn', fn);
assignin('base', 'beam_pf', pf);
assignin('base', 'beam_modeshapes', ModeShapes);

assignin('base', 'beam_stiffness', stiff);
assignin('base', 'beam_mass', mass);

set(handles.pushbutton_displacements,'Visible','on');
set(handles.uipanel_loads,'Visible','on');

msgbox('Natural Frequencies written to Command Window');


% --- Executes on selection change in leftBClistbox.
function leftBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns leftBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from leftBClistbox
clear_buttons(hObject, eventdata, handles);

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


if(handles.unit==1)
    set(handles.lengthlabel,'String','inch');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (lbf/in^2)');
    set(handles.massdensitylabel,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_nsm,'String','lbm');     
    set(handles.text_pmloc,'String','inch');   
    set(handles.text_pm,'String','lbm');    
else
    set(handles.lengthlabel,'String','meter');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (GPa)'); 
    set(handles.massdensitylabel,'String','Mass Density (kg/m^3)');
    set(handles.text_nsm,'String','kg');
    set(handles.text_pmloc,'String','meter'); 
    set(handles.text_pm,'String','kg');      
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

set(handles.pushbutton_displacements,'Visible','off');

set(handles.uipanel_loads,'Visible','off');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(beam_column_static_inertia_relief);


% --- Executes on button press in pushbutton_view_mode_shapes.
function pushbutton_view_mode_shapes_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_mode_shapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.unitslistbox,'Value');

        xx=getappdata(0,'xx');
        fn=getappdata(0,'fn');
      mode=getappdata(0,'ModeShapes');
dof_status=getappdata(0,'dof_status');
   fig_num=getappdata(0,'fig_num');

       num=get(handles.listbox_mode_number,'Value');
       
   
         
LF=length(fn);

if(num>LF)
    out1=sprintf(' Highest mode number = %d',LF);
    warndlg(out1);
    return;
end
   
npo=length(xx);
pp=round(npo/3);

pmodex=zeros(npo,1);
pmodey=zeros(npo,1);



undeformed=zeros(npo,1);

%
for j=num:num
%
      at = sprintf(' Mode %d   freq=%8.4g Hz',j,fn(j));
      pf_mode=mode(:,j);      

      ijk=1;
      
      for i=1:npo
    
        pmodex(i)=pf_mode(ijk);
        pmodey(i)=pf_mode(ijk+1);
        ijk=ijk+3;
    
      end      
      
      xm=xx+pmodex;
      ym=pmodey;
      
%      
      figure(fig_num);
      fig_num=fig_num+1;
      
      plot(xx,undeformed,'b',xm,ym,'r'); 
      grid;
      set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','lin');    
      title(at);
      if(iu==1)
            xlabel('x (inch)'); 
      else
            xlabel('x (meters)');
      end    
      ylabel('modal displacement');
%

end

setappdata(0,'fig_num',fig_num);





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



function edit_num_elem_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_elem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_elem as text
%        str2double(get(hObject,'String')) returns contents of edit_num_elem as a double

edit_num_elem_KeyPressFcn(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function edit_num_elem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_elem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_displacements.
function pushbutton_displacements_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_displacements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * * * ');
disp('  ');

iu=get(handles.unitslistbox,'Value');

stiff=getappdata(0,'stiff');
mass=getappdata(0,'mass');
ModeShapes=getappdata(0,'ModeShapes_full');

xx=getappdata(0,'xx');


rbm=ModeShapes(:,1:3);

try
    FS=get(handles.edit_loads_array,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found.');
    return;
end

force_array=THM;

num=length(xx);
szf=size(force_array);

if(szf(2)~=3)
    warndlg('Input array must have three columns');
    return;
end

anum=szf(1)*szf(2);

force=zeros(anum,1);

ijk=1;
for i=1:3:anum
    force(i)=force_array(ijk,1);
    force(i+1)=force_array(ijk,2);    
    force(i+2)=force_array(ijk,3);    
    ijk=ijk+1;
end



%%%

cdof=[1 2 3];

    num_cdof=length(cdof);
    
    kee=stiff;
    
    for i=1:num_cdof
        
        j=cdof(i);
        
        kee(j,:)=0;
        kee(:,j)=0;
        
    end
    
%%    disp(' ');
%%    disp(' Inertia Relief Matrix');


    szm=size(mass);
    
    nq=szm(1);
    
    id=eye(nq);
    
    R=id-mass*rbm*rbm';
    
    Gc=pinv(kee);
    
    
%%    disp(' ');
%%    disp(' Constrained Flexibility Matrix ');    
        
%%    Gc
    
%%    disp(' System Flexibility for Elastic Modes ');

    Ge=R'*Gc*R;
        
    try
        ddd=Ge*force;
    catch
        
        disp(' size Ge ');
        size(Ge)
        disp(' size force ');
        size(force)        
        
        warndlg(' Multiplication error:  ddd=Ge*force ');
        return; 
    end

np=length(xx);

dx=zeros(np,4);

dx(:,1)=xx;

ijk=1;

for i=1:np
    
    dx(i,2:4)=[   ddd(ijk)   ddd(ijk+1)   ddd(ijk+2)    ];
    
    ijk=ijk+3;
    
end

disp(' ');
disp(' Displacements ');
disp(' ');
disp('     x       axial      lateral     rotation');

if(iu==1)
    disp('    (in)     (in)        (in)        (rad) ');     
else
    disp('    (m)      (m)        (m)         (rad) ');      
end


for i=1:np
   
    out1=sprintf(' %8.4f \t %8.4f \t %8.4f \t %8.4f ',dx(i,1),dx(i,2),dx(i,3),dx(i,4));
    disp(out1);
    
end    

%%%%%%%%%%%%%%

disp(' ');
disp('  ** The following peaks are max & min ** ');


figure(10);
plot(xx+dx(:,2),dx(:,3));
grid on;
title('Displacement Shape');

if(iu==1)
   xlabel('x (in)');
   ylabel('y (in)');
else
   xlabel('x (m)');   
   ylabel('y (m)');
end

disp('  ');
if(iu==1)
    disp(' Peak Displacements (in) ');
else
    disp(' Peak Displacements (m)');    
end
disp('  ');


out1=sprintf('      Axial:  %8.4g  %8.4g ', max(dx(:,2)),min(dx(:,2)));
out2=sprintf('    Lateral:  %8.4g  %8.4g ', max(dx(:,3)),min(dx(:,3)));
disp(out1);
disp(out2);

disp('  ');
disp(' Peak Rotations (rad)');  
disp('  ');    
out3=sprintf('               %8.4g  %8.4g  ', max(dx(:,4)),min(dx(:,4)));
disp(out3);

assignin('base','displacement_array',dx);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EI=getappdata(0,'EI');
cna=getappdata(0,'cna');
MOI=getappdata(0,'MOI');
area=getappdata(0,'area');
E=getappdata(0,'elastic_modulus');


ne=getappdata(0,'ne');

num_nodes=ne+1;

%%%

Moment=zeros(num_nodes,1);
Shear=zeros(num_nodes,1);

x=0;
L=xx(2)-xx(1);
[MA,VA]=beam_bending_moment_array(L,x);
dispV=[  dx(1,3) dx(1,4)  dx(2,3) dx(2,4) ]';
Moment(1)=(EI/L^2)*MA*dispV;
 Shear(1)=(EI/L^2)*VA*dispV;

%%%

M_right=zeros(ne,1);
M_left =zeros(ne,1);
V_right=zeros(ne,1);
V_left =zeros(ne,1);


for i=1:ne
    
    L=xx(i+1)-xx(i);
    
    dispV=[  dx(i,3) dx(i,4)  dx(i+1,3) dx(i+1,4) ]';
    
    x=0;
    [MA,VA]=beam_bending_moment_array(L,x);
    M_left(i)=(EI/L^2)*MA*dispV;
    V_left(i)=(EI/L^2)*VA*dispV;    
    
    x=1;
    [MA,VA]=beam_bending_moment_array(L,x);
    M_right(i)=(EI/L^2)*MA*dispV;
    V_right(i)=(EI/L^2)*VA*dispV;        
    
    
end

for i=1:(ne-1)
    
    Moment(i+1)=mean([M_right(i) M_left(i+1)]);
     Shear(i+1)=mean([V_right(i) V_left(i+1)]);    
    
end

Moment(num_nodes)=M_right(ne);
 Shear(num_nodes)=V_right(ne);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(11);
plot(xx,Moment);
grid on;
title('Bending Moment');

disp(' ');
if(iu==1)
   xlabel('x (in)');
   ylabel1='Moment (in-lbf)';
   disp(' Peak Moment (in-lbf)');
else
   xlabel('x (m)');   
   ylabel1='Moment (N-m)';
   disp(' Peak Moment (N-m)');   
end
ylabel(ylabel1);

disp('  ');
out1=sprintf('            %8.4g     %8.4g  ',max(Moment),min(Moment));
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(12);
plot(xx,Shear);
grid on;
title('Shear Force');

disp('  ');
if(iu==1)
   xlab='x (in)';
   ylabel2='Force (lbf)';
   disp(' Peak Shear (lbf)');    
else
   xlab='x (m)';   
   ylabel2='Force (N)';
   disp(' Peak Shear (N)');     
end
xlabel(xlab);
ylabel(ylabel2);

disp('  ');
out1=sprintf('            %8.4g     %8.4g  ',max(Shear),min(Shear));
disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=13;

data1=[xx,Moment];
data2=[xx,Shear];
xlabel2=xlab;
t_string1='Bending Moment';
t_string2='Shear Force';
[fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axial_stress=zeros(num_nodes,1);
elem_axial_stress=zeros(ne,1);

for i=1:ne
    
    L=xx(i+1)-xx(i);
    
    strain= ( dx(i+1,2)-dx(i,2) )/L;
    
    elem_axial_stress(i)=E*strain;    
    
end

axial_stress(1)=elem_axial_stress(1);

for i=2:(num_nodes-1)
    axial_stress(i)=mean([ elem_axial_stress(i)  elem_axial_stress(i-1) ]);
end

axial_stress(num_nodes)=elem_axial_stress(ne);

normal_stress=(Moment*cna/MOI)+axial_stress;

figure(fig_num);
fig_num=fig_num+1;
plot(xx,normal_stress);
grid on;
title('Normal Stress from Bending & Axial');

disp('  ');

if(iu==1)
   xlabel('x (in)');
   ylabel('Stress (psi)');
   disp(' Peak Stress (psi)');
else 
   xlabel('x (m)');   
   ylabel('Stress (Pa)');
   disp(' Peak Stresses (Pa)');   
end

disp('  ');
out1=sprintf('            %8.4g     %8.4g  ',max(normal_stress),min(normal_stress));
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp('  ');
disp(' Output array:  displacement_array ');
disp('   (x, axial displacement, lateral displacement, rotation)');
disp('  ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function edit_loads_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_loads_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_loads_array as text
%        str2double(get(hObject,'String')) returns contents of edit_loads_array as a double


% --- Executes during object creation, after setting all properties.
function edit_loads_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_loads_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nodes as text
%        str2double(get(hObject,'String')) returns contents of edit_nodes as a double


% --- Executes during object creation, after setting all properties.
function edit_nodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dof_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dof as text
%        str2double(get(hObject,'String')) returns contents of edit_dof as a double


% --- Executes during object creation, after setting all properties.
function edit_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_num_elem and none of its controls.
function edit_num_elem_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_elem (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


sss=get(handles.edit_num_elem,'String');
ne=str2num(sss);

nodes=ne+1;
dof=3*nodes;

s1=sprintf('%d',nodes);
s2=sprintf('%d',dof);


set(handles.edit_nodes,'String',s1);
set(handles.edit_dof,'String',s2);

set(handles.uipanel_loads,'Visible','off');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_num_elem.
function edit_num_elem_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_elem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


edit_num_elem_KeyPressFcn(hObject, eventdata, handles)
