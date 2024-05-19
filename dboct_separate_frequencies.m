function varargout = dboct_separate_frequencies(varargin)
% DBOCT_SEPARATE_FREQUENCIES MATLAB code for dboct_separate_frequencies.fig
%      DBOCT_SEPARATE_FREQUENCIES, by itself, creates a new DBOCT_SEPARATE_FREQUENCIES or raises the existing
%      singleton*.
%
%      H = DBOCT_SEPARATE_FREQUENCIES returns the handle to a new DBOCT_SEPARATE_FREQUENCIES or the handle to
%      the existing singleton*.
%
%      DBOCT_SEPARATE_FREQUENCIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DBOCT_SEPARATE_FREQUENCIES.M with the given input arguments.
%
%      DBOCT_SEPARATE_FREQUENCIES('Property','Value',...) creates a new DBOCT_SEPARATE_FREQUENCIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dboct_separate_frequencies_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dboct_separate_frequencies_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dboct_separate_frequencies

% Last Modified by GUIDE v2.5 04-Feb-2014 15:22:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dboct_separate_frequencies_OpeningFcn, ...
                   'gui_OutputFcn',  @dboct_separate_frequencies_OutputFcn, ...
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


% --- Executes just before dboct_separate_frequencies is made visible.
function dboct_separate_frequencies_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dboct_separate_frequencies (see VARARGIN)

% Choose default command line output for dboct_separate_frequencies
handles.output = hObject;

set(handles.listbox_dimension,'value',1);
set(handles.listbox_analysis,'value',1);

listbox_dimension_Callback(hObject, eventdata, handles)
listbox_analysis_Callback(hObject, eventdata, handles);

clear_results(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dboct_separate_frequencies wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles)
%
set(handles.edit_slope_results,'Visible','off');
set(handles.edit_slope_results,'String',' ');

set(handles.uipanel5,'Visible','off');

set(handles.edit_new_coordinate,'Visible','off');
set(handles.edit_new_coordinate,'String',' ');



% --- Outputs from this function are returned to the command line.
function varargout = dboct_separate_frequencies_OutputFcn(hObject, eventdata, handles) 
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
delete(dboct_separate_frequencies);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_slope_results,'Visible','on');

n=get(handles.listbox_dimension,'Value');
m=get(handles.listbox_analysis,'Value');

  f1=str2num(get(handles.edit_f1,'String'));
amp1=str2num(get(handles.edit_amp1,'String'));

if(m==2 || m==3)
    set(handles.edit_new_coordinate,'Visible','on');
    new_frequency=str2num(get(handles.edit_new_frequency,'String'));
end

if(m==1 || m==3)
%
  f2=str2num(get(handles.edit_f2,'String'));
amp2=str2num(get(handles.edit_amp2,'String'));
%
     noct=log(f2/f1)/log(2);
     nslope=log(amp2/amp1)/log(f2/f1);     
%
   if(n==1)
      dbpo=20*nslope*log10(2); 
   else        
      dbpo=10*nslope*log10(2);        
   end
%
   dbchange=noct*dbpo;
%
end 
if(m==2)
%
   dbpo=str2num(get(handles.edit_slope,'String'));
%
   if(n==1)
      nslope=(dbpo/20)/log10(2);
   else
      nslope=(dbpo/10)/log10(2);      
   end
%
   y=amp1*(new_frequency/f1)^(nslope); 
   if(n==1)
      s2=sprintf('%8.4g Hz, %8.4g G',new_frequency,y);
   else
      s2=sprintf('%8.4g Hz, %8.4g G^2/Hz',new_frequency,y);       
   end
%
   noct=log(new_frequency/f1)/log(2);
   dbchange=noct*dbpo;
%    
end  
if(m==3)
   y=amp1*(new_frequency/f1)^(nslope); 
   if(n==1)
      pv=y*386/(2*pi*new_frequency);
      s2=sprintf('%8.4g Hz, %8.4g G, %8.4g in/sec',new_frequency,y,pv);
   else
      s2=sprintf('%8.4g Hz, %8.4g G^2/Hz',new_frequency,y);       
   end
end  

s1=sprintf(' %7.3g dB/oct\n %7.3g log-log slope \n\n %7.3g octave span \n %7.3g dB Change',dbpo,nslope,noct,dbchange);
set(handles.edit_slope_results,'String',s1);

if(m==2 || m==3)
    set(handles.uipanel5,'Visible','on');
    set(handles.edit_new_coordinate,'String',s2);
end

% --- Executes on selection change in listbox_dimension.
function listbox_dimension_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dimension contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dimension

n=get(handles.listbox_dimension,'Value');

if(n==1)
    set(handles.text_amplitude,'String','SRS(G)');
else
    set(handles.text_amplitude,'String','PSD(G^2/Hz)');
end

clear_results(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis

m=get(handles.listbox_analysis,'Value');

if(m==1 || m==3)
    set(handles.text_coordinate_2,'Visible','on');
    set(handles.edit_f2,'Visible','on');
    set(handles.edit_amp2,'Visible','on');
else
    set(handles.text_coordinate_2,'Visible','off'); 
    set(handles.edit_f2,'Visible','off');
    set(handles.edit_amp2,'Visible','off');    
end

if(m==2)
    set(handles.edit_slope,'Visible','on');
    set(handles.text_slope,'Visible','on');    
else
    set(handles.edit_slope,'Visible','off');   
    set(handles.text_slope,'Visible','off');     
end

if(m==2 || m==3)
    set(handles.edit_new_frequency,'Visible','on');
    set(handles.text_new_frequency,'Visible','on');    
else
    set(handles.edit_new_frequency,'Visible','off');
    set(handles.text_new_frequency,'Visible','off');    
end

clear_results(hObject, eventdata, handles);



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



function edit_f1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f1 as text
%        str2double(get(hObject,'String')) returns contents of edit_f1 as a double


% --- Executes during object creation, after setting all properties.
function edit_f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_amp1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amp1 as text
%        str2double(get(hObject,'String')) returns contents of edit_amp1 as a double


% --- Executes during object creation, after setting all properties.
function edit_amp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f2 as text
%        str2double(get(hObject,'String')) returns contents of edit_f2 as a double
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_amp2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amp2 as text
%        str2double(get(hObject,'String')) returns contents of edit_amp2 as a double


% --- Executes during object creation, after setting all properties.
function edit_amp2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_slope_Callback(hObject, eventdata, handles)
% hObject    handle to edit_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_slope as text
%        str2double(get(hObject,'String')) returns contents of edit_slope as a double


% --- Executes during object creation, after setting all properties.
function edit_slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_new_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_new_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_f1 and none of its controls.
function edit_f1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_amp1 and none of its controls.
function edit_amp1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_amp2 and none of its controls.
function edit_amp2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_slope and none of its controls.
function edit_slope_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_slope (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_new_frequency and none of its controls.
function edit_new_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_frequency (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_slope_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_slope_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_slope_results as text
%        str2double(get(hObject,'String')) returns contents of edit_slope_results as a double


% --- Executes during object creation, after setting all properties.
function edit_slope_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_slope_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_coordinate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_coordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_coordinate as text
%        str2double(get(hObject,'String')) returns contents of edit_new_coordinate as a double


% --- Executes during object creation, after setting all properties.
function edit_new_coordinate_CreateFcn(hObject, eventdata, ~)
% hObject    handle to edit_new_coordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
