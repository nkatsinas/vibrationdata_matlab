function varargout = vibrationdata_dB_difference(varargin)
% VIBRATIONDATA_DB_DIFFERENCE MATLAB code for vibrationdata_dB_difference.fig
%      VIBRATIONDATA_DB_DIFFERENCE, by itself, creates a new VIBRATIONDATA_DB_DIFFERENCE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_DB_DIFFERENCE returns the handle to a new VIBRATIONDATA_DB_DIFFERENCE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_DB_DIFFERENCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_DB_DIFFERENCE.M with the given input arguments.
%
%      VIBRATIONDATA_DB_DIFFERENCE('Property','Value',...) creates a new VIBRATIONDATA_DB_DIFFERENCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_dB_difference_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_dB_difference_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_dB_difference

% Last Modified by GUIDE v2.5 01-May-2020 13:41:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_dB_difference_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_dB_difference_OutputFcn, ...
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


% --- Executes just before vibrationdata_dB_difference is made visible.
function vibrationdata_dB_difference_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_dB_difference (see VARARGIN)

% Choose default command line output for vibrationdata_dB_difference
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

listbox_format_Callback(hObject, eventdata, handles);
listbox_amp_limits_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_dB_difference wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_dB_difference_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_dB_difference);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

nf=get(handles.listbox_format,'Value');


if(nf==1)
    try
        FS=get(handles.edit_c1_array_name,'String');
        THM=evalin('base',FS);
    catch
        warndlg('Array does not exist','Warning');
        return;
    end
    
    THM1=[THM(:,1) THM(:,2)];
    THM2=[THM(:,1) THM(:,3)];
    
else    
    try
        FS1=strtrim(get(handles.edit_c1_array_name,'String'));
        THM1=evalin('base',FS1);
    catch
        warndlg('Array 1 does not exist','Warning');
        return;
    end

    try
        FS2=strtrim(get(handles.edit_c2_array_name,'String'));
        THM2=evalin('base',FS2);
    catch
        warndlg('Array 2 does not exist','Warning');
        return;
    end
end

nfunction=get(handles.listbox_function,'Value');

x_label='Natural Frequency (Hz)';

if(nfunction==1) % SRS (G)
    b=1;
end
if(nfunction==2) % PSD (G^2/Hz)
    b=2;
    x_label='Frequency (Hz)';
end
if(nfunction==3) % FDS (G^4)
    b=4;
end
if(nfunction==4) % FDS (G^8);
    b=8;
end

sz1=size(THM1);
sz2=size(THM2);

n1=sz1(1);
n2=sz2(1);

% if(n1~=n2)
%    warndlg('Functions have different lengths');
%    return;
% end
if(THM1(1,1)~=THM2(1,1))
    warndlg('Functions have different starting frequencies');
    return;
end
% if(THM1(end,1)~=THM2(end,1))
%    warndlg('Functions have different end frequencies');
%    return;
% end


nnn=min([n1 n2]);

dB_difference=zeros(nnn,2);

for i=1:nnn
   
    if(THM1(i,1)>0)
        ddd=(THM1(i,1)-THM2(i,1))/THM1(i,1);
    
        if(abs(ddd)>0.01)
            warndlg('Functions have different frequency steps');
            return;        
        end
    end
    
    ratio=THM1(i,2)/THM2(i,2);
    
    if(nfunction>=2)
        ratio=(THM1(i,2)/THM2(i,2))^(1/b);
    end
    
    dB_difference(i,1)=THM1(i,1);
    dB_difference(i,2)=20*log10(ratio);
    
%    out1=sprintf('%8.4g %8.4g %8.4g %g %8.4g ',dB_difference(i,2),THM1(i,2),THM2(i,2),b,ratio,dB_difference(i,2));
%    disp(out1);
    
end

fmin=dB_difference(1,1);
fmax=dB_difference(end,1);
ppp=dB_difference;

y_label='Difference (dB)';

t_string=get(handles.edit_title,'String');

[fig_num,h2]=...
    plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

n=get(handles.listbox_amp_limits,'Value');

if(n==2)
    ymax=str2num(get(handles.edit_ymax,'String'));
    ymin=str2num(get(handles.edit_ymin,'String'));
    
    if(ymin>ymax)
        temp=ymax;
        ymax=ymin;
        ymin=temp;
        set(handles.edit_ymax,'String',ymax);
        set(handles.edit_ymin,'String',ymin);        
    end
    
    ylim([ymin ymax]);
end

setappdata(0,'dB_difference',dB_difference);

set(handles.uipanel_save,'Visible','on');


% --- Executes on selection change in listbox_function.
function listbox_function_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_function contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_function
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_function_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

set(handles.uipanel_save,'Visible','off');

nf=get(handles.listbox_format,'Value');

if(nf==1)
    set(handles.edit_c2_array_name,'Visible','off');
    set(handles.text_2,'Visible','off');
    set(handles.text_1,'Visible','off');      
else
    set(handles.edit_c2_array_name,'Visible','on');
    set(handles.text_2,'Visible','on');  
    set(handles.text_1,'Visible','on');  
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



function edit_c1_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c1_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c1_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_c1_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_c1_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c1_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c2_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c2_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c2_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_c2_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_c2_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c2_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_amp_limits.
function listbox_amp_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amp_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amp_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amp_limits

n=get(handles.listbox_amp_limits,'Value');

if(n==1) % auto
    set(handles.text_max,'Visible','off');
    set(handles.text_min,'Visible','off');
    set(handles.edit_ymin,'Visible','off');
    set(handles.edit_ymax,'Visible','off');    
else % manual
    set(handles.text_max,'Visible','on');
    set(handles.text_min,'Visible','on');
    set(handles.edit_ymin,'Visible','on');
    set(handles.edit_ymax,'Visible','on');      
end



% --- Executes during object creation, after setting all properties.
function listbox_amp_limits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amp_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on edit_c1_array_name and none of its controls.
function edit_c1_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_c1_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_c2_array_name and none of its controls.
function edit_c2_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_c2_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'dB_difference');

output_name=get(handles.edit_output_name,'String');
assignin('base', output_name,data);

h = msgbox('Save Complete');



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
