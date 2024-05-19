function varargout = vibrationdata_add_time_column(varargin)
% VIBRATIONDATA_ADD_TIME_COLUMN MATLAB code for vibrationdata_add_time_column.fig
%      VIBRATIONDATA_ADD_TIME_COLUMN, by itself, creates a new VIBRATIONDATA_ADD_TIME_COLUMN or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ADD_TIME_COLUMN returns the handle to a new VIBRATIONDATA_ADD_TIME_COLUMN or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ADD_TIME_COLUMN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ADD_TIME_COLUMN.M with the given input arguments.
%
%      VIBRATIONDATA_ADD_TIME_COLUMN('Property','Value',...) creates a new VIBRATIONDATA_ADD_TIME_COLUMN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_add_time_column_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_add_time_column_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_add_time_column

% Last Modified by GUIDE v2.5 19-Apr-2016 16:17:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_add_time_column_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_add_time_column_OutputFcn, ...
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


% --- Executes just before vibrationdata_add_time_column is made visible.
function vibrationdata_add_time_column_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_add_time_column (see VARARGIN)

% Choose default command line output for vibrationdata_add_time_column
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_add_time_column wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_add_time_column_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_cubic_spline);


% --- Executes on button press in pushbutton_calculation.
function pushbutton_calculation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

try
     FS=get(handles.edit_input_array,'String');
     THM=evalin('base',FS);   
catch
     warndlg('Input array does not exist.');
     return;
end


yaxis_label=get(handles.edit_yaxis_label,'String');
title_label=get(handles.edit_title,'String');

y=THM;

sz=size(y);

nrows=sz(1);
ncols=sz(2);

setappdata(0,'ncols',ncols);

sr=str2num(get(handles.edit_new_sr,'String'));

dt=1/sr;
%

t=zeros(nrows,1);

for j=1:nrows
    t(j)=(j-1)*dt;
end

%%%%

if(ncols==1)
    setappdata(0,'th_data',[t y]);    
else    
    for i=1:ncols
        channel_name=sprintf('th_data_%d',i);
        setappdata(0,channel_name,[t y(:,i)]);
    end
end

if(ncols<13)

    for i=1:ncols

        figure(i);
        plot(t,y(:,i));
        
        if(ncols==1)
            title(title_label);            
        else
            ch_title_label=sprintf('%s %d',title_label,i);
            title(ch_title_label);            
        end
        
        ylabel(yaxis_label);
        xlabel('Time (sec)');
        grid on;
    end
    
end

set(handles.uipanel_save,'Visible','on');


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



function edit_yaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_yaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_yaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ncols=getappdata(0,'ncols');

output_array=get(handles.edit_output_array,'String');

if(ncols==1)
    
    data=getappdata(0,'th_data');
    assignin('base', output_array, data);  
    
    msgbox('Save Complete'); 
    
else
    
    disp(' ');
    disp(' * * * ')
    disp('  ');
    
    for i=1:ncols

         channel_name=sprintf('th_data_%d',i);
         data=getappdata(0,channel_name); 
         
         mas=sprintf('%s_%d',output_array,i);
         
         assignin('base',mas, data);
         
         disp(mas);
    
    end
    
    msgbox('Output array names written to Command Window'); 
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
