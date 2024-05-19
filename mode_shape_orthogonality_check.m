function varargout = mode_shape_orthogonality_check(varargin)
% MODE_SHAPE_ORTHOGONALITY_CHECK MATLAB code for mode_shape_orthogonality_check.fig
%      MODE_SHAPE_ORTHOGONALITY_CHECK, by itself, creates a new MODE_SHAPE_ORTHOGONALITY_CHECK or raises the existing
%      singleton*.
%
%      H = MODE_SHAPE_ORTHOGONALITY_CHECK returns the handle to a new MODE_SHAPE_ORTHOGONALITY_CHECK or the handle to
%      the existing singleton*.
%
%      MODE_SHAPE_ORTHOGONALITY_CHECK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODE_SHAPE_ORTHOGONALITY_CHECK.M with the given input arguments.
%
%      MODE_SHAPE_ORTHOGONALITY_CHECK('Property','Value',...) creates a new MODE_SHAPE_ORTHOGONALITY_CHECK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mode_shape_orthogonality_check_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mode_shape_orthogonality_check_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mode_shape_orthogonality_check

% Last Modified by GUIDE v2.5 26-Sep-2020 19:00:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mode_shape_orthogonality_check_OpeningFcn, ...
                   'gui_OutputFcn',  @mode_shape_orthogonality_check_OutputFcn, ...
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


% --- Executes just before mode_shape_orthogonality_check is made visible.
function mode_shape_orthogonality_check_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mode_shape_orthogonality_check (see VARARGIN)

% Choose default command line output for mode_shape_orthogonality_check
handles.output = hObject;

set(handles.pushbutton_calculate,'Enable','off');

nrows=1;
ncolumns=1;

cn={'Include'};
columnformat={'logical'};
set(handles.uitable_data,'ColumnName',cn,'ColumnFormat',columnformat,'Data',cell(nrows,ncolumns));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mode_shape_orthogonality_check wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mode_shape_orthogonality_check_OutputFcn(hObject, eventdata, handles) 
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

delete(mode_shape_orthogonality_check);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * *');
disp(' ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz_mass=getappdata(0,'sz_mass');
MMS=getappdata(0,'MMS');
AMS=getappdata(0,'AMS');
mass=getappdata(0,'mass');

sz_MMS=size(MMS);
NC=sz_MMS(2);

AC=get(handles.uitable_data,'Data');

try
    for i=1:NC
        channel{i}=AC{i,1};
    end      
catch
end

kflag=0;
for i=NC:-1:1
    if(channel{i}==1 )
        kflag=1;
    else    
        MMS(:,i)=[];
    end
end

if(kflag==0)
    warndlg('At least one mode shape must be included');
    return;
end


sz_measured=size(MMS);

if(sz_mass(1)~=sz_measured(1) || sz_mass(2)~=sz_measured(2))
   
    sz_mass
    sz_measured
    
    warndlg(' Mass matrix & analytical mode shape matrix must be the same size ');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dof=sz_mass(1);

scale=zeros(dof,1);

QTMQ=MMS'*mass*MMS;

for i=1:dof 
    scale(i)=1./sqrt(QTMQ(i,i));
    sss=sum(MMS(:,i)); 
    if(real(sss)<0)
        scale=-scale;
    end
    MMS(:,i) = MMS(:,i)*scale(i);    
end
%

disp(' ');
disp(' Mass-normalized Measured Mode Shapes');
MMS


disp(' ');
disp(' Transformed Mass Matrix (should be identity matrix)');

q=AMS'*mass*MMS

Z=abs(q);

figure(1)
b = bar3(Z);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
xlabel('Rows');
ylabel('Columns');
title('Mode Shape Orthogonality Check');
axis equal
zlim([0 2]);










function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_analytical_ms_Callback(hObject, eventdata, handles)
% hObject    handle to edit_analytical_ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_analytical_ms as text
%        str2double(get(hObject,'String')) returns contents of edit_analytical_ms as a double


% --- Executes during object creation, after setting all properties.
function edit_analytical_ms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_analytical_ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_measured_ms_Callback(hObject, eventdata, handles)
% hObject    handle to edit_measured_ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_measured_ms as text
%        str2double(get(hObject,'String')) returns contents of edit_measured_ms as a double


% --- Executes during object creation, after setting all properties.
function edit_measured_ms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_measured_ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=strtrim(get(handles.edit_mass,'String'));
    mass=evalin('base',FS);      
catch
    warndlg(' Mass Matrix not found');
    return;
end

sz_mass=size(mass);

try
    FS=strtrim(get(handles.edit_analytical_ms,'String'));
    AMS=evalin('base',FS);  
catch
    warndlg(' Analytical mode shapes matrix not found');
    return;
end

sz_analytical=size(AMS);

if(sz_mass(1)~=sz_analytical(1) || sz_mass(2)~=sz_analytical(2))
    warndlg(' Mass matrix & analytical mode shape matrix must be the same size ');
    return;
end


try
    FS=strtrim(get(handles.edit_measured_ms,'String'));
    MMS=evalin('base',FS);  
catch
    warndlg(' Measured mode shapes matrix not found');
    return;
end

setappdata(0,'sz_mass',sz_mass);
setappdata(0,'MMS',MMS);
setappdata(0,'AMS',AMS);
setappdata(0,'mass',mass);

sz_MMS=size(MMS);

nrows=sz_MMS(2);
ncolumns=1;

cn={'Include'};
columnformat={'logical'};
set(handles.uitable_data,'ColumnName',cn,'ColumnFormat',columnformat,'Data',cell(nrows,ncolumns));

set(handles.pushbutton_calculate,'Enable','on');
