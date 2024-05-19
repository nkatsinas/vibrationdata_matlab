function varargout = isolated_damping(varargin)
% ISOLATED_DAMPING MATLAB code for isolated_damping.fig
%      ISOLATED_DAMPING, by itself, creates a new ISOLATED_DAMPING or raises the existing
%      singleton*.
%
%      H = ISOLATED_DAMPING returns the handle to a new ISOLATED_DAMPING or the handle to
%      the existing singleton*.
%
%      ISOLATED_DAMPING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISOLATED_DAMPING.M with the given input arguments.
%
%      ISOLATED_DAMPING('Property','Value',...) creates a new ISOLATED_DAMPING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before isolated_damping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to isolated_damping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help isolated_damping

% Last Modified by GUIDE v2.5 07-May-2018 15:49:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @isolated_damping_OpeningFcn, ...
                   'gui_OutputFcn',  @isolated_damping_OutputFcn, ...
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


% --- Executes just before isolated_damping is made visible.
function isolated_damping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to isolated_damping (see VARARGIN)

% Choose default command line output for isolated_damping
handles.output = hObject;


set(handles.Q_listbox,'Value',1);
set(handles.uniform_listbox,'Value',1)

try

    QL=getappdata(0,'Q_listbox');
    UL=getappdata(0,'uniform_listbox');


    if(~isempty(QL))
        set(handles.Q_listbox,'Value',QL);
    end
    if(~isempty(UL))    
        set(handles.uniform_listbox,'Value',UL);
    end

catch    
end


value_boxes(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes isolated_damping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = isolated_damping_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Q_listbox.
function Q_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to Q_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Q_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Q_listbox

Qn=get(handles.Q_listbox,'Value');

if(Qn==1)
    set(handles.Q_text,'String','Q');
else
    set(handles.Q_text,'String','Ratio');    
end

value_boxes(hObject, eventdata, handles);

guidata(hObject, handles);


function value_boxes(hObject, eventdata, handles)

set(handles.d1_edit,'Enable','off');
set(handles.d2_edit,'Enable','off');
set(handles.d3_edit,'Enable','off');
set(handles.d4_edit,'Enable','off');
set(handles.d5_edit,'Enable','off');
set(handles.d6_edit,'Enable','off');

set(handles.d1_edit,'String',' ');
set(handles.d2_edit,'String',' ');
set(handles.d3_edit,'String',' ');
set(handles.d4_edit,'String',' ');
set(handles.d5_edit,'String',' ');
set(handles.d6_edit,'String',' ');

set(handles.m1_text,'Enable','off');
set(handles.m2_text,'Enable','off');
set(handles.m3_text,'Enable','off');
set(handles.m4_text,'Enable','off');
set(handles.m5_text,'Enable','off');
set(handles.m6_text,'Enable','off');

set(handles.m1_text,'String',' ');
set(handles.m2_text,'String',' ');
set(handles.m3_text,'String',' ');
set(handles.m4_text,'String',' ');
set(handles.m5_text,'String',' ');
set(handles.m6_text,'String',' ');

UL=get(handles.uniform_listbox,'Value');
QL=get(handles.Q_listbox,'Value');

if(UL==1)
    set(handles.mode_text,'String',' ');
    set(handles.d1_edit,'Enable','on');
    
    if(QL==1)
       
        try
            damp_Q=getappdata(0,'damping_Q');
            ss=sprintf('%g',damp_Q(1));
            set(handles.d1_edit,'String',ss);
        catch
        end
        
    else
       
        try
            damp_visc=getappdata(0,'damping_visc');
            ss=sprintf('%g',damp_visc(1));
            set(handles.d1_edit,'String',ss);
        catch
        end
         
    end
    
    
else
    set(handles.mode_text,'String','Mode');    
    set(handles.d1_edit,'Enable','on');
    set(handles.d2_edit,'Enable','on');
    set(handles.d3_edit,'Enable','on');
    set(handles.d4_edit,'Enable','on');
    set(handles.d5_edit,'Enable','on');
    set(handles.d6_edit,'Enable','on');
    
    set(handles.m1_text,'Enable','on');
    set(handles.m2_text,'Enable','on');
    set(handles.m3_text,'Enable','on');
    set(handles.m4_text,'Enable','on');
    set(handles.m5_text,'Enable','on');
    set(handles.m6_text,'Enable','on');
    
    set(handles.m1_text,'String','1');
    set(handles.m2_text,'String','2');
    set(handles.m3_text,'String','3');
    set(handles.m4_text,'String','4');
    set(handles.m5_text,'String','5');
    set(handles.m6_text,'String','6'); 
    
    
    if(QL==1)
       
        try
            damp_Q=getappdata(0,'damping_Q');
            ss=sprintf('%g',damp_Q(1));
            set(handles.d1_edit,'String',ss);
            ss=sprintf('%g',damp_Q(2));
            set(handles.d2_edit,'String',ss);
            ss=sprintf('%g',damp_Q(3));
            set(handles.d3_edit,'String',ss);  
            ss=sprintf('%g',damp_Q(4));
            set(handles.d4_edit,'String',ss);
            ss=sprintf('%g',damp_Q(5));
            set(handles.d5_edit,'String',ss);
            ss=sprintf('%g',damp_Q(6));
            set(handles.d6_edit,'String',ss);                
        catch
        end
        
    else
       
        try
            damp_visc=getappdata(0,'damping_visc');
            ss=sprintf('%g',damp_visc(1));
            set(handles.d1_edit,'String',ss);
            damp_visc=getappdata(0,'damping_visc');
            ss=sprintf('%g',damp_visc(2));
            set(handles.d2_edit,'String',ss);
            damp_visc=getappdata(0,'damping_visc');
            ss=sprintf('%g',damp_visc(3));
            set(handles.d3_edit,'String',ss);
            damp_visc=getappdata(0,'damping_visc');
            ss=sprintf('%g',damp_visc(4));
            set(handles.d4_edit,'String',ss);
            damp_visc=getappdata(0,'damping_visc');
            ss=sprintf('%g',damp_visc(5));
            set(handles.d5_edit,'String',ss);
            damp_visc=getappdata(0,'damping_visc');
            ss=sprintf('%g',damp_visc(6));
            set(handles.d6_edit,'String',ss);           
        catch
        end
         
    end
        
    
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Q_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in uniform_listbox.
function uniform_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to uniform_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns uniform_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from uniform_listbox

handles.uniform_list=get(handles.uniform_listbox,'Value');

value_boxes(hObject, eventdata, handles);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function uniform_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uniform_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function d6_edit_Callback(hObject, eventdata, handles)
% hObject    handle to d6_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d6_edit as text
%        str2double(get(hObject,'String')) returns contents of d6_edit as a double


% --- Executes during object creation, after setting all properties.
function d6_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d6_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear damp;

UL=get(handles.uniform_listbox,'Value');
QL=get(handles.Q_listbox,'Value');

damp_visc=zeros(6,1);
damp_Q=zeros(6,1);

disp(' ');

if(UL==1) % uniform
 
    damp(1)=str2num(get(handles.d1_edit,'String'));
    damp(2:6)=damp(1);
else
    damp(1)=str2num(get(handles.d1_edit,'String'));
    damp(2)=str2num(get(handles.d2_edit,'String'));
    damp(3)=str2num(get(handles.d3_edit,'String'));
    damp(4)=str2num(get(handles.d4_edit,'String'));
    damp(5)=str2num(get(handles.d5_edit,'String'));
    damp(6)=str2num(get(handles.d6_edit,'String'));    
end

if(QL==1) % Q
    
    damp_Q=damp;
    
    for i=1:6
        damp_visc(i)=1/(2*damp_Q(i));
    end
else
    damp_visc=damp;
    
    
    for i=1:6
        damp_Q(i)=1/(2*damp_visc(i));
    end
    
end

disp(' ');
disp('                Viscous ')
disp(' Mode      Q    Damping Ratio ');

for i=1:6
    out1=sprintf('   %d  %7.3g  %7.3g',i,damp_Q(i),damp_visc(i));
    disp(out1);
end


setappdata(0,'damping_Q',damp_Q);
setappdata(0,'damping_visc',damp_visc);
setappdata(0,'Q_listbox',QL);
setappdata(0,'uniform_listbox',UL);




damping_flag=1;
setappdata(0,'damping_flag',damping_flag);


msgbox('Damping values saved and displayed in Matlab Command Window.') 

delete(isolated_damping);
