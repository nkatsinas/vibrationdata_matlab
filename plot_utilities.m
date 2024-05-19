function varargout = plot_utilities(varargin)
% PLOT_UTILITIES MATLAB code for plot_utilities.fig
%      PLOT_UTILITIES, by itself, creates a new PLOT_UTILITIES or raises the existing
%      singleton*.
%
%      H = PLOT_UTILITIES returns the handle to a new PLOT_UTILITIES or the handle to
%      the existing singleton*.
%
%      PLOT_UTILITIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_UTILITIES.M with the given input arguments.
%
%      PLOT_UTILITIES('Property','Value',...) creates a new PLOT_UTILITIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_utilities_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_utilities_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_utilities

% Last Modified by GUIDE v2.5 07-Mar-2014 10:44:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_utilities_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_utilities_OutputFcn, ...
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


% --- Executes just before plot_utilities is made visible.
function plot_utilities_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_utilities (see VARARGIN)

% Choose default command line output for plot_utilities
handles.output = hObject;

set(handles.listbox_type,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plot_utilities wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_utilities_OutputFcn(hObject, eventdata, handles) 
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
delete(plot_utilities);


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

if(n==1) % time history
    handles.s= vibrationdata_plot_time_history;    
end
if(n==2) % two time histories, scatter plot
    handles.s= vibrationdata_plot_scatter;    
end
if(n==3) % PSD
    handles.s= vibrationdata_psd_rms;    
end
if(n==4) % SRS
   handles.s=vibrationdata_SRS_plot;
end
if(n==5) % SRS, multiple
   handles.s=vibrationdata_SRS_plot_multiple;
end
if(n==6) % SPL
   handles.s=oaspl;  
end
if(n==7) % FT magnitude & phase
   handles.s=vibrationdata_FT_magnitude_phase;   
end
if(n==8) % FT real & imaginary
   handles.s=vibrationdata_FT_real_imaginary; 
end
if(n==9) % Nyquist & Nichols Plots
   handles.s=vibrationdata_Nyquist_Nichols; 
end
if(n==10) % Two Curves & Miscellaneous
    handles.s= plot_two_curves;   
end
if(n==11)% Multiple Curves
    handles.s=plot_multiple_curves;
end 
if(n==12)% subplots_2x1
    handles.s=subplots_2x1;
end  
if(n==13)% subplots_3x1
    handles.s=subplots_3x1;
end  

set(handles.s,'Visible','on'); 
