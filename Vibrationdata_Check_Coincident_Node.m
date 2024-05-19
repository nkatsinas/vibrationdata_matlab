function varargout = Vibrationdata_Check_Coincident_Node(varargin)
% VIBRATIONDATA_CHECK_COINCIDENT_NODE MATLAB code for Vibrationdata_Check_Coincident_Node.fig
%      VIBRATIONDATA_CHECK_COINCIDENT_NODE, by itself, creates a new VIBRATIONDATA_CHECK_COINCIDENT_NODE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_CHECK_COINCIDENT_NODE returns the handle to a new VIBRATIONDATA_CHECK_COINCIDENT_NODE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_CHECK_COINCIDENT_NODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_CHECK_COINCIDENT_NODE.M with the given input arguments.
%
%      VIBRATIONDATA_CHECK_COINCIDENT_NODE('Property','Value',...) creates a new VIBRATIONDATA_CHECK_COINCIDENT_NODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_Check_Coincident_Node_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_Check_Coincident_Node_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_Check_Coincident_Node

% Last Modified by GUIDE v2.5 13-Mar-2014 14:46:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_Check_Coincident_Node_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_Check_Coincident_Node_OutputFcn, ...
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


% --- Executes just before Vibrationdata_Check_Coincident_Node is made visible.
function Vibrationdata_Check_Coincident_Node_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_Check_Coincident_Node (see VARARGIN)

% Choose default command line output for Vibrationdata_Check_Coincident_Node
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_Check_Coincident_Node wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_Check_Coincident_Node_OutputFcn(hObject, eventdata, handles) 
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

delete(Vibrationdata_Check_Coincident_Node);


function edit_tol_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tol as text
%        str2double(get(hObject,'String')) returns contents of edit_tol as a double


% --- Executes during object creation, after setting all properties.
function edit_tol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_check.
function pushbutton_check_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iflag=0;

tol=str2num(get(handles.edit_tol,'String'));


try
    ncoor=getappdata(0,'ncoor');
    iflag=1;   
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);
    warndlg('No existing nodes');
end

if(iflag==1)
   sz=size(ncoor);
   
   n=sz(1);
   
   for i=1:n-1;
        for j=i+1:n
            d=sqrt( (ncoor(i,2)-ncoor(j,2))^2 +(ncoor(i,3)-ncoor(j,3))^2 +(ncoor(i,4)-ncoor(j,4))^2);
            if(d<tol)
                 out1=sprintf('Warning, concident nodes: %d %d',ncoor(i,1),ncoor(j,1));
                 warndlg(out1);
            end
        end    
   end
   
end


% --- Executes on button press in pushbutton_check_merge.
function pushbutton_check_merge_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check_merge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iflag=0;

tol=str2num(get(handles.edit_tol,'String'));

try
    ncoor=getappdata(0,'ncoor');
    iflag=1;   
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);
    warndlg('No existing nodes');
end

if(iflag==1)
   sz=size(ncoor);
   n=sz(1);
   
   for i=n:-1:2

      for j=(i-1):-1:1
          d=sqrt( (ncoor(i,2)-ncoor(j,2))^2 +(ncoor(i,3)-ncoor(j,3))^2 +(ncoor(i,4)-ncoor(j,4))^2);
          
          if(d<tol)
                out1=sprintf('Nodes merged: %d %d',ncoor(i,1),ncoor(j,1));
                warndlg(out1);
                ncoor(i,:)=[];
                break;
          end
      end
   
   end
   
   setappdata(0,'ncoor',ncoor);
   
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
np=get(handles.listbox_perspective,'Value');
Vibrationdata_Model_Plot(np);


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
