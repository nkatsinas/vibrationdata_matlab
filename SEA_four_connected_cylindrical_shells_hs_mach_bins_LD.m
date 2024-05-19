function varargout = SEA_four_connected_cylindrical_shells_hs_mach_bins_LD(varargin)
% SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS_MACH_BINS_LD MATLAB code for SEA_four_connected_cylindrical_shells_hs_mach_bins_LD.fig
%      SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS_MACH_BINS_LD, by itself, creates a new SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS_MACH_BINS_LD or raises the existing
%      singleton*.
%
%      H = SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS_MACH_BINS_LD returns the handle to a new SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS_MACH_BINS_LD or the handle to
%      the existing singleton*.
%
%      SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS_MACH_BINS_LD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS_MACH_BINS_LD.M with the given input arguments.
%
%      SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS_MACH_BINS_LD('Property','Value',...) creates a new SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS_MACH_BINS_LD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_four_connected_cylindrical_shells_hs_mach_bins_LD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_four_connected_cylindrical_shells_hs_mach_bins_LD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_four_connected_cylindrical_shells_hs_mach_bins_LD

% Last Modified by GUIDE v2.5 17-Sep-2018 14:50:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_four_connected_cylindrical_shells_hs_mach_bins_LD_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_four_connected_cylindrical_shells_hs_mach_bins_LD_OutputFcn, ...
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


% --- Executes just before SEA_four_connected_cylindrical_shells_hs_mach_bins_LD is made visible.
function SEA_four_connected_cylindrical_shells_hs_mach_bins_LD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_four_connected_cylindrical_shells_hs_mach_bins_LD (see VARARGIN)

% Choose default command line output for SEA_four_connected_cylindrical_shells_hs_mach_bins_LD
handles.output = hObject;

clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cn={'Name','FPL'};

data{1,1}='subsystem 1';
data{2,1}='subsystem 2';
data{3,1}='subsystem 3';
data{4,1}='subsystem 4';

data{1,2}=' ';
data{2,2}=' ';
data{3,2}=' ';
data{4,2}=' ';

set(handles.uitable_names,'Data',data,'ColumnName',cn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fstr='four_1_f.jpg';
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

change(hObject, eventdata, handles);

set(handles.pushbutton_geometry,'Enable','on');
set(handles.pushbutton_sandwich,'Enable','on');
set(handles.pushbutton_calculate,'Enable','on');

%  set(handles.listbox_acoustic_field,'Value',1);


try
    a_1=getappdata(0,'a_1');
    if(isempty(a_1))
    else    
        ss=sprintf('%9.5g',a1);
        set(handles.edit_a1,'String',ss);
    end
catch
end

try
    a_2=getappdata(0,'a_2');
    if(isempty(a_2))
    else    
        ss=sprintf('%9.5g',a2);
        set(handles.edit_a2,'String',ss);
    end
catch
end

change(hObject, eventdata, handles);

set(handles.uipanel_mach_number,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_four_connected_cylindrical_shells_hs_mach_bins_LD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function edit_gas_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gas_md as text
%        str2double(get(hObject,'String')) returns contents of edit_gas_md as a double


% --- Executes during object creation, after setting all properties.
function edit_gas_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fstart_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fstart as text
%        str2double(get(hObject,'String')) returns contents of edit_fstart as a double


% --- Executes during object creation, after setting all properties.
function edit_fstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_gas.
function listbox_gas_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_gas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_gas
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_gas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_acoustic_field.
function listbox_acoustic_field_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acoustic_field contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acoustic_field

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_acoustic_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mach_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mach as text
%        str2double(get(hObject,'String')) returns contents of edit_mach as a double


% --- Executes during object creation, after setting all properties.
function edit_mach_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_altitude_Callback(hObject, eventdata, handles)
% hObject    handle to edit_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_altitude as text
%        str2double(get(hObject,'String')) returns contents of edit_altitude as a double


% --- Executes during object creation, after setting all properties.
function edit_altitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function reverse_speed(hObject, eventdata, handles)
%

ft_per_km=getappdata(0,'ft_per_km');
 altitude=getappdata(0,'altitude');

alt_num=length(altitude);

c=zeros(alt_num,1);


for ikk=1:alt_num
   
    h=altitude(ikk);

    LH1=11*ft_per_km;
    LH2=20*ft_per_km;
    
    if( h < LH1)  % troposphere
	
        Tz=288.;
		L=6.5;
        gamma=1.402;
        ROM = (8314.3/28.97);

        if( h < 0.)
			h=0;
        end

		c(ikk)=sqrt(abs(gamma*ROM*(Tz-L*(h/(ft_per_km)))))*3.28;

        if( h >= LH1 && h <= LH2 )  % lower stratosphere
		
			c(ikk) = 295.*3.28;
            
        end
        if( h > LH2 )
            warndlg('Altitude too high for speed of sound calculation');
            return;
        end
 
    end
end

setappdata(0,'speed_of_sound',c);

function density(hObject, eventdata, handles)
%
ft_per_km=getappdata(0,'ft_per_km');

h=getappdata(0,'altitude');

if(isempty(h))
    warndlg('Enter altitude');
    return;
end    



alt=zeros(21,1);

for i=1:21
    alt(i)=(i-1)*ft_per_km;
end

dens(1)=1.226;
dens(2)=1.112;
dens(3)=1.007;
dens(4)=0.9096;
dens(5)=0.8195;
dens(6)=0.7365;
dens(7)=0.6600;
dens(8)=0.5898;
dens(9)=0.5254;
dens(10)=0.4666;
dens(11)=0.4129;
dens(12)=0.3641;
dens(13)=0.3104;
dens(14)=0.2652;
dens(15)=0.2266;
dens(16)=0.1936;
dens(17)=0.1654;
dens(18)=0.1413;
dens(19)=0.1207;
dens(20)=0.1032;
dens(21)=0.0881;

rho=0.;

for i=1:20
    
    if( h >= alt(i) && h < alt(i+1) )
		
        len = alt(i+1)-alt(i);
        c2  = (h-alt(i))/len;
        c1  = 1. -c2;

		rho = c1*dens(i) + c2*dens(i+1);

		break;
    end	

end
	
setappdata(0,'gas_md',rho);



function edit_a2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a2 as text
%        str2double(get(hObject,'String')) returns contents of edit_a2 as a double


% --- Executes during object creation, after setting all properties.
function edit_a2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a1 as text
%        str2double(get(hObject,'String')) returns contents of edit_a1 as a double


% --- Executes during object creation, after setting all properties.
function edit_a1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_load_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Outputs from this function are returned to the command line.
function varargout = SEA_four_connected_cylindrical_shells_hs_mach_bins_LD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c as text
%        str2double(get(hObject,'String')) returns contents of edit_c as a double


% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(SEA_four_connected_cylindrical_shells_hs_mach_bins);


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_view,'Value');

if(n==1)
    A = imread('power_balance_4s.jpg');
end
if(n==2)
    A = imread('clf_line_joint_plates.jpg');    
end
if(n==3)
    A = imread('transmission_coefficient_sandwich.jpg');    
end
if(n==4)
    A = imread('equivalent_acoustic_power_cylinder.jpg');
end
if(n==5)
    A = imread('equivalent_acoustic_power_cylinder_TBL.jpg');
end
if(n==6)
    A = imread('re_sandwich_cylinder.jpg');
end
if(n==7)
    A = imread('modal_density_sandwich_cylinder.jpg');  
end
if(n==8)
    A = imread('wavespeed_sandwich.jpg'); 
end


figure(999)
imshow(A,'border','tight','InitialMagnification',100) 



% --- Executes on selection change in listbox_view.
function listbox_view_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_view contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_view


% --- Executes during object creation, after setting all properties.
function listbox_view_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change(hObject, eventdata, handles);

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


% --- Executes on button press in pushbutton_geometry.
function pushbutton_geometry_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');
setappdata(0,'iu',iu);

handles.s=SEA_four_geometry;
set(handles.s,'Visible','on');

set(handles.pushbutton_sandwich,'Enable','on');


% --- Executes on button press in pushbutton_sandwich.
function pushbutton_sandwich_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sandwich (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');
setappdata(0,'iu',iu);

handles.s=SEA_honeycomb_sandwich_four;
set(handles.s,'Visible','on');

set(handles.pushbutton_calculate,'Enable','on');


% --- Executes on button press in pushbutton_LF.
function pushbutton_LF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_LF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% n=get(handles.listbox_acoustic_field,'Value');

%% if(n==1)
%%     handles.s=SEA_four_honeycomb_cylindrical_shells_FPL;
%% else
%%     handles.s=SEA_four_honeycomb_cylindrical_shells_FPL;  
%% end
    

handles.s=SEA_four_honeycomb_cylindrical_shells_lf;

set(handles.s,'Visible','on');
  
set(handles.pushbutton_geometry,'Enable','on');

% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ref 1');
 
[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
disp(' ref 2');
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
disp(' ref 3');
 
structnames
 
 
% struct
 
try
    SEA_four_shells_hs=evalin('base','SEA_four_shells_hs');
catch
   warndlg(' evalin failed ');
   return;
end
 
SEA_four_shells_hs
 
disp(' ref 4');
 
 
%%%
 
 
try
    fstart=SEA_four_shells_hs.fstart;    
    setappdata(0,'fstart_orig',fstart); 
    ss=sprintf('%8.4g',fstart);
    set(handles.edit_fstart,'String',ss);    
catch
end
 
try
    iu=SEA_four_shells_hs.iu;    
    setappdata(0,'iu',iu);
    set(handles.listbox_units,'Value',iu);
catch
end
 
try
    ng=SEA_four_shells_hs.ng;    
    setappdata(0,'ng',ng);
    set(handles.listbox_gas,'Value',ng);
catch
end
 
 
try
    nj12=SEA_four_shells_hs.nj12;    
    setappdata(0,'nj12',nj12);
    set(handles.listbox_j12,'Value',nj12);
catch
end

try
    nj23=SEA_four_shells_hs.nj23;    
    setappdata(0,'nj23',nj23);
    set(handles.listbox_j23,'Value',nj23);
catch
end

try
    nj34=SEA_four_shells_hs.nj34;    
    setappdata(0,'nj34',nj34);
    set(handles.listbox_j34,'Value',nj34);
catch
end
 

try
    L1=SEA_four_shells_hs.L1;    
    setappdata(0,'L1',L1); 
catch
end
 
try
    L2=SEA_four_shells_hs.L2;    
    setappdata(0,'L2',L2);
catch
end

try
    L3=SEA_four_shells_hs.L3;    
    setappdata(0,'L3',L3); 
catch
end
 
try
    L4=SEA_four_shells_hs.L4;    
    setappdata(0,'L4',L4);
catch
end
 

try
    L1_orig=SEA_four_shells_hs.L1_orig;    
    setappdata(0,'L1_orig',L1_orig); 
catch
end
 
try
    L2_orig=SEA_four_shells_hs.L2_orig;    
    setappdata(0,'L2_orig',L2_orig);
catch
end

try
    L3_orig=SEA_four_shells_hs.L3_orig;    
    setappdata(0,'L3_orig',L3_orig); 
catch
end
 
try
    L4_orig=SEA_four_shells_hs.L4_orig;    
    setappdata(0,'L4_orig',L4_orig);
catch
end




try
    diam1=SEA_four_shells_hs.diam1;    
    setappdata(0,'diam1',diam1);    
catch
end
 
try
    diam2=SEA_four_shells_hs.diam2;    
    setappdata(0,'diam2',diam2);    
catch
end
 
 
try
    diam3=SEA_four_shells_hs.diam3;    
    setappdata(0,'diam3',diam3);    
catch
end
 
try
    diam4=SEA_four_shells_hs.diam4;    
    setappdata(0,'diam4',diam4);    
catch
end
 


try
    diam1_orig=SEA_four_shells_hs.diam1_orig;    
    setappdata(0,'diam1_orig',diam1_orig);    
catch
end
 
try
    diam2_orig=SEA_four_shells_hs.diam2_orig;    
    setappdata(0,'diam2_orig',diam2_orig);    
catch
end
 
 
try
    diam3_orig=SEA_four_shells_hs.diam3_orig;    
    setappdata(0,'diam3_orig',diam3_orig);    
catch
end
 
try
    diam4_orig=SEA_four_shells_hs.diam4_orig;    
    setappdata(0,'diam4_orig',diam4_orig);    
catch
end


%%%%%%%%%%%


try
    listbox_array_type=SEA_four_shells_hs.listbox_array_type;    
    setappdata(0,'listbox_array_type',listbox_array_type);        
catch
end


%%%


 
try
    a_1=SEA_four_shells_hs.a_1;
    ss=sprintf('%9.5g',a_1);
    set(handles.edit_a1,'String',ss);
catch
end
 
try
    a_2=SEA_four_shells_hs.a_2;
    ss=sprintf('%9.5g',a_2);
    set(handles.edit_a2,'String',ss);
catch
end

%%%

try
    imat_orig=SEA_four_shells_hs.imat_orig;    
    setappdata(0,'imat_orig',imat_orig);    
catch
end

try
    tf_orig=SEA_four_shells_hs.tf_orig;    
    setappdata(0,'tf_orig',tf_orig);    
catch
end

try
    E_orig=SEA_four_shells_hs.E_orig;    
    setappdata(0,'E_orig',E_orig);    
catch
end

try
    rhof_orig=SEA_four_shells_hs.rhof_orig;    
    setappdata(0,'rhof_orig',rhof_orig);    
catch
end

try
    G_orig=SEA_four_shells_hs.G_orig;    
    setappdata(0,'G_orig',G_orig);    
catch
end

try
    rhoc_orig=SEA_four_shells_hs.rhoc_orig;    
    setappdata(0,'rhoc_orig',rhoc_orig);    
catch
end

try
    hc_orig=SEA_four_shells_hs.hc_orig;    
    setappdata(0,'hc_orig',hc_orig);    
catch
end


try
    mu_orig=SEA_four_shells_hs.mu_orig;    
    setappdata(0,'mu_orig',mu_orig);    
catch
end

try
    tf=SEA_four_shells_hs.tf;    
    setappdata(0,'tf',tf);    
catch
end
 
try
    E=SEA_four_shells_hs.E;    
    setappdata(0,'E',E);    
catch
end
 
try
    rhof=SEA_four_shells_hs.rhof;    
    setappdata(0,'rhof',rhof);    
catch
end
 
try
    G=SEA_four_shells_hs.G;    
    setappdata(0,'G',G);    
catch
end
 
try
    rhoc=SEA_four_shells_hs.rhoc;    
    setappdata(0,'rhoc',rhoc);    
catch
end
 
try
    hc=SEA_four_shells_hs.hc;    
    setappdata(0,'hc',hc);    
catch
end
 
 
try
    mu=SEA_four_shells_hs.mu;    
    setappdata(0,'mu',mu);    
catch
end


%%%

try
    listbox_lf1=SEA_four_shells_hs.listbox_lf1;    
    setappdata(0,'listbox_lf1',listbox_lf1);    
catch
end
try
    listbox_lf2=SEA_four_shells_hs.listbox_lf2;    
    setappdata(0,'listbox_lf2',listbox_lf2);    
catch
end
try
    listbox_lf3=SEA_four_shells_hs.listbox_lf3;    
    setappdata(0,'listbox_lf3',listbox_lf3);    
catch
end
try
    listbox_lf4=SEA_four_shells_hs.listbox_lf4;    
    setappdata(0,'listbox_lf4',listbox_lf4);    
catch
end

%%%

try
    constant_lf1=SEA_four_shells_hs.constant_lf1;    
    setappdata(0,'constant_lf1',constant_lf1);
catch
end
try
    constant_lf2=SEA_four_shells_hs.constant_lf2;    
    setappdata(0,'constant_lf2',constant_lf2);
catch
end
try
    constant_lf3=SEA_four_shells_hs.constant_lf3;    
    setappdata(0,'constant_lf3',constant_lf3);
catch
end
try
    constant_lf4=SEA_four_shells_hs.constant_lf4;    
    setappdata(0,'constant_lf4',constant_lf4);
catch
end

%%%

try
    
    sname_1=strtrim(SEA_four_shells_hs.sname_1);    
    sname_2=strtrim(SEA_four_shells_hs.sname_2); 
    sname_3=strtrim(SEA_four_shells_hs.sname_3); 
    sname_4=strtrim(SEA_four_shells_hs.sname_4);     
   
    data{1,1}=sname_1;
    data{2,1}=sname_2;
    data{3,1}=sname_3;
    data{4,1}=sname_4;
    
catch
end

try
    
    FPL_name_1=strtrim(SEA_four_shells_hs.FPL_name_1);    
    FPL_name_2=strtrim(SEA_four_shells_hs.FPL_name_2); 
    FPL_name_3=strtrim(SEA_four_shells_hs.FPL_name_3); 
    FPL_name_4=strtrim(SEA_four_shells_hs.FPL_name_4);     
   
    data{1,2}=FPL_name_1;
    data{2,2}=FPL_name_2;
    data{3,2}=FPL_name_3;
    data{4,2}=FPL_name_4;
    
catch
end


try
    set(handles.uitable_names,'Data',data);
    pushbutton_read_FPL_Callback(hObject, eventdata, handles);
catch
end


try
    THM1=SEA_four_shells_hs.THM1;
    assignin('base',FPL_name_1,THM1);  
catch
    disp('  THM1 failed ')
end 
try
    THM2=SEA_four_shells_hs.THM2;
    assignin('base',FPL_name_2,THM2);  
catch
end 
try
    THM3=SEA_four_shells_hs.THM3;
    assignin('base',FPL_name_3,THM3);  
catch
end 
try
    THM4=SEA_four_shells_hs.THM4;
    assignin('base',FPL_name_4,THM4);  
catch
end 

%%%%
  
try
    MM=SEA_four_shells_hs.MM;
    cn={'Mach'};
    set(handles.uitable_mach,'Data',MM,'ColumnName',cn);
    
catch
end    



try
    smd=SEA_four_shells_hs.smd;
    setappdata(0,'smd',smd);
catch
end

try
    smd_orig=SEA_four_shells_hs.smd_orig;
    setappdata(0,'smd_orig',smd_orig);
catch
end


try
    trajectory_name=SEA_four_shells_hs.trajectory_name; 
    set(handles.edit_trajectory_array,'String',trajectory_name); 
catch
end

try
    THM_trajectory=SEA_four_shells_hs.THM_trajectory;  
    assignin('base',trajectory_name,THM_trajectory);     
catch
end



%%%


change(hObject, eventdata, handles);

%%%%



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%

try
    AA=get(handles.uitable_names,'Data');
    SEA_four_shells_hs.AA=AA;
catch
end   

try
    MM=get(handles.uitable_mach,'Data');
    SEA_four_shells_hs.MM=MM;
catch
end    



try
    FPL_name_1=strtrim(char(AA{1,2}));
    SEA_four_shells_hs.FPL_name_1=FPL_name_1;
catch
end
try
    FPL_name_2=strtrim(char(AA{2,2}));
    SEA_four_shells_hs.FPL_name_2=FPL_name_2;
catch
end
try
    FPL_name_3=strtrim(char(AA{3,2}));
    SEA_four_shells_hs.FPL_name_3=FPL_name_3;
catch
end
try
    FPL_name_4=strtrim(char(AA{4,2}));
    SEA_four_shells_hs.FPL_name_4=FPL_name_4;
catch
end



try
    THM1=evalin('base',FPL_name_1);
    SEA_four_shells_hs.THM1=THM1;
catch
    warndlg('FPL_name_1 not found ');
    return;
end
try
    THM2=evalin('base',FPL_name_2);
    SEA_four_shells_hs.THM2=THM2;    
catch
    warndlg('FPL_name_2 not found ');
    return;
end
try
    THM3=evalin('base',FPL_name_3);
    SEA_four_shells_hs.THM3=THM3;    
catch
    warndlg('FPL_name_3 not found ');
    return;
end
try
    THM4=evalin('base',FPL_name_4);
    SEA_four_shells_hs.THM4=THM4;    
catch
    warndlg('FPL_name_4 not found ');
    return;
end


try
    trajectory_name=get(handles.edit_trajectory_array,'String');
    SEA_four_shells_hs.trajectory_name=trajectory_name;  
    THM_trajectory=evalin('base',trajectory_name);
    SEA_four_shells_hs.THM_trajectory=THM_trajectory;
catch
    warndlg('Trajectory Array not found ');
    return;
end



%%%%%%%%%%%%%%

try
    listbox_lf1=getappdata(0,'listbox_lf1');    
    SEA_four_shells_hs.listbox_lf1=listbox_lf1;
catch
end
try
    listbox_lf2=getappdata(0,'listbox_lf2');    
    SEA_four_shells_hs.listbox_lf2=listbox_lf2;
catch
end
try
    listbox_lf3=getappdata(0,'listbox_lf3');    
    SEA_four_shells_hs.listbox_lf3=listbox_lf3;
catch
end
try
    listbox_lf4=getappdata(0,'listbox_lf4');    
    SEA_four_shells_hs.listbox_lf4=listbox_lf4;
catch
end

%%%

try
    constant_lf1=getappdata(0,'constant_lf1');
    SEA_four_shells_hs.constant_lf1=constant_lf1;
catch
end
try
    constant_lf2=getappdata(0,'constant_lf2');
    SEA_four_shells_hs.constant_lf2=constant_lf2;
catch
end
try
    constant_lf3=getappdata(0,'constant_lf3');
    SEA_four_shells_hs.constant_lf3=constant_lf3;
catch
end
try
    constant_lf4=getappdata(0,'constant_lf4');
    SEA_four_shells_hs.constant_lf4=constant_lf4;
catch
end

%%%%%%%%%%%%%%

try
    altitude_orig=str2num(get(handles.edit_altitude,'String')); 
    SEA_four_shells_hs.altitude_orig=altitude_orig;
catch
end

try
    mach=str2num(get(handles.edit_mach,'String'));      
    SEA_four_shells_hs.mach=mach;
catch
end

try
    a_1=str2num(get(handles.edit_a1,'String'));     
    SEA_four_shells_hs.a_1=a_1;
catch
end

try
    a_2=str2num(get(handles.edit_a2,'String')); 
    SEA_four_shells_hs.a_2=a_2;
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    gas_c=getappdata(0,'gas_c_orig');        
    SEA_four_shells_hs.gas_c=gas_c;
catch
end
 
try
    gas_md=getappdata(0,'gas_md_orig');
    SEA_four_shells_hs.gas_md=gas_md;
catch
end
 
try
    fstart=getappdata(0,'fstart_orig'); 
    SEA_four_shells_hs.fstart=fstart;
catch
end
 
try
    iu=getappdata(0,'iu');
    SEA_four_shells_hs.iu=iu;
catch
end
 
try
    ng=getappdata(0,'ng');
    SEA_four_shells_hs.ng=ng;
catch
end
 
try
    nj12=getappdata(0,'nj12');
    SEA_four_shells_hs.nj12=nj12;
catch
end

try
    nj23=getappdata(0,'nj23');
    SEA_four_shells_hs.nj23=nj23;
catch
end

try
    nj34=getappdata(0,'nj34');
    SEA_four_shells_hs.nj34=nj34;
catch
end
 
try
    L1=getappdata(0,'L1');
    SEA_four_shells_hs.L1=L1;
catch
end
 
try
    L2=getappdata(0,'L2');
    SEA_four_shells_hs.L2=L2;
catch
end

try
    L3=getappdata(0,'L3');
    SEA_four_shells_hs.L3=L3;
catch
end
 
try
    L4=getappdata(0,'L4');
    SEA_four_shells_hs.L4=L4;
catch
end

try
    L1_orig=getappdata(0,'L1_orig');
    SEA_four_shells_hs.L1_orig=L1_orig;
catch
end
 
try
    L2_orig=getappdata(0,'L2_orig');
    SEA_four_shells_hs.L2_orig=L2_orig;
catch
end

try
    L3_orig=getappdata(0,'L3_orig');
    SEA_four_shells_hs.L3_orig=L3_orig;
catch
end
 
try
    L4_orig=getappdata(0,'L4_orig');
    SEA_four_shells_hs.L4_orig=L4_orig;
catch
end


 
try
    diam1=getappdata(0,'diam1');  
    SEA_four_shells_hs.diam1=diam1;
catch
end
 
try
    diam2=getappdata(0,'diam2');  
    SEA_four_shells_hs.diam2=diam2;
catch
end

 
try
    diam3=getappdata(0,'diam3');  
    SEA_four_shells_hs.diam3=diam3;
catch
end
 
try
    diam4=getappdata(0,'diam4');  
    SEA_four_shells_hs.diam4=diam4;
catch
end
 
try
    diam1_orig=getappdata(0,'diam1_orig');  
    SEA_four_shells_hs.diam1_orig=diam1_orig;
catch
end
 
try
    diam2_orig=getappdata(0,'diam2_orig');  
    SEA_four_shells_hs.diam2_orig=diam2_orig;
catch
end
 
 
try
    diam3_orig=getappdata(0,'diam3_orig');  
    SEA_four_shells_hs.diam3_orig=diam3_orig;
catch
end
 
try
    diam4_orig=getappdata(0,'diam4_orig');  
    SEA_four_shells_hs.diam4_orig=diam4_orig;
catch
end
 
 
try
    THM=getappdata(0,'FPL_five');
    SEA_four_shells_hs.THM_five=THM;
catch
end
 
try
    FS=getappdata(0,'FPL_five_name');          
    SEA_four_shells_hs.FS_five=FS;
catch
end
 
try
    THM=getappdata(0,'FPL_nine');
    SEA_four_shells_hs.THM=THM;
catch
end
 
try
    FS=getappdata(0,'FPL_nine_name');          
    SEA_four_shells_hs.FS=FS;
catch
end


try
    listbox_array_type=getappdata(0,'listbox_array_type');        
    SEA_four_shells_hs.listbox_array_type=listbox_array_type;
catch
end


%%%

try
    imat_orig=getappdata(0,'imat_orig');
    SEA_four_shells_hs.imat_orig=imat_orig;
catch
end

try
    tf_orig=getappdata(0,'tf_orig');
    SEA_four_shells_hs.tf_orig=tf_orig;
catch
end

try
    E_orig=getappdata(0,'E_orig');
    SEA_four_shells_hs.E_orig=E_orig;
catch
end
 
 
try
    rhof_orig=getappdata(0,'rhof_orig');
    SEA_four_shells_hs.rhof_orig=rhof_orig;
catch
end

try
    smd_orig=getappdata(0,'smd_orig');
    SEA_four_shells_hs.smd_orig=smd_orig;
catch
end
try
    smd=getappdata(0,'smd');
    SEA_four_shells_hs.smd=smd;
catch
end


try
    G_orig=getappdata(0,'G_orig');
    SEA_four_shells_hs.G_orig=G_orig;
catch
end

try
    rhoc_orig=getappdata(0,'rhoc_orig');
    SEA_four_shells_hs.rhoc_orig=rhoc_orig;
catch
end
 
 
try
    hc_orig=getappdata(0,'hc_orig');
    SEA_four_shells_hs.hc_orig=hc_orig;
catch
end

try
    mu_orig=getappdata(0,'mu_orig');
    SEA_four_shells_hs.mu_orig=mu_orig;
catch
end

try
    tf=getappdata(0,'tf');
    SEA_four_shells_hs.tf=tf;
catch
end
 
try
    E=getappdata(0,'E');
    SEA_four_shells_hs.E=E;
catch
end
 
 
try
    rhof=getappdata(0,'rhof');
    SEA_four_shells_hs.rhof=rhof;
catch
end
 
try
    G=getappdata(0,'G');
    SEA_four_shells_hs.G=G;
catch
end
 
try
    rhoc=getappdata(0,'rhoc');
    SEA_four_shells_hs.rhoc=rhoc;
catch
end
 
 
try
    hc=getappdata(0,'hc');
    SEA_four_shells_hs.hc=hc;
catch
end
 
try
    mu=getappdata(0,'mu');
    SEA_four_shells_hs.mu=mu;
catch
end


try
   
    AA=get(handles.uitable_names,'Data');

    sname_1=char(AA{1,1});
    sname_2=char(AA{2,1});
    sname_3=char(AA{3,1});
    sname_4=char(AA{4,1});

    SEA_four_shells_hs.sname_1=sname_1;
    SEA_four_shells_hs.sname_2=sname_2;
    SEA_four_shells_hs.sname_3=sname_3;
    SEA_four_shells_hs.sname_4=sname_4;    
    
catch
end

 
% % %
 
structnames = fieldnames(SEA_four_shells_hs, '-full'); % fields in the struct
 
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'SEA_four_shells_hs'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
% Construct a questdlg with four options
choice = questdlg('Save Complete.  Reset Workspace?', ...
    'Options', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
%%        disp([choice ' Reseting'])
%%        pushbutton_reset_Callback(hObject, eventdata, handles)
        appdata = get(0,'ApplicationData');
        fnsx = fieldnames(appdata);
        for ii = 1:numel(fnsx)
            rmappdata(0,fnsx{ii});
        end
end  

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp(' * * * * * * * * * * * * * * * * * * * * * * ');
disp(' ');

tpi=2*pi;

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


fig_num=1;
setappdata(0,'fig_num',1);


read_special(hObject, eventdata, handles);

THM1=getappdata(0,'THM1');
THM2=getappdata(0,'THM2');
THM3=getappdata(0,'THM3');
THM4=getappdata(0,'THM4');

sname_1=getappdata(0,'sname_1');
sname_2=getappdata(0,'sname_2');
sname_3=getappdata(0,'sname_3');
sname_4=getappdata(0,'sname_4');



sz1=size(THM1);

nmach=sz1(2)-1;

%%%%%%%%%%%%
%

iu=get(handles.listbox_units,'Value');
setappdata(0,'iu',iu);

iuo=iu;

%%%%

[ft_per_km,meters_per_inch]=length_unit_conversion();
[kgpm3_per_lbmpft3]=mass_per_volume_conversion();

setappdata(0,'ft_per_km',ft_per_km);

%
%%%%%%%%%%%%

MM=get(handles.uitable_mach,'Data');

fpl_mach=zeros(nmach,1);

for i=1:nmach
    fpl_mach(i)=str2num(char(MM{i,1}));
end

% fpl_mach

%%%%

trajectory_name=get(handles.edit_trajectory_array,'String');
   
try
    trajectory=evalin('base',trajectory_name);
catch
    warndlg('Enter trajectory array');
    return;
end

%%

a_1=str2num(get(handles.edit_a1,'String'));
a_2=str2num(get(handles.edit_a2,'String'));
    
setappdata(0,'a_1',a_1);
setappdata(0,'a_2',a_2);

%%

alt_mach=zeros(nmach,1);

altitude=trajectory(:,1);
mach=trajectory(:,2);


mach_length=length(mach);

% interpolation

for i=1:nmach
    for j=1:(mach_length-1)
        if(fpl_mach(i)>=mach(j) && fpl_mach(i)<=mach(j+1))
            x1=mach(j);
            y1=altitude(j);
            x2=mach(j+1);
            y2=altitude(j+1);
            xnew=fpl_mach(i);
            [ynew]=linear_interpolation_function(x1,y1,x2,y2,xnew);
            alt_mach(i)=ynew;    
            break;
        end
    end
end



for i=1:nmach
    if(alt_mach(i)==0)
        
        disp(' ');
        out1=sprintf('        fpl mach range: %g to %g  ',min(fpl_mach),max(fpl_mach));
        out2=sprintf(' trajectory mach range: %g to %g  ',min(mach),max(mach));
        
        disp(out1);
        disp(out2);
        
        warndlg('Error:  FPL mach is outside of trajectory mach ');
        return;
    end
end

%

gas_md=zeros(nmach,1);
gas_c=zeros(nmach,1);
fs_velox=zeros(nmach,1);


for i=1:nmach
    
    [~,mass_dens,~,~,sound_speed]=atmopheric_properties(alt_mach(i),iu);
    
    gas_md(i)=mass_dens;
    gas_c(i) =sound_speed;

end    

if(iu==1)  % convert English to metric
   
   gas_c=gas_c*12;
   gas_c=gas_c*meters_per_inch;
   
   gas_md=gas_md*kgpm3_per_lbmpft3;
   
end

for i=1:nmach
    fs_velox(i)=fpl_mach(i)*gas_c(i);  % m/sec
end

% mach,altitude,gas_md,gas_c,fs_velox


%%%%

L1=getappdata(0,'L1');
L2=getappdata(0,'L2');
L3=getappdata(0,'L3');
L4=getappdata(0,'L4');

diam1=getappdata(0,'diam1');
diam2=getappdata(0,'diam2');
diam3=getappdata(0,'diam3');
diam4=getappdata(0,'diam4');

nj12=getappdata(0,'nj12');
nj23=getappdata(0,'nj23');
nj34=getappdata(0,'nj34');


if(isempty(nj12))
    warndlg('nj12 not found.  Run geometry');
    return;
end
if(isempty(nj23))
    warndlg('nj23 not found.  Run geometry');
    return;
end
if(isempty(nj34))
    warndlg('nj34 not found.  Run geometry');
    return;
end

%%%%

if(nj12==1)
    Lc12=pi*diam1;
end
if(nj12==2)
    Lc12=pi*diam2;    
end
if(nj12==3)
    Lc12=pi*mean([ diam1 diam2  ]);
end

%%%%

if(nj23==1)
    Lc23=pi*diam2;
end
if(nj23==2)
    Lc23=pi*diam3;    
end
if(nj23==3)
    Lc23=pi*mean([ diam2 diam3  ]);
end

%%%%

if(nj34==1)
    Lc34=pi*diam3;
end
if(nj34==2)
    Lc34=pi*diam4;    
end
if(nj34==3)
    Lc34=pi*mean([ diam3 diam4  ]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

freq=THM1(:,1);
fc=freq;

nfc=length(freq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

listbox_lf1=getappdata(0,'listbox_lf1');
listbox_lf2=getappdata(0,'listbox_lf2');
listbox_lf3=getappdata(0,'listbox_lf3');
listbox_lf4=getappdata(0,'listbox_lf4');


lf1=zeros(nfc,1);
lf2=zeros(nfc,1);
lf3=zeros(nfc,1);
lf4=zeros(nfc,1);


if(listbox_lf1==1)
    for i=1:nfc
        [lf1(i)]=sandwich_panel_bare_lf(fc(i));
    end
else    
    constant_lf1=getappdata(0,'constant_lf1');
    lf1=ones(nfc,1)*constant_lf1;
end

if(listbox_lf2==1)
    for i=1:nfc
        [lf2(i)]=sandwich_panel_bare_lf(fc(i));
    end    
else    
    constant_lf2=getappdata(0,'constant_lf2');
    lf2=ones(nfc,1)*constant_lf2;    
end

if(listbox_lf3==1)
    for i=1:nfc
        [lf3(i)]=sandwich_panel_bare_lf(fc(i));
    end    
else    
    constant_lf3=getappdata(0,'constant_lf3');
    lf3=ones(nfc,1)*constant_lf3;    
end

if(listbox_lf4==1)
    for i=1:nfc
        [lf4(i)]=sandwich_panel_bare_lf(fc(i));
    end    
else    
    constant_lf4=getappdata(0,'constant_lf4');
    lf4=ones(nfc,1)*constant_lf4;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

E=getappdata(0,'E');
mu=getappdata(0,'mu');
G=getappdata(0,'G');

rhoc=getappdata(0,'rhoc');
hc=getappdata(0,'hc');

tf=getappdata(0,'tf');
rhof=getappdata(0,'rhof');

smd=getappdata(0,'smd');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(isempty(tf))
    warndlg('tf missing. Enter Sandwich Data');
    return;
end
if(isempty(hc))
    warndlg('hc missing. Enter Sandwich Data');
    return;
end
if(isempty(G))
    warndlg('G missing. Enter Sandwich Data');
    return;
end
if(isempty(rhof))
    warndlg('rhof missing. Enter Sandwich Data');
    return;
end
if(isempty(rhoc))
    warndlg('rhoc missing. Enter Sandwich Data');
    return;
end
if(isempty(smd))
    warndlg('smd missing. Enter Sandwich Data');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% bc=get(handles.listbox_bc,'Value');
bc=4;   % simply supported at each end


fstart=str2num(get(handles.edit_fstart,'String')); 


if(isempty(fstart))
   warndlg(' Enter output starting frequency '); 
   return; 
end    

setappdata(0,'fstart_orig',fstart);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iu=2;


disp(' ');
out1=sprintf(' L1=%8.4g  L2=%8.4g  L3=%8.4g  L4=%8.4g ',L1,L2,L3,L4);
disp(out1);
out1=sprintf(' diam1=%8.4g  diam2=%8.4g  diam3=%8.4g  diam4=%8.4g ',diam1,diam2,diam3,diam4);
disp(out1);
out1=sprintf(' E=%8.4g  G=%8.4g  mu=%8.4g  tf=%8.4g  hc=%8.4g rhof=%8.4g  rhoc=%8.4g',E,G,mu,tf,hc,rhof,rhoc);
disp(out1);
disp(' ');
 

[D1,K1,S1,~,fring1]=honeycomb_sandwich_properties_wave(E(1),G(1),mu(1),tf(1),hc(1),diam1,rhof(1),rhoc(1));
[D2,K2,S2,~,fring2]=honeycomb_sandwich_properties_wave(E(2),G(2),mu(2),tf(2),hc(2),diam2,rhof(2),rhoc(2));
[D3,K3,S3,~,fring3]=honeycomb_sandwich_properties_wave(E(3),G(3),mu(3),tf(3),hc(3),diam3,rhof(3),rhoc(3));
[D4,K4,S4,~,fring4]=honeycomb_sandwich_properties_wave(E(4),G(4),mu(4),tf(4),hc(4),diam4,rhof(4),rhoc(4));

[f11,f12]=shear_frequencies(E(1),G(1),mu(1),tf(1),hc(1),rhof(1),rhoc(1));
[f21,f22]=shear_frequencies(E(2),G(2),mu(2),tf(2),hc(2),rhof(2),rhoc(2));
[f31,f32]=shear_frequencies(E(3),G(3),mu(3),tf(3),hc(3),rhof(3),rhoc(3));
[f41,f42]=shear_frequencies(E(4),G(4),mu(4),tf(4),hc(4),rhof(4),rhoc(4));

NSM_per_area=0;


%% nfc

fcr=zeros(nmach,4);
rho_c=zeros(nmach,1);

mpa=zeros(4,1);
B=zeros(4,1);
Bf=zeros(4,1);

for j=1:nmach
    
    % mach,altitude,gas_md,gas_c,fs_velox

    rho_c(j)=gas_md(j)*gas_c(j);
    
    for i=1:4     

        [fcr(j,i),mpa(i),B(i),Bf(i),kflag]=...
            honeycomb_sandwich_critical_frequency_D(E(i),G(i),mu(i),tf(i),hc(i),rhof(i),rhoc(i),gas_c(j),NSM_per_area);

        if(kflag==1)
            warndlg('Critical frequency does not exist for this case');
            return;
        end

    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mpa=smd;

mmax=220;
nmax=220;

Ap1=L1*pi*diam1;
mass1=mpa(1)*Ap1;
m1=mass1;

Ap2=L2*pi*diam2;
mass2=mpa(2)*Ap2;
m2=mass2;

Ap3=L3*pi*diam3;
mass3=mpa(3)*Ap3;
m3=mass3;

Ap4=L4*pi*diam4;
mass4=mpa(4)*Ap4;
m4=mass4;


num=length(fc);

rad_eff1=zeros(num,nmach);
rad_eff2=zeros(num,nmach);
rad_eff3=zeros(num,nmach);
rad_eff4=zeros(num,nmach);

mph1=zeros(num,nmach);
mph2=zeros(num,nmach);
mph3=zeros(num,nmach);
mph4=zeros(num,nmach);

cphase1=zeros(num,nmach);
cphase2=zeros(num,nmach);
cphase3=zeros(num,nmach);
cphase4=zeros(num,nmach);


for j=1:nmach

    [rad_eff1(:,j),mph1(:,j),cphase1(:,j)]=...
        re_sandwich_cylinder_engine_speed(D1,K1,mu(1),diam1,L1,mpa(1),bc,mmax,nmax,gas_c(j),fcr(1),fring1,freq);
    
    [rad_eff2(:,j),mph2(:,j),cphase2(:,j)]=...
        re_sandwich_cylinder_engine_speed(D2,K2,mu(2),diam2,L2,mpa(2),bc,mmax,nmax,gas_c(j),fcr(2),fring2,freq);

    [rad_eff3(:,j),mph3(:,j),cphase3(:,j)]=...
        re_sandwich_cylinder_engine_speed(D3,K3,mu(3),diam3,L3,mpa(3),bc,mmax,nmax,gas_c(j),fcr(3),fring3,freq);

    [rad_eff4(:,j),mph4(:,j),cphase4(:,j)]=...
        re_sandwich_cylinder_engine_speed(D4,K4,mu(4),diam4,L4,mpa(4),bc,mmax,nmax,gas_c(j),fcr(4),fring4,freq);

end

%%%

ajf=ones(nmach,1);
ajg=ones(nmach,1);

for j=1:nmach
    for i=(num-2):-1:1
        if(mph1(i,j)<1.e-20 || mph2(i,j)<1.e-20 || mph3(i,j)<1.e-20 || mph4(i,j)<1.e-20 || rad_eff1(i,j)<1.e-20 || rad_eff2(i,j)<1.e-20 || rad_eff3(i,j)<1.e-20 || rad_eff4(i,j)<1.e-20 ||fc(i)<fstart ) 
        
            ajf(j)=i+1;
            disp(' break 1');
            break;
      
        end
    end
end


for j=1:nmach
    for i=(num-2):-1:1
    
        if(mph1(i,j)<1.e-20 || mph2(i,j)<1.e-20 || mph3(i,j)<1.e-20 || mph4(i,j)<1.e-20 || rad_eff1(i,j)<1.e-20 || rad_eff2(i,j)<1.e-20 || rad_eff3(i,j)<1.e-20 || rad_eff4(i,j)<1.e-20 )
       
            out1=sprintf('i=%d  mph1=%8.4g  mph2=%8.4g  mph3=%8.4g  mph4=%8.4g \n     rad_eff1=%8.4g  rad_eff2=%8.4g  rad_eff3=%8.4g  rad_eff4=%8.4g   ',i,mph1(i),mph2(i),mph3(i),mph4(i),rad_eff1(i),rad_eff2(i),rad_eff3(i),rad_eff4(i));
            disp(out1);
        
            ajg(j)=i+1;
            disp(' break 2');
            break;

        end    
    end
end

jf=min(ajf);
jg=min(ajg);

out1=sprintf(' jf=%d jg=%d  num=%d',jf,jg,num);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    fmin=fc(jf);
catch
    fmin=fc(1);
end
        
fmax=fc(num);

try
    out1=sprintf('\n fc(jf)=%8.4g  jf=%d  fc(jg)=%8.4g  jg=%d  \n',fc(jf),jf,fc(jg),jg);
    disp(out1);
catch
end
    
out1=sprintf('\n fmin=%8.4g   fmax=%8.4g  \n',fmin,fmax);
disp(out1);

if(fmax<1)
    warndlg('fmax error');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


leg1=sname_1;
leg2=sname_2;
leg3=sname_3;
leg4=sname_4;

f1=fc;
f2=f1;
f3=f1;
f4=f1;

n_type=1;

sz=size(THM1);
ncc=sz(2);

for j=2:ncc

    dB1=THM1(:,j);
    dB2=THM2(:,j);
    dB3=THM3(:,j);
    dB4=THM4(:,j);
    
    t_string=sprintf('Mach %g',fpl_mach(j-1));

    [fig_num]=fpl_plot_four_title(fig_num,n_type,f1,dB1,f2,dB2,f3,dB3,f4,dB4,leg1,leg2,leg3,leg4,t_string);    

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

leg1=sname_1;
leg2=sname_2;
leg3=sname_3;
leg4=sname_4;

x_label='Center Frequency (Hz)';
y_label='Ratio';


md=3;

for j=2:ncc
    
    t_string=sprintf('Radiation Efficiency  Mach %g',fpl_mach(j-1));

    ppp1=[fc(jg:num) rad_eff1(jg:num,j-1)];
    ppp2=[fc(jg:num) rad_eff2(jg:num,j-1)];
    ppp3=[fc(jg:num) rad_eff3(jg:num,j-1)];
    ppp4=[fc(jg:num) rad_eff4(jg:num,j-1)];
    
    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,fmin,fmax,md);
                  
end

ppp1=[fc(jg:num) rad_eff1(jg:num,:)];
ppp2=[fc(jg:num) rad_eff2(jg:num,:)];
ppp3=[fc(jg:num) rad_eff3(jg:num,:)];
ppp4=[fc(jg:num) rad_eff4(jg:num,:)];

assignin('base', 'rad_eff1',ppp1);
assignin('base', 'rad_eff2',ppp2);
assignin('base', 'rad_eff3',ppp3);
assignin('base', 'rad_eff4',ppp4);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha=2^(1/6)-1/2^(1/6);

k=1;

num_modes_1=zeros((num-jg+1),1);
num_modes_2=zeros((num-jg+1),1);
num_modes_3=zeros((num-jg+1),1);
num_modes_4=zeros((num-jg+1),1);

fnm=zeros((num-jg+1),1);


for i=jg:num
    
    bw=fc(i)*alpha;
    
    fnm(k)=fc(i);
    
    num_modes_1(k)=mph1(i,1)*bw;
    num_modes_2(k)=mph2(i,1)*bw;    
    num_modes_3(k)=mph3(i,1)*bw;
    num_modes_4(k)=mph4(i,1)*bw;     
    
    k=k+1;
    
end

data1=[fnm num_modes_1];
data2=[fnm num_modes_2];
data3=[fnm num_modes_3];
data4=[fnm num_modes_4];

xlabel2='Center Frequency (Hz)';
ylabel1='Modes';
ylabel2='Modes';
ylabel3='Modes';
ylabel4='Modes';


t_string1=sprintf('Number of Modes in Band  %s',sname_1);
t_string2=sprintf('Number of Modes in Band  %s',sname_2);
t_string3=sprintf('Number of Modes in Band  %s',sname_3);
t_string4=sprintf('Number of Modes in Band  %s',sname_4);

[fig_num]=subplots_four_onethird_bar(fig_num,xlabel2,...
                                     ylabel1,ylabel2,ylabel3,ylabel4,...
                                     data1,data2,data3,data4,...
                                     t_string1,t_string2,t_string3,t_string4);
                                 
                                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp1=[fc(jg:num) mph1(jg:num,1)];
ppp2=[fc(jg:num) mph2(jg:num,1)];
ppp3=[fc(jg:num) mph3(jg:num,1)];
ppp4=[fc(jg:num) mph4(jg:num,1)];


assignin('base', 'mph1',ppp1);
assignin('base', 'mph2',ppp2);
assignin('base', 'mph3',ppp3);
assignin('base', 'mph4',ppp4);

leg1=sname_1;
leg2=sname_2;
leg3=sname_3;
leg4=sname_4;


x_label='Center Frequency (Hz)';
y_label='n (modes/Hz)';
t_string='Modal Density';

md=3;
[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,fmin,fmax,md);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp(' ');
disp('   Modal Density (modes/Hz)');
disp(' ');
disp('   fc(Hz)   mph1   mph2    mph3   mph4 ');
disp(' ');

for i=1:num    
    out1=sprintf('%7.1f  %8.4g  %8.4g  %8.4g  %8.4g',fc(i),mph1(i,1),mph2(i,1),mph3(i,1),mph4(i,1));
    disp(out1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   power1=zeros(num,nmach);
power_dB1=zeros(num,nmach);

   power2=zeros(num,nmach);
power_dB2=zeros(num,nmach);

   power3=zeros(num,nmach);
power_dB3=zeros(num,nmach);

   power4=zeros(num,nmach);
power_dB4=zeros(num,nmach);

md=rhof;
md_core=rhoc;
v=mu;

Uc=zeros(nmach,1);

for i=1:nmach
    
    x=fpl_mach(i);
    
    if(x<=1.2)
        CCC=0.8;
    else
        if(x>1.2 && x <2.5)
        
            x1=1.2;
            y1=0.8;
            x2=2.5;
            y2=0.6;
            xnew=x;
            
            [CCC]=linear_interpolation_function(x1,y1,x2,y2,xnew);
            
        else
            
            CCC=0.6;
            
        end
        
        
    end
    
    Uc(i)=CCC*fs_velox(i);    
end

%% for i=1:4

%    [B(i),~,~,mpa(i)]=honeycomb_sandwich_properties(E(i),G(i),v(i),tf(i),hc(i),md(i),md_core(i));
%    [Bf(i)]=flexural_rigidity(E(i),tf(i),v(i));

%%        Uc=0.8*fs_velox;
%%        omegac = (Uc/( (B(i)/mpa(i))^(1/4)))^2; 
%%        fh=omegac/tpi;
%%        out1=sprintf('%d  fh=%8.4g Hz  Uc=%8.4g  B=%8.4g  mpa=%8.4g',i,fh,Uc,B(i),mpa(i));
%%        disp(out1);
%%end

cp=zeros(num,4);

omega=tpi*fc;
for i=1:num   
    
    for j=1:4
        [cp(i,j)]=sandwich_wavespeed_polynomial(omega(i),B(j),Bf(j),G(j),mpa(j),hc(j));
    end  
    
%%     if(cphase1(i,1)>0)
%%         cp(i,1)=cphase1(i,1);
%%     end
%%     if(cphase2(i,1)>0)
%%         cp(i,2)=cphase2(i,1);
%%     end
%%     if(cphase3(i,1)>0)
%%         cp(i,3)=cphase3(i,1);
%%     end
%%     if(cphase4(i,1)>0)
%%         cp(i,4)=cphase4(i,1);
%%     end    
    
end





disp(' ');

for ijk=1:nmach  % mach bin
        
    dB1=THM1(:,ijk+1);
    dB2=THM2(:,ijk+1);
    dB3=THM3(:,ijk+1);
    dB4=THM4(:,ijk+1);
    
    for i=1:num   % freq
            
        % [power,power_dB,a1,a2]=power_from_TBL_spl_dB(fc,dB,mpa,Ap,L,Uc,cp,a1,a2)
    
        [power1(i,ijk),power_dB1(i,ijk),~,~]=power_from_TBL_spl_dB(fc(i),dB1(i),mpa(1),Ap1,L1,Uc(ijk),cp(i,1),a_1,a_2);     
        [power2(i,ijk),power_dB2(i,ijk),~,~]=power_from_TBL_spl_dB(fc(i),dB2(i),mpa(2),Ap2,L2,Uc(ijk),cp(i,2),a_1,a_2);  
        [power3(i,ijk),power_dB3(i,ijk),~,~]=power_from_TBL_spl_dB(fc(i),dB3(i),mpa(3),Ap3,L3,Uc(ijk),cp(i,3),a_1,a_2);       
        [power4(i,ijk),power_dB4(i,ijk),~,~]=power_from_TBL_spl_dB(fc(i),dB4(i),mpa(4),Ap4,L4,Uc(ijk),cp(i,4),a_1,a_2);  
            
    end
end


    
disp(' ');  
disp('Hydrodynamically slow to fast transition frequencies '); 
  
for ijk=1:nmach  % mach bin
    
    out1=sprintf('\n Mach=%g ',fpl_mach(ijk));
    disp(out1);
    
    for i=1:4
  
        [ftrans]=sandwich_wavespeed_polynomial_transition(B(i),Bf(i),G(i),mpa(i),hc(i),Uc(ijk)); 
   
        if(i==1)
            out1=sprintf('  %s  freq=%8.4g Hz',sname_1,ftrans);
        end
        if(i==2)
            out1=sprintf('  %s  freq=%8.4g Hz',sname_2,ftrans);
        end  
        if(i==3)
            out1=sprintf('  %s  freq=%8.4g Hz',sname_3,ftrans);
        end
        if(i==4)
            out1=sprintf('  %s  freq=%8.4g Hz',sname_4,ftrans);
        end             
        
        disp(out1);
  
    end

end


for ijk=1:nmach  % mach bin
    
    out1=sprintf('\n Mach=%g ',fpl_mach(ijk));
    disp(out1);

    dB1=THM1(:,ijk+1);
    dB2=THM2(:,ijk+1);
    dB3=THM3(:,ijk+1);
    dB4=THM4(:,ijk+1);
    
    disp(' ');
    disp(' Zero dB References: ');
    disp('   Pressure 20 micro Pa');
    disp('   Power     1 pico Watt ');
    disp(' ');
    disp('   fc    FPL1    FPL2    FPL3     FPL4    ');
    disp('  (Hz)   (dB)    (dB)    (dB)     (dB)    ');

    for i=1:num
        out1=sprintf('%7.1f  %6.1f  %6.1f  %6.1f  %6.1f',fc(i),dB1(i),dB2(i),dB3(i),dB4(i));
        disp(out1);
    end    

    disp(' ');
    disp('   fc    Power1  Power2  Power3   Power4    ');
    disp('  (Hz)   (dB)    (dB)    (dB)     (dB)    ');


    for i=1:num    
        out1=sprintf('%7.1f  %6.1f  %6.1f  %6.1f  %6.1f',fc(i),power_dB1(i,ijk),power_dB2(i,ijk),power_dB3(i,ijk),power_dB4(i,ijk));
        disp(out1);
    end
    
    
    disp(' ');

    [oapow1]=oaspl_function(power_dB1(:,ijk));
    [oapow2]=oaspl_function(power_dB2(:,ijk));
    [oapow3]=oaspl_function(power_dB3(:,ijk));
    [oapow4]=oaspl_function(power_dB4(:,ijk));

    out1=sprintf('\n Overall Power Levels \n  Power 1 = %7.4g dB \n  Power 2 = %7.4g dB \n  Power 3 = %7.4g dB \n  Power 4 = %7.4g dB ',oapow1,oapow2,oapow3,oapow4);
    disp(out1);
    

end

power_ref=1.0e-12;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NL=length(fc);

omega=tpi*fc;

clf_12=zeros(NL,1);
clf_21=zeros(NL,1);

clf_23=zeros(NL,1);
clf_32=zeros(NL,1);

clf_34=zeros(NL,1);
clf_43=zeros(NL,1);

Moverlap1=zeros(NL,1);
Moverlap2=zeros(NL,1);
Moverlap3=zeros(NL,1);
Moverlap4=zeros(NL,1);


% [B,~,~,mpa]=honeycomb_sandwich_properties(E,G,mu,tf,hc,rhof,rhoc);
% [Bf]=flexural_rigidity(E,tf,mu);


for i=1:NL

    [Moverlap1(i)]=SEA_modal_overlap(mph1(i),lf1(i),freq(i));
    [Moverlap2(i)]=SEA_modal_overlap(mph2(i),lf2(i),freq(i));
    [Moverlap3(i)]=SEA_modal_overlap(mph3(i),lf3(i),freq(i));
    [Moverlap4(i)]=SEA_modal_overlap(mph4(i),lf4(i),freq(i));    
    
    [clf_12(i),clf_21(i),~]=sandwich_panel_line_index(omega(i),B,Bf,G,mpa,hc,Lc12,Ap1,Ap2,1,2);
    [clf_23(i),clf_32(i),~]=sandwich_panel_line_index(omega(i),B,Bf,G,mpa,hc,Lc23,Ap2,Ap3,2,3);
    [clf_34(i),clf_43(i),~]=sandwich_panel_line_index(omega(i),B,Bf,G,mpa,hc,Lc34,Ap3,Ap4,3,4);    
end


lfa1=zeros(NL,ijk);
lfa2=zeros(NL,ijk);
lfa3=zeros(NL,ijk);
lfa4=zeros(NL,ijk);

total_lf1=zeros(NL,ijk);
total_lf2=zeros(NL,ijk);
total_lf3=zeros(NL,ijk);
total_lf4=zeros(NL,ijk);


for ijk=1:nmach
    for i=1:NL
    
        radiation_resistance1=rho_c(ijk)*Ap1*rad_eff1(i,ijk);
        lfa1(i,ijk)=radiation_resistance1/(m1*omega(i));  
    
        radiation_resistance2=rho_c(ijk)*Ap2*rad_eff2(i,ijk);
        lfa2(i,ijk)=radiation_resistance2/(m2*omega(i));      
    
        radiation_resistance3=rho_c(ijk)*Ap3*rad_eff3(i,ijk);
        lfa3(i,ijk)=radiation_resistance3/(m3*omega(i));   
    
        radiation_resistance4=rho_c(ijk)*Ap4*rad_eff4(i,ijk);
        lfa4(i,ijk)=radiation_resistance4/(m4*omega(i));       

    end
    
    total_lf1(:,ijk)=lf1(:)+lfa1(:,ijk);
    total_lf2(:,ijk)=lf2(:)+lfa2(:,ijk);
    total_lf3(:,ijk)=lf3(:)+lfa3(:,ijk);
    total_lf4(:,ijk)=lf4(:)+lfa4(:,ijk);
 
end

ppq1=[fc(jg:num)  Moverlap1(jg:num) ];
ppq2=[fc(jg:num)  Moverlap2(jg:num) ];
ppq3=[fc(jg:num)  Moverlap3(jg:num) ];
ppq4=[fc(jg:num)  Moverlap4(jg:num) ];


leg1=sname_1;
leg2=sname_2;
leg3=sname_3;
leg4=sname_4;


x_label='Center Frequency (Hz)';
y_label=' ';
t_string='Modal Overlap';

md=4;
[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppq1,ppq2,ppq3,ppq4,leg1,leg2,leg3,leg4,fmin,fmax,md);

                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      

v1=zeros(NL,nmach);
v2=zeros(NL,nmach);
v3=zeros(NL,nmach);
v4=zeros(NL,nmach);

a1=zeros(NL,nmach);
a2=zeros(NL,nmach);
a3=zeros(NL,nmach);
a4=zeros(NL,nmach);


% broadband=zeros(NL,4);
 
DD=2;
z=2^(1/6);

for ijk=1:nmach
    for i=1:NL

        A=zeros(4,4);
    
        A(1,1)=total_lf1(i,ijk)+clf_12(i);
        A(1,2)=-clf_12(i);
    
        A(2,1)=-clf_12(i);
        A(2,2)=total_lf2(i,ijk)+clf_21(i)+clf_23(i);
        A(2,3)=-clf_32(i);
    
        A(3,2)=-clf_23(i);
        A(3,3)=total_lf3(i,ijk)+clf_32(i)+clf_34(i);
        A(3,4)=-clf_43(i);
    
        A(4,3)=-clf_34(i);
        A(4,4)=total_lf4(i,ijk)+clf_43(i);
   
        B=[ power1(i,ijk); power2(i,ijk); power3(i,ijk); power4(i,ijk)]/omega(i);

        E=A\B;

        E1=E(1);
        E2=E(2);
        E3=E(3);
        E4=E(4);    
    
        [v1(i,ijk),a1(i,ijk)]=energy_to_velox_accel(E1,m1,omega(i));    
        [v2(i,ijk),a2(i,ijk)]=energy_to_velox_accel(E2,m2,omega(i));
        [v3(i,ijk),a3(i,ijk)]=energy_to_velox_accel(E3,m3,omega(i));
        [v4(i,ijk),a4(i,ijk)]=energy_to_velox_accel(E4,m4,omega(i));   
    
    end
end


if(iu==2)
   v1=v1*1000;
   v2=v2*1000;
   v3=v3*1000;
   v4=v4*1000;   
end

if(iu==1)
   a1=a1/386;
   a2=a2/386;
   a3=a3/386;
   a4=a4/386;   
else
   a1=a1/9.81;
   a2=a2/9.81;  
   a3=a3/9.81;
   a4=a4/9.81;       
end


if(iu==1)
    seu='in-lbf';
    spu='in-lbf/sec';
    spv='in/sec';
else
    seu='J';
    spu='W';
    spv='mm/sec';    
end  

if(iuo==1)
    v1=v1/25.4;
    v2=v2/25.4;
    v3=v3/25.4;
    v4=v4/25.4;    
    spv='in/sec';
end




disp(' ');
disp(' * * * * ');


for ijk=1:nmach  % mach bin
    
    out1=sprintf('\n Mach=%g ',fpl_mach(ijk));
    disp(out1);


    disp(' ');
    disp(' Freq      a1       a2       a3       a4');
   
    if(iuo==1)
        disp(' (Hz)    (G)      (G)       (G)      (G)');    
    else
        disp(' (Hz)    (G)      (G)       (G)      (G)');  
    end
    
    
    for i=1:NL
    
        out1=sprintf(' %g   %8.4g   %8.4g  %8.4g  %8.4g',fc(i),a1(i),a2(i),a3(i),a4(i));
        disp(out1);
    
    end

end



for ijk=1:nmach  % mach bin

    x_label='Frequency (Hz)';
    y_label=sprintf('Velocity (%s) rms',spv);


    md=5;
    leg1=sname_1;
    leg2=sname_2;
    leg3=sname_3;
    leg4=sname_4;

    ppp1=[fc(jf:num) v1(jf:num,ijk)];
    ppp2=[fc(jf:num) v2(jf:num,ijk)];
    ppp3=[fc(jf:num) v3(jf:num,ijk)];
    ppp4=[fc(jf:num) v4(jf:num,ijk)];

    t_string=sprintf('Velocity Spectrum  Mach %g',fpl_mach(ijk));

    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,fmin,fmax,md);
           
           
end

vel_ps_1=[fc(jf:num) v1(jf:num,ijk,:)];
vel_ps_2=[fc(jf:num) v2(jf:num,ijk,:)];  
vel_ps_3=[fc(jf:num) v3(jf:num,ijk,:)];
vel_ps_4=[fc(jf:num) v4(jf:num,ijk,:)]; 


assignin('base', 'vel_ps_1',vel_ps_1);
assignin('base', 'vel_ps_2',vel_ps_2);
assignin('base', 'vel_ps_3',vel_ps_3);
assignin('base', 'vel_ps_4',vel_ps_4);



for ijk=1:nmach  % mach bin

    
    aaa1=[fc(jf:num) a1(jf:num,ijk)];
    aaa2=[fc(jf:num) a2(jf:num,ijk)];
    aaa3=[fc(jf:num) a3(jf:num,ijk)];
    aaa4=[fc(jf:num) a4(jf:num,ijk)];           
    
    x_label='Frequency (Hz)';
    y_label=sprintf('Accel (G rms)');           
    t_string=sprintf('Acceleration Spectrum  Mach %g',fpl_mach(ijk));

    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,aaa1,aaa2,aaa3,aaa4,leg1,leg2,leg3,leg4,fmin,fmax,md);


end          
  


accel_ps_1=[fc(jf:num) a1(jf:num,ijk,:)];
accel_ps_2=[fc(jf:num) a2(jf:num,ijk,:)];
accel_ps_3=[fc(jf:num) a3(jf:num,ijk,:)];
accel_ps_4=[fc(jf:num) a4(jf:num,ijk,:)];


assignin('base', 'accel_ps_1',accel_ps_1);
assignin('base', 'accel_ps_2',accel_ps_2); 
assignin('base', 'accel_ps_3',accel_ps_3);
assignin('base', 'accel_ps_4',accel_ps_4); 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for ijk=1:nmach  % mach bin

    qqq1=[fc(jf:num) power1(jf:num,ijk)];
    qqq2=[fc(jf:num) power2(jf:num,ijk)];
    qqq3=[fc(jf:num) power3(jf:num,ijk)];
    qqq4=[fc(jf:num) power4(jf:num,ijk)];

    t_string=sprintf('Input Power Spectrum  Mach %g',fpl_mach(ijk));

    if(iu==1)
       y_label='Power (in-lbf/sec)'; 
    else
       y_label='Power (W)';    
    end

    [oapow1]=oaspl_function(power_dB1(jf:num,ijk));
    [oapow2]=oaspl_function(power_dB2(jf:num,ijk));
    [oapow3]=oaspl_function(power_dB3(jf:num,ijk));
    [oapow4]=oaspl_function(power_dB4(jf:num,ijk));

    wov1=power_ref*10^(oapow1/10);
    wov2=power_ref*10^(oapow2/10);
    wov3=power_ref*10^(oapow3/10);
    wov4=power_ref*10^(oapow4/10);

    leg1=sprintf('%s  %8.4g W overall',sname_1,wov1);
    leg2=sprintf('%s  %8.4g W overall',sname_2,wov2);
    leg3=sprintf('%s  %8.4g W overall',sname_3,wov3);
    leg4=sprintf('%s  %8.4g W overall',sname_4,wov4);


    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,qqq3,qqq4,leg1,leg2,leg3,leg4,fmin,fmax,md);           
           
end           


qqq1=[fc(jf:num) power1(jf:num,ijk)];
qqq2=[fc(jf:num) power2(jf:num,ijk)];   
qqq3=[fc(jf:num) power3(jf:num,ijk)];
qqq4=[fc(jf:num) power4(jf:num,ijk)]; 

assignin('base', 'power1',qqq1);    
assignin('base', 'power2',qqq2);   
assignin('base', 'power3',qqq3);   
assignin('base', 'power4',qqq4);   


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for ijk=1:nmach  % mach bin

    t_string=sprintf('Loss Factors   Mach %g',fpl_mach(ijk));
    y_label='Loss Factor'; 

    rrr1=[fc total_lf1];
    rrr2=[fc total_lf2];
    rrr3=[fc total_lf3];
    rrr4=[fc total_lf4];

    leg1='total lf 1';
    leg2='total lf 2';
    leg3='total lf 3';
    leg4='total lf 4';


    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,rrr1,rrr2,rrr3,rrr4,leg1,leg2,leg3,leg4,fmin,fmax,md);

           
end
           
           
leg1='clf 12';
leg2='clf 21';
leg3='clf 23';
leg4='clf 32';    
leg5='clf 34';
leg6='clf 43';  
  
t_string='Coupling Loss Factors';
y_label='CLF'; 
           
rrr1=[fc clf_12];
rrr2=[fc clf_21];   

rrr3=[fc clf_23];
rrr4=[fc clf_32]; 

rrr5=[fc clf_34];
rrr6=[fc clf_43]; 

[fig_num,h2]=plot_loglog_function_md_six_h2(fig_num,x_label,...
               y_label,t_string,rrr1,rrr2,rrr3,rrr4,rrr5,rrr6,...
              leg1,leg2,leg3,leg4,leg5,leg6,fmin,fmax,md);
   
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


psd1=zeros(NL,nmach);
psd2=zeros(NL,nmach);
psd3=zeros(NL,nmach);
psd4=zeros(NL,nmach);

nb=1;

for ijk=1:nmach  % mach bin

    out1=sprintf('\n Mach=%g ',fpl_mach(ijk));
    disp(out1);
    
    [psd1(:,ijk),~]=psd_from_spectrum(nb,fc,a1(:,ijk));    
    [psd2(:,ijk),~]=psd_from_spectrum(nb,fc,a2(:,ijk));  
    [psd3(:,ijk),~]=psd_from_spectrum(nb,fc,a3(:,ijk));    
    [psd4(:,ijk),~]=psd_from_spectrum(nb,fc,a4(:,ijk));     
    
    [~,grms1] = calculate_PSD_slopes(fc(jf:num),psd1(jf:num,ijk));
    [~,grms2] = calculate_PSD_slopes(fc(jf:num),psd2(jf:num,ijk));
    [~,grms3] = calculate_PSD_slopes(fc(jf:num),psd3(jf:num,ijk));
    [~,grms4] = calculate_PSD_slopes(fc(jf:num),psd4(jf:num,ijk));    

    
    leg_1{ijk}=sprintf('Mach %g  %7.3g GRMS',fpl_mach(ijk),grms1);
    leg_2{ijk}=sprintf('Mach %g  %7.3g GRMS',fpl_mach(ijk),grms2);   
    leg_3{ijk}=sprintf('Mach %g  %7.3g GRMS',fpl_mach(ijk),grms3);
    leg_4{ijk}=sprintf('Mach %g  %7.3g GRMS',fpl_mach(ijk),grms4);  
    
    
    disp(' ');
    disp(' Power Spectral Density ');
    disp(' ');
    disp('   Freq    PSD 1     PSD 2     PSD 3     PSD 4 ');
    disp('   (Hz)   (G^2/Hz)  (G^2/Hz)   (G^2/Hz)  (G^2/Hz)');
           
    for i=jf:NL
    
        out1=sprintf('  %g    %8.4g  %8.4g  %8.4g  %8.4g',fc(i),psd1(i),psd2(i),psd3(i),psd4(i));
        disp(out1);
    
    end
 

    leg1=sprintf('%s  %7.3g GRMS',sname_1,grms1);
    leg2=sprintf('%s  %7.3g GRMS',sname_2,grms2);
    leg3=sprintf('%s  %7.3g GRMS',sname_3,grms3);
    leg4=sprintf('%s  %7.3g GRMS',sname_4,grms4);   
    
    disp(' ');
    disp(' Overall Levels ');
    disp(' ');   
    out1=sprintf(' %s = %8.4g GRMS',sname_1,grms1);
    disp(out1);
    out2=sprintf(' %s = %8.4g GRMS',sname_2,grms2);
    disp(out2);
    out3=sprintf(' %s = %8.4g GRMS',sname_3,grms3);
    disp(out3);
    out4=sprintf(' %s = %8.4g GRMS',sname_4,grms4);
    disp(out4);      
    
      
    qqq1=[fc(jf:num) psd1(jf:num,ijk)];
    qqq2=[fc(jf:num) psd2(jf:num,ijk)];    
    qqq3=[fc(jf:num) psd3(jf:num,ijk)];
    qqq4=[fc(jf:num) psd4(jf:num,ijk)];
    
    y_label='Accel (G^2/Hz)';
    
    t_string=sprintf('Power Spectral Density  Mach %g',fpl_mach(ijk));
 

    
    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,qqq3,qqq4,leg1,leg2,leg3,leg4,fmin,fmax,md);

end


accel_psd1=[fc(jf:num) psd1(jf:num,:)];
accel_psd2=[fc(jf:num) psd2(jf:num,:)];  
accel_psd3=[fc(jf:num) psd3(jf:num,:)];
accel_psd4=[fc(jf:num) psd4(jf:num,:)]; 

assignin('base', 'accel_psd_1',accel_psd1);
assignin('base', 'accel_psd_2',accel_psd2);   
assignin('base', 'accel_psd_3',accel_psd3);
assignin('base', 'accel_psd_4',accel_psd4);



sz=size(accel_psd1);
 
accel_max_psd1=zeros(sz(1),2);
accel_max_psd2=zeros(sz(1),2);
accel_max_psd3=zeros(sz(1),2);
accel_max_psd4=zeros(sz(1),2);

accel_max_psd1(:,1)=accel_psd1(:,1);
accel_max_psd2(:,1)=accel_psd2(:,1);
accel_max_psd3(:,1)=accel_psd3(:,1);
accel_max_psd4(:,1)=accel_psd4(:,1);

 
for i=1:sz(1)
    accel_max_psd1(i,2)=max(accel_psd1(i,2:sz(2)));
    accel_max_psd2(i,2)=max(accel_psd2(i,2:sz(2)));
    accel_max_psd3(i,2)=max(accel_psd3(i,2:sz(2)));
    accel_max_psd4(i,2)=max(accel_psd4(i,2:sz(2)));    
end


assignin('base', 'accel_psd_max_1',accel_max_psd1);
assignin('base', 'accel_psd_max_2',accel_max_psd2);   
assignin('base', 'accel_psd_max_3',accel_max_psd3);
assignin('base', 'accel_psd_max_4',accel_max_psd4);




%%%%%


x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';


leg=leg_1;
t_string=sprintf('Power Spectral Density  %s',sname_1);
ppp=accel_psd1;
[fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);

leg=leg_2;
t_string=sprintf('Power Spectral Density  %s',sname_2);
ppp=accel_psd2;
[fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);

leg=leg_3;
t_string=sprintf('Power Spectral Density  %s',sname_3);
ppp=accel_psd3;
[fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);

leg=leg_4;
t_string=sprintf('Power Spectral Density  %s',sname_4);
ppp=accel_psd4;
[fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);




md=6;

f=accel_max_psd1(:,1);
a=accel_max_psd1(:,2);
[~,grms1] = calculate_PSD_slopes(f,a);

f=accel_max_psd2(:,1);
a=accel_max_psd2(:,2);
[~,grms2] = calculate_PSD_slopes(f,a);

f=accel_max_psd3(:,1);
a=accel_max_psd3(:,2);
[~,grms3] = calculate_PSD_slopes(f,a);

f=accel_max_psd4(:,1);
a=accel_max_psd4(:,2);
[~,grms4] = calculate_PSD_slopes(f,a);



t_string=sprintf('PSD Max  %s  %7.3g GRMS',sname_1,grms1);
ppp=accel_max_psd1;
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    


t_string=sprintf('PSD Max  %s  %7.3g GRMS',sname_2,grms2);
ppp=accel_max_psd2;
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md); 


t_string=sprintf('PSD Max  %s  %7.3g GRMS',sname_3,grms3);
ppp=accel_max_psd3;
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md); 

t_string=sprintf('PSD Max  %s  %7.3g GRMS',sname_4,grms4);
ppp=accel_max_psd4;
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md); 


%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('  Ring Frequencies ');
disp(' ');
out1=sprintf('%s  %8.4g Hz',sname_1,fring1);
out2=sprintf('%s  %8.4g Hz',sname_2,fring2);
out3=sprintf('%s  %8.4g Hz',sname_3,fring3);
out4=sprintf('%s  %8.4g Hz',sname_4,fring4);
disp(out1);
disp(out2);
disp(out3);
disp(out4);

out1=sprintf('\n %s',sname_1);
disp(out1);
display_shear_frequencies(f11,f12);

out1=sprintf('\n %s',sname_2);
disp(out1);
display_shear_frequencies(f21,f22);

out1=sprintf('\n %s',sname_3);
disp(out1);
display_shear_frequencies(f31,f32);

out1=sprintf('\n %s',sname_4);
disp(out1);
display_shear_frequencies(f41,f42);

for i=1:4

    if(i==1)
        out11=sprintf('\n %s',sname_1);
    end
    if(i==2)
        out11=sprintf('\n %s',sname_2);
    end
    if(i==3)
        out11=sprintf('\n %s',sname_3);
    end
    if(i==4)
        out11=sprintf('\n %s',sname_4);
    end       
    
    disp(out11);
    
    
    out1=sprintf(' Mass per area = %8.4g kg/m^2',mpa(i));
    out2=sprintf('               = %8.4g lbm/ft^2',mpa(i)*0.20485 );
    out3=sprintf('               = %8.4g lbm/in^2',mpa(i)*0.0014226 );
    disp(out1);
    disp(out2);
    disp(out3);

end


disp(' ');
for j=1:nmach
    out1=sprintf(' Mach=%g rho_c=%8.4g  gas_md=%8.4g  gas_c=%8.4g  Uc=%8.4g ',fpl_mach(j),rho_c(j),gas_md(j),gas_c(j),Uc(j));
    disp(out1);
end
disp(' ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Output Arrays:');

disp(' ');
disp(' Modal Density:  mph1, mph2, mph3, mph4');
disp(' ');
disp(' Radiation Efficiency:  rad_eff1, rad_eff2, rad_eff3, rad_eff4');
disp(' ');
disp(' Power:  power1, power2, power3, power4 ');

disp(' ');
disp(' Power Spectra:   vel_ps_1,   vel_ps_2,   vel_ps_3,   vel_ps_4');        
disp('                accel_ps_1, accel_ps_2, accel_ps_3, accel_ps_4');    

disp(' ');
disp(' Power Spectral Densities:'); 
disp('      accel_psd_1,     accel_psd_2,     accel_psd_3,     accel_psd_4');
disp('  accel_psd_max_1, accel_psd_max_2, accel_psd_max_3, accel_psd_max_4');    


    
msgbox('Results written to Command Window');



           


function change(hObject, eventdata, handles)

iu=get(handles.listbox_units,'Value');

%
 
set(handles.text_a1,'Visible','on');
set(handles.text_a2,'Visible','on');
set(handles.edit_a1,'Visible','on');
set(handles.edit_a2,'Visible','on');    

%%%%%%%%%%%%%   

if(iu==1)
    sss='Trajectory Array with two columns:  Altitude (ft) & Mach';
else
    sss='Trajectory Array with two columns:  Altitude (km) & Mach';        
end

set(handles.text_mach_altitude,'String',sss);


function edit_trajectory_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trajectory_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trajectory_array as text
%        str2double(get(hObject,'String')) returns contents of edit_trajectory_array as a double


% --- Executes during object creation, after setting all properties.
function edit_trajectory_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trajectory_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_read_FPL.
function pushbutton_read_FPL_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_FPL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

read_special(hObject, eventdata, handles);


THM1=getappdata(0,'THM1');

sz1=size(THM1);

Nrows=sz1(2)-1;

Ncolumns=1;

cn={'Mach'};

set(handles.uitable_mach,'Data',cell(Nrows,Ncolumns),'ColumnName',cn);

set(handles.uipanel_mach_number,'Visible','on');




function read_special(hObject, eventdata, handles)

AA=get(handles.uitable_names,'Data');

setappdata(0,'AA',AA);

sname_1=char(AA{1,1});
sname_2=char(AA{2,1});
sname_3=char(AA{3,1});
sname_4=char(AA{4,1});

setappdata(0,'sname_1',sname_1);
setappdata(0,'sname_2',sname_2);
setappdata(0,'sname_3',sname_3);
setappdata(0,'sname_4',sname_4);


FPL_name_1=strtrim(char(AA{1,2}));
FPL_name_2=strtrim(char(AA{2,2}));
FPL_name_3=strtrim(char(AA{3,2}));
FPL_name_4=strtrim(char(AA{4,2}));


try
    THM1=evalin('base',FPL_name_1);
catch
    warndlg('FPL_name_1 not found ');
    return;
end
try
    THM2=evalin('base',FPL_name_2);
catch
    warndlg('FPL_name_2 not found ');
    return;
end
try
    THM3=evalin('base',FPL_name_3);
catch
    warndlg('FPL_name_3 not found ');
    return;
end
try
    THM4=evalin('base',FPL_name_4);
catch
    warndlg('FPL_name_4 not found ');
    return;
end

sz1=size(THM1);
sz2=size(THM2);
sz3=size(THM3);
sz4=size(THM4);

if(sz1(1)~=sz2(1) || sz1(1)~=sz3(1) || sz1(1)~=sz4(1) )
    warndlg('Input FPLs must have same number of rows');
    return;
end
if(sz1(2)~=sz2(2) || sz1(2)~=sz3(2) || sz1(2)~=sz4(2) )
    warndlg('Input FPLs must have same number of columns');
    return;
end

for i=1:sz1(1)
   if(THM1(i,1)~=THM2(i,1) || THM1(i,1)~=THM3(i,1) || THM1(i,1)~=THM4(i,1))
        warndlg('Inputs FPLs must have same frequency column');
        return;
   end
end


setappdata(0,'THM1',THM1);
setappdata(0,'THM2',THM2);
setappdata(0,'THM3',THM3);
setappdata(0,'THM4',THM4);


% --- Executes on key press with focus on uitable_names and none of its controls.
function uitable_names_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_names (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_mach_number,'Visible','off');
