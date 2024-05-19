function varargout = sine_multiple_columns(varargin)
% SINE_MULTIPLE_COLUMNS MATLAB code for sine_multiple_columns.fig
%      SINE_MULTIPLE_COLUMNS, by itself, creates a new SINE_MULTIPLE_COLUMNS or raises the existing
%      singleton*.
%
%      H = SINE_MULTIPLE_COLUMNS returns the handle to a new SINE_MULTIPLE_COLUMNS or the handle to
%      the existing singleton*.
%
%      SINE_MULTIPLE_COLUMNS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINE_MULTIPLE_COLUMNS.M with the given input arguments.
%
%      SINE_MULTIPLE_COLUMNS('Property','Value',...) creates a new SINE_MULTIPLE_COLUMNS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sine_multiple_columns_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sine_multiple_columns_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sine_multiple_columns

% Last Modified by GUIDE v2.5 10-May-2017 15:37:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sine_multiple_columns_OpeningFcn, ...
                   'gui_OutputFcn',  @sine_multiple_columns_OutputFcn, ...
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


% --- Executes just before sine_multiple_columns is made visible.
function sine_multiple_columns_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sine_multiple_columns (see VARARGIN)

% Choose default command line output for sine_multiple_columns
handles.output = hObject;

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

set(handles.listbox_coordinates,'Value',1);

listbox_coordinates_Callback(hObject, eventdata, handles);

listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sine_multiple_columns wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sine_multiple_columns_OutputFcn(hObject, eventdata, handles) 
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

fig_num=1;

tmax=str2num(get(handles.edit_duration,'String'));

sr=str2num(get(handles.edit_sr,'String'));
dt=1/sr;

nt=floor(tmax/dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


m=get(handles.listbox_coordinates,'Value');
N=m;
NC=N+1;

A=char(get(handles.uitable_coordinates,'Data'));

B=str2num(A);

freq=B(1:N);
amp=B((N+1):(2*N));
phase=B((2*N+1):(3*N));

freq=fix_size(freq);
amp=fix_size(amp);
phase=fix_size(phase);



%%

if(max(freq)>(sr/10))
       sr=max(fff)*10;
       dt=1/sr;
       msgbox('Note: sample rate increased ','Warning','warn');
       out1=sprintf('%8.4g',sr);
       set(handles.edit_sr,'String',out1);
end

%%

tpi=2.*pi;

freq=tpi*freq;
phase=phase*pi/180;

sine_array=zeros(nt,NC);

sine_array(:,1)=linspace(0,(nt-1)*dt,nt);

for i=1:N
    for j=1:nt
        t=sine_array(j,1);
        sine_array(j,i+1)=amp(i)*sin(freq(i)*t+phase(i));
    end    
end

t_string1='First Sine';
t_string2='Second Sine';
t_string3='Third Sine';

ylabel1=' ';
ylabel2=' ';
ylabel3=' ';

if(N==1)
    figure(fig_num);
    fig_num=fig_num+1;
    plot(sine_array(:,1),sine_array(:,2));
    xlabel('Time (sec)');
    title('Sine Function');

end
if(N==2)
    data1=[sine_array(:,1) sine_array(:,2) ];
    data2=[sine_array(:,1) sine_array(:,3) ];
    xlabel2='Time (sec)';
    [fig_num]=subplots_two_linlin_two_titles_scale(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);    
end
if(N==3)
    data1=[sine_array(:,1) sine_array(:,2) ];
    data2=[sine_array(:,1) sine_array(:,3) ];
    data3=[sine_array(:,1) sine_array(:,4) ];
    xlabel3='Time (sec)';    
    [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3)
end

setappdata(0,'sine_array',sine_array);

msgbox('Calculation Complete');

set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save,'Enable','on');  

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(sine_multiple_columns);


function edit_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
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
 
    
listbox_time_Callback(hObject, eventdata, handles);

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

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
data=getappdata(0,'sine_array');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);


out1=sprintf('\n  Data saved as:  %s  \n',output_name);
disp(out1);

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


% --- Executes on selection change in listbox_coordinates.
function listbox_coordinates_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_coordinates contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_coordinates

m=get(handles.listbox_coordinates,'Value');
n=m;

for i = 1:n
   for j=1:3
      data_s{i,j} = '';     
   end 
end
set(handles.uitable_coordinates,'Data',data_s);

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');


% --- Executes during object creation, after setting all properties.
function listbox_coordinates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_number_octaves_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number_octaves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number_octaves as text
%        str2double(get(hObject,'String')) returns contents of edit_number_octaves as a double


% --- Executes during object creation, after setting all properties.
function edit_number_octaves_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_octaves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_direction.
function listbox_direction_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_direction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_direction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_direction


% --- Executes during object creation, after setting all properties.
function listbox_direction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_direction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_time.
function listbox_time_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_time contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_time


% --- Executes during object creation, after setting all properties.
function listbox_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_spectral.
function listbox_spectral_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_spectral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_spectral contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_spectral


% --- Executes during object creation, after setting all properties.
function listbox_spectral_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_spectral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
