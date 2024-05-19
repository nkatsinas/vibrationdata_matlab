function varargout = vibrationdata_arbitrary_isolators(varargin)
% VIBRATIONDATA_ARBITRARY_ISOLATORS MATLAB code for vibrationdata_arbitrary_isolators.fig
%      VIBRATIONDATA_ARBITRARY_ISOLATORS, by itself, creates a new VIBRATIONDATA_ARBITRARY_ISOLATORS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ARBITRARY_ISOLATORS returns the handle to a new VIBRATIONDATA_ARBITRARY_ISOLATORS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ARBITRARY_ISOLATORS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ARBITRARY_ISOLATORS.M with the given input arguments.
%
%      VIBRATIONDATA_ARBITRARY_ISOLATORS('Property','Value',...) creates a new VIBRATIONDATA_ARBITRARY_ISOLATORS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_arbitrary_isolators_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_arbitrary_isolators_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_arbitrary_isolators

% Last Modified by GUIDE v2.5 27-Apr-2020 19:43:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_arbitrary_isolators_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_arbitrary_isolators_OutputFcn, ...
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


% --- Executes just before vibrationdata_arbitrary_isolators is made visible.
function vibrationdata_arbitrary_isolators_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_arbitrary_isolators (see VARARGIN)

% Choose default command line output for vibrationdata_arbitrary_isolators
handles.output = hObject;

damping_flag=999;
setappdata(0,'damping_flag',damping_flag);

frf_flag=999;
setappdata(0,'frf_flag',frf_flag);

damp=0;
setappdata(0,'damping',damp);

fig_num=1;
setappdata(0,'fig_num',fig_num);


clear_pushbuttons(hObject, eventdata, handles);

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_arbitrary_isolators wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_arbitrary_isolators_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_arbitrary_isolators)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp(' ');

tpi=2*pi;

units = get(handles.listbox_units, 'Value');

number = get(handles.listbox_number, 'Value');

%%%

mass = str2num(get(handles.edit_mass, 'string'));

jx = str2num(get(handles.edit_Jx, 'string'));
jy = str2num(get(handles.edit_Jy, 'string'));
jz = str2num(get(handles.edit_Jz, 'string'));
AM = get(handles.uitable_stiffness,'Data');

%%%

if isempty(mass)
   warndlg('Enter mass'); 
   return;
end

if isempty(jx)
   warndlg('Enter Jx'); 
   return;
end

if isempty(jy)
   warndlg('Enter Jy'); 
   return;
end

if isempty(jz)
   warndlg('Enter Jz'); 
   return;
end

if isempty(AM)
   warndlg('Enter Spring Properties'); 
   return;
end

%%%

if(mass==0)
    warndlg('mass=0');
end
if(jx==0)
    warndlg('jx=0');
end
if(jy==0)
    warndlg('jy=0');
end
if(jz==0)
    warndlg('jz=0');
end

%%%

kx=zeros(number,1);
ky=zeros(number,1);
kz=zeros(number,1);

x=zeros(number,1);
y=zeros(number,1);
z=zeros(number,1);


for i=1:number
    
    try
         kx(i)=str2num(char(AM{i,1}));      
         ky(i)=str2num(char(AM{i,2}));  
         kz(i)=str2num(char(AM{i,3}));
          x(i)=str2num(char(AM{i,4}));      
          y(i)=str2num(char(AM{i,5}));  
          z(i)=str2num(char(AM{i,6}));        
    catch
        warndlg('Enter all Spring properties');
        return; 
    end    

end

%%%

if(units==1) % English
  mass=mass/386;
  jx=jx/386;
  jy=jy/386;
  jz=jz/386;
else % metric
  x=x/100;
  y=y/100;
  z=z/100;
end

%%%

n=6;
%
m=zeros(n,n);
k=zeros(n,n);
%
m(1,1)=mass;
%
m(2,2)=mass;
%	
m(3,3)=mass;
%	
m(4,4)=jx;
%
m(5,5)=jy;
%
m(6,6)=jz;

%%%

[k]=arbitrary_isolator_stiffness(kx,ky,kz,x,y,z);

%%%

disp(' ');
disp(' The mass matrix is');
m
disp(' ');
disp(' The stiffness matrix is');
k
%
%  Calculate eigenvalues and eigenvectors
%
[ModeShapes,Eigenvalues]=eig(k,m);
k6=k;
m6=m;
%
lambda=zeros(n,1);

for i=1:n
    lambda(i)=Eigenvalues(i,i);
    if(lambda(i)<0.)
        disp(' ');
        disp(' Warning: negative eigenvalue ');
        disp(' ');
    end
end
%
disp(' ');
disp(' Eigenvalues ');
lambda
%
omegan = sqrt(lambda);
fn=omegan/tpi;
%
disp(' ');
disp('  Natural Frequencies = ');
%
for i=1:n 
    out1=sprintf(' %d.   %8.4g Hz',i,fn(i));
    disp(out1);
end
%
MST=ModeShapes';

temp=m*ModeShapes;
QTMQ=MST*temp;
%   
for i=1:n
    scale(i)=1./sqrt(QTMQ(i,i));
end
%
for i=1:n
    ModeShapes(:,i) = ModeShapes(:,i)*scale(i);  
end
%
MST=ModeShapes';
%
disp(' ');
disp('  Modes Shapes (rows represent modes) ');
disp(' ');
clear MSTT;
MSTT=MST;
maximum = max(max(abs(MST)));  
for i=1:6
   for j=1:6
       if(abs(MSTT(i,j))< (maximum/1.0e+05) )
           MSTT(i,j)=0.;
       end
   end
end
%
out_999 = sprintf('          x       y       z     alpha    beta    theta ');
disp(out_999);
for i=1:6
    out1 = sprintf(' %d.  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f ',i,MSTT(i,1),MSTT(i,2),MSTT(i,3),MSTT(i,4),MSTT(i,5),MSTT(i,6));
    disp(out1);
end
%
disp(' ');
disp('  Participation Factors (rows represent modes) ');
disp(' ');
L=MST*m;
PF=L;
%
if(units==1)
    PF=PF*386.;
end
%
maximum = max(max(abs(PF)));  
for i=1:6
   for j=1:6
       if(abs(PF(i,j))< (maximum/1.0e+04) )
           PF(i,j)=0.;
       end
   end
end
disp(out_999);
for i=1:6
    out1 = sprintf(' %d.  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f ',i,PF(i,1),PF(i,2),PF(i,3),PF(i,4),PF(i,5),PF(i,6));
    disp(out1);
end
%
disp(' ');
disp('  Effective Modal Mass (rows represent modes) ');
disp(' ');
EMM=L.*L;
%
if(units==1)
    EMM=EMM*386.;
end
%
maximum = max(max(abs(EMM)));  
for i=1:6
   for j=1:6
       if(abs(EMM(i,j))< (maximum/1.0e+04) )
           EMM(i,j)=0.;
       end
   end
end

disp(out_999);
for i=1:6
    out1 = sprintf(' %d.  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f ',i,EMM(i,1),EMM(i,2),EMM(i,3),EMM(i,4),EMM(i,5),EMM(i,6));
    disp(out1);
end
disp(' ')
disp(' Total Modal Mass ')
disp(' ')
%
out1 = sprintf('   %7.3f  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f ',sum(EMM(:,1)),sum(EMM(:,2)),sum(EMM(:,3)),sum(EMM(:,4)),sum(EMM(:,5)),sum(EMM(:,6)));
disp(out1);
%

setappdata(0,'units',units);
setappdata(0,'m6',m6);
setappdata(0,'k6',k6);
setappdata(0,'fn',fn);
setappdata(0,'ModeShapes',ModeShapes);
setappdata(0,'mass',mass);

setappdata(0,'kx',kx);
setappdata(0,'ky',ky);
setappdata(0,'kz',kz);

setappdata(0,'x',x);
setappdata(0,'y',y);
setappdata(0,'z',z);


if(units==1)
    PF=PF/386;
end

setappdata(0,'PF',PF);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xc=0;
yc=0;
zc=0;

if(units==2)
    x=x*100;
    y=y*100;
    z=z*100;
end    

figure(1);
plot3(x,y,z,'bo',xc,yc,zc,'ro');
grid on;
if(units==1)
    xlabel('X (in)');
    ylabel('Y (in)');
    zlabel('Z (in)');
else
    xlabel('X (cm)');
    ylabel('Y (cm)');
    zlabel('Z (cm)');    
end    
title('Blue Circles = Spring Nodes     Red Circle = CG '); 

for i=1:number
    txt{i}=sprintf('  %d',i);
end    

text(x,y,z,txt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2);
plot(x,y,'bo',xc,yc,'ro');
grid on;
if(units==1)
    xlabel('X (in)');
    ylabel('Y (in)');
else
    xlabel('X (cm)');
    ylabel('Y (cm)');  
end    
title('Blue Circles = Spring Nodes     Red Circle = CG '); 

for i=1:number
    txt{i}=sprintf('  %d',i);
end    

text(x,y,txt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3);
plot(y,z,'bo',yc,zc,'ro');
grid on;
if(units==1)
    xlabel('Y (in)');
    ylabel('Z (in)');
else
    xlabel('Y (cm)');
    ylabel('Z (cm)');  
end    
title('Blue Circles = Spring Nodes     Red Circle = CG '); 

for i=1:number
    txt{i}=sprintf('  %d',i);
end    

text(y,z,txt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(4);
plot(x,z,'bo',xc,zc,'ro');
grid on;
if(units==1)
    xlabel('X (in)');
    ylabel('Z (in)');
else
    xlabel('X (cm)');
    ylabel('Z (cm)');  
end    
title('Blue Circles = Spring Nodes     Red Circle = CG '); 

for i=1:number
    txt{i}=sprintf('  %d',i);
end    

text(x,z,txt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.ED_pushbutton,'Enable','on')
set(handles.RB_pushbutton,'Enable','on')

msgbox('Calculation Complete.  Output given in Matlab Command Window.') 
%



% --- Executes on selection change in listbox_number.
function listbox_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_number
change(hObject, eventdata, handles);
clear_pushbuttons(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_number (see GCBO)
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
clear_pushbuttons(hObject, eventdata, handles);


iu=get(handles.listbox_units,'Value');

if(iu==1) 
    set(handles.text_mass,'String','Mass (lbm)');
    set(handles.text_polar_MOI,'String','Polar MOI (lbm in^2)');   
    ss='Stiffness Unit:  (lbf/in)          Length Unit:  (in)';   
else
    set(handles.text_mass,'String','Mass (kg)');
    set(handles.text_polar_MOI,'String','Polar MOI (kg m^2)'); 
    ss='Stiffness Unit:  (N/m)          Length Unit:  (cm)';       
end

set(handles.text_stiffness_unit,'String',ss);


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



function change(hObject, eventdata, handles)


stiffness = get(handles.uitable_stiffness,'Data');
 
sz=size(stiffness);

Nrows=get(handles.listbox_number,'Value');

Ncolumns=6;

set(handles.uitable_stiffness,'Data',cell(Nrows,Ncolumns));

nn=min([sz(1) Nrows]);

for i=1:nn
    data_s{i,1} = stiffness{i,1};
    data_s{i,2} = stiffness{i,2};
    data_s{i,3} = stiffness{i,3};
    data_s{i,4} = stiffness{i,4};
    data_s{i,5} = stiffness{i,5};
    data_s{i,6} = stiffness{i,6};    
end

for i=(nn+1):Nrows
    data_s{i,1} = '';    
    data_s{i,2} = '';   
    data_s{i,3} = '';       
    data_s{i,4} = '';    
    data_s{i,5} = '';   
    data_s{i,6} = '';          
end

set(handles.uitable_stiffness,'Data',data_s);


listbox_units_Callback(hObject, eventdata, handles);



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



function edit_Jx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Jx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Jx as text
%        str2double(get(hObject,'String')) returns contents of edit_Jx as a double


% --- Executes during object creation, after setting all properties.
function edit_Jx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Jx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Jy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Jy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Jy as text
%        str2double(get(hObject,'String')) returns contents of edit_Jy as a double


% --- Executes during object creation, after setting all properties.
function edit_Jy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Jy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Jz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Jz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Jz as text
%        str2double(get(hObject,'String')) returns contents of edit_Jz as a double


% --- Executes during object creation, after setting all properties.
function edit_Jz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Jz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



try
    units = get(handles.listbox_units, 'Value');
    ArbitraryIsolatorsSave.units=units;
end 
try
    number = get(handles.listbox_number, 'Value');
    ArbitraryIsolatorsSave.number=number;
end 


try
    mass = str2num(get(handles.edit_mass, 'string'));
    ArbitraryIsolatorsSave.mass=mass;
end 
try
    Jx = str2num(get(handles.edit_Jx, 'string'));
    ArbitraryIsolatorsSave.Jx=Jx;
end 
try
    Jy = str2num(get(handles.edit_Jy, 'string'));
    ArbitraryIsolatorsSave.Jy=Jy;
end 
try
    Jz = str2num(get(handles.edit_Jz, 'string'));
    ArbitraryIsolatorsSave.Jz=Jz;
end 
try
    stiffness = get(handles.uitable_stiffness,'Data');
    ArbitraryIsolatorsSave.stiffness=stiffness;
end 

% % %
 
structnames = fieldnames(ArbitraryIsolatorsSave, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'ArbitraryIsolatorsSave'); 
 
    catch
        warndlg('Save error');
        return;
    end
 





% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat', 'Select model file');

NAME = [pathname,filename];

struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);


for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct
 
try
    ArbitraryIsolatorsSave=evalin('base','ArbitraryIsolatorsSave');
catch
    warndlg(' evalin failed ');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%

try
    units=ArbitraryIsolatorsSave.units;    
    set(handles.listbox_units, 'Value');
end 
try
    number=ArbitraryIsolatorsSave.number;    
    set(handles.listbox_number, 'Value',number);
end 

change(hObject, eventdata, handles);





try
    mass=ArbitraryIsolatorsSave.mass;    
    ss=sprintf('%g',mass);
    set(handles.edit_mass, 'string',ss);
end 
try
    Jx=ArbitraryIsolatorsSave.Jx;  
    ss=sprintf('%g',Jx);    
    set(handles.edit_Jx, 'string',ss);
end 
try
    Jy=ArbitraryIsolatorsSave.Jy;   
    ss=sprintf('%g',Jy);    
    set(handles.edit_Jy, 'string',ss);
end 
try
    Jz=ArbitraryIsolatorsSave.Jz;
    ss=sprintf('%g',Jz);    
    set(handles.edit_Jz, 'string',ss);
end 

try
    stiffness=ArbitraryIsolatorsSave.stiffness;    
    set(handles.uitable_stiffness,'Data',stiffness);
end 


% --- Executes when entered data in editable cell(s) in uitable_stiffness.
function uitable_stiffness_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_stiffness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on uitable_stiffness and none of its controls.
function uitable_stiffness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_stiffness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);

% --- Executes on button press in ED_pushbutton.
function ED_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ED_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
damping_flag=getappdata(0,'damping_flag');
frf_flag=getappdata(0,'damping_flag');

handles.s_ID= isolated_damping;
set(handles.s_ID,'Visible','on');

set(handles.ED_pushbutton,'Enable','on')
set(handles.FRF_pushbutton,'Enable','on')
set(handles.PSD_pushbutton,'Enable','on')
set(handles.sine_pushbutton,'Enable','on')
set(handles.HS_pushbutton,'Enable','on')
set(handles.ARB_pushbutton,'Enable','on')
set(handles.RB_pushbutton,'Enable','on')


% --- Executes on button press in FRF_pushbutton.
function FRF_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to FRF_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
damping_flag=getappdata(0,'damping_flag');

if(damping_flag~=1)
    Icon='warn';
    Title='Warning';
    Message='Enter damping values prior to this calculation.'; 
    msgbox(Message,Title,Icon);
else
    handles.s_ITFRF= isolated_transmissibility_frf;
    set(handles.s_ITFRF,'Visible','on')
end

% --- Executes on button press in PSD_pushbutton.
function PSD_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to PSD_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
damping_flag=getappdata(0,'damping_flag');
if(damping_flag ~=1)
    Icon='warn';
    Title='Warning';
    Message='Enter Damping prior to this calculation.';  
    msgbox(Message,Title,Icon);
else   
    handles.s_PSD= isolated_PSD;
    set(handles.s_PSD,'Visible','on');
end

% --- Executes on button press in sine_pushbutton.
function sine_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to sine_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
damping_flag=getappdata(0,'damping_flag');
frf_flag=getappdata(0,'frf_flag');

if(damping_flag ~=1)
    Icon='warn';
    Title='Warning';
    Message='Enter Damping prior to this calculation.'; 
    msgbox(Message,Title,Icon);
else
    handles.s_sine= isolated_sine_acceleration;
    set(handles.s_sine,'Visible','on');
end

% --- Executes on button press in HS_pushbutton.
function HS_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to HS_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
damping_flag=getappdata(0,'damping_flag');

if(damping_flag~=1)
    Icon='warn';
    Title='Warning';
    Message='Enter damping values prior to this calculation.'; 
    msgbox(Message,Title,Icon);
else
    handles.s_HS= isolated_half_sine_base_input;
    set(handles.s_HS,'Visible','on');
end


% --- Executes on button press in ARB_pushbutton.
function ARB_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ARB_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
damping_flag=getappdata(0,'damping_flag');

if(damping_flag~=1)
    Icon='warn';
    Title='Warning';
    Message='Enter damping values prior to this calculation.'; 
    msgbox(Message,Title,Icon);
else
    handles.s_ARB= isolated_arbitrary_base_input;
    set(handles.s_ARB,'Visible','on');
end

% --- Executes on button press in RB_pushbutton.
function RB_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to RB_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s_RB= isolated_RB_acceleration;
set(handles.s_RB,'Visible','on');



function clear_pushbuttons(hObject, eventdata, handles)
set(handles.ED_pushbutton,'Enable','off')
set(handles.FRF_pushbutton,'Enable','off')
set(handles.sine_pushbutton,'Enable','off')
set(handles.HS_pushbutton,'Enable','off')
set(handles.ARB_pushbutton,'Enable','off')
set(handles.RB_pushbutton,'Enable','off')
set(handles.PSD_pushbutton,'Enable','off')


% --- Executes on key press with focus on edit_mass and none of its controls.
function edit_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_Jx and none of its controls.
function edit_Jx_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Jx (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_Jy and none of its controls.
function edit_Jy_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Jy (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_Jz and none of its controls.
function edit_Jz_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Jz (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_view_equations.
function pushbutton_view_equations_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_equations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://www.vibrationdata.com/tutorials2/arbitrary_isolator_system_2.pdf');
