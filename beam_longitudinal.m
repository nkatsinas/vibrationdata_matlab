function varargout = beam_longitudinal(varargin)
% BEAM_LONGITUDINAL MATLAB code for beam_longitudinal.fig
%      BEAM_LONGITUDINAL, by itself, creates a new BEAM_LONGITUDINAL or raises the existing
%      singleton*.
%
%      H = BEAM_LONGITUDINAL returns the handle to a new BEAM_LONGITUDINAL or the handle to
%      the existing singleton*.
%
%      BEAM_LONGITUDINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_LONGITUDINAL.M with the given input arguments.
%
%      BEAM_LONGITUDINAL('Property','Value',...) creates a new BEAM_LONGITUDINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_longitudinal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_longitudinal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_longitudinal

% Last Modified by GUIDE v2.5 12-Aug-2013 16:11:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_longitudinal_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_longitudinal_OutputFcn, ...
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


% --- Executes just before beam_longitudinal is made visible.
function beam_longitudinal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_longitudinal (see VARARGIN)

% Choose default command line output for beam_longitudinal
handles.output = hObject;

handles.unit=1;
handles.material=1;

% Update handles structure
guidata(hObject, handles);

units_change(hObject,eventdata,handles)

clear_answer(hObject, eventdata, handles)


clc;
bg = imread('beam_image_2.jpg');
image(bg);
axis off; 

% UIWAIT makes beam_longitudinal wait for user response (see UIRESUME)
% uiwait(handles.figure1);

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


% --- Outputs from this function are returned to the command line.
function varargout = beam_longitudinal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in left_BC_listbox.
function left_BC_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to left_BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns left_BC_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from left_BC_listbox
clear_answer(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function left_BC_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to left_BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in right_BC_listbox.
function right_BC_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to right_BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns right_BC_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from right_BC_listbox
clear_answer(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function right_BC_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to right_BC_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calculate_pushbutton.
function calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Answer,'Enable','on');

LBC=get(handles.left_BC_listbox,'Value');
RBC=get(handles.right_BC_listbox,'Value');

E=str2num(get(handles.elastic_modulus_edit,'String'));
rho=str2num(get(handles.mass_density_edit,'String'));
L=str2num(get(handles.length_edit,'String'));

if(handles.unit==1)
    rho=rho/386;
else
    [E]=GPa_to_Pa(E);
end

tpi=2*pi;

c=sqrt(E/rho);
term=pi*c/L;


if((LBC==1 && RBC==1)||(LBC==2 && RBC==2))  % fixed-fixed or free-free
   for n=1:3
       omega=n*term;
       fn(n)=omega/tpi;
   end
end

if((LBC==1 && RBC==2) || (LBC==2 && RBC==1)) % fixed-free
   for n=1:3
       omega=((2*n-1)/2)*term;
       fn(n)=omega/tpi;
   end
end

ss1=sprintf('natural frequencies = \n\n %8.4g Hz\n %8.4g Hz\n %8.4g Hz',...
                                                        fn(1),fn(2),fn(3));
                                                    
if(handles.unit==1)
    ss2=sprintf('wave speed = \n\n %8.4g in/sec',c);
else
    ss2=sprintf('wave speed = \n\n %8.4g m/sec',c);
end

ss3=sprintf('%s \n\n %s',ss1,ss2);
                                                    
set(handles.Answer,'String',ss3);




% --- Executes on button press in reset_pushbutton.
function reset_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to reset_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);

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
clear_answer(hObject, eventdata, handles)

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


% --- Executes on key press with focus on elastic_modulus_edit and none of its controls.
function elastic_modulus_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)

% --- Executes on key press with focus on length_edit and none of its controls.
function length_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to length_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


function clear_answer(hObject, eventdata, handles)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');
% Update handles structure
guidata(hObject, handles);



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


% --- Executes on key press with focus on mass_density_edit and none of its controls.
function mass_density_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles)


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(beam_longitudinal);
