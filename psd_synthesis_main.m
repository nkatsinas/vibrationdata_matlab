function varargout = psd_synthesis_main(varargin)
% PSD_SYNTHESIS_MAIN MATLAB code for psd_synthesis_main.fig
%      PSD_SYNTHESIS_MAIN, by itself, creates a new PSD_SYNTHESIS_MAIN or raises the existing
%      singleton*.
%
%      H = PSD_SYNTHESIS_MAIN returns the handle to a new PSD_SYNTHESIS_MAIN or the handle to
%      the existing singleton*.
%
%      PSD_SYNTHESIS_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PSD_SYNTHESIS_MAIN.M with the given input arguments.
%
%      PSD_SYNTHESIS_MAIN('Property','Value',...) creates a new PSD_SYNTHESIS_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before psd_synthesis_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to psd_synthesis_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help psd_synthesis_main

% Last Modified by GUIDE v2.5 08-Oct-2021 21:25:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @psd_synthesis_main_OpeningFcn, ...
                   'gui_OutputFcn',  @psd_synthesis_main_OutputFcn, ...
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


% --- Executes just before psd_synthesis_main is made visible.
function psd_synthesis_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to psd_synthesis_main (see VARARGIN)

% Choose default command line output for psd_synthesis_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes psd_synthesis_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = psd_synthesis_main_OutputFcn(hObject, eventdata, handles) 
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

delete(psd_synthesis_main);


% --- Executes on button press in pushbutton_force.
function pushbutton_force_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

p=get(handles.listbox_force,'Value');

       if(p==1) % time history synthesis - white noise
           handles.s= vibrationdata_psd_syn_wnb;             
       end      
       if(p==2) % time history synthesis - white noise, kurtosis
           handles.s= vibrationdata_psd_syn_wnb_kurtosis;             
       end         
       if(p==3) % time history synthesis - sine
           handles.s= vibrationdata_psd_syn_fp_sine;             
       end 
       if(p==4) % time history synthesis - two PSDs
           handles.s=two_psd_synthesis_variable_phase;             
       end 
       
       set(handles.s,'Visible','on');

% --- Executes on selection change in listbox_force.
function listbox_force_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force


% --- Executes during object creation, after setting all properties.
function listbox_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_acc.
function pushbutton_acc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_acc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

p=get(handles.listbox_acc,'Value');

       if(p==1) % PSD synthesis
           handles.s= vibrationdata_PSD_accel_synth;    
       end  
       if(p==2) % PSD synthesis, two PSDs
           handles.s= vibrationdata_PSD_accel_synth_two;    
       end  

set(handles.s,'Visible','on');

% --- Executes on selection change in listbox_acc.
function listbox_acc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acc


% --- Executes during object creation, after setting all properties.
function listbox_acc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
