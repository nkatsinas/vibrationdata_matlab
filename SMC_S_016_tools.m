function varargout = SMC_S_016_tools(varargin)
% SMC_S_016_TOOLS MATLAB code for SMC_S_016_tools.fig
%      SMC_S_016_TOOLS, by itself, creates a new SMC_S_016_TOOLS or raises the existing
%      singleton*.
%
%      H = SMC_S_016_TOOLS returns the handle to a new SMC_S_016_TOOLS or the handle to
%      the existing singleton*.
%
%      SMC_S_016_TOOLS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SMC_S_016_TOOLS.M with the given input arguments.
%
%      SMC_S_016_TOOLS('Property','Value',...) creates a new SMC_S_016_TOOLS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SMC_S_016_tools_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SMC_S_016_tools_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SMC_S_016_tools

% Last Modified by GUIDE v2.5 18-Dec-2020 08:59:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SMC_S_016_tools_OpeningFcn, ...
                   'gui_OutputFcn',  @SMC_S_016_tools_OutputFcn, ...
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


% --- Executes just before SMC_S_016_tools is made visible.
function SMC_S_016_tools_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SMC_S_016_tools (see VARARGIN)

% Choose default command line output for SMC_S_016_tools
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SMC_S_016_tools wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SMC_S_016_tools_OutputFcn(hObject, eventdata, handles) 
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

delete(SMC_S_016_tools);


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox1,'Value');

if(n==1)
    [fig_num]=smc_s_16_psd_function();
end
if(n==2)
    [fig_num]=TQ_qualification_duration();
end
if(n==3)
    [fig_num]=LPC_level();
end
if(n==4)
    smc_s_016_psd_spl_mpe; 
end