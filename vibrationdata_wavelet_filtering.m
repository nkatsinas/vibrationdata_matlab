function varargout = vibrationdata_wavelet_filtering(varargin)
% VIBRATIONDATA_WAVELET_FILTERING MATLAB code for vibrationdata_wavelet_filtering.fig
%      VIBRATIONDATA_WAVELET_FILTERING, by itself, creates a new VIBRATIONDATA_WAVELET_FILTERING or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_WAVELET_FILTERING returns the handle to a new VIBRATIONDATA_WAVELET_FILTERING or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_WAVELET_FILTERING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_WAVELET_FILTERING.M with the given input arguments.
%
%      VIBRATIONDATA_WAVELET_FILTERING('Property','Value',...) creates a new VIBRATIONDATA_WAVELET_FILTERING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_wavelet_filtering_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_wavelet_filtering_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_wavelet_filtering

% Last Modified by GUIDE v2.5 08-Oct-2019 14:06:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_wavelet_filtering_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_wavelet_filtering_OutputFcn, ...
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


% --- Executes just before vibrationdata_wavelet_filtering is made visible.
function vibrationdata_wavelet_filtering_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_wavelet_filtering (see VARARGIN)

% Choose default command line output for vibrationdata_wavelet_filtering
handles.output = hObject;

listbox_num_arrays_Callback(hObject, eventdata, handles);

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_wavelet_filtering wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_wavelet_filtering_OutputFcn(hObject, eventdata, handles) 
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
% handles    structure with h
delete(vibrationdata_wavelet_filtering);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

 
Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );


for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end



%%%

    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    N=get(handles.listbox_num,'Value');    
    
    fc=zeros(N,1);
    sd=zeros(N,1);    
    nwave=zeros(N,1);
    
    k=1;
    
    for i=1:N
        aaa=A(k,:); k=k+1;
        fc(i) = str2double(strtrim(aaa)); 
    end
    for i=1:N
        aaa=A(k,:); k=k+1;
        sd(i) = str2double(strtrim(aaa)); 
    end  
    for i=1:N
        aaa=A(k,:); k=k+1;
        nwave(i) = round(str2double(strtrim(aaa)));
    end     

%%%

t1=str2num(get(handles.edit_t1,'String'));
t2=str2num(get(handles.edit_t2,'String'));

minw=str2num(get(handles.edit_minw,'String'));
maxw=str2num(get(handles.edit_maxw,'String'));

iunit=get(handles.listbox_units,'Value');
 
start_time=str2num(get(handles.edit_start_time,'String'));

nt=str2num(get(handles.edit_ntrials,'String'));
 
fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


data=get(handles.uitable_array_names,'Data');
A=char(data);
setappdata(0,'data',data);
    
Narrays=get(handles.listbox_num_arrays,'Value');    
    
k=1;
    
for i=1:Narrays
    aaa=A(k,:); k=k+1;
    array{i} = strtrim(aaa); 
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

for iv=1:Narrays

    try
        FS=array{iv};
        THM=evalin('base',FS);
    catch
        warndlg('Array does not exist');
        return;    
    end


    THM=fix_size(THM);

    t_string=FS;
    t_string=strrep(t_string,'_',' ');     
    
    
    figure(fig_num);
    fig_num=fig_num+1;
    plot(THM(:,1),THM(:,2));
    grid on;
    xlabel('Time (sec)');
 
    if(iunit<=2)
        ylabel('Accel (G)');
    else
        ylabel('Accel (m/sec^2)');    
    end
 
    title(t_string);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    sz=size(THM); 
    num=sz(1);
 
    dur=THM(num,1)-THM(1,1);
    dt=dur/(num-1);


    THM_orig=THM;

    [~,i1]=min(abs(THM(:,1)-t1));
    [~,i2]=min(abs(THM(:,1)-t2));

    THM=THM(i1:i2,:);
 
    first=4./dur;
 
    tr=THM(:,1); 
    store_recon=THM(:,2);   

    [acceleration,velocity,displacement,wavelet_table]=...
    vibrationdata_wavelet_decomposition_engine_filter(tr,store_recon,dt,first,...
                                        iunit,nt,start_time,minw,maxw,fc,sd,nwave);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    residual=THM_orig;

    residual(i1:i2,2)=residual(i1:i2,2)-acceleration(:,2);
    rrr(:,1)=residual(i1:i2,1);
    rrr(:,2)=residual(i1:i2,2);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    figure(fig_num)
    fig_num=fig_num+1;
    plot(acceleration(:,1),acceleration(:,2),'r',THM(:,1),THM(:,2),'b');
    ttt=sprintf('Input & Synth Accel %s',t_string);
    title(ttt);
    legend('Wavelet Series','Input Data');
    grid on;
    xlabel('Time(sec)');
    if(iunit<=2)
        ylabel('Accel(G)');
        ylabel1='Accel(G)';
        ylabel2='Accel(G)';  
        ylabel3='Accel(G)'; 
    else
        ylabel('Accel(m/sec^2)'); 
        ylabel1='Accel(m/sec^2)';
        ylabel2='Accel(m/sec^2)';      
        ylabel3='Accel(m/sec^2)';          
    end   

xlabel2='Time (sec)';
data1=THM;
data2=acceleration;
t_string1='Input';
t_string2='Acceleration Synthesis';


[fig_num]=subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);

data3=rrr;
t_string3='Residual';
[fig_num]=subplots_three_linlin_three_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);


%%%%%%%%%%%%%%%

tt=acceleration(:,1);
a=acceleration(:,2);
v=velocity(:,2);
d=displacement(:,2);

if(iunit<=2)
    ay='Accel(G)';
else
    ay='Accel(m/sec^2)';    
end   

if(iunit==1)
    vy='Velocity(in/sec)';
else
    vy='Velocity(cm/sec)'; 
end

if(iunit==1)
    dy='Disp(inch)';
else
    dy='Disp(mm)';
end



aat=sprintf('Synth Accel %s',t_string);
vvt=sprintf('Synth Velox %s',t_string);
ddt=sprintf('Synth Disp %s',t_string);


[fig_num,hp]=plot_avd_time_histories_subplots_altp_titles_iu(fig_num,tt,a,v,d,ay,vy,dy,aat,vvt,ddt,iunit);


 
%%%%%%%%%%%%%%%

    figure(fig_num)
    fig_num=fig_num+1;
    plot(residual(:,1),residual(:,2));
    ttt=sprintf('Residual Accel %s',t_string);
    title(ttt);
    grid on;
    xlabel('Time(sec)');
    if(iunit<=2)
        ylabel('Accel(G)');
    else
        ylabel('Accel(m/sec^2)');    
    end   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    prefix=FS;

    output_name_1=sprintf('%s_syn',prefix);
    output_name_2=sprintf('%s_res',prefix);
    output_name_3=sprintf('%s_table',prefix);    

    assignin('base', output_name_1, acceleration);
    assignin('base', output_name_2, residual);
    assignin('base', output_name_3, wavelet_table);
    
end
    
disp(' ');
disp(' Output arrays');
disp(' ');

for iv=1:Narrays

    prefix=array{iv};

    output_name_1=sprintf('%s_syn',prefix);
    output_name_2=sprintf('%s_res',prefix);
    output_name_3=sprintf('%s_table',prefix);
    
    disp(output_name_1);
    disp(output_name_2);
    disp(output_name_3);
    
end

pushbutton_save_model_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_output_array,'value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
end
if(n==4)
    data=getappdata(0,'shock_response_spectrum');
end
if(n==5)
    data=getappdata(0,'wavelet_table');
end
if(n==6)
    data=getappdata(0,'residual');
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 



% --- Executes on selection change in listbox_output_array.
function listbox_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_array


% --- Executes during object creation, after setting all properties.
function listbox_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_number_wavelets_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number_wavelets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number_wavelets as text
%        str2double(get(hObject,'String')) returns contents of edit_number_wavelets as a double


% --- Executes during object creation, after setting all properties.
function edit_number_wavelets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_wavelets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trials_per_wavelet_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trials_per_wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trials_per_wavelet as text
%        str2double(get(hObject,'String')) returns contents of edit_trials_per_wavelet as a double


% --- Executes during object creation, after setting all properties.
function edit_trials_per_wavelet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials_per_wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


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



function edit_ffmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ffmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ffmin as text
%        str2double(get(hObject,'String')) returns contents of edit_ffmin as a double


% --- Executes during object creation, after setting all properties.
function edit_ffmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ffmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ffmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ffmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ffmax as text
%        str2double(get(hObject,'String')) returns contents of edit_ffmax as a double


% --- Executes during object creation, after setting all properties.
function edit_ffmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ffmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_start_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_time as text
%        str2double(get(hObject,'String')) returns contents of edit_start_time as a double


% --- Executes during object creation, after setting all properties.
function edit_start_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_freq.
function listbox_freq_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_freq contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_freq


% --- Executes during object creation, after setting all properties.
function listbox_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_minw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_minw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_minw as text
%        str2double(get(hObject,'String')) returns contents of edit_minw as a double


% --- Executes during object creation, after setting all properties.
function edit_minw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_minw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_maxw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_maxw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_maxw as text
%        str2double(get(hObject,'String')) returns contents of edit_maxw as a double


% --- Executes during object creation, after setting all properties.
function edit_maxw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_maxw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num

%%%%
 
Nrows=get(handles.listbox_num,'Value');
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end
 
set(handles.uitable_data,'Data',data_s);






% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ntrials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ntrials as text
%        str2double(get(hObject,'String')) returns contents of edit_ntrials as a double


% --- Executes during object creation, after setting all properties.
function edit_ntrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_arrays.
function listbox_num_arrays_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_arrays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_arrays contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_arrays

cn={'Array Name'};

%%%%
 
Nrows=get(handles.listbox_num_arrays,'Value');
Ncolumns=1;
 
A=get(handles.uitable_array_names,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end
 
set(handles.uitable_array_names,'Data',data_s,'ColumnName',cn);





% --- Executes during object creation, after setting all properties.
function listbox_num_arrays_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_arrays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Nrows=get(handles.listbox_num_arrays,'Value');
 
Ncolumns=1;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_array_names,'Data',data_s);


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




try
    N=get(handles.listbox_num,'Value');   
    WaveletFilter.N=N;   
catch
end

try
    data=get(handles.uitable_data,'Data');
    WaveletFilter.data=data;     
catch
end

try
    t1=(get(handles.edit_t1,'String'));
    WaveletFilter.t1=t1;       
catch
end

try
    t2=(get(handles.edit_t2,'String'));
    WaveletFilter.t2=t2;        
catch
end


try
    minw=(get(handles.edit_minw,'String'));
    WaveletFilter.minw=minw;       
catch
end


try
    maxw=(get(handles.edit_maxw,'String')); 
    WaveletFilter.maxw=maxw;   
catch
end


try
    iunit=get(handles.listbox_units,'Value');
    WaveletFilter.iunit=iunit; 
catch
end


try
    start_time=(get(handles.edit_start_time,'String'));
    WaveletFilter.start_time=start_time; 
catch
end


try
    nt=(get(handles.edit_ntrials,'String'));
    WaveletFilter.nt=nt;         
catch
end


try
    array_names=get(handles.uitable_array_names,'Data');
    WaveletFilter.array_names=array_names;         
catch
end


try
    Narrays=get(handles.listbox_num_arrays,'Value'); 
    WaveletFilter.Narrays=Narrays;      
catch
end


% % %
 
structnames = fieldnames(WaveletFilter, '-full'); % fields in the struct

try
    save_array_name=get(handles.edit_save_array_name,'String');
    WaveletFilter.save_array_name=save_array_name; 
catch 
    warndlg('Enter save array name');
    return;
end
 
if(isempty(save_array_name))
    warndlg('Enter save array name');
    return;    
end

    
name=save_array_name;
 
name=strrep(name,'.mat','');
name=strrep(name,'_model','');    
name=sprintf('%s_model.mat',name);
 
try
    save(name, 'WaveletFilter'); 
catch
    warndlg('Save error');
    return;
end
 
disp(' ');
out1=sprintf('Save Complete: %s',name);
disp(out1);
msgbox(out1);



  
% % %
 



% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat', 'Select plot save file');

NAME = [pathname,filename];
 
filename2=strrep(filename,'.mat','');
set(handles.edit_save_array_name,'String',filename2);


struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try

   WaveletFilter=evalin('base','WaveletFilter');

catch
   warndlg(' evalin failed ');
   return;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    N=WaveletFilter.N;  
    set(handles.listbox_num,'Value',N);     
catch
end

try
    data=WaveletFilter.data;     
    set(handles.uitable_data,'Data',data);    
catch
end

try
    t1=WaveletFilter.t1;    
    set(handles.edit_t1,'String',t1);       
catch
end

try
    t2=WaveletFilter.t2;     
    set(handles.edit_t2,'String',t2);       
catch
end


try
    minw=WaveletFilter.minw;     
    set(handles.edit_minw,'String',minw);      
catch
end


try
    maxw=WaveletFilter.maxw;     
    set(handles.edit_maxw,'String',maxw);   
catch
end


try
    iunit=WaveletFilter.iunit;     
    set(handles.listbox_units,'Value',iunit);
catch
end


try
    start_time=WaveletFilter.start_time;    
    set(handles.edit_start_time,'String',start_time); 
catch
end


try
    nt=WaveletFilter.nt; 
    set(handles.edit_ntrials,'String',nt);         
catch
end


try
    array_names=WaveletFilter.array_names;   
    set(handles.uitable_array_names,'Data',array_names);       
catch
end


try
    Narrays=WaveletFilter.Narrays;    
    set(handles.listbox_num_arrays,'Value',Narrays);       
catch
end

listbox_num_Callback(hObject, eventdata, handles);
listbox_num_arrays_Callback(hObject, eventdata, handles);



function edit_save_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_save_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_save_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
