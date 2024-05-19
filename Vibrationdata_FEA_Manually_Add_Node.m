function varargout = Vibrationdata_FEA_Manually_Add_Node(varargin)
% VIBRATIONDATA_FEA_MANUALLY_ADD_NODE MATLAB code for Vibrationdata_FEA_Manually_Add_Node.fig
%      VIBRATIONDATA_FEA_MANUALLY_ADD_NODE, by itself, creates a new VIBRATIONDATA_FEA_MANUALLY_ADD_NODE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FEA_MANUALLY_ADD_NODE returns the handle to a new VIBRATIONDATA_FEA_MANUALLY_ADD_NODE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FEA_MANUALLY_ADD_NODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FEA_MANUALLY_ADD_NODE.M with the given input arguments.
%
%      VIBRATIONDATA_FEA_MANUALLY_ADD_NODE('Property','Value',...) creates a new VIBRATIONDATA_FEA_MANUALLY_ADD_NODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_FEA_Manually_Add_Node_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_FEA_Manually_Add_Node_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_FEA_Manually_Add_Node

% Last Modified by GUIDE v2.5 13-Mar-2014 14:08:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_FEA_Manually_Add_Node_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_FEA_Manually_Add_Node_OutputFcn, ...
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


% --- Executes just before Vibrationdata_FEA_Manually_Add_Node is made visible.
function Vibrationdata_FEA_Manually_Add_Node_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_FEA_Manually_Add_Node (see VARARGIN)

% Choose default command line output for Vibrationdata_FEA_Manually_Add_Node
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_FEA_Manually_Add_Node wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_FEA_Manually_Add_Node_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_Add.
function pushbutton_Add_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%% ncoor=evalin('base','ncoor');

ncoor=getappdata(0,'ncoor');

N=str2num(get(handles.edit_N,'String'));
X=str2num(get(handles.edit_X,'String'));
Y=str2num(get(handles.edit_Y,'String'));
Z=str2num(get(handles.edit_Z,'String'));

iflag=1;

if isempty(N)
    iflag=0;
    warndlg('Enter Node Number','Warning');
else
    if isempty(X)
        iflag=0;      
        warndlg('Enter X coordinate','Warning');
    else
        if isempty(Y)
            iflag=0;
            warndlg('Enter Y coordinate','Warning');            
        else
            if isempty(Z)
                iflag=0;
                warndlg('Enter Z coordinate','Warning');                   
            end            
        end        
    end    
end

if(iflag==1)
    sz=size(ncoor);
    m=sz(1)+1;
    ncoor(m,:)=[N X Y Z 0 0 0 0 0 0];

    ncoor = sortrows(ncoor,1);
    
%%%%    assignin('base','ncoor',ncoor);

    setappdata(0,'ncoor',ncoor);
    
    out=sprintf('Node %d added',N);
    h = msgbox(out);
    
%%    disp('add node');
%%    ncoor
    
    n=get(handles.listbox_perspective,'Value');
    [~]=Vibrationdata_Model_Plot(n); 
    
end





% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%% vibrationdata_fea_preprocessor;

delete(Vibrationdata_FEA_Manually_Add_Node);



function edit_Z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Z as text
%        str2double(get(hObject,'String')) returns contents of edit_Z as a double


% --- Executes during object creation, after setting all properties.
function edit_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_X_Callback(hObject, eventdata, handles)
% hObject    handle to edit_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_X as text
%        str2double(get(hObject,'String')) returns contents of edit_X as a double


% --- Executes during object creation, after setting all properties.
function edit_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Y as text
%        str2double(get(hObject,'String')) returns contents of edit_Y as a double


% --- Executes during object creation, after setting all properties.
function edit_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_N_Callback(hObject, eventdata, handles)
% hObject    handle to edit_N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_N as text
%        str2double(get(hObject,'String')) returns contents of edit_N as a double


% --- Executes during object creation, after setting all properties.
function edit_N_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_clear.
function pushbutton_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_N,'String','');
set(handles.edit_X,'String','');
set(handles.edit_Y,'String','');
set(handles.edit_Z,'String','');


% --- Executes on selection change in listbox_perspective.
function listbox_perspective_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_perspective (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_perspective contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_perspective

n=get(handles.listbox_perspective,'Value');
[~]=Vibrationdata_Model_Plot(n); 


% --- Executes during object creation, after setting all properties.
function listbox_perspective_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_perspective (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
