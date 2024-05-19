function varargout = transmission_loss_main(varargin)
% TRANSMISSION_LOSS_MAIN MATLAB code for transmission_loss_main.fig
%      TRANSMISSION_LOSS_MAIN, by itself, creates a new TRANSMISSION_LOSS_MAIN or raises the existing
%      singleton*.
%
%      H = TRANSMISSION_LOSS_MAIN returns the handle to a new TRANSMISSION_LOSS_MAIN or the handle to
%      the existing singleton*.
%
%      TRANSMISSION_LOSS_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSMISSION_LOSS_MAIN.M with the given input arguments.
%
%      TRANSMISSION_LOSS_MAIN('Property','Value',...) creates a new TRANSMISSION_LOSS_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before transmission_loss_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to transmission_loss_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help transmission_loss_main

% Last Modified by GUIDE v2.5 30-Oct-2017 16:26:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @transmission_loss_main_OpeningFcn, ...
                   'gui_OutputFcn',  @transmission_loss_main_OutputFcn, ...
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


% --- Executes just before transmission_loss_main is made visible.
function transmission_loss_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to transmission_loss_main (see VARARGIN)

% Choose default command line output for transmission_loss_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes transmission_loss_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = transmission_loss_main_OutputFcn(hObject, eventdata, handles) 
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

delete(transmission_loss_main);


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_TL,'Value');

if(n==1)
    handles.s=TL_single_partition_reveberant;    
end 
if(n==2)
    handles.s=TL_single_partition_plane;    
end 
if(n==3)
    handles.s=TL_two_media;    
end 
if(n==4)
    handles.s=TL_three_media;    
end 


set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_TL.
function listbox_TL_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_TL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_TL contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_TL


% --- Executes during object creation, after setting all properties.
function listbox_TL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_TL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
