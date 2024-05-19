function varargout = vibrationdata_circular_plate_base(varargin)
% VIBRATIONDATA_CIRCULAR_PLATE_BASE MATLAB code for vibrationdata_circular_plate_base.fig
%      VIBRATIONDATA_CIRCULAR_PLATE_BASE, by itself, creates a new VIBRATIONDATA_CIRCULAR_PLATE_BASE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_CIRCULAR_PLATE_BASE returns the handle to a new VIBRATIONDATA_CIRCULAR_PLATE_BASE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_CIRCULAR_PLATE_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_CIRCULAR_PLATE_BASE.M with the given input arguments.
%
%      VIBRATIONDATA_CIRCULAR_PLATE_BASE('Property','Value',...) creates a new VIBRATIONDATA_CIRCULAR_PLATE_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_circular_plate_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_circular_plate_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_circular_plate_base

% Last Modified by GUIDE v2.5 09-Sep-2014 17:29:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_circular_plate_base_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_circular_plate_base_OutputFcn, ...
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


% --- Executes just before vibrationdata_circular_plate_base is made visible.
function vibrationdata_circular_plate_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_circular_plate_base (see VARARGIN)

% Choose default command line output for vibrationdata_circular_plate_base
handles.output = hObject;

value_boxes(hObject, eventdata, handles);

key=getappdata(0,'return');



    if(strcmp(key,'yes'))
        
        Q=getappdata(0,'damp_Q');
        set(handles.Q_list,'Value',1);
        set(handles.uniform_list,'Value',2);
        set(handles.uipanel_uniform,'Visible','off');
        set(handles.uipanel_modal_damping,'Visible','on');
        value_boxes(hObject, eventdata, handles);

        set(handles.uipanel_modal_damping,'Visible','on');
        
        set(handles.d1_edit,'String',' ');

        fn=getappdata(0,'fn');

        n=length(fn);

        for i = 1:n
            out1=sprintf('%8.4g',fn(i));
            out2=sprintf('%g',Q(i));           
            data_s{i,1} = out1;
            data_s{i,2} = out2; 
        end
        
        set(handles.uitable_coordinates,'Data',data_s,'columnname', {'Natural Freq (Hz)', 'Q'});         
        
        set(handles.pushbutton_arbitrary,'Visible','on');
        set(handles.transmissibility_pushbutton,'Visible','on');
        set(handles.pushbutton_sine,'Visible','on');
        set(handles.pushbutton_psd,'Visible','on');
    else
        set(handles.pushbutton_arbitrary,'Visible','off');
        set(handles.transmissibility_pushbutton,'Visible','off');
        set(handles.pushbutton_sine,'Visible','off');
        set(handles.pushbutton_psd,'Visible','off');        
    end



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_circular_plate_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_circular_plate_base_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_circular_plate_base);

% --- Executes on button press in pushbutton_save_damping.
function pushbutton_save_damping_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


clear damp;

fn=getappdata(0,'fn');

num=length(fn);

  

Qn=get(handles.Q_list,'value');
Un=get(handles.uniform_list','value');



if(Un==1) % uniform
 
    damp(1)=str2num(get(handles.d1_edit,'String'));
    damp(2:num)=damp(1);
else
    N=num;

    A=char(get(handles.uitable_coordinates,'Data'));
    B=str2num(A);

    damp=B((N+1):(2*N));
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

for i=1:num
    out1=sprintf('%d  %8.4g  %6.3g  %6.3g',i,fn(i),damp_Q(i),damp_ratio(i));
    disp(out1);
end

setappdata(0,'damp_Q',damp_Q);
setappdata(0,'damp_ratio',damp_ratio);

damping_flag=1;
setappdata(0,'damping_flag',damping_flag);

set(handles.pushbutton_arbitrary,'Visible','on');
set(handles.transmissibility_pushbutton,'Visible','on');
set(handles.pushbutton_sine,'Visible','on');
set(handles.pushbutton_psd,'Visible','on');

setappdata(0,'return','yes');

msgbox('Damping values saved and displayed in Matlab Command Window.') 




% --- Executes on button press in pushbutton_arbitrary.
function pushbutton_arbitrary_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arbitrary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=circular_plate_arbitrary;     
set(handles.s,'Visible','on'); 



% --- Executes on button press in transmissibility_pushbutton.
function transmissibility_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to transmissibility_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=circular_plate_trans;     
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_sine.
function pushbutton_sine_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=circular_plate_sine;     
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_psd.
function pushbutton_psd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=circular_plate_psd;     
set(handles.s,'Visible','on'); 


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


% --- Executes on selection change in Q_list.
function Q_list_Callback(hObject, eventdata, handles)
% hObject    handle to Q_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Q_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Q_list


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

function value_boxes(hObject, eventdata, handles)

Qn=get(handles.Q_list,'Value');
Un=get(handles.uniform_list,'Value');

if(Qn==1)
    set(handles.Q_text,'String','Q');
else
    set(handles.Q_text,'String','Ratio');    
end

set(handles.d1_edit,'String',' ');

fn=getappdata(0,'fn');

n=length(fn);

for i = 1:n
    out1=sprintf('%8.4g',fn(i));
    data_s{i,1} = out1;
    data_s{i,2} = ''; 
end


if(Un==1)
    set(handles.uipanel_uniform,'Visible','on');
    set(handles.uipanel_modal_damping,'Visible','off');      
else
    set(handles.uipanel_uniform,'Visible','off');
    set(handles.uipanel_modal_damping,'Visible','on');
    
    if(Qn==1)
        set(handles.uitable_coordinates,'Data',data_s,'columnname', {'Natural Freq (Hz)', 'Q'});    
    else
        set(handles.uitable_coordinates,'Data',data_s,'columnname', {'Natural Freq (Hz)', 'Damping Ratio'});        
    end
    
end

guidata(hObject, handles);
