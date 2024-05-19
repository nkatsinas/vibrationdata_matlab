function varargout = SEA_models(varargin)
% SEA_MODELS MATLAB code for SEA_models.fig
%      SEA_MODELS, by itself, creates a new SEA_MODELS or raises the existing
%      singleton*.
%
%      H = SEA_MODELS returns the handle to a new SEA_MODELS or the handle to
%      the existing singleton*.
%
%      SEA_MODELS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_MODELS.M with the given input arguments.
%
%      SEA_MODELS('Property','Value',...) creates a new SEA_MODELS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_models_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_models_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_models

% Last Modified by GUIDE v2.5 19-Sep-2018 13:56:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_models_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_models_OutputFcn, ...
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


% --- Executes just before SEA_models is made visible.
function SEA_models_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_models (see VARARGIN)

% Choose default command line output for SEA_models
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_models wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_models_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_analyze_general.
function pushbutton_analyze_general_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze_general (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

num=get(handles.listbox_num_subsystems,'Value');

if(num==1)
    handles.s=SEA_one_subsystem;      
end
if(num==2)
    handles.s=SEA_two_subsystems;      
end
if(num==3)
    handles.s=SEA_three_subsystems_main;      
end
if(num==4)
    handles.s=SEA_four_subsystems_main;      
end

set(handles.s,'Visible','on'); 



% --- Executes on selection change in listbox_num_subsystems.
function listbox_num_subsystems_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_subsystems (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_subsystems contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_subsystems


% --- Executes during object creation, after setting all properties.
function listbox_num_subsystems_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_subsystems (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(SEA_models);

% --- Executes during object creation, after setting all properties.
function pushbutton_return_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_SCLV,'Value');

if(n==1)
    handles.s=SEA_cylindrical_shell_shelf;      
end
if(n==2)
    handles.s=SEA_simple_launch_vehicle_fairing;      
end
if(n==3)
    handles.s=SEA_one_cylindrical_shell_sandwich;    
end
if(n==4)
    handles.s=SEA_two_connected_cylindrical_shells_hs;      
end
if(n==5)
    handles.s=SEA_four_connected_cylindrical_shells_hs;      
end
if(n==6)
    handles.s=SEA_four_connected_cylindrical_shells_hs_mach_bins;
end
if(n==7)
    SEA_one_cylindrical_shell_App;   
end
if(n==8)
    handles.s=SEA_four_connected_cylindrical_shells;      
end

try
    set(handles.s,'Visible','on'); 
catch
    return;
end


% --- Executes on selection change in listbox_SCLV.
function listbox_SCLV_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_SCLV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_SCLV contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_SCLV


% --- Executes during object creation, after setting all properties.
function listbox_SCLV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_SCLV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_SCLV,'Value');

if(n==1)

     A = imread('cylindrical_shell_shelf_diagram.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 

end
if(n==2)

     A = imread('simple_launch_vehicle_fairing_diagram.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 

end
if(n==3)
    
     A = imread('tcss_a.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100)  

end
if(n>=4 && n<=5)
    
     A = imread('four_1_f.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100)  

end
if(n==6)
    
     A = imread('one_system_sea_alt.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100)  

end
