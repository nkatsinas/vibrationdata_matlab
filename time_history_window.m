function varargout = time_history_window(varargin)
% TIME_HISTORY_WINDOW MATLAB code for time_history_window.fig
%      TIME_HISTORY_WINDOW, by itself, creates a new TIME_HISTORY_WINDOW or raises the existing
%      singleton*.
%
%      H = TIME_HISTORY_WINDOW returns the handle to a new TIME_HISTORY_WINDOW or the handle to
%      the existing singleton*.
%
%      TIME_HISTORY_WINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIME_HISTORY_WINDOW.M with the given input arguments.
%
%      TIME_HISTORY_WINDOW('Property','Value',...) creates a new TIME_HISTORY_WINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before time_history_window_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to time_history_window_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help time_history_window

% Last Modified by GUIDE v2.5 10-Jan-2019 10:21:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @time_history_window_OpeningFcn, ...
                   'gui_OutputFcn',  @time_history_window_OutputFcn, ...
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


% --- Executes just before time_history_window is made visible.
function time_history_window_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to time_history_window (see VARARGIN)

% Choose default command line output for time_history_window
handles.output = hObject;

set(handles.pushbutton_calculate,'Enable','off');
set(handles.uipanel_save,'Visible','off');

listbox_method_Callback(hObject, eventdata, handles)


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes time_history_window wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = time_history_window_OutputFcn(hObject, eventdata, handles) 
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

delete(time_history_window);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

THM=getappdata(0,'THM');

t=THM(:,1);
a=THM(:,2);

dur=t(end)-t(1);


n=get(handles.listbox_method,'Value');

if(n==1)
    sigma=str2num(get(handles.edit_damp,'String'));
    [b]=exponential_window_function(a,dur,sigma); 
    t_string2=sprintf('Signal with Exponenital Window  sigma = %g',sigma);    
end    
if(n==2)
    T=str2num(get(handles.edit_damp,'String'));
    sigma=6.9087/T;
    [b]=exponential_window_function(a,dur,sigma); 
    t_string2=sprintf('Signal with Exponenital Window  sigma = %6.4g',sigma);    
end 
if(n==3)
    [b]=Hanning_function(a);   
    t_string2='Signal with Compensated Hanning Window';      
end    


tt=t;
b=fix_size(b);


setappdata(0,'signal',[tt b]);
set(handles.uipanel_save,'Visible','on');


sss=get(handles.edit_ylab,'String');

ylabel1=sss;
ylabel2=sss;

t_string1='Input Signal';


fig_num=1;

xlabel2='Time (sec)';
data1=[tt a];
data2=[tt b];

[fig_num]=subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'signal');

output_name=get(handles.edit_output_array,'String');
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


% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
      FS=get(handles.edit_input_array,'String');
      THM=evalin('base',FS);
%      disp('ref 2')
catch
      warndlg('Unable to read input file','Warning');
      return;
end    

% disp('ref 3')
setappdata(0,'THM',THM);
% disp('ref 4')
set(handles.pushbutton_calculate,'Enable','on');
% disp('ref 5')


y=double(THM(:,2));
n=length(y);
dur=THM(n,1)-THM(1,1);
dt=dur/(n-1);


setappdata(0,'n',n);
setappdata(0,'dur',dur);
setappdata(0,'dt',dt);


sss=sprintf('Duration = %8.4g sec \n Number of Points = %d',dur,n);

set(handles.edit_stats,'String',sss);


msgbox('Data read');


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


LL=get(handles.listbox_method,'Value');


set(handles.text_damp,'Visible','off');
set(handles.edit_damp,'Visible','off');

if(LL<=2)
    set(handles.text_damp,'Visible','on');
    set(handles.edit_damp,'Visible','on');
end

if(LL==1)
    set(handles.text_damp,'String','Enter Sigma');
end
if(LL==2)
    set(handles.text_damp,'String','Enter T');    
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



function edit_damp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damp as text
%        str2double(get(hObject,'String')) returns contents of edit_damp as a double


% --- Executes during object creation, after setting all properties.
function edit_damp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stats_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stats as text
%        str2double(get(hObject,'String')) returns contents of edit_stats as a double


% --- Executes during object creation, after setting all properties.
function edit_stats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_zero.
function listbox_zero_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_zero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_zero contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_zero


% --- Executes during object creation, after setting all properties.
function listbox_zero_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_zero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylab_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylab as text
%        str2double(get(hObject,'String')) returns contents of edit_ylab as a double


% --- Executes during object creation, after setting all properties.
function edit_ylab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylab (see GCBO)
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

A = imread('time_history_window.jpg'); 

figure(999)
imshow(A,'border','tight','InitialMagnification',100) 
