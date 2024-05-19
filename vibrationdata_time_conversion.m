function varargout = vibrationdata_time_conversion(varargin)
% VIBRATIONDATA_TIME_CONVERSION MATLAB code for vibrationdata_time_conversion.fig
%      VIBRATIONDATA_TIME_CONVERSION, by itself, creates a new VIBRATIONDATA_TIME_CONVERSION or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TIME_CONVERSION returns the handle to a new VIBRATIONDATA_TIME_CONVERSION or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TIME_CONVERSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TIME_CONVERSION.M with the given input arguments.
%
%      VIBRATIONDATA_TIME_CONVERSION('Property','Value',...) creates a new VIBRATIONDATA_TIME_CONVERSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_time_conversion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_time_conversion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_time_conversion

% Last Modified by GUIDE v2.5 02-Apr-2017 14:12:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_time_conversion_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_time_conversion_OutputFcn, ...
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


% --- Executes just before vibrationdata_time_conversion is made visible.
function vibrationdata_time_conversion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_time_conversion (see VARARGIN)

% Choose default command line output for vibrationdata_time_conversion
handles.output = hObject;

listbox_analysis_Callback(hObject, eventdata, handles);

Ncolumns=4;
Nrows=1;
set(handles.uitable1,'Data',cell(Nrows,Ncolumns));


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_time_conversion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_time_conversion_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_time_conversion);


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ia=get(handles.listbox_analysis,'Value');

disp(' ');
disp(' * * * * * * * ');


if(ia==1)
    tsec=str2num(get(handles.edit_tsec','String'));
    
    out1=sprintf('\n  Input Time = %g sec',tsec);
    disp(out1);    
    
    
    tdays=floor(tsec/86400);
%
    residual=tsec-tdays*86400;
    
    thr=floor(residual/3600);
    
    residual=residual-thr*3600;
    
    tmin=floor(residual/60);
    
    residual=residual-tmin*60;
    
    tsec=residual;

    if(tdays>365)
        years=tdays/365.25;
        fprintf('\n %8.4g years  (ref: 365.25 days per year) \n',years);
    end    
    
    fprintf('\n %d days %d hr %d min %g sec \n',tdays,thr,tmin,tsec);
    
    fprintf('\n       %g hr %g min %g sec \n',(24*tdays+thr),tmin,tsec);
    
    fprintf('\n %d:%d:%d:%g \n',tdays,thr,tmin,tsec);
    
else
    
    C=get(handles.uitable1,'Data');
    
    if(isempty(C{1}))
        C{1}='0';
    end
    if(isempty(C{2}))
        C{2}='0';
    end
    if(isempty(C{3}))
        C{3}='0';
    end
    if(isempty(C{4}))
        C{4}='0';
    end    
    
    A=char(C);  
    
    B=str2num(A);
    
    days=B(1);
    hr=B(2);
    min=B(3);
    sec=B(4);    
    
    fprintf('\n %g days  %g hrs  %g min %g sec \n',days,hr,min,sec);
    
    fprintf('\n          %g hrs  %g min %g sec \n',(24*days+hr),min,sec);
    
    
    
    total=sec+min*60+hr*3600+days*86400;
    string=sprintf('\n total time = %10.4g sec',total);
    disp(string) 
end

msgbox(' Result written to Command Window ');


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis

ia=get(handles.listbox_analysis,'Value');

set(handles.text_tsec,'Visible','off');
set(handles.edit_tsec,'Visible','off');

set(handles.text_mixed,'Visible','off');
set(handles.uitable1,'Visible','off');


if(ia==1)
    set(handles.text_tsec,'Visible','on');
    set(handles.edit_tsec,'Visible','on'); 
else
    set(handles.text_mixed,'Visible','on');
    set(handles.uitable1,'Visible','on');    
end




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



function edit_tsec_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tsec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tsec as text
%        str2double(get(hObject,'String')) returns contents of edit_tsec as a double


% --- Executes during object creation, after setting all properties.
function edit_tsec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tsec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
