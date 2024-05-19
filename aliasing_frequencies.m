function varargout = aliasing_frequencies(varargin)
% ALIASING_FREQUENCIES MATLAB code for aliasing_frequencies.fig
%      ALIASING_FREQUENCIES, by itself, creates a new ALIASING_FREQUENCIES or raises the existing
%      singleton*.
%
%      H = ALIASING_FREQUENCIES returns the handle to a new ALIASING_FREQUENCIES or the handle to
%      the existing singleton*.
%
%      ALIASING_FREQUENCIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALIASING_FREQUENCIES.M with the given input arguments.
%
%      ALIASING_FREQUENCIES('Property','Value',...) creates a new ALIASING_FREQUENCIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aliasing_frequencies_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aliasing_frequencies_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aliasing_frequencies

% Last Modified by GUIDE v2.5 31-Mar-2014 14:18:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aliasing_frequencies_OpeningFcn, ...
                   'gui_OutputFcn',  @aliasing_frequencies_OutputFcn, ...
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


% --- Executes just before aliasing_frequencies is made visible.
function aliasing_frequencies_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aliasing_frequencies (see VARARGIN)

% Choose default command line output for aliasing_frequencies
handles.output = hObject;

set(handles.listbox_type,'Value',1);
listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aliasing_frequencies wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aliasing_frequencies_OutputFcn(hObject, eventdata, handles) 
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

delete(aliasing_frequencies);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

sr=str2num(get(handles.edit_SR,'String'));
sf=sr;

nf=sr/2.;


if(n==1)
        ef=str2num(get(handles.edit_box2,'String'));
    
        iflag=0;
        
        af=0.;
    
        if(ef<nf)
            msgbox(' Aliasing does not occur for this case. ');
        end
        if(ef==nf)
            msgbox(' Borderline case. ');
        end
        if(nf < ef && ef< sf)
            af=sf-ef;
            iflag=1;
        end
        
        for m=1:20
            if(ef==m*sf)
                iflag=1;
                break;
            end
            if(m*sf < ef && ef< (m+0.5)*sf) 
                af=ef-m*sf;
                iflag=1;
                break;
            end
            if((m+0.5)*sf < ef && ef< (m+1)*sf)
                af=af-ef+(m+1)*sf;
                iflag=1;
                break;
            end
        end
        if(iflag==1)
            s1=sprintf('%g',af);
            set(handles.edit_results,'String',s1,'Max',5);
            set(handles.edit_results,'Visible','on');
            set(handles.text_results,'Visible','on');            
        end
else
    af=str2num(get(handles.edit_box2,'String'));
    
    
    
    j=1;
    for m=1:10
			ef=m*sf-af;
			s1{j}=sprintf('%9.5g',ef);
            j=j+1;
			ef=m*sf+af;
			s1{j}=sprintf('%9.5g',ef);
            j=j+1;
    end
    
    set(handles.edit_results,'String',s1,'Max',14);
    set(handles.edit_results,'Visible','on');
    set(handles.text_results,'Visible','on');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

n=get(handles.listbox_type,'Value');

if(n==1)
    set(handles.text_box2,'String','Source Energy Frequency (Hz)');
    set(handles.text_results,'String','Aliasing Frequency (Hz)');
else
    set(handles.text_box2,'String','Resulting Aliasing Frequency (Hz)'); 
    set(handles.text_results,'String','Candiate Source Frequencies (Hz)');
end

clear_results(hObject, eventdata, handles);


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



function edit_SR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SR as text
%        str2double(get(hObject,'String')) returns contents of edit_SR as a double


% --- Executes during object creation, after setting all properties.
function edit_SR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_box2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_box2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_box2 as text
%        str2double(get(hObject,'String')) returns contents of edit_box2 as a double


% --- Executes during object creation, after setting all properties.
function edit_box2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_box2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'String','');
set(handles.edit_results,'Visible','off');
set(handles.text_results,'Visible','off')


% --- Executes on key press with focus on edit_SR and none of its controls.
function edit_SR_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_box2 and none of its controls.
function edit_box2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_box2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);
