function varargout = vibrationdata_mean_filter(varargin)
% VIBRATIONDATA_MEAN_FILTER MATLAB code for vibrationdata_mean_filter.fig
%      VIBRATIONDATA_MEAN_FILTER, by itself, creates a new VIBRATIONDATA_MEAN_FILTER or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_MEAN_FILTER returns the handle to a new VIBRATIONDATA_MEAN_FILTER or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_MEAN_FILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_MEAN_FILTER.M with the given input arguments.
%
%      VIBRATIONDATA_MEAN_FILTER('Property','Value',...) creates a new VIBRATIONDATA_MEAN_FILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_mean_filter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_mean_filter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_mean_filter

% Last Modified by GUIDE v2.5 04-Dec-2020 09:18:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_mean_filter_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_mean_filter_OutputFcn, ...
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


% --- Executes just before vibrationdata_mean_filter is made visible.
function vibrationdata_mean_filter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_mean_filter (see VARARGIN)

% Choose default command line output for vibrationdata_mean_filter
handles.output = hObject;


set(handles.listbox_method,'Value',1);
set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');
set(handles.listbox_window_size,'Value',1);

set(handles.listbox_output,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_mean_filter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_mean_filter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
n=get(hObject,'Value');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_input_array,'String',' ');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');    
    
   set(handles.edit_input_array,'enable','off')
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
   
   YS=get(handles.edit_ylabel,'String');

   figure(1);
   plot(THM(:,1),THM(:,2));
   title('Input Time History');
   xlabel(' Time(sec) ')
   ylabel(YS)
   grid on;

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



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output,'Value');

if(n==1)
    filtered_data=getappdata(0,'mf_lowpass');
else
    filtered_data=getappdata(0,'mf_highpass');    
end    

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, filtered_data);

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



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_np_Callback(hObject, eventdata, handles)
% hObject    handle to edit_np (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_np as text
%        str2double(get(hObject,'String')) returns contents of edit_np as a double


% --- Executes during object creation, after setting all properties.
function edit_np_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_np (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_mean_filter)

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end


y=double(THM(:,2));

t=THM(:,1);

%%%%%%%%%%%%%%%%%%%%%%%

YS=get(handles.edit_ylabel,'String');

figure(1);
plot(THM(:,1),THM(:,2));
title('Input Time History');
xlabel(' Time(sec) ')
ylabel(YS)
grid on;

%%%%%%%%%%%%%%%%%%%%%%%

npass=str2num(get(handles.edit_np,'String'));
sws=get(handles.listbox_window_size,'Value');
windowSize=2*sws+1;

npass

%
[mf]=mean_filter_function(y,npass,windowSize);   
%
yf=mf;
%
t=fix_size(t);
yf=fix_size(yf);
mf=fix_size(mf);
%
vvmax=max(yf);
vvmin=min(yf);
disp(' ');
disp(' Raw Signal with Mean Filtered Signal Removed');          
fprintf(' max=%8.4g  min=%8.4g \n',vvmax,vvmin);
%
figure(2);
plot(t,yf);
ylabel(YS)
xlabel('Time (sec)')
title(' Raw Signal with Mean Filtered Signal Removed, mf highpass ');
grid on;
raw_minus_mf(:,1)=t;
raw_minus_mf(:,2)=yf;        
%           
figure(3);
plot(t,mf);
ylabel(YS)
xlabel('Time (sec)')
title(' Mean Filtered signal, mf lowpass');
grid on;  
mean_filtered(:,1)=t;
mean_filtered(:,2)=mf;   
%
vvmax=max(mf);
vvmin=min(mf);
disp(' ');
disp(' Mean Filtered Signal');          
fprintf(' max=%8.4g  min=%8.4g \n',vvmax,vvmin);
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=4;
xlabel2='Time (sec)';
ylabel1=YS;
ylabel2=YS;
data1=THM;
data2=mean_filtered;

ttt=get(handles.edit_title,'String');

t_string1=ttt;
t_string2='Mean Filtered';

[fig_num]=subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear mf_lowpass;
clear mf_highpass;
%
mf_lowpass=mean_filtered;
mf_highpass=raw_minus_mf;
%
setappdata(0,'mf_lowpass',mf_lowpass);  
setappdata(0,'mf_highpass',mf_highpass);  
%
set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array,'Enable','on');


% --- Executes on selection change in listbox_window_size.
function listbox_window_size_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_window_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_window_size contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_window_size


% --- Executes during object creation, after setting all properties.
function listbox_window_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_window_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
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
