function varargout = TL_two_media(varargin)
% TL_TWO_MEDIA MATLAB code for TL_two_media.fig
%      TL_TWO_MEDIA, by itself, creates a new TL_TWO_MEDIA or raises the existing
%      singleton*.
%
%      H = TL_TWO_MEDIA returns the handle to a new TL_TWO_MEDIA or the handle to
%      the existing singleton*.
%
%      TL_TWO_MEDIA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TL_TWO_MEDIA.M with the given input arguments.
%
%      TL_TWO_MEDIA('Property','Value',...) creates a new TL_TWO_MEDIA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TL_two_media_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TL_two_media_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TL_two_media

% Last Modified by GUIDE v2.5 02-Nov-2017 16:56:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TL_two_media_OpeningFcn, ...
                   'gui_OutputFcn',  @TL_two_media_OutputFcn, ...
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


% --- Executes just before TL_two_media is made visible.
function TL_two_media_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TL_two_media (see VARARGIN)

% Choose default command line output for TL_two_media
handles.output = hObject;

change(hObject, eventdata, handles);

set(handles.uipanel_result,'Visible','off');

for i = 1:2
    data_s{i,1} = '0';     
end


set(handles.uitable_coordinates,'Data',data_s);

listbox_m1_Callback(hObject, eventdata, handles);
listbox_m2_Callback(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TL_two_media wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)
%



% --- Outputs from this function are returned to the command line.
function varargout = TL_two_media_OutputFcn(hObject, eventdata, handles) 
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
delete(TL_two_media);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * ');
disp(' ');

A=char(get(handles.uitable_coordinates,'Data'));
R=str2num(A);

    
%
num=4*R(1)*R(2);
%
den=(R(1)+R(2))^2;
%
alpha_t=num/den;
%
TL=10*log10( 1/alpha_t );

sss=sprintf('%6.3g',TL);
set(handles.edit_TL,'String',sss);

sss=sprintf('%6.3g',alpha_t);
set(handles.edit_at,'String',sss);

%%


set(handles.uipanel_result,'Visible','on');



function edit_TL_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TL as text
%        str2double(get(hObject,'String')) returns contents of edit_TL as a double


% --- Executes during object creation, after setting all properties.
function edit_TL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TL (see GCBO)
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

data=getappdata(0,'transmission_loss');
%

output_name=get(handles.edit_TL,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
set(handles.uipanel_result,'Visible','off');

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('TL_two_media.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100); 



function edit_h_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h as text
%        str2double(get(hObject,'String')) returns contents of edit_h as a double


% --- Executes during object creation, after setting all properties.
function edit_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_m1.
function listbox_m1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_m1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_m1
set(handles.uipanel_result,'Visible','off');
m=get(handles.listbox_m1,'Value');

A=char(get(handles.uitable_coordinates,'Data'));

B=str2num(A);

[B(1)]=characteristic_impedance(m);

s1=sprintf('%g',B(1));
s2=sprintf('%g',B(2));

data_s={s1; s2};

set(handles.uitable_coordinates,'Data',data_s);



% --- Executes during object creation, after setting all properties.
function listbox_m1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_m2.
function listbox_m2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_m2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_m2

set(handles.uipanel_result,'Visible','off');
m=get(handles.listbox_m2,'Value');

A=char(get(handles.uitable_coordinates,'Data'));

B=str2num(A);

[B(2)]=characteristic_impedance(m);

s1=sprintf('%g',B(1));
s2=sprintf('%g',B(2));

data_s={s1; s2};

set(handles.uitable_coordinates,'Data',data_s);




% set(handles.uitable_coordinates,'Data',data_s);

% --- Executes during object creation, after setting all properties.
function listbox_m3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_m2.
function listbox_m2_old_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_m2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_m2




set(handles.uipanel_result,'Visible','off');
      

m=get(handles.listbox_m2,'Value');

A=char(get(handles.uitable_coordinates,'Data'));

B=str2num(A);

c=0;

if(m==1) % Aluminum
    B(2)=17e+06;
    c=6300;
end
if(m==2) % Steel
    B(2)=47e+06;  
    c=6100;    
end
if(m==3) % Lead
    B(2)=23.2e+06;         
    c=2050;    
end
if(m==4) % Concrete
    B(2)=8e+06;
    c=3100;    
end
if(m==5) % Graphite/Epoxy
    B(2)=10e+06;
    c=6604;   
end

ss=sprintf('%g',c);
set(handles.edit_c,'String',ss);

s1=sprintf('%g',B(1));
s2=sprintf('%g',B(2));
s3=sprintf('%g',B(3));

data_s={s1; s2; s3};

set(handles.uitable_coordinates,'Data',data_s);



% --- Executes during object creation, after setting all properties.
function listbox_m2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c as text
%        str2double(get(hObject,'String')) returns contents of edit_c as a double


% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_h and none of its controls.
function edit_h_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_c and none of its controls.
function edit_c_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');



function edit_at_Callback(hObject, eventdata, handles)
% hObject    handle to edit_at (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_at as text
%        str2double(get(hObject,'String')) returns contents of edit_at as a double


% --- Executes during object creation, after setting all properties.
function edit_at_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_at (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
