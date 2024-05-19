function varargout = NASA7005_shock_distance_joints(varargin)
% NASA7005_SHOCK_DISTANCE_JOINTS MATLAB code for NASA7005_shock_distance_joints.fig
%      NASA7005_SHOCK_DISTANCE_JOINTS, by itself, creates a new NASA7005_SHOCK_DISTANCE_JOINTS or raises the existing
%      singleton*.
%
%      H = NASA7005_SHOCK_DISTANCE_JOINTS returns the handle to a new NASA7005_SHOCK_DISTANCE_JOINTS or the handle to
%      the existing singleton*.
%
%      NASA7005_SHOCK_DISTANCE_JOINTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NASA7005_SHOCK_DISTANCE_JOINTS.M with the given input arguments.
%
%      NASA7005_SHOCK_DISTANCE_JOINTS('Property','Value',...) creates a new NASA7005_SHOCK_DISTANCE_JOINTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NASA7005_shock_distance_joints_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NASA7005_shock_distance_joints_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NASA7005_shock_distance_joints

% Last Modified by GUIDE v2.5 30-Nov-2018 08:23:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NASA7005_shock_distance_joints_OpeningFcn, ...
                   'gui_OutputFcn',  @NASA7005_shock_distance_joints_OutputFcn, ...
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


% --- Executes just before NASA7005_shock_distance_joints is made visible.
function NASA7005_shock_distance_joints_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NASA7005_shock_distance_joints (see VARARGIN)

% Choose default command line output for NASA7005_shock_distance_joints
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NASA7005_shock_distance_joints wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)

set(handles.uipanel_save,'Visible','off');

sse='Delta Distance (in)';
ssm='Delta Distance (m)';

iu=get(handles.listbox_units,'Value');

set(handles.text_v1,'String','Plateau Remaining Ratio');
set(handles.text_v2,'String','Plateau Remaining Ratio');
set(handles.text_v3,'String','Plateau Remaining Ratio');
set(handles.text_v4,'String','Plateau Remaining Ratio');
set(handles.text_v5,'String','Plateau Remaining Ratio');
set(handles.text_v6,'String','Plateau Remaining Ratio');


n1=get(handles.listbox_s1,'Value');
n2=get(handles.listbox_s2,'Value');
n3=get(handles.listbox_s3,'Value');
n4=get(handles.listbox_s4,'Value');
n5=get(handles.listbox_s5,'Value');
n6=get(handles.listbox_s6,'Value');

if(iu==1)
    if(n1==1)
        set(handles.text_v1,'String',sse);
    end
    if(n2==1)
        set(handles.text_v2,'String',sse);        
    end 
    if(n3==1)
        set(handles.text_v3,'String',sse);        
    end
    if(n4==1)
        set(handles.text_v4,'String',sse);        
    end   
    if(n5==1)
        set(handles.text_v5,'String',sse);        
    end
    if(n6==1)
        set(handles.text_v6,'String',sse);        
    end       
else
    if(n1==1)
        set(handles.text_v1,'String',ssm);
    end
    if(n2==1)
        set(handles.text_v2,'String',ssm);        
    end 
    if(n3==1)
        set(handles.text_v3,'String',ssm);        
    end
    if(n4==1)
        set(handles.text_v4,'String',ssm);        
    end   
    if(n5==1)
        set(handles.text_v5,'String',ssm);        
    end
    if(n6==1)
        set(handles.text_v6,'String',ssm);        
    end     
end



%%%%%%%%%%%%%%

n=get(handles.listbox_steps,'Value');

set(handles.text_s2,'Visible','off');
set(handles.text_s3,'Visible','off');
set(handles.text_s4,'Visible','off');
set(handles.text_s5,'Visible','off');
set(handles.text_s6,'Visible','off');

set(handles.listbox_s2,'Visible','off');
set(handles.listbox_s3,'Visible','off');
set(handles.listbox_s4,'Visible','off');
set(handles.listbox_s5,'Visible','off');
set(handles.listbox_s6,'Visible','off');

set(handles.edit_s2,'Visible','off');
set(handles.edit_s3,'Visible','off');
set(handles.edit_s4,'Visible','off');
set(handles.edit_s5,'Visible','off');
set(handles.edit_s6,'Visible','off');

set(handles.text_v2,'Visible','off');
set(handles.text_v3,'Visible','off');
set(handles.text_v4,'Visible','off');
set(handles.text_v5,'Visible','off');
set(handles.text_v6,'Visible','off');

%%%%%%%%%

if(n>=2)
    set(handles.text_s2,'Visible','on');    
    set(handles.listbox_s2,'Visible','on');    
    set(handles.edit_s2,'Visible','on');
    set(handles.text_v2,'Visible','on');     
end
if(n>=3)
    set(handles.text_s3,'Visible','on');    
    set(handles.listbox_s3,'Visible','on');
    set(handles.edit_s3,'Visible','on');       
    set(handles.text_v3,'Visible','on');       
end
if(n>=4)
    set(handles.text_s4,'Visible','on');    
    set(handles.listbox_s4,'Visible','on');
    set(handles.edit_s4,'Visible','on');
    set(handles.text_v4,'Visible','on');       
end
if(n>=5)
    set(handles.text_s5,'Visible','on');    
    set(handles.listbox_s5,'Visible','on');
    set(handles.edit_s5,'Visible','on');
    set(handles.text_v5,'Visible','on');       
end
if(n>=6)
    set(handles.text_s6,'Visible','on');    
    set(handles.listbox_s6,'Visible','on');
    set(handles.edit_s6,'Visible','on');
    set(handles.text_v6,'Visible','on');       
end





% --- Outputs from this function are returned to the command line.
function varargout = NASA7005_shock_distance_joints_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on selection change in listbox_steps.
function listbox_steps_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_steps contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_steps

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_steps (see GCBO)
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



function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
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

delete(NASA7005_shock_distance_joints);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * * * * * ');
disp('  ');

iu=get(handles.listbox_units,'Value');
ns=get(handles.listbox_steps,'Value');

m(1)=get(handles.listbox_s1,'Value');
m(2)=get(handles.listbox_s2,'Value');
m(3)=get(handles.listbox_s3,'Value');
m(4)=get(handles.listbox_s4,'Value');
m(5)=get(handles.listbox_s5,'Value');
m(6)=get(handles.listbox_s6,'Value');

v(1)=str2num(get(handles.edit_s1,'String'));

if(ns>=2)
    v(2)=str2num(get(handles.edit_s2,'String'));
end
if(ns>=3)
    v(3)=str2num(get(handles.edit_s3,'String'));
end
if(ns>=4)
    v(4)=str2num(get(handles.edit_s4,'String'));
end
if(ns>=5)
    v(5)=str2num(get(handles.edit_s5,'String'));
end
if(ns>=6)
    v(6)=str2num(get(handles.edit_s6,'String'));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

md=5;

t_string=get(handles.edit_title,'String');

try
      FS=get(handles.edit_input_array,'String');
      THM=evalin('base',FS);
%      disp('ref 2')
catch
      warndlg('Unable to read input file','Warning');
      return;
end   

f=THM(:,1);
a=THM(:,2);

srs1=THM;

%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Source SRS ');
disp('  ');
disp('  fn(Hz)  Accel(G) ');

for i=1:length(f)
    out1=sprintf(' %6.0f  %8.4g ',srs1(i,1),srs1(i,2));
    disp(out1);
end

x1=0;

for i=1:ns
 
    
    if(m(i)==1)  % distance
 
        if(iu==1)
            out1=sprintf('\n Step %d   Distance Attenuation   Delta Distance=%g in',i,v(i));
            disp(out1);
        else
            out1=sprintf('\n Step %d   Distance Attenuation   Delta Distance=%g m',i,v(i));
            disp(out1);            
        end
        
        x2=v(i)+x1;
        
        if(iu==1)
            xx1=x1*2.54/100;
            xx2=x2*2.54/100;            
        else        
            xx1=x1/100;
            xx2=x2/100;
        end

        
        [attr1,attp1]=NASA7005_ramp_plateau(xx1);
        [attr2,attp2]=NASA7005_ramp_plateau(xx2);

        if(attr2==0 || attr1==0)
            attr=0;
        else    
            attr=attr2/attr1;
        end
        
        if(attp2==0 || attp1==0)
            attp=0;
        else    
            attp=attp2/attp1;
        end
        
        out1=sprintf('\n  Remaining:  ramp=%6.3g   plateau=%6.3g ',attr,attp);
        disp(out1);
        
        f=srs1(:,1);
        a=srs1(:,2);
        
        [f,a]=srs_distance_atten_ramp_plateau(attp,attr,f,a);
        srs2=[f a];
        
        x1=x2;
    
    else         % joint
        
        out1=sprintf('\n Step %d   Joint   %g remaining',i,v(i));
        disp(out1);        
        
        [srs2]=SRS_plateau_attenuation(srs1,v(i));
        
    end
    
    srs1=srs2;
    
    disp('  ');
    disp('  fn(Hz)  Accel(G) ');

  
    
    f=srs1(:,1);
    for i=1:length(f)
        out1=sprintf(' %6.0f  %8.4g ',srs1(i,1),srs1(i,2));
        disp(out1);
    end
    
end

%%%%%%%%%%%%%%%%%%%

setappdata(0,'attenuated_srs',srs1);

set(handles.uipanel_save,'Visible','on');

%%%%%%%%%%%%%%%%%%%

ppp1=THM;
ppp2=srs1;

leg1='Source';
leg2='Attenuated';

fmin=f(1);
fmax=f(end);

%%%

x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';


[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%
           
           

% --- Executes on selection change in listbox_s1.
function listbox_s1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_s1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_s1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_s1
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_s1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_s1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_s2.
function listbox_s2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_s2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_s2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_s2
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_s2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_s2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_s3.
function listbox_s3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_s3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_s3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_s3
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_s3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_s3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_s4.
function listbox_s4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_s4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_s4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_s4
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_s4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_s4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_s5.
function listbox_s5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_s5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_s5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_s5
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_s5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_s5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_s6.
function listbox_s6_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_s6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_s6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_s6
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_s6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_s6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s1 as text
%        str2double(get(hObject,'String')) returns contents of edit_s1 as a double


% --- Executes during object creation, after setting all properties.
function edit_s1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s2 as text
%        str2double(get(hObject,'String')) returns contents of edit_s2 as a double


% --- Executes during object creation, after setting all properties.
function edit_s2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s3 as text
%        str2double(get(hObject,'String')) returns contents of edit_s3 as a double


% --- Executes during object creation, after setting all properties.
function edit_s3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s4 as text
%        str2double(get(hObject,'String')) returns contents of edit_s4 as a double


% --- Executes during object creation, after setting all properties.
function edit_s4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s5 as text
%        str2double(get(hObject,'String')) returns contents of edit_s5 as a double


% --- Executes during object creation, after setting all properties.
function edit_s5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s6 as text
%        str2double(get(hObject,'String')) returns contents of edit_s6 as a double


% --- Executes during object creation, after setting all properties.
function edit_s6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=getappdata(0,'attenuated_srs');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 

% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_s1 and none of its controls.
function edit_s1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_s1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_s2 and none of its controls.
function edit_s2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_s2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_s3 and none of its controls.
function edit_s3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_s3 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_s4 and none of its controls.
function edit_s4_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_s4 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_s5 and none of its controls.
function edit_s5_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_s5 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_s6 and none of its controls.
function edit_s6_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_s6 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');
