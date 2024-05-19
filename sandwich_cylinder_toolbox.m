function varargout = sandwich_cylinder_toolbox(varargin)
% SANDWICH_CYLINDER_TOOLBOX MATLAB code for sandwich_cylinder_toolbox.fig
%      SANDWICH_CYLINDER_TOOLBOX, by itself, creates a new SANDWICH_CYLINDER_TOOLBOX or raises the existing
%      singleton*.
%
%      H = SANDWICH_CYLINDER_TOOLBOX returns the handle to a new SANDWICH_CYLINDER_TOOLBOX or the handle to
%      the existing singleton*.
%
%      SANDWICH_CYLINDER_TOOLBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SANDWICH_CYLINDER_TOOLBOX.M with the given input arguments.
%
%      SANDWICH_CYLINDER_TOOLBOX('Property','Value',...) creates a new SANDWICH_CYLINDER_TOOLBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sandwich_cylinder_toolbox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sandwich_cylinder_toolbox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sandwich_cylinder_toolbox

% Last Modified by GUIDE v2.5 27-Jan-2016 14:23:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sandwich_cylinder_toolbox_OpeningFcn, ...
                   'gui_OutputFcn',  @sandwich_cylinder_toolbox_OutputFcn, ...
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


% --- Executes just before sandwich_cylinder_toolbox is made visible.
function sandwich_cylinder_toolbox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sandwich_cylinder_toolbox (see VARARGIN)

% Choose default command line output for sandwich_cylinder_toolbox
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sandwich_cylinder_toolbox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sandwich_cylinder_toolbox_OutputFcn(hObject, eventdata, handles) 
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

delete(sandwich_cylinder_toolbox);


% --- Executes on selection change in listbox_SEA.
function listbox_SEA_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_SEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_SEA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_SEA


% --- Executes during object creation, after setting all properties.
function listbox_SEA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_SEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_SEA.
function pushbutton_SEA_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_SEA,'Value');

if(n==1)
   handles.s=critical_ring_frequencies_sandwich_cylinder;
   set(handles.s,'Visible','on'); 
end
if(n==2)
    handles.s=radiation_efficiency_honeycomb_sandwich_cylinder; 
end
if(n==3)
    handles.s=mobility_honeycomb_sandwich_cylinder; 
end
if(n==4)
    handles.s=dissipation_loss_factor_sandwich_cylinder;      
end
if(n==5)
    handles.s=modal_density_sandwich_cylinder; 
end


% --- Executes on selection change in listbox_acoustic_field.
function listbox_acoustic_field_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acoustic_field contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acoustic_field


% --- Executes during object creation, after setting all properties.
function listbox_acoustic_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_acoustic_field.
function pushbutton_acoustic_field_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_acoustic_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_acoustic_field,'Value');

nb=get(handles.listbox_band_apf,'Value');

if(n==1)
    
    if(nb==1)
         handles.s=SEA_equivalent_acoustic_power_cylinder_sandwich; 
    else
         handles.s=SEA_equivalent_acoustic_power_cyl_sandwich_multi;     
    end
else
    if(nb==1)
         handles.s=SEA_cylinder_acoustic_response_sandwich;    
    else
         handles.s=SEA_one_cylindrical_shell_sandwich;
    end    
end    

set(handles.s,'Visible','on');



% --- Executes on selection change in listbox_band_apf.
function listbox_band_apf_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band_apf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band_apf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band_apf




% --- Executes during object creation, after setting all properties.
function listbox_band_apf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band_apf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
