function varargout = vibrationdata_autocorrelation(varargin)
% VIBRATIONDATA_AUTOCORRELATION MATLAB code for vibrationdata_autocorrelation.fig
%      VIBRATIONDATA_AUTOCORRELATION, by itself, creates a new VIBRATIONDATA_AUTOCORRELATION or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_AUTOCORRELATION returns the handle to a new VIBRATIONDATA_AUTOCORRELATION or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_AUTOCORRELATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_AUTOCORRELATION.M with the given input arguments.
%
%      VIBRATIONDATA_AUTOCORRELATION('Property','Value',...) creates a new VIBRATIONDATA_AUTOCORRELATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_autocorrelation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_autocorrelation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_autocorrelation

% Last Modified by GUIDE v2.5 29-May-2013 10:12:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_autocorrelation_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_autocorrelation_OutputFcn, ...
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


% --- Executes just before vibrationdata_autocorrelation is made visible.
function vibrationdata_autocorrelation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_autocorrelation (see VARARGIN)

% Choose default command line output for vibrationdata_autocorrelation
handles.output = hObject;

set(handles.listbox_method,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_autocorrelation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_autocorrelation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

YS=get(handles.edit_ylabel,'String');

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end
%
amp=THM(:,2);
%
xmax=0;
tmax=0;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
n = length(amp);

dt=(THM(n,1)-THM(1,1))/(n-1);

disp(' ')
disp(' Autocorrelation ');

out1=sprintf(' n=%d  dt=%8.4g ',n,dt);
disp(out1);

%# autocorrelation

ac1 = ifft(abs(fft(amp, 2*n-1)).^2);

ac1=ac1/n;

sz=size(ac1);
if(sz(2)>sz(1))
    ac1=ac1';
end

m=floor(length(ac1)/2);

ac2 = ac1(1:m);

ac2r=flipud(ac2);

ac2r(m)=[];

ac3=[ ac2r ; ac2];

n=length(ac3);

t=linspace(0,(n-1)*dt,n);

t=t-t(n)/2;

[~,I] = min(abs(t));

t(I)=0;


sz=size(t);
if(sz(2)>sz(1))
    t=t';
end

xc=[t,ac3];
%
    clear C;
    clear I;
    [C,I]=max(xc);
    xmax=xc(I(2),2);
    tmax=xc(I(2),1);
   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    figure(1);
    plot(THM(:,1),THM(:,2));
    title('Time History');
    xlabel(' Time(sec) ')
    ylabel(YS)
    grid on;
%
    disp(' ');
    out1=sprintf(' Maximum occurs at %6.4g sec  Amp = %8.4g',tmax,xmax);
    disp(out1);
%
    figure(2);
    plot(xc(:,1),xc(:,2));
    xlabel(' Delay(sec) ');
    ylabel('Rxx')
    out1=sprintf(' Autocorrelation   Max at %6.4g sec  Amp=%8.4g',tmax,xmax);
    title(out1);
    grid on;
%



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_autocorrelation);


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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

n=get(hObject,'Value');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end

% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
