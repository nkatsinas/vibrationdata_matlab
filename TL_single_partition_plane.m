function varargout = TL_single_partition_plane(varargin)
% TL_SINGLE_PARTITION_PLANE MATLAB code for TL_single_partition_plane.fig
%      TL_SINGLE_PARTITION_PLANE, by itself, creates a new TL_SINGLE_PARTITION_PLANE or raises the existing
%      singleton*.
%
%      H = TL_SINGLE_PARTITION_PLANE returns the handle to a new TL_SINGLE_PARTITION_PLANE or the handle to
%      the existing singleton*.
%
%      TL_SINGLE_PARTITION_PLANE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TL_SINGLE_PARTITION_PLANE.M with the given input arguments.
%
%      TL_SINGLE_PARTITION_PLANE('Property','Value',...) creates a new TL_SINGLE_PARTITION_PLANE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TL_single_partition_plane_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TL_single_partition_plane_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TL_single_partition_plane

% Last Modified by GUIDE v2.5 31-Oct-2017 10:54:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TL_single_partition_plane_OpeningFcn, ...
                   'gui_OutputFcn',  @TL_single_partition_plane_OutputFcn, ...
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


% --- Executes just before TL_single_partition_plane is made visible.
function TL_single_partition_plane_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TL_single_partition_plane (see VARARGIN)

% Choose default command line output for TL_single_partition_plane
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TL_single_partition_plane wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TL_single_partition_plane_OutputFcn(hObject, eventdata, handles) 
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

delete(TL_single_partition_plane);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp(' * * * * * * ');
disp(' ');

fig_num=1;

iu=get(handles.listbox_units,'Value');
imat=get(handles.listbox_material,'Value');

imethod=get(handles.listbox_method,'Value');

h=str2num(get(handles.edit_thickness,'String'));
ho=h;

if(iu==2)
    h=h/1000;
end

if(imat<=6 || (imat==7 && imethod~=3))

    md=str2num(get(handles.edit_md,'String'));

    if(iu==1)
        md=md/386;
    end
    
    E=str2num(get(handles.edit_em,'String'));

    if(iu==2)
        [E]=GPa_to_Pa(E);
    end    

end


    
if(imat<=6)   

    E=str2num(get(handles.edit_em,'String'));

    if(iu==2)
        [E]=GPa_to_Pa(E);
    end
    
    CL=sqrt(E/md);
    R2=md*CL;
    
    if(iu==1)
        out1=sprintf('\n  CL=%8.4g in/sec',CL);
    else
        out1=sprintf('\n  CL=%8.4g  m/sec',CL);        
    end
    
    disp(out1);
    
else
        
    if(imethod==1)
        CL=sqrt(E/md);
    end
    if(imethod>=2)
        CL=str2num(get(handles.edit_speed,'String'));
    end  
    if(imethod<=2)
        R2=md*CL;  
    end    
    if(imethod==3)
        alpha=str2num(get(handles.edit_alpha,'String'));
        aa=1;
        bb=2-4/alpha;
        cc=1;
        R2=(-bb+sqrt(bb^2-4*aa*cc))/(2*aa);  % Crocker page 699, equation (8)
    end       
end

if(iu==1)
    R1=0.001529;  % psi sec/in
else
    R1=415;       % Pa sec/m
end

out1=sprintf('\n  R2/R1=%8.4g  \n',R2/R1);
disp(out1);

[~,fc,~,imax]=one_third_octave_frequencies();

L=h;

ff=zeros(imax,1);
TL=zeros(imax,1);

    for i=1:imax
        k2=2*pi*fc(i)/CL;
        ff(i)=fc(i);
        den=4*((cos(k2*L))^2) + ((R2/R1)^2)*((sin(k2*L))^2);
        tau=4/den;
        TL(i)=10*log10(1/tau);
    end

%%

transmission_loss=[ff TL];
setappdata(0,'transmission_loss',transmission_loss);

fmin=10;
fmax=20000;
if(iu==1)
    stitle=sprintf('Transmission Loss  %g inch thick',ho);
else
    stitle=sprintf('Transmission Loss  %g mm thick',ho);    
end
    
[fig_num]=tl_plot_title(fig_num,ff,TL,stitle,fmin,fmax);

set(handles.uipanel_export,'Visible','on');


    
function change(hObject, eventdata, handles)    

set(handles.uipanel_export,'Visible','off');

iu=get(handles.listbox_units,'Value');
imat=get(handles.listbox_material,'Value');


if(iu==1)
   set(handles.text_em,'String','Elastic Modulus (psi)');
   set(handles.text_md,'String','Mass Density (lbm/in^3)'); 
   set(handles.text_thickness,'String','Thickness (in)');  
   set(handles.text_speed,'String','Material Speed of Sound (in/sec)');     
else
   set(handles.text_em,'String','Elastic Modulus (GPa)'); 
   set(handles.text_md,'String','Mass Density (kg/m^3)');
   set(handles.text_thickness,'String','Thickness (mm)');  
   set(handles.text_speed,'String','Material Speed of Sound (m/sec)');    
end


set(handles.text_speed,'Visible','off');
set(handles.edit_speed,'Visible','off');

set(handles.text_alpha,'Visible','off');
set(handles.edit_alpha,'Visible','off');


%
%%%%

[elastic_modulus,mass_density,~]=six_materials(iu,imat);

if(imat<=6)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
        
        set(handles.text_method,'Visible','off');
        set(handles.listbox_method,'Visible','off');
        
else
        ss1=' ';
        ss2=' ';
        
        set(handles.text_method,'Visible','on');
        set(handles.listbox_method,'Visible','on'); 
        
        imethod=get(handles.listbox_method,'Value');
        
        
        set(handles.text_em,'Visible','off');
        set(handles.edit_em,'Visible','off');    
        
        if(imethod==1)
            
            set(handles.text_em,'Visible','on');
            set(handles.edit_em,'Visible','on');              
            
        end
        if(imethod>=2)
            set(handles.text_speed,'Visible','on');
            set(handles.edit_speed,'Visible','on');            
        end        
        if(imethod==3)
            set(handles.text_alpha,'Visible','on');
            set(handles.edit_alpha,'Visible','on');
        end        
end
 
set(handles.edit_em,'String',ss1);
set(handles.edit_md,'String',ss2); 



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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

change(hObject, eventdata, handles);


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



function edit_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_em_Callback(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_em as text
%        str2double(get(hObject,'String')) returns contents of edit_em as a double


% --- Executes during object creation, after setting all properties.
function edit_em_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md as text
%        str2double(get(hObject,'String')) returns contents of edit_md as a double


% --- Executes during object creation, after setting all properties.
function edit_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_speed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_speed as text
%        str2double(get(hObject,'String')) returns contents of edit_speed as a double


% --- Executes during object creation, after setting all properties.
function edit_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alpha as text
%        str2double(get(hObject,'String')) returns contents of edit_alpha as a double


% --- Executes during object creation, after setting all properties.
function edit_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_em and none of its controls.
function edit_em_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_md and none of its controls.
function edit_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_speed and none of its controls.
function edit_speed_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_alpha and none of its controls.
function edit_alpha_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'transmission_loss');
%

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('TL_single_partition_normal.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 
