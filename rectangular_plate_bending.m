function varargout = rectangular_plate_bending(varargin)
% RECTANGULAR_PLATE_BENDING MATLAB code for rectangular_plate_bending.fig
%      RECTANGULAR_PLATE_BENDING, by itself, creates a new RECTANGULAR_PLATE_BENDING or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_PLATE_BENDING returns the handle to a new RECTANGULAR_PLATE_BENDING or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_PLATE_BENDING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_PLATE_BENDING.M with the given input arguments.
%
%      RECTANGULAR_PLATE_BENDING('Property','Value',...) creates a new RECTANGULAR_PLATE_BENDING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_plate_bending_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_plate_bending_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_plate_bending

% Last Modified by GUIDE v2.5 27-Jul-2021 09:52:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_plate_bending_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_plate_bending_OutputFcn, ...
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


% --- Executes just before rectangular_plate_bending is made visible.
function rectangular_plate_bending_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_plate_bending (see VARARGIN)

% Choose default command line output for rectangular_plate_bending
handles.output = hObject;

handles.elastic_modulus=0;
handles.mass_density=0;
handles.poisson=0;

handles.NSM=0;

handles.total_mass=0;

handles.length=0;
handles.width=0;
handles.thickness=0;

handles.material=1;
handles.unit=1;

handles.leftBC=1;
handles.topBC=1;
handles.rightBC=1;
handles.bottomBC=1;

set(handles.Answer,'Enable','off');
set(handles.NSMeditbox,'String','0');

clc;
bg = imread('plate_image.jpg');
image(bg);
axis off; 

guidata(hObject, handles);




material_change(hObject, eventdata, handles);






% --- Outputs from this function are returned to the command line.
function varargout = rectangular_plate_bending_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in unitlistbox.
function unitlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to unitlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unitlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unitlistbox
clear_answer(hObject, eventdata, handles);

handles.unit=get(hObject,'Value');

if(handles.unit==1)
   set(handles.elasticmodulustext,'String','Elastic Modulus (psi)');
   set(handles.massdensitytext,'String','Mass Density (lbm/in^3)');
   set(handles.NSMmasslabel,'String','Nonstructural Mass (lbm)');
   set(handles.totalmasslabel,'String','Total Mass (lbm)');   
   set(handles.widthtext,'String','Width(in)');
   set(handles.lengthtext,'String','Length(in)'); 
   set(handles.thicknesstext,'String','Thickness(in)'); 
   set(handles.text_plate_stiffness_D,'String','Bending Stiffness (lbf-in)'); 
else
   set(handles.elasticmodulustext,'String','Elastic Modulus (GPa)'); 
   set(handles.massdensitytext,'String','Mass Density (kg/m^3)');
   set(handles.NSMmasslabel,'String','Nonstructural Mass (kg)');
   set(handles.totalmasslabel,'String','Total Mass (kg)'); 
   set(handles.widthtext,'String','Width(mm)');
   set(handles.lengthtext,'String','Length(mm)'); 
   set(handles.thicknesstext,'String','Thickness(mm)'); 
   set(handles.text_plate_stiffness_D,'String','Bending Stiffness (N-m)');    
end

if(handles.material==5)
    set(handles.elasticmoduluseditbox,'String',' ');
    set(handles.massdensityeditbox,'String',' ');  
    set(handles.poissoneditbox,'String',' ');  
end

guidata(hObject, handles);

material_change(hObject, eventdata, handles); 





function clear_answer(hObject, eventdata, handles)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');
set(handles.totalmasseditbox,'String',' ');
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function unitlistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unitlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function calculate_total_mass(hObject, eventdata, handles)

L=str2num(get(handles.lengtheditbox,'String'));
W=str2num(get(handles.widtheditbox,'String'));
thick=str2num(get(handles.thicknesseditbox,'String'));
mass_density=str2num(get(handles.massdensityeditbox,'String'));
NSM=str2num(get(handles.NSMeditbox,'String'));

out1=sprintf('thickness=%8.4g',thick);
% disp(out1);

if(handles.unit==2)
    L=L/1000;
    W=W/1000;
    thick=thick/1000;
end    


vol=L*W*thick;

ss=sprintf('vol=%8.4g',vol);
% disp(ss);

structural_mass=mass_density*vol + NSM;

handles.total_mass=structural_mass;

ss=sprintf('%8.4g',structural_mass);
set(handles.totalmasseditbox,'String',ss);

guidata(hObject, handles);


% --- Executes on selection change in materiallistbox.
function materiallistbox_Callback(hObject, eventdata, handles)
% hObject    handle to materiallistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns materiallistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from materiallistbox
clear_answer(hObject, eventdata, handles);
handles.material=get(hObject,'Value');

guidata(hObject, handles);

material_change(hObject, eventdata, handles); 



function material_change(hObject, eventdata, handles)

if(handles.unit==1)  % English
    if(handles.material==1) % aluminum
        handles.elastic_modulus=1e+007;
        handles.mass_density=0.1;  
    end  
    if(handles.material==2)  % steel
        handles.elastic_modulus=3e+007;
        handles.mass_density= 0.28;         
    end
    if(handles.material==3)  % copper
        handles.elastic_modulus=1.6e+007;
        handles.mass_density=  0.322;
    end
    if(handles.material==4)  % G10
        handles.elastic_modulus=2.7e+006;
        handles.mass_density=  0.065;
    end
else                 % metric
    if(handles.material==1)  % aluminum
        handles.elastic_modulus=70;
        handles.mass_density=  2700;
    end
    if(handles.material==2)  % steel
        handles.elastic_modulus=205;
        handles.mass_density=  7700;        
    end
    if(handles.material==3)   % copper
        handles.elastic_modulus=110;
        handles.mass_density=  8900;
    end
    if(handles.material==4)  % G10
        handles.elastic_modulus=18.6;
        handles.mass_density=  1800;
    end
end
 
if(handles.material==1) % aluminum
        handles.poisson=0.33;  
end  
if(handles.material==2)  % steel
        handles.poisson= 0.30;         
end
if(handles.material==3)  % copper
        handles.poisson=  0.33;
end
if(handles.material==4)  % G10
        handles.poisson=  0.12;
end

if(handles.material<5)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density);
    ss3=sprintf('%8.4g',handles.poisson);  
 
    set(handles.elasticmoduluseditbox,'String',ss1);
    set(handles.massdensityeditbox,'String',ss2);  
    set(handles.poissoneditbox,'String',ss3);  
end

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function materiallistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to materiallistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elasticmoduluseditbox_Callback(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elasticmoduluseditbox as text
%        str2double(get(hObject,'String')) returns contents of elasticmoduluseditbox as a double
clear_answer(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function elasticmoduluseditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end








function poissoneditbox_Callback(hObject, eventdata, handles)
% hObject    handle to poissoneditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poissoneditbox as text
%        str2double(get(hObject,'String')) returns contents of poissoneditbox as a double
clear_answer(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function poissoneditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poissoneditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in leftBClistbox.
function leftBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns leftBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from leftBClistbox
clear_answer(hObject, eventdata, handles);
handles.leftBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function leftBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in bottomBClistbox.
function bottomBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to bottomBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns bottomBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bottomBClistbox
clear_answer(hObject, eventdata, handles);
handles.bottomBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function bottomBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bottomBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rightBClistbox.
function rightBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rightBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rightBClistbox
clear_answer(hObject, eventdata, handles);
handles.rightBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rightBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in topBClistbox.
function topBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to topBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns topBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from topBClistbox
clear_answer(hObject, eventdata, handles);
handles.topBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function topBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to topBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NSMeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to NSMeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NSMeditbox as text
%        str2double(get(hObject,'String')) returns contents of NSMeditbox as a double
clear_answer(hObject, eventdata, handles);
handles.NSM=str2num(get(hObject,'String')); 
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function NSMeditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NSMeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function totalmasseditbox_Callback(hObject, eventdata, handles)
% hObject    handle to totalmasseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of totalmasseditbox as text
%        str2double(get(hObject,'String')) returns contents of totalmasseditbox as a double


% --- Executes during object creation, after setting all properties.
function totalmasseditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totalmasseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Answer_Callback(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Answer as text
%        str2double(get(hObject,'String')) returns contents of Answer as a double


% --- Executes during object creation, after setting all properties.
function Answer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calculatepushbutton.
function calculatepushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculatepushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


leftBC=get(handles.leftBClistbox,'Value');
topBC=get(handles.topBClistbox,'Value');
rightBC=get(handles.rightBClistbox,'Value');
bottomBC=get(handles.bottomBClistbox,'Value');

calculate_total_mass(hObject, eventdata, handles);

E=str2num(get(handles.elasticmoduluseditbox,'String'));
mu=str2num(get(handles.poissoneditbox,'String'));
mass=str2num(get(handles.totalmasseditbox,'String'));

L=str2num(get(handles.lengtheditbox,'String'));
W=str2num(get(handles.widtheditbox,'String'));
thick=str2num(get(handles.thicknesseditbox,'String'));

out1=sprintf(' E=%8.4g  mu=%7.3g  mass dens=%8.4g  ',E,mu,mass);
out2=sprintf(' L=%8.4g   W=%8.4g  thick=%8.4g  ',L,W,thick);

disp(out1);
disp(out2);

unit=get(handles.unitlistbox,'Value');

if(unit==1)
    mass=mass/386;
else
    L=L/1000;
    W=W/1000;
    thick=thick/1000;
    E=E*1e+09;
end

area=L*W;
rhos=mass/area;

D=E*thick^3/(12*(1.-mu^2));

sss=sprintf('%8.4g',D);
set(handles.edit_D,'String',sss);


sqDrho=sqrt(D/rhos);

a=L;
b=W;

a2=a^2;
a4=a^4;

b2=b^2;
b4=b^4;

a2b2=a^2*b^2;


iflag=0;

out1=sprintf(' %d %d %d %d ',leftBC,topBC,rightBC,bottomBC);
disp(out1);

% case 1:  pinned-pinned-free-free
if( (leftBC==3 && topBC==3 && rightBC==2 && bottomBC==2)||...
    (leftBC==2 && topBC==2 && rightBC==3 && bottomBC==3)||...
    (leftBC==2 && topBC==3 && rightBC==3 && bottomBC==2)||...
    (leftBC==3 && topBC==2 && rightBC==2 && bottomBC==3))
    fn=(pi/11)*sqDrho*( (1/a2) + (1/b2) );
    iflag=1;
end

% case 2:  pinned-pinned-free-pinned
if( (leftBC==2 && topBC==2 && rightBC==3 && bottomBC==2)||...
    (leftBC==3 && topBC==2 && rightBC==2 && bottomBC==2))
    fn=(pi/2)*sqDrho*( (1/(4*a2)) + (1/b2) );
    iflag=1;
end

% case 3:  pinned-pinned-pinned-pinned
if( leftBC==2 && topBC==2 && rightBC==2 && bottomBC==2)
    fn=(pi/2)*sqDrho*( (1/a2) + (1/b2) );
    iflag=1;
end

% case 4:  fixed-fixed-free-free
if( (leftBC==3 && topBC==3 && rightBC==1 && bottomBC==1)||...
    (leftBC==1 && topBC==1 && rightBC==3 && bottomBC==3)||...
    (leftBC==1 && topBC==3 && rightBC==3 && bottomBC==1)||...
    (leftBC==3 && topBC==1 && rightBC==1 && bottomBC==3))
    fn=(pi/5.42)*sqDrho*sqrt( (1/a4) + (3.2/a2b2)+ (1/b4) );
    iflag=1;
end

% case 5:  fixed-fixed-fixed-free
if( (leftBC==1 && topBC==1 && rightBC==3 && bottomBC==1)||...
    (leftBC==3 && topBC==1 && rightBC==1 && bottomBC==1))
    fn=(pi/3)*sqDrho*sqrt( (0.75/a4) + (2/a2b2)+ (12/b4) );
    iflag=1;
end


% case 6:  fixed-fixed-fixed-fixed
if(leftBC==1 && topBC==1 && rightBC==1 && bottomBC==1)
    fn=(pi/1.5)*sqDrho*sqrt( (3/a4) + (2/a2b2) + (3/b4) );
    iflag=1;
end

% case 7:  fixed-pinned-fixed-pinned
if(leftBC==1 && topBC==2 && rightBC==1 && bottomBC==2)
    fn=(pi/3.46)*sqDrho*sqrt( (16/a4) + (8/a2b2) + (3/b4) );
    iflag=1;
end

% case 8:  free-free-free-free
if( leftBC==3 && topBC==3 && rightBC==3 && bottomBC==3)
    disp(' free-free-free-free  ');
    fn=(pi/2)*sqDrho*sqrt( 2.08/a2b2 );
    iflag=1;
end

% case 9:  fixed-free-free-free
if( (leftBC==1 && topBC==3 && rightBC==3 && bottomBC==3)||...
    (leftBC==3 && topBC==3 && rightBC==1 && bottomBC==3))  
    fn=(0.56/a2)*sqDrho;
    iflag=1;
end

% case 10:  fixed-free-fixed-free
if( leftBC==1 && topBC==3 && rightBC==1 && bottomBC==3) 
    fn=(3.55/a2)*sqDrho;
    iflag=1;
end

% case 11:  fixed-free-pinned-free
if( (leftBC==1 && topBC==3 && rightBC==2 && bottomBC==3)||...
    (leftBC==2 && topBC==3 && rightBC==1 && bottomBC==3))  
    fn=(0.78*pi/a2)*sqDrho;
    iflag=1;
end


% case 12:  pinned-free-pinned-free
if( leftBC==2 && topBC==3 && rightBC==2 && bottomBC==3) 
%    fn=(pi/(2*a2))*sqDrho;
    omega= (9.87/a2)*sqDrho;  % Leissa, Table 4.20
    fn=omega/(2*pi);
    iflag=1;
end

% case 13:  fixed-pinned-fixed-free
if( (leftBC==1 && topBC==2 && rightBC==1 && bottomBC==3)||...
    (leftBC==1 && topBC==3 && rightBC==1 && bottomBC==2))  
    fn=(pi/1.74)*sqDrho*sqrt((4/a4)+(1/(2*a2b2))+(1/(64*b4)));
    iflag=1;
end

% case 14:  fixed-pinned-free-free
if( (leftBC==1 && topBC==2 && rightBC==3 && bottomBC==3)||...
    (leftBC==1 && topBC==3 && rightBC==3 && bottomBC==2)||... 
    (leftBC==3 && topBC==2 && rightBC==1 && bottomBC==3)||... 
    (leftBC==3 && topBC==3 && rightBC==1 && bottomBC==2)) 
    fn=(pi/2)*sqDrho*sqrt((0.127/a4)+(0.20/a2b2));
    iflag=1;
end

% case 15:  pinned-fixed-pinned-free
if( (leftBC==2 && topBC==1 && rightBC==2 && bottomBC==3)||...
    (leftBC==2 && topBC==3 && rightBC==2 && bottomBC==1))  
    fn=(pi/2)*sqDrho*sqrt((1/a4)+(0.608/a2b2)+(0.126/b4));
    iflag=1;
end    

% case 16:  fixed-fixed-pinned-fixed
if( (leftBC==2 && topBC==1 && rightBC==1 && bottomBC==1)||...
    (leftBC==1 && topBC==1 && rightBC==2 && bottomBC==1))  
    fn=(pi/2)*sqDrho*sqrt((2.45/a4)+(2.90/a2b2)+(5.13/b4));
    iflag=1;
end

% case 17:  fixed-fixed-free-pinned
if( (leftBC==1 && topBC==1 && rightBC==3 && bottomBC==2)||...
    (leftBC==1 && topBC==2 && rightBC==3 && bottomBC==1)||... 
    (leftBC==3 && topBC==1 && rightBC==1 && bottomBC==2)||... 
    (leftBC==3 && topBC==2 && rightBC==1 && bottomBC==1)) 
    fn=(pi/2)*sqDrho*sqrt((0.127/a4)+(0.707/a2b2)+(2.44/b4));
    iflag=1;
end

% case 18:  fixed-fixed-pinned-pinned-pinned
if( (leftBC==2 && topBC==2 && rightBC==1 && bottomBC==1)||...
    (leftBC==1 && topBC==1 && rightBC==2 && bottomBC==2)||... 
    (leftBC==1 && topBC==2 && rightBC==2 && bottomBC==1)||... 
    (leftBC==2 && topBC==1 && rightBC==1 && bottomBC==2)) 
    fn=(pi/2)*sqDrho*sqrt((2.45/a4)+(2.68/a2b2)+(2.45/b4));
    iflag=1;
end


% case 19:  fixed-pinned-pinned-pinned
if( (leftBC==1 && topBC==2 && rightBC==2 && bottomBC==2)||...
    (leftBC==2 && topBC==2 && rightBC==1 && bottomBC==2))  
    fn=(pi/2)*sqDrho*sqrt((2.45/a4)+(2.32/a2b2)+(1/b4));
    iflag=1;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(thick>0.5*W || thick>0.5*L)
    iflag=2;
end

set(handles.Answer,'Enable','on');

if(iflag==0)
    ss=sprintf('case unavailable');
end
if(iflag==1)
    ss=sprintf('%8.4g',fn);
    out1=sprintf('\n  fn=%8.4g Hz \n',fn);
    disp(out1);
end
if(iflag==2)
    ss=sprintf('thickness too large');
end

set(handles.Answer,'String',ss);

guidata(hObject, handles);

% --- Executes on button press in resetpushbutton.
function resetpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to resetpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


function widtheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to widtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of widtheditbox as text
%        str2double(get(hObject,'String')) returns contents of widtheditbox as a double
clear_answer(hObject, eventdata, handles);
handles.width=str2num(get(hObject,'String')); 
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function widtheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to widtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thicknesseditbox_Callback(hObject, eventdata, handles)
% hObject    handle to thicknesseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thicknesseditbox as text
%        str2double(get(hObject,'String')) returns contents of thicknesseditbox as a double
clear_answer(hObject, eventdata, handles);


handles.thickness=str2num(get(hObject,'String')); 
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function thicknesseditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thicknesseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lengtheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lengtheditbox as text
%        str2double(get(hObject,'String')) returns contents of lengtheditbox as a double
clear_answer(hObject, eventdata, handles);
handles.length=str2num(get(hObject,'String')); 
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function lengtheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function massdensityeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of massdensityeditbox as text
%        str2double(get(hObject,'String')) returns contents of massdensityeditbox as a double
clear_answer(hObject, eventdata, handles);
st=get(hObject,'String');
 
handles.mass_density=str2num(st); 
 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function massdensityeditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on lengtheditbox and none of its controls.
function lengtheditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_answer(hObject, eventdata, handles);


% --- Executes on key press with focus on widtheditbox and none of its controls.
function widtheditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to widtheditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


% --- Executes on key press with focus on massdensityeditbox and none of its controls.
function massdensityeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_answer(hObject, eventdata, handles);



% --- Executes on key press with focus on NSMeditbox and none of its controls.
function NSMeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to NSMeditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_answer(hObject, eventdata, handles);

% --- Executes on key press with focus on thicknesseditbox and none of its controls.
function thicknesseditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to thicknesseditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over lengtheditbox.
function lengtheditbox_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on poissoneditbox and none of its controls.
function poissoneditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to poissoneditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


% --- Executes on key press with focus on elasticmoduluseditbox and none of its controls.
function elasticmoduluseditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



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
