function varargout = nastran_normal_modes_response_spectrum(varargin)
% NASTRAN_NORMAL_MODES_RESPONSE_SPECTRUM MATLAB code for nastran_normal_modes_response_spectrum.fig
%      NASTRAN_NORMAL_MODES_RESPONSE_SPECTRUM, by itself, creates a new NASTRAN_NORMAL_MODES_RESPONSE_SPECTRUM or raises the existing
%      singleton*.
%
%      H = NASTRAN_NORMAL_MODES_RESPONSE_SPECTRUM returns the handle to a new NASTRAN_NORMAL_MODES_RESPONSE_SPECTRUM or the handle to
%      the existing singleton*.
%
%      NASTRAN_NORMAL_MODES_RESPONSE_SPECTRUM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NASTRAN_NORMAL_MODES_RESPONSE_SPECTRUM.M with the given input arguments.
%
%      NASTRAN_NORMAL_MODES_RESPONSE_SPECTRUM('Property','Value',...) creates a new NASTRAN_NORMAL_MODES_RESPONSE_SPECTRUM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nastran_normal_modes_response_spectrum_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nastran_normal_modes_response_spectrum_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nastran_normal_modes_response_spectrum

% Last Modified by GUIDE v2.5 19-Mar-2018 16:33:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nastran_normal_modes_response_spectrum_OpeningFcn, ...
                   'gui_OutputFcn',  @nastran_normal_modes_response_spectrum_OutputFcn, ...
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


% --- Executes just before nastran_normal_modes_response_spectrum is made visible.
function nastran_normal_modes_response_spectrum_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nastran_normal_modes_response_spectrum (see VARARGIN)

% Choose default command line output for nastran_normal_modes_response_spectrum
handles.output = hObject;

listbox_scale_1_Callback(hObject, eventdata, handles);


radiobutton_acceleration_Callback(hObject, eventdata, handles);
radiobutton_displacement_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nastran_normal_modes_response_spectrum wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nastran_normal_modes_response_spectrum_OutputFcn(hObject, eventdata, handles) 
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

delete(nastran_normal_modes_response_spectrum);


function find_number_nodes_elements(hObject, eventdata, handles)
       
disp('  ');
disp(' Find number of nodes & elements... ');
disp('  ');     
    
sarray=getappdata(0,'sarray'); 

rb_displacement=getappdata(0,'rb_displacement');
rb_velocity=getappdata(0,'rb_velocity');
rb_acceleration=getappdata(0,'rb_acceleration');

rb_plate_quad4_stress=getappdata(0,'rb_plate_quad4_stress');
rb_plate_quad4_strain=getappdata(0,'rb_plate_quad4_strain');

rb_plate_tria3_stress=getappdata(0,'rb_plate_tria3_stress');
rb_plate_tria3_strain=getappdata(0,'rb_plate_tria3_strain');

rb_solid_hexahedron_stress=getappdata(0,'rb_solid_hexahedron_stress');

num_disp=0;
num_velox=0;
num_accel=0;

num_quad4stress=0;
num_quad4strain=0;

num_tria3stress=0;
num_tria3strain=0;

num_hexahedron_stress=0;    
    
idd=[];
idv=[];
ida=[];

iquad4stress=[];
itria3stress=[];

iquad4strain=[];
itria3strain=[];


ihexahedronstress=[];


    if(rb_displacement==1)    
        idd = strfind(sarray{:}, 'D I S P L A C E M E N T   V E C T O R');
        idd = find(not(cellfun('isempty', idd)));
        num_disp = length(idd);
    end

     
    if(rb_velocity==1)
        idv = strfind(sarray{:}, 'V E L O C I T Y    V E C T O R');
        idv = find(not(cellfun('isempty', idv)));
        num_velox = length(idv);
    end
    
    if(rb_acceleration==1)
        ida = strfind(sarray{:}, 'A C C E L E R A T I O N    V E C T O R');
        ida = find(not(cellfun('isempty', ida)));
        num_accel = length(ida);
        setappdata(0,'num_accel',num_accel);
    end
    
    if(rb_plate_quad4_stress==1)
        iquad4stress = strfind(sarray{:}, 'S T R E S S E S   I N   Q U A D R I L A T E R A L   E L E M E N T S   ( Q U A D 4 )');
        iquad4stress = find(not(cellfun('isempty', iquad4stress)));
        num_quad4stress = length(iquad4stress);   
    end
    if(rb_plate_quad4_strain==1)
        iquad4strain = strfind(sarray{:}, 'S T R A I N S   I N   Q U A D R I L A T E R A L   E L E M E N T S   ( Q U A D 4 )');
        iquad4strain = find(not(cellfun('isempty', iquad4strain)));
        num_quad4strain = length(iquad4strain);   
    end    
    
    
    if(rb_plate_tria3_stress==1)
        itria3stress = strfind(sarray{:},'S T R E S S E S   I N   T R I A N G U L A R   E L E M E N T S   ( T R I A 3 )');
        itria3stress = find(not(cellfun('isempty', itria3stress)));
        num_tria3stress = length(itria3stress);   
    end
    if(rb_plate_tria3_strain==1)
        itria3strain = strfind(sarray{:},'S T R A I N S   I N   T R I A N G U L A R   E L E M E N T S   ( T R I A 3 )');
        itria3strain = find(not(cellfun('isempty', itria3strain)));
        num_tria3strain = length(itria3strain);   
    end    
    
    
    

    if(rb_solid_hexahedron_stress==1)
        ihexahedronstress = strfind(sarray{:},'S T R E S S E S   I N   H E X A H E D R O N   S O L I D   E L E M E N T S   ( H E X A )');
        ihexahedronstress = find(not(cellfun('isempty', ihexahedronstress)));
        num_hexahedron_stress = length(ihexahedronstress);   
    end   
   
    metric_displacement=0;
    metric_velocity=0;
    metric_acceleration=0;
    
    metric_quad4stress=0;
    metric_quad4strain=0;   
    
    metric_tria3stress=0;
    metric_tria3strain=0;    
    
    metric_hexahedron_stress=0;

    
    if(num_disp>0)
        metric_displacement=1;
    end
    if(num_velox>0)
        metric_velocity=1;          
    end   
    if(num_accel>0)
        metric_acceleration=1;          
    end
    
    if(num_quad4stress>0)
        metric_quad4stress=1;          
    end
    if(num_quad4strain>0)
        metric_quad4strain=1;          
    end    
    
    if(num_tria3stress>0)
        metric_tria3stress=1;          
    end  
    if(num_tria3strain>0)
        metric_tria3strain=1;          
    end   
    
    
    if(num_hexahedron_stress>0)
        metric_hexahedron_stress=1;          
    end     
    
    
    if(rb_displacement==0 || num_disp==0)
        metric_displacement=0;      
    end 
    if(rb_velocity==0 || num_velox==0)
        metric_velocity=0;           
    end 
    if(rb_acceleration==0 || num_accel==0)
        metric_acceleration=0;       
    end
    
    
    if(rb_plate_quad4_stress==0 || num_quad4stress==0)
        metric_quad4stress=0;      
    end     
    if(rb_plate_quad4_strain==0 || num_quad4strain==0)
        metric_quad4strain=0;      
    end        
    
    
    if(rb_plate_tria3_stress==0 || num_tria3stress==0)
        metric_tria3stress=0;      
    end 
    if(rb_plate_tria3_strain==0 || num_tria3strain==0)
        metric_tria3strain=0;      
    end     
    
    
    
    if(rb_solid_hexahedron_stress==0 || num_hexahedron_stress==0)
        metric_hexahedron_stress=0;      
    end     
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
   out1=sprintf(' num_disp=%d  num_velox=%d  num_accel=%d ',num_disp,num_velox,num_accel);
   disp(out1);
   
   out1=sprintf(' num_quad4stress=%d num_quad4strain=%d  ',num_quad4stress,num_quad4strain);
   disp(out1);
   
   out1=sprintf(' num_tria3stress=%d num_tria3strain=%d  ',num_tria3stress,num_tria3strain);
   disp(out1);
   
   out1=sprintf(' num_hexahedron_stress=%d ',num_hexahedron_stress);
   disp(out1);

   if(rb_displacement==1)
        setappdata(0,'idd',idd);   
   end 
   if(rb_velocity==1)
        setappdata(0,'idv',idv);          
   end 
   if(rb_acceleration==1)
        setappdata(0,'ida',ida);
   end
   
   if(rb_plate_quad4_stress==1)
        setappdata(0,'iquad4stress',iquad4stress);
   end
   if(rb_plate_quad4_strain==1)
        setappdata(0,'iquad4strain',iquad4strain);
   end   
   
   
   if(rb_plate_tria3_stress==1)
        setappdata(0,'itria3stress',itria3stress);      
   end   
   if(rb_plate_tria3_strain==1)
        setappdata(0,'itria3strain',itria3strain);      
   end  
   
   
   if(rb_solid_hexahedron_stress==1)
        setappdata(0,'ihexahedronstress',ihexahedronstress);  
   end

        
   setappdata(0,'num_disp',num_disp);
   setappdata(0,'num_velox',num_velox);
   setappdata(0,'num_accel',num_accel);
   
   setappdata(0,'num_quad4stress',num_quad4stress);
   setappdata(0,'num_quad4strain',num_quad4strain);   
   
   setappdata(0,'num_tria3stress',num_tria3stress);
   setappdata(0,'num_tria3strain',num_tria3strain);   
   
   
   setappdata(0,'num_hexahedron_stress',num_hexahedron_stress);


   setappdata(0,'metric_displacement',metric_displacement);
   setappdata(0,'metric_velocity',metric_velocity);
   setappdata(0,'metric_acceleration',metric_acceleration);
   
   setappdata(0,'metric_quad4stress',metric_quad4stress);
   setappdata(0,'metric_quad4strain',metric_quad4strain);   
   
   setappdata(0,'metric_tria3stress',metric_tria3stress);
   setappdata(0,'metric_tria3strain',metric_tria3strain);   
   
   setappdata(0,'metric_hexahedron_stress',metric_hexahedron_stress);


  
function find_displacement_nodes(hObject, eventdata, handles)
    
    sarray=getappdata(0,'sarray');
    idd=getappdata(0,'idd');
    
    disp('    ');
    disp(' Find displacement response nodes ');
    disp('    ');
        
    jn=1;
    
    iq=length(idd);
        
    for i=idd(1):idd(iq)
        
        try
            ss=sarray{1}{i};
        catch
            disp(' ss  break ');
            break;
        end
        
        j=1;
            
        k=strfind(ss, 'POINT ID.');
        
%%        out1=sprintf('i=%d',i);
%%        disp(out1);
            
        if(~isempty(k))
                
                while(1) 
                    
                    ss=sarray{1}{i+j};
                    
                    kk=strfind(ss,'NORMAL MODES');
                    
                    if(~isempty(kk))
                        break;
                    end
                    
                    strs = strsplit(ss,' ');
                    
                    LL=length(strs);

                                    
                    if(LL==8)
                    
                        node_disp(jn)= str2double(strs(1));
                    
                        T1=str2double(strs(3));
                        T2=str2double(strs(4));
                        T3=str2double(strs(5));
                        R1=str2double(strs(6));
                        R2=str2double(strs(7));
                        R3=str2double(strs(8));
                    
                        node_disp_array(jn,:)=[ T1 T2 T3 R1 R2 R3];
                    
                        jn=jn+1;
                    end
                    
                    j=j+1;
                    
                end                
        end
    end
   
   num_node_disp=length(node_disp);
   
%%   for i=1:num_node_disp
%%       out1=sprintf('  %d',node_disp(i));
%%       disp(out1);
%%   end    
   
   setappdata(0,'num_node_disp',num_node_disp);
   setappdata(0,'node_disp_array',node_disp_array);
    

[val_T1, idx_T1] = max(node_disp_array(:,1));   
[val_T2, idx_T2] = max(node_disp_array(:,2));   
[val_T3, idx_T3] = max(node_disp_array(:,3));   
[val_R1, idx_R1] = max(node_disp_array(:,4));
[val_R2, idx_R2] = max(node_disp_array(:,5));   
[val_R3, idx_R3] = max(node_disp_array(:,6));

   
disp('  ');
disp(' Writing displacement array'); 
disp('  ');  


iu=get(handles.listbox_units,'Value');

if(iu<=2)
    su='in';
else
    su='m';
end
                

node_disp=fix_size(node_disp);

output1='displacement_response_spectrum [node T1 T2 T3 R1 R2 R3]';
disp(output1);
disp('  ');   

output2='displacement_response_spectrum';
assignin('base', output2, [node_disp node_disp_array]);  

disp(' Maximum Displacements: ');
disp('          node     value ');

out1=sprintf(' T1:  %8d  %10.5f %s',node_disp(idx_T1),val_T1,su);
out2=sprintf(' T2:  %8d  %10.5f %s',node_disp(idx_T2),val_T2,su);
out3=sprintf(' T3:  %8d  %10.5f %s',node_disp(idx_T3),val_T3,su);
out4=sprintf(' R1:  %8d  %10.5f rad/sec',node_disp(idx_R1),val_R1);
out5=sprintf(' R2:  %8d  %10.5f rad/sec',node_disp(idx_R2),val_R2);
out6=sprintf(' R3:  %8d  %10.5f rad/sec',node_disp(idx_R3),val_R3);

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);

fig_num=getappdata(0,'fig_num');
hFig = figure(fig_num);
    fig_num=fig_num+1;
    xwidth=700;
    ywidth=600;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{29})
    
    BIG=[node_disp node_disp_array];
    
    dat =  BIG(:,1:7);
    columnname =   {'node','Disp T1','Disp T2','Disp T3',...
       'Disp R1','Disp R2','Disp R3' };
    columnformat = {'numeric','numeric', 'numeric','numeric','numeric','numeric',...
       'numeric'};
    columneditable = [false false false false false false false];   

    sz=size(BIG);
%
    for i = 1:sz(1)
        for j=1:sz(2)

                tempStr = sprintf(' %9.4g', dat(i,j));                
 
            data_s{i,j} = tempStr;     
        end  
    end
%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'RowName',[]);
%
    setappdata(0,'columnname',columnname); 

 
setappdata(0,'fig_num',fig_num);
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
    
     

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

n=get(handles.radiobutton_acceleration,'Value');

if(n==1)

    set(handles.text_scale_acceleration,'Visible','on');    
    set(handles.listbox_scale_1,'Visible','on');
    set(handles.text_divide,'Visible','on');
    set(handles.listbox_scale_2,'Visible','on');
    set(handles.text_scale_factor,'Visible','on');
    set(handles.edit_factor,'Visible','on');

else

    set(handles.text_scale_acceleration,'Visible','off');    
    set(handles.listbox_scale_1,'Visible','off');
    set(handles.text_divide,'Visible','off');
    set(handles.listbox_scale_2,'Visible','off');
    set(handles.text_scale_factor,'Visible','off');
    set(handles.edit_factor,'Visible','off');
    
end


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


function find_acceleration_nodes(hObject, eventdata, handles)

    ia=get(handles.listbox_scale_1,'Value');
    
    scale=1;
    
    if(ia==1)
        scale=str2num(get(handles.edit_factor,'String'));
    end

    sarray=getappdata(0,'sarray');
    ida=getappdata(0,'ida');
    
    disp('    ');
    disp(' Find acceleration response nodes ');
    disp('    ');
        
    jn=1;
    
    iq=length(ida);
        
    for i=ida(1):ida(iq)
        
        try
            ss=sarray{1}{i};
        catch
            disp(' ss  break ');
            break;
        end
        
        j=1;
            
        k=strfind(ss, 'POINT ID.');
        
%%        out1=sprintf('i=%d',i);
%%        disp(out1);
            
        if(~isempty(k))
                
                while(1) 
                    
                    ss=sarray{1}{i+j};
                    
                    kk=strfind(ss,'NORMAL MODES');
                    
                    if(~isempty(kk))
                        break;
                    end
                    
                    strs = strsplit(ss,' ');
                    
                    LL=length(strs);

                                    
                    if(LL==8)
                    
                        node_accel(jn)= str2double(strs(1));
                    
                        T1=str2double(strs(3));
                        T2=str2double(strs(4));
                        T3=str2double(strs(5));
                        R1=str2double(strs(6));
                        R2=str2double(strs(7));
                        R3=str2double(strs(8));
                    
                        node_accel_array(jn,:)=[ T1/scale T2/scale T3/scale R1 R2 R3];
                    
                        jn=jn+1;
                    end
                    
                    j=j+1;
                    
                end                
        end
    end
   
   num_node_accel=length(node_accel);
   
%%   for i=1:num_node_accel
%%       out1=sprintf('  %d',node_accel(i));
%%       disp(out1);
%%   end    
   
   setappdata(0,'num_node_accel',num_node_accel);
   setappdata(0,'node_accel_array',node_accel_array);
    

[val_T1, idx_T1] = max(node_accel_array(:,1));   
[val_T2, idx_T2] = max(node_accel_array(:,2));   
[val_T3, idx_T3] = max(node_accel_array(:,3));   
[val_R1, idx_R1] = max(node_accel_array(:,4));
[val_R2, idx_R2] = max(node_accel_array(:,5));   
[val_R3, idx_R3] = max(node_accel_array(:,6));

   
disp('  ');
disp(' Writing acceleration array'); 
disp('  ');    
                

node_accel=fix_size(node_accel);

output1='acceleration_response_spectrum [node T1 T2 T3 R1 R2 R3]';
disp(output1);
disp('  ');   

output2='acceleration_response_spectrum';
assignin('base', output2, [node_accel node_accel_array]);  


iu=get(handles.listbox_units,'Value');

if(iu==1)
    su='in/sec^2';
end
if(iu==2)
    su='G';
end
if(iu==3)
    su='m/sec^2';
end
if(iu==4)
    su='G';
end

disp(' Maximum accelerations: ');
disp('          node     value ');

out1=sprintf(' T1:  %8d  %12.3f %s',node_accel(idx_T1),val_T1,su);
out2=sprintf(' T2:  %8d  %12.3f %s',node_accel(idx_T2),val_T2,su);
out3=sprintf(' T3:  %8d  %12.3f %s',node_accel(idx_T3),val_T3,su);
out4=sprintf(' R1:  %8d  %12.3f rad/sec^2',node_accel(idx_R1),val_R1);
out5=sprintf(' R2:  %8d  %12.3f rad/sec^2',node_accel(idx_R2),val_R2);
out6=sprintf(' R3:  %8d  %12.3f rad/sec^2',node_accel(idx_R3),val_R3);

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);

fig_num=getappdata(0,'fig_num');
hFig = figure(fig_num);
    fig_num=fig_num+1;
    xwidth=700;
    ywidth=600;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{29})
    
    BIG=[node_accel node_accel_array];
    
    dat =  BIG(:,1:7);
    columnname =   {'node','Accel T1','Accel T2','Accel T3',...
       'Accel R1','Accel R2','Accel R3' };
    columnformat = {'numeric','numeric', 'numeric','numeric','numeric','numeric',...
       'numeric'};
    columneditable = [false false false false false false false];   

    sz=size(BIG);
%
    for i = 1:sz(1)
        for j=1:sz(2)

                tempStr = sprintf(' %9.4g', dat(i,j));                
 
            data_s{i,j} = tempStr;     
        end  
    end
%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'RowName',[]);
%
    setappdata(0,'columnname',columnname); 

 
setappdata(0,'fig_num',fig_num);    

   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5
 
 
% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

 
 
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
 
% --- Executes on selection change in listbox6.
function listbox6_Callback(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: contents = cellstr(get(hObject,'String')) returns listbox6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox6



% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4
 
 
% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function listbox6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
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

% --- Executes on selection change in listbox_rd.
function listbox_rd_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_rd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: contents = cellstr(get(hObject,'String')) returns listbox_rd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_rd

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

% --- Executes on button press in radiobutton_displacement.
function radiobutton_displacement_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hint: get(hObject,'Value') returns toggle state of radiobutton_displacement
 


function edit_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of edit_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_factor as a double
 
 
% --- Executes during object creation, after setting all properties.
function edit_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox_scale_2.
function listbox_scale_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scale_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scale_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scale_2
 
 
n=get(handles.listbox_scale_2,'Value');
 
if(n==1)
    ss='386';
    set(handles.listbox_units,'Value',2);
end
if(n==2)
    ss='9.81';
    set(handles.listbox_units,'Value',4);    
end
if(n==3)
    ss=' ';
end
 
set(handles.edit_factor,'String',ss);
    
 
% --- Executes during object creation, after setting all properties.
function listbox_scale_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_scale_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

 
% --- Executes on selection change in listbox_scale_1.
function listbox_scale_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scale_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scale_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scale_1
 
n=get(handles.listbox_scale_1,'Value');
 
if(n==1)
    set(handles.listbox_scale_2,'Visible','on');
    set(handles.edit_factor,'Visible','on');
    set(handles.text_divide,'Visible','on');
    set(handles.text_scale_factor,'Visible','on');
    listbox_scale_2_Callback(hObject, eventdata, handles);
else
    set(handles.listbox_scale_2,'Visible','off');
    set(handles.edit_factor,'Visible','off');
    set(handles.text_divide,'Visible','off');
    set(handles.text_scale_factor,'Visible','off');    
end

 
% --- Executes during object creation, after setting all properties.
function listbox_scale_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_scale_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function listbox_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_plot.
function listbox_plot_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plot

 


 
% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
   tic
  
   clear_all_figures(nastran_normal_modes_response_spectrum);
   
   setappdata(0,'metric_displacement',0);
   setappdata(0,'metric_velocity',0);
   setappdata(0,'metric_acceleration',0);
   
   setappdata(0,'metric_quad4stress',0);
   setappdata(0,'metric_quad4strain',0);   
   
   setappdata(0,'metric_tria3stress',0);
   setappdata(0,'metric_tria3strain',0);   
   
   setappdata(0,'metric_hexahedron_stress',0);
   
   
   fig_num=2;
   setappdata(0,'fig_num',fig_num);
 
   disp('  ');
   disp(' * * * * * * * * * * * * * * ');
   disp('  ');
 
   [filename, pathname] = uigetfile('*.f06');
   filename = fullfile(pathname, filename);
 
   try
      fid = fopen(filename,'r');
   catch
      warndlg('File not opened'); 
      return; 
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
   
   disp(' Read f06 file... ');
   disp('  ');   
 
   sarray = textscan(fid,'%s','Delimiter','\n');
   fclose(fid);
    
   setappdata(0,'sarray',sarray);
    
    kv=cellfun(@length,sarray);
 
    out1=sprintf(' %d number of lines',kv);
    disp(out1);
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   rb_displacement = get(handles.radiobutton_displacement, 'Value');
   rb_velocity = get(handles.radiobutton_velocity, 'Value');
   rb_acceleration = get(handles.radiobutton_acceleration, 'Value');
   
   rb_plate_quad4_stress = get(handles.radiobutton_plate_quad4_stress, 'Value');
   rb_plate_quad4_strain = get(handles.radiobutton_plate_quad4_strain, 'Value');  
   
   rb_plate_tria3_stress = get(handles.radiobutton_plate_tria3_stress, 'Value');
   rb_plate_tria3_strain = get(handles.radiobutton_plate_tria3_strain, 'Value');
   
   
   rb_solid_hexahedron_stress = get(handles.radiobutton_solid_hexahedron_stress, 'Value');  
 
   find_number_nodes_elements(hObject, eventdata, handles);
   
   
   setappdata(0,'rb_displacement',rb_displacement);
   setappdata(0,'rb_velocity',rb_velocity);
   setappdata(0,'rb_acceleration',rb_acceleration);
   
   setappdata(0,'rb_plate_quad4_stress',rb_plate_quad4_stress);
   setappdata(0,'rb_plate_quad4_strain',rb_plate_quad4_strain);  
   
   setappdata(0,'rb_plate_tria3_stress',rb_plate_tria3_stress);   
   setappdata(0,'rb_plate_tria3_strain',rb_plate_tria3_strain);      
   
   setappdata(0,'rb_solid_hexahedron_stress',rb_solid_hexahedron_stress); 
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
 
   nu=get(handles.listbox_units,'Value');
   setappdata(0,'nu',nu);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
   
   metric_displacement=getappdata(0,'metric_displacement');
   metric_velocity=getappdata(0,'metric_velocity');
   metric_acceleration=getappdata(0,'metric_acceleration');
   
   metric_quad4stress=getappdata(0,'metric_quad4stress');
   metric_quad4strain=getappdata(0,'metric_quad4strain');  
   
   metric_tria3stress=getappdata(0,'metric_tria3stress');
   metric_tria3strain=getappdata(0,'metric_tria3strain');   
   
   
   metric_hexahedron_stress=getappdata(0,'metric_hexahedron_stress');
   
   
   out1=sprintf(' metric_displacement=%d',metric_displacement);
   out2=sprintf(' metric_velocity=%d',metric_velocity);   
   out3=sprintf(' metric_acceleration=%d',metric_acceleration);
   
   out4=sprintf(' metric_quad4stress=%d',metric_quad4stress);
   out5=sprintf(' metric_quad4strain=%d',metric_quad4strain);   
  
   out6=sprintf(' metric_tria3stress=%d',metric_tria3stress);
   out7=sprintf(' metric_tria3strain=%d',metric_tria3strain);   
   
   out8=sprintf(' metric_hexahedron_stress=%d',metric_hexahedron_stress);    
   
   
   disp(out1);
   disp(out2);  
   disp(out3);
   disp(out4);     
   disp(out5);
   disp(out6);     
   disp(out7);   
   disp(out8);
   
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   if(metric_displacement==1 && rb_displacement==1)
        find_displacement_nodes(hObject, eventdata, handles);     
   end    

   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   if(metric_velocity==1 && rb_velocity==1)
        find_velocity_nodes(hObject, eventdata, handles)           
   end     
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   if(metric_acceleration==1 && rb_acceleration==1)
        find_acceleration_nodes(hObject, eventdata, handles)     
   end       
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   if(metric_quad4stress==1 && rb_plate_quad4_stress==1)
        find_quad4stress_elem(hObject, eventdata, handles);  
   end            
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   if(metric_quad4strain==1 && rb_plate_quad4_strain==1)
        find_quad4strain_elem(hObject, eventdata, handles);  
   end            
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   if(metric_tria3stress==1 && rb_plate_tria3_stress==1)
        find_tria3stress_elem(hObject, eventdata, handles);          
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   if(metric_tria3strain==1 && rb_plate_tria3_strain==1)
        find_tria3strain_elem(hObject, eventdata, handles);          
   end   
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%

   if(metric_hexahedron_stress==1 && rb_solid_hexahedron_stress==1)
       find_hexahedron_elem(hObject, eventdata, handles);        
   end    

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    
disp('  ');
disp(' Analysis complete'); 
disp('  ');
toc
disp('  ');   


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 
function find_quad4stress_elem(hObject, eventdata, handles)     
 
iquad4stress=getappdata(0,'iquad4stress');        
    
disp('    ');
disp(' Find quad4 stress response elements ');
disp('    ');

istart=iquad4stress(1);
iend=max(iquad4stress);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);
setappdata(0,'stress_type',1);

plate_stress_core(hObject, eventdata, handles);            
            
%%%

function find_quad4strain_elem(hObject, eventdata, handles)     
 
iquad4strain=getappdata(0,'iquad4strain');        
    
disp('    ');
disp(' Find quad4 strain response elements ');
disp('    ');

istart=iquad4strain(1);
iend=max(iquad4strain);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);
setappdata(0,'strain_type',1);

plate_strain_core(hObject, eventdata, handles);            
            
%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plate_stress_core(hObject, eventdata, handles)    
           
jk=1;

istart=getappdata(0,'istart');
iend=getappdata(0,'iend');
sarray=getappdata(0,'sarray');
itype=getappdata(0,'stress_type');

if(iend==istart)
    iend=iend+1;
end

out1=sprintf('\n  istart=%d  iend=%d   \n',istart,iend);
disp(out1);


for i=istart:iend
                       
            ss=sarray{1}{i};
                       
            k=strfind(ss, 'GRID-ID');
            kk=strfind(ss, 'ELEMENT');
            kv=strfind(ss, 'ID.');
           
            j=1;
            
            if(~isempty(k) || ~isempty(kk) || ~isempty(kv) )
                
                while(1) 
                    ss=sarray{1}{i+j};
                    
                    
                    kn=strfind(ss,'NORMAL MODES');
                    
                    if(~isempty(kn))
                        break;
                    end
                    
                    strs = strsplit(ss,' ');                    
                    
                    L=length(strs);

                    if( (L==10 || L==11) && str2double(strs(1))==0 )
                        
                            ssz=str2double(strs(2));
                                             
                            if(~isnan(ssz) && ssz~=0)
                                
                                NX=str2double(strs(L-6));
                                NY=str2double(strs(L-5));
                                SXY=str2double(strs(L-4));
                                ANG=str2double(strs(L-3));
                                MAJ=str2double(strs(L-2));
                                MIN=str2double(strs(L-1));
                                VM=str2double(strs(L));
                          
                                Z(jk)=ssz;
                                ZS(jk,:)=[ NX NY SXY ANG MAJ MIN VM ];
                                        
                                jk=jk+1;
                            end

                    end
                   
                    j=j+1;
                    
                end
                
            end
end

try
    num_elem_stress=length(Z);   
catch
    warndlg(' Z error in function plate_stress_core ');
    return; 
end
    
    
setappdata(0,'num_elem_stress',num_elem_stress);
setappdata(0,'elem_stress_array',ZS);


[val_NX, idx_NX] = max(ZS(:,1));   
[val_NY, idx_NY] = max(ZS(:,2));   
[val_SXY, idx_SXY] = max(ZS(:,3));

[val_MAJ, idx_MAJ] = max(ZS(:,5));
[val_MIN, idx_MIN] = max(ZS(:,6));   
[val_VM, idx_VM]   = max(ZS(:,7));
   
disp('  ');
disp(' Writing Stress array'); 
disp('  ');    
                
iu=get(handles.listbox_units,'Value');

if(iu<=2)
    su='psi';
else
    su='Pa';
end

Z=fix_size(Z);

if(itype==1)
    output1='quad4_stress_response_spectrum [node NX NY SXY ANG MAJ MIN VM]';
else
    output1='tria3_stress_response_spectrum [node NX NY SXY ANG MAJ MIN VM]';    
end

disp(output1);
disp('  ');   


% Z(jk)=ssz; 
% ZS(jk,:)=[ NX NY SXY ANG MAJ MIN VM ];

if(itype==1)

    output2='quad4_stress_response_spectrum';
    assignin('base', output2, [Z ZS]);  
    disp(' Maximum Quad4 Stress: ');

else

    output2='tria3_stress_response_spectrum';
    assignin('base', output2, [Z ZS]);  
    disp(' Maximum Tria3 Stress: ');
    
end



disp('                   element     value ');

out1=sprintf(' NORMAL-X    :  %7d  %10.3f %s',Z(idx_NX),val_NX,su);
out2=sprintf(' NORMAL-Y    :  %7d  %10.3f %s',Z(idx_NY),val_NY,su);
out3=sprintf(' SHEAR-XY    :  %7d  %10.3f %s',Z(idx_SXY),val_SXY,su);
out4=sprintf(' MAJOR PRNCPL:  %7d  %10.3f %s',Z(idx_MAJ),val_MAJ,su);
out5=sprintf(' MINOR PRNCPL:  %7d  %10.3f %s',Z(idx_MIN),val_MIN,su);
out6=sprintf(' VON MISES   :  %7d  %10.3f %s',Z(idx_VM),val_VM,su);

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);

fig_num=getappdata(0,'fig_num');
hFig = figure(fig_num);
    fig_num=fig_num+1;
    xwidth=700;
    ywidth=600;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{29})
    
    BIG=[Z ZS];
    
    dat =  BIG(:,1:8);
    columnname =   {'elem','Norm-X','Norm-Y','Shear-XY',...
       'Angle','Major P','Minor P','Von Mises Stress'};
    columnformat = {'numeric','numeric','numeric', 'numeric','numeric','numeric','numeric',...
       'numeric'};
    columneditable = [false false false false false false false false];   

    sz=size(BIG);
%
    for i = 1:sz(1)
        for j=1:sz(2)

                tempStr = sprintf(' %9.4g', dat(i,j));                
 
            data_s{i,j} = tempStr;     
        end  
    end
%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'RowName',[]);
%
    setappdata(0,'columnname',columnname); 

 
setappdata(0,'fig_num',fig_num);
  



            
function find_tria3stress_elem(hObject, eventdata, handles)    

itria3stress=getappdata(0,'itria3stress');                 
    
disp('    ');
disp(' Find tria3 stress response elements ');
disp('    ');
        
istart=itria3stress(1);
iend=max(itria3stress);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);
setappdata(0,'stress_type',2);

plate_stress_core(hObject, eventdata, handles);   


function find_tria3strain_elem(hObject, eventdata, handles)    

itria3strain=getappdata(0,'itria3strain');                 
    
disp('    ');
disp(' Find tria3 strain response elements ');
disp('    ');
        
istart=itria3strain(1);
iend=max(itria3strain);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);
setappdata(0,'strain_type',2);

plate_strain_core(hObject, eventdata, handles);  
     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
function find_velocity_nodes(hObject, eventdata, handles)
    

    sarray=getappdata(0,'sarray');
    idv=getappdata(0,'idv');
    
    disp('    ');
    disp(' Find velocity response nodes ');
    disp('    ');
        
    jn=1;
    
    iq=length(idv);
        
    for i=idv(1):idv(iq)
        
        try
            ss=sarray{1}{i};
        catch
            disp(' ss  break ');
            break;
        end
        
        j=1;
            
        k=strfind(ss, 'POINT ID.');
        
%%        out1=sprintf('i=%d',i);
%%        disp(out1);
            
        if(~isempty(k))
                
                while(1) 
                    
                    ss=sarray{1}{i+j};
                    
                    kk=strfind(ss,'NORMAL MODES');
                    
                    if(~isempty(kk))
                        break;
                    end
                    
                    strs = strsplit(ss,' ');
                    
                    LL=length(strs);

                                    
                    if(LL==8)
                    
                        node_velox(jn)= str2double(strs(1));
                    
                        T1=str2double(strs(3));
                        T2=str2double(strs(4));
                        T3=str2double(strs(5));
                        R1=str2double(strs(6));
                        R2=str2double(strs(7));
                        R3=str2double(strs(8));
                    
                        node_velox_array(jn,:)=[ T1 T2 T3 R1 R2 R3];
                    
                        jn=jn+1;
                    end
                    
                    j=j+1;
                    
                end                
        end
    end
   
   num_node_velox=length(node_velox);
   
%%   for i=1:num_node_velox
%%       out1=sprintf('  %d',node_velox(i));
%%       disp(out1);
%%   end    
   
   setappdata(0,'num_node_velox',num_node_velox);
   setappdata(0,'node_velox_array',node_velox_array);
    

[val_T1, idx_T1] = max(node_velox_array(:,1));   
[val_T2, idx_T2] = max(node_velox_array(:,2));   
[val_T3, idx_T3] = max(node_velox_array(:,3));   
[val_R1, idx_R1] = max(node_velox_array(:,4));
[val_R2, idx_R2] = max(node_velox_array(:,5));   
[val_R3, idx_R3] = max(node_velox_array(:,6));

   
disp('  ');
disp(' Writing velocity array'); 
disp('  ');    
                


iu=get(handles.listbox_units,'Value');

if(iu<=2)
    su='in/sec';
else
    su='m/sec';
end


node_velox=fix_size(node_velox);

output1='velocity_response_spectrum [node T1 T2 T3 R1 R2 R3]';
disp(output1);
disp('  ');   

output2='velocity_response_spectrum';
assignin('base', output2, [node_velox node_velox_array]);  

disp(' Maximum velocities: ');
disp('          node     value ');

out1=sprintf(' T1:  %8d  %10.3f %s',node_velox(idx_T1),val_T1,su);
out2=sprintf(' T2:  %8d  %10.3f %s',node_velox(idx_T2),val_T2,su);
out3=sprintf(' T3:  %8d  %10.3f %s',node_velox(idx_T3),val_T3,su);
out4=sprintf(' R1:  %8d  %10.3f rad/sec',node_velox(idx_R1),val_R1);
out5=sprintf(' R2:  %8d  %10.3f rad/sec ',node_velox(idx_R2),val_R2);
out6=sprintf(' R3:  %8d  %10.3f rad/sec ',node_velox(idx_R3),val_R3);

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);

fig_num=getappdata(0,'fig_num');
hFig = figure(fig_num);
    fig_num=fig_num+1;
    xwidth=700;
    ywidth=600;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{29})
    
    BIG=[node_velox node_velox_array];
    
    dat =  BIG(:,1:7);
    columnname =   {'node','Vel T1','Vel T2','Vel T3',...
       'Vel R1','Vel R2','Vel R3' };
    columnformat = {'numeric','numeric', 'numeric','numeric','numeric','numeric',...
       'numeric'};
    columneditable = [false false false false false false false];   

    sz=size(BIG);
%
    for i = 1:sz(1)
        for j=1:sz(2)

                tempStr = sprintf(' %9.4g', dat(i,j));                
 
            data_s{i,j} = tempStr;     
        end  
    end
%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'RowName',[]);
%
    setappdata(0,'columnname',columnname); 

 
setappdata(0,'fig_num',fig_num);
  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 
function find_hexahedron_elem(hObject, eventdata, handles)     
 
sarray=getappdata(0,'sarray');
ihexahedronstress=getappdata(0,'ihexahedronstress');        
    

%%%

disp('    ');
disp(' Find hexahedron stress response elements & nodes ');
disp('    ');
        
jk=1;

i1=ihexahedronstress(1);    
i2=max(ihexahedronstress);

elem=0;

istart=i1;

progressbar;
 
i=istart-1;    
    
while(1)  
    
    i=i+1;
    
    if(i>i2)
        break;
    end
    
    progressbar(i/i2);
    
    try
        ss=sarray{1}{i};
    catch
        break;
    end
        
    kg=strfind(ss,'XY');    
    
    k0G=strfind(ss,'0GRID');
    
    if(~isempty(k0G))
        strs = strsplit(ss,' ');
        elem=str2double(strs(2));
    end
    
    if(~isempty(kg) && elem>0)
        
        j=0;
        
        nnn=0;
    
        while(1)
        
            try
                ss=sarray{1}{i+j};
            catch
                break;
            end
            
            kn=strfind(ss,'NORMAL MODES');
            kc=strfind(ss,'CENTER');
            
            if(~isempty(k0G))
                strs = strsplit(ss,' ');
                elem=str2double(strs(2));
            end            
            
            kg=strfind(ss,'XY'); 
            
            strs = strsplit(ss,' ');
            L=length(strs);
        
%            ss
          
%%            out1=sprintf(' L=%d  elem=%d ',L,elem);
%%            disp(out1);           
            
            if((L>=12 && L<=14) && str2double(strs(1))==0 && ~isempty(kg) && elem>0 && isempty(kc) && isempty(kn))
                node=str2double(strs(2));
                nnn=nnn+1;
                
%                out1=sprintf('  node=%d ',node);
%                disp(out1);

                try
                    VM=str2double(strs(length(strs)));
                
                    if(elem>0 && node>0)
                        ZHEX(jk,:)=[elem node VM];
                        jk=jk+1;
                    end    
               
                catch
                end
                    
                if(nnn==8)
                    i=i+j;
                    break;
                end
      
            end  
            
            
 %           uuu=input(' ');
            
            j=j+1;
        end    
    end
    
end

pause(0.2);
progressbar(1);

iu=get(handles.listbox_units,'Value');

if(iu<=2)
    su='psi';
else
    su='Pa';
end


disp(' ');
disp(' Maximum Von Mises Stress Ranked');
disp(' ');
disp('  Note that hexahedron elements with constrained nodes may have ');
disp('  unrealistically high stress levels.');
disp(' ');


BIG=ZHEX;

sz=size(BIG);

qw=min([ sz(1) 40]);

out1=sprintf(' n     elem      node   stress(%s)',su);
disp(out1);

for i=1:qw
    
    [val,idx] = max(ZHEX(:,3));
    
    out1=sprintf(' %d  %8d  %8d  %8.4e ',i,ZHEX(idx,1),ZHEX(idx,2),val);
    disp(out1);

    ZHEX(idx,:)=[];
    
end

output1='hex_stress_response_spectrum [elem node VM]';
disp(output1);
disp('  ');   

output2='hex_stress_response_spectrum';
assignin('base', output2, ZHEX);


fig_num=getappdata(0,'fig_num');
hFig = figure(fig_num);
    fig_num=fig_num+1;
    xwidth=300;
    ywidth=700;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{29})
    
    
    dat =  BIG(:,1:3);
    columnname =   {'elem','node','VM Stress'};
    columnformat = {'numeric','numeric', 'numeric'};
    columneditable = [false false false];   

    sz=size(BIG);
%
    for i = 1:sz(1)
        for j=1:sz(2)

                tempStr = sprintf(' %11.6g', dat(i,j));                
 
            data_s{i,j} = tempStr;     
        end  
    end
%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'RowName',[]);
%
    setappdata(0,'columnname',columnname); 

 
setappdata(0,'fig_num',fig_num);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in radiobutton_solid_hexahedron_stress.
function radiobutton_solid_hexahedron_stress_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_solid_hexahedron_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_solid_hexahedron_stress


% --- Executes on button press in radiobutton_plate_quad4_strain.
function radiobutton_plate_quad4_strain_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_plate_quad4_strain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_plate_quad4_strain



function plate_strain_core(hObject, eventdata, handles)    
           
jk=1;

istart=getappdata(0,'istart');
iend=getappdata(0,'iend');
sarray=getappdata(0,'sarray');
itype=getappdata(0,'strain_type');

if(iend==istart)
    iend=iend+1;
end

out1=sprintf('\n  istart=%d  iend=%d   \n',istart,iend);
disp(out1);


for i=istart:iend
                       
            ss=sarray{1}{i};
                       
            k=strfind(ss, 'GRID-ID');
            kk=strfind(ss, 'ELEMENT');
            kv=strfind(ss, 'ID.');
           
            j=1;
            
            if(~isempty(k) || ~isempty(kk) || ~isempty(kv) )
                
                while(1) 
                    ss=sarray{1}{i+j};
                    
                    
                    kn=strfind(ss,'NORMAL MODES');
                    
                    if(~isempty(kn))
                        break;
                    end
                    
                    strs = strsplit(ss,' ');                    
                    
                    L=length(strs);

                    if( (L==10 || L==11) && str2double(strs(1))==0 )
                        
                            ssz=str2double(strs(2));
                                             
                            if(~isnan(ssz) && ssz~=0)
                                
                                NX=str2double(strs(L-6));
                                NY=str2double(strs(L-5));
                                SXY=str2double(strs(L-4));
                                ANG=str2double(strs(L-3));
                                MAJ=str2double(strs(L-2));
                                MIN=str2double(strs(L-1));
                                VM=str2double(strs(L));
                          
                                Z(jk)=ssz;
                                ZS(jk,:)=[ NX NY SXY ANG MAJ MIN VM ];
                                        
                                jk=jk+1;
                            end

                    end
                   
                    j=j+1;
                    
                end
                
            end
end

try
    num_elem_strain=length(Z);   
catch
    warndlg(' Z error in function plate_strain_core ');
    return; 
end
    
    
setappdata(0,'num_elem_strain',num_elem_strain);
setappdata(0,'elem_strain_array',ZS);


[val_NX, idx_NX] = max(ZS(:,1));   
[val_NY, idx_NY] = max(ZS(:,2));   
[val_SXY, idx_SXY] = max(ZS(:,3));

[val_MAJ, idx_MAJ] = max(ZS(:,5));
[val_MIN, idx_MIN] = max(ZS(:,6));   
[val_VM, idx_VM]   = max(ZS(:,7));
   
disp('  ');
disp(' Writing strain array'); 
disp('  ');    
                
iu=get(handles.listbox_units,'Value');


Z=fix_size(Z);

if(itype==1)
    output1='quad4_strain_response_spectrum [node NX NY SXY ANG MAJ MIN VM]';
else
    output1='tria3_strain_response_spectrum [node NX NY SXY ANG MAJ MIN VM]';    
end

disp(output1);
disp('  ');   


% Z(jk)=ssz; 
% ZS(jk,:)=[ NX NY SXY ANG MAJ MIN VM ];


if(itype==1)
    output2='quad4_strain_response_spectrum';
    assignin('base', output2, [Z ZS]);  
    disp(' Maximum Quad4 strain: ');
else
    output2='tria3_strain_response_spectrum';
    assignin('base', output2, [Z ZS]);  
    disp(' Maximum Tria3 strain: ');
end


disp('                   element     value ');

out1=sprintf(' NORMAL-X    :  %7d  %10.5f %s',Z(idx_NX),val_NX);
out2=sprintf(' NORMAL-Y    :  %7d  %10.5f %s',Z(idx_NY),val_NY);
out3=sprintf(' SHEAR-XY    :  %7d  %10.5f %s',Z(idx_SXY),val_SXY);
out4=sprintf(' MAJOR PRNCPL:  %7d  %10.5f %s',Z(idx_MAJ),val_MAJ);
out5=sprintf(' MINOR PRNCPL:  %7d  %10.5f %s',Z(idx_MIN),val_MIN);
out6=sprintf(' VON MISES   :  %7d  %10.5f %s',Z(idx_VM),val_VM);

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);

fig_num=getappdata(0,'fig_num');
hFig = figure(fig_num);
    fig_num=fig_num+1;
    xwidth=700;
    ywidth=600;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{29})
    
    BIG=[Z ZS];
    
    dat =  BIG(:,1:8);
    columnname =   {'elem','Norm-X','Norm-Y','Shear-XY',...
       'Angle','Major P','Minor P','Von Mises Strain'};
    columnformat = {'numeric','numeric','numeric', 'numeric','numeric','numeric','numeric',...
       'numeric'};
    columneditable = [false false false false false false false false];   

    sz=size(BIG);
%
    for i = 1:sz(1)
        for j=1:sz(2)

                tempStr = sprintf(' %9.4g', dat(i,j));                
 
            data_s{i,j} = tempStr;     
        end  
    end
%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'RowName',[]);
%
    setappdata(0,'columnname',columnname); 

 
setappdata(0,'fig_num',fig_num);
  


% --- Executes on button press in radiobutton_plate_tria3_strain.
function radiobutton_plate_tria3_strain_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_plate_tria3_strain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_plate_tria3_strain
