function varargout = SEA_two_subsystems(varargin)
% SEA_TWO_SUBSYSTEMS MATLAB code for SEA_two_subsystems.fig
%      SEA_TWO_SUBSYSTEMS, by itself, creates a new SEA_TWO_SUBSYSTEMS or raises the existing
%      singleton*.
%
%      H = SEA_TWO_SUBSYSTEMS returns the handle to a new SEA_TWO_SUBSYSTEMS or the handle to
%      the existing singleton*.
%
%      SEA_TWO_SUBSYSTEMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_TWO_SUBSYSTEMS.M with the given input arguments.
%
%      SEA_TWO_SUBSYSTEMS('Property','Value',...) creates a new SEA_TWO_SUBSYSTEMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_two_subsystems_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_two_subsystems_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_two_subsystems

% Last Modified by GUIDE v2.5 12-Dec-2015 12:54:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_two_subsystems_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_two_subsystems_OutputFcn, ...
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


% --- Executes just before SEA_two_subsystems is made visible.
function SEA_two_subsystems_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_two_subsystems (see VARARGIN)

% Choose default command line output for SEA_two_subsystems
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_two_subsystems wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_two_subsystems_OutputFcn(hObject, eventdata, handles) 
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

delete(SEA_two_subsystems);


% --- Executes on button press in pushbutton_single.
function pushbutton_single_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_single,'Value');


if(n==1)
    handles.s=response_velocities_two_subsystems;  
end
if(n==2)
    handles.s=coupling_loss_factors_two_subsystems;  
end


set(handles.s,'Visible','on'); 



% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
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


% --- Executes on button press in pushbutton_multiple.
function pushbutton_multiple_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_multiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_bands,'Value');

if(n==1)
    handles.s=response_velocities_two_subsystems_bands;  
end
if(n==2)
    
      warndlg('Function to be added in a future version ');
      return;
    
%%    handles.s=response_velocities_panel_cylinder_bands;  
end

set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_single.
function listbox_single_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_single contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_single


% --- Executes during object creation, after setting all properties.
function listbox_single_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_multiples.
function listbox_multiples_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_multiples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_multiples contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_multiples


% --- Executes during object creation, after setting all properties.
function listbox_multiples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_multiples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
