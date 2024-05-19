function varargout = SEA_one_cylindrical_shell_power_comp(varargin)
% SEA_ONE_CYLINDRICAL_SHELL_POWER_COMP MATLAB code for SEA_one_cylindrical_shell_power_comp.fig
%      SEA_ONE_CYLINDRICAL_SHELL_POWER_COMP, by itself, creates a new SEA_ONE_CYLINDRICAL_SHELL_POWER_COMP or raises the existing
%      singleton*.
%
%      H = SEA_ONE_CYLINDRICAL_SHELL_POWER_COMP returns the handle to a new SEA_ONE_CYLINDRICAL_SHELL_POWER_COMP or the handle to
%      the existing singleton*.
%
%      SEA_ONE_CYLINDRICAL_SHELL_POWER_COMP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_ONE_CYLINDRICAL_SHELL_POWER_COMP.M with the given input arguments.
%
%      SEA_ONE_CYLINDRICAL_SHELL_POWER_COMP('Property','Value',...) creates a new SEA_ONE_CYLINDRICAL_SHELL_POWER_COMP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_one_cylindrical_shell_power_comp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_one_cylindrical_shell_power_comp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_one_cylindrical_shell_power_comp

% Last Modified by GUIDE v2.5 25-Sep-2018 16:17:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_one_cylindrical_shell_power_comp_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_one_cylindrical_shell_power_comp_OutputFcn, ...
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


% --- Executes just before SEA_one_cylindrical_shell_power_comp is made visible.
function SEA_one_cylindrical_shell_power_comp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_one_cylindrical_shell_power_comp (see VARARGIN)

% Choose default command line output for SEA_one_cylindrical_shell_power_comp
handles.output = hObject;

clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fstr='one_system_sea_alt_small.jpg';
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

change(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','on');

set(handles.listbox_acoustic_field,'Value',1);

try
    naf=getappdata(0,'naf');
    if(isempty(naf))
    else    
        set(handles.listbox_acoustic_field,'Value',naf);
    end
catch
end

try
    alt=getappdata(0,'altitude_orig');
    if(isempty(alt))
    else    
        ss=sprintf('%9.5g',alt);
        set(handles.edit_altitude,'String',ss);
    end
catch
end

try
    alt=getappdata(0,'altitude_orig');
    if(isempty(alt))
    else    
        ss=sprintf('%9.5g',alt);
        set(handles.edit_altitude,'String',ss);
    end
catch
end


try
    mach=getappdata(0,'mach');
    if(isempty(mach))
    else    
        ss=sprintf('%9.5g',mach);
        set(handles.edit_mach,'String',ss);
    end
catch
end


try
    ax=getappdata(0,'ax');
    if(isempty(ax))
    else    
        ss=sprintf('%9.5g',a1);
        set(handles.edit_ax,'String',ss);
    end
catch
end

try
    az=getappdata(0,'az');
    if(isempty(az))
    else    
        ss=sprintf('%9.5g',a2);
        set(handles.edit_az,'String',ss);
    end
catch
end

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_one_cylindrical_shell_power_comp wait for user response (see UIRESUME)
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



function edit_az_Callback(hObject, eventdata, handles)
% hObject    handle to edit_az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_az as text
%        str2double(get(hObject,'String')) returns contents of edit_az as a double


% --- Executes during object creation, after setting all properties.
function edit_az_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ax as text
%        str2double(get(hObject,'String')) returns contents of edit_ax as a double


% --- Executes during object creation, after setting all properties.
function edit_ax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ax (see GCBO)
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
function varargout = SEA_one_cylindrical_shell_power_comp_OutputFcn(hObject, eventdata, handles) 
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

delete(SEA_one_cylindrical_shell_power_comp);


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
    A = imread('Corcos_TBL.jpg');
end
if(n==6)
    A = imread('re_cylinder.jpg');
end
if(n==7)
    A = imread('Cylinder_md.jpg');  
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

iu=get(handles.listbox_units,'Value');

if(iu==1)
    data{1,1}='Length (in)';
    data{2,1}='Diameter (in)';
    data{3,1}='Thickness (in)';
else
    data{1,1}='Length (m)';
    data{2,1}='Diameter (m)';
    data{3,1}='Thickness (mm)';    
end

data{1,2}=' ';
data{2,2}=' ';
data{3,2}=' ';

cn={'Parameter','Value'};
 
set(handles.uitable_geometry,'Data',data,'ColumnName',cn);

listbox_material_Callback(hObject, eventdata, handles);


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

handles.s=SEA_one_geometry;
set(handles.s,'Visible','on');



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


% --- Executes on button press in pushbutton_SPL.
function pushbutton_SPL_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SPL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_acoustic_field,'Value');

if(n==1)
    handles.s=SEA_one_cylindrical_shell_SPL;
else
    handles.s=SEA_one_cylindrical_shell_SPL;  
end
    
set(handles.s,'Visible','on');


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
    SEA_one_shell=evalin('base','SEA_one_shell');
catch
   warndlg(' evalin failed ');
   return;
end
 
SEA_one_shell
 
disp(' ref 4');
 
%%%

try
    iu=SEA_one_shell.iu;      
    set(handles.listbox_units,'Value',iu);  
catch
end 

try
    material=SEA_one_shell.material;    
    set(handles.listbox_material,'Value',material);
catch
end
 
try
    gas=SEA_one_shell.gas;    
    set(handles.listbox_gas,'Value',gas);
catch
end
 
try
    naf=SEA_one_shell.naf;    
    set(handles.listbox_acoustic_field,'Value',naf);
catch
end
  
change(hObject, eventdata, handles);

%%%%%%%

try
    listbox_q=SEA_one_shell.q;       
    setappdata(0,'listbox_q',listbox_q); 
catch
end   

%%%%%%%%%%%  

try
    SPL_three=SEA_one_shell.SPL_three;    
    setappdata(0,'SPL_three',SPL_three);       
catch
end   

try
    SPL_three_name=SEA_one_shell.SPL_three_name;     
    setappdata(0,'SPL_three_name',SPL_three_name);      
catch
end  

try
    assignin('base',SPL_three_name,SPL_three); % fix here
catch
end  


%%%%%%%%%%%  

try
    SPL_two=SEA_one_shell.SPL_two;    
    setappdata(0,'SPL_two',SPL_two);       
catch
end   


try
    SPL_two_name=SEA_one_shell.SPL_two_name;      
    setappdata(0,'SPL_two_name',SPL_two_name);     
catch
end  

try
    assignin('base',SPL_two_name,SPL_two); % fix here
catch
end  

%%%%%%%%%%%  

try
    uniform=SEA_one_shell.uniform;      
    setappdata(0,'uniform',uniform);      
catch
end 

%%%%%%%


try
    AG=SEA_one_shell.AG;    
    set(handles.uitable_geometry,'Data',AG);
catch
end
 
try
    AM=SEA_one_shell.AM;      
    set(handles.uitable_material,'Data',AM);
catch 
end

try
    name=SEA_one_shell.name;    
    set(handles.edit_name,'String',name);      
catch
end

try
    fstart=SEA_one_shell.fstart;    
    sss=sprintf('%g',fstart);
    set(handles.edit_fstart,'String',sss);      
catch
end
 
try
    fend=SEA_one_shell.fend;  
    sss=sprintf('%g',fend);    
    set(handles.edit_fend,'String',sss);      
catch
end

try
    altitude_orig=SEA_one_shell.altitude_orig;
    sss=sprintf('%g',altitude_orig);
    set(handles.edit_altitude,'String',sss); 
catch
end

try
    gas_md=SEA_one_shell.gas_md;    
    sss=sprintf('%g',gas_md);
    set(handles.edit_gas_md,'String',sss);    
catch
end

try
    gas_c=SEA_one_shell.gas_c;    
    sss=sprintf('%g',gas_c);
    set(handles.edit_c,'String',sss);        
catch
end

try
    mach=SEA_one_shell.mach;    
    sss=sprintf('%g',mach);
    set(handles.edit_mach,'String',sss);      
catch
end

try
    ax=SEA_one_shell.ax;   
    sss=sprintf('%g',ax);    
    set(handles.edit_ax,'String',sss);     
catch
end
 
try
    az=SEA_one_shell.az;  
    sss=sprintf('%g',az);     
    set(handles.edit_az,'String',sss); 
catch
end





%%%

msgbox('Load Complete');

%%%%



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    q=getappdata(0,'listbox_q');
    SEA_one_shell.q=q;
    out1=sprintf('q=%d',q);
    disp(out1);
catch
    disp('no q');
end    


try
    uniform=getappdata(0,'uniform');
    SEA_one_shell.uniform=uniform;        
catch
end    


try
    SPL_three=getappdata(0,'SPL_three');
    SEA_one_shell.SPL_three=SPL_three;       
catch
end  

try
    SPL_two=getappdata(0,'SPL_two');
    SEA_one_shell.SPL_two=SPL_two;     
catch
end    

try
    SPL_three_name=getappdata(0,'SPL_three_name');
    SEA_one_shell.SPL_three_name=SPL_three_name;       
catch
end    

try
    SPL_two_name=getappdata(0,'SPL_two_name');
    SEA_one_shell.SPL_two_name=SPL_two_name;       
catch
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    iu=get(handles.listbox_units,'Value');
    SEA_one_shell.iu=iu;    
catch
end 



try
    AG=get(handles.uitable_geometry,'Data');
    SEA_one_shell.AG=AG;
catch
end

try
    AM=get(handles.uitable_material,'Data');
    SEA_one_shell.AM=AM;    
catch 
end


try
    name=get(handles.edit_name,'String');      
    SEA_one_shell.name=name;
catch
end


try
    fstart=str2num(get(handles.edit_fstart,'String'));      
    SEA_one_shell.fstart=fstart;
catch
end

try
    fend=str2num(get(handles.edit_fend,'String'));      
    SEA_one_shell.fend=fend;
catch
end


try
    material=get(handles.listbox_material,'Value');
    SEA_one_shell.material=material;
catch
end

try
    gas=get(handles.listbox_gas,'Value');
    SEA_one_shell.gas=gas;
catch
end


try
    naf=get(handles.listbox_acoustic_field,'Value');
    SEA_one_shell.naf=naf;
catch
end

try
    altitude_orig=str2num(get(handles.edit_altitude,'String')); 
    SEA_one_shell.altitude_orig=altitude_orig;
catch
end

try
    mach=str2num(get(handles.edit_mach,'String'));      
    SEA_one_shell.mach=mach;
catch
end

try
    ax=str2num(get(handles.edit_ax,'String'));     
    SEA_one_shell.ax=ax;
catch
end

try
    az=str2num(get(handles.edit_az,'String')); 
    SEA_one_shell.az=az;
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    gas_c=str2num(get(handles.edit_c,'String'));        
    SEA_one_shell.gas_c=gas_c;
catch
end
 
try
    gas_md=str2num(get(handles.edit_gas_md,'String'));    
    SEA_one_shell.gas_md=gas_md;
catch
end
 
 
 
% % %
 
structnames = fieldnames(SEA_one_shell, '-full'); % fields in the struct
 
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'SEA_one_shell'); 
 
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

disp('    ');
disp(' * * * * * * ');
disp('    ');

fig_num=1;
setappdata(0,'fig_num',1);

tpi=2*pi;

num_seg=1;

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

iu=get(handles.listbox_units,'Value');
setappdata(0,'iu',iu);
iuo=iu;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,meters_per_inch]=length_unit_conversion();
[kgpm3_per_lbmpft3,kgpm3_per_lbmpin3]=mass_per_volume_unit_conversion();
[~,Pa_per_psi]=pressure_unit_conversion2();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AG=get(handles.uitable_geometry,'Data');

AM=get(handles.uitable_material,'Data');
 
   E=zeros(num_seg,1);
 rho=zeros(num_seg,1);
  mu=zeros(num_seg,1);
   L=zeros(num_seg,1);
diam=zeros(num_seg,1);
   h=zeros(num_seg,1);
 
   
for i=1:num_seg
 
    try
         E(i)=str2num(char(AM{1,2}));      
       rho(i)=str2num(char(AM{2,2}));  
        mu(i)=str2num(char(AM{3,2}));  
    catch
        warndlg('Enter material properties');
        return; 
    end    
    
    try
          L(i)=str2num(char(AG{1,2}));      
       diam(i)=str2num(char(AG{2,2}));  
          h(i)=str2num(char(AG{3,2}));  
    catch
         warndlg('Enter geometry');
         return; 
    end

    if(iu==1)  % convert English to metric
    
        rho(i)=rho(i)*kgpm3_per_lbmpin3;
        h(i)=h(i)*meters_per_inch;
        L(i)=L(i)*meters_per_inch;
        diam(i)=diam(i)*meters_per_inch;
        E(i)=E(i)*Pa_per_psi;
    else
        [E(i)]=GPa_to_Pa(E(i));
        h(i)=h(i)/1000;
    end

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sname=get(handles.edit_name,'String');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

naf=get(handles.listbox_acoustic_field,'Value');
setappdata(0,'naf',naf);




    fs_velox=0;
    mach=0;
    altitude=0;
    ax=0;
    az=0;
    setappdata(0,'altitude_orig',altitude);    
    
    ng=get(handles.listbox_gas,'Value');
    gas_c_daf=str2num(get(handles.edit_c,'String')); 
    gas_md_daf=str2num(get(handles.edit_gas_md,'String'));    
    

    
    ng=1;
    mach=str2num(get(handles.edit_mach,'String'));
    altitude=str2num(get(handles.edit_altitude,'String'));
    
    if(isempty(mach))
        warndlg('Enter mach');
        return;
    end
    if(isempty(altitude))
        warndlg('Enter altitude');
        return;
    end
    
    setappdata(0,'altitude_orig',altitude);

    [~,mass_dens,~,~,sound_speed]=atmopheric_properties(altitude,iu);
    
    fs_velox=mach*sound_speed;

    gas_md_tbl=mass_dens;
    gas_c_tbl=sound_speed;
    
%%    gammax=getappdata(0,'gammax');
%%    gamma_3=getappdata(0,'gamma_3');
%%    delta_star=getappdata(0,'delta_star');
%%    Reynolds=getappdata(0,'Reynolds');
    
    ax=str2num(get(handles.edit_ax,'String'));
    az=str2num(get(handles.edit_az,'String'));
    



setappdata(0,'mach',mach);
setappdata(0,'ax',ax);
setappdata(0,'az',ax);

setappdata(0,'ng',ng);
setappdata(0,'gas_c_orig',gas_c_daf);
setappdata(0,'gas_md_orig',gas_md_daf);
setappdata(0,'fs_velox',fs_velox);


if(iu==1)  % convert English to metric
   
   gas_c_daf=gas_c_daf*12;
   gas_c_daf=gas_c_daf*meters_per_inch;
   gas_md_daf=gas_md_daf*kgpm3_per_lbmpft3;
   
   gas_c_tbl=gas_c_tbl*12;
   gas_c_tbl=gas_c_tbl*meters_per_inch;
   gas_md_tbl=gas_md_tbl*kgpm3_per_lbmpft3;
   
end


fs_velox=mach*gas_c_tbl;  % m/sec

%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
   THM=getappdata(0,'SPL_three');
catch
   warndlg('Enter SPL'); 
   return;     
end
    
if(isempty(THM))
   warndlg('Enter SPL'); 
   return; 
end    

freq=THM(:,1);
fc=freq;

dB(:,1)=THM(:,2);
lf(:,1)=THM(:,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% bc=get(handles.listbox_bc,'Value');
bc=4;   % simply supported at each end


fstart=str2num(get(handles.edit_fstart,'String')); 

if(isempty(fstart))
   warndlg(' Enter output starting frequency '); 
   return; 
end    

fend=str2num(get(handles.edit_fend,'String')); 

if(isempty(fend))
   warndlg(' Enter output ending frequency '); 
   return; 
end    

setappdata(0,'fstart_orig',fstart);
setappdata(0,'fend_orig',fend);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iu=2;

c_daf=gas_c_daf;
rho_c_daf=gas_md_daf*gas_c_daf;

c_tbl=gas_c_tbl;
rho_c_tbl=gas_md_tbl*gas_c_tbl;


num=length(fc);

fl=zeros(num,1);
fu=zeros(num,1);

for i=1:num
   fl(i)=fc(i)*(1/2^(1/6)); 
   fu(i)=fl(i)*2^(1/3);
end

    K=zeros(num_seg,1);
    D=zeros(num_seg,1);
fring=zeros(num_seg,1);
  fcr=zeros(num_seg,1);
  mpa=zeros(num_seg,1);
   Ap=zeros(num_seg,1);
 mass=zeros(num_seg,1);
    m=zeros(num_seg,1);
    rad_eff=zeros(num,num_seg);
        mph=zeros(num,num_seg);
    
mmax=400;
nmax=400;    

for i=1:num_seg
    
    [D(i),K(i),mpa(i),fcr(i),fring(i),~]=cylinder_properties_wave(E(i),mu(i),h(i),diam(i),rho(i),gas_c_daf);

    Ap(i)=L(i)*pi*diam(i);
    mass(i)=mpa(i)*Ap(i);
    m(i)=mass(i);

   [~,mph(:,i)]=...
        re_cylinder_engine(D(i),K(i),mu(i),diam(i),L(i),mpa(i),bc,mmax,nmax,gas_c_daf,fcr(i),fring(i),fc,fl,fu);   

   for j=1:num 
        [rad_eff(j,i)]=cylinder_rad_eff(fc(j),fcr(i),fring(i),L(i),diam(i),c_daf,mu(i));  
   end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

jf=1;
jg=1;

for ijk=1:num_seg

    for i=(num-2):-1:1
        if(mph(i,ijk)<1.e-20  || rad_eff(i,ijk)<1.e-20  ||fc(i)<fstart ) 
            jf=i+1;
            disp(' break 1');
            break;
        end
    end

end

for ijk=1:num_seg
    
    for i=(num-2):-1:1
    
        if(mph(i,ijk)<1.e-20  || rad_eff(i,ijk)<1.e-20  )
            jg=i+1;
            disp(' break 2');
            break;
        end
    end
end

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

freq=THM(:,1);
fc=freq;


n_type=1;

if(naf==1)
    [fig_num]=spl_plot_nd(fig_num,n_type,freq,dB(:,1));    
else
    [fig_num]=fpl_plot_nd(fig_num,n_type,freq,dB(:,1));      
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_label='Center Frequency (Hz)';
y_label='Ratio';
t_string='Radiation Efficiency';

md=3;

ppp=[fc(jg:num) rad_eff(jg:num,1)];

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);     

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha=2^(1/6)-1/2^(1/6);

k=1;

num_modes=zeros((num-jg+1),num_seg);  

fnm=zeros((num-jg+1),1);

for ijk=1:num_seg
    for i=jg:num
    
        bw=fc(i)*alpha;
    
        fnm(k)=fc(i);
    
        num_modes(k,ijk)=mph(i,ijk)*bw;
      
        k=k+1;
    
    end
end

data=[fnm num_modes(:,1)];

xlabel='Center Frequency (Hz)';
ylabel='Modes';

t_string=sprintf('Number of Modes in Band  %s',sname);

[fig_num]=plot_one_onethird_bar(fig_num,xlabel,ylabel,data,t_string);                                 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp=[fc(jg:num) mph(jg:num,1)];


x_label='Center Frequency (Hz)';
y_label='n (modes/Hz)';
t_string='Modal Density';

md=3;

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fstart,fend,md);           
           
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('   Modal Density (modes/Hz)');
disp(' ');
disp('   fc(Hz)   mph');
disp(' ');

for i=1:num    
    out1=sprintf('%7.1f  %8.4g',fc(i),mph(i,1));
    disp(out1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   power_daf=zeros(num,num_seg);
power_dB_daf=zeros(num,num_seg);

   power_tbl=zeros(num,num_seg);
power_dB_tbl=zeros(num,num_seg);

power_ratio_dB=zeros(num,num_seg);




Uc=0.8*fs_velox;


disp(' ');

ik=1;

for ijk=1:num_seg
    
    for i=1:num    
    
        % diffuse
        
        [power_daf(i,ijk),power_dB_daf(i,ijk)]=power_from_spl_dB(fc(i),dB(i,ijk),mph(i,ijk),c_daf,mpa(ijk),rad_eff(i,ijk));    
    
        % TBL
         
        [power_tbl(i,ijk),power_dB_tbl(i,ijk)]=power_from_TBL_spl_dB(fc(i),dB(i,ijk),mpa(ijk),Ap(ijk),L(ijk),diam(ijk),Uc,ax,az,D(ijk));
        
        if(fc(i)==1000)
            out1=sprintf('%8.4g %8.4g %8.4g %8.4g %8.4g %8.4g',power_dB_daf(i,ijk),dB(i,ijk),mph(i,ijk),c_daf,mpa(ijk),rad_eff(i,ijk));
            disp(out1);
            out1=sprintf('%8.4g %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g',power_dB_tbl(i,ijk),dB(i,ijk),mpa(ijk),Ap(ijk),L(ijk),diam(ijk),Uc,ax,az,D(ijk));
            disp(out1);
            out1=sprintf('%8.4g %8.4g ',power_tbl(i,ijk),power_daf(i,ijk));
            disp(out1);
        end
        
        power_ratio_dB(i,ijk)=-power_dB_tbl(i,ijk)+power_dB_daf(i,ijk);

    
    if(fc(i)>=fstart && fc(i)<=fend)
    
        trans_daf(ik,:)=[fc(i)  power_dB_daf(i,1)-dB(i,1)];
        trans_tbl(ik,:)=[fc(i)  power_dB_tbl(i,1)-dB(i,1)];
        
        ik=ik+1;
        
    end
    
        end
end





assignin('base', 'trans_daf',trans_daf);
assignin('base', 'trans_tbl',trans_tbl);


assignin('base', 'power_ratio_dB',power_ratio_dB);


disp(' ');
disp('   fc    TBL    DAF   Power Ratio ');
disp('  (Hz)  (dB)    (dB)   (dB)       ');


for i=1:num    
    out1=sprintf('%7.1f  %6.1f  %6.1f  %6.1f',fc(i),power_dB_tbl(i,1),power_dB_daf(i,1),power_ratio_dB(i,1));
    disp(out1);
end

data=[fc power_ratio_dB(:,1)];

sz=size(data);

num=sz(1);

for i=num:-1:1
    if(fc(i)>=fstart && fc(i)<=fend)
    else
        data(i,:)=[];
    end
end


xlab='Center Frequency (Hz)';
ylab='Difference (dB)';

t_string='Input Power Difference:  DAF-TBL'; 


[fig_num]=plot_one_onethird_bar_loglin(fig_num,xlab,ylab,data,t_string);


 
%%%%%%%%%%%%%%%


disp(' ');
disp('  Ring Frequency ');
disp(' ');
out1=sprintf('%s  %8.4g Hz',sname,fring(1));
disp(out1);


disp(' ');


for i=1:num_seg

    out1=sprintf('\n Subsystem %d ',i);
    disp(out1);
    out1=sprintf(' Mass per area = %8.4g kg/m^2',mpa(i));
    out2=sprintf('               = %8.4g lbm/ft^2',mpa(i)*0.20485 );
    out3=sprintf('               = %8.4g lbm/in^2',mpa(i)*0.0014226 );
    disp(out1);
    disp(out2);
    disp(out3);

end


    
msgbox('Results written to Command Window');



           


function change(hObject, eventdata, handles)

iu=get(handles.listbox_units,'Value');
ng=get(handles.listbox_gas,'Value');

naf=get(handles.listbox_acoustic_field,'Value');

%

if(naf==1)  % diffuse
    set(handles.text_mach,'Visible','off');
    set(handles.text_altitude,'Visible','off');
    set(handles.edit_mach,'Visible','off');
    set(handles.edit_altitude,'Visible','off');
    set(handles.edit_c,'Enable','on');   
    set(handles.edit_gas_md,'Enable','on');
    set(handles.text_ax,'Visible','off');
    set(handles.text_az,'Visible','off');
    set(handles.edit_ax,'Visible','off');
    set(handles.edit_az,'Visible','off');
    set(handles.text_Corcos,'Visible','off');
else
    set(handles.text_mach,'Visible','on');
    set(handles.text_altitude,'Visible','on');
    set(handles.edit_mach,'Visible','on');
    set(handles.edit_altitude,'Visible','on');    
    set(handles.edit_c,'Enable','off');   
    set(handles.edit_gas_md,'Enable','off');   
    set(handles.text_ax,'Visible','on');
    set(handles.text_az,'Visible','on');
    set(handles.edit_ax,'Visible','on');
    set(handles.edit_az,'Visible','on'); 
    set(handles.text_Corcos,'Visible','on');    
end


set(handles.text_mach,'Visible','on');
set(handles.text_altitude,'Visible','on');
set(handles.edit_mach,'Visible','on');
set(handles.edit_altitude,'Visible','on');    
set(handles.edit_c,'Enable','on');   
set(handles.edit_gas_md,'Enable','on');   
set(handles.text_ax,'Visible','on');
set(handles.text_az,'Visible','on');
set(handles.edit_ax,'Visible','on');
set(handles.edit_az,'Visible','on'); 
set(handles.text_Corcos,'Visible','on');  


set(handles.edit_c,'String',' ');   
set(handles.edit_gas_md,'String',' ');  

%%%%%%%%%%%%%   

if(iu==1)
    
    set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)'); 
    set(handles.text_gas_md,'String','Gas Mass Density (lbm/ft^3)');
    set(handles.text_altitude,'String','Altitude (ft)');
    
    if(ng==1 && naf==1)
        set(handles.edit_c,'String','1125');
        set(handles.edit_gas_md,'String','0.076487');       
    end
    
else
    
    set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
    set(handles.text_gas_md,'String','Gas Mass Density (kg/m^3)'); 
    set(handles.text_altitude,'String','Altitude (km)');
        
    if(ng==1 && naf==1)
        set(handles.edit_c,'String','343');  
        set(handles.edit_gas_md,'String','1.225');                   
    end    
   
end



function edit_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name as text
%        str2double(get(hObject,'String')) returns contents of edit_name as a double


% --- Executes during object creation, after setting all properties.
function edit_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double


% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L as text
%        str2double(get(hObject,'String')) returns contents of edit_L as a double


% --- Executes during object creation, after setting all properties.
function edit_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_D_Callback(hObject, eventdata, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_D as text
%        str2double(get(hObject,'String')) returns contents of edit_D as a double


% --- Executes during object creation, after setting all properties.
function edit_D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material


iu=get(handles.listbox_units,'Value');

imat=get(handles.listbox_material,'Value');


if(iu==1)
    data{1,1}='Elastic Modulus (psi)';
    data{2,1}='Mass Density (lbm/in^3)';
else
    data{1,1}='Elastic Modulus (GPa)';
    data{2,1}='Mass Density (kg/m^3)';  
end

data{3,1}='Poisson Ratio';

if(imat<=6)  

    [elastic_modulus,mass_density,poisson]=six_materials(iu,imat);
    
    data{1,2} =sprintf('%g',elastic_modulus);
    data{2,2} =sprintf('%g',mass_density); 
    data{3,2} =sprintf('%g',poisson);    
    
else
    
    data{1,2}=' ';
    data{2,2}=' ';
    data{3,2}=' ';

end    



cn={'Parameter','Value'};
 
set(handles.uitable_material,'Data',data,'ColumnName',cn);



% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_em_Callback(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_em as text
%        str2double(get(hObject,'String')) returns contents of edit_em as a double


% --- Executes during object creation, after setting all properties.
function edit_em_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md as text
%        str2double(get(hObject,'String')) returns contents of edit_md as a double


% --- Executes during object creation, after setting all properties.
function edit_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
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


% --- Executes on key press with focus on uitable_geometry and none of its controls.
function uitable_geometry_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_geometry (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uitable_geometry_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uitable_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in uitable_geometry.
function uitable_geometry_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_geometry (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in uitable_geometry.
function uitable_geometry_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable_geometry (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)



function edit_fend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fend as text
%        str2double(get(hObject,'String')) returns contents of edit_fend as a double


% --- Executes during object creation, after setting all properties.
function edit_fend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
