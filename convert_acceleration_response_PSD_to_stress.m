function varargout = convert_acceleration_response_PSD_to_stress(varargin)
% CONVERT_ACCELERATION_RESPONSE_PSD_TO_STRESS MATLAB code for convert_acceleration_response_PSD_to_stress.fig
%      CONVERT_ACCELERATION_RESPONSE_PSD_TO_STRESS, by itself, creates a new CONVERT_ACCELERATION_RESPONSE_PSD_TO_STRESS or raises the existing
%      singleton*.
%
%      H = CONVERT_ACCELERATION_RESPONSE_PSD_TO_STRESS returns the handle to a new CONVERT_ACCELERATION_RESPONSE_PSD_TO_STRESS or the handle to
%      the existing singleton*.
%
%      CONVERT_ACCELERATION_RESPONSE_PSD_TO_STRESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVERT_ACCELERATION_RESPONSE_PSD_TO_STRESS.M with the given input arguments.
%
%      CONVERT_ACCELERATION_RESPONSE_PSD_TO_STRESS('Property','Value',...) creates a new CONVERT_ACCELERATION_RESPONSE_PSD_TO_STRESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before convert_acceleration_response_PSD_to_stress_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to convert_acceleration_response_PSD_to_stress_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help convert_acceleration_response_PSD_to_stress

% Last Modified by GUIDE v2.5 06-Jul-2021 10:46:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @convert_acceleration_response_PSD_to_stress_OpeningFcn, ...
                   'gui_OutputFcn',  @convert_acceleration_response_PSD_to_stress_OutputFcn, ...
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


% --- Executes just before convert_acceleration_response_PSD_to_stress is made visible.
function convert_acceleration_response_PSD_to_stress_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to convert_acceleration_response_PSD_to_stress (see VARARGIN)

% Choose default command line output for convert_acceleration_response_PSD_to_stress
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');
listbox_material_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes convert_acceleration_response_PSD_to_stress wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = convert_acceleration_response_PSD_to_stress_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(convert_acceleration_response_PSD_to_stress);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
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

%%%%

fig_num=1;

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

n=length(THM(:,1));

if(THM(1,1)<1.0e-04)
    THM(1,1)=1.0e-04;
end


f=THM(:,1);
a=THM(:,2);

[~,arms] = calculate_PSD_slopes(f,a);

omega=2*pi*f;
%

E=str2num(get(handles.edit_em,'String'))
rho=str2num(get(handles.edit_md,'String'));

rho=rho/386

chat=str2num(get(handles.edit_chat,'String'));

Q2=(chat*sqrt(E*rho))^2

v=zeros(n,1);
%      
for i=1:n
    v(i)=a(i)/omega(i)^2;
end

v=v*386^2;

s=v*Q2/1000^2;  % ksi

[~,vrms] = calculate_PSD_slopes(f,v);
[~,srms] = calculate_PSD_slopes(f,s);



xlabel2='Frequency (Hz)';
nfont=11;

data1=[f a];
data2=[f v];

t_string1=sprintf('Acceleration PSD  %7.3g GRMS Overall',arms);
t_string2=sprintf('Velocity PSD  %7.3g (in/sec) RMS Overall',vrms);

ylabel1='Accel (G^2/Hz)';
ylabel2='Vel ((in/sec)^2/Hz))';

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

[fig_num,h2]=subplots_two_loglog_1x2_xlim_h2(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2,nfont,fmin,fmax);

set(h2, 'Position', [0 0 1000 400]);

%%

md=6;

t_string=sprintf('Stress PSD  %7.3g ksi RMS Overall',srms);
x_label='Frequency (Hz)';
y_label='Stress (ksi^2/Hz)';
ppp=[f s];
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%

setappdata(0,'velocity_psd',[f v]);
setappdata(0,'stress_psd',[f s])

set(handles.uipanel_save,'Visible','on');
set(handles.pushbutton_Dirlik,'Enable','off');


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


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
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

n=get(handles.listbox_type,'Value');

if(n==1)
    data=getappdata(0,'velocity_psd');
else
    data=getappdata(0,'stress_psd');   
end

output_name=get(handles.edit_output_name,'String');
assignin('base', output_name, data);

set(handles.pushbutton_Dirlik,'Enable','on');

msgbox('Save Complete');



function edit_output_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

iu=1;

imat=get(handles.listbox_material,'Value');


%%%
    

%%%%%%%%%%%%%%   
 
[elastic_modulus,mass_density,~]=six_materials(iu,imat);
 
%%%%
 
 
if(imat<=6)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
else
        ss1=' ';
        ss2=' ';
end
 
set(handles.edit_em,'String',ss1);
set(handles.edit_md,'String',ss2); 


%%%

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



function edit_chat_Callback(hObject, eventdata, handles)
% hObject    handle to edit_chat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_chat as text
%        str2double(get(hObject,'String')) returns contents of edit_chat as a double


% --- Executes during object creation, after setting all properties.
function edit_chat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_chat (see GCBO)
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

    A = imread('SV_relationship.png');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on button press in pushbutton_Dirlik.
function pushbutton_Dirlik_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Dirlik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_stress_psd_fatigue_nasgro;
set(handles.s,'Visible','on');
