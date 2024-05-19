function varargout = two_dof_system_dashpots_c(varargin)
% TWO_DOF_SYSTEM_DASHPOTS_C MATLAB code for two_dof_system_dashpots_c.fig
%      TWO_DOF_SYSTEM_DASHPOTS_C, by itself, creates a new TWO_DOF_SYSTEM_DASHPOTS_C or raises the existing
%      singleton*.
%
%      H = TWO_DOF_SYSTEM_DASHPOTS_C returns the handle to a new TWO_DOF_SYSTEM_DASHPOTS_C or the handle to
%      the existing singleton*.
%
%      TWO_DOF_SYSTEM_DASHPOTS_C('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_SYSTEM_DASHPOTS_C.M with the given input arguments.
%
%      TWO_DOF_SYSTEM_DASHPOTS_C('Property','Value',...) creates a new TWO_DOF_SYSTEM_DASHPOTS_C or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_system_dashpots_c_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_system_dashpots_c_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_system_dashpots_c

% Last Modified by GUIDE v2.5 24-Aug-2018 12:58:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_system_dashpots_c_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_system_dashpots_c_OutputFcn, ...
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


% --- Executes just before two_dof_system_dashpots_c is made visible.
function two_dof_system_dashpots_c_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_system_dashpots_c (see VARARGIN)

% Choose default command line output for two_dof_system_dashpots_c
handles.output = hObject;

fstr='two_dof_system_dashpots_c.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);

pos1 = getpixelposition(handles.pushbutton_return,true);
pos2 = getpixelposition(handles.uipanel_data,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos2(2) w h]);
axis off;
 
units_listbox_Callback(hObject, eventdata, handles);

set(handles.pushbutton_frf,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_system_dashpots_c wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_system_dashpots_c_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox

n=get(handles.units_listbox,'Value');

data_s=get(handles.uitable_data,'Data');

if(n==1)
    data_s{1,2}='lbm';
    data_s{2,2}='lbm';
    data_s{3,2}='lbf sec/in'; 
    data_s{4,2}='lbf sec/in';
    data_s{5,2}='lbf sec/in';    
    data_s{6,2}='lbf/in';
    data_s{7,2}='lbf/in';      
    data_s{8,2}='lbf/in';       
else
    data_s{1,2}='kg';
    data_s{2,2}='kg';
    data_s{3,2}='N sec/m'; 
    data_s{4,2}='N sec/m';
    data_s{5,2}='N sec/m';    
    data_s{6,2}='N/m';
    data_s{7,2}='N/m';   
    data_s{8,2}='N/m';     
end

set(handles.uitable_data,'Data',data_s);


set(handles.pushbutton_frf,'Enable','off');


% --- Executes during object creation, after setting all properties.
function units_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * ');
disp(' ');

tpi=2*pi;

iu=get(handles.units_listbox,'value');
setappdata(0,'iu',iu);

A=char(get(handles.uitable_data,'Data'));


m1=str2num(A(1,:));
m2=str2num(A(2,:));
c1=str2num(A(3,:));
c2=str2num(A(4,:));
c3=str2num(A(5,:));
k1=str2num(A(6,:));
k2=str2num(A(7,:));
k3=str2num(A(8,:));

M=zeros(2,2);

M(1,1)=m1;
M(2,2)=m2;

K=[(k1+k2) -k2; -k2 (k2+k3)];

C=[(c1+c2) -c2; -c2 (c2+c3)];


disp(' ');
disp(' Mass Matrix');
disp(' ');
out1=sprintf(' %g   %g ',M(1,1),M(1,2));
out2=sprintf(' %g   %g ',M(2,1),M(2,2));
disp(out1);
disp(out2);

disp(' ');
disp(' Damping Matrix ');
disp(' ');
out1=sprintf(' %g   %g ',C(1,1),C(1,2));
out2=sprintf(' %g   %g ',C(2,1),C(2,2));
disp(out1);
disp(out2);

disp(' ');
disp(' Stiffness Matrix ');
disp(' ');
out1=sprintf(' %g   %g ',K(1,1),K(1,2));
out2=sprintf(' %g   %g ',K(2,1),K(2,2));
disp(out1);
disp(out2);



%
if(iu==1)
   M=M/386.;
end
%

Z=zeros(2,2);

clear A;
clear B;

A=[ C M ; M  Z ];
B=[ K Z ; Z -M ];

disp(' ');
disp(' A Matrix ');
disp(' ');
A


disp(' ');
disp(' B Matrix ');
disp(' ');
B


[ModeShapes,Evals]=eig(B,-A);

szz=max(size(Evals));

EEE=zeros(szz,szz+2);

for i=1:szz
    EEE(i,1)=abs(Evals(i,i));
    EEE(i,2)=Evals(i,i);    
end
EEE(:,3:szz+2)=transpose(ModeShapes);
EEE=sortrows(EEE);

Eigenvalues=EEE(:,2);
ModeShapes=transpose(EEE(:,3:szz+2));
MST=transpose(ModeShapes);


disp(' ');
disp(' Eigenvalues');
disp(' ');

for i=1:4
    v=Eigenvalues(i);
    out1=sprintf('Complex: %8.4g + %8.4gi   Mag: %8.4g rad/sec  f=%8.4g Hz',real(v),imag(v),abs(v),abs(v)/tpi);
    disp(out1);
end

disp(' ');
disp(' Mode Shapes');

ModeShapes

disp(' ');


ar=MST*A*ModeShapes;
br=MST*B*ModeShapes;

lambda=zeros(4,1);

for i=1:4
    q=-br(i,i)/ar(i,i);
    out1=sprintf(' lambda%d =   %8.4g + %8.4gi  ',i,real(q),imag(q));
    disp(out1);
    lambda(i)=q;
end

disp(' ');

assignin('base','A',A); 
assignin('base','B',B); 
assignin('base','ar',ar);
assignin('base','br',br);
assignin('base','ModeShapes',ModeShapes);
assignin('base','Eigenvalues',Eigenvalues); 

setappdata(0,'A',A);
setappdata(0,'B',B);
setappdata(0,'ar',diag(ar));
setappdata(0,'br',diag(br));
setappdata(0,'lambda',lambda);
setappdata(0,'ModeShapes',ModeShapes);
setappdata(0,'MST',MST);
setappdata(0,'Eigenvalues',Eigenvalues);


set(handles.pushbutton_frf,'Enable','on');

msgbox('Calculation complete.  Output written to Matlab Command Window.');




function mass2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass2_edit as text
%        str2double(get(hObject,'String')) returns contents of mass2_edit as a double


% --- Executes during object creation, after setting all properties.
function mass2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness2_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness2_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass1_edit as text
%        str2double(get(hObject,'String')) returns contents of mass1_edit as a double


% --- Executes during object creation, after setting all properties.
function mass1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness1_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness1_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
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
delete(two_dof_system_dashpots_c);


% --- Executes on button press in pushbutton_frf.
function pushbutton_frf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_frf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=state_space_frf;
set(handles.s,'Visible','on');   


% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_frf,'Enable','off');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


 
iu=get(handles.units_listbox,'Value');
two_dof_dashpots.iu=iu;

A=get(handles.uitable_data,'Data');
two_dof_dashpots.A=A;

% % %
 
structnames = fieldnames(two_dof_dashpots, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'two_dof_dashpots'); 
 
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
    two_dof_dashpots=evalin('base','two_dof_dashpots');
catch
    warndlg(' evalin failed ');
    return;
end
 
two_dof_dashpots


try
    iu=two_dof_dashpots.iu;    
    set(handles.units_listbox,'Value',iu);
catch
end

units_listbox_Callback(hObject, eventdata, handles);

try
    A=two_dof_dashpots.A;     
    set(handles.uitable_data,'Data',A);   
catch
    disp('set unsuccessful')
end    
