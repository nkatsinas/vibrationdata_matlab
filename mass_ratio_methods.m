function varargout = mass_ratio_methods(varargin)
% MASS_RATIO_METHODS MATLAB code for mass_ratio_methods.fig
%      MASS_RATIO_METHODS, by itself, creates a new MASS_RATIO_METHODS or raises the existing
%      singleton*.
%
%      H = MASS_RATIO_METHODS returns the handle to a new MASS_RATIO_METHODS or the handle to
%      the existing singleton*.
%
%      MASS_RATIO_METHODS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MASS_RATIO_METHODS.M with the given input arguments.
%
%      MASS_RATIO_METHODS('Property','Value',...) creates a new MASS_RATIO_METHODS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mass_ratio_methods_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mass_ratio_methods_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mass_ratio_methods

% Last Modified by GUIDE v2.5 05-Jan-2016 15:30:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mass_ratio_methods_OpeningFcn, ...
                   'gui_OutputFcn',  @mass_ratio_methods_OutputFcn, ...
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


% --- Executes just before mass_ratio_methods is made visible.
function mass_ratio_methods_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mass_ratio_methods (see VARARGIN)

% Choose default command line output for mass_ratio_methods
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mass_ratio_methods wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mass_ratio_methods_OutputFcn(hObject, eventdata, handles) 
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

delete(mass_ratio_methods);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('   ');
disp(' * * * ');
disp('   ');


ia=get(handles.listbox_amp,'Value');
iu=get(handles.listbox_units,'Value');
im=get(handles.listbox_method,'Value');

try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

  f=THM(:,1);
amp=THM(:,2);

M1=str2num(get(handles.edit_M1,'String'));
M2=str2num(get(handles.edit_M2,'String'));
    
if(im==2)
    A2=str2num(get(handles.edit_A2,'String'));
    
    if(iu==2)
       A2=A2/100^2; 
    end
    
    M2=M2/A2;
end

F=M1/(M1+M2);

sc=amp*F;

V=[f sc];

out1=sprintf(' Scale Factor = %8.4g ',F);
out2=sprintf('              = %8.4g dB \n',20*log10(F));

disp(out1);
disp(out2);

if(ia==1)
    t_string='Power Spectrum';
    disp('      Power Spectrum ');
else
    t_string='Power Spectral Density';    
    disp('    Power Spectral Density ');    
end
disp(' ');


    disp('    Freq     Unloaded   Loaded ');

if(ia==1)
    disp('    (Hz)      (G^2)      (G^2)');
else
    disp('    (Hz)     (G^2/Hz)   (G^2/Hz)')   
end 

for i=1:length(f)
   fprintf(' %8.4g  %8.4g  %8.4g \n',f(i),amp(i),sc(i)); 
end    

disp(' ');

if(ia==2 && length(f) >-2 )
   
    [~,grms_1] = calculate_PSD_slopes_no(f,amp);
    [~,grms_2] = calculate_PSD_slopes_no(f,sc);
    
    disp(' ');    
    disp(' Overall acceleration levels ');
    disp(' ');
    fprintf(' Unloaded Structure = %8.4g GRMS \n',grms_1);  
    fprintf('   Loaded Structure = %8.4g GRMS \n',grms_2);   
    disp(' ');
end

if(ia==1)
    scaled_ps=V;
    disp(' Output loaded power spectrum array:  scaled_ps');
    assignin('base', 'scaled_ps',scaled_ps);
    y_label='Accel (GRMS^2)';
else
    scaled_psd=V;    
    disp(' Output loaded psd array:  scaled_psd');  
    assignin('base', 'scaled_psd',scaled_psd);    
    y_label='Accel (G^2/Hz)';    
end 

fig_num=1;
x_label='Frequency (Hz)';

leg1=sprintf('Unloaded %7.3g GRMS',grms_1);
leg2=sprintf('Loaded %7.3g GRMS',grms_2);
md=4;

ppp1=THM;
ppp2=V;

fmin=min(f);
fmax=max(f);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

msgbox('Output data written to Command Window');


function change(hObject, eventdata, handles)
%
ia=get(handles.listbox_amp,'Value');
iu=get(handles.listbox_units,'Value');
im=get(handles.listbox_method,'Value');

set(handles.text_A0,'Visible','off');
set(handles.text_A2,'Visible','off');
set(handles.edit_A2,'Visible','off');


if(im==1) % Mass ratio
    if(iu==1)
        set(handles.text_M1,'String','Bare Structure Mass (lbm)');
        set(handles.text_M2,'String','Equipment Mass (lbm)');
    else
        set(handles.text_M1,'String','Bare Structure Mass (kg)');
        set(handles.text_M2,'String','Equipment Mass (kg)');        
    end
else  % Mass area density ratio
        
    if(iu==1)
        set(handles.text_M1,'String','Bare Structure Mass/Area (lbm/in^2)');
        set(handles.text_M2,'String','Equipment Mass (lbm)'); 
        set(handles.text_A2,'String','Area (in^2)');        
    else
        set(handles.text_M1,'String','Bare Structure Mass/Area (kg/m^2)');
        set(handles.text_M2,'String','Equipment Mass (kg)');
        set(handles.text_A2,'String','Area (cm^2)');        
    end
    
    set(handles.text_A0,'Visible','on');    
    set(handles.text_A2,'Visible','on');
    set(handles.edit_A2,'Visible','on');    
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


% --- Executes on selection change in listbox_amp.
function listbox_amp_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amp
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_M1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_M1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_M1 as text
%        str2double(get(hObject,'String')) returns contents of edit_M1 as a double


% --- Executes during object creation, after setting all properties.
function edit_M1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_M1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_M2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_M2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_M2 as text
%        str2double(get(hObject,'String')) returns contents of edit_M2 as a double


% --- Executes during object creation, after setting all properties.
function edit_M2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_M2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_A2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_A2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_A2 as text
%        str2double(get(hObject,'String')) returns contents of edit_A2 as a double


% --- Executes during object creation, after setting all properties.
function edit_A2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_A2 (see GCBO)
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

A = imread('mass_loading.jpg');
figure(999) 
imshow(A,'border','tight','InitialMagnification',100) 
