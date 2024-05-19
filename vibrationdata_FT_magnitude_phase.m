function varargout = vibrationdata_FT_magnitude_phase(varargin)
% VIBRATIONDATA_FT_MAGNITUDE_PHASE MATLAB code for vibrationdata_FT_magnitude_phase.fig
%      VIBRATIONDATA_FT_MAGNITUDE_PHASE, by itself, creates a new VIBRATIONDATA_FT_MAGNITUDE_PHASE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FT_MAGNITUDE_PHASE returns the handle to a new VIBRATIONDATA_FT_MAGNITUDE_PHASE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FT_MAGNITUDE_PHASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FT_MAGNITUDE_PHASE.M with the given input arguments.
%
%      VIBRATIONDATA_FT_MAGNITUDE_PHASE('Property','Value',...) creates a new VIBRATIONDATA_FT_MAGNITUDE_PHASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_FT_magnitude_phase_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_FT_magnitude_phase_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_FT_magnitude_phase

% Last Modified by GUIDE v2.5 15-Nov-2016 10:10:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_FT_magnitude_phase_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_FT_magnitude_phase_OutputFcn, ...
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


% --- Executes just before vibrationdata_FT_magnitude_phase is made visible.
function vibrationdata_FT_magnitude_phase_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_FT_magnitude_phase (see VARARGIN)

% Choose default command line output for vibrationdata_FT_magnitude_phase
handles.output = hObject;

set(handles.listbox_method,'Value',1);
set(handles.listbox_frequency_limits,'Value',1);

listbox_frequency_limits_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_FT_magnitude_phase wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_FT_magnitude_phase_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_FT_magnitude_phase);

% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

t_string=get(handles.edit_title,'String');

m=get(handles.listbox_frequency_limits,'Value');

ntype=get(handles.listbox_axis_type,'Value');


fig_num=1;

k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

sz=size(THM);
%
n=sz(1);
ff=THM(:,1);
frf_m=THM(:,2);
frf_p=THM(:,3);
%
scale=pi/180;
%
frf_real=zeros(n,1);
frf_imag=zeros(n,1);
%
for i=1:n
    ff(i)=THM(i,1);
    theta=scale*frf_p(i);
    frf_real(i)=frf_m(i)*cos(theta);
    frf_imag(i)=frf_m(i)*sin(theta);
%
end 
%

if(m==1)  % automatic
    f1=10^(floor(log10(min(ff))));
    f2=10^(ceil(log10(max(ff))));
else    
    f1=str2num(get(handles.edit_start_frequency,'String'));
    f2=str2num(get(handles.edit_end_frequency,'String'));
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

[fig_num]=FRF_plots_two(ff,frf_m,frf_p,frf_real,frf_imag,ntype,t_string,f1,f2,fig_num);



% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

n=get(hObject,'Value');

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g %g',[3 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end


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



function edit_start_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_start_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_start_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_end_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_end_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency_limits.
function listbox_frequency_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_limits
n=get(handles.listbox_frequency_limits,'Value');
 
if(n==1) % auto
    set(handles.text_start_frequency,'Visible','off');
    set(handles.text_end_frequency,'Visible','off');
    set(handles.edit_start_frequency,'Visible','off');
    set(handles.edit_end_frequency,'Visible','off');    
else % manual
    set(handles.text_start_frequency,'Visible','on');
    set(handles.text_end_frequency,'Visible','on');
    set(handles.edit_start_frequency,'Visible','on');
    set(handles.edit_end_frequency,'Visible','on');      
end


% --- Executes during object creation, after setting all properties.
function listbox_frequency_limits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_axis_type.
function listbox_axis_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_axis_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_axis_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_axis_type


% --- Executes during object creation, after setting all properties.
function listbox_axis_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_axis_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
