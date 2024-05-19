function varargout = plate_mdof_srs(varargin)
% PLATE_MDOF_SRS MATLAB code for plate_mdof_srs.fig
%      PLATE_MDOF_SRS, by itself, creates a new PLATE_MDOF_SRS or raises the existing
%      singleton*.
%
%      H = PLATE_MDOF_SRS returns the handle to a new PLATE_MDOF_SRS or the handle to
%      the existing singleton*.
%
%      PLATE_MDOF_SRS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATE_MDOF_SRS.M with the given input arguments.
%
%      PLATE_MDOF_SRS('Property','Value',...) creates a new PLATE_MDOF_SRS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plate_mdof_srs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plate_mdof_srs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plate_mdof_srs

% Last Modified by GUIDE v2.5 05-Apr-2022 15:02:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plate_mdof_srs_OpeningFcn, ...
                   'gui_OutputFcn',  @plate_mdof_srs_OutputFcn, ...
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


% --- Executes just before plate_mdof_srs is made visible.
function plate_mdof_srs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plate_mdof_srs (see VARARGIN)

% Choose default command line output for plate_mdof_srs
handles.output = hObject;

set(handles.uipanel_data,'Visible','off');
listbox_srs_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plate_mdof_srs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plate_mdof_srs_OutputFcn(hObject, eventdata, handles) 
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

delete(plate_mdof_srs);


% --- Executes on button press in pushbutton_calculate_2.
function pushbutton_calculate_2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * ');
disp(' ');

fk=getappdata(0,'fk');
pk=getappdata(0,'pk');
ek=getappdata(0,'ek');

iu=getappdata(0,'iu');

N=length(fk);

A=char(get(handles.uitable_coordinates,'Data'));

B=str2num(A);

srs=B(4*N+1:5*N);

a=0;
ab=0;
for i=1:N
    a=a+(pk(i)*ek(i)*srs(i))^2;
    ab=ab+abs(pk(i)*ek(i)*srs(i));
end
a=sqrt(a);

fprintf('\n Expected Acceleration \n');
fprintf('\n ABSSUM:  %8.4g G ',ab);
fprintf('\n   SRSS:  %8.4g G \n',a);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn=getappdata(0,'fn');

if(iu==1)
    du='in';
    srs=srs*386;
else
    du='mm';
    srs=srs*9.81*1000;
end

a=0;
ab=0;
for i=1:N
    srs(i)=srs(i)/(2*pi*fn(i))^2;
    a=a+(pk(i)*ek(i)*srs(i))^2;
    ab=ab+abs(pk(i)*ek(i)*srs(i));
end
a=sqrt(a);

fprintf('\n Expected Relative Displacement \n');
fprintf('\n ABSSUM:  %8.4g %s ',ab,du);
fprintf('\n   SRSS:  %8.4g %s \n',a,du);


msgbox('Results written to Command Window');


function edit_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_node as text
%        str2double(get(hObject,'String')) returns contents of edit_node as a double



% --- Executes during object creation, after setting all properties.
function edit_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculation_1.
function pushbutton_calculation_1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculation_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_data,'Visible','on');

fn=getappdata(0,'fn');

ModeShapes=getappdata(0,'ModeShapes_corrected');

iq=get(handles.listbox_srs,'Value');

pff=getappdata(0,'pff');
pff=abs(pff);
mp=max(pff);

node=str2num(get(handles.edit_node,'String'));

ndof=3*node-2;

k=1;

for i=1:length(fn)
    if(pff(i)>0.01*mp)
        fk(k)=fn(i);
        pk(k)=pff(i);
        mk(k)=i;
        ek(k)=abs(ModeShapes(ndof,i));
        k=k+1;
        if(k==7)
            break;
        end
    end
end

setappdata(0,'fk',fk);
setappdata(0,'pk',pk);
setappdata(0,'ek',ek);

num_fn=length(fk);

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);   
catch
    warndlg('Input Array not Found');  
    return;  
end

num_srs=length(THM(:,1));

a_srs=zeros(num_fn,1);

if(iq==1)
    f=THM(:,1);
    a=THM(:,2);

    slope=zeros(num_srs-1,1);

    for i=1:(num_srs-1)
        slope(i)=log(a(i+1)/a(i))/log(f(i+1)/f(i));
    end
    
    for i=1:num_fn
        
        a_srs(i)=a(1);
        
        for k=1:(num_srs-1)
            if(fk(i)>=f(k) && fk(i)<=f(k+1))
                a_srs(i)=a(k)*(fk(i)/f(k))^slope(k);
                break;
            end   
            if(fk(k)>f(end))
                a_srs(i)=a(end);
                break;
            end
        end
    end 
end
    
for i = 1:num_fn

    data_s{i,1} = sprintf('%d',mk(i));     
    data_s{i,2} = sprintf('%7.4g',fk(i));    
    data_s{i,3} = sprintf('%7.4g',pk(i));    
    data_s{i,4} = sprintf('%7.4g',ek(i));
    
    if(iq==1)
        data_s{i,5} = sprintf('%7.4g',a_srs(i));
    else
        data_s{i,5} = '';
    end
        
end

set(handles.uitable_coordinates,'Data',data_s);


% --- Executes on selection change in listbox_srs.
function listbox_srs_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_srs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_srs

i=get(handles.listbox_srs,'Value');

if(i==1)
    set(handles.text_SRS_name,'Visible','on');
    set(handles.edit_input_array,'Visible','on');
    set(handles.text_format,'Visible','on');    
else
    set(handles.text_SRS_name,'Visible','off');
    set(handles.edit_input_array,'Visible','off');
    set(handles.text_format,'Visible','off');      
end


% --- Executes during object creation, after setting all properties.
function listbox_srs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_node and none of its controls.
function edit_node_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_node.
function edit_node_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_input_array.
function edit_input_array_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
