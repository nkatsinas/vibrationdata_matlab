function varargout = vibrationdata_decimate_batch(varargin)
% VIBRATIONDATA_DECIMATE_BATCH MATLAB code for vibrationdata_decimate_batch.fig
%      VIBRATIONDATA_DECIMATE_BATCH, by itself, creates a new VIBRATIONDATA_DECIMATE_BATCH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_DECIMATE_BATCH returns the handle to a new VIBRATIONDATA_DECIMATE_BATCH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_DECIMATE_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_DECIMATE_BATCH.M with the given input arguments.
%
%      VIBRATIONDATA_DECIMATE_BATCH('Property','Value',...) creates a new VIBRATIONDATA_DECIMATE_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_decimate_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_decimate_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_decimate_batch

% Last Modified by GUIDE v2.5 10-Aug-2016 10:22:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_decimate_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_decimate_batch_OutputFcn, ...
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


% --- Executes just before vibrationdata_decimate_batch is made visible.
function vibrationdata_decimate_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_decimate_batch (see VARARGIN)

% Choose default command line output for vibrationdata_decimate_batch
handles.output = hObject;

set(handles.listbox_filter,'Value',1);
set(handles.listbox_factor,'Value',1);

set(handles.edit_input_array,'enable','on')    

set(handles.edit_current_sr,'String','');
set(handles.edit_new_sr,'String','');

listbox_filter_Callback(hObject, eventdata, handles);
 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_decimate_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_decimate_batch_OutputFcn(hObject, eventdata, handles) 
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

new_data=getappdata(0,'new_data');
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, new_data);

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



function edit_ylabel_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_input as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_input as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sample_rate(hObject, eventdata, handles)
%
try
    THM=getappdata(0,'THM');
catch
    return; 
end    

t=double(THM(:,1));
y=double(THM(:,2));

n=length(y);

dt=(t(n)-t(1))/(n-1);

csr=1/dt;

setappdata(0,'csr',csr); 

css=sprintf('%10.4g',csr);

set(handles.edit_current_sr,'String',css);

nfactor=1+get(handles.listbox_factor,'Value');

nsr=csr/nfactor;

nss=sprintf('%10.4g',nsr);

set(handles.edit_new_sr,'String',nss);

ss=sprintf('Filter frequency should be < %9.4g Hz',0.8*nsr/2);

set(handles.text_filter_frequency,'String',ss);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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




nfactor=1+get(handles.listbox_factor,'Value');
nfilter=get(handles.listbox_filter,'Value');

YS_input=get(handles.edit_ylabel_input,'String');
 
kv=length(sarray);

np=get(handles.listbox_plots,'Value');

ext=get(handles.edit_extension,'String');


disp('  ');
disp(' * * * * * ');
disp('  ');
disp('  Output Arrays ');
disp('  ');

for i=1:kv
    
    THM=evalin('base',char(sarray(i,:)));
    
    output_array=strcat(char(sarray(i,:)),ext);
    
    t=double(THM(:,1));
    y=double(THM(:,2));

    setappdata(0,'THM',THM);
    sample_rate(hObject, eventdata, handles);
    
    if(nfilter==1)
    
        value2 = get(handles.edit_fc,'String');
    
        if isempty(value2)
            msgbox('Enter lowpass frequency')
            return;
        end    
    
        fc=str2num(value2);
    
%    iband:   1=lowpass  2=highpass  3=bandpass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering    

        iband=1;
        iphase=1;
        fl=fc;
        fh=fc;
    
        csr=getappdata(0,'csr');
        dt=1/csr;
    
        [y,mu,sd,rms]=Butterworth_filter_function_alt(y,dt,iband,fl,fh,iphase);    
   
    end

    tn=t(1:nfactor:end);
    yn=y(1:nfactor:end);

    tn = fix_size(tn);
    yn = fix_size(yn);

    new_data=[tn yn];

    out1=sprintf('%s',output_array);
    disp(out1);
    
    assignin('base', output_array, new_data);
    
    
    out2=sprintf('%s',output_array);
    ss{i}=out2;
    
%%%%%%%%%%%%%%%%%%%%%%%

    if(np==1)

        figure(i);
        subplot(2,1,1);
        plot(THM(:,1),THM(:,2));
        grid on;
        [newStr]=plot_title_fix_alt(char(sarray(i,:)));
        out1=sprintf('%s Input Data ',newStr);
        title(out1);
        xlabel('Time(sec)');
        ylabel(YS_input);
        
        yl = ylim;
        ymax=max(abs(yl));
        ylim([-ymax ymax]);

        subplot(2,1,2);        
        plot(tn,yn);
        grid on;
        title('Decimated Data');
        xlabel('Time(sec)');
        ylabel(YS_input);
        ylim([-ymax ymax]);        
        
    end
end

ss=ss';
length(ss);

output_name='decimated_array';
    
assignin('base', output_name, ss);

disp(' ');
disp('Output array names stored in string array:');
disp(' decimated_array');

msgbox('Calculation complete.  See Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_decimate_batch)


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method





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


% --- Executes on selection change in listbox_filter.
function listbox_filter_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_filter

n=get(handles.listbox_filter,'value');

if(n==1)
    set(handles.edit_fc,'enable','on');
else
    set(handles.edit_fc,'enable','off');    
end


% --- Executes during object creation, after setting all properties.
function listbox_filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fc as text
%        str2double(get(hObject,'String')) returns contents of edit_fc as a double




% --- Executes during object creation, after setting all properties.
function edit_fc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_factor.
function listbox_factor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_factor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_factor





% --- Executes during object creation, after setting all properties.
function listbox_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_current_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_current_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_current_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_current_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_current_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_current_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_new_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_new_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_sr (see GCBO)
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


% --- Executes on button press in pushbutton_read_matlab.
function pushbutton_read_matlab_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_matlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FS=get(handles.edit_input_array,'String');
THM=evalin('base',FS);
setappdata(0,'THM',THM);

sample_rate(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','on'); 


% --- Executes on selection change in listbox_array.
function listbox_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_array


% --- Executes during object creation, after setting all properties.
function listbox_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_plots.
function listbox_plots_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plots contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plots


% --- Executes during object creation, after setting all properties.
function listbox_plots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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
