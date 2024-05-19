function varargout = vibrationdata_rectangular_plate_uniform_pressure_PSD(varargin)
% VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_PSD MATLAB code for vibrationdata_rectangular_plate_uniform_pressure_PSD.fig
%      VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_PSD, by itself, creates a new VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_PSD or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_PSD returns the handle to a new VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_PSD or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_PSD.M with the given input arguments.
%
%      VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_PSD('Property','Value',...) creates a new VIBRATIONDATA_RECTANGULAR_PLATE_UNIFORM_PRESSURE_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_rectangular_plate_uniform_pressure_PSD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_rectangular_plate_uniform_pressure_PSD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_rectangular_plate_uniform_pressure_PSD

% Last Modified by GUIDE v2.5 05-Aug-2021 12:11:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_rectangular_plate_uniform_pressure_PSD_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_rectangular_plate_uniform_pressure_PSD_OutputFcn, ...
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


% --- Executes just before vibrationdata_rectangular_plate_uniform_pressure_PSD is made visible.
function vibrationdata_rectangular_plate_uniform_pressure_PSD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_rectangular_plate_uniform_pressure_PSD (see VARARGIN)

% Choose default command line output for vibrationdata_rectangular_plate_uniform_pressure_PSD
handles.output = hObject;

n_units=getappdata(0,'n_units');

if(n_units==1)
    ss='The input array must have two columns:  Freq (Hz) & Pressure (psi^2/Hz)';
else
    ss='The input array must have two columns:  Freq (Hz) & Pressure (Pa^2/Hz)';
end

set(handles.text_input_text,'String',ss);
    
set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_rectangular_plate_uniform_pressure_PSD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_rectangular_plate_uniform_pressure_PSD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function pushbutton_calculate_Callback(hObject, eventdata, handles)
% --- Executes on button press in pushbutton_calculate.
 
% hObject    handle to pushbutton_calculate (see GCBO)
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



fig_num=10;
nni=get(handles.listbox_interpolate,'Value');


disp_power_trans=getappdata(0,'displacement_power_transfer');  
vM_power_trans=getappdata(0,'stress_power_transfer');

Hxx_power_trans=getappdata(0,'Hxx_power_trans');
Hyy_power_trans=getappdata(0,'Hyy_power_trans');
Hxy_power_trans=getappdata(0,'Hxy_power_trans');




x=getappdata(0,'x'); 
y=getappdata(0,'y'); 
n_units=getappdata(0,'n_units');

FS=get(handles.edit_input_array_name,'String');

try
    THM=evalin('base',FS);  
catch
    warndlg('Input array not found');
    return;
end

fb=THM(:,1);
b=THM(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fa=disp_power_trans(:,1);
a=disp_power_trans(:,2);

[ppp,rms]=power_transmissibility_mult_function(fa,a,fb,b,nni);


if(n_units==1)
    t_string=sprintf('Displacement Response PSD  (x=%g, y=%g in) \n %7.4g in rms overall',x,y,rms);
    y_label='Disp (in^2/Hz)';
    fprintf('\n  Overall displacement = %8.4g inch 3-sigma\n',3*rms);
else
    t_string=sprintf('Displacement Response PSD  (x=%g, y=%g m) \n %7.4g mm rms overall',x,y,rms);   
    y_label='Disp (mm^2/Hz)'; 
    fprintf('\n  Overall displacement = %8.4g mm 3-sigma\n',3*rms);    
end
    
x_label='Frequency (Hz)';

md=7;

fc=ppp(:,1);

fmin=fc(1);
fmax=fc(end);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

setappdata(0,'disp_psd',ppp);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fa=Hxx_power_trans(:,1);
ax=Hxx_power_trans(:,2);
ay=Hyy_power_trans(:,2);

[pppx,rmsx]=power_transmissibility_mult_function(fa,ax,fb,b,nni);
[pppy,rmsy]=power_transmissibility_mult_function(fa,ay,fb,b,nni);


if(n_units==1)
    t_string=sprintf('Stress Response PSD  (x=%g, y=%g in)',x,y);
    y_label='Stress (psi^2/Hz)';
    uu='psi';
else
    t_string=sprintf('Stress Response PSD  (x=%g, y=%g m)',x,y);   
    y_label='Stress (Pa^2/Hz)';
    uu='Pa ';
end


ppp1=pppx;
ppp2=pppy;

leg1=sprintf('SXX %7.3g %s RMS',rmsx,uu);
leg2=sprintf('SYY %7.3g %s RMS',rmsy,uu);


md=7;

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fa=vM_power_trans(:,1);
a=vM_power_trans(:,2);


[ppp,rms]=power_transmissibility_mult_function(fa,a,fb,b,nni);


if(n_units==1)
    t_string=sprintf('von Mises Stress Response PSD  (x=%g, y=%g in) \n %7.4g psi rms overall',x,y,rms);
    y_label='Stress (psi^2/Hz)';
else
    t_string=sprintf('von Mises Stress Response PSD  (x=%g, y=%g m) \n %7.4g Pa rms overall',x,y,rms);   
    y_label='Stress (Pa^2/Hz)';    
end
    
x_label='Frequency (Hz)';

md=7;

fc=ppp(:,1);

fmin=fc(1);
fmax=fc(end);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


setappdata(0,'stress_psd',ppp);

set(handles.uipanel_save,'Visible','on');

set(handles.pushbutton_Dirlik,'Enable','off');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_rectangular_plate_uniform_pressure_PSD);



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_interpolate.
function listbox_interpolate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_interpolate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_interpolate


% --- Executes during object creation, after setting all properties.
function listbox_interpolate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'disp_psd');
else
    data=getappdata(0,'stress_psd');    
end

output_name=strtrim(get(handles.edit_output_array_name,'String'));

assignin('base', output_name, data);


set(handles.pushbutton_Dirlik,'Enable','on');

h = msgbox('Save Complete'); 



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


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Dirlik.
function pushbutton_Dirlik_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Dirlik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=vibrationdata_stress_psd_fatigue_nasgro;
set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_model.
function listbox_model_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_model contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_model


% --- Executes during object creation, after setting all properties.
function listbox_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
