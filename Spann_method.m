function varargout = Spann_method(varargin)
% SPANN_METHOD MATLAB code for Spann_method.fig
%      SPANN_METHOD, by itself, creates a new SPANN_METHOD or raises the existing
%      singleton*.
%
%      H = SPANN_METHOD returns the handle to a new SPANN_METHOD or the handle to
%      the existing singleton*.
%
%      SPANN_METHOD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPANN_METHOD.M with the given input arguments.
%
%      SPANN_METHOD('Property','Value',...) creates a new SPANN_METHOD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Spann_method_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Spann_method_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Spann_method

% Last Modified by GUIDE v2.5 06-Jul-2021 10:34:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Spann_method_OpeningFcn, ...
                   'gui_OutputFcn',  @Spann_method_OutputFcn, ...
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


% --- Executes just before Spann_method is made visible.
function Spann_method_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Spann_method (see VARARGIN)

% Choose default command line output for Spann_method
handles.output = hObject;

change(hObject, eventdata, handles);

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Spann_method wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)

n=get(handles.listbox_input,'Value');
m=get(handles.listbox_units,'Value');

method=get(handles.listbox_mass_method,'Value');
%

if(m==1)
    set(handles.text_mass,'String','Mass (lbm)');
    set(handles.text_area,'String','Surface Area (in^2)');
    set(handles.text_smd2,'String','(lbm/in^2)');
else
    set(handles.text_mass,'String','Mass (kg)');   
    set(handles.text_area,'String','Surface Area (m^2)'); 
    set(handles.text_smd2,'String','(kg/m^2)');    
end


if(n==1) % SPL
    
    ss='Input Array Name:  freq(Hz) & SPL(dB)';

else     % PSD
    
    if(m==1) % English
        ss='Input Array Name:  freq(Hz) & PSD (psi^2/Hz)';
    else     % metric
        ss='Input Array Name:  freq(Hz) & PSD (Pa^2/Hz)';
    end    
end

set(handles.text_input_array_name,'String',ss);

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_mass_method,'Visible','on');
set(handles.edit_smd,'Visible','on');
set(handles.text_smd1,'Visible','on');
set(handles.text_smd2,'Visible','on');

set(handles.edit_mass,'Visible','on');
set(handles.edit_area,'Visible','on');
set(handles.text_ma1,'Visible','on');
set(handles.text_mass,'Visible','on');
set(handles.text_area,'Visible','on');


if(method==1)
    set(handles.edit_smd,'Visible','off');
    set(handles.text_smd1,'Visible','off');
    set(handles.text_smd2,'Visible','off');
else
    set(handles.edit_mass,'Visible','off');
    set(handles.edit_area,'Visible','off');
    set(handles.text_ma1,'Visible','off');
    set(handles.text_mass,'Visible','off');
    set(handles.text_area,'Visible','off');    
end



% --- Outputs from this function are returned to the command line.
function varargout = Spann_method_OutputFcn(hObject, eventdata, handles) 
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

delete(Spann_method);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

n=get(handles.listbox_input,'Value');
iu=get(handles.listbox_units,'Value');

method=get(handles.listbox_mass_method,'Value');

Q=str2num(get(handles.edit_Q,'String'));
beta=str2num(get(handles.edit_beta,'String'));


if(method==1)
    mass=str2num(get(handles.edit_mass,'String'));
    area=str2num(get(handles.edit_area,'String'));
    if(iu==1)
        mass=mass/386;
    else
        mass=mass*9.81;
    end
    scale=(Q*beta*area/mass)^2;
else
    smd=str2num(get(handles.edit_smd,'String'));
    if(iu==1)
        smd=smd/386;
    else
        smd=smd*9.81;
    end    
    scale=(Q*beta/smd)^2;
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch
    warndlg('Input array not available');
    return;
end
    
THM=fix_size(THM);
sz=size(THM);   

num=sz(1);

Wa=zeros(num,2);


if(n==1) % spl
    
   if(iu==1) 
       Pref=2.9e-09;  % psi
   else
       Pref=20e-06;   % Pa
   end

   Wp=zeros(num,2);
   Wp(:,1)=THM(:,1);
   
   SPL=THM(:,2);
   
   x=2^(1/6)-1/(2^(1/6));
   
   for i=1:num
       dfc=Wp(i,1)*x;
       Wp(i,2)=(Pref^2/dfc)*10^(SPL(i)/10 );
   end
   
    suma=0.;
%
    for i=1:num
%
        rms = (10.^(SPL(i)/10));
        suma=suma+rms;
    end
%
    OASPL=10.*log10(suma);   
   
   
    figure(fig_num)
    fig_num=fig_num+1;
    plot(THM(:,1),THM(:,2));
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
    grid on;
    out1=sprintf(' One-Third Octave Sound Pressure Level  OASPL = %8.4g dB ',OASPL);
    title(out1)
    xlabel(' Center Frequency (Hz) ');
    ylabel(' SPL (dB) ');   
   
   

else     % pressure psd
   Wp=THM;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




Wa(:,1)=Wp(:,1);

num=sz(1);

for i=1:num
   Wa(i,2)=scale*Wp(i,2); 
end

if(iu==1)
    Wa(:,2)=Wa(:,2)/386^2;
else
    Wa(:,2)=Wa(:,2)/9.81^2;
end

[s,prms] = calculate_PSD_slopes_no(Wp(:,1),Wp(:,2));
[s,grms] = calculate_PSD_slopes_no(Wa(:,1),Wa(:,2));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fmin=Wa(1,1);
fmax=Wa(num,1);

if(fmin>20)
    fmin=20;
end
if(fmin>10 && fmin<20)
    fmin=10;
end

if(fmax<1000)
    fmax=1000;
end
if(fmax>1000 && fmax<2000)
    fmax=2000;
end
if(fmax>2000 && fmax<5000)
    fmax=5000;
end
if(fmax>5000 && fmax<10000)
    fmax=10000;
end
if(fmax>10000 && fmax<20000)
    fmax=20000;
end

if(iu==1)
    t_string = sprintf('Pressure Power Spectral Density  %7.3g psi RMS Overall',prms);
    y_label='Pressure (psi^2/Hz)';
else
    t_string = sprintf('Pressure Power Spectral Density  %7.3g Pa RMS Overall',prms);
    y_label='Pressure (Pa^2/Hz)';    
end    
    
x_label='Frequency (Hz)';

[fig_num,h]=plot_PSD_function(fig_num,x_label,y_label,t_string,Wp,fmin,fmax);



t_string = sprintf(' Acceleration Power Spectral Density  %7.3g GRMS Overall',grms);
x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';

[fig_num]=plot_PSD_function(fig_num,x_label,y_label,t_string,Wa,fmin,fmax);

setappdata(0,'Wa',Wa);
set(handles.uipanel_save,'Visible','on');
set(handles.pushbutton_stress_psd,'Enable','off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function change_units_input_type(hObject, eventdata, handles)
%
n=get(handles.listbox_input,'Value');
m=get(handles.listbox_units,'Value');
%

if(m==1)
    set(handles.text_mass,'String','Mass (lbm)');
    set(handles.text_area,'String','Surface Area (in^2)');
else
    set(handles.text_mass,'String','Mass (kg)');   
    set(handles.text_area,'String','Surface Area (m^2)');    
end


if(n==1) % SPL
    
    ss='Input Array Name:  freq(Hz) & SPL(dB)';

else     % PSD
    
    if(m==1) % English
        ss='Input Array Name:  freq(Hz) & PSD (psi^2/Hz)';
    else     % metric
        ss='Input Array Name:  freq(Hz) & PSD (Pa^2/Hz)';
    end    
end

set(handles.text_input_array_name,'String',ss);

set(handles.uipanel_save,'Visible','off');




% --- Executes on selection change in listbox_input.
function listbox_input_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input (see GCBO)
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



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_beta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beta as text
%        str2double(get(hObject,'String')) returns contents of edit_beta as a double


% --- Executes during object creation, after setting all properties.
function edit_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_area_Callback(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_area as text
%        str2double(get(hObject,'String')) returns contents of edit_area as a double


% --- Executes during object creation, after setting all properties.
function edit_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=getappdata(0,'Wa');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

set(handles.pushbutton_stress_psd,'Enable','on');

h = msgbox('Save Complete'); 


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_mass and none of its controls.
function edit_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_beta and none of its controls.
function edit_beta_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_area and none of its controls.
function edit_area_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on selection change in listbox_mass_method.
function listbox_mass_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mass_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mass_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mass_method
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_mass_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mass_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_smd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_smd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_smd as text
%        str2double(get(hObject,'String')) returns contents of edit_smd as a double


% --- Executes during object creation, after setting all properties.
function edit_smd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_smd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_stress_psd.
function pushbutton_stress_psd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stress_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=convert_acceleration_response_PSD_to_stress;
set(handles.s,'Visible','on');
