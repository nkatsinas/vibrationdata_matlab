function varargout = nastran_base_input_frf_data_table_nodes(varargin)
% NASTRAN_BASE_INPUT_FRF_DATA_TABLE_NODES MATLAB code for nastran_base_input_frf_data_table_nodes.fig
%      NASTRAN_BASE_INPUT_FRF_DATA_TABLE_NODES, by itself, creates a new NASTRAN_BASE_INPUT_FRF_DATA_TABLE_NODES or raises the existing
%      singleton*.
%
%      H = NASTRAN_BASE_INPUT_FRF_DATA_TABLE_NODES returns the handle to a new NASTRAN_BASE_INPUT_FRF_DATA_TABLE_NODES or the handle to
%      the existing singleton*.
%
%      NASTRAN_BASE_INPUT_FRF_DATA_TABLE_NODES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NASTRAN_BASE_INPUT_FRF_DATA_TABLE_NODES.M with the given input arguments.
%
%      NASTRAN_BASE_INPUT_FRF_DATA_TABLE_NODES('Property','Value',...) creates a new NASTRAN_BASE_INPUT_FRF_DATA_TABLE_NODES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nastran_base_input_frf_data_table_nodes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nastran_base_input_frf_data_table_nodes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nastran_base_input_frf_data_table_nodes

% Last Modified by GUIDE v2.5 04-Aug-2021 14:51:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nastran_base_input_frf_data_table_nodes_OpeningFcn, ...
                   'gui_OutputFcn',  @nastran_base_input_frf_data_table_nodes_OutputFcn, ...
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


% --- Executes just before nastran_base_input_frf_data_table_nodes is made visible.
function nastran_base_input_frf_data_table_nodes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nastran_base_input_frf_data_table_nodes (see VARARGIN)

% Choose default command line output for nastran_base_input_frf_data_table_nodes
handles.output = hObject;

change_list(hObject, eventdata, handles);

listbox_rd_Callback(hObject, eventdata, handles);

set(handles.listbox_units,'Value',2);

clear(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nastran_base_input_frf_data_table_nodes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nastran_base_input_frf_data_table_nodes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function clear(hObject, eventdata, handles)
%
set(handles.pushbutton_sine,'Enable','off');
set(handles.uipanel_post,'Visible','off');
set(handles.uipanel_PSD,'Visible','off');



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end 


   iu=get(handles.listbox_units,'Value');
   setappdata(0,'iu',iu);
   
   setappdata(0,'metric_displacement',0);
   setappdata(0,'metric_velocity',0);
   setappdata(0,'metric_acceleration',0);
   
   
   
   fig_num=1;
   setappdata(0,'fig_num',fig_num);
 
   disp('  ');
   disp(' * * * * * * * * * * * * * * ');
   disp('  ');
 
   try
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        THM=importdata(filename);
        THM=THM.data';
   catch
        warndlg('File not opened'); 
        return; 
   end
  
sz=size(THM)   
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
   
ii=get(handles.listbox_first,'Value'); 
jj=get(handles.listbox_second,'Value'); 
kk=get(handles.listbox_third,'Value'); 

num=1;
if(jj~=4)
    num=num+1;
end
if(kk~=4)
    num=num+1;
end

fmin=str2num(get(handles.edit_fmin,'String'));
df=str2num(get(handles.edit_df,'String'));

STHM=THM(2:end,:);

if(fmin==0)
    STHM(1,:)=[];
    fmin=df;
end

sz=size(STHM);

nrows=sz(1);
nID=sz(2);

nx=floor(3*nrows/num);



f=((1:nx)-1)*df+fmin;
f=fix_size(f);

for i=1:nID         % number of nodes
    
    amp_t1=zeros(nx,num);
    amp_t2=zeros(nx,num);
    amp_t3=zeros(nx,num);  
    
    for j=1:num     % number of amplitude metric
        for k=1:nx  % number of frequency cases per amplitude metric
            
            amp_t1(k,j)=STHM(3*k-2,i);
            amp_t2(k,j)=STHM(3*k-1,i);
            amp_t3(k,j)=STHM(3*k,i);        
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    if(ii==1)
        name=sprintf('node_%d_T1_accel_frf',[f THM(i,1)]);
        assignin('base',name,amp_t1(:,1));
        name=sprintf('node_%d_T2_accel_frf',[f THM(i,1)]);
        assignin('base',name,amp_t2(:,1));
        name=sprintf('node_%d_T3_accel_frf',[f THM(i,1)]);
        assignin('base',name,amp_t3(:,1));  
    end
    if(ii==2)
        name=sprintf('node_%d_T1_vel_frf',[f THM(i,1)]);       
        assignin('base',name,amp_t1(:,1));
        name=sprintf('node_%d_T2_vel_frf',[f THM(i,1)]);       
        assignin('base',name,amp_t2(:,1));
        name=sprintf('node_%d_T3_vel_frf',[f THM(i,1)]);        
        assignin('base',name,amp_t3(:,1));         
    end   
    if(ii==3)
        name=sprintf('node_%d_T1_disp_frf',[f THM(i,1)]);               
        assignin('base',name,amp_t1(:,1));
        name=sprintf('node_%d_T2_disp_frf',[f THM(i,1)]);         
        assignin('base',name,amp_t2(:,1));
        name=sprintf('node_%d_T3_disp_frf',[f THM(i,1)]);          
        assignin('base',name,amp_t3(:,1));         
    end  
%%  
    if(jj==1)
        assignin('base',name,amp_t1(:,2));
        assignin('base',name,amp_t2(:,2));
        assignin('base',name,amp_t3(:,2));  
    end
    if(jj==2)
        assignin('base',name,amp_t1(:,2));
        assignin('base',name,amp_t2(:,2));
        assignin('base',name,amp_t3(:,2));         
    end   
    if(jj==3)
        assignin('base',name,amp_t1(:,2));
        assignin('base',name,amp_t2(:,2));
        assignin('base',name,amp_t3(:,2));         
    end  
%%  
    if(kk==1)
        assignin('base',name,amp_t1(:,3));
        assignin('base',name,amp_t2(:,3));
        assignin('base',name,amp_t3(:,3));  
    end
    if(kk==2)
        assignin('base',name,amp_t1(:,3));
        assignin('base',name,amp_t2(:,3));
        assignin('base',name,amp_t3(:,3));         
    end   
    if(kk==3)
        assignin('base',name,amp_t1(:,3));
        assignin('base',name,amp_t2(:,3));
        assignin('base',name,amp_t3(:,3));         
    end       
    
end



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(nastran_base_input_frf);


% --- Executes on button press in radiobutton_displacement.
function radiobutton_displacement_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_displacement


% --- Executes on button press in radiobutton_velocity.
function radiobutton_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_velocity


% --- Executes on button press in radiobutton_acceleration.
function radiobutton_acceleration_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_acceleration


% --- Executes on button press in radiobutton_plate_quad4_stress.
function radiobutton_plate_quad4_stress_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_plate_quad4_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_plate_quad4_stress


% --- Executes on button press in radiobutton_plate_tria3_stress.
function radiobutton_plate_tria3_stress_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_plate_tria3_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_plate_tria3_stress


% --- Executes on selection change in listbox_rd.
function listbox_rd_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_rd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_rd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_rd

clear(hObject, eventdata, handles);

n=get(handles.listbox_rd,'Value');


set(handles.text_reference_node,'Visible','off');
set(handles.edit_reference_node,'Visible','off');    
 
if(n==1)
    set(handles.text_reference_node,'Visible','on');
    set(handles.edit_reference_node,'Visible','on');
end



% --- Executes during object creation, after setting all properties.
function listbox_rd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_rd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_reference_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reference_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reference_node as text
%        str2double(get(hObject,'String')) returns contents of edit_reference_node as a double


% --- Executes during object creation, after setting all properties.
function edit_reference_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_base_input_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_base_input_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_base_input_node as text
%        str2double(get(hObject,'String')) returns contents of edit_base_input_node as a double


% --- Executes during object creation, after setting all properties.
function edit_base_input_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_base_input_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_axis.
function listbox_axis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_axis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_axis
clear(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_axis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_axis (see GCBO)
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
clear(hObject, eventdata, handles);

n=get(handles.listbox_units,'Value');

if(n==1)
    ss='Accel (in/sec^2)';
end
if(n==2)
    ss='Accel (G)';    
end
if(n==3)
    ss='Accel (m/sec^2)';
end
if(n==4)
    ss='Accel (G)';      
end

set(handles.text_amp,'String',ss);
    


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


function plot_displacement(hObject, eventdata, handles)      
   

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_df,'String'));

nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_node_disp=getappdata(0,'num_node_disp');
node_disp=getappdata(0,'node_disp');
nrd=getappdata(0,'nrd');
reference_node=getappdata(0,'reference_node');
    
xlabel3='Freq (Hz)';

iu=getappdata(0,'iu');

if(iu==1)
    su='Disp(in)/Accel(in/sec^2)';
    sr='Rel Disp(in)/Accel(in/sec^2)';
end
if(iu==2)
    su='Disp(in)/Accel(G)'; 
    sr='Rel Disp(in)/Accel(G)';
end
if(iu==3)
    su='Disp(m)/Accel(m/sec^2)'; 
    sr='Rel Disp(in)/Accel(m/sec^2)';    
end
if(iu==4)
    su='Disp(m)/Accel(G)';
    sr='Rel Disp(in)/Accel(G)';    
end


        
ylabel1=su;
ylabel2=su;
ylabel3=su;        
        
for i=1:num_node_disp
            
    node=node_disp(i);
        
    output_T1=sprintf('disp_%d_mag_frf_T1',node);
    output_T2=sprintf('disp_%d_mag_frf_T2',node);            
    output_T3=sprintf('disp_%d_mag_frf_T3',node);     
            
    data1=evalin('base',output_T1); 
    data2=evalin('base',output_T2); 
    data3=evalin('base',output_T3);  
          
    t_string1=sprintf('Transmissibilty FRF  Node %d T1',node);
    t_string2=sprintf('Transmissibilty FRF  Node %d T2',node);
    t_string3=sprintf('Transmissibilty FRF  Node %d T3',node);
          
    pdata1=data1;
    pdata2=data2;
    pdata3=data3;

    for j=nf:-1:1
        if(pdata1(j,1)<fmin || pdata1(j,1)>fmax)
            pdata1(j,:)=[];
        end
        if(pdata2(j,1)<fmin || pdata2(j,1)>fmax)
            pdata2(j,:)=[];
        end
        if(pdata3(j,1)<fmin || pdata3(j,1)>fmax)
            pdata3(j,:)=[];
        end    
    end    

    f=pdata1(:,1);
    if(fmax>max(f))
        fmax=max(f);
    end
    
    
    [fig_num]=subplots_three_loglog_three_titles_ff(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,pdata1,pdata2,pdata3,t_string1,t_string2,t_string3,fmin,fmax);
    
end

if(nrd==1)
    
    ylabel1=sr;
    ylabel2=sr;
    ylabel3=sr;       

    for i=1:num_node_disp
    
        node=node_disp(i);
    
        if(node~=reference_node)
        
            output_T1=sprintf('rel_disp_mag_frf_%d_%d_T1',node,reference_node);
            output_T2=sprintf('rel_disp_mag_frf_%d_%d_T2',node,reference_node);            
            output_T3=sprintf('rel_disp_mag_frf_%d_%d_T3',node,reference_node);     
            
            data1=evalin('base',output_T1); 
            data2=evalin('base',output_T2); 
            data3=evalin('base',output_T3);  
          
            t_string1=sprintf('Transmissibilty FRF  Node %d - %d T1',node,reference_node);
            t_string2=sprintf('Transmissibilty FRF  Node %d - %d T2',node,reference_node);
            t_string3=sprintf('Transmissibilty FRF  Node %d - %d T3',node,reference_node);
          
            pdata1=data1;
            pdata2=data2;
            pdata3=data3;

            for j=nf:-1:1
                if(pdata1(j,1)<fmin || pdata1(j,1)>fmax)
                    pdata1(j,:)=[];
                end
                if(pdata2(j,1)<fmin || pdata2(j,1)>fmax)
                    pdata2(j,:)=[];
                end
                if(pdata3(j,1)<fmin || pdata3(j,1)>fmax)
                    pdata3(j,:)=[];
                end    
            end    
    
            
            f=pdata1(:,1);
            if(fmax>max(f))
                fmax=max(f);
            end
            
            [fig_num]=subplots_three_loglog_three_titles_ff(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,pdata1,pdata2,pdata3,t_string1,t_string2,t_string3,fmin,fmax);
        
        end
    
    end

end    
    
setappdata(0,'fig_num',fig_num);
        

function plot_velocity(hObject, eventdata, handles)      



fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_df,'String'));

nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_node_velox=getappdata(0,'num_node_velox');
node_velox=getappdata(0,'node_velox');
nrd=getappdata(0,'nrd');
reference_node=getappdata(0,'reference_node');
    
xlabel3='Freq (Hz)';

iu=getappdata(0,'iu');

if(iu==1)
    su='Vel(in/sec)/Accel(in/sec^2)'; 
    sr='Rel Vel(in/sec)/Accel(in/sec^2)'; 
end
if(iu==2)
    su='Vel(in/sec)/Accel(G)';
    sr='Rel Vel(in/sec)/Accel(G)';
end
if(iu==3)
    su='Vel(m/sec)/Accel(m/sec^2)';
    sr='Rel Vel(m/sec)/Accel(m/sec^2)';
end
if(iu==4)
    su='Vel(m/sec)/Accel(G)';
    sr='Rel Vel(m/sec)/Accel(G)';
end


        
ylabel1=su;
ylabel2=su;
ylabel3=su;        
        
for i=1:num_node_velox
            
    node=node_velox(i);
        
    output_T1=sprintf('velox_%d_mag_frf_T1',node);
    output_T2=sprintf('velox_%d_mag_frf_T2',node);            
    output_T3=sprintf('velox_%d_mag_frf_T3',node);     
            
    data1=evalin('base',output_T1); 
    data2=evalin('base',output_T2); 
    data3=evalin('base',output_T3);  
          
    t_string1=sprintf('Transmissibilty FRF  Node %d T1',node);
    t_string2=sprintf('Transmissibilty FRF  Node %d T2',node);
    t_string3=sprintf('Transmissibilty FRF  Node %d T3',node);
          
    pdata1=data1;
    pdata2=data2;
    pdata3=data3;

    for j=nf:-1:1
        if(pdata1(j,1)<fmin || pdata1(j,1)>fmax)
            pdata1(j,:)=[];
        end
        if(pdata2(j,1)<fmin || pdata2(j,1)>fmax)
            pdata2(j,:)=[];
        end
        if(pdata3(j,1)<fmin || pdata3(j,1)>fmax)
            pdata3(j,:)=[];
        end    
    end    
    
    f=pdata1(:,1);
    if(fmax>max(f))
        fmax=max(f);
    end
    
    [fig_num]=subplots_three_loglog_three_titles_ff(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,pdata1,pdata2,pdata3,t_string1,t_string2,t_string3,fmin,fmax);
    
end

if(nrd==1)
    
    ylabel1=sr;
    ylabel2=sr;
    ylabel3=sr;       

    for i=1:num_node_velox
    
        node=node_velox(i);
    
        if(node~=reference_node)
        
            output_T1=sprintf('rel_velox_mag_frf_%d_%d_T1',node,reference_node);
            output_T2=sprintf('rel_velox_mag_frf_%d_%d_T2',node,reference_node);            
            output_T3=sprintf('rel_velox_mag_frf_%d_%d_T3',node,reference_node);     
            
            data1=evalin('base',output_T1); 
            data2=evalin('base',output_T2); 
            data3=evalin('base',output_T3);  
          
            t_string1=sprintf('Transmissibilty FRF  Node %d - %d T1',node,reference_node);
            t_string2=sprintf('Transmissibilty FRF  Node %d - %d T2',node,reference_node);
            t_string3=sprintf('Transmissibilty FRF  Node %d - %d T3',node,reference_node);
          
            pdata1=data1;
            pdata2=data2;
            pdata3=data3;

            for j=nf:-1:1
                if(pdata1(j,1)<fmin || pdata1(j,1)>fmax)
                    pdata1(j,:)=[];
                end
                if(pdata2(j,1)<fmin || pdata2(j,1)>fmax)
                    pdata2(j,:)=[];
                end
                if(pdata3(j,1)<fmin || pdata3(j,1)>fmax)
                    pdata3(j,:)=[];
                end    
            end    
    
            f=pdata1(:,1);
            if(fmax>max(f))
                fmax=max(f);
            end           
            
            [fig_num]=subplots_three_loglog_three_titles_ff(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,pdata1,pdata2,pdata3,t_string1,t_string2,t_string3,fmin,fmax);
        
        end
    
    end
end

setappdata(0,'fig_num',fig_num);


function plot_acceleration(hObject, eventdata, handles)      
   

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_df,'String'));

nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_node_accel=getappdata(0,'num_node_accel');
node_accel=getappdata(0,'node_accel');


xlabel3='Freq (Hz)';

iu=getappdata(0,'iu');

if(iu==1)
    su='Accel(in/sec^2)/Accel(in/sec^2)'; 
end
if(iu==2)
    su='Accel(G)/Accel(G)'; 
end
if(iu==3)
    su='Accel(m/sec^2)/Accel(m/sec^2)'; 
end
if(iu==4)
    su='Accel(G)/Accel(G)'; 
end


        
ylabel1=su;
ylabel2=su;
ylabel3=su;        
        
for i=1:num_node_accel
            
    node=node_accel(i);
        
    output_T1=sprintf('accel_%d_mag_frf_T1',node);
    output_T2=sprintf('accel_%d_mag_frf_T2',node);            
    output_T3=sprintf('accel_%d_mag_frf_T3',node);     
            
    data1=evalin('base',output_T1); 
    data2=evalin('base',output_T2); 
    data3=evalin('base',output_T3);  
          
    t_string1=sprintf('Transmissibilty FRF  Node %d T1',node);
    t_string2=sprintf('Transmissibilty FRF  Node %d T2',node);
    t_string3=sprintf('Transmissibilty FRF  Node %d T3',node);
          
    pdata1=data1;
    pdata2=data2;
    pdata3=data3;

    for j=nf:-1:1
        if(pdata1(j,1)<fmin || pdata1(j,1)>fmax)
            pdata1(j,:)=[];
        end
        if(pdata2(j,1)<fmin || pdata2(j,1)>fmax)
            pdata2(j,:)=[];
        end
        if(pdata3(j,1)<fmin || pdata3(j,1)>fmax)
            pdata3(j,:)=[];
        end    
    end    
    
    f=pdata1(:,1);
    if(fmax>max(f))
        fmax=max(f);
    end    
    
    try
        [fig_num]=subplots_three_loglog_three_titles_ff(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,pdata1,pdata2,pdata3,t_string1,t_string2,t_string3,fmin,fmax);
    catch
    end
end
        

setappdata(0,'fig_num',fig_num);





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



function edit_df_Callback(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_df as text
%        str2double(get(hObject,'String')) returns contents of edit_df as a double


% --- Executes during object creation, after setting all properties.
function edit_df_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%

function plot_quad4stress(hObject, eventdata, handles)      
   

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_df,'String'));

nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_elem_quad4stress=getappdata(0,'num_elem_quad4stress');
elem_quad4stress=getappdata(0,'elem_quad4stress');

    
x_label='Freq (Hz)';

iu=getappdata(0,'iu');

if(iu==1)
    su='Stress(psi)/Accel(in/sec^2)'; 
end
if(iu==2)
    su='Stress(psi)/Accel(G)'; 
end
if(iu==3)
    su='Stress(Pa)/Accel(m/sec^2)'; 
end
if(iu==4)
    su='Stress(Pa)/Accel(G)'; 
end


        
y_label=su;
        
for i=1:num_elem_quad4stress
            
    elem=elem_quad4stress(i);
        
    output_T1=sprintf('quad4_stress_VM_frf_%d',elem);   
            
    data1=evalin('base',output_T1); 
          
    t_string=sprintf('Von Mises Stress Trans FRF  Elem %d ',elem);
          
    ppp=data1;

    for j=nf:-1:1
        if(ppp(j,1)<fmin || ppp(j,1)>fmax)
            ppp(j,:)=[];
        end  
    end    
    
    f=ppp(:,1);
    if(fmax>max(f))
        fmax=max(f);
    end    
    
    [fig_num]=plot_loglog_function(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
    
end

%%%%%%%%

function plot_quad4strain(hObject, eventdata, handles)      
   

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_df,'String'));

nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_elem_quad4strain=getappdata(0,'num_elem_quad4strain');
elem_quad4strain=getappdata(0,'elem_quad4strain');

    
x_label='Freq (Hz)';

iu=getappdata(0,'iu');

if(iu==1)
    su='Strain/Accel(in/sec^2)'; 
end
if(iu==2)
    su='Strain/Accel(G)'; 
end
if(iu==3)
    su='Strain/Accel(m/sec^2)'; 
end
if(iu==4)
    su='Strain/Accel(G)'; 
end


        
y_label=su;
        
for i=1:num_elem_quad4strain
            
    elem=elem_quad4strain(i);
        
    output_T1=sprintf('quad4_strain_VM_frf_%d',elem);   
            
    data1=evalin('base',output_T1); 
          
    t_string=sprintf('Von Mises Strain Trans FRF  Elem %d ',elem);
          
    ppp=data1;

    for j=nf:-1:1
        if(ppp(j,1)<fmin || ppp(j,1)>fmax)
            ppp(j,:)=[];
        end  
    end    
    
    f=ppp(:,1);
    if(fmax>max(f))
         fmax=max(f);
    end    
    
    [fig_num]=plot_loglog_function(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
    
end


%%%%%%%%

function plot_tria3stress(hObject, eventdata, handles)      
   

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_df,'String'));

nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_elem_tria3stress=getappdata(0,'num_elem_tria3stress');
elem_tria3stress=getappdata(0,'elem_tria3stress');

    
x_label='Freq (Hz)';

iu=getappdata(0,'iu');

if(iu==1)
    su='Stress(psi)/Accel(in/sec^2)'; 
end
if(iu==2)
    su='Stress(psi)/Accel(G)'; 
end
if(iu==3)
    su='Stress(Pa)/Accel(m/sec^2)'; 
end
if(iu==4)
    su='Stress(Pa)/Accel(G)'; 
end


        
y_label=su;
        
for i=1:num_elem_tria3stress
            
    elem=elem_tria3stress(i);
        
    output_T1=sprintf('tria3_stress_VM_frf_%d',elem);   
            
    data1=evalin('base',output_T1); 
          
    t_string=sprintf('Von Mises Stress Trans FRF  Elem %d ',elem);
          
    ppp=data1;

    for j=nf:-1:1
        if(ppp(j,1)<fmin || ppp(j,1)>fmax)
            ppp(j,:)=[];
        end  
    end    
    
    
    f=ppp(:,1);
    if(fmax>max(f))
         fmax=max(f);
    end     
    
    [fig_num]=plot_loglog_function(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
    
end

setappdata(0,'fig_num',fig_num);


% --- Executes on button press in pushbutton_sine.
function pushbutton_sine_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_post,'Visible','on'); 
set(handles.uipanel_PSD,'Visible','off'); 


function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_amp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amp as text
%        str2double(get(hObject,'String')) returns contents of edit_amp as a double


% --- Executes during object creation, after setting all properties.
function edit_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_reference_node and none of its controls.
function edit_reference_node_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference_node (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_base_input_node and none of its controls.
function edit_base_input_node_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_base_input_node (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_response.
function pushbutton_response_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


num_node_accel=getappdata(0,'num_node_accel');
node_accel=getappdata(0,'node_accel');

num_node_velox=getappdata(0,'num_node_velox');
node_velox=getappdata(0,'node_velox');

num_node_disp=getappdata(0,'num_node_disp');
node_disp=getappdata(0,'node_disp');

num_elem_quad4stress =getappdata(0,'num_elem_quad4stress');
elem_quad4stress=getappdata(0,'elem_quad4stress');

num_elem_tria3stress=getappdata(0,'num_elem_tria3stress');
elem_tria3stress=getappdata(0,'elem_tria3stress');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fsine=str2num(get(handles.edit_freq,'String'));
amp=str2num(get(handles.edit_amp,'String'));
iu=get(handles.listbox_units,'Value');

nrd=get(handles.listbox_rd,'Value');

if(nrd==1)
    node_ref=str2num(get(handles.edit_reference_node,'String'));
end

if(iu==1)
    su='in/sec^2';
    sv='in/sec';
    sd='in';
    svm='psi';
end
if(iu==2)
    su='G';
    sv='in/sec';
    sd='in';
    svm='psi';    
end
if(iu==3)
    su='m/sec^2';
    sv='m/sec';
    sd='m';
    svm='Pa';    
end
if(iu==4)
    su='G';
    sv='m/sec';
    sd='m';
    svm='Pa';     
end


threshold=1.0e-09;



if(num_node_accel>=1)

   disp(' ');
   out1=sprintf('            Acceleration (%s)   ',su);
   out2=sprintf(' Node         T1         T2         T3  ');
   disp(out1);
   disp(out2);
    
   for i=1:num_node_accel 
    
       accel_T1=0;
       accel_T2=0;
       accel_T3=0;
       
       node=node_accel(i);
       
       sss=sprintf('accel_%d_mag_frf_T1',node);
       T1=evalin('base',sss); 
       sss=sprintf('accel_%d_mag_frf_T2',node);
       T2=evalin('base',sss);       
       sss=sprintf('accel_%d_mag_frf_T3',node);
       T3=evalin('base',sss);
       
       sss=sprintf('accel_%d_mag_frf_R1',node);
       R1=evalin('base',sss); 
       sss=sprintf('accel_%d_mag_frf_R2',node);
       R2=evalin('base',sss);       
       sss=sprintf('accel_%d_mag_frf_R3',node);
       R3=evalin('base',sss);      
       
       freq=T1(:,1);
       
       for j=1:(length(freq)-1)
       
           if(fsine==freq(j))
               accel_T1=T1(j,2)*amp;
               accel_T2=T2(j,2)*amp;
               accel_T3=T3(j,2)*amp;               
               break;
           end
           if(fsine==freq(j+1))
               accel_T1=T1(j+1,2)*amp;
               accel_T2=T2(j+1,2)*amp;
               accel_T3=T3(j+1,2)*amp;                   
               break;
           end 
           if(freq(j)<fsine && fsine<freq(j+1))
               
               df=freq(j+1)-freq(j);
               C2=(fsine-freq(j))/df;
               C1=1-C2;
               
               TT1=C1*T1(j,2)+C2*T1(j+1,2);
               TT2=C1*T2(j,2)+C2*T2(j+1,2);               
               TT3=C1*T3(j,2)+C2*T3(j+1,2);
               
               accel_T1=TT1*amp;
               accel_T2=TT2*amp;
               accel_T3=TT3*amp;           
                          
               break;
           end           
           
       end
      
       if(accel_T1<threshold)
            accel_T1=0;
       end
       if(accel_T2<threshold)
            accel_T2=0;
       end
       if(accel_T3<threshold)
            accel_T3=0;
       end           
       
       out1=sprintf('  %d \t %8.4g \t %8.4g \t %8.4g ',node,accel_T1,accel_T2,accel_T3);
       disp(out1);   
       
       
   end    
    
end    


if(num_node_velox>=1)

   disp(' ');
   out1=sprintf('            Velocity (%s)   ',sv);
   out2=sprintf(' Node         T1         T2         T3  ');
   disp(out1);
   disp(out2);
    
   for i=1:num_node_velox 
    
       velox_T1=0;
       velox_T2=0;
       velox_T3=0;
       
       node=node_velox(i);
       
       sss=sprintf('velox_%d_mag_frf_T1',node);
       T1=evalin('base',sss); 
       sss=sprintf('velox_%d_mag_frf_T2',node);
       T2=evalin('base',sss);       
       sss=sprintf('velox_%d_mag_frf_T3',node);
       T3=evalin('base',sss);
       
       sss=sprintf('velox_%d_mag_frf_R1',node);
       R1=evalin('base',sss); 
       sss=sprintf('velox_%d_mag_frf_R2',node);
       R2=evalin('base',sss);       
       sss=sprintf('velox_%d_mag_frf_R3',node);
       R3=evalin('base',sss);      
       
       freq=T1(:,1);
       
       for j=1:(length(freq)-1)
       
           if(fsine==freq(j))
               velox_T1=T1(j,2)*amp;
               velox_T2=T2(j,2)*amp;
               velox_T3=T3(j,2)*amp;               
               break;
           end
           if(fsine==freq(j+1))
               velox_T1=T1(j+1,2)*amp;
               velox_T2=T2(j+1,2)*amp;
               velox_T3=T3(j+1,2)*amp;                   
               break;
           end 
           if(freq(j)<fsine && fsine<freq(j+1))

               
               df=freq(j+1)-freq(j);
               C2=(fsine-freq(j))/df;
               C1=1-C2;
               
               TT1=C1*T1(j,2)+C2*T1(j+1,2);
               TT2=C1*T2(j,2)+C2*T2(j+1,2);               
               TT3=C1*T3(j,2)+C2*T3(j+1,2);
               
               velox_T1=TT1*amp;
               velox_T2=TT2*amp;
               velox_T3=TT3*amp;           
                    
               break;
           end           
           
       end
   
       if(velox_T1<threshold)
            velox_T1=0;
       end
       if(velox_T2<threshold)
            velox_T2=0;
       end
       if(velox_T3<threshold)
            velox_T3=0;
       end        
       
       out1=sprintf('  %d \t %8.4g \t %8.4g \t %8.4g ',node,velox_T1,velox_T2,velox_T3);
       disp(out1);   
           
   end    
   
   if(nrd==1)
       
      disp(' ');
      out1=sprintf('           Relative Velocity (%s)   ',sv);
      out2=sprintf(' Node         T1         T2         T3  ');
      disp(out1);
      disp(out2);
    
      for i=1:num_node_velox 
    
          rel_velox_T1=0;
          rel_velox_T2=0;
          rel_velox_T3=0;
          
          node=node_velox(i);
          
          if(node~=node_ref)
       
             sss=sprintf('rel_velox_mag_frf_%d_%d_T1',node,node_ref);
             T1=evalin('base',sss); 
             sss=sprintf('rel_velox_mag_frf_%d_%d_T2',node,node_ref);  
             T2=evalin('base',sss);       
             sss=sprintf('rel_velox_mag_frf_%d_%d_T3',node,node_ref);
             T3=evalin('base',sss);
       
             freq=T1(:,1);
       
             for j=1:(length(freq)-1)
       
                 if(fsine==freq(j))
                     rel_velox_T1=T1(j,2)*amp;
                     rel_velox_T2=T2(j,2)*amp;
                     rel_velox_T3=T3(j,2)*amp;               
                     break;
                 end
                 if(fsine==freq(j+1))
                     rel_velox_T1=T1(j+1,2)*amp;
                     rel_velox_T2=T2(j+1,2)*amp;
                     rel_velox_T3=T3(j+1,2)*amp;                   
                     break;
                 end 
                 if(freq(j)<fsine && fsine<freq(j+1))

                     df=freq(j+1)-freq(j);
                     C2=(fsine-freq(j))/df;
                     C1=1-C2;
               
                     TT1=C1*T1(j,2)+C2*T1(j+1,2);
                     TT2=C1*T2(j,2)+C2*T2(j+1,2);               
                     TT3=C1*T3(j,2)+C2*T3(j+1,2);
               
                     rel_velox_T1=TT1*amp;
                     rel_velox_T2=TT2*amp;
                     rel_velox_T3=TT3*amp;           
                    
                     break;
                 end           
             end
   
             if(rel_velox_T1<threshold)
                  rel_velox_T1=0;
             end
             if(rel_velox_T2<threshold)
                  rel_velox_T2=0;
             end
             if(rel_velox_T3<threshold)
                  rel_velox_T3=0;
             end        
       
             out1=sprintf('  %d \t %8.4g \t %8.4g \t %8.4g ',node,rel_velox_T1,rel_velox_T2,rel_velox_T3);
             disp(out1);  
         end
      end
       
   end
   
end

if(num_node_disp>=1)
 
   disp(' ');
   out1=sprintf('            Displacement (%s)   ',sd);
   out2=sprintf(' Node         T1         T2         T3  ');
   disp(out1);
   disp(out2);
    
   for i=1:num_node_disp 
    
       disp_T1=0;
       disp_T2=0;
       disp_T3=0;
       
       node=node_disp(i);
       
       sss=sprintf('disp_%d_mag_frf_T1',node);
       T1=evalin('base',sss); 
       sss=sprintf('disp_%d_mag_frf_T2',node);
       T2=evalin('base',sss);       
       sss=sprintf('disp_%d_mag_frf_T3',node);
       T3=evalin('base',sss);
       
       sss=sprintf('disp_%d_mag_frf_R1',node);
       R1=evalin('base',sss); 
       sss=sprintf('disp_%d_mag_frf_R2',node);
       R2=evalin('base',sss);       
       sss=sprintf('disp_%d_mag_frf_R3',node);
       R3=evalin('base',sss);      
       
       freq=T1(:,1);
       
       for j=1:(length(freq)-1)
       
           if(fsine==freq(j))
               disp_T1=T1(j,2)*amp;
               disp_T2=T2(j,2)*amp;
               disp_T3=T3(j,2)*amp;               
               break;
           end
           if(fsine==freq(j+1))
               disp_T1=T1(j+1,2)*amp;
               disp_T2=T2(j+1,2)*amp;
               disp_T3=T3(j+1,2)*amp;                   
               break;
           end 
           if(freq(j)<fsine && fsine<freq(j+1))
               
               df=freq(j+1)-freq(j);
               C2=(fsine-freq(j))/df;
               C1=1-C2;
               
               TT1=C1*T1(j,2)+C2*T1(j+1,2);
               TT2=C1*T2(j,2)+C2*T2(j+1,2);               
               TT3=C1*T3(j,2)+C2*T3(j+1,2);
               
               disp_T1=TT1*amp;
               disp_T2=TT2*amp;
               disp_T3=TT3*amp;           
               
               
               break;
           end           
           
       end
   

       if(disp_T1<threshold)
            disp_T1=0;
       end
       if(disp_T2<threshold)
            disp_T2=0;
       end
       if(disp_T3<threshold)
            disp_T3=0;
       end               

       out1=sprintf('  %d \t %8.4g \t %8.4g \t %8.4g ',node,disp_T1,disp_T2,disp_T3);
       disp(out1);   
       
       
   end
   
   if(nrd==1)
       
      disp(' ');
      out1=sprintf('           Relative Displacement (%s)   ',sd);
      out2=sprintf(' Node         T1         T2         T3  ');
      disp(out1);
      disp(out2);
    
      for i=1:num_node_disp 
    
          rel_disp_T1=0;
          rel_disp_T2=0;
          rel_disp_T3=0;
          
          node=node_disp(i);
          
          if(node~=node_ref)
       
             sss=sprintf('rel_disp_mag_frf_%d_%d_T1',node,node_ref);
             T1=evalin('base',sss); 
             sss=sprintf('rel_disp_mag_frf_%d_%d_T2',node,node_ref);  
             T2=evalin('base',sss);       
             sss=sprintf('rel_disp_mag_frf_%d_%d_T3',node,node_ref);
             T3=evalin('base',sss);
       
             freq=T1(:,1);
       
             for j=1:(length(freq)-1)
       
                 if(fsine==freq(j))
                     rel_disp_T1=T1(j,2)*amp;
                     rel_disp_T2=T2(j,2)*amp;
                     rel_disp_T3=T3(j,2)*amp;               
                     break;
                 end
                 if(fsine==freq(j+1))
                     rel_disp_T1=T1(j+1,2)*amp;
                     rel_disp_T2=T2(j+1,2)*amp;
                     rel_disp_T3=T3(j+1,2)*amp;                   
                     break;
                 end 
                 if(freq(j)<fsine && fsine<freq(j+1))
 
                     df=freq(j+1)-freq(j);
                     C2=(fsine-freq(j))/df;
                     C1=1-C2;
               
                     TT1=C1*T1(j,2)+C2*T1(j+1,2);
                     TT2=C1*T2(j,2)+C2*T2(j+1,2);               
                     TT3=C1*T3(j,2)+C2*T3(j+1,2);
               
                     rel_disp_T1=TT1*amp;
                     rel_disp_T2=TT2*amp;
                     rel_disp_T3=TT3*amp;           
                    
                     break;
                 end           
             end
   
             if(rel_disp_T1<threshold)
                  rel_disp_T1=0;
             end
             if(rel_disp_T2<threshold)
                  rel_disp_T2=0;
             end
             if(rel_disp_T3<threshold)
                  rel_disp_T3=0;
             end        
       
             out1=sprintf('  %d \t %8.4g \t %8.4g \t %8.4g ',node,rel_disp_T1,rel_disp_T2,rel_disp_T3);
             disp(out1);  
         end
      end
       
   end
end   

if(num_elem_quad4stress>=1 && min(elem_quad4stress)>=1)

  
      disp(' ');
      out1=sprintf('  Quad4    Von Mises'); 
      out2=sprintf(' Element   Stress (%s) ',svm);
      disp(out1);
      disp(out2);      
      
      for i=1:num_elem_quad4stress 
    
          VM_stress=0;
       
          elem=elem_quad4stress(i);
       
          sss=sprintf('quad4_VM_frf_%d',elem);
          VMS=evalin('base',sss); 

       
          freq=T1(:,1);
       
          for j=1:(length(freq)-1)
       
              if(fsine==freq(j))
                  VM_stress=VMS(j,2)*amp;              
                  break;
              end
              if(fsine==freq(j+1))
                  VM_stress=VMS(j+1,2)*amp;              
                  break;
              end 
              if(freq(j)<fsine && fsine<freq(j+1))
               
                  df=freq(j+1)-freq(j);
                  C2=(fsine-freq(j))/df;
                  C1=1-C2;
               
                  TT=C1*VMS(j,2)+C2*VMS(j+1,2);
               
                  VM_stress=TT*amp;
                                 
                  break;
              end           
           
          end
      
          if(VM_stress<threshold)
               VM_stress=0;
          end
         
          out1=sprintf('  %d \t %8.4g ',elem,VM_stress);
          disp(out1);   
       
      end    
    
end
   
if(num_elem_tria3stress>=1 && min(elem_tria3stress)>=1)

      disp(' ');
      out1=sprintf('  Tria3    Von Mises'); 
      out2=sprintf(' Element   Stress (%s) ',svm);
      disp(out1);
      disp(out2);
    
      for i=1:num_elem_tria3stress 
    
          VM_stress=0;
       
          elem=elem_tria3stress(i);
       
          sss=sprintf('tria3_VM_frf_%d',elem);
          VMS=evalin('base',sss); 

       
          freq=T1(:,1);
       
          for j=1:(length(freq)-1)
       
              if(fsine==freq(j))
                  VM_stress=VMS(j,2)*amp;              
                  break;
              end
              if(fsine==freq(j+1))
                  VM_stress=VMS(j+1,2)*amp;              
                  break;
              end 
              if(freq(j)<fsine && fsine<freq(j+1))
               
                  df=freq(j+1)-freq(j);
                  C2=(fsine-freq(j))/df;
                  C1=1-C2;
               
                  TT=C1*VMS(j,2)+C2*VMS(j+1,2);
               
                  VM_stress=TT*amp;
                                 
                  break;
              end           
           
          end
      
          if(VM_stress<threshold)
               VM_stress=0;
          end
         
          out1=sprintf('  %d \t %8.4g ',elem,VM_stress);
          disp(out1);   
       
      end    
    
end


% --- Executes on button press in pushbutton_PSD.
function pushbutton_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_PSD,'Visible','on');
set(handles.uipanel_post,'Visible','off'); 


function edit_psd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_psd as text
%        str2double(get(hObject,'String')) returns contents of edit_psd as a double


% --- Executes during object creation, after setting all properties.
function edit_psd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_response_PSD.
function pushbutton_response_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_response_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


fig_num=getappdata(0,'fig_num');

try
     FS=get(handles.edit_psd,'String');
     THM1=evalin('base',FS);   
catch
     warndlg('Input array does not exist.');
     return;
end

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_df,'String'));


%%%

num_elem_beamstress=getappdata(0,'num_elem_beamstress');
elem_beamstress=getappdata(0,'elem_beamstress');

num_node_accel=getappdata(0,'num_node_accel');
node_accel=getappdata(0,'node_accel');

num_node_velox=getappdata(0,'num_node_velox');
node_velox=getappdata(0,'node_velox');

num_node_disp=getappdata(0,'num_node_disp');
node_disp=getappdata(0,'node_disp');

num_elem_quad4stress =getappdata(0,'num_elem_quad4stress');
elem_quad4stress=getappdata(0,'elem_quad4stress');

num_elem_tria3stress=getappdata(0,'num_elem_tria3stress');
elem_tria3stress=getappdata(0,'elem_tria3stress');

iu=get(handles.listbox_units,'Value');

nrd=get(handles.listbox_rd,'Value');

if(nrd==1)
    node_ref=str2num(get(handles.edit_reference_node,'String'));
end

%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    su='in/sec^2 RMS';
    sv='in/sec RMS';
    sd='in RMS';
    svm='psi RMS';
end
if(iu==2)
    su='GRMS';
    sv='in/sec RMS';
    sd='in RMS';
    svm='psi RMS';    
end
if(iu==3)
    su='m/sec^2 RMS';
    sv='m/sec RMS';
    sd='m RMS';
    svm='Pa RMS';    
end
if(iu==4)
    su='GRMS';
    sv='m/sec RMS';
    sd='m RMS';
    svm='Pa RMS';     
end

%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    su2='Accel (in/sec^2)^2/Hz';
    sv2='Vel (in/sec)^2/Hz';
    sd2='Disp (in^2/Hz)';
    svm2='Stress (psi^2/Hz)';
end
if(iu==2)
    su2='Accel (G^2/Hz)';
    sv2='Vel (in/sec)^2/Hz';
    sd2='Disp (in^2/Hz)';
    svm2='Stress (psi^2/Hz)';    
end
if(iu==3)
    su2='Accel (m/sec^2)^2/Hz';
    sv2='Vel (m/sec)^2/Hz';
    sd2='Disp (m^2/Hz)';
    svm2='Stress (Pa^2/Hz)';    
end
if(iu==4)
    su2='Accel (G^2/Hz)';
    sv2='Vel (m/sec)^2/Hz';
    sd2='Disp (m^2/Hz)';
    svm2='Stress (Pa^2/Hz)';     
end

threshold=1.0e-05;

nni=get(handles.listbox_interpolation,'Value');

% szz =1  for display size on
%     =2  for display size off 

szz=2;
md=6;
x_label='Frequency (Hz)';

ijk=1; 
   

if(num_node_accel>=1)
    
   disp(' ');
   out1=sprintf('          Overall Acceleration (%s)   ',su);
   out2=sprintf(' Node         T1         T2         T3  ');
   disp(out1);
   disp(out2);
    
   for i=1:num_node_accel 
       
       node=node_accel(i);
       try
            sss=sprintf('accel_%d_power_trans_T1',node);
            T1_HH=evalin('base',sss);
       catch
       end
%       
       try
            sss=sprintf('accel_%d_power_trans_T2',node);
            T2_HH=evalin('base',sss);
       catch
       end
%       
       try
            sss=sprintf('accel_%d_power_trans_T3',node);
            T3_HH=evalin('base',sss);
       catch
       end
           
%%%

       [ff_T1,ab_T1,rms_T1]=trans_mult(szz,THM1,T1_HH,nni);
       [ff_T2,ab_T2,rms_T2]=trans_mult(szz,THM1,T2_HH,nni);
       [ff_T3,ab_T3,rms_T3]=trans_mult(szz,THM1,T3_HH,nni);
       
       
       if(rms_T1<1.0e-05)
           rms_T1=0;
       end
       if(rms_T2<1.0e-05)
           rms_T2=0;
       end
       if(rms_T3<1.0e-05)
           rms_T3=0;
       end       
       
%%%         
       
       out1=sprintf('  %d \t %7.3g \t %7.3g \t %7.3g ',node,rms_T1,rms_T2,rms_T3);
       disp(out1); 
       
       
       ppp1=[ff_T1,ab_T1];
       ppp2=[ff_T2,ab_T2];
       ppp3=[ff_T3,ab_T3];

       
        
       
       
       t_string1=sprintf('Accel PSD Node %d T1  %7.3g %s Overall',node,rms_T1,su);
       t_string2=sprintf('Accel PSD Node %d T2  %7.3g %s Overall',node,rms_T2,su);
       t_string3=sprintf('Accel PSD Node %d T3  %7.3g %s Overall',node,rms_T3,su); 
       
       output_T1=sprintf('accel_psd_node_%d_T1',node);
       output_T2=sprintf('accel_psd_node_%d_T2',node);
       output_T3=sprintf('accel_psd_node_%d_T3',node);
       
       
       f=ppp1(:,1);
       if(fmax>max(f))
            fmax=max(f);
       end        
       
       try 
            if(max(ab_T1)>threshold)
                [fig_num]=plot_loglog_function_md(fig_num,x_label,su2,t_string1,ppp1,fmin,fmax,md);
                assignin('base', output_T1, ppp1);  
                sfiles{ijk,:}=output_T1;
                ijk=ijk+1;
            end    
       catch
       end
       
       try
            if(max(ab_T2)>threshold)           
                [fig_num]=plot_loglog_function_md(fig_num,x_label,su2,t_string2,ppp2,fmin,fmax,md);
                assignin('base', output_T2, ppp2); 
                sfiles{ijk,:}=output_T2;    
                ijk=ijk+1;               
            end                
       catch
       end
       
       try
            if(max(ab_T3)>threshold)              
                [fig_num]=plot_loglog_function_md(fig_num,x_label,su2,t_string3,ppp3,fmin,fmax,md);
                assignin('base', output_T3, ppp3);
                sfiles{ijk,:}=output_T3;
                ijk=ijk+1; 
            end    
       catch
       end
       
   end    
   
 
    
end   

%%%%%%%%%%%%%%

if(num_node_velox>=1)

   disp(' ');
   out1=sprintf('          Overall Velocity (%s)   ',sv);
   out2=sprintf(' Node         T1         T2         T3  ');
   disp(out1);
   disp(out2);
    
   for i=1:num_node_velox 
       
       node=node_velox(i);
       try
            sss=sprintf('velox_%d_power_trans_T1',node);
            T1_HH=evalin('base',sss);
       catch
       end
%       
       try
            sss=sprintf('velox_%d_power_trans_T2',node);
            T2_HH=evalin('base',sss);
       catch
       end
%       
       try
            sss=sprintf('velox_%d_power_trans_T3',node);
            T3_HH=evalin('base',sss);
       catch
       end
           
%%%

       [ff_T1,ab_T1,rms_T1]=trans_mult(szz,THM1,T1_HH,nni);
       [ff_T2,ab_T2,rms_T2]=trans_mult(szz,THM1,T2_HH,nni);
       [ff_T3,ab_T3,rms_T3]=trans_mult(szz,THM1,T3_HH,nni);
       
       
       if(rms_T1<1.0e-05)
           rms_T1=0;
       end
       if(rms_T2<1.0e-05)
           rms_T2=0;
       end
       if(rms_T3<1.0e-05)
           rms_T3=0;
       end       
       
%%%         
       
       out1=sprintf('  %d \t %7.3g \t %7.3g \t %7.3g ',node,rms_T1,rms_T2,rms_T3);
       disp(out1); 
       
       
       ppp1=[ff_T1,ab_T1];
       ppp2=[ff_T2,ab_T2];
       ppp3=[ff_T3,ab_T3];
       
       
       t_string1=sprintf('velox PSD Node %d T1  %7.3g %s Overall',node,rms_T1,sv);
       t_string2=sprintf('velox PSD Node %d T2  %7.3g %s Overall',node,rms_T2,sv);
       t_string3=sprintf('velox PSD Node %d T3  %7.3g %s Overall',node,rms_T3,sv); 
       
       output_T1=sprintf('velox_psd_node_%d_T1',node);
       output_T2=sprintf('velox_psd_node_%d_T2',node);
       output_T3=sprintf('velox_psd_node_%d_T3',node);
       
       f=ppp1(:,1);
       if(fmax>max(f))
            fmax=max(f);
       end        
       
       try 
            if(max(ab_T1)>threshold)
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sv2,t_string1,ppp1,fmin,fmax,md);
                assignin('base', output_T1, ppp1);  
                sfiles{ijk,:}=output_T1;
                ijk=ijk+1;
            end    
       catch
       end
       
       try
            if(max(ab_T2)>threshold)           
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sv2,t_string2,ppp2,fmin,fmax,md);
                assignin('base', output_T2, ppp2); 
                sfiles{ijk,:}=output_T2;    
                ijk=ijk+1;               
            end                
       catch
       end
       
       try
            if(max(ab_T3)>threshold)              
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sv2,t_string3,ppp3,fmin,fmax,md);
                assignin('base', output_T3, ppp3);
                sfiles{ijk,:}=output_T3;
                ijk=ijk+1; 
            end    
       catch
       end
  
       
   end    

end  

if(num_node_velox>=1 && nrd==1)

   disp(' ');
   out1=sprintf('        Overall Relative Velocity (%s)   ',sv);
   out2=sprintf(' Node         T1         T2         T3  ');
   disp(out1);
   disp(out2);
    
   for i=1:num_node_velox 
       
       node=node_velox(i);
       
       if(node~=node_ref)
       
       
       try
            sss=sprintf('rel_velox_%d_power_trans_T1',node);
            T1_HH=evalin('base',sss);
       catch
       end
%       
       try
            sss=sprintf('rel_velox_%d_power_trans_T2',node);
            T2_HH=evalin('base',sss);
       catch
       end
%       
       try
            sss=sprintf('rel_velox_%d_power_trans_T3',node);
            T3_HH=evalin('base',sss);
       catch
       end
           
%%%

       [ff_T1,ab_T1,rms_T1]=trans_mult(szz,THM1,T1_HH,nni);
       [ff_T2,ab_T2,rms_T2]=trans_mult(szz,THM1,T2_HH,nni);
       [ff_T3,ab_T3,rms_T3]=trans_mult(szz,THM1,T3_HH,nni);
       
       
       if(rms_T1<1.0e-05)
           rms_T1=0;
       end
       if(rms_T2<1.0e-05)
           rms_T2=0;
       end
       if(rms_T3<1.0e-05)
           rms_T3=0;
       end       
       
%%%         
       
       out1=sprintf('  %d \t %7.3g \t %7.3g \t %7.3g ',node,rms_T1,rms_T2,rms_T3);
       disp(out1); 
       
       
       ppp1=[ff_T1,ab_T1];
       ppp2=[ff_T2,ab_T2];
       ppp3=[ff_T3,ab_T3];

       
        
       t_string1=sprintf('Rel Velox PSD Node %d - %d  T1  %7.3g %s Overall',node,node_ref,rms_T1,sv);
       t_string2=sprintf('Rel Velox PSD Node %d - %d  T2  %7.3g %s Overall',node,node_ref,rms_T2,sv);
       t_string3=sprintf('Rel Velox PSD Node %d - %d  T3  %7.3g %s Overall',node,node_ref,rms_T3,sv); 
       
       output_T1=sprintf('rel_velox_psd_node_%d_%d_T1',node,node_ref);
       output_T2=sprintf('rel_velox_psd_node_%d_%d_T2',node,node_ref);
       output_T3=sprintf('rel_velox_psd_node_%d_%d_T3',node,node_ref);
       
       
       f=ppp1(:,1);
       if(fmax>max(f))
            fmax=max(f);
       end 
       
       
       try 
            if(max(ab_T1)>threshold)
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sv2,t_string1,ppp1,fmin,fmax,md);
                assignin('base', output_T1, ppp1);  
                sfiles{ijk,:}=output_T1;
                ijk=ijk+1;
            end    
       catch
       end
       
       try
            if(max(ab_T2)>threshold)           
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sv2,t_string2,ppp2,fmin,fmax,md);
                assignin('base', output_T2, ppp2); 
                sfiles{ijk,:}=output_T2;    
                ijk=ijk+1;               
            end                
       catch
       end
       
       try
            if(max(ab_T3)>threshold)              
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sv2,t_string3,ppp3,fmin,fmax,md);
                assignin('base', output_T3, ppp3);
                sfiles{ijk,:}=output_T3;
                ijk=ijk+1; 
            end    
       catch
       end
  
       end
       
   end    

    
end 




if(num_node_disp>=1)

    
   d_threshold=1.0e-09; 
    
   disp(' ');
   out1=sprintf('          Overall Displacement (%s)   ',sd);
   out2=sprintf(' Node         T1         T2         T3  ');
   disp(out1);
   disp(out2);
    
   for i=1:num_node_disp 
       
       node=node_disp(i);
       try
            sss=sprintf('disp_%d_power_trans_T1',node);
            T1_HH=evalin('base',sss);
       catch
       end
%       
       try
            sss=sprintf('disp_%d_power_trans_T2',node);
            T2_HH=evalin('base',sss);
       catch
       end
%       
       try
            sss=sprintf('disp_%d_power_trans_T3',node);
            T3_HH=evalin('base',sss);
       catch
       end
           
%%%

       [ff_T1,ab_T1,rms_T1]=trans_mult(szz,THM1,T1_HH,nni);
       [ff_T2,ab_T2,rms_T2]=trans_mult(szz,THM1,T2_HH,nni);
       [ff_T3,ab_T3,rms_T3]=trans_mult(szz,THM1,T3_HH,nni);
       
       
       if(rms_T1<1.0e-05)
           rms_T1=0;
       end
       if(rms_T2<1.0e-05)
           rms_T2=0;
       end
       if(rms_T3<1.0e-05)
           rms_T3=0;
       end       
       
%%%         
       
       out1=sprintf('  %d \t %7.3g \t %7.3g \t %7.3g ',node,rms_T1,rms_T2,rms_T3);
       disp(out1); 
       
       
       ppp1=[ff_T1,ab_T1];
       ppp2=[ff_T2,ab_T2];
       ppp3=[ff_T3,ab_T3];
       
       
       t_string1=sprintf('disp PSD Node %d T1  %7.3g %s Overall',node,rms_T1,sd);
       t_string2=sprintf('disp PSD Node %d T2  %7.3g %s Overall',node,rms_T2,sd);
       t_string3=sprintf('disp PSD Node %d T3  %7.3g %s Overall',node,rms_T3,sd); 
       
       output_T1=sprintf('disp_psd_node_%d_T1',node);
       output_T2=sprintf('disp_psd_node_%d_T2',node);
       output_T3=sprintf('disp_psd_node_%d_T3',node);
       
       
       f=ppp1(:,1);
       if(fmax>max(f))
            fmax=max(f);
       end       
       
       
       try 
            if(max(ab_T1)>d_threshold)
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sd2,t_string1,ppp1,fmin,fmax,md);
                assignin('base', output_T1, ppp1);  
                sfiles{ijk,:}=output_T1;
                ijk=ijk+1;
            end    
       catch
       end
       
       try
            if(max(ab_T2)>d_threshold)           
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sd2,t_string2,ppp2,fmin,fmax,md);
                assignin('base', output_T2, ppp2); 
                sfiles{ijk,:}=output_T2;    
                ijk=ijk+1;               
            end                
       catch
       end
       
       try
            if(max(ab_T3)>d_threshold)              
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sd2,t_string3,ppp3,fmin,fmax,md);
                assignin('base', output_T3, ppp3);
                sfiles{ijk,:}=output_T3;
                ijk=ijk+1; 
            end    
       catch
       end
  
       
   end    

end  

if(num_node_disp>=1 && nrd==1)

   disp(' ');
   out1=sprintf('        Overall Relative Displacement (%s)   ',sd);
   out2=sprintf(' Node         T1         T2         T3  ');
   disp(out1);
   disp(out2);
    
   for i=1:num_node_disp 
       
       node=node_disp(i);
       
       if(node~=node_ref)
       
       
       try
            sss=sprintf('rel_disp_%d_power_trans_T1',node);
            T1_HH=evalin('base',sss);
       catch
       end
%       
       try
            sss=sprintf('rel_disp_%d_power_trans_T2',node);
            T2_HH=evalin('base',sss);
       catch
       end
%       
       try
            sss=sprintf('rel_disp_%d_power_trans_T3',node);
            T3_HH=evalin('base',sss);
       catch
       end
           
%%%

       [ff_T1,ab_T1,rms_T1]=trans_mult(szz,THM1,T1_HH,nni);
       [ff_T2,ab_T2,rms_T2]=trans_mult(szz,THM1,T2_HH,nni);
       [ff_T3,ab_T3,rms_T3]=trans_mult(szz,THM1,T3_HH,nni);
       
       
       if(rms_T1<1.0e-05)
           rms_T1=0;
       end
       if(rms_T2<1.0e-05)
           rms_T2=0;
       end
       if(rms_T3<1.0e-05)
           rms_T3=0;
       end       
       
%%%         
       
       out1=sprintf('  %d \t %7.3g \t %7.3g \t %7.3g ',node,rms_T1,rms_T2,rms_T3);
       disp(out1); 
       
       
       ppp1=[ff_T1,ab_T1];
       ppp2=[ff_T2,ab_T2];
       ppp3=[ff_T3,ab_T3];

       
        
       t_string1=sprintf('Rel disp PSD Node %d - %d  T1  %7.3g %s Overall',node,node_ref,rms_T1,sd);
       t_string2=sprintf('Rel disp PSD Node %d - %d  T2  %7.3g %s Overall',node,node_ref,rms_T2,sd);
       t_string3=sprintf('Rel disp PSD Node %d - %d  T3  %7.3g %s Overall',node,node_ref,rms_T3,sd); 
       
       output_T1=sprintf('rel_disp_psd_node_%d_%d_T1',node,node_ref);
       output_T2=sprintf('rel_disp_psd_node_%d_%d_T2',node,node_ref);
       output_T3=sprintf('rel_disp_psd_node_%d_%d_T3',node,node_ref);
       
       f=ppp1(:,1);
       if(fmax>max(f))
            fmax=max(f);
       end        
       
       try 
            if(max(ab_T1)>d_threshold)
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sd2,t_string1,ppp1,fmin,fmax,md);
                assignin('base', output_T1, ppp1);  
                sfiles{ijk,:}=output_T1;
                ijk=ijk+1;
            end    
       catch
       end
       
       try
            if(max(ab_T2)>d_threshold)           
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sd2,t_string2,ppp2,fmin,fmax,md);
                assignin('base', output_T2, ppp2); 
                sfiles{ijk,:}=output_T2;    
                ijk=ijk+1;               
            end                
       catch
       end
       
       try
            if(max(ab_T3)>d_threshold)              
                [fig_num]=plot_loglog_function_md(fig_num,x_label,sd2,t_string3,ppp3,fmin,fmax,md);
                assignin('base', output_T3, ppp3);
                sfiles{ijk,:}=output_T3;
                ijk=ijk+1; 
            end    
       catch
       end
  
       end
       
   end    
    
end 


if(num_elem_quad4stress>=1)
    
   disp(' ');
   out1=sprintf('          Overall Von Mises');
   out2=sprintf(' Elem     Stress (%s)   ',svm);         
   disp(out1);
   disp(out2);
    
   for i=1:num_elem_quad4stress 
       
       elem=elem_quad4stress(i);
       try
            sss=sprintf('quad4_stress_VM_power_trans_%d',elem);
            T1_HH=evalin('base',sss);
       catch
       end
%       
%%%

       [ff_T1,ab_T1,rms_T1]=trans_mult(szz,THM1,T1_HH,nni);
 
       if(rms_T1<1.0e-05)
           rms_T1=0;
       end
      
%%%         
       
       out1=sprintf('  %d \t %7.3g  ',elem,rms_T1);
       disp(out1); 
              
       ppp1=[ff_T1,ab_T1];

       t_string1=sprintf('Von Mises Elem %d T1  %7.3g %s Overall',elem,rms_T1,svm);
 
       
       output_T1=sprintf('quad4_VM_stress_elem_%d_T1',elem);

       
       f=ppp1(:,1);
       if(fmax>max(f))
            fmax=max(f);
       end        
       
       try 
            if(max(ab_T1)>threshold)
                [fig_num]=plot_loglog_function_md(fig_num,x_label,svm2,t_string1,ppp1,fmin,fmax,md);
                assignin('base', output_T1, ppp1);  
                sfiles{ijk,:}=output_T1;
                ijk=ijk+1;
            end    
       catch
       end
       
       
   end    
    
end

 
if(num_elem_tria3stress>=1)
    
   disp(' ');
   out1=sprintf('          Overall Von Mises');
   out2=sprintf(' Elem     Stress (%s)   ',svm);         
   disp(out1);
   disp(out2);
    
   for i=1:num_elem_tria3stress 
       
       elem=elem_tria3stress(i);
       try
            sss=sprintf('tria3_stress_VM_power_trans_%d',elem);
            T1_HH=evalin('base',sss);
       catch
       end
%       
%%%
 
       [ff_T1,ab_T1,rms_T1]=trans_mult(szz,THM1,T1_HH,nni);
 
       if(rms_T1<1.0e-05)
           rms_T1=0;
       end
      
%%%         
       
       out1=sprintf('  %d \t %7.3g  ',elem,rms_T1);
       disp(out1); 
              
       ppp1=[ff_T1,ab_T1];
 
       t_string1=sprintf('Von Mises Elem %d T1  %7.3g %s Overall',elem,rms_T1,svm);
 
       
       output_T1=sprintf('tria3_VM_stress_elem_%d_T1',elem);
 
       
       f=ppp1(:,1);
       if(fmax>max(f))
            fmax=max(f);
       end        
       
       
       try 
            if(max(ab_T1)>threshold)
                [fig_num]=plot_loglog_function_md(fig_num,x_label,svm2,t_string1,ppp1,fmin,fmax,md);
                assignin('base', output_T1, ppp1);  
                sfiles{ijk,:}=output_T1;
                ijk=ijk+1;
            end    
       catch
       end
       
       
   end    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(num_elem_beamstress>=1)  
    

   disp(' ');
   out1=sprintf('          Overall Longitudinal');
   out2=sprintf(' Elem     Stress (%s) at Each End  ',svm);              
   disp(out1);
   disp(out2);
    
   for i=1:num_elem_beamstress
       
       elem=elem_beamstress(i);
       try
            sss=sprintf('beam_longitudinal_stress_power_trans_1_%d',elem);
            T1_HH=evalin('base',sss);
       catch
       end   
       try
            sss=sprintf('beam_longitudinal_stress_power_trans_2_%d',elem);
            T2_HH=evalin('base',sss);
       catch
       end       
%       
%%%

       [ff_T1,ab_T1,rms_T1]=trans_mult(szz,THM1,T1_HH,nni);
 
       if(rms_T1<1.0e-05)
           rms_T1=0;
       end
      
%%%
       [ff_T2,ab_T2,rms_T2]=trans_mult(szz,THM1,T2_HH,nni);
 
       if(rms_T2<1.0e-05)
           rms_T2=0;
       end

%%%
       fprintf('  %d \t %8.4g \t %8.4g \n',elem,rms_T1,rms_T2);
 
       output_T1=sprintf('beam_longitudinal_stress_elem_%d_T1',elem);
       output_T2=sprintf('beam_longitudinal_stress_elem_%d_T2',elem);       
       
       ppp1=[ff_T1,ab_T1];
       ppp2=[ff_T2,ab_T2];       

       t_string=sprintf('Longitudinal Stress Elem %d  ',elem);
       md=6;
       
       leg1=sprintf('  First Node %8.4g %s Overall',rms_T1,svm);
       leg2=sprintf(' Second Node %8.4g %s Overall',rms_T2,svm);
       
       x_label='Frequency (Hz)';
       y_label=sprintf('%s',svm2);
       
       f=ppp1(:,1);
       if(fmax>max(f))
            fmax=max(f);
       end        
       
       try
                assignin('base', output_T1, ppp1);  
                sfiles{ijk,:}=output_T1;
                ijk=ijk+1;
                assignin('base', output_T2, ppp2);  
                sfiles{ijk,:}=output_T2;
                ijk=ijk+1;           
       catch
       end
       
       try 
            if(max(ab_T1)>threshold)
                [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                 y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
            end    
       catch
           warndlg('Stress plot failed');
       end
           
   end    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

out1=sprintf('\n ijk=%d \n',ijk);
disp(out1);

if(ijk>=2)

    disp(' PSD output arrays');
   
    for i=1:(ijk-1)
        out1=sprintf('  %s',sfiles{i,:});
        disp(out1);
    end

else
    
    disp('no output data');
    
end

%%%%%%%%%%%%%%

function plot_beamstress(hObject, eventdata, handles)      
   
fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_df,'String'));

nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_elem_beamstress=getappdata(0,'num_elem_beamstress');
elem_beamstress=getappdata(0,'elem_beamstress');

    
x_label='Freq (Hz)';

iu=getappdata(0,'iu');

if(iu==1)
    su='Stress(psi)/Accel(in/sec^2)'; 
end
if(iu==2)
    su='Stress(psi)/Accel(G)'; 
end
if(iu==3)
    su='Stress(Pa)/Accel(m/sec^2)'; 
end
if(iu==4)
    su='Stress(Pa)/Accel(G)'; 
end

md=6;
        
y_label=su;
        
for i=1:num_elem_beamstress
            
    elem=elem_beamstress(i);
        
    output_T1=sprintf('beam_longitudinal_stress_frf_1_%d',elem);
    output_T2=sprintf('beam_longitudinal_stress_frf_2_%d',elem);     
            
    ppp1=evalin('base',output_T1); 
    ppp2=evalin('base',output_T2);     
          
    t_string=sprintf('Longitudinal Stress Trans FRF Elem %d ',elem);
          

    for j=nf:-1:1
        if(ppp1(j,1)<fmin || ppp1(j,1)>fmax)
            ppp1(j,:)=[];
            ppp2(j,:)=[];           
        end  
    end    
    
    leg1='Grid 1';
    leg2='Grid 2';
    

    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);    
end



% --- Executes on selection change in listbox_interpolation.
function listbox_interpolation_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_interpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_interpolation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_interpolation


% --- Executes during object creation, after setting all properties.
function listbox_interpolation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_interpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_response_PSD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_response_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton_beam_stress.
function radiobutton_beam_stress_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_beam_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_beam_stress


% --- Executes on button press in radiobutton_plate_quad4_strain.
function radiobutton_plate_quad4_strain_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_plate_quad4_strain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_plate_quad4_strain


function find_quad4strain_elem(hObject, eventdata, handles)     
 
iquad4strain=getappdata(0,'iquad4strain');    
fn=getappdata(0,'fn');    
    
disp('    ');
disp(' Find quad4 strain response elements ');
disp('    ');

istart=iquad4strain(1);
iend=iquad4strain(2);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);

plate_strain_core(hObject, eventdata, handles);    
     
Z=getappdata(0,'Z');
   
try
    elem_quad4strain = Z(Z~=0);
catch
    warndlg('Quad strain elements not found');
    return;
end            
            
            
num_elem_quad4strain=length(elem_quad4strain);
   
for i=1:num_elem_quad4strain
    out1=sprintf('  %d',elem_quad4strain(i));
    disp(out1);
end  

setappdata(0,'num_elem_quad4strain',num_elem_quad4strain);
setappdata(0,'elem_quad4strain',elem_quad4strain);   
        
%%%

disp('    ');
disp(' Form QUAD 4 strain frfs ');
disp('    ');

setappdata(0,'num_elem_plate_strain',num_elem_quad4strain);
setappdata(0,'elem_plate_strain',elem_quad4strain);   
setappdata(0,'iplate_strain',iquad4strain);

plate_strain_frf(hObject, eventdata, handles);

quad4_normal_x=getappdata(0,'plate_normal_x');
quad4_normal_y=getappdata(0,'plate_normal_y');
quad4_shear=getappdata(0,'plate_shear');
quad4_VM=getappdata(0,'plate_VM');       

setappdata(0,'quad4_strain_normal_x',quad4_normal_x);
setappdata(0,'quad4_strain_normal_y',quad4_normal_y);
setappdata(0,'quad4_strain_shear',quad4_shear);
setappdata(0,'quad4_strain_VM_signed',quad4_VM);

%%%

disp('  ');
disp(' Writing QUAD4 strain arrays'); 
disp('  ');        
 
abase_mag=getappdata(0,'abase_mag');

nf=getappdata(0,'nf');


iu=getappdata(0,'iu');
 
scale=1;
 
if(iu==2)
    scale=386;
end
if(iu==4)
    scale=9.81;
end

quad4_VM_power_trans=zeros(nf,num_elem_quad4strain);

progressbar;

total=num_elem_quad4strain*nf;

for i=1:num_elem_quad4strain
     
    elem=elem_quad4strain(i);
        
    output_S1=sprintf('quad4_strain_normal_x_frf_%d',elem);
    output_S2=sprintf('quad4_strain_normal_y_frf_%d',elem);            
    output_S3=sprintf('quad4_strain_shear_frf_%d',elem);         
    output_S7=sprintf('quad4_strain_VM_frf_%d',elem);     
    output_S9=sprintf('quad4_strain_VM_power_trans_%d',elem);    

    for j=1:nf
        
        progressbar((i+j)/total);        
        
        quad4_normal_x(j,i)=scale*quad4_normal_x(j,i)/abase_mag(j);
        quad4_normal_y(j,i)=scale*quad4_normal_y(j,i)/abase_mag(j);
        quad4_shear(j,i)=scale*quad4_shear(j,i)/abase_mag(j);
        quad4_VM(j,i)=scale*quad4_VM(j,i)/abase_mag(j);
        quad4_VM_power_trans(j,i)=quad4_VM(j,i)^2;
    end
    
    assignin('base', output_S1, [fn quad4_normal_x(:,i)]);            
    assignin('base', output_S2, [fn quad4_normal_y(:,i)]); 
    assignin('base', output_S3, [fn quad4_shear(:,i)]);             
    assignin('base', output_S7, [fn quad4_VM(:,i)]); 
    assignin('base', output_S9, [fn quad4_VM_power_trans(:,i)]);    
    
    
%    disp(' ref 2')
%    max(abs( quad4_VM_signed(:,i)  ))
            
    output_TT=sprintf('%s\t %s\t %s',output_S1,output_S2,output_S3); 
    
    disp(output_TT);
    disp(output_S7); 
    disp(output_S9);    
   
end

progressbar(1);
    
%%

function plate_strain_core(hObject, eventdata, handles)    
   
j=1;
        
iflag=0;

jk=1;

istart=getappdata(0,'istart');
iend=getappdata(0,'iend');
sarray=getappdata(0,'sarray');

Zb=-999;

for i=istart:iend
                       
            ss=sarray{1}{i};
            
            k=strfind(ss, 'ID');
            kv=strfind(ss, 'ID.');
            
            if(~isempty(k) || ~isempty(kv) )
                
                while(1) 
                    ss=sarray{1}{i+j};
                    strs = strsplit(ss,' ');                    
                    

                    if(length(strs)>=10 && str2double(strs(1))==0 )
                        
                            ssz=str2double(strs(2));
                        
                            if(~isnan(ssz) && ssz~=0)
                          
                                Z(jk)=ssz; 
                            
                                if(Z(jk)==Zb)
                                    iflag=1;
                                    Z(jk)=[];
                                    break;
                                end
                            
                                if(jk==1)    
                                    Zb=Z(1);
                                end    
                            
                                jk=jk+1;
                            end
                    end
                   
                    j=j+1;
                    
                end
                
                if(iflag==1)
                    break;
                end                
              
            end

end

setappdata(0,'Z',Z);



%%%%%%%%

function change_list(hObject, eventdata, handles)


i=get(handles.listbox_first,'Value');
j=get(handles.listbox_second,'Value');
k=get(handles.listbox_third,'Value');

if(i==1 || j==1 || k==1)
    set(handles.text_crd,'Visible','on');
    set(handles.listbox_rd,'Visible','on');
else
    set(handles.text_crd,'Visible','off');
    set(handles.listbox_rd,'Visible','off');    
end

listbox_rd_Callback(hObject, eventdata, handles);


% --- Executes on selection change in listbox_first.
function listbox_first_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_first contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_first

change_list(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_first_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_second.
function listbox_second_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_second (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_second contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_second
change_list(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_second_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_second (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_third.
function listbox_third_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_third (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_third contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_third
change_list(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_third_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_third (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
