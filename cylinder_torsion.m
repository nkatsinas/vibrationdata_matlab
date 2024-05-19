function varargout = cylinder_torsion(varargin)
% CYLINDER_TORSION MATLAB code for cylinder_torsion.fig
%      CYLINDER_TORSION, by itself, creates a new CYLINDER_TORSION or raises the existing
%      singleton*.
%
%      H = CYLINDER_TORSION returns the handle to a new CYLINDER_TORSION or the handle to
%      the existing singleton*.
%
%      CYLINDER_TORSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CYLINDER_TORSION.M with the given input arguments.
%
%      CYLINDER_TORSION('Property','Value',...) creates a new CYLINDER_TORSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cylinder_torsion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cylinder_torsion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cylinder_torsion

% Last Modified by GUIDE v2.5 17-Feb-2015 09:08:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cylinder_torsion_OpeningFcn, ...
                   'gui_OutputFcn',  @cylinder_torsion_OutputFcn, ...
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


% --- Executes just before cylinder_torsion is made visible.
function cylinder_torsion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cylinder_torsion (see VARARGIN)

% Choose default command line output for cylinder_torsion
handles.output = hObject;

set(handles.listbox_solid,'Value',1);
listbox_solid_Callback(hObject, eventdata, handles);

set(handles.listbox_units,'Value',1);
listbox_units_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cylinder_torsion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cylinder_torsion_OutputFcn(hObject, eventdata, handles) 
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

delete(cylinder_torsion);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');

fig_num=1;

iu=get(handles.listbox_units,'Value');
ng=get(handles.listbox_geometry,'Value');
ncross=get(handles.listbox_solid,'Value');

T=str2num(get(handles.edit_torque,'String'));


P=0;
ID=0;


if(ng==1)
    OD=str2num(get(handles.edit_OD,'String'));
    if(ncross==2)
        ID=str2num(get(handles.edit_ID,'String'));
    end    
    thick=(OD-ID)/2;
else
    OD=str2num(get(handles.edit_OD,'String'));
    if(ncross==2)
        thick=str2num(get(handles.edit_ID,'String'));   
        ID=OD-2*thick;
    end    
end

ODR=OD;
IDR=ID;
thickR=thick;

   
if(iu==2)
    OD=OD/1000;
    ID=ID/1000;
    thick=thick/1000;
end



J=(OD^4-ID^4)*pi/32;   % polar

R=OD/2;


tau_max=T*R/J;


if(iu==1)
   RR=R; 
   stress_unit='psi';
   torque_unit='in-lbf';
   length_unit='in';
   J_unit='in^4';
else
   RR=R*1000;
   stress_unit='Pa';
   torque_unit='N-m';   
   J_unit='m^4';
   length_unit='mm';   
end

if(ncross==2)
    out1=sprintf('Dimensions (%s)',length_unit);
    disp(out1);
    out1=sprintf(' OD=%7.3g,  ID=%7.3g,  thick=%7.3g ',ODR,IDR,thickR);
    disp(out1);
end 

disp(' ');
out1=sprintf(' Torque=%8.4g %s, J=%8.4g %s \n',T,torque_unit,J,J_unit);
disp(out1);

out1=sprintf(' R=%8.4g %s \n',RR,length_unit);
disp(out1);

out1=sprintf(' tau max=%8.4g %s',tau_max,stress_unit);
disp(out1);

if(iu==1)
    out1=sprintf('        =%8.4g ksi',tau_max/1000);
    disp(out1);    
end

if(ncross==2)
    P=str2num(get(handles.edit_internal_pressure,'String'));
    out1=sprintf('\n Internal Pressure=%8.4g %s \n',P,stress_unit);
    disp(out1);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

srr=0;
srt=tau_max;   % shear stress from torque

if(ncross==1)  % hoop stress
    stt=0;    
else
    stt=P*R/thick;
    disp(' ');
    out1=sprintf(' Hoop stress = %7.3g %s ',stt,stress_unit);
    disp(out1);
end

srx=0;
stx=0;

nends=get(handles.listbox_ends,'Value');

if(ncross==1) % solid
    sxx=0;
else % hollow
    if(nends==2) % closed
        disp(' closed ends ');
        sxx=P*R/(2*thick);
    else
        disp(' open ends ');        
        sxx=0;
    end    
end
    
str=srt;
sxr=srx;
sxt=stx;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A=[srr srt srx; str stt stx; sxr sxt sxx];

disp(' ');
disp('Stress Tensor');

A

[lambda,evector]=three_by_three_invariants(A);

disp(' ');   
disp(' Principal Stresses');
disp(' ');   

for i=1:length(lambda)
    out1=sprintf('%8.4g ',lambda(i));
    disp(out1);
end

disp(' ');
disp(' Eigenvectors, direction cosines of principal plane ');
disp('      (column format) ');
disp(' ');
    
evector


y=(lambda(1)-lambda(2))^2+(lambda(1)-lambda(3))^2+(lambda(2)-lambda(3))^2;
vMstress=sqrt(y/2);


mss=0.5*(lambda(1)-lambda(3));

out1=sprintf('\n Overall maximum shear stress = %8.4g %s',mss,stress_unit);
disp(out1);     
        
if(iu==1)
    out1=sprintf('                               =%8.4g ksi',mss/1000);
    disp(out1);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
out1=sprintf('\n von Mises stress = %8.4g %s',vMstress,stress_unit);
disp(out1);

if(iu==1)
    out1=sprintf('                  =%8.4g ksi',vMstress/1000);
    disp(out1);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L1=lambda(1);
L2=lambda(2);
L3=lambda(3);
        
[fig_num]=Mohrs_circle_3D(L1,L2,L3,fig_num);

msgbox('Results written to Command Window');

function edit_torque_Callback(hObject, eventdata, handles)
% hObject    handle to edit_torque (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_torque as text
%        str2double(get(hObject,'String')) returns contents of edit_torque as a double


% --- Executes during object creation, after setting all properties.
function edit_torque_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_torque (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

n=get(handles.listbox_geometry,'Value');

if(n==1)
    set(handles.text_inner_diameter,'String','Inner Diameter');
else    
    set(handles.text_inner_diameter,'String','Thickness');
end

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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

n=get(handles.listbox_units,'Value');

if(n==1)
    set(handles.text_torque_unit,'String','in-lbf');
    set(handles.text_dimension_OD,'String','in');
    set(handles.text_dimension_ID,'String','in');
    set(handles.text_psi2,'String','psi');
else
    set(handles.text_torque_unit,'String','N-m');
    set(handles.text_dimension_OD,'String','mm');
    set(handles.text_dimension_ID,'String','mm');    
    set(handles.text_psi2,'String','Pa');    
end





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


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= cylinder_torsion_image;
set(handles.s,'Visible','on'); 



function edit_OD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_OD as text
%        str2double(get(hObject,'String')) returns contents of edit_OD as a double


% --- Executes during object creation, after setting all properties.
function edit_OD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ID_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ID as text
%        str2double(get(hObject,'String')) returns contents of edit_ID as a double


% --- Executes during object creation, after setting all properties.
function edit_ID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_internal_pressure_Callback(hObject, eventdata, handles)
% hObject    handle to edit_internal_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_internal_pressure as text
%        str2double(get(hObject,'String')) returns contents of edit_internal_pressure as a double


% --- Executes during object creation, after setting all properties.
function edit_internal_pressure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_internal_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_solid.
function listbox_solid_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_solid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_solid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_solid

n=get(handles.listbox_solid,'Value');

if(n==1)
    set(handles.uipanel_internal_pressure,'Visible','off');
    
    set(handles.text_inner_diameter,'Visible','off');
    set(handles.edit_ID,'Visible','off');
    set(handles.text_dimension_ID,'Visible','off');
    
    set(handles.uipanel_geometry_type,'Visible','off');    
    
else
    set(handles.uipanel_internal_pressure,'Visible','on');   
    
    set(handles.text_inner_diameter,'Visible','on');
    set(handles.edit_ID,'Visible','on');
    set(handles.text_dimension_ID,'Visible','on');
    
    set(handles.uipanel_geometry_type,'Visible','on');      
end    
    

% --- Executes during object creation, after setting all properties.
function listbox_solid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_solid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ends.
function listbox_ends_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ends (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ends contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ends


% --- Executes during object creation, after setting all properties.
function listbox_ends_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ends (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
