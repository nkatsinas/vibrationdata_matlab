function varargout = Vibrationdata_FEA_Copy_Node(varargin)
% VIBRATIONDATA_FEA_COPY_NODE MATLAB code for Vibrationdata_FEA_Copy_Node.fig
%      VIBRATIONDATA_FEA_COPY_NODE, by itself, creates a new VIBRATIONDATA_FEA_COPY_NODE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FEA_COPY_NODE returns the handle to a new VIBRATIONDATA_FEA_COPY_NODE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FEA_COPY_NODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FEA_COPY_NODE.M with the given input arguments.
%
%      VIBRATIONDATA_FEA_COPY_NODE('Property','Value',...) creates a new VIBRATIONDATA_FEA_COPY_NODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_FEA_Copy_Node_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_FEA_Copy_Node_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_FEA_Copy_Node

% Last Modified by GUIDE v2.5 13-Mar-2014 14:49:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_FEA_Copy_Node_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_FEA_Copy_Node_OutputFcn, ...
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


% --- Executes just before Vibrationdata_FEA_Copy_Node is made visible.
function Vibrationdata_FEA_Copy_Node_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_FEA_Copy_Node (see VARARGIN)

% Choose default command line output for Vibrationdata_FEA_Copy_Node
handles.output = hObject;

set_listbox(hObject, eventdata, handles);

set(handles.pushbutton_copy,'Visible','on');  % leave on

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_FEA_Copy_Node wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_FEA_Copy_Node_OutputFcn(hObject, eventdata, handles) 
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

delete(Vibrationdata_FEA_Copy_Node);


% --- Executes on selection change in listbox_nodes.
function listbox_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nodes

iflag=0;

try

    ncoor=getappdata(0,'ncoor');

    iflag=1;
        
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);    
    warndlg('No existing nodes.  ref 1');
end

if(iflag==1)
    n=get(handles.listbox_nodes,'Value');
    
    ss=sprintf('%d',ncoor(n,1));
    
    set(handles.edit_node,'String',ss);
end


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


function set_listbox(hObject, eventdata, handles)
%

iflag=0;

try

    ncoor=getappdata(0,'ncoor');
    
    iflag=1;
        
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);    
    warndlg('No existing nodes.  ref 2');
end

if(iflag==1)
 sz=size(ncoor);
    
    if(sz(1)>=1)
        
    
        set(handles.listbox_nodes,'Visible','on');  
        set(handles.pushbutton_copy,'Visible','on');
        
        n=get(handles.listbox_nodes,'Value');
        
        sz(1);

        clear string_th;
    
        for i=1:sz(1)
            string_th{i}=sprintf(' %d  (%7.4g, %7.4g, %7.4g) ',ncoor(i,1),ncoor(i,2),ncoor(i,3),ncoor(i,4));
        end

    
        set(handles.listbox_nodes,'String',string_th); 
        
        nc1=sprintf('%d',ncoor(n,1));
        set(handles.edit_node,'String',nc1);
        
        
    else    
        warndlg('No existing nodes.  ref 3');
    end
end



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



function edit_number_repititions_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number_repititions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number_repititions as text
%        str2double(get(hObject,'String')) returns contents of edit_number_repititions as a double


% --- Executes during object creation, after setting all properties.
function edit_number_repititions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_repititions (see GCBO)
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


% --- Executes on button press in pushbutton_copy.
function pushbutton_copy_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_copy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iflag=0;

try
    ncoor=getappdata(0,'ncoor');    
      
    iflag=1;
    
catch
    ncoor=[];  
    warndlg('No existing nodes');
end

if(iflag==1)
      sz=size(ncoor);
    s=sz(1);
    nmax=max(ncoor(:,1));
    
    n=get(handles.listbox_nodes,'Value');
    num=str2num(get(handles.edit_number_repititions,'String'));
    
    dx=str2num(get(handles.edit_X,'String'));
    dy=str2num(get(handles.edit_Y,'String'));
    dz=str2num(get(handles.edit_Z,'String'));
    
    x1=ncoor(n,2);
    y1=ncoor(n,3);
    z1=ncoor(n,4);
    
    for i=1:num
        s=s+1;
        nmax=nmax+1;
        
        nx=x1+dx*i;
        ny=y1+dy*i;
        nz=z1+dz*i;
        
        ncoor(s,:)=[nmax nx ny nz 0 0 0 0 0 0];
    end
    
    setappdata(0,'ncoor',ncoor);
    
    set_listbox(hObject, eventdata, handles);
    
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
