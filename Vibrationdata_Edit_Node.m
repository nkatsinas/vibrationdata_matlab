function varargout = Vibrationdata_Edit_Node(varargin)
% VIBRATIONDATA_EDIT_NODE MATLAB code for Vibrationdata_Edit_Node.fig
%      VIBRATIONDATA_EDIT_NODE, by itself, creates a new VIBRATIONDATA_EDIT_NODE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_EDIT_NODE returns the handle to a new VIBRATIONDATA_EDIT_NODE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_EDIT_NODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_EDIT_NODE.M with the given input arguments.
%
%      VIBRATIONDATA_EDIT_NODE('Property','Value',...) creates a new VIBRATIONDATA_EDIT_NODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_Edit_Node_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_Edit_Node_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_Edit_Node

% Last Modified by GUIDE v2.5 25-Mar-2014 09:12:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_Edit_Node_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_Edit_Node_OutputFcn, ...
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


% --- Executes just before Vibrationdata_Edit_Node is made visible.
function Vibrationdata_Edit_Node_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_Edit_Node (see VARARGIN)

% Choose default command line output for Vibrationdata_Edit_Node
handles.output = hObject;

set_listbox(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_Edit_Node wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_Edit_Node_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function set_listbox(hObject, eventdata, handles)
%


set(handles.listbox_nodes,'String',''); 


try
    disp(' edit node ');
    ncoor=getappdata(0,'ncoor');
    
    sz=size(ncoor);
        
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);    
    warndlg('No existing nodes');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(sz(1)>=1)
            
        set(handles.listbox_nodes,'Visible','on');  
        set(handles.pushbutton_save_change,'Visible','on');
        
        n=get(handles.listbox_nodes,'Value');

        sz(1);        
        
        if(n>sz(1))
            n=1;
        end    
       
        clear string_th;
    
        for i=1:sz(1)
            string_th{i}=sprintf(' %d  (%7.4g, %7.4g, %7.4g) ',ncoor(i,1),ncoor(i,2),ncoor(i,3),ncoor(i,4));
        end

    
        set(handles.listbox_nodes,'String',string_th); 

        if(n<=sz(1))

            nc1=sprintf('%d',ncoor(n,1));
            ncx=sprintf('%8.4g',ncoor(n,2));
            ncy=sprintf('%8.4g',ncoor(n,3));
            ncz=sprintf('%8.4g',ncoor(n,4));

        else
            nc1='';
            ncx='';
            ncy='';
            ncz='';          
        end
        
        set(handles.edit_node,'String',nc1);        
        set(handles.edit_X,'String',ncx);  
        set(handles.edit_Y,'String',ncy); 
        set(handles.edit_Z,'String',ncz);            
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(Vibrationdata_Edit_Node);


% --- Executes on selection change in listbox_nodes.
function listbox_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nodes

set_listbox(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_nodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_change.
function pushbutton_save_change_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_nodes,'Value');

ncoor=getappdata(0,'ncoor');

nc1=str2num(get(handles.edit_node,'String'));
ncx=str2num(get(handles.edit_X,'String'));
ncy=str2num(get(handles.edit_Y,'String'));
ncz=str2num(get(handles.edit_Z,'String'));

sz=size(ncoor);

iflag=1;

ncoor;
%% disp(' ref 1');

tx=ncoor(n,5);
ty=ncoor(n,6);
tz=ncoor(n,7);
rx=ncoor(n,8);
ry=ncoor(n,9);
rz=ncoor(n,10);

ncoor(n,:)=[nc1 ncx ncy ncz tx ty tz rx ry rz];
setappdata(0,'ncoor',ncoor);    
set_listbox(hObject, eventdata, handles);

np=get(handles.listbox_perspective,'Value');
Vibrationdata_Model_Plot(np);



function edit_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_node as text
%        str2double(get(hObject,'String')) returns contents of edit_node as a double


% --- Executes during object creation, after setting all properties.
function edit_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
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


% --- Executes on button press in pushbutton_delete_node.
function pushbutton_delete_node_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' delete ');

n=get(handles.listbox_nodes,'Value')

%%%% ncoor=evalin('base','ncoor');

iflag=0;

try
    ncoor=getappdata(0,'ncoor');
 
    iflag=1;
 
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);
    set(handles.axes1,'Visible','off');
end

if(iflag==1)
    
    ncoor(n,:)=[];

    setappdata(0,'ncoor',ncoor);
        
    ncoor
    
    set_listbox(hObject, eventdata, handles);

    set(handles.listbox_nodes,'Value',1);
    
    np=get(handles.listbox_perspective,'Value');
    Vibrationdata_Model_Plot(np);
end

% --- Executes on selection change in listbox_perspective.
function listbox_perspective_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_perspective (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_perspective contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_perspective
n=get(handles.listbox_perspective,'Value');
Vibrationdata_Model_Plot(n);


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
