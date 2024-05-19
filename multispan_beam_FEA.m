function varargout = multispan_beam_FEA(varargin)
% MULTISPAN_BEAM_FEA MATLAB code for multispan_beam_FEA.fig
%      MULTISPAN_BEAM_FEA, by itself, creates a new MULTISPAN_BEAM_FEA or raises the existing
%      singleton*.
%
%      H = MULTISPAN_BEAM_FEA returns the handle to a new MULTISPAN_BEAM_FEA or the handle to
%      the existing singleton*.
%
%      MULTISPAN_BEAM_FEA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTISPAN_BEAM_FEA.M with the given input arguments.
%
%      MULTISPAN_BEAM_FEA('Property','Value',...) creates a new MULTISPAN_BEAM_FEA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multispan_beam_FEA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multispan_beam_FEA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multispan_beam_FEA

% Last Modified by GUIDE v2.5 14-Sep-2023 19:58:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multispan_beam_FEA_OpeningFcn, ...
                   'gui_OutputFcn',  @multispan_beam_FEA_OutputFcn, ...
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


% --- Executes just before multispan_beam_FEA is made visible.
function multispan_beam_FEA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multispan_beam_FEA (see VARARGIN)

% Choose default command line output for multispan_beam_FEA
handles.output = hObject;


set(handles.unitslistbox,'Value',1,'Enable','off');


set(handles.pushbutton_base_psd,'Enable','off');

listbox_numi_Callback(hObject, eventdata, handles);



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
 
set(handles.lengtheditbox,'String','');


% Update handles structure
guidata(hObject, handles);
 
material_change(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);
unitslistbox_Callback(hObject, eventdata, handles);


% UIWAIT makes multispan_beam_FEA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = multispan_beam_FEA_OutputFcn(hObject, eventdata, handles) 
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

% set(handles.edit_neutral_axis,'Visible','on');
% set(handles.text_neutral_axis,'Visible','on');

handles.cross_section=get(handles.crosssectionlistbox,'Value');
handles.unit=get(handles.unitslistbox,'Value');

iu=handles.unit;
iu=1;

E=str2num(get(handles.elasticmoduluseditbox,'String'));
rho=str2num(get(handles.massdensityeditbox,'String'));

nsm=str2num(get(handles.edit_nsm,'String'));

LBC=get(handles.leftBClistbox,'Value');
RBC=get(handles.rightBClistbox,'Value');

if(RBC==1)
    rem=str2num(get(handles.edit_right_end_mass,'String'));
    if(iu==1)
        rem=rem/386;
    end
end


L=str2num(get(handles.lengtheditbox,'String'));
setappdata(0,'L',L);


fprintf('\n  E=%8.4g   rho=%8.4g   L=%8.4g  nsm=%8.4g\n',E,rho,L,nsm);
fprintf(' LBC=%d RBC=%d \n',LBC,RBC);



if(L>1.0e-20 && L<1.0e+20)
else
    warndlg('Enter Valid length');
    return;
end
   
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
    
    
%    if(handles.cross_section==4) % other
%        set(handles.edit_neutral_axis,'Enable','on');
%    else
%        set(handles.edit_neutral_axis,'Enable','off');        
%    end

    box1=str2num(get(handles.crosssectioneditbox1,'String'));
    box2=str2num(get(handles.crosssectioneditbox2,'String'));
    get(handles.crosssectioneditbox2,'String')


    handles.cross_section=get(handles.crosssectionlistbox,'Value');
    
    if(handles.cross_section==1) % rectangular,
        
        thick=box1;
        width=box;
        
        if(thick>width)
            warndlg('Thickness > Width');
        end
        [area,MOI,cna]=beam_rectangular_geometry(width,thick); 
    end
    if(handles.cross_section==2) % pipe
        diameter=box1;
        wall_thick=box2;
        [area,MOI,cna]=pipe_geometry_wall(diameter,wall_thick);      

    end
    if(handles.cross_section==3) % solid cylinder
        diameter=box1;
        [area,MOI,cna]=cylinder_geometry(diameter);      
    end
    if(handles.cross_section==4) % other
        area=box1;
        MOI=box2;
%        cna=str2num(get(handles.edit_neutral_axis,'String'));
    end
    
%    ss=sprintf('%8.4g',cna);
%    set(handles.edit_neutral_axis,'String',ss);  
    
%    setappdata(0,'cna',cna);
    
    out1=sprintf('area=%8.4g MOI=%8.4g',area,MOI);
    disp(out1);

    rho=rho*area+(nsm/L);   % mass per unit length
    
    tmass=rho*L;
    
    
    out1=sprintf('\n area=%8.4g L=%g Vol=%8.4g rho=%8.4g mass/length  \n',area,L,area*L,rho);
    disp(out1);

%

ne=str2num(get(handles.edit_num_elements,'String'));

setappdata(0,'num_elem',ne);

if(ne==0 || isempty(ne))
   warndlg(' Number of elements must be >=1 '); 
   return; 
end


deltax=L/ne;
    
xx=zeros((ne+1),1);

for i=2:(ne+1)
    xx(i)=xx(i-1)+deltax; 
end 

%%%

numi=get(handles.listbox_numi,'Value');

numi=numi-1;

if(numi==0)   
 
    int_index=0;
    
else
    
    N=numi;

    A=char(get(handles.uitable_coordinates,'Data'));
    B=str2num(A);
    int_loc=B(1:N);    
    
    int_index=zeros(N,1);
    
    for i=1:numi
        
        if(int_loc(i)>=L)
            warndlg('Intermediate location >= length ');
            return;
        end
       
        [~,index] = min(abs(xx-int_loc(i)));
        
        xx(index)=int_loc(i);
        
        int_index(i)=index;
        
    end
    
    int_index=sort(int_index);
        
end


dx=zeros(ne,1);
for i=1:ne
    dx(i)=xx(i+1)-xx(i);
    
    if(dx(i)<1.0e-12)
        warndlg('Coincident nodes. Increase number of elements');
        return;
    end
    
end

disp(' ');
disp(' Node locations');
for i=1:length(xx)
    fprintf(' %8.4g \n',xx(i));
end
disp(' ');

%%%

setappdata(0,'xx',xx);

dof=2*ne+2;
% orig_dof=dof;

setappdata(0,'dof',dof);

%
I=MOI;


[klocal] = local_stiffness(E,I,ne,dx);
[mlocal] = local_mass(rho,ne,dx);


kk=zeros(4,4);
mm=zeros(4,4);

for i=1:4
    for j=1:4
        kk(i,j)=klocal(1,i,j);
        mm(i,j)=mlocal(1,i,j);
    end
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% int_index


[stiff,mass,stiff_unc,mass_unc,dof,dof_status,ivector]=...
            mspan_beam_assembly_unc(ne,klocal,mlocal,LBC,RBC,dof,numi,int_index);           

%% disp('dof_status')
%% for i=1:length(dof_status)
%%    fprintf(' %g \n',dof_status(i));
%% end
%% disp(' ');

%% disp('ivector');
%% for i=1:length(ivector)
%%    fprintf(' %g \n',ivector(i));
%% end
%% disp(' ');

        
if(ne==1)
    
    stiff
    mass
    
end
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          

    clear sum; 
    
    pms=0;

    tmass=tmass+pms;
    
    if(RBC==1)
        tmass=tmass+rem;
    end
    
    total_mass=tmass;


    if(handles.unit==1) % English    
        out1=sprintf('\n Total mass = %8.4g lbm ',tmass*386);
    else
        out1=sprintf('\n Total mass = %8.4g kg ',tmass);        
    end
    
    disp(out1);    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(RBC==1 && rem >0 )
        sz=size(mass);
        k=sz(1)-1;
        mass(k,k)=rem;
    end

[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiff,mass,2);
%

setappdata(0,'stiff_unc',stiff_unc);
setappdata(0,'mass_unc',mass_unc);

setappdata(0,'stiff',stiff);
setappdata(0,'mass',mass);

setappdata(0,'fn_full',fn);
setappdata(0,'fn',fn);
setappdata(0,'ModeShapes_full',ModeShapes);



setappdata(0,'dof',dof);
setappdata(0,'dof_status',dof_status);
setappdata(0,'ivector',ivector);

%
setappdata(0,'E',E);
setappdata(0,'I',MOI);    
setappdata(0,'cna',cna); 



%%%%%%%%%%%%%%%%%%

[pf]=beam_fn_pf_emm(iu,total_mass,dof,fn,mass,ModeShapes,MST,dof_status,ivector);  % function

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

assignin('base', 'beam_stiffness_unc', stiff_unc);
assignin('base', 'beam_mass_unc', mass_unc);

set(handles.pushbutton_base_psd,'Enable','on');

msgbox('Natural Frequencies written to Command Window');


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
    set(handles.lengthlabel,'String','inch');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (lbf/in^2)');
    set(handles.massdensitylabel,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_nsm,'String','lbm');      
else
    set(handles.lengthlabel,'String','meter');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (GPa)'); 
    set(handles.massdensitylabel,'String','Mass Density (kg/m^3)');
    set(handles.text_nsm,'String','kg'); 
end

rightBClistbox_Callback(hObject, eventdata, handles);

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

n=get(handles.rightBClistbox,'Value');

if(n==1)
    set(handles.uipanel_right_end_mass,'Visible','on');
else
    set(handles.uipanel_right_end_mass,'Visible','off');    
end

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
   
orig_dof=length(dof_status);
dof_half=round(orig_dof/2);
%
choice=1;
%
for j=num:num
%
    if(choice==1)
%      
      at = sprintf(' Mode %d   freq=%8.4g Hz',j,fn(j));
      pf_mode=mode(:,j);  
%
        for i=1:orig_dof
            if(dof_status(i)==0)
%       
                pf_mode=[pf_mode(1:(i-1));0;pf_mode(i:length(pf_mode))];
%
            end
        end
%
        pmode=zeros(dof_half,1);
%        
        for i=1:dof_half
            pmode(i)=pf_mode(2*i-1);
        end
%
        figure(fig_num);
        fig_num=fig_num+1;
%
        plot(xx,pmode); 
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


iu=get(handles.unitslistbox,'Value');

n=get(handles.listbox_numi,'Value');

n=n-1;

if(n==0)
    
    set(handles.uitable_coordinates,'Visible','off'); 
    set(handles.text_distance,'Visible','off');
    
else    
    
    set(handles.uitable_coordinates,'Visible','on');  
    set(handles.text_distance,'Visible','on');
    
    if(iu==1)
       set(handles.text_distance,'String','Distance from Left End (in)');
    else
       set(handles.text_distance,'String','Distance from Left End (m)');
    end

    for i = 1:n
        data_s{i,1} = '';     
    end
    
    cn={'x'};
    set(handles.uitable_coordinates,'Data',data_s,'ColumnName',cn)

end

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



function edit_num_elements_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_elements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_elements as text
%        str2double(get(hObject,'String')) returns contents of edit_num_elements as a double
set(handles.pushbutton_base_psd,'Enable','off');

% --- Executes during object creation, after setting all properties.
function edit_num_elements_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_elements (see GCBO)
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

    handles.s=mspan_base_input_psd; 
    set(handles.s,'Visible','on');
end

% --- Executes on key press with focus on edit_num_elements and none of its controls.
function edit_num_elements_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_elements (see GCBO)
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
    L=get(handles.lengtheditbox,'String');
    multispan_beam_FEA.L=L;
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
    data=get(handles.uitable_coordinates,'data');
    multispan_beam_FEA.data=data;
catch
end
try
    num_elements=get(handles.edit_num_elements,'String');
    multispan_beam_FEA.num_elements=num_elements;
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
    L=multispan_beam_FEA.L;    
    set(handles.lengtheditbox,'String',L);
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
    num_elements=multispan_beam_FEA.num_elements;    
    set(handles.edit_num_elements,'String',num_elements);
catch
end
try
    cross=multispan_beam_FEA.cross;    
    set(handles.crosssectionlistbox,'Value',cross);
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
    data=multispan_beam_FEA.data;    
    set(handles.uitable_coordinates,'data',data);
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



function edit_right_end_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_right_end_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_right_end_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_right_end_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_right_end_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_right_end_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_base_psd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_base_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
