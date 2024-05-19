function varargout = pipe_breakout_transmission_loss(varargin)
% PIPE_BREAKOUT_TRANSMISSION_LOSS MATLAB code for pipe_breakout_transmission_loss.fig
%      PIPE_BREAKOUT_TRANSMISSION_LOSS, by itself, creates a new PIPE_BREAKOUT_TRANSMISSION_LOSS or raises the existing
%      singleton*.
%
%      H = PIPE_BREAKOUT_TRANSMISSION_LOSS returns the handle to a new PIPE_BREAKOUT_TRANSMISSION_LOSS or the handle to
%      the existing singleton*.
%
%      PIPE_BREAKOUT_TRANSMISSION_LOSS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIPE_BREAKOUT_TRANSMISSION_LOSS.M with the given input arguments.
%
%      PIPE_BREAKOUT_TRANSMISSION_LOSS('Property','Value',...) creates a new PIPE_BREAKOUT_TRANSMISSION_LOSS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pipe_breakout_transmission_loss_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pipe_breakout_transmission_loss_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pipe_breakout_transmission_loss

% Last Modified by GUIDE v2.5 30-Jul-2019 15:42:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pipe_breakout_transmission_loss_OpeningFcn, ...
                   'gui_OutputFcn',  @pipe_breakout_transmission_loss_OutputFcn, ...
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


% --- Executes just before pipe_breakout_transmission_loss is made visible.
function pipe_breakout_transmission_loss_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pipe_breakout_transmission_loss (see VARARGIN)

% Choose default command line output for pipe_breakout_transmission_loss
handles.output = hObject;

change(hObject, eventdata, handles);

set(handles.pushbutton_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pipe_breakout_transmission_loss wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pipe_breakout_transmission_loss_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * ');
disp(' ');


fig_num=1;

iu=get(handles.listbox_units,'Value');
ioct=get(handles.listbox_bands,'Value');

[fc,imax]=octaves(ioct);

k=1;
for i=imax:-1:1
    if(fc(i)>=16 && fc(i)<=20000)
        f(k)=fc(i);
        k=k+1;
    end
end

f=fix_size(f);
f=flipud(f);

num=length(f);


t=str2num(get(handles.edit_thickness,'String'));

rho=str2num(get(handles.edit_md,'String'));


% rho_c=415;     % kg / (s m^2)

rho_c=str2num(get(handles.edit_rhoc,'String'));


if(iu==1)
    rho_c=rho_c*0.0014226;
else    
    t=t/1000;
end

 
m = rho*t;

% out1=sprintf('\n rho_c=%8.4g  m=%8.4g  m/rho_c=%8.4g \n',rho_c,m,m/rho_c);
% disp(out1);


TL=zeros(num,1);
ratio=zeros(num,1);

disp('  Freq(Hz)   TL(dB)    Ratio');

for i=1:num
    omega=2*pi*f(i);
   
    a=m^2*omega^2;
    b=12.7*rho_c^2;
    TL(i)=10*log10(a/b);
    ratio(i)=((omega*m)/(2*rho_c))^2;

    out1=sprintf('%8.4g \t %8.3g \t %8.3g',f(i),TL(i),ratio(i));
    disp(out1);
end    
    
ppp=[f TL];
t_string='Breakout Transmission Loss';
x_label='Center Frequency (Hz)';
y_label='TL (dB)';
fmin=f(1);
fmax=f(end);

[fig_num,h2]=plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);


setappdata(0,'ppp',ppp);
set(handles.pushbutton_save,'Enable','on');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(pipe_breakout_transmission_loss);


function change(hObject, eventdata, handles)

iu=get(handles.listbox_units,'Value');
imat=get(handles.listbox_material,'Value');

if(iu==1)
    set(handles.text_thickness,'String','Wall Thickness (in)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)');     
else
    set(handles.text_thickness,'String','Wall Thickness (mm)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');
end

%%%%

[~,mass_density,~]=six_materials(iu,imat);
 
%%%%
 
 
if(imat<=6)
    ss2=sprintf('%8.4g',mass_density);
else
    ss2=' ';  
end
 

set(handles.edit_md,'String',ss2); 

set(handles.pushbutton_save,'Enable','off');



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


% --- Executes on selection change in listbox_bands.
function listbox_bands_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bands (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bands contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bands
set(handles.pushbutton_save,'Enable','off');


% --- Executes during object creation, after setting all properties.
function listbox_bands_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bands (see GCBO)
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



function edit_rhoc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rhoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rhoc as text
%        str2double(get(hObject,'String')) returns contents of edit_rhoc as a double


% --- Executes during object creation, after setting all properties.
function edit_rhoc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rhoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('breakout_transmission_loss.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'ppp');

output_array=get(handles.edit_output_array_name,'String');
assignin('base', output_array, data);

msgbox('Save Complete');


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off');


% --- Executes on key press with focus on edit_md and none of its controls.
function edit_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off');


% --- Executes on key press with focus on edit_rhoc and none of its controls.
function edit_rhoc_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_rhoc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off');
