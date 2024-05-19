function varargout = Martin_Marietta_shock_distance_joints(varargin)
% MARTIN_MARIETTA_SHOCK_DISTANCE_JOINTS MATLAB code for Martin_Marietta_shock_distance_joints.fig
%      MARTIN_MARIETTA_SHOCK_DISTANCE_JOINTS, by itself, creates a new MARTIN_MARIETTA_SHOCK_DISTANCE_JOINTS or raises the existing
%      singleton*.
%
%      H = MARTIN_MARIETTA_SHOCK_DISTANCE_JOINTS returns the handle to a new MARTIN_MARIETTA_SHOCK_DISTANCE_JOINTS or the handle to
%      the existing singleton*.
%
%      MARTIN_MARIETTA_SHOCK_DISTANCE_JOINTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MARTIN_MARIETTA_SHOCK_DISTANCE_JOINTS.M with the given input arguments.
%
%      MARTIN_MARIETTA_SHOCK_DISTANCE_JOINTS('Property','Value',...) creates a new MARTIN_MARIETTA_SHOCK_DISTANCE_JOINTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Martin_Marietta_shock_distance_joints_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Martin_Marietta_shock_distance_joints_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Martin_Marietta_shock_distance_joints

% Last Modified by GUIDE v2.5 30-Apr-2021 16:27:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Martin_Marietta_shock_distance_joints_OpeningFcn, ...
                   'gui_OutputFcn',  @Martin_Marietta_shock_distance_joints_OutputFcn, ...
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


% --- Executes just before Martin_Marietta_shock_distance_joints is made visible.
function Martin_Marietta_shock_distance_joints_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Martin_Marietta_shock_distance_joints (see VARARGIN)

% Choose default command line output for Martin_Marietta_shock_distance_joints
handles.output = hObject;

pushbutton_reset_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Martin_Marietta_shock_distance_joints wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)

set(handles.uipanel_save,'Visible','off');


iu=get(handles.listbox_units,'Value');


Ncolumns=3;

Nrows=get(handles.listbox_num,'Value');
 
A=get(handles.uitable_data,'Data');

[data_s]=clear_data_s(Nrows);


if(~isempty(A))
    
    sz=size(A);
    Arows=sz(1);    
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end

if(iu==1)
    cn={'Type','Delta Distance (in)','Plateau Remaining Ratio'};
else
    cn={'Type','Delta Distance (m)','Plateau Remaining Ratio'};
end

try
    set(handles.uitable_data,'Data',data_s,'ColumnName',cn);
catch
    warndlg('set failed');
    return;
end


% --- Outputs from this function are returned to the command line.
function varargout = Martin_Marietta_shock_distance_joints_OutputFcn(hObject, eventdata, handles) 
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

delete(Martin_Marietta_shock_distance_joints);


function[data_s]=clear_data_s(Nrows)

for i=1:Nrows
        data_s{i,1}='';
        data_s{i,2}='';
        data_s{i,3}='';
end

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * * * * * ');
disp('  ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CV=get(handles.listbox_CV,'Value');

iu=get(handles.listbox_units,'Value');


A=get(handles.uitable_data,'Data');

Ncolumns=3;
Nrows=get(handles.listbox_num,'Value');

k=1;
for i=1:Nrows
    channela{i}=A{k}; k=k+1;
end
for i=1:Nrows
    channelb{i}=A{k}; k=k+1;
end

for i=1:Nrows
    channelc{i}=A{k}; k=k+1;
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

nrp=get(handles.listbox_rp,'Value');

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

for i=1:Nrows

    ca=channela{i};
    cb=char(channelb{i});
    cc=char(channelc{i});
    
    if(contains(ca,'Joint'))
 
        v=str2double(cc);
        
        out1=sprintf('\n Step %d   Joint   %g plateau remaining',i,v);
        disp(out1);        
        
        [srs2]=SRS_plateau_attenuation(srs1,v);        
        
    else   
        
        v=str2double(cb);

        if(contains(ca,'Cylindrical Shell'))
            sq='Cylindrical Shell';
            n=1;
        end    
        if(contains(ca,'Longeron or Stringer'))
            sq='Longeron or Stringer';
            n=2;
        end    
        if(contains(ca,'Skin/Ring Frame'))
            sq='Skin/Ring Frame';
            n=3;
        end    
        if(contains(ca,'Primary Truss'))
            sq='Primary Truss';
            n=4;
        end    
        if(contains(ca,'Complex Airframe'))
            sq='Complex Airframe';
            n=5;
        end           
        if(contains(ca,'Complex Equipment Structure'))
            sq='Complex Equipment Structure';
            n=6;
        end    
        if(contains(ca,'Honeycomb'))
            sq='Honeycomb';
            n=7;
        end          
        
        if(iu==1)
            out1=sprintf('\n Step %d  %s   Delta Distance=%g in',i,sq,v);
            disp(out1);
        else
            out1=sprintf('\n Step %d  %s   Delta Distance=%g m',i,sq,v);
            disp(out1);            
        end
        
        x2=v+x1;
        
        xx1=x1;
        xx2=x2;
        
        if(iu==2)
            xx1=x1*100/2.54;
            xx2=x2*100/2.54;            
        end  

        [attr1,attp1]=MM_ramp_plateau(xx1,n);
        [attr2,attp2]=MM_ramp_plateau(xx2,n);
        
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
        
        if(nrp==2)
            attr=attp;
        end
        
        if(attr<attp)
            attr=attp;
        end
        
        out1=sprintf('\n  Remaining:  ramp=%6.3g   plateau=%6.3g ',attr,attp);
        disp(out1);
        
        f=srs1(:,1);
        a=srs1(:,2);
        
        [f,a]=srs_distance_atten_ramp_plateau(attp,attr,f,a);
        srs2=[f a];
        
        x1=x2;
            
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


if(CV==1)

    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
else
    ppp50=[fmin 0.8*fmin; fmax 0.8*fmax ];
    leg50='50 ips';

    [fig_num,h2]=plot_loglog_function_md_three_h2_third_dash(fig_num,x_label,...
                  y_label,t_string,ppp1,ppp2,ppp50,leg1,leg2,leg50,fmin,fmax,md);    
end
            
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

output_name_6dB=sprintf('%s_6dB',output_name);
assignin('base', output_name_6dB, [data(:,1) 2*data(:,2)]);

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


% --- Executes on selection change in listbox_units.
function listbox13_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


% --- Executes during object creation, after setting all properties.
function listbox13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox15.
function listbox15_Callback(hObject, eventdata, handles)
% hObject    handle to listbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox15 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox15


% --- Executes during object creation, after setting all properties.
function listbox15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function uitable_data_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% pushbutton_change(hObject, eventdata, handles);

% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in uitable_data.
function uitable_data_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)



% --- Executes when entered data in editable cell(s) in uitable_data.
function uitable_data_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
%%pushbutton_change(hObject, eventdata, handles);

% disp('edit')

A=get(handles.uitable_data,'Data');

Ncolumns=3;
Nrows=get(handles.listbox_num,'Value');

k=1;
for i=1:Nrows
    channela{i}=A{k}; k=k+1;
end
for i=1:Nrows
    channelb{i}=A{k}; k=k+1;
end

for i=1:Nrows
    channelc{i}=A{k}; k=k+1;
end



for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}=A{i,j};
    end
end

for i=1:Nrows
    ca=channela{i};
    cb=channelb{i};
    cc=channelc{i};
    if(contains(ca,'Joint'))
            data_s{i,2}='n/a';
            if(contains(cc,'n/a'))
                data_s{i,3}='';
            end
    else   
            data_s{i,3}='n/a';
            if(contains(cb,'n/a'))
                data_s{i,2}='';
            end            
    end    
end


set(handles.uitable_data,'Data',data_s);





% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Nrows=get(handles.listbox_num,'Value');

[data_s]=clear_data_s(Nrows);

set(handles.uitable_data,'Data',data_s);

listbox_num_Callback(hObject, eventdata, handles);


% --- Executes on selection change in listbox_rp.
function listbox_rp_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_rp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_rp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_rp


% --- Executes during object creation, after setting all properties.
function listbox_rp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_rp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    output=get(handles.edit_output_array,'String');
    MMshock.output=output;      
catch
end

try
    iu=get(handles.listbox_units,'Value'); 
    MMshock.iu=iu;      
catch
end

try
    input_array=get(handles.edit_input_array,'String'); 
    MMshock.input_array=input_array;      
catch
end

try
    title=get(handles.edit_title,'String'); 
    MMshock.title=title;      
catch
end

try
    rp=get(handles.listbox_rp,'Value'); 
    MMshock.rp=rp;      
catch
end

try
    num=get(handles.listbox_num,'Value'); 
    MMshock.num=num;      
catch
end

try
    data=get(handles.uitable_data,'data'); 
    MMshock.data=data;      
catch
end



% % %
 
structnames = fieldnames(MMshock, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'MMshock'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');



% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat', 'Select plot save file');

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

MMshock=evalin('base','MMshock');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%

try
    output=MMshock.output;    
    set(handles.edit_output_array,'String',output);
catch
end   

try
    iu=MMshock.iu;     
    set(handles.listbox_units,'Value',iu);      
catch
end

try
    input_array=MMshock.input_array;    
    set(handles.edit_input_array,'String',input_array);       
catch
end

try
    title=MMshock.title;      
    set(handles.edit_title,'String',title);     
catch
end

try
    rp=MMshock.rp;     
    set(handles.listbox_rp,'Value',rp);      
catch
end

try
    num=MMshock.num;         
    set(handles.listbox_num,'Value',num);  
catch
end

try
    data=MMshock.data;    
    set(handles.uitable_data,'data',data);       
catch
end


% --- Executes on selection change in listbox_CV.
function listbox_CV_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_CV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_CV contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_CV


% --- Executes during object creation, after setting all properties.
function listbox_CV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_CV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
