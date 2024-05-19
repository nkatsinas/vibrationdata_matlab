function varargout = vibrationdata_interpolate_function(varargin)
% VIBRATIONDATA_INTERPOLATE_FUNCTION MATLAB code for vibrationdata_interpolate_function.fig
%      VIBRATIONDATA_INTERPOLATE_FUNCTION, by itself, creates a new VIBRATIONDATA_INTERPOLATE_FUNCTION or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_INTERPOLATE_FUNCTION returns the handle to a new VIBRATIONDATA_INTERPOLATE_FUNCTION or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_INTERPOLATE_FUNCTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_INTERPOLATE_FUNCTION.M with the given input arguments.
%
%      VIBRATIONDATA_INTERPOLATE_FUNCTION('Property','Value',...) creates a new VIBRATIONDATA_INTERPOLATE_FUNCTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_interpolate_function_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_interpolate_function_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_interpolate_function

% Last Modified by GUIDE v2.5 21-Jun-2019 11:50:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_interpolate_function_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_interpolate_function_OutputFcn, ...
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


% --- Executes just before vibrationdata_interpolate_function is made visible.
function vibrationdata_interpolate_function_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_interpolate_function (see VARARGIN)

% Choose default command line output for vibrationdata_interpolate_function
handles.output = hObject;

listbox_format_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_interpolate_function wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_interpolate_function_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%

disp(' ');
disp(' * * * * * ');
disp(' ');

fig_num=1;

try
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
catch
  warndlg('Input array not found');
  return;
end    

x=THM(:,1);
y=THM(:,2);


xlab=get(handles.edit_xlab,'String');

%%%

n=get(handles.listbox_format,'Value');

if(n==1)  % linear-linear
    
    dt=str2num(get(handles.edit_delta_X,'String'));
    
    sr=1/dt;
    
    tstart=str2num(get(handles.edit_start_X,'String'));
    tend=str2num(get(handles.edit_end_X,'String'));
    
    if(tstart<x(1))
        x(1)=tstart;
        out1=sprintf(' Import data starting point reset to %8.4g',tstart);
        disp(out1);
    end
    if(tend>x(end))
        x(end)=tend;
        out2=sprintf(' Import data ending point reset to %8.4g',tend);       
        disp(out2);
    end
    
    n=floor((tend-tstart)/dt);
%
    upper=(n*dt)+tstart;

    out1=sprintf('\n sr=%8.4g  dt=%8.4g  n=%d  tstart=%8.4g  upper=%8.4g ',sr,dt,n,tstart,upper);
    disp(out1);

    xi = linspace(tstart,upper,n+1); 
    yi = interp1(x,y,xi);    
    
    xi=fix_size(xi);
    yi=fix_size(yi);    
    
    figure(fig_num);
    fig_num=fig_num+1;
    plot(xi,yi);
    xlabel(xlab);
    title('Interpolated Data');
    grid('on');
   
    fmin=xi(1);
    fmax=xi(end);
    ppp=[xi yi];
    x_label=xlab;
    y_label=' ';
    t_string='Interpolated Data';
    
   [fig_num,h2]=...
    plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,ppp,fmin,fmax)
    
end

if(n==2 || n==3)
    ioct=get(handles.listbox_oct,'Value');
    [fl,fc,fu,imax]=octaves_alt(ioct);
end

if(n==2)  % log-linear
    warndlg('Function to be added in future version');
    return;
end    
if(n==3)  % log-log
    warndlg('Function to be added in future version');    
    return;
end  



setappdata(0,'data_interp',[xi yi]);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_interpolate_function);



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'data_interp');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


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


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format

n=get(handles.listbox_format,'Value');

if(n==1)
    
    set(handles.text_delta_X,'Visible','on');
    set(handles.edit_delta_X,'Visible','on');
    
    set(handles.text_oct,'Visible','off');
    set(handles.listbox_oct,'Visible','off');
    
    set(handles.text_start_X,'Visible','on');
    set(handles.edit_start_X,'Visible','on');
    
    set(handles.text_end_X,'Visible','on');
    set(handles.edit_end_X,'Visible','on');
    
else
    
    set(handles.text_delta_X,'Visible','off');
    set(handles.edit_delta_X,'Visible','off');
    
    set(handles.text_oct,'Visible','on');
    set(handles.listbox_oct,'Visible','on');
    
    set(handles.text_start_X,'Visible','on');
    set(handles.edit_start_X,'Visible','on');
    
    set(handles.text_end_X,'Visible','on');
    set(handles.edit_end_X,'Visible','on');    
    
end



% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_delta_X_Callback(hObject, eventdata, handles)
% hObject    handle to edit_delta_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_delta_X as text
%        str2double(get(hObject,'String')) returns contents of edit_delta_X as a double


% --- Executes during object creation, after setting all properties.
function edit_delta_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_delta_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_oct.
function listbox_oct_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_oct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_oct contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_oct


% --- Executes during object creation, after setting all properties.
function listbox_oct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_oct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_start_X_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_X as text
%        str2double(get(hObject,'String')) returns contents of edit_start_X as a double


% --- Executes during object creation, after setting all properties.
function edit_start_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_X_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_X as text
%        str2double(get(hObject,'String')) returns contents of edit_end_X as a double


% --- Executes during object creation, after setting all properties.
function edit_end_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xlab_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xlab as text
%        str2double(get(hObject,'String')) returns contents of edit_xlab as a double


% --- Executes during object creation, after setting all properties.
function edit_xlab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
