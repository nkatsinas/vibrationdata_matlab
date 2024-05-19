function varargout = SEA_diffuse_field_panel_response(varargin)
% SEA_DIFFUSE_FIELD_PANEL_RESPONSE MATLAB code for SEA_diffuse_field_panel_response.fig
%      SEA_DIFFUSE_FIELD_PANEL_RESPONSE, by itself, creates a new SEA_DIFFUSE_FIELD_PANEL_RESPONSE or raises the existing
%      singleton*.
%
%      H = SEA_DIFFUSE_FIELD_PANEL_RESPONSE returns the handle to a new SEA_DIFFUSE_FIELD_PANEL_RESPONSE or the handle to
%      the existing singleton*.
%
%      SEA_DIFFUSE_FIELD_PANEL_RESPONSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_DIFFUSE_FIELD_PANEL_RESPONSE.M with the given input arguments.
%
%      SEA_DIFFUSE_FIELD_PANEL_RESPONSE('Property','Value',...) creates a new SEA_DIFFUSE_FIELD_PANEL_RESPONSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_diffuse_field_panel_response_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_diffuse_field_panel_response_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_diffuse_field_panel_response

% Last Modified by GUIDE v2.5 30-Apr-2016 10:52:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_diffuse_field_panel_response_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_diffuse_field_panel_response_OutputFcn, ...
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


% --- Executes just before SEA_diffuse_field_panel_response is made visible.
function SEA_diffuse_field_panel_response_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_diffuse_field_panel_response (see VARARGIN)

% Choose default command line output for SEA_diffuse_field_panel_response
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_diffuse_field_panel_response wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_diffuse_field_panel_response_OutputFcn(hObject, eventdata, handles) 
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
delete(SEA_diffuse_field_panel_response);


% --- Executes on selection change in listbox_resp_freely_hung.
function listbox_resp_freely_hung_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_resp_freely_hung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_resp_freely_hung contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_resp_freely_hung


% --- Executes during object creation, after setting all properties.
function listbox_resp_freely_hung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_resp_freely_hung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_freely_hung.
function pushbutton_freely_hung_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_freely_hung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=get(handles.listbox_resp_freely_hung,'Value');

if(n==1)
    handles.s=freely_hung_panel_diffuse_field;          
end
if(n==2)
    handles.s=freely_hung_panel_diffuse_field_multi;          
end

set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_limp.
function listbox_limp_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_limp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_limp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_limp


% --- Executes during object creation, after setting all properties.
function listbox_limp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_limp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_limp.
function pushbutton_limp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_limp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_limp,'Value');

if(n==1)
    handles.s=limp_panel;  
end
if(n==2)
    handles.s=limp_panel_multi;  
end

set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_resp_baffled.
function listbox_resp_baffled_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_resp_baffled (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_resp_baffled contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_resp_baffled




% --- Executes during object creation, after setting all properties.
function listbox_resp_baffled_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_resp_baffled (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_baffled.
function pushbutton_baffled_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_baffled (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_resp_baffled,'Value');

if(n==1)
    handles.s=baffled_panel_diffuse_field;          
end
if(n==2)
    handles.s=baffled_panel_diffuse_field_multi;          
end

set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_config.
function listbox_config_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_config (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_config contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_config


% --- Executes during object creation, after setting all properties.
function listbox_config_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_config (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_bands.
function listbox_bands_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bands (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bands contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bands


% --- Executes during object creation, after setting all properties.
function listbox_bands_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bands (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nc=get(handles.listbox_config,'Value');

nb=get(handles.listbox_bands,'Value');

if(nc==1)  % limp
    
    if(nb==1)
        handles.s=limp_panel;          
    else
        handles.s=limp_panel_multi;          
    end
    
end

if(nc==2)  % freely hung
    
    if(nb==1)
        handles.s=freely_hung_panel_diffuse_field;             
    else
        handles.s=freely_hung_panel_diffuse_field_multi_App;          
    end
    
end

if(nc==3)  % baffled
    
    if(nb==1)
        handles.s=baffled_panel_diffuse_field;          
    else
        handles.s=baffled_panel_diffuse_field_multi;         
    end
    
end
