function varargout = Barrett_method_load(varargin)
% BARRETT_METHOD_LOAD MATLAB code for Barrett_method_load.fig
%      BARRETT_METHOD_LOAD, by itself, creates a new BARRETT_METHOD_LOAD or raises the existing
%      singleton*.
%
%      H = BARRETT_METHOD_LOAD returns the handle to a new BARRETT_METHOD_LOAD or the handle to
%      the existing singleton*.
%
%      BARRETT_METHOD_LOAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BARRETT_METHOD_LOAD.M with the given input arguments.
%
%      BARRETT_METHOD_LOAD('Property','Value',...) creates a new BARRETT_METHOD_LOAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Barrett_method_load_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Barrett_method_load_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Barrett_method_load

% Last Modified by GUIDE v2.5 08-Nov-2019 09:47:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Barrett_method_load_OpeningFcn, ...
                   'gui_OutputFcn',  @Barrett_method_load_OutputFcn, ...
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


% --- Executes just before Barrett_method_load is made visible.
function Barrett_method_load_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Barrett_method_load (see VARARGIN)

% Choose default command line output for Barrett_method_load
handles.output = hObject;


listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Barrett_method_load wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Barrett_method_load_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('****');

all_pathname=char(getappdata(0,'all_pathname'));  
all_filename=char(getappdata(0,'all_filename'));

n=get(handles.listbox_files,'Value');

% pathname=all_pathname(n,:);
filename=all_filename(n,:);


% pathname
% filename

% setappdata(0,'pathname',pathname);
setappdata(0,'filename',filename);
setappdata(0,'Lflag',0);

delete(Barrett_method_load);

% --- Executes on selection change in listbox_files.
function listbox_files_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_files


% --- Executes during object creation, after setting all properties.
function listbox_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return_only.
function pushbutton_return_only_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return_only (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'Lflag',1);

delete(Barrett_method_load);


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

nt=get(handles.listbox_type,'Value');


try
    filename = 'Barrett_method_load_list.txt';
    THM=importdata(filename);
catch
    THM='none';
end

THM
sz=size(THM);
num=sz(1);

out1=sprintf(' sz(1)=%d  sz(2)=%d ',sz(1),sz(2));
disp(out1);

%%


try

   k=1; 
    
%    
    if(nt==1)
        for i=1:num
            aaa=THM{i};
            all_filename{i} = aaa;
        end        
    end
%    
%    
    if(nt==2)
        for i=1:num
            aaa=THM{i};
            if(contains(aaa,'Liftoff') || contains(aaa,'liftoff') || contains(aaa,'ev1') || contains(aaa,'psd1') || contains(aaa,'psd_1'))
                all_filename{k} = aaa; k=k+1;
            end    
        end       
    end
%    
%    
    if(nt==3)
         for i=1:num
            aaa=THM{i};
            if(contains(aaa,'Landing') || contains(aaa,'landing') || contains(aaa,'ev4') || contains(aaa,'psd4') || contains(aaa,'psd_4'))
                all_filename{k} = aaa; k=k+1;
            end    
        end         
    end
% 
    
    set(handles.listbox_files,'String',all_filename);  
    setappdata(0,'all_filename',all_filename);

catch
    warndlg(' ref d failure');
end



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
