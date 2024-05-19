function varargout = modal_overlap(varargin)
% MODAL_OVERLAP MATLAB code for modal_overlap.fig
%      MODAL_OVERLAP, by itself, creates a new MODAL_OVERLAP or raises the existing
%      singleton*.
%
%      H = MODAL_OVERLAP returns the handle to a new MODAL_OVERLAP or the handle to
%      the existing singleton*.
%
%      MODAL_OVERLAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODAL_OVERLAP.M with the given input arguments.
%
%      MODAL_OVERLAP('Property','Value',...) creates a new MODAL_OVERLAP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modal_overlap_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modal_overlap_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modal_overlap

% Last Modified by GUIDE v2.5 31-Dec-2015 13:47:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modal_overlap_OpeningFcn, ...
                   'gui_OutputFcn',  @modal_overlap_OutputFcn, ...
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


% --- Executes just before modal_overlap is made visible.
function modal_overlap_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modal_overlap (see VARARGIN)

% Choose default command line output for modal_overlap
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modal_overlap wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)
%
n=get(handles.listbox_band,'Value');

set(handles.text_freq1,'Visible','off');
set(handles.text_freq2,'Visible','off');
set(handles.edit_f,'Visible','off');
set(handles.text_md1,'Visible','off');
set(handles.text_md2,'Visible','off');
set(handles.edit_md,'Visible','off');
set(handles.text_lf,'Visible','off');
set(handles.edit_lf,'Visible','off');
set(handles.uipanel_M,'Visible','off');

set(handles.text_a1,'Visible','off');
set(handles.text_a2,'Visible','off');
set(handles.text_a3,'Visible','off');
set(handles.text_a4,'Visible','off');
set(handles.text_a5,'Visible','off');
set(handles.edit_input_array,'Visible','off');


if(n==1) % single

    set(handles.text_freq1,'Visible','on');
    set(handles.text_freq2,'Visible','on');
    set(handles.edit_f,'Visible','on');
    set(handles.text_md1,'Visible','on');
    set(handles.text_md2,'Visible','on');
    set(handles.edit_md,'Visible','on');
    set(handles.text_lf,'Visible','on');
    set(handles.edit_lf,'Visible','on');
    set(handles.uipanel_M,'Visible','on'); 

else
    set(handles.text_a1,'Visible','on');
    set(handles.text_a2,'Visible','on');
    set(handles.text_a3,'Visible','on');
    set(handles.text_a4,'Visible','on');
    set(handles.text_a5,'Visible','on');
    set(handles.edit_input_array,'Visible','on');
end



% --- Outputs from this function are returned to the command line.
function varargout = modal_overlap_OutputFcn(hObject, eventdata, handles) 
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

delete(modal_overlap);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_band,'Value');

if(n==1)

    md=str2num(get(handles.edit_md,'String'));
    f=str2num(get(handles.edit_f,'String'));
    lf=str2num(get(handles.edit_lf,'String'));

    M=md*f*lf;
    sss=sprintf('%8.4g',M);
    set(handles.edit_M,'String',sss);
    set(handles.uipanel_M,'Visible','on');

else

    try
        FS=get(handles.edit_input_array,'String');
        THM=evalin('base',FS);  

    catch  
        warndlg('Input Array does not exist.  Try again.')
        return;
    end

    sz=size(THM);

    if(sz(2)~=3)
        warndlg('Input array must have 3 columns');  
        return; 
    end
    
    f=THM(:,1);
    md=THM(:,2);
    lf=THM(:,3);
    
    NL=length(f);
    
    M=zeros(NL,1);
    
    
    disp('  ');
     
    disp(' M < 1  use deterministic method ');
    disp(' M > 1  use statistical energy analysis ');
   
    disp(' ');
    disp('  Freq   Modal Dens   Loss      ');
    disp('  (Hz)   (modes/Hz)  Factor    M  ');    
    
    for i=1:NL
        M(i)=f(i)*lf(i)*md(i);
        out1=sprintf(' %7.4g  %7.4g  %7.4g  %7.4g ',f(i),md(i),lf(i),M(i));
        disp(out1);
    end
    
    msgbox('Results Written to Command Window ');
    
end


function edit_M_Callback(hObject, eventdata, handles)
% hObject    handle to edit_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_M as text
%        str2double(get(hObject,'String')) returns contents of edit_M as a double


% --- Executes during object creation, after setting all properties.
function edit_M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md as text
%        str2double(get(hObject,'String')) returns contents of edit_md as a double


% --- Executes during object creation, after setting all properties.
function edit_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f as text
%        str2double(get(hObject,'String')) returns contents of edit_f as a double


% --- Executes during object creation, after setting all properties.
function edit_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf as text
%        str2double(get(hObject,'String')) returns contents of edit_lf as a double


% --- Executes during object creation, after setting all properties.
function edit_lf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_md and none of its controls.
function edit_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
change(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_f and none of its controls.
function edit_f_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_f (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
change(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_lf and none of its controls.
function edit_lf_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
change(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    A = imread('modal_overlap.jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on selection change in listbox_band.
function listbox_band_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_band_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f as text
%        str2double(get(hObject,'String')) returns contents of edit_f as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
