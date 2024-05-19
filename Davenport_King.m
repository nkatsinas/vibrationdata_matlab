function varargout = Davenport_King(varargin)
% DAVENPORT_KING MATLAB code for Davenport_King.fig
%      DAVENPORT_KING, by itself, creates a new DAVENPORT_KING or raises the existing
%      singleton*.
%
%      H = DAVENPORT_KING returns the handle to a new DAVENPORT_KING or the handle to
%      the existing singleton*.
%
%      DAVENPORT_KING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DAVENPORT_KING.M with the given input arguments.
%
%      DAVENPORT_KING('Property','Value',...) creates a new DAVENPORT_KING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Davenport_King_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Davenport_King_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Davenport_King

% Last Modified by GUIDE v2.5 26-Jan-2015 11:41:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Davenport_King_OpeningFcn, ...
                   'gui_OutputFcn',  @Davenport_King_OutputFcn, ...
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


% --- Executes just before Davenport_King is made visible.
function Davenport_King_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Davenport_King (see VARARGIN)

% Choose default command line output for Davenport_King
handles.output = hObject;

set(handles.pushbutton_save,'Enable','off');

set(handles.pushbutton_th,'Visible','off');

set(handles.listbox_unit,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Davenport_King wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Davenport_King_OutputFcn(hObject, eventdata, handles) 
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


L=str2num(get(handles.edit_L,'String'));
k=str2num(get(handles.edit_k,'String'));
V=str2num(get(handles.edit_V,'String'));


value1 = get(handles.edit_k, 'String');

if isempty(value1)
    msgbox('Enter Drag Coefficient');
    return;
else
    V=str2num(value1);
end    

value2 = get(handles.edit_V, 'String');

if isempty(value2)
    msgbox('Enter Velocity');
    return;
else
    V=str2num(value2);
end    


num=1000;

f=zeros(num,1);
W=zeros(num,1);

for i=1:num

    f(i)=i/10;
    fbar=f(i)*L/V;
    
    a=L/V;
    b=(2+fbar^2)^(5/6);
    
    W(i)=4*k*V^2*a/b;

end

n=get(handles.listbox_unit,'Value');

figure(1);
plot(f,W);
grid on;
%

if(n==1)
    ylabel('Wind Velocity ((ft/sec)^2/Hz)');
    out1=sprintf(' Davenport-King Spectrum  V=%g ft/sec, L=%g ft, k=%g',V,L,k);    
else
    ylabel('Wind Velocity ((m/sec)^2/Hz)');
    out1=sprintf(' Davenport-King Spectrum  V=%g m/sec, L=%g m, k=%g',V,L,k);    
end    

xlabel('Frequency (Hz)');
title(out1);

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%

%
wind_PSD=[f W];

setappdata(0,'wind_PSD',wind_PSD);

set(handles.pushbutton_save,'Enable','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(Davenport_King);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'wind_PSD');
%

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 

set(handles.pushbutton_th,'Visible','on');


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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

n=get(handles.listbox_unit,'Value');

if(n==1)
    set(handles.text_V,'String','Mean Velocity (ft/sec) at 33 ft');
    set(handles.text_scale_length,'String','Scale Length (ft)');
    set(handles.edit_L,'String','4000');
else
    set(handles.text_V,'String','Mean Velocity (m/sec) at 10 m');    
    set(handles.text_scale_length,'String','Scale Length (m)');    
    set(handles.edit_L,'String','1300');    
end


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L as text
%        str2double(get(hObject,'String')) returns contents of edit_L as a double


% --- Executes during object creation, after setting all properties.
function edit_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_k_Callback(hObject, eventdata, handles)
% hObject    handle to edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_k as text
%        str2double(get(hObject,'String')) returns contents of edit_k as a double


% --- Executes during object creation, after setting all properties.
function edit_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_V_Callback(hObject, eventdata, handles)
% hObject    handle to edit_V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_V as text
%        str2double(get(hObject,'String')) returns contents of edit_V as a double


% --- Executes during object creation, after setting all properties.
function edit_V_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_th.
function pushbutton_th_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_PSD_vel_synth;       
set(handles.s,'Visible','on'); 
