function varargout = vibrationdata_wavelet_decomposition_method1(varargin)
% VIBRATIONDATA_WAVELET_DECOMPOSITION_METHOD1 MATLAB code for vibrationdata_wavelet_decomposition_method1.fig
%      VIBRATIONDATA_WAVELET_DECOMPOSITION_METHOD1, by itself, creates a new VIBRATIONDATA_WAVELET_DECOMPOSITION_METHOD1 or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_WAVELET_DECOMPOSITION_METHOD1 returns the handle to a new VIBRATIONDATA_WAVELET_DECOMPOSITION_METHOD1 or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_WAVELET_DECOMPOSITION_METHOD1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_WAVELET_DECOMPOSITION_METHOD1.M with the given input arguments.
%
%      VIBRATIONDATA_WAVELET_DECOMPOSITION_METHOD1('Property','Value',...) creates a new VIBRATIONDATA_WAVELET_DECOMPOSITION_METHOD1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_wavelet_decomposition_method1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_wavelet_decomposition_method1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_wavelet_decomposition_method1

% Last Modified by GUIDE v2.5 25-Oct-2021 10:33:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_wavelet_decomposition_method1_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_wavelet_decomposition_method1_OutputFcn, ...
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


% --- Executes just before vibrationdata_wavelet_decomposition_method1 is made visible.
function vibrationdata_wavelet_decomposition_method1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_wavelet_decomposition_method1 (see VARARGIN)

% Choose default command line output for vibrationdata_wavelet_decomposition_method1
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_wavelet_decomposition_method1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_wavelet_decomposition_method1_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_wavelet_decomposition_method1)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

 


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );


for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end



try
    FS=strtrim(get(handles.edit_input_array,'String'));
    THM=evalin('base',FS);
catch
    warndlg('Array does not exist');
    return;    
end

minw=str2num(get(handles.edit_minw,'String'));
maxw=str2num(get(handles.edit_maxw,'String'));

LF=get(handles.listbox_freq,'Value');

 
iunit=get(handles.listbox_units,'Value');
 
t_string=get(handles.edit_title,'String');

t_string=strrep(t_string,'_',' '); 

THM=fix_size(THM);
 
fig_num=1;
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

nfr=str2num(get(handles.edit_number_wavelets,'String'));
nt=str2num(get(handles.edit_trials_per_wavelet,'String'));


sz=size(THM);
 
num=sz(1);
 
dur=THM(num,1)-THM(1,1);
 
dt=dur/(num-1);

ffmin=str2num(get(handles.edit_ffmin,'String'));
ffmax=str2num(get(handles.edit_ffmax,'String'));

t1=str2num(get(handles.edit_t1,'String'));
t2=str2num(get(handles.edit_t2,'String'));

THM_orig=THM;

[~,i1]=min(abs(THM(:,1)-t1));
[~,i2]=min(abs(THM(:,1)-t2));

THM=THM(i1:i2,:);

Q=10;
damp=1./(2.*Q);

octave=(2.^(1./12.));

i=1;


rf(1)=ffmin;

while(1)
    i=i+1;
    rf(i)=rf(i-1)*octave;
    
    if(rf(i)>=ffmax || i>500)
        break;
    end
end



freq=rf;
 
first=4./dur;
 
tr=THM(:,1); 
store_recon=THM(:,2);  

start_time=str2num(get(handles.edit_start_time,'String'));
 
[acceleration,velocity,displacement,wavelet_table]=...
    vibrationdata_wavelet_decomposition_engine_alt(tr,store_recon,dt,first,...
                                       freq,ffmin,ffmax,damp,iunit,nt,nfr,start_time,LF,minw,maxw);
%
 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  input THM

[a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(rf,damp,dt);

nfreq=length(rf);

xabs=zeros(nfreq,1);

yy=THM(:,2);

for j=1:nfreq
       
        clear resp;
        clear forward;
        clear back;
       
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        resp=filter(forward,back,yy);
%
        xmax= abs(max(resp));
        xmin= abs(min(resp));
        
        aaa=xmax;
        if(xmin>xmax)
            aaa=xmin;
        end
        
        xabs(j)=aaa;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

srs_syn=zeros(nfreq,2);
srs_syn(:,1)=rf;

yy=acceleration(:,2);


for j=1:nfreq
       
        clear resp;
        clear forward;
        clear back;
       
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        resp=filter(forward,back,yy);
%
        xmax= abs(max(resp));
        xmin= abs(min(resp));
        
        aaa=xmax;
        if(xmin>xmax)
            aaa=xmin;
        end
        
        srs_syn(j,2)=aaa;

end

residual=THM_orig;

residual(i1:i2,2)=residual(i1:i2,2)-acceleration(:,2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num)
fig_num=fig_num+1;
plot(acceleration(:,1),acceleration(:,2),'r',THM(:,1),THM(:,2),'b');
title('Acceleration');
legend('Wavelet Series','Input Data');
grid on;
xlabel('Time(sec)');
if(iunit<=2)
    ylabel('Accel(G)');
else
    ylabel('Accel(m/sec^2)');    
end   

%%%%%%%%%%%%%%%
 
figure(fig_num)
fig_num=fig_num+1;
plot(acceleration(:,1),acceleration(:,2));
title('Wavelet Series Acceleration');
grid on; 
xlabel('Time(sec)');
if(iunit<=2)
    ylabel('Accel(G)');
else
    ylabel('Accel(m/sec^2)');    
end    
 
%%%%%%%%%%%%%%%


figure(fig_num)
fig_num=fig_num+1;
plot(residual(:,1),residual(:,2));
title('Residual Acceleration');
grid on;
xlabel('Time(sec)');
if(iunit<=2)
    ylabel('Accel(G)');
else
    ylabel('Accel(m/sec^2)');    
end   

%%%%%%%%%%%%%%%
 
xlabel('Time(sec)');
grid on;
%
figure(fig_num)
fig_num=fig_num+1;
plot(velocity(:,1),velocity(:,2));
title('Wavelet Series Velocity');
if(iunit==1)
        ylabel('Velocity(in/sec)');
else
        ylabel('Velocity(cm/sec)'); 
end
xlabel('Time(sec)');
grid on;
%
figure(fig_num)
fig_num=fig_num+1;
plot(displacement(:,1),displacement(:,2));
title('Wavelet Series Displacement');
if(iunit==1)
        ylabel('Disp(inch)');
else
        ylabel('Disp(mm)');
end
xlabel('Time(sec)');
grid on;
%

%%%%

figure(fig_num)
fig_num=fig_num+1;
plot(rf,srs_syn(:,2),'r',rf,xabs,'b');
title('Shock Response Spectrum Q=10');
legend('Wavelet Series','Input Data');
xlabel('Natural Frequency (Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');

if(iunit<=2)
    ylabel('Peak Accel(G)');
else
    ylabel('Peak Accel(m/sec^2)');    
end   

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
shock_response_spectrum=srs_syn;

setappdata(0,'displacement',displacement); 
setappdata(0,'velocity',velocity);
setappdata(0,'acceleration',acceleration); 
setappdata(0,'shock_response_spectrum',shock_response_spectrum); 
setappdata(0,'wavelet_table',wavelet_table);
setappdata(0,'residual',residual);

prefix=strtrim(get(handles.edit_input_array,'String'));

output_name_1=sprintf('%s_syn',prefix);
output_name_2=sprintf('%s_res',prefix);

assignin('base', output_name_1, acceleration);
assignin('base', output_name_2, residual);

disp(' ');
disp(' Output arrays');
disp(' ');
disp(output_name_1)
disp(output_name_2)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
set(handles.uipanel_save,'Visible','on');
 


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
