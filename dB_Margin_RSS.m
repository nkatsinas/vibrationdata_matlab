function varargout = dB_Margin_RSS(varargin)
% DB_MARGIN_RSS MATLAB code for dB_Margin_RSS.fig
%      DB_MARGIN_RSS, by itself, creates a new DB_MARGIN_RSS or raises the existing
%      singleton*.
%
%      H = DB_MARGIN_RSS returns the handle to a new DB_MARGIN_RSS or the handle to
%      the existing singleton*.
%
%      DB_MARGIN_RSS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DB_MARGIN_RSS.M with the given input arguments.
%
%      DB_MARGIN_RSS('Property','Value',...) creates a new DB_MARGIN_RSS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dB_Margin_RSS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dB_Margin_RSS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dB_Margin_RSS

% Last Modified by GUIDE v2.5 18-Jul-2018 13:56:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dB_Margin_RSS_OpeningFcn, ...
                   'gui_OutputFcn',  @dB_Margin_RSS_OutputFcn, ...
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


% --- Executes just before dB_Margin_RSS is made visible.
function dB_Margin_RSS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dB_Margin_RSS (see VARARGIN)

% Choose default command line output for dB_Margin_RSS
handles.output = hObject;

Ncolumns=1;
Nrows=10;

set(handles.uitable_value,'Data',cell(Nrows,Ncolumns),'ColumnName',{'dB Value'});



change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dB_Margin_RSS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)
%

try

    A=char(get(handles.uitable_value,'Data'));
    R=str2num(A);

catch
end

n=get(handles.listbox_num,'Value');

m=n+1;
 
Nrows=m;
Ncolumns=1;

set(handles.uitable_value,'Data',cell(Nrows,Ncolumns)); 

for i = 1:m
    data_s{i,1} = '';     
end



for i = 1:m
    try
        data_s{i,1} = sprintf('%5.3g',R(i));
    end    
end

set(handles.uitable_value,'Data',data_s);



set(handles.uipanel_result,'Visible','off');




% --- Outputs from this function are returned to the command line.
function varargout = dB_Margin_RSS_OutputFcn(hObject, eventdata, handles) 
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

delete(dB_Margin_RSS);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * *');
disp(' ');

n=get(handles.listbox_num,'Value');

m=n+1;

try
    A=char(get(handles.uitable_value,'Data'));
    R=str2num(A);
catch
    warndlg('Data input error');
    return; 
end

try
    
    for i=1:m

        if(isempty(R(i)))
            warndlg('Missing dB value'); 
            return; 
        end

    end
catch
    warndlg('Missing dB value'); 
    return;     
end    
    


%
C=20;

sum=0;

for i=1:m
  scale=10^(R(i)/C);
  sum=sum+(scale-1)^2;
  
%%  out1=sprintf('R=%g  scale=%7.3g  scale^2=%7.3g ',R(i),scale,scale^2);
%%  disp(out1);
  
end


oadb=C*log10(1+sqrt(sum));
%
out1=sprintf('\n overall margin = %8.4g dB \n',oadb);
disp(out1);

ss=sprintf('%6.4g',oadb);

set(handles.edit_rss,'String',ss);

set(handles.uipanel_result,'Visible','on');


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num
change(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function uitable_value_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uitable_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');



function edit_rss_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rss as text
%        str2double(get(hObject,'String')) returns contents of edit_rss as a double


% --- Executes during object creation, after setting all properties.
function edit_rss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on uitable_value and none of its controls.
function uitable_value_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_value (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');
