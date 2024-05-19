function varargout = spacecraft_clamp_band(varargin)
% SPACECRAFT_CLAMP_BAND MATLAB code for spacecraft_clamp_band.fig
%      SPACECRAFT_CLAMP_BAND, by itself, creates a new SPACECRAFT_CLAMP_BAND or raises the existing
%      singleton*.
%
%      H = SPACECRAFT_CLAMP_BAND returns the handle to a new SPACECRAFT_CLAMP_BAND or the handle to
%      the existing singleton*.
%
%      SPACECRAFT_CLAMP_BAND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPACECRAFT_CLAMP_BAND.M with the given input arguments.
%
%      SPACECRAFT_CLAMP_BAND('Property','Value',...) creates a new SPACECRAFT_CLAMP_BAND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spacecraft_clamp_band_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spacecraft_clamp_band_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spacecraft_clamp_band

% Last Modified by GUIDE v2.5 28-Aug-2017 17:11:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spacecraft_clamp_band_OpeningFcn, ...
                   'gui_OutputFcn',  @spacecraft_clamp_band_OutputFcn, ...
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


% --- Executes just before spacecraft_clamp_band is made visible.
function spacecraft_clamp_band_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spacecraft_clamp_band (see VARARGIN)

% Choose default command line output for spacecraft_clamp_band
handles.output = hObject;



fstr='clamp_band_1.jpg';
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

listbox_units_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes spacecraft_clamp_band wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spacecraft_clamp_band_OutputFcn(hObject, eventdata, handles) 
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

delete(spacecraft_clamp_band);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * ');
disp('  ');

disp(' Compressive forces and fluxes are expressed here ');
disp(' using a positive sign in accordance with the convection ');
disp(' per the Rockot User Guide ');
disp('  ');

iu=get(handles.listbox_units,'Value');

D=str2num(get(handles.edit_diameter,'String'));

alpha=str2num(get(handles.edit_alpha,'String'));

mu=str2num(get(handles.edit_mu,'String'));

N=str2num(get(handles.edit_axial,'String'));
M=str2num(get(handles.edit_moment,'String'));

overflux=str2num(get(handles.edit_overflux,'String'));
KD=str2num(get(handles.edit_design,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    afu='lbf/in';
    efu='lbf';
    lu='in';
    mou='in-lbf';
else
    afu='N/m';
    efu='N';
    lu='m';
    mou='N-m';
end

out1=sprintf('        N = %g %s',N,efu);
out2=sprintf('        M = %g %s',M,mou);
out3=sprintf('        D = %g %s',D,lu);
out4=sprintf('    alpha = %g deg',alpha);
out5=sprintf('       mu = %g',mu);
out6=sprintf(' overflux = %g',overflux);
out7=sprintf('       KD = %g',KD);


disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);
disp(out7);


%%%%%%%%%%%%%%%%%%%%%%%%

alpha=alpha*pi/180;

aa=N/(pi*D);
bb=4*M/(pi*D^2);

f12(1)=aa+bb;
f12(2)=aa-bb;


cc=N;
dd=4*M/D;

A12(1)=cc+dd;
A12(2)=cc-dd;

%%%

f12_DLL=f12*overflux*KD;  
A12_DLL=A12*overflux*KD;


f12_DLL= sort(f12_DLL,'descend');
A12_DLL= sort(A12_DLL,'descend');

%%%

disp(' ');
disp(' Design Limit Load values, max & min');
disp('   ');

out1=sprintf(' I/F Axial Flux (%s): \n  %8.4g   %8.4g  \n',afu,f12_DLL(1),f12_DLL(2));
disp(out1);
out1=sprintf(' Equivalent Axial Force (%s): \n   %8.4g   %8.4g  \n',efu,A12_DLL(1),A12_DLL(2));
disp(out1);

%%%

num=tan(alpha)-mu;
den=1+mu*tan(alpha);

f_radial_max=2*(abs(f12_DLL(2)))*num/den;

out1=sprintf(' Maximum Radial Flux = %8.4g %s \n',f_radial_max,afu); 
disp(out1);

%%%

Tmin=f_radial_max*D/2;

out1=sprintf(' Minimum clamp band tension:  Tmin=%8.4g %s \n',Tmin,efu);
disp(out1);

%%%

msgbox('Results written to Command Window');


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

n=get(handles.listbox_units,'Value');

if(n==1)
    s1='Diameter (in)';
    s2='Axial Force (lbf)';
    s3='Moment (in-lbf)';
else
    s1='Diameter (m)';
    s2='Axial Force (N)';
    s3='Moment (N-m)';    
end

set(handles.text_diameter,'String',s1);
set(handles.text_axial,'String',s2);
set(handles.text_moment,'String',s3);




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



function edit_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alpha as text
%        str2double(get(hObject,'String')) returns contents of edit_alpha as a double


% --- Executes during object creation, after setting all properties.
function edit_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mu as text
%        str2double(get(hObject,'String')) returns contents of edit_mu as a double


% --- Executes during object creation, after setting all properties.
function edit_mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_moment_Callback(hObject, eventdata, handles)
% hObject    handle to edit_moment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_moment as text
%        str2double(get(hObject,'String')) returns contents of edit_moment as a double


% --- Executes during object creation, after setting all properties.
function edit_moment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_moment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_axial_Callback(hObject, eventdata, handles)
% hObject    handle to edit_axial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_axial as text
%        str2double(get(hObject,'String')) returns contents of edit_axial as a double


% --- Executes during object creation, after setting all properties.
function edit_axial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_axial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_overflux_Callback(hObject, eventdata, handles)
% hObject    handle to edit_overflux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_overflux as text
%        str2double(get(hObject,'String')) returns contents of edit_overflux as a double


% --- Executes during object creation, after setting all properties.
function edit_overflux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_overflux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_design_Callback(hObject, eventdata, handles)
% hObject    handle to edit_design (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_design as text
%        str2double(get(hObject,'String')) returns contents of edit_design as a double


% --- Executes during object creation, after setting all properties.
function edit_design_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_design (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
