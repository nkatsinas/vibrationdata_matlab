function varargout = beam_peak_bending_stress(varargin)
% BEAM_PEAK_BENDING_STRESS MATLAB code for beam_peak_bending_stress.fig
%      BEAM_PEAK_BENDING_STRESS, by itself, creates a new BEAM_PEAK_BENDING_STRESS or raises the existing
%      singleton*.
%
%      H = BEAM_PEAK_BENDING_STRESS returns the handle to a new BEAM_PEAK_BENDING_STRESS or the handle to
%      the existing singleton*.
%
%      BEAM_PEAK_BENDING_STRESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_PEAK_BENDING_STRESS.M with the given input arguments.
%
%      BEAM_PEAK_BENDING_STRESS('Property','Value',...) creates a new BEAM_PEAK_BENDING_STRESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_peak_bending_stress_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_peak_bending_stress_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_peak_bending_stress

% Last Modified by GUIDE v2.5 13-Jan-2020 16:13:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_peak_bending_stress_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_peak_bending_stress_OutputFcn, ...
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


% --- Executes just before beam_peak_bending_stress is made visible.
function beam_peak_bending_stress_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_peak_bending_stress (see VARARGIN)

% Choose default command line output for beam_peak_bending_stress
handles.output = hObject;

listbox_units_Callback(hObject, eventdata, handles);

listbox_cs_Callback(hObject, eventdata, handles);

%%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_peak_bending_stress wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_peak_bending_stress_OutputFcn(hObject, eventdata, handles) 
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

disp(' ');
disp(' * * * * * ');
disp(' ');

data=get(handles.uitable_data,'Data');
AA=char(data);

M=str2num(get(handles.edit_bm,'String'));
  
n=get(handles.listbox_cs,'Value');

if(n==1)  % solid rectangular
    width=str2double(AA(1,:));
    thick=str2double(AA(2,:));
    [area,MOIy,MOIz,J,cna]=beam_rectangular_geometry_alt(width,thick);
end
if(n==2)  % hollow rectangular
    width=str2double(AA(1,:));
    height=str2double(AA(2,:));
    thick=str2double(AA(3,:));
    [area,MOIy,MOIz,J,cna]=beam_rectangular_hollow_geometry_alt(width,height,thick);
end
if(n==3)  % pipe
    diameter=str2double(AA(1,:));
    wall_thick=str2double(AA(2,:));
    [area,MOIz,J,cna]=pipe_geometry_wall_alt(diameter,wall_thick);             
end
if(n==4)  % solid cylinder
    diameter=str2double(AA(1,:));
    [area,MOIz,J,cna]=cylinder_geometry_alt(diameter);      
end
if(n==5)  % I-beam, equal
    B=str2double(AA(1,:));
    H=str2double(AA(2,:));
    Tf=str2double(AA(3,:));
    Tw=str2double(AA(4,:));   
    [area,MOIz,MOIy,J,cna]=Ibeam_geometry_alt(B,H,Tf,Tw);
end

ps=M*cna/MOIz;


iu=get(handles.listbox_units,'Value');

if(iu==1)
    u1='in';
    u2='in^2';
    u3='in^4';
    u4='psi';
end
if(iu==2)
    u1='mm';
    u2='mm^2';
    u3='mm^4';
    u4='Pa';
    ps=ps*1000^2;
end

out1=sprintf('   Yc=  %8.4g %s (distance to centroid)',cna,u1);
out2=sprintf(' area=  %8.4g %s',area,u2);
out3=sprintf('  Izz=  %8.4g %s',MOIz,u3);    

disp(out1);
disp(out2);
disp(out3);

SQ=sprintf(' Yc=  %8.4g %s \n\n area=  %8.4g %s \n\n MOIz=  %8.4g %s \n\n peak stress= %8.4g %s',cna,u1,area,u2,MOIz,u3,ps,u4);


set(handles.edit_results,'String',SQ);

set(handles.uipanel_results,'Visible','on');

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(beam_peak_bending_stress);


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

n=get(handles.listbox_units,'Value');

if(n==1)
    ss='Dimesions (inches)';
    tt='Bending Moment (in-lbf)';
else
    ss='Dimesions (mm)';    
    tt='Bending Moment (N-mm)';    
end

set(handles.text_unit,'String',ss);
set(handles.uipanel_results,'Visible','off');


% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_cs.
function listbox_cs_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cs


n=get(handles.listbox_cs,'Value');

clc;

if(n==1)
    cn={'Base B','Height H'};
    fstr='rectangular_cs_ms.jpg';    
end
if(n==2)
    cn={'Base B','Height H','Wall Thickness T'};
    fstr='rectangular_hollow_cs_ms.jpg';    
end
if(n==3)
    cn={'Outer Diameter','Wall Thickness'};
    fstr='pipe_cs_ms.jpg';     
end
if(n==4)   
    cn={'Diameter'};
    fstr='solid_cylinder_cs_ms.jpg';     
end
if(n==5)
    cn={'Width B','Height H','Flange Thickness Tf','Web Thickness Tw'};
    fstr='Ibeam1_cs_ms.jpg';
end



Ncolumns=length(cn);

%%%

    bg = imread(fstr);
    info = imfinfo(fstr);
    w = info.Width;  %An integer indicating the width of the image in pixels
    h = info.Height; %An integer indicating the height of the image in pixels
 
    axes(handles.axes1);
    image(bg);
 
    pos1 = getpixelposition(handles.axes1,true);
 
    set(handles.axes1, ...
        'Visible', 'off', ...
        'Units', 'pixels', ...
        'Position', [pos1(1) pos1(2) w h]);
    axis off;

%%%

Nrows=1;

set(handles.uitable_data,'Data',cell(Nrows,Ncolumns),'ColumnName',cn);

set(handles.uipanel_results,'Visible','off');



% --- Executes during object creation, after setting all properties.
function listbox_cs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');



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



function edit_bm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bm as text
%        str2double(get(hObject,'String')) returns contents of edit_bm as a double


% --- Executes during object creation, after setting all properties.
function edit_bm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
