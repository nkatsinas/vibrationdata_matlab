function varargout = descriptive_statistics(varargin)
% DESCRIPTIVE_STATISTICS MATLAB code for descriptive_statistics.fig
%      DESCRIPTIVE_STATISTICS, by itself, creates a new DESCRIPTIVE_STATISTICS or raises the existing
%      singleton*.
%
%      H = DESCRIPTIVE_STATISTICS returns the handle to a new DESCRIPTIVE_STATISTICS or the handle to
%      the existing singleton*.
%
%      DESCRIPTIVE_STATISTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DESCRIPTIVE_STATISTICS.M with the given input arguments.
%
%      DESCRIPTIVE_STATISTICS('Property','Value',...) creates a new DESCRIPTIVE_STATISTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before descriptive_statistics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to descriptive_statistics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help descriptive_statistics

% Last Modified by GUIDE v2.5 16-May-2021 14:21:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @descriptive_statistics_OpeningFcn, ...
                   'gui_OutputFcn',  @descriptive_statistics_OutputFcn, ...
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


% --- Executes just before descriptive_statistics is made visible.
function descriptive_statistics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to descriptive_statistics (see VARARGIN)

% Choose default command line output for descriptive_statistics
handles.output = hObject;

set(handles.uipanel_results,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes descriptive_statistics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = descriptive_statistics_OutputFcn(hObject, eventdata, handles) 
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

delete(descriptive_statistics)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * ');
disp('  ');

try  
    FS=get(handles.edit_input_array,'String');
    amp=evalin('base',FS);  
catch
    warndlg('Input Array does not exist.  Try again.')
end

[mu,sd,rms,sk,kt]=kurtosis_stats(amp);

md=median(amp);

y = quantile(amp,3);

sss1=sprintf('    mean = %8.4g \n',mu);
sss2=sprintf('  median = %8.4g \n\n',md);

sss3=sprintf(' std dev = %8.4g \n',sd);
sss4=sprintf('     rms = %8.4g \n\n',rms);

sss5=sprintf('     min = %8.4g \n',min(amp));
sss6=sprintf('     max = %8.4g \n\n',max(amp));

sss7=sprintf('  skewness = %8.4g \n',sk);
sss8=sprintf('  kurtosis = %8.4g \n\n',kt);

sss9=sprintf(' Quartile \n');
sss10=sprintf(' [ %8.4g  %8.4g  %8.4g ] \n',y(1),y(2),y(3));

fprintf(sss1);
fprintf(sss2);
fprintf(sss3);
fprintf(sss4);
fprintf(sss5);
fprintf(sss6);
fprintf(sss7);
fprintf(sss8);
fprintf(sss9);
fprintf(sss10);


%%%%%%%%%%%%%

sss1=sprintf('\n    mean = %8.4g \n',mu);
sss2=sprintf('  median = %8.4g \n\n',md);

sss=sprintf('%s %s %s %s %s %s %s %s %s %s',sss1,sss2,sss3,sss4,sss5,sss6,sss7,sss8,sss9,sss10);

set(handles.edit_results,'String',sss);


yy=get(handles.edit_unit,'String');

nbars=str2double(get(handles.edit_nbars,'String'));

figure(1);
plot(amp);
ylabel(yy);
xlabel('Index');
grid on;

figure(2)
histogram(amp,nbars);
xlabel(yy);
ylabel('Counts');
title('Histogram');


set(handles.uipanel_results,'Visible','on');



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



function edit_unit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_unit as text
%        str2double(get(hObject,'String')) returns contents of edit_unit as a double


% --- Executes during object creation, after setting all properties.
function edit_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_unit (see GCBO)
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


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');



function edit_nbars_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nbars (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nbars as text
%        str2double(get(hObject,'String')) returns contents of edit_nbars as a double


% --- Executes during object creation, after setting all properties.
function edit_nbars_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nbars (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
