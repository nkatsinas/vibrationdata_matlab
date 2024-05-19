function varargout = noise_reduction_room(varargin)
% NOISE_REDUCTION_ROOM MATLAB code for noise_reduction_room.fig
%      NOISE_REDUCTION_ROOM, by itself, creates a new NOISE_REDUCTION_ROOM or raises the existing
%      singleton*.
%
%      H = NOISE_REDUCTION_ROOM returns the handle to a new NOISE_REDUCTION_ROOM or the handle to
%      the existing singleton*.
%
%      NOISE_REDUCTION_ROOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISE_REDUCTION_ROOM.M with the given input arguments.
%
%      NOISE_REDUCTION_ROOM('Property','Value',...) creates a new NOISE_REDUCTION_ROOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before noise_reduction_room_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to noise_reduction_room_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help noise_reduction_room

% Last Modified by GUIDE v2.5 07-Nov-2017 16:13:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @noise_reduction_room_OpeningFcn, ...
                   'gui_OutputFcn',  @noise_reduction_room_OutputFcn, ...
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


% --- Executes just before noise_reduction_room is made visible.
function noise_reduction_room_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to noise_reduction_room (see VARARGIN)

% Choose default command line output for noise_reduction_room
handles.output = hObject;

clear(hObject, eventdata, handles);



for i = 1:8
   for j=1:4
      data_tau{i,j} = '';     
   end 
end

set(handles.uitable_tau,'Data',data_tau); 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



for i = 1:8
   for j=1:4
      data_alpha{i,j} = '';     
   end 
end

set(handles.uitable_alpha,'Data',data_alpha); 





%% listbox_tau_Callback(hObject, eventdata, handles);
%% listbox_alpha_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes noise_reduction_room wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = noise_reduction_room_OutputFcn(hObject, eventdata, handles) 
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
delete(noise_reduction_room);


function clear(hObject, eventdata, handles)

set(handles.edit_transmittance,'Visible','off');
set(handles.edit_absorption,'Visible','off');
set(handles.edit_NR,'Visible','off');
set(handles.text_transmittance,'Visible','off');
set(handles.text_absorption,'Visible','off');
set(handles.text_NR,'Visible','off'); 


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp(' ');

Ax=get(handles.uitable_alpha,'Data');

% A=char(Ax);


A_Area=zeros(8,1);

for j=1:8
    
    q=str2double(Ax{j,2});

    if(isnan(q)|| isempty(q))
    else
        A_Area(j)=q;
    end
end


A_alpha=zeros(8,1);

for j=1:8

    q=str2double(Ax{j,3});
    
    if(isnan(q) || isempty(q))
    else
        A_alpha(j)=q;
    end
end

aaa=zeros(8,1);

for i=1:8
    aaa(i)=A_Area(i)*A_alpha(i);
    
%    out1=sprintf(' %d %8.4g %8.4g %8.4g  ',i, aaa(i),A_Area(i),A_alpha(i));
%    disp(out1);
    
    Ax{i,4}=sprintf('%8.4g',aaa(i));
end



set(handles.uitable_alpha,'Data',Ax); 

total_absorption=sum(aaa);

sss=sprintf('%8.4g',total_absorption);

set(handles.edit_absorption,'String',sss);

%%%%%%

Ax=get(handles.uitable_tau,'Data');
 
 
 
A_Area=zeros(8,1);
 
for j=1:8;
 
%    q=str2num(A(i,:));
    
    q=str2double(Ax{j,2});

    if(isnan(q) || isempty(q))
    else
        A_Area(j)=q;
    end
end
 
A_tau=zeros(8,1);
 
for j=1:8
 
%    q=str2num(A(i,:));
    q=str2double(Ax{j,3});    

    if(isnan(q) || isempty(q))
    else
        A_tau(j)=q;
    end
end
 
aaa=zeros(8,1);
 
for i=1:8
    aaa(i)=A_Area(i)*A_tau(i);
    Ax{i,4}=aaa(i);

end
 
 
set(handles.uitable_tau,'Data',Ax); 
 
total_transmittance=sum(aaa);
 
sss=sprintf('%8.4g',total_transmittance);
 
set(handles.edit_transmittance,'String',sss);


%%%%%%

NR=10*log10(total_absorption/total_transmittance);
sss=sprintf('%8.4g',NR);
set(handles.edit_NR,'String',sss);


set(handles.edit_transmittance,'Visible','on');
set(handles.edit_absorption,'Visible','on');
set(handles.edit_NR,'Visible','on');
set(handles.text_transmittance,'Visible','on');
set(handles.text_absorption,'Visible','on');
set(handles.text_NR,'Visible','on'); 


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('noise_reduction_room.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on selection change in listbox_alpha.
function listbox_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_alpha contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_alpha
data_alpha={'','','',''};
 
n=get(handles.listbox_alpha,'Value');
 
AT=get(handles.uitable_alpha,'Data');
 
sz=size(AT);
 
num=min([sz(1) n]);
 
for i = 1:num
   for j=1:4
      data_alpha{i,j} = AT{i,j};     
   end 
end
 
for i = (num+1):n
   for j=1:4
      data_alpha{i,j} = '';     
   end 
end
 
try
    set(handles.uitable_alpha,'Data',data_alpha); 
catch
end





% --- Executes during object creation, after setting all properties.
function listbox_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_tau.
function listbox_tau_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_tau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_tau contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_tau

data_tau={'','','',''};

n=get(handles.listbox_tau,'Value');

AT=get(handles.uitable_tau,'Data');

sz=size(AT);

num=min([sz(1) n]);

for i = 1:num
   for j=1:4
      data_tau{i,j} = AT{i,j};     
   end 
end

for i = (num+1):n
   for j=1:4
      data_tau{i,j} = '';     
   end 
end

try
    set(handles.uitable_tau,'Data',data_tau); 
catch
end




% --- Executes during object creation, after setting all properties.
function listbox_tau_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_tau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_transmittance_Callback(hObject, eventdata, handles)
% hObject    handle to edit_transmittance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_transmittance as text
%        str2double(get(hObject,'String')) returns contents of edit_transmittance as a double


% --- Executes during object creation, after setting all properties.
function edit_transmittance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_transmittance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_absorption_Callback(hObject, eventdata, handles)
% hObject    handle to edit_absorption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_absorption as text
%        str2double(get(hObject,'String')) returns contents of edit_absorption as a double


% --- Executes during object creation, after setting all properties.
function edit_absorption_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_absorption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_NR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_NR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_NR as text
%        str2double(get(hObject,'String')) returns contents of edit_NR as a double


% --- Executes during object creation, after setting all properties.
function edit_NR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_NR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on uitable_tau and none of its controls.
function uitable_tau_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_tau (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear(hObject, eventdata, handles);


% --- Executes on key press with focus on uitable_alpha and none of its controls.
function uitable_alpha_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_alpha (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_copy.
function pushbutton_copy_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_copy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ax_alpha=get(handles.uitable_alpha,'Data');
Ax_tau=get(handles.uitable_tau,'Data');

for i=1:8
    Ax_alpha{i,1}=Ax_tau{i,1};
    Ax_alpha{i,2}=Ax_tau{i,2};
end 
    
set(handles.uitable_alpha,'Data',Ax_alpha); 
