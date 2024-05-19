function varargout = peak_sigma_random(varargin)
% PEAK_SIGMA_RANDOM MATLAB code for peak_sigma_random.fig
%      PEAK_SIGMA_RANDOM, by itself, creates a new PEAK_SIGMA_RANDOM or raises the existing
%      singleton*.
%
%      H = PEAK_SIGMA_RANDOM returns the handle to a new PEAK_SIGMA_RANDOM or the handle to
%      the existing singleton*.
%
%      PEAK_SIGMA_RANDOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEAK_SIGMA_RANDOM.M with the given input arguments.
%
%      PEAK_SIGMA_RANDOM('Property','Value',...) creates a new PEAK_SIGMA_RANDOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before peak_sigma_random_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to peak_sigma_random_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help peak_sigma_random

% Last Modified by GUIDE v2.5 29-Jul-2022 14:37:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @peak_sigma_random_OpeningFcn, ...
                   'gui_OutputFcn',  @peak_sigma_random_OutputFcn, ...
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


% --- Executes just before peak_sigma_random is made visible.
function peak_sigma_random_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to peak_sigma_random (see VARARGIN)

% Choose default command line output for peak_sigma_random
handles.output = hObject;


listbox_method_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes peak_sigma_random wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = peak_sigma_random_OutputFcn(hObject, eventdata, handles) 
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

im=get(handles.listbox_method,'Value');

fn=str2num(get(handles.edit_fn,'String'));
T=str2num(get(handles.edit_T,'String'));

[ps]=maximax_peak(fn,T);

if(im>=2)
    
    ax=(1/100)*str2num(get(handles.edit_ax,'String'));
    
    [ps]=risk_overshoot(fn,T,ax);
    
end


%
% disp(' ');
% out1=sprintf(' The maximum expected peak response is: %4.3g sigma ',ps);
% disp(out1);

if(isinf(ps)==1)
    warndlg(' (fn T) product is too high for stable calculation ');
    return;
end

str=sprintf('%4.3g sigma',ps);

set(handles.edit_result,'String',str);

set(handles.uipanel_results,'Visible','on');

%%%%%%

    tsec=T;

    tdays=floor(tsec/86400);
%
    residual=tsec-tdays*86400;
    
    thr=floor(residual/3600);
    
    residual=residual-thr*3600;
    
    tmin=floor(residual/60);
    
    residual=residual-tmin*60;
    
    tsec=residual;
 
    if(tdays>=365)
        years=tdays/365.25;
        sss=sprintf('%10.4g years',years);
        set(handles.edit_eq_duration,'String',sss);
        return;
    end    
    
    if(tdays>=1)
        sss=sprintf('%d days %d hr %d min %g sec',tdays,thr,tmin,tsec);
        set(handles.edit_eq_duration,'String',sss);
        return;
    end 
    
    if(thr>=1)
        sss=sprintf('%g hr %g min %g sec',(24*tdays+thr),tmin,tsec);
        set(handles.edit_eq_duration,'String',sss);
        return;        
    end  
    
    if(tmin>=1)
        sss=sprintf('%g min %g sec',tmin,tsec);
        set(handles.edit_eq_duration,'String',sss);
        return;        
    end
    
    sss=sprintf('  %g sec',tsec);
    set(handles.edit_eq_duration,'String',sss);



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double



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



function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double



% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_result_Callback(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_result as text
%        str2double(get(hObject,'String')) returns contents of edit_result as a double


% --- Executes during object creation, after setting all properties.
function edit_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_result and none of its controls.
function edit_result_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_results,'Visible','off')

% --- Executes on key press with focus on edit_T and none of its controls.
function edit_T_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off')


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(peak_sigma_random);


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
set(handles.uipanel_results,'Visible','off')

im=get(handles.listbox_method,'Value');

set(handles.edit_ax,'Visible','off');
set(handles.text_ax,'Visible','off');
set(handles.text_percent,'Visible','off');   

if(im>=2)
    set(handles.edit_ax,'String','63.2');    
    set(handles.edit_ax,'Visible','on','Enable','on');
    set(handles.text_ax,'Visible','on');
    set(handles.text_percent,'Visible','on');    
end

if(im==3)
    set(handles.edit_ax,'String','50');    
    set(handles.edit_ax,'Enable','off');
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



function edit_ax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ax as text
%        str2double(get(hObject,'String')) returns contents of edit_ax as a double


% --- Executes during object creation, after setting all properties.
function edit_ax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_ax and none of its controls.
function edit_ax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ax (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off')



function edit_eq_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eq_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eq_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_eq_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_eq_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eq_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
