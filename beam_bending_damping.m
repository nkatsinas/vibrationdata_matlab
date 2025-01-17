function varargout = beam_bending_damping(varargin)
% BEAM_BENDING_DAMPING MATLAB code for beam_bending_damping.fig
%      BEAM_BENDING_DAMPING, by itself, creates a new BEAM_BENDING_DAMPING or raises the existing
%      singleton*.
%
%      H = BEAM_BENDING_DAMPING returns the handle to a new BEAM_BENDING_DAMPING or the handle to
%      the existing singleton*.
%
%      BEAM_BENDING_DAMPING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_BENDING_DAMPING.M with the given input arguments.
%
%      BEAM_BENDING_DAMPING('Property','Value',...) creates a new BEAM_BENDING_DAMPING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_bending_damping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_bending_damping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_bending_damping

% Last Modified by GUIDE v2.5 16-Sep-2015 15:50:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_bending_damping_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_bending_damping_OutputFcn, ...
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


% --- Executes just before beam_bending_damping is made visible.
function beam_bending_damping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_bending_damping (see VARARGIN)

% Choose default command line output for beam_bending_damping
handles.output = hObject;

setappdata(0,'Qn',1);
setappdata(0,'Un',1);

value_boxes(hObject, eventdata, handles);

set(handles.half_sine_pushbutton,'Enable','off');
set(handles.transmissibility_pushbutton,'Enable','off');
set(handles.sine_pushbutton,'Enable','off');
set(handles.PSD_pushbutton,'Enable','off');
set(handles.arbitrary_pushbutton,'Enable','off');
set(handles.pushbutton_mdof_srs,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_bending_damping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_bending_damping_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Save_Damping_pushbutton.
function Save_Damping_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Damping_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fn=getappdata(0,'fn');

if(length(fn)==0)
    warndlg(' fn vector does not exist');
    return;
end    


clear damp;

Qn=getappdata(0,'Qn');
Un=getappdata(0,'Un');

disp(' ');
if(Qn==1) % Q
    disp(' Amplification Factors Q ');
else
    disp(' Viscous Damping Ratios  ');
end

if(Un==1) % uniform
 
    damp(1)=str2num(get(handles.d1_edit,'String'));
    damp(2:5)=damp(1);
else
    damp(1)=str2num(get(handles.d1_edit,'String'));
    damp(2)=str2num(get(handles.d2_edit,'String'));
    damp(3)=str2num(get(handles.d3_edit,'String'));
    damp(4)=str2num(get(handles.d4_edit,'String')); 
    damp(5)=str2num(get(handles.d4_edit,'String'));      
end

num=length(fn);

if(num>5)
    num=5;
end

damp_Q=zeros(num,1);
damp_ratio=zeros(num,1);


if(Qn==1) % Q
    damp_Q=damp;
    for i=1:num
        damp_ratio(i)=1/(2*damp(i));
    end
else
    damp_ratio=damp;
    for i=1:num
        damp_Q(i)=1/(2*damp(i));
    end    
end

disp(' ');
disp('Mode    fn     Q     Damping');
disp('       (Hz)          Ratio');

for i=1:length(fn)
    out1=sprintf('%d  %8.4g  %6.3g  %6.3g',i,fn(i),damp_Q(i),damp_ratio(i));
    disp(out1);
end


setappdata(0,'damp_Q',damp_Q);
setappdata(0,'damp_ratio',damp_ratio);

damping_flag=1;
setappdata(0,'damping_flag',damping_flag);


msgbox('Damping values saved and displayed in Matlab Command Window.') 

set(handles.half_sine_pushbutton,'Enable','on');
set(handles.transmissibility_pushbutton,'Enable','on');
set(handles.sine_pushbutton,'Enable','on');
set(handles.PSD_pushbutton,'Enable','on');
set(handles.arbitrary_pushbutton,'Enable','on');

%%  delete(beam_bending_damping);



function value_boxes(hObject, eventdata, handles)

Qn=getappdata(0,'Qn');
Un=getappdata(0,'Un');

if(Qn==1)
    set(handles.Q_text,'String','Q');
else
    set(handles.Q_text,'String','Ratio');    
end


set(handles.d1_edit,'Enable','off');
set(handles.d2_edit,'Enable','off');
set(handles.d3_edit,'Enable','off');
set(handles.d4_edit,'Enable','off');
set(handles.d5_edit,'Enable','off');

set(handles.d1_edit,'String',' ');
set(handles.d2_edit,'String',' ');
set(handles.d3_edit,'String',' ');
set(handles.d4_edit,'String',' ');
set(handles.d5_edit,'String',' ');

set(handles.m1_text,'Enable','off');
set(handles.m2_text,'Enable','off');
set(handles.m3_text,'Enable','off');
set(handles.m4_text,'Enable','off');
set(handles.m5_text,'Enable','off');

set(handles.m1_text,'String',' ');
set(handles.m2_text,'String',' ');
set(handles.m3_text,'String',' ');
set(handles.m4_text,'String',' ');
set(handles.m5_text,'String',' ');

if(Un==1)
    set(handles.mode_text,'String',' ');
    set(handles.d1_edit,'Enable','on');
else
    set(handles.mode_text,'String','Mode');    
    set(handles.d1_edit,'Enable','on');
    set(handles.d2_edit,'Enable','on');
    set(handles.d3_edit,'Enable','on');
    set(handles.d4_edit,'Enable','on');
    set(handles.d5_edit,'Enable','on');    
    
    set(handles.m1_text,'Enable','on');
    set(handles.m2_text,'Enable','on');
    set(handles.m3_text,'Enable','on');
    set(handles.m4_text,'Enable','on');
    set(handles.m5_text,'Enable','on');    
    
    set(handles.m1_text,'String','1');
    set(handles.m2_text,'String','2');
    set(handles.m3_text,'String','3');
    set(handles.m4_text,'String','4');
    set(handles.m5_text,'String','5');
end

guidata(hObject, handles);



% --- Executes on button press in transmissibility_pushbutton.
function transmissibility_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to transmissibility_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s1= beam_bending_transmissibility;
set(handles.s1,'Visible','on');


% --- Executes on button press in sine_pushbutton.
function sine_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to sine_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s1= beam_bending_sine;
set(handles.s1,'Visible','on');

% --- Executes on button press in PSD_pushbutton.
function PSD_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to PSD_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s1= beam_bending_PSD;
set(handles.s1,'Visible','on');

% --- Executes on button press in half_sine_pushbutton.
function half_sine_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to half_sine_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s1= beam_bending_half_sine;
set(handles.s1,'Visible','on');

% --- Executes on button press in arbitrary_pushbutton.
function arbitrary_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to arbitrary_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s1= beam_bending_arbitrary;
set(handles.s1,'Visible','on');

% --- Executes on button press in Return_pushbutton.
function Return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(beam_bending_damping);


function d1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to d1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d1_edit as text
%        str2double(get(hObject,'String')) returns contents of d1_edit as a double


% --- Executes during object creation, after setting all properties.
function d1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to d2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d2_edit as text
%        str2double(get(hObject,'String')) returns contents of d2_edit as a double


% --- Executes during object creation, after setting all properties.
function d2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to d3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d3_edit as text
%        str2double(get(hObject,'String')) returns contents of d3_edit as a double


% --- Executes during object creation, after setting all properties.
function d3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d4_edit_Callback(hObject, eventdata, handles)
% hObject    handle to d4_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d4_edit as text
%        str2double(get(hObject,'String')) returns contents of d4_edit as a double


% --- Executes during object creation, after setting all properties.
function d4_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d4_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Q_list.
function Q_list_Callback(hObject, eventdata, handles)
% hObject    handle to Q_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Q_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Q_list

Qn=get(hObject,'Value');
setappdata(0,'Qn',Qn);

value_boxes(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function Q_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in uniform_list.
function uniform_list_Callback(hObject, eventdata, handles)
% hObject    handle to uniform_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns uniform_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from uniform_list

Un=get(hObject,'Value');

setappdata(0,'Un',Un);

value_boxes(hObject, eventdata, handles);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function uniform_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uniform_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mdof_srs.
function pushbutton_mdof_srs_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mdof_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s1= beam_mdof_srs;
set(handles.s1,'Visible','on');



function d5_edit_Callback(hObject, eventdata, handles)
% hObject    handle to d5_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d5_edit as text
%        str2double(get(hObject,'String')) returns contents of d5_edit as a double


% --- Executes during object creation, after setting all properties.
function d5_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d5_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
