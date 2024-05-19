function varargout = vibrationdata_differentiate(varargin)
% VIBRATIONDATA_DIFFERENTIATE MATLAB code for vibrationdata_differentiate.fig
%      VIBRATIONDATA_DIFFERENTIATE, by itself, creates a new VIBRATIONDATA_DIFFERENTIATE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_DIFFERENTIATE returns the handle to a new VIBRATIONDATA_DIFFERENTIATE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_DIFFERENTIATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_DIFFERENTIATE.M with the given input arguments.
%
%      VIBRATIONDATA_DIFFERENTIATE('Property','Value',...) creates a new VIBRATIONDATA_DIFFERENTIATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_differentiate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_differentiate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_differentiate

% Last Modified by GUIDE v2.5 29-May-2013 09:59:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_differentiate_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_differentiate_OutputFcn, ...
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


% --- Executes just before vibrationdata_differentiate is made visible.
function vibrationdata_differentiate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_differentiate (see VARARGIN)

% Choose default command line output for vibrationdata_differentiate
handles.output = hObject;

set(handles.edit_scale_factor,'Enable','on');

set(handles.listbox_method,'Value',1);
set(handles.edit_scale_factor,'Enable','off');

set(handles.pushbutton_save_ws,'Enable','off');
set(handles.edit_output_array,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_differentiate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_differentiate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


y=double(THM(:,2));

n=length(y);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);

ddt=12.*dt;
%

%
v(1)=( -y(3)+4.*y(2)-3.*y(1) )/(2.*dt);
v(2)=( -y(4)+4.*y(3)-3.*y(2) )/(2.*dt);
v(3:(n-2))=(-y(5:n)+8*y(4:(n-1))-8*y(2:(n-3))+y(1:(n-4)))/ddt;
v(n-1)=( +y(n-1)-y(n-3) )/(2.*dt);
v(n)  =( +y(n-1)-y(n-2) )/dt;

m=get(handles.listbox_scale_factor,'Value');

if(m==2)
    scale=str2num(get(handles.edit_scale_factor,'String'));
    v=v/scale;
end

    figure(1);
    plot(THM(:,1),THM(:,2));
    title('Input Time History');
    xlabel(' Time(sec) ')
    ylabel(YS_input)
    grid on;

    figure(2);
    plot(THM(:,1),v);
    title('Differentiated Time History');
    xlabel(' Time(sec) ')
    ylabel(YS_output)
    grid on;

sz=size(v);
if(sz(2)>sz(1))
    v=v';
end

diff=[THM(:,1),v];    
    
setappdata(0,'diff',diff);    
    
set(handles.pushbutton_save_ws,'Enable','on');    
set(handles.edit_output_array,'Enable','on');    
    
% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_differentiate);

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


set(handles.pushbutton_save_ws,'Enable','off');
set(handles.edit_input_array,'String',' ');

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


% --- Executes on selection change in listbox_scale_factor.
function listbox_scale_factor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scale_factor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scale_factor

n=get(hObject,'Value');

set(handles.pushbutton_save_ws,'Enable','off'); 

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


% --- Executes on button press in pushbutton_save_ws.
function pushbutton_save_ws_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_ws (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

diff=getappdata(0,'diff');
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, diff);

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
