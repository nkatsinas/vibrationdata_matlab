function varargout = liftoff_stations(varargin)
% LIFTOFF_STATIONS MATLAB code for liftoff_stations.fig
%      LIFTOFF_STATIONS, by itself, creates a new LIFTOFF_STATIONS or raises the existing
%      singleton*.
%
%      H = LIFTOFF_STATIONS returns the handle to a new LIFTOFF_STATIONS or the handle to
%      the existing singleton*.
%
%      LIFTOFF_STATIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LIFTOFF_STATIONS.M with the given input arguments.
%
%      LIFTOFF_STATIONS('Property','Value',...) creates a new LIFTOFF_STATIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before liftoff_stations_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to liftoff_stations_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help liftoff_stations

% Last Modified by GUIDE v2.5 20-Jun-2019 16:12:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @liftoff_stations_OpeningFcn, ...
                   'gui_OutputFcn',  @liftoff_stations_OutputFcn, ...
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


% --- Executes just before liftoff_stations is made visible.
function liftoff_stations_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to liftoff_stations (see VARARGIN)

% Choose default command line output for liftoff_stations
handles.output = hObject;

disp('  ');
disp(' * * * * * * * * * * ');
disp('  ');

Ncolumns=3;


listbox_stations_num_Callback(hObject, eventdata, handles);


iu=getappdata(0,'iu');

if(iu==1)
    ss='unit: inch';
else
    ss='unit: meters';
end

set(handles.text_unit,'String',ss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try

    n=getappdata(0,'n_stations');
    
    if(n>=1 && n<=10)
        set(handles.listbox_stations_num,'Value',n);
    end
    
catch
end

try 
    data_s=getappdata(0,'data_s');
    if(~isempty(data_s))
        set(handles.uitable_stations,'Data',data_s);
    end    
catch
    disp(' load none ');
    listbox_stations_Callback(hObject, eventdata, handles);    
end   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes liftoff_stations wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = liftoff_stations_OutputFcn(hObject, eventdata, handles) 
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

N=get(handles.listbox_stations_num,'Value');
setappdata(0,'n_stations',N);

A=get(handles.uitable_stations,'Data');
setappdata(0,'data_s',A);

A=char(A);

L=zeros(N,1);
diameter=zeros(N,1);

for i=1:N
    prefix{i}=strtrim(A(i,:));    
end
for i=1:N
    L(i)=str2num(strtrim(A(i+N,:)));    
end
for i=1:N
    diameter(i)=str2num(strtrim(A(i+2*N,:)));    
end

setappdata(0,'prefix',prefix);

setappdata(0,'length',L);
setappdata(0,'diameter',diameter);

setappdata(0,'q_length',L);
setappdata(0,'q_diameter',diameter);



delete(liftoff_stations);


% --- Executes on selection change in listbox_stations_num.
function listbox_stations_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_stations_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_stations_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_stations_num

Nrows=get(handles.listbox_stations_num,'Value');
Ncolumns=3;

set(handles.uitable_stations,'Data',cell(Nrows,Ncolumns));


% --- Executes during object creation, after setting all properties.
function listbox_stations_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_stations_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_clear.
function pushbutton_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_stations_num,'Value');

for i = 1:n
   for j=1:3
      data_s{i,j} = '';     
   end 
end
set(handles.uitable_stations,'Data',data_s); 
setappdata(0,'data_s',data_s);


setappdata(0,'prefix','');

setappdata(0,'q_length','');
setappdata(0,'q_diameter','');

setappdata(0,'length','');
setappdata(0,'diameter','');
