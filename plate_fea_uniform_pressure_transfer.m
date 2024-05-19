function varargout = plate_fea_uniform_pressure_transfer(varargin)
% PLATE_FEA_UNIFORM_PRESSURE_TRANSFER MATLAB code for plate_fea_uniform_pressure_transfer.fig
%      PLATE_FEA_UNIFORM_PRESSURE_TRANSFER, by itself, creates a new PLATE_FEA_UNIFORM_PRESSURE_TRANSFER or raises the existing
%      singleton*.
%
%      H = PLATE_FEA_UNIFORM_PRESSURE_TRANSFER returns the handle to a new PLATE_FEA_UNIFORM_PRESSURE_TRANSFER or the handle to
%      the existing singleton*.
%
%      PLATE_FEA_UNIFORM_PRESSURE_TRANSFER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATE_FEA_UNIFORM_PRESSURE_TRANSFER.M with the given input arguments.
%
%      PLATE_FEA_UNIFORM_PRESSURE_TRANSFER('Property','Value',...) creates a new PLATE_FEA_UNIFORM_PRESSURE_TRANSFER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plate_fea_uniform_pressure_transfer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plate_fea_uniform_pressure_transfer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plate_fea_uniform_pressure_transfer

% Last Modified by GUIDE v2.5 07-Aug-2018 12:10:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plate_fea_uniform_pressure_transfer_OpeningFcn, ...
                   'gui_OutputFcn',  @plate_fea_uniform_pressure_transfer_OutputFcn, ...
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


% --- Executes just before plate_fea_uniform_pressure_transfer is made visible.
function plate_fea_uniform_pressure_transfer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plate_fea_uniform_pressure_transfer (see VARARGIN)

% Choose default command line output for plate_fea_uniform_pressure_transfer
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

fig_num=300;
setappdata(0,'tfig',fig_num);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plate_fea_uniform_pressure_transfer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plate_fea_uniform_pressure_transfer_OutputFcn(hObject, eventdata, handles) 
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

delete(plate_fea_uniform_pressure_transfer);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

if(n==1)
    data=getappdata(0,'Ha');
end
if(n==2)
    data=getappdata(0,'Hv');
end
if(n==3)
    data=getappdata(0,'Hd');
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

disp(' ');
disp(' * * * * * * * * ');
disp(' ');



try
    fig_num=getappdata(0,'tfig');
catch
    fig_num=900;
end

if(isempty(fig_num))
    fig_num=900;
end
   

num_modes=str2num(get(handles.edit_num_modes,'String'));

node=str2num(get(handles.edit_node,'String'));

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

fn=getappdata(0,'fn');
damp=getappdata(0,'damp_ratio');


iu=getappdata(0,'iu');

QE=getappdata(0,'ModeShapes');

constraint_matrix=getappdata(0,'constraint_matrix');

node_matrix=getappdata(0,'node_matrix');

szn=size(node_matrix);
NL=szn(1);

sz=size(constraint_matrix);
CL=sz(1);


dof_matrix=zeros(NL,3);


for i=1:CL
    j=constraint_matrix(i,1);
    dof_matrix(j,:)=[ constraint_matrix(i,2) constraint_matrix(i,3) constraint_matrix(i,4)  ];
end


% dof matrix  row index is node.   Three columns for TZ, RX, RY.  1=constrained
% dof_matrix


nzeros=nnz(~dof_matrix);

cr_matrix=zeros(nzeros,2);


k=1;

for i=1:NL
   
    if(dof_matrix(i,1)==0)
        cr_matrix(k,:)=[i 1];
        k=k+1;
    end
    if(dof_matrix(i,2)==0)
        cr_matrix(k,:)=[i 2];
        k=k+1;
    end    
    if(dof_matrix(i,3)==0)
        cr_matrix(k,:)=[i 3];
        k=k+1;
    end    

    
end    

response_dof=0;

for i=1:nzeros
    if(node==cr_matrix(i,1) && cr_matrix(i,2)==1)
        response_dof=i;
    end
end

if(response_dof==0)
   warndlg('Response node not found');
   return;
end

% cr matrix format:  node & free dof
% cr_matrix

out1=sprintf('Response Node at dof = %d ',response_dof);
disp(out1);


k=1;

for i=1:nzeros
    if(cr_matrix(i,2)==1)
        zz(k,1)=i;
        zz(k,2)=cr_matrix(i,1);
        k=k+1;
    end
end

% zz format;  z-dof  node
% zz

zzn=length(zz(:,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f(1)=fmin;
oct=2^(1/96);

k=2;
while(1)
    f(k)=f(k-1)*oct;
    
    if(f(k)>fmax)
        f(k)=fmax;
        break;
    end
    
    k=k+1;
end

tpi=2*pi;

omega=tpi*f;
omega2=omega.*omega;
omegan=tpi*fn;
omn2=omegan.*omegan;

% [~, index] = min(abs(fmax-fn));

num_columns=min([length(damp) length(damp) num_modes]);


L=getappdata(0,'L');
W=getappdata(0,'W'); 

area=L*W;

out1=sprintf('\n  area=%8.4g  L=%8.4g  W=%8.4g \n',area,L,W);
disp(out1);


pressure=1;

total_force=pressure*area;

nodal_force=total_force/NL;

out1=sprintf('\n total_force=%8.4g  nodal_force=%7.3g  \n',total_force,nodal_force);
disp(out1);


%%%%%%%%%


[Ha,Hv,Hd]=plate_transfer_fea(f,fn,QE,response_dof,num_columns,damp,omegan,omega,zz);



pause(0.3);
progressbar(1);


try
    Ha=Ha*nodal_force;
    Hv=Hv*nodal_force;
    Hd=Hd*nodal_force;
catch
    out1=sprintf('H error: i=%d  zzn=%d  nf=%d ',i,zzn,nf);
    warndlg(out1);
    return; 
end



%%%%%%%%%

if(iu==1)
    Ha=Ha/386;
    ya_label='Accel/Pressure (G/psi)';
    yv_label='Vel/Pressure (in/sec/psi)';
    yd_label='Disp/Pressure (in/psi)';
    ssa='(G/psi)';
    ssv='(in/sec/psi)';
    ssd='(in/psi)';
else 
    Ha=Ha/9.81;
    ya_label='Accel/Pressure (G/Pa)';
    yv_label='Vel/Pressure (m/sec/Pa)';
    yd_label='Disp/Pressure (m/Pa)';    
    ssa='(G/Pa)';
    ssv='(m/sec/Pa)';
    ssd='(m/Pa)';    
end


%%%%%%%%%

md=4;
freq=f;


t_string='Acceleration Transfer Function';

[fig_num]=plot_frf_md(fig_num,freq,Ha,fmin,fmax,t_string,ya_label,md);

%%%%%%%%%

t_string='Velocity Transfer Function';

[fig_num]=plot_frf_md(fig_num,freq,Hv,fmin,fmax,t_string,yv_label,md);

%%%%%%%%%

t_string='Displacement Transfer Function';

[fig_num]=plot_frf_md(fig_num,freq,Hd,fmin,fmax,t_string,yd_label,md);

%%%%%%%%%

freq=fix_size(freq);

[axmax,aymax]=find_max([freq abs(Ha)]);
[vxmax,vymax]=find_max([freq abs(Hv)]);
[dxmax,dymax]=find_max([freq abs(Hd)]);



disp(' ');
disp(' Maximum Values');
disp(' ');

out1=sprintf('Acceleration/Pressure:  %7.4g Hz, %7.4g %s',aymax,axmax,ssa);
out2=sprintf('    Velocity/Pressure:  %7.4g Hz, %7.4g %s',vymax,vxmax,ssv);
out3=sprintf('Displacement/Pressure:  %7.4g Hz, %7.4g %s',dymax,dxmax,ssd);

disp(out1);
disp(out2);
disp(out3);
disp(' ');

%%%%%%%%%

setappdata(0,'Ha',[freq Ha]);
setappdata(0,'Hv',[freq Hv]);
setappdata(0,'Hd',[freq Hd]);


setappdata(0,'tfig',fig_num);

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
