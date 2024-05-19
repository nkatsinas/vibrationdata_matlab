function varargout = annular_plate_bending(varargin)
% ANNULAR_PLATE_BENDING MATLAB code for annular_plate_bending.fig
%      ANNULAR_PLATE_BENDING, by itself, creates a new ANNULAR_PLATE_BENDING or raises the existing
%      singleton*.
%
%      H = ANNULAR_PLATE_BENDING returns the handle to a new ANNULAR_PLATE_BENDING or the handle to
%      the existing singleton*.
%
%      ANNULAR_PLATE_BENDING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANNULAR_PLATE_BENDING.M with the given input arguments.
%
%      ANNULAR_PLATE_BENDING('Property','Value',...) creates a new ANNULAR_PLATE_BENDING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before annular_plate_bending_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to annular_plate_bending_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help annular_plate_bending

% Last Modified by GUIDE v2.5 13-Mar-2014 17:17:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @annular_plate_bending_OpeningFcn, ...
                   'gui_OutputFcn',  @annular_plate_bending_OutputFcn, ...
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


% --- Executes just before annular_plate_bending is made visible.
function annular_plate_bending_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to annular_plate_bending (see VARARGIN)

% Choose default command line output for annular_plate_bending
handles.output = hObject;



%% handles.s1= annular_homogeneous;
%% handles.s2= annular_honeycomb;




%% set(handles.s1,'Visible','off');
%% set(handles.s2,'Visible','off');



% Update handles structure
guidata(hObject, handles);



% UIWAIT makes annular_plate_bending wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = annular_plate_bending_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in construction_listbox.
function construction_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to construction_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns construction_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from construction_listbox

choice=0;

choice=get(hObject,'Value');

out1=sprintf(' construction %d ',choice);
disp(out1);

if(choice==1)
   set(handles.s1,'Visible','on');
end
if(choice==2)
   set(handles.s2,'Visible','on');    
end

% annular_plate_bending_OpeningFcn(hObject, eventdata, handles, varargin);


% Update handles structure
% guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function construction_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to construction_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in homogeneous_pushbutton.
function homogeneous_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to homogeneous_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   set(annular_homogeneous,'Visible','on');


% --- Executes on button press in honeycomb_pushbutton.
function honeycomb_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to honeycomb_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   set(annular_honeycomb,'Visible','on');   


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(annular_plate_bending);

