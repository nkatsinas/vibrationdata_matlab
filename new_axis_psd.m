function varargout = new_axis_psd(varargin)
% NEW_AXIS_PSD MATLAB code for new_axis_psd.fig
%      NEW_AXIS_PSD, by itself, creates a new NEW_AXIS_PSD or raises the existing
%      singleton*.
%
%      H = NEW_AXIS_PSD returns the handle to a new NEW_AXIS_PSD or the handle to
%      the existing singleton*.
%
%      NEW_AXIS_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEW_AXIS_PSD.M with the given input arguments.
%
%      NEW_AXIS_PSD('Property','Value',...) creates a new NEW_AXIS_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before new_axis_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to new_axis_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help new_axis_psd

% Last Modified by GUIDE v2.5 23-Oct-2020 09:41:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @new_axis_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @new_axis_psd_OutputFcn, ...
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


% --- Executes just before new_axis_psd is made visible.
function new_axis_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to new_axis_psd (see VARARGIN)

% Choose default command line output for new_axis_psd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes new_axis_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = new_axis_psd_OutputFcn(hObject, eventdata, handles) 
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

try  
    FS=get(handles.edit_psd,'String');
    THM=evalin('base',FS);  
catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

sz=size(THM);

if(sz(2)~=3)
    warndlg('Input array must have three columns');
    return;
end

num=sz(1);

x=THM(:,2);
y=THM(:,3);

alpha=0;

ca=cos(alpha);
sa=sin(alpha);


for i=1:num
    for j=1:90
        ca*x(i)*sin(theta)-sa*y(i)*sin(theta+phase);
    end    
end




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(new_plane_psd);



function edit_psd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_psd as text
%        str2double(get(hObject,'String')) returns contents of edit_psd as a double


% --- Executes during object creation, after setting all properties.
function edit_psd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_phase.
function listbox_phase_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_phase contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_phase


% --- Executes during object creation, after setting all properties.
function listbox_phase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
