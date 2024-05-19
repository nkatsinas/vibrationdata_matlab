function varargout = plate_fea_transmissibility(varargin)
% PLATE_FEA_TRANSMISSIBILITY MATLAB code for plate_fea_transmissibility.fig
%      PLATE_FEA_TRANSMISSIBILITY, by itself, creates a new PLATE_FEA_TRANSMISSIBILITY or raises the existing
%      singleton*.
%
%      H = PLATE_FEA_TRANSMISSIBILITY returns the handle to a new PLATE_FEA_TRANSMISSIBILITY or the handle to
%      the existing singleton*.
%
%      PLATE_FEA_TRANSMISSIBILITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATE_FEA_TRANSMISSIBILITY.M with the given input arguments.
%
%      PLATE_FEA_TRANSMISSIBILITY('Property','Value',...) creates a new PLATE_FEA_TRANSMISSIBILITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plate_fea_transmissibility_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plate_fea_transmissibility_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plate_fea_transmissibility

% Last Modified by GUIDE v2.5 02-Mar-2022 10:59:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plate_fea_transmissibility_OpeningFcn, ...
                   'gui_OutputFcn',  @plate_fea_transmissibility_OutputFcn, ...
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


% --- Executes just before plate_fea_transmissibility is made visible.
function plate_fea_transmissibility_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plate_fea_transmissibility (see VARARGIN)

% Choose default command line output for plate_fea_transmissibility
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

fig_num=300;
setappdata(0,'tfig',fig_num);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plate_fea_transmissibility wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plate_fea_transmissibility_OutputFcn(hObject, eventdata, handles) 
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

delete(plate_fea_transmissibility);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

if(n==1)
    data=getappdata(0,'accel_H');
end
if(n==2)
    data=getappdata(0,'rel_disp_H');
end

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete');



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=getappdata(0,'tfig');

num_modes=str2num(get(handles.edit_num_modes,'String'));

node=str2num(get(handles.edit_node,'String'));

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

damp=getappdata(0,'damp_ratio');

iu=getappdata(0,'iu');


%% fn=getappdata(0,'part_fn');
omega=getappdata(0,'part_omega');
ModeShapes=getappdata(0,'part_ModeShapes');

sz=size(ModeShapes);

for i=1:sz(1)
    for j=1:sz(2)
        if(isnan(ModeShapes(i,j)))
            warndlg('ModeShape error');
            return;
        end
        if(isinf(ModeShapes(i,j)))
            warndlg('ModeShapes error');
            return;
        end           
    end
end
 
for i=1:length(omega)
    if(isnan(omega(i)))
        warndlg('omega error');
        return;
    end
    if(isinf(omega(i)))
        warndlg('omega error');
        return;
    end    
end


MST=ModeShapes';


TT=getappdata(0,'TT');


Mwd=getappdata(0,'Mwd');
Mww=getappdata(0,'Mww');



ngw=getappdata(0,'ngw');

TZ_tracking_array=getappdata(0,'TZ_tracking_array');

nem=getappdata(0,'nem');

sz=size(Mww);
nff=sz(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omegan=omega;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ndf=get(handles.listbox_df,'Value');



oct=2^(1/96);

f=zeros(10000,1);

f(1)=fmin;

k=2;
while(1)

    if(ndf==1)
        f(k)=f(k-1)+1;
    end    
    if(ndf==2)
        f(k)=f(k-1)+0.5;
    end
    if(ndf==3)     
        f(k)=f(k-1)*oct;
    end
    
    if(f(k)>fmax)
        f(k)=fmax;
        break;
    end
    
    k=k+1;
end

f=f(1:k);

[f,acc,rd]=fea_transmissibility_core(f,nff,nem,ModeShapes,MST,Mwd,...
                                damp,omegan,TT,ngw,TZ_tracking_array,node,num_modes);

ah=[f acc];

ppp=ah;

t_string=sprintf('Acceleration Transmissibility at node %d',node);

x_label='Frequency (Hz)';
y_label='Trans (G/G)';

md=6;

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


if(iu==1)
    y_label='Trans (in/G)';
    scale=386;
else
    y_label='Trans (mm/G)';
    scale=9.81*1000;    
end  


rh=[f scale*rd];
ppp=rh;
    
t_string=sprintf('Relative Displacement Trans at node %d',node);

x_label='Frequency (Hz)';

md=6;

if(max(rd)>1.0e-08 && min(rd)>1.0e-80)

    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
else
    msgbox(' Relative displacement is zero at this node .'); 
end    
    
    
%%

maxHA=0.;
maxHrd=0.;

for k=1:length(f)
          
        if(acc(k)>maxHA)
            maxHA=acc(k);
            maxFA=f(k);
        end
   
        if(rh(k,2)>maxHrd)
            maxHrd=rh(k,2);
            maxFrd=f(k);
        end        
  
end


out1=sprintf('\n  max Accel Trans    = %8.4g (G/G) at %8.4g Hz ',maxHA,maxFA);
disp(out1);

if(max(rd)>1.0e-08 && min(rd)>1.0e-80)
    if(iu==1)
        out1=sprintf('\n  max Rel Disp Trans = %8.4g (in/G) at %8.4g Hz ',maxHrd,maxFrd);
    else
        out1=sprintf('\n  max Rel Disp Trans = %8.4g (mm/G) at %8.4g Hz ',maxHrd,maxFrd);    
    end
    disp(out1);
end


disp(' ');

%%

setappdata(0,'tfig',fig_num);
setappdata(0,'accel_H',ah);

set(handles.uipanel_save,'Visible','on');



function edit_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_modes as text
%        str2double(get(hObject,'String')) returns contents of edit_num_modes as a double


% --- Executes during object creation, after setting all properties.
function edit_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_df.
function listbox_df_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_df contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_df


% --- Executes during object creation, after setting all properties.
function listbox_df_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
