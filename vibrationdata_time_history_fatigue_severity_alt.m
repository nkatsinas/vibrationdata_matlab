function varargout = vibrationdata_time_history_fatigue_severity_alt(varargin)
% VIBRATIONDATA_TIME_HISTORY_FATIGUE_SEVERITY_ALT MATLAB code for vibrationdata_time_history_fatigue_severity_alt.fig
%      VIBRATIONDATA_TIME_HISTORY_FATIGUE_SEVERITY_ALT, by itself, creates a new VIBRATIONDATA_TIME_HISTORY_FATIGUE_SEVERITY_ALT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TIME_HISTORY_FATIGUE_SEVERITY_ALT returns the handle to a new VIBRATIONDATA_TIME_HISTORY_FATIGUE_SEVERITY_ALT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TIME_HISTORY_FATIGUE_SEVERITY_ALT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TIME_HISTORY_FATIGUE_SEVERITY_ALT.M with the given input arguments.
%
%      VIBRATIONDATA_TIME_HISTORY_FATIGUE_SEVERITY_ALT('Property','Value',...) creates a new VIBRATIONDATA_TIME_HISTORY_FATIGUE_SEVERITY_ALT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_time_history_fatigue_severity_alt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_time_history_fatigue_severity_alt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_time_history_fatigue_severity_alt

% Last Modified by GUIDE v2.5 19-Jun-2020 13:59:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_time_history_fatigue_severity_alt_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_time_history_fatigue_severity_alt_OutputFcn, ...
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


% --- Executes just before vibrationdata_time_history_fatigue_severity_alt is made visible.
function vibrationdata_time_history_fatigue_severity_alt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_time_history_fatigue_severity_alt (see VARARGIN)

% Choose default command line output for vibrationdata_time_history_fatigue_severity_alt
handles.output = hObject;

listbox_fn_Callback(hObject, eventdata, handles);

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_time_history_fatigue_severity_alt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_time_history_fatigue_severity_alt_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_time_history_fatigue_severity_alt);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end  

disp(' ');
disp(' * * * * * * * * * * * ');
disp(' ');

fig_num=1;

try
    FS=strtrim(get(handles.edit_input_array,'String'));
    THM=evalin('base',FS);   
catch
    warndlg('Input Filename Error');
    return;
    
end

num=length(THM(:,1));

T=THM(end,1)-THM(1,1);

dt=T/(num-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q=str2double(get(handles.edit_Q,'String'));
b=str2double(get(handles.edit_bex,'String'));

max_runs=str2double(get(handles.edit_runs,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nchoice=get(handles.listbox_fn,'Value');

[fn,~]=octaves(5);  % 1/24

if(nchoice==1)
    fn=str2double(get(handles.edit_fn,'String'));
end
if(nchoice==2)
    ffmin=str2double(get(handles.edit_lower_fn,'String'));     
    ffmax=str2double(get(handles.edit_upper_fn,'String'));  
    [~,i1]=min(abs(fn-ffmin));
    [~,i2]=min(abs(fn-ffmax));
    fn=fn(i1:i2);
end

nf=length(fn);

fn=fix_size(fn);
omegan=2*pi*fn;

qdamage=zeros(max_runs,2);


FDS=zeros(max_runs,nf);
pv_srs=zeros(nf,1);

yy=THM(:,2);

progressbar;

for i=1:nf

    progressbar(i/nf);
%

    damp=1/(2*Q);
    [~,~,~,~,~,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn(i),damp,dt);
%    
    [rd_resp,rd_pos,rd_neg]=arbit_engine(rd_a1,rd_a2,rd_b1,rd_b2,rd_b3,yy);

    pv_srs(i)=386*omegan(i)*max([ rd_pos rd_neg  ]);
    
    response=386*omegan(i)*rd_resp;
    
    [damage]=rainflow_damage_function(response,b);
  
    for nruns=1:max_runs
        A=1;
        scale=damage*nruns;
        A=scale*A; 
        FDS(nruns,i)=A^(1/b);
        
        out1=sprintf(' i=%d nruns=%d  A=%8.4g  b=%8.4g  FDS=%8.4g ',i,nruns,A,b,FDS(nruns,i));
 %       disp(out1);
        
    end
    
end

progressbar(1);
pause(0.2);

for nruns=1:max_runs  
    qdamage(nruns,:)=[T*nruns  max(FDS(nruns,:))];
end

% output_name=sprintf('velox_%d',Q);

% assignin('base', output_name, qdamage);

setappdata(0,'qdamage',qdamage);

%  [C,I]=max(FDS);
%  threshold=C;


figure(fig_num);
fig_num=fig_num+1;
plot(THM(:,1),THM(:,2));
ylabel('Accel (G)');
xlabel('Time (sec)');
out1=sprintf('Base Input Time History   %7.3g GRMS',std(THM(:,2)));
title(out1);
grid on;

if(nf>=3)
    
    fmin=fn(1);
    fmax=fn(end);

    md=5;
    
    ppp=[fn pv_srs];

    
    y_label='PV (ips)';
    x_label='Natural Frequency (Hz)';
    t_string = sprintf(' Pseudo Velocity Shock Response Spectrum Q=%g ',Q);

    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(qdamage(:,1),qdamage(:,2));
ylabel('Velocity (ips)');
xlabel('Time (sec)');
out1=sprintf('Velocity Fatigue Limit  Q=%g  b=%g',Q,b);
title(out1);
grid on;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
set(handles.uipanel_save,'Visible','on');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'qdamage');

output_name=strtrim(get(handles.edit_output_name,'String'));
assignin('base', output_name, data);
 
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

%%% set(handles.pushbutton_calculate,'Enable','off');

n=get(handles.listbox_method,'Value');


set(handles.edit_output_array,'Enable','off');

set(handles.pushbutton_save,'Enable','off');

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
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
   
   set(handles.pushbutton_calculate,'Enable','on');
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
set(handles.uipanel_save,'Visible','off');

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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
set(handles.uipanel_save,'Visible','off');

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



function edit_dur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur as text
%        str2double(get(hObject,'String')) returns contents of edit_dur as a double


% --- Executes during object creation, after setting all properties.
function edit_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_sigma.
function listbox_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_sigma contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_sigma


% --- Executes during object creation, after setting all properties.
function listbox_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_amp.
function listbox_output_amp_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_amp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_amp


% --- Executes during object creation, after setting all properties.
function listbox_output_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_srs.
function pushbutton_srs_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_calculate.
function listbox_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_calculate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_calculate


set(handles.edit_output_array_fds,'enable','off')
set(handles.pushbutton_save_FDS,'enable','off')

n=get(handles.listbox_calculate,'value');

if(n==1)
    set(handles.text_fatigue_exponent,'visible','off');
    set(handles.edit_fatigue_exponent,'visible','off');
    set(handles.text_fatigue_type,'visible','off');
    set(handles.listbox_FDS_type,'visible','off');    
    set(handles.uipanel_FDS,'visible','off');
else
    set(handles.text_fatigue_exponent,'visible','on');
    set(handles.edit_fatigue_exponent,'visible','on');  
    set(handles.text_fatigue_type,'visible','on');
    set(handles.listbox_FDS_type,'visible','on');     
    set(handles.uipanel_FDS,'visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fatigue_exponent_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fatigue_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fatigue_exponent as text
%        str2double(get(hObject,'String')) returns contents of edit_fatigue_exponent as a double


% --- Executes during object creation, after setting all properties.
function edit_fatigue_exponent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fatigue_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_FDS_type.
function listbox_FDS_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_FDS_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_FDS_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_FDS_type


% --- Executes during object creation, after setting all properties.
function listbox_FDS_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_FDS_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_FDS.
function pushbutton_save_FDS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_FDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'fds');
output_name=strtrim(get(handles.edit_output_array_fds,'String'));
assignin('base', output_name, data);
 
h = msgbox('Save Complete'); 


function edit_output_array_fds_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_fds as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_fds as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_fds_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_velox_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velox as text
%        str2double(get(hObject,'String')) returns contents of edit_velox as a double


% --- Executes during object creation, after setting all properties.
function edit_velox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bex_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bex as text
%        str2double(get(hObject,'String')) returns contents of edit_bex as a double
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_bex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_fn.
function listbox_fn_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fn contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fn
set(handles.uipanel_save,'Visible','off');
n=get(handles.listbox_fn,'Value');

set(handles.text_fn,'Visible','off');
set(handles.edit_fn,'Visible','off');

set(handles.text_lower_fn,'Visible','off');
set(handles.edit_lower_fn,'Visible','off');

set(handles.text_upper_fn,'Visible','off');
set(handles.edit_upper_fn,'Visible','off');

if(n==1)
    set(handles.text_fn,'Visible','on');
    set(handles.edit_fn,'Visible','on');   
end
if(n==2)
    set(handles.text_lower_fn,'Visible','on');
    set(handles.edit_lower_fn,'Visible','on');

    set(handles.text_upper_fn,'Visible','on');
    set(handles.edit_upper_fn,'Visible','on');  
end


% --- Executes during object creation, after setting all properties.
function listbox_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lower_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lower_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lower_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_lower_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_lower_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lower_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_upper_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_upper_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_upper_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_upper_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_upper_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_upper_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_runs_Callback(hObject, eventdata, handles)
% hObject    handle to edit_runs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_runs as text
%        str2double(get(hObject,'String')) returns contents of edit_runs as a double


% --- Executes during object creation, after setting all properties.
function edit_runs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_runs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on key press with focus on edit_lower_fn and none of its controls.
function edit_lower_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_lower_fn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_upper_fn and none of its controls.
function edit_upper_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_upper_fn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');
