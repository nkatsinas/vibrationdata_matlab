function varargout = statistical_distributions(varargin)
% STATISTICAL_DISTRIBUTIONS MATLAB code for statistical_distributions.fig
%      STATISTICAL_DISTRIBUTIONS, by itself, creates a new STATISTICAL_DISTRIBUTIONS or raises the existing
%      singleton*.
%
%      H = STATISTICAL_DISTRIBUTIONS returns the handle to a new STATISTICAL_DISTRIBUTIONS or the handle to
%      the existing singleton*.
%
%      STATISTICAL_DISTRIBUTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATISTICAL_DISTRIBUTIONS.M with the given input arguments.
%
%      STATISTICAL_DISTRIBUTIONS('Property','Value',...) creates a new STATISTICAL_DISTRIBUTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before statistical_distributions_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to statistical_distributions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help statistical_distributions

% Last Modified by GUIDE v2.5 24-Jul-2015 17:35:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @statistical_distributions_OpeningFcn, ...
                   'gui_OutputFcn',  @statistical_distributions_OutputFcn, ...
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


% --- Executes just before statistical_distributions is made visible.
function statistical_distributions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to statistical_distributions (see VARARGIN)

% Choose default command line output for statistical_distributions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes statistical_distributions wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = statistical_distributions_OutputFcn(hObject, eventdata, handles) 
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
delete(statistical_distributions);


% --- Executes on button press in pushbutton_Normal.
function pushbutton_Normal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=normal_distribution;    
set(handles.s,'Visible','on'); 

% --- Executes on button press in pushbutton_Rayleigh.
function pushbutton_Rayleigh_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Rayleigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Rayleigh_distribution;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_Poisson.
function pushbutton_Poisson_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Poisson_distribution;    
set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis


% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analysis.
function pushbutton_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s=normal_distribution; 
end
if(n==2)
    handles.s=Rayleigh_distribution;  
end
if(n==3)
    handles.s=Poisson_distribution; 
end
if(n==4)
    handles.s=vibrationdata_tolerance_factor; 
end
if(n==5)
    handles.s=exponential_distribution; 
end
if(n==6)
    handles.s=Weibull_distribution; 
end
if(n==7)
    handles.s=descriptive_statistics; 
end

set(handles.s,'Visible','on'); 
