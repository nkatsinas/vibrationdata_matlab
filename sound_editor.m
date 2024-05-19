function varargout = sound_editor(varargin)
% SOUND_EDITOR MATLAB code for sound_editor.fig
%      SOUND_EDITOR, by itself, creates a new SOUND_EDITOR or raises the existing
%      singleton*.
%
%      H = SOUND_EDITOR returns the handle to a new SOUND_EDITOR or the handle to
%      the existing singleton*.
%
%      SOUND_EDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOUND_EDITOR.M with the given input arguments.
%
%      SOUND_EDITOR('Property','Value',...) creates a new SOUND_EDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sound_editor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sound_editor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sound_editor

% Last Modified by GUIDE v2.5 17-Jun-2016 11:16:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sound_editor_OpeningFcn, ...
                   'gui_OutputFcn',  @sound_editor_OutputFcn, ...
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


% --- Executes just before sound_editor is made visible.
function sound_editor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sound_editor (see VARARGIN)

% Choose default command line output for sound_editor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sound_editor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sound_editor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_read_wav.
function pushbutton_read_wav_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s1= read_wave_file;
set(handles.s1,'Visible','on');


% --- Executes on button press in pushbutton_generate.
function pushbutton_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s2= generate_sound;
set(handles.s2,'Visible','on');

% --- Executes on button press in pushbutton_read_txt.
function pushbutton_read_txt_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s3= read_convert_text;
set(handles.s3,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(sound_editor);
