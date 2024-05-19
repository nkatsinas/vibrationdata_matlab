function varargout = SEA_four_geometry(varargin)
% SEA_FOUR_GEOMETRY MATLAB code for SEA_four_geometry.fig
%      SEA_FOUR_GEOMETRY, by itself, creates a new SEA_FOUR_GEOMETRY or raises the existing
%      singleton*.
%
%      H = SEA_FOUR_GEOMETRY returns the handle to a new SEA_FOUR_GEOMETRY or the handle to
%      the existing singleton*.
%
%      SEA_FOUR_GEOMETRY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_FOUR_GEOMETRY.M with the given input arguments.
%
%      SEA_FOUR_GEOMETRY('Property','Value',...) creates a new SEA_FOUR_GEOMETRY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_four_geometry_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_four_geometry_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_four_geometry

% Last Modified by GUIDE v2.5 02-Dec-2017 09:57:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_four_geometry_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_four_geometry_OutputFcn, ...
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


% --- Executes just before SEA_four_geometry is made visible.
function SEA_four_geometry_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_four_geometry (see VARARGIN)

% Choose default command line output for SEA_four_geometry
handles.output = hObject;

try
    iu=getappdata(0,'iu');
    if(isempty(iu))
    else
        if(iu==1)
            set(handles.text_unit,'String','Unit: inch');
        else
            set(handles.text_unit,'String','Unit: meter');            
        end
    end
catch
end



data_s{1,1} = 'Length 1';  
data_s{2,1} = 'Length 2'; 
data_s{3,1} = 'Length 3'; 
data_s{4,1} = 'Length 4'; 
data_s{5,1} = 'Diameter 1'; 
data_s{6,1} = 'Diameter 2'; 
data_s{7,1} = 'Diameter 3'; 
data_s{8,1} = 'Diameter 4'; 

data_s{1,2} = ' ';  
data_s{2,2} = ' '; 
data_s{3,2} = ' '; 
data_s{4,2} = ' '; 
data_s{5,2} = ' '; 
data_s{6,2} = ' '; 
data_s{7,2} = ' '; 
data_s{8,2} = ' '; 

try
    L1=getappdata(0,'L1_orig');
    if(isempty(L1))
    else
        ss=sprintf('%8.4g',L1);
        data_s{1,2} = ss;
    end
catch
end

try
    L2=getappdata(0,'L2_orig');
    if(isempty(L2))
    else
        ss=sprintf('%8.4g',L2);
        data_s{2,2} = ss;
    end
catch
end

try
    L3=getappdata(0,'L3_orig');
    if(isempty(L3))
    else
        ss=sprintf('%8.4g',L3);
        data_s{3,2} = ss;
    end
catch
end

try
    L4=getappdata(0,'L4_orig');
    if(isempty(L4))
    else
        ss=sprintf('%8.4g',L4);
        data_s{4,2} = ss;
    end
catch
end

%

try
    diam1=getappdata(0,'diam1_orig');
    if(isempty(diam1))
    else
        ss=sprintf('%8.4g',diam1);
        data_s{5,2} = ss;
    end
catch
end


try
    diam2=getappdata(0,'diam2_orig');
    if(isempty(diam2))
    else
        ss=sprintf('%8.4g',diam2);
        data_s{6,2} = ss;
    end
catch
end


try
    diam3=getappdata(0,'diam3_orig');
    if(isempty(diam3))
    else
        ss=sprintf('%8.4g',diam3);
        data_s{7,2} = ss;
    end
catch
end



try
    diam4=getappdata(0,'diam4_orig');
    if(isempty(diam4))
    else
        ss=sprintf('%8.4g',diam4);
        data_s{8,2} = ss;
    end
catch
end

%%%

try
    nj12=getappdata(0,'nj12');
    if(isempty(nj12))
    else
       set(handles.listbox_j12,'Value',nj12);
    end
catch
end

try
    nj23=getappdata(0,'nj23');
    if(isempty(nj23))
    else
       set(handles.listbox_j23,'Value',nj23);
    end
catch
end

try
    nj34=getappdata(0,'nj34');
    if(isempty(nj34))
    else
       set(handles.listbox_j34,'Value',nj34);
    end
catch
end




%%%

set(handles.uitable_variables,'Data',data_s);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_four_geometry wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_four_geometry_OutputFcn(hObject, eventdata, handles) 
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

meters_per_inch=0.0254;

iu=getappdata(0,'iu');

A=get(handles.uitable_variables,'Data');

% A= A(find(~isspace(A)));

% whos A

L1=str2num(char(A{1,2}));
L2=str2num(char(A{2,2}));
L3=str2num(char(A{3,2}));
L4=str2num(char(A{4,2}));

diam1=str2num(char(A{5,2}));
diam2=str2num(char(A{6,2}));
diam3=str2num(char(A{7,2}));
diam4=str2num(char(A{8,2}));


setappdata(0,'L1_orig',L1);
setappdata(0,'L2_orig',L2);
setappdata(0,'L3_orig',L3);
setappdata(0,'L4_orig',L4);

setappdata(0,'diam1_orig',diam1);
setappdata(0,'diam2_orig',diam2);
setappdata(0,'diam3_orig',diam3);
setappdata(0,'diam4_orig',diam4);



if(iu==1)  % convert English to metric
    
   diam1=diam1*meters_per_inch;
   diam2=diam2*meters_per_inch;
   diam3=diam3*meters_per_inch;
   diam4=diam4*meters_per_inch;   
   
   L1=L1*meters_per_inch;
   L2=L2*meters_per_inch;
   L3=L3*meters_per_inch;
   L4=L4*meters_per_inch;


   
else
end



setappdata(0,'L1',L1);
setappdata(0,'L2',L2);
setappdata(0,'L3',L3);
setappdata(0,'L4',L4);

setappdata(0,'L',[L1 L2 L3 L4]);

setappdata(0,'diam1',diam1);
setappdata(0,'diam2',diam2);
setappdata(0,'diam3',diam3);
setappdata(0,'diam4',diam4);

setappdata(0,'diam',[diam1 diam2 diam3 diam4]);


nj12=get(handles.listbox_j12,'Value');
nj23=get(handles.listbox_j23,'Value');
nj34=get(handles.listbox_j34,'Value');

setappdata(0,'nj12',nj12);
setappdata(0,'nj23',nj23);
setappdata(0,'nj34',nj34);

delete(SEA_four_geometry);


% --- Executes on selection change in listbox_j12.
function listbox_j12_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_j12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_j12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_j12


% --- Executes during object creation, after setting all properties.
function listbox_j12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_j12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_j23.
function listbox_j23_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_j23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_j23 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_j23


% --- Executes during object creation, after setting all properties.
function listbox_j23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_j23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_j34.
function listbox_j34_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_j34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_j34 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_j34


% --- Executes during object creation, after setting all properties.
function listbox_j34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_j34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
