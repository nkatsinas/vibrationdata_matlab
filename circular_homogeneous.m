function varargout = circular_homogeneous(varargin)
% CIRCULAR_HOMOGENEOUS MATLAB code for circular_homogeneous.fig
%      CIRCULAR_HOMOGENEOUS, by itself, creates a new CIRCULAR_HOMOGENEOUS or raises the existing
%      singleton*.
%
%      H = CIRCULAR_HOMOGENEOUS returns the handle to a new CIRCULAR_HOMOGENEOUS or the handle to
%      the existing singleton*.
%
%      CIRCULAR_HOMOGENEOUS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCULAR_HOMOGENEOUS.M with the given input arguments.
%
%      CIRCULAR_HOMOGENEOUS('Property','Value',...) creates a new CIRCULAR_HOMOGENEOUS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circular_homogeneous_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circular_homogeneous_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circular_homogeneous

% Last Modified by GUIDE v2.5 09-Sep-2014 17:38:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circular_homogeneous_OpeningFcn, ...
                   'gui_OutputFcn',  @circular_homogeneous_OutputFcn, ...
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


% --- Executes just before circular_homogeneous is made visible.
function circular_homogeneous_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circular_homogeneous (see VARARGIN)

% Choose default command line output for circular_homogeneous
handles.output = hObject;

setappdata(0,'return','no');

setappdata(0,'bulkhead_type','homogeneous');

set(handles.pushbutton_base,'Visible','off');
set(handles.uipanel_results,'Visible','off');

handles.unit=1;
handles.material=1;

% Update handles structure
guidata(hObject, handles);

units_change(hObject,eventdata,handles)

clear_answer(hObject, eventdata, handles)


function clear_answer(hObject, eventdata, handles)

set(handles.uipanel_results,'Visible','off');

set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');
% Update handles structure
guidata(hObject, handles);




% --- Outputs from this function are returned to the command line.
function varargout = circular_homogeneous_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function units_change(hObject,eventdata,handles)

% disp(' units_change ');

if(handles.unit==1)
   set(handles.elastic_modulus_text,'String','Elastic Modulus (psi)');
   set(handles.mass_density_text,'String','Mass Density (lbm/in^3)');
   set(handles.diameter_text,'String','Diameter (inch)');
   set(handles.thickness_text,'String','Thickness (inch)');
   set(handles.mass_text,'String','lbm');
else
   set(handles.elastic_modulus_text,'String','Elastic Modulus (GPa)'); 
   set(handles.mass_density_text,'String','Mass Density (kg/m^3)');
   set(handles.diameter_text,'String','Diameter (mm)');   
   set(handles.thickness_text,'String','Thickness (mm)');
   set(handles.mass_text,'String','kg');
end

material_change(hObject, eventdata, handles);

guidata(hObject, handles)


% --- Executes on button press in return_pushbutton.
function return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(circular_homogeneous)


% --- Executes on selection change in unit_listbox.
function unit_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to unit_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unit_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unit_listbox
clear_answer(hObject, eventdata, handles)

handles.unit=get(hObject,'Value');

guidata(hObject, handles);

units_change(hObject,eventdata,handles);
materials_listbox_Callback(hObject, eventdata, handles);



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
clear_answer(hObject, eventdata, handles)

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
clear_answer(hObject, eventdata, handles)

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
clear_answer(hObject, eventdata, handles)

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


% --- Executes on button press in calculate_button.
function calculate_button_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'circular_homogeneous_key',0);

fig_num=1;

set(handles.Answer,'Enable','on');

BC=get(handles.BC_listbox,'Value');


E=str2num(get(handles.elastic_modulus_edit,'String'));
rho=str2num(get(handles.mass_density_edit,'String'));
mu=str2num(get(handles.poisson_edit,'String'));

diameter=str2num(get(handles.diameter_edit,'String'));
T=str2num(get(handles.thickness_edit,'String'));

NSM=str2num(get(handles.NSM_edit,'String'));

iu=handles.unit;

if(handles.unit==1)
    rho=rho/386;
    NSM=NSM/386;
else
    [E]=GPa_to_Pa(E);
    diameter=diameter/1000;
    T=T/1000;
end

h=T;

tpi=2*pi;

r=diameter/2;
radius=r;

area=pi*(diameter^2)/4;

[~,total_mass,rho]=homogeneous_totals_mass(area,T,rho,NSM);

den=12*(rho*T*(1-mu^2));

term=sqrt(E*T^3/den)/(tpi*r^2);

if(BC==1)  % fixed
    L(1)=10.22;
    L(2)=21.26;
    L(3)=34.88;
end

if(BC==2)  % ss
    L(1)=4.977;
    L(2)=13.94;
    L(3)=25.65;
end

if(BC==3)  % free
    L(1)=5.253;
    L(2)=9.084;
    L(3)=12.23;    
end


D=E*h^3/(12*(1.-mu^2));
DD=sqrt(D/(rho*h));  

if(BC==1)  % fixed

    [fn,part,n,k,CE,DE,root,fig_num]=...
               vibrationdata_fixed_circular_plate(D,DD,rho,mu,h,r,fig_num);
%
    msgbox('Results written to Command Window');    
    
end
if(BC==2)  % ss
%    
    [fn,part,n,k,CE,DE,root,fig_num]=...
                  vibrationdata_ss_circular_plate(D,DD,rho,mu,h,r,fig_num);
%
     msgbox('Results written to Command Window');
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(BC==3)  % free

    set(handles.uipanel_results,'Visible','on');
    
    fn=zeros(3,1);

    for i=1:3
        fn(i)=L(i)*term;
    end

    ss1=sprintf('natural frequencies = \n\n %8.4g Hz\n %8.4g Hz\n %8.4g Hz',...
                                                        fn(1),fn(2),fn(3));
                                                    
    if(handles.unit==1)
        ss2=sprintf('total mass = \n\n %8.4g lbm',total_mass*386);
    else
        ss2=sprintf('total mass = \n\n %8.4g kg',total_mass);
    end

    ss3=sprintf('%s \n\n %s',ss1,ss2);
                                                    
    set(handles.Answer,'String',ss3);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if(BC<=2)
    
    num=length(fn);
    
    j=1;
    
    for i=1:num
        if(abs(part(i))>1.0e-08)
            ns(j)=n(i);
            ks(j)=k(i);
            CEs(j)=CE(i);
            DEs(j)=DE(i);
            roots(j)=root(i);
            fns(j)=fn(i);
            parts(j)=part(i);
            j=j+1;
        end
    end    

    setappdata(0,'n',ns);
    setappdata(0,'k',ks);
    setappdata(0,'CE',CEs);
    setappdata(0,'DE',DEs);
    setappdata(0,'root',roots);
    setappdata(0,'fn',fns);
    setappdata(0,'part',parts);     
    
end


if(BC==4)
    
    De=E*h^3/(12*(1.-mu^2));
    
    [fn,part,Z,Z_r,Z_theta]=...
        vibrationdata_circular_four_points(De,diameter,total_mass,mu,rho,h);
   
    out1=sprintf(' fn = %7.4g Hz  PF=%8.4g',fn,part);
    disp(out1)
%
    ZZr=Z/max(max(Z));

    figure(fig_num);
    fig_num=fig_num+1;
    polarplot3d(ZZr,'PlotType','surfn','meshscale',0.5,'PolarGrid',[20 72]);
    title(out1)
       

    setappdata(0,'fn',fn);
    setappdata(0,'part',part);  
    setappdata(0,'Z',Z);  
    setappdata(0,'Z_r',Z_r);
    setappdata(0,'Z_theta',Z_theta);
    
    set(handles.pushbutton_base,'Visible','on');    
end

if(BC~=3)
    set(handles.pushbutton_base,'Visible','on');
end


setappdata(0,'iu',iu);
setappdata(0,'E',E);
setappdata(0,'T',T);
setappdata(0,'radius',radius);   
setappdata(0,'mu',mu);
setappdata(0,'rho',rho);
setappdata(0,'total_mass',total_mass);
setappdata(0,'BC',BC);
setappdata(0,'fig_num',fig_num);



D
rho*h


function NSM_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NSM_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NSM_edit as text
%        str2double(get(hObject,'String')) returns contents of NSM_edit as a double
clear_answer(hObject, eventdata, handles)

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



function diameter_edit_Callback(hObject, eventdata, handles)
% hObject    handle to diameter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diameter_edit as text
%        str2double(get(hObject,'String')) returns contents of diameter_edit as a double
clear_answer(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function diameter_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diameter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thickness_edit_Callback(hObject, eventdata, handles)
% hObject    handle to thickness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thickness_edit as text
%        str2double(get(hObject,'String')) returns contents of thickness_edit as a double
clear_answer(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function thickness_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thickness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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


% --- Executes on selection change in BC_listbox.
function BC_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BC_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BC_listbox
clear_answer(hObject, eventdata, handles)


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


% --- Executes on key press with focus on diameter_edit and none of its controls.
function diameter_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to diameter_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


% --- Executes on key press with focus on thickness_edit and none of its controls.
function thickness_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to thickness_edit (see GCBO)
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


% --- Executes on button press in pushbutton_base.
function pushbutton_base_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

BC=get(handles.BC_listbox,'Value');

if(BC<=2)
    handles.s=vibrationdata_circular_plate_base;     
else
    handles.s=circular_plate_four_points_base;        
end    
    
set(handles.s,'Visible','on'); 
