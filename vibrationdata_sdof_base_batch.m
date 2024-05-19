function varargout = vibrationdata_sdof_base_batch(varargin)
% VIBRATIONDATA_SDOF_BASE_BATCH MATLAB code for vibrationdata_sdof_base_batch.fig
%      VIBRATIONDATA_SDOF_BASE_BATCH, by itself, creates a new VIBRATIONDATA_SDOF_BASE_BATCH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SDOF_BASE_BATCH returns the handle to a new VIBRATIONDATA_SDOF_BASE_BATCH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SDOF_BASE_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SDOF_BASE_BATCH.M with the given input arguments.
%
%      VIBRATIONDATA_SDOF_BASE_BATCH('Property','Value',...) creates a new VIBRATIONDATA_SDOF_BASE_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_sdof_base_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_sdof_base_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_sdof_base_batch

% Last Modified by GUIDE v2.5 04-May-2017 10:21:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_sdof_base_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_sdof_base_batch_OutputFcn, ...
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


% --- Executes just before vibrationdata_sdof_base_batch is made visible.
function vibrationdata_sdof_base_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_sdof_base_batch (see VARARGIN)

% Choose default command line output for vibrationdata_sdof_base_batch
handles.output = hObject;


set(handles.edit_Q,'String','10');

%% set(handles.listbox_method,'Value',1);

%% set(handles.pushbutton_save,'Enable','off');
%% set(handles.edit_output_array,'Enable','off');

%% set(handles.edit_results,'Enable','off');

%% set(handles.pushbutton_rainflow_fatigue,'Enable','off');
%% set(handles.pushbutton_Steinberg,'Enable','off');


%% set(handles.pushbutton_statistics,'Enable','off');
%% set(handles.pushbutton_psd,'Enable','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_sdof_base_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_sdof_base_batch_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'accel_data'); 
end
if(n==2)
    data=getappdata(0,'rel_disp_data'); 
end
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 

%% set(handles.pushbutton_rainflow_fatigue,'Enable','on');
%% set(handles.pushbutton_Steinberg,'Enable','on');

%% set(handles.pushbutton_statistics,'Enable','on');
%% set(handles.pushbutton_psd,'Enable','on');

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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% set(handles.edit_results,'Enable','on');

disp(' ');
disp(' * * * * * * * * ');
disp(' ');

try
    FS=get(handles.edit_input_array,'String');
    sarray=evalin('base',FS);
catch
    warndlg('Input string array not found.');
    return; 
end    
 
if(iscell(sarray)==0)
    warndlg('Input must be array of strings (class=cell)');  
    return;
end

kv=length(sarray);
ext=get(handles.edit_extension,'String');

%%

fig_num=1;

iu=get(handles.listbox_unit,'Value');

iresp=get(handles.listbox_resp,'Value');


Q=str2num(get(handles.edit_Q,'String'));
fn=str2num(get(handles.edit_fn,'String'));

damp=1/(2*Q);


 accel_table=zeros(kv,8);
 rd_table=zeros(kv,8);

progressbar;

for i=1:kv

    progressbar(i/kv);
    
    THM=evalin('base',char(sarray(i,:)));
    
    output_array{i}=strcat(char(sarray(i,:)),ext);
    
    t=double(THM(:,1));
    y=double(THM(:,2));

    yy=y;

    n=length(y);             % leave here because may vary per time history
    dur=THM(n,1)-THM(1,1);
    dt=dur/(n-1);
    sr=1/dt;
    fmax=sr/8;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%  Initialize coefficients
%
    [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
%
%
%  SRS engine
%
    for j=1:1
%
        if(iresp==1)

%%            disp(' ')
%%            disp(' Calculating absolute acceleration');
%
            forward=[ b1(j),  b2(j),  b3(j) ];    
            back   =[     1, -a1(j), -a2(j) ];    
%    
            a_resp=filter(forward,back,yy);
            zdd=a_resp-yy;
%
            a_pos= max(a_resp);
            a_neg= min(a_resp);
            
            a_mu=mean(a_resp);
            a_sd=std(a_resp);
            a_rms=sqrt(a_sd^2+a_mu^2); 
            a_max_abs=max(abs(a_resp));  
            
            a_crest=a_max_abs/a_rms;
            
            accel_data=[THM(:,1) a_resp];         
            
            accel_table(i,:)=[ i a_max_abs a_pos a_neg  a_rms  a_sd  a_mu  a_crest];
        
            sdata=accel_data;
            
        end 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        if(iresp==2)

%%        disp(' ')
%%        disp(' Calculating relative displacement');
%
            rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
            rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];       
%    
            rd_resp=filter(rd_forward,rd_back,yy);
%
            if(iu==1)
                rd_resp=rd_resp*386;
            end
            if(iu==2)
                rd_resp=rd_resp*9.81*1000;        
            end
            if(iu==3)
                rd_resp=rd_resp*1000;        
            end    
%
            rd_pos= max(rd_resp);
            rd_neg= min(rd_resp);
            
            rd_mu=mean(rd_resp);
            rd_sd=std(rd_resp);
            rd_rms=sqrt(rd_sd^2+rd_mu^2); 
            rd_max_abs=max(abs(rd_resp));
    
            rel_disp_data=[THM(:,1) rd_resp];           
  
            rd_table(i,:)=[ i rd_max_abs rd_pos rd_neg  rd_rms  rd_sd  rd_mu  rd_crest]; 
            
            sdata=rel_disp_data;
            
        end    
    end
    
    assignin('base', output_array{i}, sdata);
    out2=sprintf('%s',output_array{i});    
    ss{i}=out2; 
end


disp('  ');
disp('  Output Arrays ');
disp('  ');

for i=1:kv
   out1=sprintf(' %s',output_array{i});
   disp(out1);    
end

output_name='sdof_response_array';
    
assignin('base', output_name, ss');

disp(' ');
disp('Output array names stored in string array:');
disp(output_name);


disp(' ');
if(iresp==1)
    disp('Summary array: accel_table ');
    assignin('base', 'accel_table', accel_table);

else
    disp('Summary array: rd_table '); 
    assignin('base', 'rd_table', rd_table);    
end

disp('   Format: ');
disp('     [index   max_abs   max_pos   max_neg  rms  std_dev  average  crest] ');


disp('  ');
disp('  Group Statistics');

% accel_table(kv,:)=[ kv a_max_abs a_pos a_neg  a_rms  a_sd  a_mu  a_crest];

if(iresp==1)

    a_resp=accel_table(:,2);
  
    C2=accel_table(:,2);
  
else
    
    C2=rd_table(:,2);   
    
end    


pmin=min(C2);
pmax=max(C2);   
pmu=mean(C2);
psd=std(C2); 

out1=sprintf('   Range: %7.4g to %7.4g ',pmin,pmax);
out2=sprintf('    Mean: %7.4g  ',pmu);
out3=sprintf(' Std Dev: %7.4g ',psd);

disp(out1);
disp(out2);
disp(out3);


if(iresp==1)

    nbar=17;
    xx1=min(abs(a_resp));
    xx2=max(abs(a_resp));
    x=linspace(xx1,xx2,nbar);       
    figure(fig_num);
    fig_num=fig_num+1;
    hist(a_resp,x)
    ylabel(' Counts');
    if(iu==1 || iu==2)
        xlabel('Accel (G)')
    else
        xlabel('Accel (m/sec^2)')    
    end  
    title('Group Acceleration Response Peak Histogram');

end

disp(' ');

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_sdof_base_batch)


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
%% set(handles.edit_results,'String',' ');
%% set(handles.edit_results,'Enabele','Off');

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


% --- Executes on selection change in listbox_output_type.
function listbox_output_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_type


% --- Executes during object creation, after setting all properties.
function listbox_output_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
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
%% set(handles.edit_results,'Enable','off');
%% set(handles.edit_results,'String',' ');

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



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double
set(handles.edit_results,'Enable','off');
set(handles.edit_results,'String',' ');

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



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_rainflow_fatigue.
function pushbutton_rainflow_fatigue_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rainflow_fatigue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_rainflow;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_statistics.
function pushbutton_statistics_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_statistics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_statistics;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_psd.
function pushbutton_psd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_psd;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_Steinberg.
function pushbutton_Steinberg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Steinberg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Steinberg_TH_fatigue;    
set(handles.s,'Visible','on'); 



function edit_extension_Callback(hObject, eventdata, handles)
% hObject    handle to edit_extension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_extension as text
%        str2double(get(hObject,'String')) returns contents of edit_extension as a double


% --- Executes during object creation, after setting all properties.
function edit_extension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_extension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_resp.
function listbox_resp_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_resp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_resp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_resp


% --- Executes during object creation, after setting all properties.
function listbox_resp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_resp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
