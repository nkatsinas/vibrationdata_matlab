function varargout = vibrationdata_trend_removal(varargin)
% VIBRATIONDATA_TREND_REMOVAL MATLAB code for vibrationdata_trend_removal.fig
%      VIBRATIONDATA_TREND_REMOVAL, by itself, creates a new VIBRATIONDATA_TREND_REMOVAL or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TREND_REMOVAL returns the handle to a new VIBRATIONDATA_TREND_REMOVAL or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TREND_REMOVAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TREND_REMOVAL.M with the given input arguments.
%
%      VIBRATIONDATA_TREND_REMOVAL('Property','Value',...) creates a new VIBRATIONDATA_TREND_REMOVAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_trend_removal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_trend_removal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_trend_removal

% Last Modified by GUIDE v2.5 29-May-2013 09:46:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_trend_removal_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_trend_removal_OutputFcn, ...
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


% --- Executes just before vibrationdata_trend_removal is made visible.
function vibrationdata_trend_removal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_trend_removal (see VARARGIN)

% Choose default command line output for vibrationdata_trend_removal


handles.output = hObject;

set(handles.edit_scale_factor,'Enable','off','String','');
set(handles.listbox_scale_factor,'Value',1);

set(handles.listbox_method,'Value',1);

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_trend_removal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_trend_removal_OutputFcn(hObject, eventdata, handles) 
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

h = msgbox('Save Complete') 


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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

YS_input=get(handles.edit_ylabel_input,'String');
YS_output=get(handles.edit_ylabel_output,'String');

k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

t=double(THM(:,1));
y=double(THM(:,2));

n=length(y);

p=get(handles.listbox_trend_removal,'Value');

if(p==1)
   y=y-mean(y);
end
if(p==2)
   y=detrend(y);
end
if(p==3)
   p = polyfit(t,y,2);
   y= y-(p(1)*t.*t + p(2)*t + p(3));
end

v=y;

m=get(handles.listbox_scale_factor,'Value');

if(m==2)
    scale=str2num(get(handles.edit_scale_factor,'String'));
    v=y*scale;
end

    figure(1);
    plot(THM(:,1),THM(:,2));
    title('Input Time History');
    xlabel(' Time(sec) ')
    ylabel(YS_input)
    grid on;

    figure(2);
    plot(THM(:,1),v);
    title('Output Time History');
    xlabel(' Time(sec) ')
    ylabel(YS_output)
    grid on;

v=fix_size(v);

new_data=[THM(:,1),v];    
    
setappdata(0,'new_data',new_data);    
    
set(handles.pushbutton_save,'Enable','on');    
set(handles.edit_output_array,'Enable','on'); 

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_trend_removal)


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
n=get(hObject,'Value');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_input_array,'String',' ');


set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');


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


% --- Executes on selection change in listbox_scale_factor.
function listbox_scale_factor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scale_factor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scale_factor
n=get(hObject,'Value');

set(handles.pushbutton_save,'Enable','off'); 

if(n==2)
   set(handles.edit_scale_factor,'Enable','on'); 
else
   set(handles.edit_scale_factor,'Enable','off');  
end


% --- Executes during object creation, after setting all properties.
function listbox_scale_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scale_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_scale_factor as a double


% --- Executes during object creation, after setting all properties.
function edit_scale_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_output_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_output as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_output as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_trend_removal.
function listbox_trend_removal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_trend_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_trend_removal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_trend_removal


% --- Executes during object creation, after setting all properties.
function listbox_trend_removal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_trend_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
