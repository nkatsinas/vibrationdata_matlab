function varargout = nastran_modal_transient(varargin)
% NASTRAN_MODAL_TRANSIENT MATLAB code for nastran_modal_transient.fig
%      NASTRAN_MODAL_TRANSIENT, by itself, creates a new NASTRAN_MODAL_TRANSIENT or raises the existing
%      singleton*.
%
%      H = NASTRAN_MODAL_TRANSIENT returns the handle to a new NASTRAN_MODAL_TRANSIENT or the handle to
%      the existing singleton*.
%
%      NASTRAN_MODAL_TRANSIENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NASTRAN_MODAL_TRANSIENT.M with the given input arguments.
%
%      NASTRAN_MODAL_TRANSIENT('Property','Value',...) creates a new NASTRAN_MODAL_TRANSIENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nastran_modal_transient_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nastran_modal_transient_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nastran_modal_transient

% Last Modified by GUIDE v2.5 05-Jun-2018 17:25:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nastran_modal_transient_OpeningFcn, ...
                   'gui_OutputFcn',  @nastran_modal_transient_OutputFcn, ...
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


% --- Executes just before nastran_modal_transient is made visible.
function nastran_modal_transient_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nastran_modal_transient (see VARARGIN)

% Choose default command line output for nastran_modal_transient
handles.output = hObject;

listbox_scale_1_Callback(hObject, eventdata, handles);
listbox_plot_Callback(hObject, eventdata, handles);
listbox_rd_Callback(hObject, eventdata, handles);

radiobutton_acceleration_Callback(hObject, eventdata, handles);
radiobutton_displacement_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nastran_modal_transient wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nastran_modal_transient_OutputFcn(hObject, eventdata, handles) 
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

delete(nastran_modal_transient);


function find_number_time_points(hObject, eventdata, handles)
       
disp('  ');
disp(' Find number of time points... ');
disp('  ');     
    
sarray=getappdata(0,'sarray'); 

rb_displacement=getappdata(0,'rb_displacement');
rb_velocity=getappdata(0,'rb_velocity');
rb_acceleration=getappdata(0,'rb_acceleration');

rb_plate_quad4_stress=getappdata(0,'rb_plate_quad4_stress');
rb_plate_quad4_strain=getappdata(0,'rb_plate_quad4_strain');

rb_plate_tria3_stress=getappdata(0,'rb_plate_tria3_stress');
rb_plate_tria3_strain=getappdata(0,'rb_plate_tria3_strain');

rb_beam_stress=getappdata(0,'rb_beam_stress');
rb_solid_hexahedron_stress=getappdata(0,'rb_solid_hexahedron_stress');

num_disp=0;
num_velox=0;
num_accel=0;

num_quad4stress=0;
num_quad4strain=0;

num_tria3stress=0;
num_tria3strain=0;

num_elem_beam_stress=0;
num_hexahedron_stress=0;    
    
   
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
    
    
    
    
    if(rb_beam_stress==1)
        ibeam_stress = strfind(sarray{:}, 'S T R E S S E S   I N   B E A M   E L E M E N T S');
        ibeam_stress = find(not(cellfun('isempty', ibeam_stress)));
        num_elem_beam_stress = length(ibeam_stress);
    end
    

    if(rb_solid_hexahedron_stress==1)
        ihexahedronstress = strfind(sarray{:},'S T R E S S E S   I N   H E X A H E D R O N   S O L I D   E L E M E N T S   ( H E X A )');
        ihexahedronstress = find(not(cellfun('isempty', ihexahedronstress)));
        num_hexahedron_stress = length(ihexahedronstress);   
    end   
    
    idt = strfind(sarray{:}, 'TIME =');
    idt = find(not(cellfun('isempty', idt)));
%%%    num_time = length(idt);    
    
    num_time=1;
    
    j=idt(1);   
    ss=sarray{1}{j};
    strs = strsplit(ss,' ');
    tb=str2double(strs(3));
    tmin=tb;
    
    idtL=length(idt);
    
    out1=sprintf(' idtL = %d ',idtL);
    disp(out1);
    
    progressbar;
    
    for i=2:idtL
        
        progressbar(i/idtL);
        
        j=idt(i);
        
        ss=sarray{1}{j};
        strs = strsplit(ss,' ');
        tt=str2double(strs(3));
        
        if(tt>tb)
            tb=tt;
            num_time=num_time+1;
        end
    end
    
    tmax=tb;
    
    pause(0.2);
    progressbar(1);
    
    nt=num_time;    
   
    metric_displacement=0;
    metric_velocity=0;
    metric_acceleration=0;
    
    metric_quad4stress=0;
    metric_quad4strain=0;
    
    metric_tria3stress=0;
    metric_tria3strain=0;   
    
    metric_beam_stress=0;
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
    
    
    if(num_elem_beam_stress>0)
        metric_beam_stress=1;          
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
    
    
     if(rb_beam_stress==0 || num_elem_beam_stress==0)
        metric_beam_stress=0;      
    end    
    if(rb_solid_hexahedron_stress==0 || num_hexahedron_stress==0)
        metric_hexahedron_stress=0;      
    end     
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
   out1=sprintf(' num_disp=%d  num_velox=%d  num_accel=%d ',num_disp,num_velox,num_accel);
   disp(out1);
   
   out1=sprintf(' num_quad4stress=%d    num_quad4stress=%d  ',num_quad4stress,num_quad4strain);
   disp(out1);
   
   out1=sprintf(' num_tria3stress=%d    num_tria3strain=%d  ',num_tria3stress,num_tria3strain);
   disp(out1);
      
   
   out1=sprintf(' num_elem_beam_stress=%d ',num_elem_beam_stress);
   disp(out1);
   
   out1=sprintf(' num_hexahedron_stress=%d ',num_hexahedron_stress);
   disp(out1);

   out1=sprintf(' num_time=%d  ',num_time);
   disp(out1)   
    
   
   
   
   
   zflag=0;
   setappdata(0,'zflag',zflag);
   
   if(nt==0)
       out1=sprintf('f06 file must contain a response parameter');
       warndlg(out1);
       zflag=1;
       setappdata(0,'zflag',zflag);
       return;
   end
   
    
   disp(' ');
   disp(' Form time vector...');
   disp(' ');   
  
        
   dt=(tmax-tmin)/(nt-1);
   
   tn = linspace(tmin,tmax,nt);
   
   tn=fix_size(tn);
   
   setappdata(0,'tn',tn);
   
   out1=sprintf(' tmin=%9.5g  tmax=%9.5g  dt=%9.5g',tn(1),tn(nt),dt);
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
   
   
   if(rb_beam_stress==1)
        setappdata(0,'ibeam_stress',ibeam_stress);      
   end      
   
   if(rb_solid_hexahedron_stress==1)
        setappdata(0,'ihexahedronstress',ihexahedronstress);  
   end
   
   try
        setappdata(0,'idt',idt);
   catch
        warndlg('Time column error');
        return;
   end
        
   
   disp(' find time')
        
   setappdata(0,'num_disp',num_disp);
   setappdata(0,'num_velox',num_velox);
   setappdata(0,'num_accel',num_accel);
   
   
   setappdata(0,'num_quad4stress',num_quad4stress);
   setappdata(0,'num_quad4strain',num_quad4strain);   
   
   setappdata(0,'num_tria3stress',num_tria3stress);
   setappdata(0,'num_tria3strain',num_tria3strain);   
   
   
   setappdata(0,'num_elem_beam_stress',num_elem_beam_stress);   
   setappdata(0,'num_hexahedron_stress',num_hexahedron_stress);
   setappdata(0,'num_time',num_time);

   setappdata(0,'metric_displacement',metric_displacement);
   setappdata(0,'metric_velocity',metric_velocity);
   setappdata(0,'metric_acceleration',metric_acceleration);
   
   setappdata(0,'metric_quad4stress',metric_quad4stress);
   setappdata(0,'metric_quad4strain',metric_quad4strain);  
   
   setappdata(0,'metric_tria3stress',metric_tria3stress);
   setappdata(0,'metric_tria3strain',metric_tria3strain);   
   
   
   setappdata(0,'metric_beam_stress',metric_beam_stress);   
   setappdata(0,'metric_hexahedron_stress',metric_hexahedron_stress);

   setappdata(0,'nt',nt);   
   setappdata(0,'tn',tn);  
   


  
function find_displacement_nodes(hObject, eventdata, handles)
    
    sarray=getappdata(0,'sarray');
    idd=getappdata(0,'idd');
    tn=getappdata(0,'tn');
    nt=getappdata(0,'nt');  
    
    disp('    ');
    disp(' Find displacement response nodes ');
    disp('    ');
        
    j=1;
        
        
    for i=idd(1):idd(2)
                        
        ss=sarray{1}{i};
            
        k=strfind(ss, 'POINT ID.');
            
        if(~isempty(k))
                
                while(1) 
                    ss=sarray{1}{i+j};
                                      
                    [node,iflag]=end_node_check(ss);
                    
                    if(iflag==1)
                        break;
                    else
                        node_disp(j)=node;
                    end
                     
                    j=j+1;
                    
                end
                
                if(iflag==1)
                    break;
                end                    
        end
    end
   
   num_node_disp=length(node_disp);
   
   for i=1:num_node_disp
       out1=sprintf('  %d',node_disp(i));
       disp(out1);
   end    
   
   setappdata(0,'num_node_disp',num_node_disp);
   setappdata(0,'node_disp',node_disp);
    
   nrd=get(handles.listbox_rd,'Value');
   setappdata(0,'nrd',nrd);
   
   qflag=0;
   setappdata(0,'qflag',qflag);
   
   if(nrd==1)
       
       reference_node=str2num(get(handles.edit_reference_node,'String'));
       
       if(isempty(reference_node))
           warndlg('Enter Reference Node');
           qflag=1;
           setappdata(0,'qflag',qflag);
           return;
       end
       
       if(max(ismember(node_disp,reference_node))~=1)
           warndlg(' Reference node is not in displacement node set');
           qflag=1;
           setappdata(0,'qflag',qflag);
           return;
       end    
       
       setappdata(0,'reference_node',reference_node);
   
   end
    
  
   
disp('    ');
disp(' Form displacement time histories ');
disp('    ');
        
nm=max(node_disp);
        
node_index=zeros(nm,1);
        
for i=1:num_node_disp
    j=node_disp(i);
    node_index(j)=i;
end
                
progressbar;
            
nndd=nt;
        
T1=zeros(nt,num_node_disp);
T2=zeros(nt,num_node_disp);
T3=zeros(nt,num_node_disp);
        
R1=zeros(nt,num_node_disp);
R2=zeros(nt,num_node_disp);
R3=zeros(nt,num_node_disp);        
         
        
for j=1:nndd
                
    progressbar(j/nndd); 
            
    k1=idd(j);
                
    k=k1-1;
                
    while(1)
                    
        k=k+1;
                                        
        sst=sarray{1}{k};             
                    
        kt=strfind(sst, 'NASTRAN');
                    
        if(~isempty(kt))
            break;
        end
                    
        ka=strfind(sst, 'POINT ID.');
            
        if(~isempty(ka))
                        
            for ijk=1:num_node_disp 
                sst=sarray{1}{k+ijk};
                strs = strsplit(sst,' ');
                iv=node_index(str2num(char(strs(1))));
                        
                T1(j,iv)=str2double(char(strs(3)));
                T2(j,iv)=str2double(char(strs(4)));
                T3(j,iv)=str2double(char(strs(5)));  
                R1(j,iv)=str2double(char(strs(6)));
                R2(j,iv)=str2double(char(strs(7)));
                R3(j,iv)=str2double(char(strs(8)));   
            end
                        
            break;
                           
        end
    end
end
 
%%
pause(0.2);
progressbar(1);       
        
 
disp('  ');
disp(' Writing displacement arrays'); 
disp('  ');        
                
for i=1:num_node_disp
 
    node=node_disp(i);
        
    output_T1=sprintf('disp_%d_T1',node);
    output_T2=sprintf('disp_%d_T2',node);            
    output_T3=sprintf('disp_%d_T3',node);         
    output_R1=sprintf('disp_%d_R1',node);
    output_R2=sprintf('disp_%d_R2',node);            
    output_R3=sprintf('disp_%d_R3',node); 
 
    assignin('base', output_T1, [tn T1(:,i)]);            
    assignin('base', output_T2, [tn T2(:,i)]); 
    assignin('base', output_T3, [tn T3(:,i)]);             
    assignin('base', output_R1, [tn R1(:,i)]);            
    assignin('base', output_R2, [tn R2(:,i)]); 
    assignin('base', output_R3, [tn R3(:,i)]);
            
    disp(output_T1);
    disp(output_T2);
    disp(output_T3); 
    disp(output_R1);
    disp(output_R2);
    disp(output_R3);
        
end
        
if(nrd==1)
            
    j=node_index(reference_node);
            
    for i=1:num_node_disp
            
        node=node_disp(i);
                
        if(node~=reference_node)
                
            output_T1=sprintf('rel_disp_%d_%d_T1',node,reference_node);
            output_T2=sprintf('rel_disp_%d_%d_T2',node,reference_node);            
            output_T3=sprintf('rel_disp_%d_%d_T3',node,reference_node);          
 
            assignin('base', output_T1, [tn T1(:,i)-T1(:,j)]);            
            assignin('base', output_T2, [tn T2(:,i)-T2(:,j)]); 
            assignin('base', output_T3, [tn T3(:,i)-T3(:,j)]);             
            
            disp(output_T1);
            disp(output_T2);
            disp(output_T3);
                
        end
                
   end
            
end
           

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
    
sarray=getappdata(0,'sarray');
ida=getappdata(0,'ida');      
tn=getappdata(0,'tn');
nt=getappdata(0,'nt');
    
disp('    ');
disp(' Find acceleration response nodes ');
disp('    ');
        
j=1;
        
        
for i=ida(1):ida(2)
                        
    ss=sarray{1}{i};
            
    k=strfind(ss, 'POINT ID.');
            
    if(~isempty(k))
                
        while(1) 
            ss=sarray{1}{i+j};
           
            [node,iflag]=end_node_check(ss);
            
            if(iflag==1)
                break;
            else
                node_accel(j)=node;
            end
                   
            j=j+1;
                    
         end
                
         if(iflag==1)
            break;
         end                
              
    end
            
end
 
   
num_node_accel=length(node_accel);
   
for i=1:num_node_accel
    out1=sprintf('  %d',node_accel(i));
    disp(out1);
end 
  
setappdata(0,'num_node_accel',num_node_accel);   
setappdata(0,'node_accel',node_accel);
  
disp('    ');
disp(' Form acceleration time histories ');
disp('    ');
      
nscale=get(handles.listbox_scale_2,'Value');
        
scale=1;
        
if(nscale==1)
    scale=str2num(get(handles.edit_factor,'String'));
end
        
if(scale>=1.0e-12 && scale<=1.0e+12)
else
    warndlg('Enter scale factor');
    return;
end
        
nm=max(node_accel);
        
node_index=zeros(nm,1);
        
for i=1:num_node_accel
    j=node_accel(i);
    node_index(j)=i;
end
        
progressbar;
            
nndd=nt;
        
T1=zeros(nt,num_node_accel);
T2=zeros(nt,num_node_accel);
T3=zeros(nt,num_node_accel);
        
R1=zeros(nt,num_node_accel);
R2=zeros(nt,num_node_accel);
R3=zeros(nt,num_node_accel);        
         
        
for j=1:nndd
                
    progressbar(j/nndd); 
            
    k1=ida(j);
                
    k=k1-1;
                
    while(1)
                    
        k=k+1;
                    
        sst=sarray{1}{k};
             
        kt=strfind(sst, 'NASTRAN');
                    
        if(~isempty(kt))
            break;
        end        
                    
        ka=strfind(sst, 'POINT ID.');
            
        if(~isempty(ka))
                        
            for ijk=1:num_node_accel 
                sst=sarray{1}{k+ijk};
                strs = strsplit(sst,' ');
                iv=node_index(str2num(char(strs(1))));
                        
                T1(j,iv)=str2double(char(strs(3)))/scale;
                T2(j,iv)=str2double(char(strs(4)))/scale;
                T3(j,iv)=str2double(char(strs(5)))/scale;  
                R1(j,iv)=str2double(char(strs(6)));
                R2(j,iv)=str2double(char(strs(7)));
                R3(j,iv)=str2double(char(strs(8)));   
            end
                        
            break;
                           
        end
    end
end
        
pause(0.2);
progressbar(1);       
        
 
disp('  ');
disp(' Writing acceleration arrays'); 
disp('  ');        
                
for i=1:num_node_accel
 
    node=node_accel(i);
        
    output_T1=sprintf('accel_%d_T1',node);
    output_T2=sprintf('accel_%d_T2',node);            
    output_T3=sprintf('accel_%d_T3',node);         
    output_R1=sprintf('accel_%d_R1',node);
    output_R2=sprintf('accel_%d_R2',node);            
    output_R3=sprintf('accel_%d_R3',node); 
 
    assignin('base', output_T1, [tn T1(:,i)]);            
    assignin('base', output_T2, [tn T2(:,i)]); 
    assignin('base', output_T3, [tn T3(:,i)]);             
    assignin('base', output_R1, [tn R1(:,i)]);            
    assignin('base', output_R2, [tn R2(:,i)]); 
    assignin('base', output_R3, [tn R3(:,i)]);
            
    disp(output_T1);
    disp(output_T2);
    disp(output_T3); 
    disp(output_R1);
    disp(output_R2);
    disp(output_R3);
        
end   
   
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
 
n=get(handles.listbox_rd,'Value');

nrd=get(handles.radiobutton_displacement,'Value');


set(handles.text_reference_node,'Visible','off');
set(handles.edit_reference_node,'Visible','off');    
 
if(n==1 && nrd==1)
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

% --- Executes on button press in radiobutton_displacement.
function radiobutton_displacement_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hint: get(hObject,'Value') returns toggle state of radiobutton_displacement
 
n=get(handles.radiobutton_displacement,'Value');
 
if(n==1)
    set(handles.text_rd_choice,'Visible','on');    
    set(handles.listbox_rd,'Visible','on');  
    set(handles.text_reference_node,'Visible','on');  
    set(handles.edit_reference_node,'Visible','on');  
else
    set(handles.text_rd_choice,'Visible','off');    
    set(handles.listbox_rd,'Visible','off');  
    set(handles.text_reference_node,'Visible','off');  
    set(handles.edit_reference_node,'Visible','off');      
end

listbox_rd_Callback(hObject, eventdata, handles);


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
 
n=get(handles.listbox_plot,'Value');
 
if(n==1)
   set(handles.listbox_units,'Visible','on');
   set(handles.text_units,'Visible','on');
else
   set(handles.listbox_units,'Visible','off');
   set(handles.text_units,'Visible','off');    
end
 

function plot_acceleration(hObject, eventdata, handles)
 
    fig_num=getappdata(0,'fig_num');
    nu=getappdata(0,'nu');
    num_node_accel=getappdata(0,'num_node_accel');
    node_accel=getappdata(0,'node_accel');
    
    xlabel3='Time (sec)';
 
    if(nu==1)
            su='Accel (in/sec^2)';
    end
    if(nu==2)
            su='Accel (G)';
    end
    if(nu==3)
            su='Accel (m/sec^2)';
    end
    if(nu==4)
            su='Accel (G)';
    end
 
    ylabel1=su;
    ylabel2=su;
    ylabel3=su;        
        
    for i=1:num_node_accel
            
          node=node_accel(i);
        
          output_T1=sprintf('accel_%d_T1',node);
          output_T2=sprintf('accel_%d_T2',node);            
          output_T3=sprintf('accel_%d_T3',node);     
            
          data1=evalin('base',output_T1); 
          data2=evalin('base',output_T2); 
          data3=evalin('base',output_T3);  
          
          t_string1=sprintf('Node %d T1',node);
          t_string2=sprintf('Node %d T2',node);
          t_string3=sprintf('Node %d T3',node);
          
          [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);
           
    end   
    
    setappdata(0,'fig_num',fig_num);
   
 
function plot_velocity(hObject, eventdata, handles)   
   
    fig_num=getappdata(0,'fig_num');
    nu=getappdata(0,'nu');
    num_node_velox=getappdata(0,'num_node_velox');
    node_velox=getappdata(0,'node_velox');
 
    xlabel3='Time (sec)';
    
        if(nu<=2)
            su='Vel (in/sec)';
        else
            su='Vel (m/sec)';            
        end    
            
        ylabel1=su;
        ylabel2=su;
        ylabel3=su;        
        
        for i=1:num_node_velox
            
          node=node_velox(i);
        
          output_T1=sprintf('velox_%d_T1',node);
          output_T2=sprintf('velox_%d_T2',node);            
          output_T3=sprintf('velox_%d_T3',node);     
            
          data1=evalin('base',output_T1); 
          data2=evalin('base',output_T2); 
          data3=evalin('base',output_T3);  
          
          t_string1=sprintf('Node %d T1',node);
          t_string2=sprintf('Node %d T2',node);
          t_string3=sprintf('Node %d T3',node);
          
          [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);
            
        end    
     
        
        
        
        
 nrd=getappdata(0,'nrd');       
    
 if(nrd==1)
     
     reference_node=getappdata(0,'reference_node');
            
    if(nu<=2)
        su='Rel Vel (in/sec)';
    else
        su='Rel Vel (m/sec)';            
    end    
        
    ylabel1=su;
    ylabel2=su;
    ylabel3=su;             
            
            
    for i=1:num_node_velox
            
        node=node_velox(i);            
                
       if(node~=reference_node)
                
            output_T1=sprintf('rel_velox_%d_%d_T1',node,reference_node);
            output_T2=sprintf('rel_velox_%d_%d_T2',node,reference_node);            
            output_T3=sprintf('rel_velox_%d_%d_T3',node,reference_node);
             
            data1=evalin('base',output_T1); 
            data2=evalin('base',output_T2); 
            data3=evalin('base',output_T3);  
          
            t_string1=sprintf('Node %d - %d  T1',node,reference_node);
            t_string2=sprintf('Node %d - %d  T2',node,reference_node);
            t_string3=sprintf('Node %d - %d  T3',node,reference_node);
          
            [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);              
       end
    end
        
end       
    
setappdata(0,'fig_num',fig_num);


function plot_displacement(hObject, eventdata, handles)      
   
fig_num=getappdata(0,'fig_num');
nu=getappdata(0,'nu');
num_node_disp=getappdata(0,'num_node_disp');
node_disp=getappdata(0,'node_disp');
nrd=getappdata(0,'nrd');
reference_node=getappdata(0,'reference_node');
    
xlabel3='Time (sec)';
        
if(nu<=2)
    su='Disp (in)';
else
    su='Disp (m)';            
end    
            
ylabel1=su;
ylabel2=su;
ylabel3=su;        
        
for i=1:num_node_disp
            
    node=node_disp(i);
        
    output_T1=sprintf('disp_%d_T1',node);
    output_T2=sprintf('disp_%d_T2',node);            
    output_T3=sprintf('disp_%d_T3',node);     
            
    data1=evalin('base',output_T1); 
    data2=evalin('base',output_T2); 
    data3=evalin('base',output_T3);  
          
    t_string1=sprintf('Node %d T1',node);
    t_string2=sprintf('Node %d T2',node);
    t_string3=sprintf('Node %d T3',node);
          
    [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);
                      
end
        
if(nrd==1)
            
    if(nu<=2)
        su='Rel Disp (in)';
    else
        su='Rel Disp (m)';            
    end    
        
    ylabel1=su;
    ylabel2=su;
    ylabel3=su;             
            
            
    for i=1:num_node_disp
            
        node=node_disp(i);            
                
       if(node~=reference_node)
                
            output_T1=sprintf('rel_disp_%d_%d_T1',node,reference_node);
            output_T2=sprintf('rel_disp_%d_%d_T2',node,reference_node);            
            output_T3=sprintf('rel_disp_%d_%d_T3',node,reference_node);
             
            data1=evalin('base',output_T1); 
            data2=evalin('base',output_T2); 
            data3=evalin('base',output_T3);  
          
            t_string1=sprintf('Node %d - %d  T1',node,reference_node);
            t_string2=sprintf('Node %d - %d  T2',node,reference_node);
            t_string3=sprintf('Node %d - %d  T3',node,reference_node);
          
            [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);              
       end
    end
        
end

setappdata(0,'fig_num',fig_num);
        

 
% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
   tic
  
   clear_all_figures(nastran_modal_transient);
   
   setappdata(0,'metric_displacement',0);
   setappdata(0,'metric_velocity',0);
   setappdata(0,'metric_acceleration',0);
   
   setappdata(0,'metric_quad4stress',0);
   setappdata(0,'metric_quad4strain',0);
   
   setappdata(0,'metric_tria3stress',0);
   setappdata(0,'metric_tria3strain',0);
   
   setappdata(0,'metric_hexahedron_stress',0);
   setappdata(0,'metric_beam_stress',0);
      
   fig_num=1;
 
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
   rb_beam_stress = get(handles.radiobutton_beam_stress, 'Value');  
   
   setappdata(0,'rb_displacement',rb_displacement);
   setappdata(0,'rb_velocity',rb_velocity);
   setappdata(0,'rb_acceleration',rb_acceleration);
   
   setappdata(0,'rb_plate_quad4_stress',rb_plate_quad4_stress);
   setappdata(0,'rb_plate_quad4_strain',rb_plate_quad4_strain);  
   
   setappdata(0,'rb_plate_tria3_stress',rb_plate_tria3_stress);   
   setappdata(0,'rb_plate_tria3_strain',rb_plate_tria3_strain);    
   
   
   setappdata(0,'rb_solid_hexahedron_stress',rb_solid_hexahedron_stress);
   setappdata(0,'rb_beam_stress',rb_beam_stress);   
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
 
   ip=get(handles.listbox_plot,'Value');
   nu=get(handles.listbox_units,'Value');
   setappdata(0,'nu',nu);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
   
   find_number_time_points(hObject, eventdata, handles);
   
   zflag=getappdata(0,'zflag');
   
   if(zflag==1)
       return;
   end
   
 
   metric_displacement=getappdata(0,'metric_displacement');
   metric_velocity=getappdata(0,'metric_velocity');
   metric_acceleration=getappdata(0,'metric_acceleration');
   metric_quad4stress=getappdata(0,'metric_quad4stress');
   metric_quad4strain=getappdata(0,'metric_quad4strain');
   metric_tria3stress=getappdata(0,'metric_tria3stress');
   metric_tria3strain=getappdata(0,'metric_tria3strain');
   metric_hexahedron_stress=getappdata(0,'metric_hexahedron_stress');
   metric_beam_stress=getappdata(0,'metric_beam_stress');
    
   
   out1=sprintf(' metric_displacement=%d',metric_displacement);
   out2=sprintf(' metric_velocity=%d',metric_velocity);   
   out3=sprintf(' metric_acceleration=%d',metric_acceleration);
   
   out4=sprintf(' metric_quad4stress=%d',metric_quad4stress);
   out5=sprintf(' metric_quad4strain=%d',metric_quad4strain);
    
   out6=sprintf(' metric_tria3stress=%d',metric_tria3stress); 
   out7=sprintf(' metric_tria3strain=%d',metric_tria3strain);    
   
   out8=sprintf(' metric_beam_stress=%d',metric_beam_stress);     
   out9=sprintf(' metric_hexahedron_stress=%d',metric_hexahedron_stress);    

   
   
   disp(out1);
   disp(out2);  
   disp(out3);
   disp(out4);     
   disp(out5);
   disp(out6);     
   disp(out7);     
   disp(out8);    
   disp(out9); 
   
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 


   if(metric_displacement==1 && rb_displacement==1)
 
        find_displacement_nodes(hObject, eventdata, handles);    
        
        qflag=getappdata(0,'qflag');
        
        if(qflag==1)
            return;
        end
        
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

   if(metric_beam_stress==1 && rb_beam_stress==1)
       
       find_beamstress_elem(hObject, eventdata, handles);        

   end    

%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%

   if(metric_hexahedron_stress==1 && rb_solid_hexahedron_stress==1)
       
       find_hexahedron_elem(hObject, eventdata, handles);        

   end   
   
   
disp(' ');   

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
if(ip==1)
 
    if(metric_displacement==1 && rb_displacement==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_displacement(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    if(metric_velocity==1 && rb_velocity==1)
 
        setappdata(0,'fig_num',fig_num);
        
        plot_velocity(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
 
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    if(metric_acceleration==1 && rb_acceleration==1)    
        
        setappdata(0,'fig_num',fig_num);
        
        plot_acceleration(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
        
    end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    if(metric_quad4stress==1 && rb_plate_quad4_stress==1)
        
        disp('plot stress')
 
        setappdata(0,'fig_num',fig_num);
        
        plot_quad4stress(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');        
        
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(metric_quad4strain==1 && rb_plate_quad4_strain==1)
        
        disp('plot strain')
 
        setappdata(0,'fig_num',fig_num);
        
        plot_quad4strain(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');        
        
    end    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(metric_tria3stress==1 && rb_plate_tria3_stress==1)
 
        setappdata(0,'fig_num',fig_num);
        
        plot_tria3stress(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');        
        
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(metric_tria3strain==1 && rb_plate_tria3_strain==1)
 
        setappdata(0,'fig_num',fig_num);
        
        plot_tria3strain(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');        
        
    end 
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(metric_beam_stress==1 && rb_beam_stress==1)
 
        setappdata(0,'fig_num',fig_num);
        
        plot_beam_stress(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');        
        
    end    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(metric_hexahedron_stress==1 && rb_solid_hexahedron_stress==1)
 
        setappdata(0,'fig_num',fig_num);
        
        plot_hexahedron_stress(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');        
        
    end    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
disp('  ');
disp(' Analysis complete'); 
disp('  ');
toc
disp('  ');   

msgbox(' Analysis complete ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 
function plate_stress_time_history(hObject, eventdata, handles)  
    
elem_plate_stress=getappdata(0,'elem_plate_stress');
num_elem_plate_stress=getappdata(0,'num_elem_plate_stress');
nt=getappdata(0,'nt');
iplate_stress=getappdata(0,'iplate_stress');
sarray=getappdata(0,'sarray');


nm=max(elem_plate_stress);
        
elem_index=zeros(nm,1);
        
for i=1:num_elem_plate_stress
    j=elem_plate_stress(i);
    elem_index(j)=i;
end

max_iv=elem_index(num_elem_plate_stress);
          
progressbar;
            
nndd=nt;
        
plate_normal_x=zeros(nt,num_elem_plate_stress);
plate_normal_y=zeros(nt,num_elem_plate_stress);
plate_shear=zeros(nt,num_elem_plate_stress);
        
plate_angle_p=zeros(nt,num_elem_plate_stress);        
plate_major_p=zeros(nt,num_elem_plate_stress);
plate_minor_p=zeros(nt,num_elem_plate_stress);
plate_VM=zeros(nt,num_elem_plate_stress); 
plate_VM_signed=zeros(nt,num_elem_plate_stress);  
  
k1=iplate_stress(1);
        
k=k1-1;

for j=1:nndd
    
    progressbar(j/nndd); 
    
    while(1)
    
        k=k+1;
                    
        sst=sarray{1}{k};
        strs = strsplit(sst,' ');       
     
        LL=length(strs);
     
        if(LL==10 || LL==11)
            
            try
                 
                s1=str2num(char(strs(1)));
                s2=str2num(char(strs(2)));
            
                if(s1==0 && ~isnan(s2) && s2>=elem_plate_stress(1))
                
                    iv = find(elem_plate_stress==s2,1);
    
                    if(iv>=1)
                        
                        plate_normal_x(j,iv)=str2double(char(strs(LL-6)));
                        plate_normal_y(j,iv)=str2double(char(strs(LL-5)));
                        plate_shear(j,iv)=str2double(char(strs(LL-4)));
        
                        plate_angle_p(j,iv)=str2double(char(strs(LL-3)));
                        plate_major_p(j,iv)=str2double(char(strs(LL-2)));
                        plate_minor_p(j,iv)=str2double(char(strs(LL-1)));
                        plate_VM(j,iv)=str2double(char(strs(LL)));
                        
                        A=[ plate_major_p(j,iv) ; plate_minor_p(j,iv)];
                        [~,idx]=max(abs(A));
                        plate_VM_signed(j,iv)=plate_VM(j,iv)*sign(A(idx));
                
                        if(iv==num_elem_plate_stress)
                            break;
                        end
                                     
                    end
            
                end
            
            catch
            end
            
        end
    end  
end           

              
pause(0.2);
progressbar(1);          
        
% disp('ref 1')
% max(abs(plate_VM_signed(:,1)))
                
setappdata(0,'plate_normal_x',plate_normal_x);
setappdata(0,'plate_normal_y',plate_normal_y);
setappdata(0,'plate_shear',plate_shear);
          
setappdata(0,'plate_angle_p',plate_angle_p);
setappdata(0,'plate_major_p',plate_major_p);
setappdata(0,'plate_minor_p',plate_minor_p);
setappdata(0,'plate_VM',plate_VM);       
          
setappdata(0,'plate_VM_signed',plate_VM_signed);
              
        
   
    




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
function plot_quad4stress(hObject, eventdata, handles)      

fig_num=getappdata(0,'fig_num');
nu=getappdata(0,'nu');
num_elem_quad4stress=getappdata(0,'num_elem_quad4stress');
elem_quad4stress=getappdata(0,'elem_quad4stress');
tn=getappdata(0,'tn');

quad4_normal_x=getappdata(0,'quad4_stress_normal_x');
quad4_normal_y=getappdata(0,'quad4_stress_normal_y');
quad4_shear=getappdata(0,'quad4_stress_shear');
quad4_VM_signed=getappdata(0,'quad4_stress_VM_signed');
   
xlabel3='Time (sec)';
   
if(nu<=2)
    su='Stress (psi)';
else
    su='Stress (Pa)';            
end    
    
for i=1:num_elem_quad4stress
            
    t_string=sprintf('Signed Von Mises Stress  Element %d',elem_quad4stress(i));
       
    ylabel1=su;
    ylabel2=su;
    ylabel3=su;
       
    data1=[tn quad4_normal_x(:,i)];
    data2=[tn quad4_normal_y(:,i)];
    data3=[tn quad4_shear(:,i)];
       
    t_string1=sprintf('Stress Normal x  Element %d',elem_quad4stress(i));
    t_string2=sprintf('Stress Normal y  Element %d',elem_quad4stress(i));
    t_string3=sprintf('Stress Shear xy  Element %d',elem_quad4stress(i));
       
       
    [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);
                      
       
    a=[tn quad4_VM_signed(:,i)];
    [fig_num]=plot_TH(fig_num,xlabel3,su,t_string,a);
           
end 
   
setappdata(0,'fig_num',fig_num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_hexahedron_stress(hObject, eventdata, handles)     

disp(' ');
disp(' Hexahedron stress plots ');
disp(' ');   
disp(' SVM  = signed Von Mises stress');
disp(' ');


fig_num=getappdata(0,'fig_num');
nu=getappdata(0,'nu');
num_elem_hexahedronstress=getappdata(0,'num_elem_hexahedronstress');
elem_hexahedronstress=getappdata(0,'elem_hexahedronstress');
tn=getappdata(0,'tn');


hexahedron_VM_signed_1=getappdata(0,'hexahedron_VM_signed_1');
hexahedron_VM_signed_2=getappdata(0,'hexahedron_VM_signed_2');
hexahedron_VM_signed_3=getappdata(0,'hexahedron_VM_signed_3');
hexahedron_VM_signed_4=getappdata(0,'hexahedron_VM_signed_4');
hexahedron_VM_signed_5=getappdata(0,'hexahedron_VM_signed_5');
hexahedron_VM_signed_6=getappdata(0,'hexahedron_VM_signed_6');
hexahedron_VM_signed_7=getappdata(0,'hexahedron_VM_signed_7');
hexahedron_VM_signed_8=getappdata(0,'hexahedron_VM_signed_8');

ZN=getappdata(0,'ZN');

%%%


   
if(nu<=2)
    su='Stress (psi)';
else
    su='Stress (Pa)';            
end    

tstart=tn(1);
tend=tn(length(tn));
    
for i=1:num_elem_hexahedronstress
            
    hp=figure(fig_num);
    fig_num=fig_num+1;
    subplot(2,4,1);
    plot(tn,hexahedron_VM_signed_1(:,i));
    ylabel(su);
    xlim([tstart tend]);
    grid on;
    xlabel('Time(sec)');    
    out1=sprintf('SVM Stress %d:%d',elem_hexahedronstress(i),ZN(i,1));
    title(out1);
    
    subplot(2,4,2);
    plot(tn,hexahedron_VM_signed_2(:,i));
    ylabel(su);    
    xlim([tstart tend]);
    grid on;
    xlabel('Time(sec)');    
    out1=sprintf('SVM Stress %d:%d',elem_hexahedronstress(i),ZN(i,2));  
    title(out1);    

    subplot(2,4,3);
    plot(tn,hexahedron_VM_signed_3(:,i));
    ylabel(su);    
    xlim([tstart tend]);
    grid on;
    xlabel('Time(sec)');    
    out1=sprintf('SVM Stress %d:%d',elem_hexahedronstress(i),ZN(i,3));   
    title(out1);
    
    
    subplot(2,4,4);
    plot(tn,hexahedron_VM_signed_4(:,i));
    ylabel(su);
    xlim([tstart tend]);
    grid on;
    xlabel('Time(sec)');    
    out1=sprintf('SVM Stress %d:%d',elem_hexahedronstress(i),ZN(i,4));
    title(out1);
     
    subplot(2,4,5);
    plot(tn,hexahedron_VM_signed_5(:,i));
    ylabel(su);    
    xlim([tstart tend]);
    grid on;
    xlabel('Time(sec)');    
    out1=sprintf('SVM Stress %d:%d',elem_hexahedronstress(i),ZN(i,5));    
    title(out1);
    
    subplot(2,4,6);
    plot(tn,hexahedron_VM_signed_6(:,i));
    ylabel(su);   
    xlim([tstart tend]);
    grid on;
    xlabel('Time(sec)');    
    out1=sprintf('SVM Stress %d:%d',elem_hexahedronstress(i),ZN(i,6));    
    title(out1);
    
    subplot(2,4,7);
    plot(tn,hexahedron_VM_signed_7(:,i));
    ylabel(su);    
    xlim([tstart tend]);
    grid on;
    xlabel('Time(sec)');
    out1=sprintf('SVM Stress %d:%d',elem_hexahedronstress(i),ZN(i,7));   
    title(out1);
    
    subplot(2,4,8);
    plot(tn,hexahedron_VM_signed_8(:,i));
    ylabel(su);    
    xlim([tstart tend]);
    grid on;
    xlabel('Time(sec)');
    out1=sprintf('SVM Stress %d:%d',elem_hexahedronstress(i),ZN(i,8));
    title(out1);
    
    set(hp, 'Position', [0 0 1100 600]);
               
end 
   
setappdata(0,'fig_num',fig_num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_tria3stress(hObject, eventdata, handles)      
   
fig_num=getappdata(0,'fig_num');
nu=getappdata(0,'nu');
num_elem_tria3stress=getappdata(0,'num_elem_tria3stress');
elem_tria3stress=getappdata(0,'elem_tria3stress');
tn=getappdata(0,'tn');

tria3_stress_normal_x=getappdata(0,'tria3_stress_normal_x');
tria3_stress_normal_y=getappdata(0,'tria3_stress_normal_y');
tria3_stress_shear=getappdata(0,'tria3_stress_shear');
tria3_stress_VM_signed=getappdata(0,'tria3_stress_VM_signed');
   
xlabel3='Time (sec)';
   
if(nu<=2)
    su='Stress (psi)';
else
    su='Stress (Pa)';            
end    
    
for i=1:num_elem_tria3stress
            
    t_string=sprintf('Signed Von Mises Stress Element %d',elem_tria3stress(i));
       
    ylabel1=su;
    ylabel2=su;
    ylabel3=su;
       
    data1=[tn tria3_stress_normal_x(:,i)];
    data2=[tn tria3_stress_normal_y(:,i)];
    data3=[tn tria3_stress_shear(:,i)];
       
    t_string1=sprintf('Stress Normal x  Element %d',elem_tria3stress(i));
    t_string2=sprintf('Stress Normal y  Element %d',elem_tria3stress(i));
    t_string3=sprintf('Stress Shear xy  Element %d',elem_tria3stress(i));
       
       
    [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);
                      
       
    a=[tn tria3_stress_VM_signed(:,i)];
    [fig_num]=plot_TH(fig_num,xlabel3,su,t_string,a);
           
end 
   
setappdata(0,'fig_num',fig_num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plate_stress_strain_core(hObject, eventdata, handles)    
   
j=1;
        
iflag=0;

jk=1;

istart=getappdata(0,'istart');
iend=getappdata(0,'iend');
sarray=getappdata(0,'sarray');

Zb=-999;

for i=istart:iend
                       
            ss=sarray{1}{i};
            
            k=strfind(ss, 'GRID-ID');
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

            
function find_tria3stress_elem(hObject, eventdata, handles)    
   
sarray=getappdata(0,'sarray');
itria3stress=getappdata(0,'itria3stress');           
nt=getappdata(0,'nt');
tn=getappdata(0,'tn');       
    
    
disp('    ');
disp(' Find tria3 stress response elements ');
disp('    ');
        
istart=itria3stress(1);
iend=max(itria3stress);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);

plate_stress_strain_core(hObject, eventdata, handles);    
     

Z=getappdata(0,'Z');
 
try
    elem_tria3stress = Z(Z~=0);
catch
    warndlg(' tria3 elements not found');
    return;  
end
    
num_elem_tria3stress=length(elem_tria3stress);
   
for i=1:num_elem_tria3stress
    out1=sprintf('  %d',elem_tria3stress(i));
    disp(out1);
end          
    
setappdata(0,'num_elem_tria3stress',num_elem_tria3stress);
setappdata(0,'elem_tria3stress',elem_tria3stress);  
    
%%

disp('    ');
disp(' Form TRIA3 stress time histories ');
disp('    ');
           
setappdata(0,'num_elem_plate_stress',num_elem_tria3stress);
setappdata(0,'elem_plate_stress',elem_tria3stress);   
setappdata(0,'iplate_stress',itria3stress);

plate_stress_time_history(hObject, eventdata, handles);

tria3_normal_x=getappdata(0,'plate_normal_x');
tria3_normal_y=getappdata(0,'plate_normal_y');
tria3_shear=getappdata(0,'plate_shear');
tria3_VM_signed=getappdata(0,'plate_VM_signed');
tria3_angle_p=getappdata(0,'plate_angle_p');
tria3_major_p=getappdata(0,'plate_major_p');
tria3_minor_p=getappdata(0,'plate_minor_p');
tria3_VM=getappdata(0,'plate_VM');       

setappdata(0,'tria3_stress_normal_x',tria3_normal_x);
setappdata(0,'tria3_stress_normal_y',tria3_normal_y);
setappdata(0,'tria3_stress_shear',tria3_shear);
setappdata(0,'tria3_stress_VM_signed',tria3_VM_signed);


disp('  ');
disp(' Writing tria3 stress arrays'); 
disp('  ');        
                
for i=1:num_elem_tria3stress
 
    elem=elem_tria3stress(i);
        
    output_S1=sprintf('tria3_stress_normal_x_%d',elem);
    output_S2=sprintf('tria3_stress_normal_y_%d',elem);            
    output_S3=sprintf('tria3_stress_shear_%d',elem);         
    output_S4=sprintf('tria3_stress_angle_p_%d',elem);
    output_S5=sprintf('tria3_stress_major_p_%d',elem);            
    output_S6=sprintf('tria3_stress_minor_p_%d',elem); 
    output_S7=sprintf('tria3_stress_VM_%d',elem);            
    output_S8=sprintf('tria3_stress_VM_signed_%d',elem);    
%    i
%    elem
%    size(tn)
%    size(tria3_normal_x(:,i))
 
    assignin('base', output_S1, [tn tria3_normal_x(:,i)]);            
    assignin('base', output_S2, [tn tria3_normal_y(:,i)]); 
    assignin('base', output_S3, [tn tria3_shear(:,i)]);             
    assignin('base', output_S4, [tn tria3_angle_p(:,i)]);            
    assignin('base', output_S5, [tn tria3_major_p(:,i)]); 
    assignin('base', output_S6, [tn tria3_minor_p(:,i)]);
    assignin('base', output_S7, [tn tria3_VM(:,i)]); 
    assignin('base', output_S8, [tn tria3_VM_signed(:,i)]);    
            
    disp(output_S1);
    disp(output_S2);
    disp(output_S3); 
    disp(output_S4);
    disp(output_S5);
    disp(output_S6);
    disp(output_S7);
    disp(output_S8);    
        
end


        
pause(0.2);
progressbar(1);     
    
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
function find_velocity_nodes(hObject, eventdata, handles)
    
sarray=getappdata(0,'sarray');
idv=getappdata(0,'idv');  
tn=getappdata(0,'tn');
nt=getappdata(0,'nt');
    
    
disp('    ');
disp(' Find velocity response nodes ');
disp('    ');
        
j=1;
            
for i=idv(1):idv(2)
                        
    ss=sarray{1}{i};
            
    k=strfind(ss, 'POINT ID.');
            
    if(~isempty(k))
                
        while(1) 
            ss=sarray{1}{i+j};

            [node,iflag]=end_node_check(ss);
            
            if(iflag==1)
                break;
            else
                node_velox(j)=node;
            end
                   
            j=j+1;
                    
        end
                
        if(iflag==1)
            break;
        end                
              
    end
    
end
 
num_node_velox=length(node_velox);
   
for i=1:num_node_velox
    out1=sprintf('  %d',node_velox(i));
    disp(out1);
end 
   
setappdata(0,'num_node_velox',num_node_velox);
setappdata(0,'node_velox',node_velox);       
   
%%%
 
disp('    ');
disp(' Form velocity time histories ');
disp('    ');
        
nm=max(node_velox);
        
node_index=zeros(nm,1);
        
for i=1:num_node_velox
	j=node_velox(i);
	node_index(j)=i;
end


progressbar;
            
nndd=nt;
        
T1=zeros(nt,num_node_velox);
T2=zeros(nt,num_node_velox);
T3=zeros(nt,num_node_velox);
        
R1=zeros(nt,num_node_velox);
R2=zeros(nt,num_node_velox);
R3=zeros(nt,num_node_velox);        
         
        
for j=1:nndd
                
    progressbar(j/nndd); 
            
    k1=idv(j);
                
    k=k1-1;
                
    while(1)
                    
        k=k+1;
                    
        sst=sarray{1}{k};
             
        kt=strfind(sst, 'NASTRAN');
                    
        if(~isempty(kt))
            break;
        end        
                    
        ka=strfind(sst, 'POINT ID.');
            
        if(~isempty(ka))
                        
            for ijk=1:num_node_velox 
                sst=sarray{1}{k+ijk};
                strs = strsplit(sst,' ');
                iv=node_index(str2num(char(strs(1))));
                        
                T1(j,iv)=str2double(char(strs(3)));
                T2(j,iv)=str2double(char(strs(4)));
                T3(j,iv)=str2double(char(strs(5)));  
                R1(j,iv)=str2double(char(strs(6)));
                R2(j,iv)=str2double(char(strs(7)));
                R3(j,iv)=str2double(char(strs(8)));   
            end
                        
            break;
                           
        end
    end
end
        
pause(0.2);
progressbar(1);       
        

disp('  ');
disp(' Writing velocity arrays'); 
disp('  ');        
                
for i=1:num_node_velox
 
            node=node_velox(i);
        
            output_T1=sprintf('velox_%d_T1',node);
            output_T2=sprintf('velox_%d_T2',node);            
            output_T3=sprintf('velox_%d_T3',node);         
            output_R1=sprintf('velox_%d_R1',node);
            output_R2=sprintf('velox_%d_R2',node);            
            output_R3=sprintf('velox_%d_R3',node); 
 
            assignin('base', output_T1, [tn T1(:,i)]);            
            assignin('base', output_T2, [tn T2(:,i)]); 
            assignin('base', output_T3, [tn T3(:,i)]);             
            assignin('base', output_R1, [tn R1(:,i)]);            
            assignin('base', output_R2, [tn R2(:,i)]); 
            assignin('base', output_R3, [tn R3(:,i)]);
            
            disp(output_T1);
            disp(output_T2);
            disp(output_T3); 
            disp(output_R1);
            disp(output_R2);
            disp(output_R3);
                
end     

nrd=getappdata(0,'nrd');

if(nrd==1)

    reference_node=getappdata(0,'reference_node');    
    
    j=node_index(reference_node);
            
    for i=1:num_node_velox
            
        node=node_velox(i);
                
        if(node~=reference_node)
                
            output_T1=sprintf('rel_velox_%d_%d_T1',node,reference_node);
            output_T2=sprintf('rel_velox_%d_%d_T2',node,reference_node);            
            output_T3=sprintf('rel_velox_%d_%d_T3',node,reference_node);          
 
            assignin('base', output_T1, [tn T1(:,i)-T1(:,j)]);            
            assignin('base', output_T2, [tn T2(:,i)-T2(:,j)]); 
            assignin('base', output_T3, [tn T3(:,i)-T3(:,j)]);             
            
            disp(output_T1);
            disp(output_T2);
            disp(output_T3);
                
        end
                
   end
            
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 
function find_hexahedron_elem(hObject, eventdata, handles)     
 
sarray=getappdata(0,'sarray');
ihexahedronstress=getappdata(0,'ihexahedronstress');    
nt=getappdata(0,'nt');
tn=getappdata(0,'tn');    
    


%%%

disp('    ');
disp(' Find hexahedron stress response elements & nodes ');
disp('    ');
        
jk=1;

i=ihexahedronstress(1);    
    
while(1)    
    
    ss=sarray{1}{i};
    strs = strsplit(ss,' ');
    
    kk=strfind(ss,'0GRID');
    
    if(~isempty(kk))
        Z(jk)=str2double(strs(2));

        if(jk>=2 && Z(jk)==Z(1))
            
            Z(jk)=[];
            
            break;
        end
        
        iq=1;
        ij=0;
        
        while(1)
            
            ij=ij+1;
            
            ss=sarray{1}{i+ij};
            
            if((i+ij)>30000)
                break;
            end
            
            k1=strfind(ss,'0GRID');
            k2=strfind(ss,'XY');
            k3=strfind(ss,'CENTER');
            
            if(~isempty(k1))
                break;
            end
            
            if(~isempty(k2) && isempty(k3))
                strs = strsplit(ss,' ');
                node = str2double(strs(2));
                ZN(jk,iq)=node;
                iq=iq+1;
            end
            
            if(iq==9)
                break;
            end
            
        end
        
        jk=jk+1;
        
    end 
    
    i=i+1;
                   
end    

 
elem_hexahedronstress=Z;

% elem_hexahedronstress = Z(Z~=0);
   
num_elem_hexahedronstress=length(elem_hexahedronstress);
   

for i=1:num_elem_hexahedronstress
    out1=sprintf('  elem=%d :  %d %d %d %d %d %d %d %d',elem_hexahedronstress(i),...
        ZN(i,1),ZN(i,2),ZN(i,3),ZN(i,4),ZN(i,5),ZN(i,6),ZN(i,7),ZN(i,8));
    disp(out1);
end          
    
setappdata(0,'num_elem_hexahedronstress',num_elem_hexahedronstress);
setappdata(0,'elem_hexahedronstress',elem_hexahedronstress);    

%%


disp('    ');
disp(' Form hexahedron time histories ');
disp('    ');
           
nm=max(elem_hexahedronstress);
        
elem_index=zeros(nm,1);
        
for i=1:num_elem_hexahedronstress
    j=elem_hexahedronstress(i);
    elem_index(j)=i;   
end

%%

num_time=length(tn);

out1=sprintf(' num_time = %d    nm = %d ',num_time,nm);
disp(out1);

hexahedron_VM_1=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_2=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_3=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_4=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_5=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_6=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_7=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_8=zeros(num_time,num_elem_hexahedronstress);




hexahedron_VM_signed_1=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_signed_2=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_signed_3=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_signed_4=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_signed_5=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_signed_6=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_signed_7=zeros(num_time,num_elem_hexahedronstress);
hexahedron_VM_signed_8=zeros(num_time,num_elem_hexahedronstress);

%%



ntt=0;

progressbar;


i0GRID = strfind(sarray{:},'0GRID CS  8 GP');
i0GRID = find(not(cellfun('isempty',i0GRID)));
num_i0GRID = length(i0GRID);   

out1=sprintf(' num_i0GRID=%d ',num_i0GRID);
disp(out1);

for iw=1:num_i0GRID
    
    progressbar(iw/num_i0GRID);
   
    i=i0GRID(iw);
    
    ss=sarray{1}{i};
    strs = strsplit(ss,' ');
    
    ee=str2double(strs(2));
  
    ii=elem_index(ee);
    
    if(ii==1)
        ntt=ntt+1;
    end

    if(ntt>num_time)
		break;
    end
    
    
    ij=0;
    
    while(1)

          ij=ij+1;
        
          try
            ss=sarray{1}{i+ij};
          catch
            break;
          end

          k1=strfind(ss,'0GRID');
          
          if(~isempty(k1))
              break;
          end           
          
          kxy=strfind(ss,'XY');
                   
          k3=strfind(ss,'CENTER'); 
          
          if(~isempty(kxy) && isempty(k3))
              
                strs = strsplit(ss,' ');
  
                PS=zeros(3,1);
                
                node=str2double(strs(2));
                PS(1)=str2double(strs(8));
                
                ssb=sarray{1}{i+ij+1};
                kyz=strfind(ssb,'YZ');
                
                if(~isempty(kyz))
                    strsb = strsplit(ssb,' ');
                    PS(2)=str2double(strsb(6));
                end
                
                ssc=sarray{1}{i+ij+2};
                kzx=strfind(ssb,'ZX');
                
                if(~isempty(kzx))
                    strsc = strsplit(ssc,' ');
                    PS(3)=str2double(strsc(6));
                end               
                
                [~, idx] = max(abs(PS));
                
                ratio=sign(PS(idx));
                
                
%               [~,iy] = min(abs(node-ZN(ii,:)));
                
                [iy] = find(ZN(ii,:)==node);
                
                svm=str2double(strs(length(strs)));
                
                VM_stress=svm;
                VM_signed_stress=svm*ratio;               
                
%                if(ee==3485)
%                      out1=sprintf(' ntt=%d  ee=%d node=%d ii=%d  iy=%d %8.4g',ntt,ee,node,ii,iy,VM_stress);          
%                      disp(out1);                   
%               end
%
                if(iy==1)
                    hexahedron_VM_1(ntt,ii)=VM_stress;   
                    hexahedron_VM_signed_1(ntt,ii)=VM_signed_stress;                   
                end
                if(iy==2)
                    hexahedron_VM_2(ntt,ii)=VM_stress;    
                    hexahedron_VM_signed_2(ntt,ii)=VM_signed_stress;                          
                end                
                if(iy==3)
                    hexahedron_VM_3(ntt,ii)=VM_stress;   
                    hexahedron_VM_signed_3(ntt,ii)=VM_signed_stress;                      
                end
                if(iy==4)
                    hexahedron_VM_4(ntt,ii)=VM_stress;    
                    hexahedron_VM_signed_4(ntt,ii)=VM_signed_stress;                    
                end   
                 if(iy==5)
                    hexahedron_VM_5(ntt,ii)=VM_stress;    
                    hexahedron_VM_signed_5(ntt,ii)=VM_signed_stress;                     
                end
                if(iy==6)
                    hexahedron_VM_6(ntt,ii)=VM_stress; 
                    hexahedron_VM_signed_6(ntt,ii)=VM_signed_stress;                      
                end                
                if(iy==7)
                    hexahedron_VM_7(ntt,ii)=VM_stress;     
                    hexahedron_VM_signed_7(ntt,ii)=VM_signed_stress;                        
                end
                if(iy==8)
                    hexahedron_VM_8(ntt,ii)=VM_stress;   
                    hexahedron_VM_signed_8(ntt,ii)=VM_signed_stress;                    
                end              
              
          end    
        
    end    
        
    
end    

pause(0.2);
progressbar(1);

%%%%%%

disp('  ');
disp(' Writing hexahedron stress arrays'); 
disp('  ');        
                
for i=1:num_elem_hexahedronstress
    
    elem=elem_hexahedronstress(i);
    
    for j=1:8
        
        node=ZN(i,j);
        
        output_S=sprintf('hexahedron_VM_stress_%d_%d',elem,node);
 
 %
        if(j==1)
            data=hexahedron_VM_1(:,i);           
        end
        if(j==2)
            data=hexahedron_VM_2(:,i);
        end        
        if(j==3)
            data=hexahedron_VM_3(:,i);
        end
        if(j==4)
            data=hexahedron_VM_4(:,i);
        end  
        if(j==5)
            data=hexahedron_VM_5(:,i);
        end
        if(j==6)
            data=hexahedron_VM_6(:,i);
        end        
        if(j==7)
            data=hexahedron_VM_7(:,i);
        end
        if(j==8)
            data=hexahedron_VM_8(:,i);
        end         
%        
        
%         out1=sprintf(' elem=%d   node=%d   %8.4g',elem,node,max(data));
%         disp(out1);

        assignin('base', output_S, [tn data]);
        
        disp(output_S);
    
    end
        
end

%%

for i=1:num_elem_hexahedronstress
    
    elem=elem_hexahedronstress(i);
    
    for j=1:8
        
        node=ZN(i,j);
        
        output_S=sprintf('hexahedron_VM_signed_stress_%d_%d',elem,node);
 
 %
        if(j==1)
            data=hexahedron_VM_signed_1(:,i);           
        end
        if(j==2)
            data=hexahedron_VM_signed_2(:,i);
        end        
        if(j==3)
            data=hexahedron_VM_signed_3(:,i);
        end
        if(j==4)
            data=hexahedron_VM_signed_4(:,i);
        end  
        if(j==5)
            data=hexahedron_VM_signed_5(:,i);
        end
        if(j==6)
            data=hexahedron_VM_signed_6(:,i);
        end        
        if(j==7)
            data=hexahedron_VM_signed_7(:,i);
        end
        if(j==8)
            data=hexahedron_VM_signed_8(:,i);
        end         
%        
        
%         out1=sprintf(' elem=%d   node=%d   %8.4g',elem,node,max(data));
%         disp(out1);

        assignin('base', output_S, [tn data]);
        
        disp(output_S);
    
    end
        
end

setappdata(0,'ZN',ZN);

setappdata(0,'hexahedron_VM_signed_1',hexahedron_VM_signed_1);
setappdata(0,'hexahedron_VM_signed_2',hexahedron_VM_signed_2);
setappdata(0,'hexahedron_VM_signed_3',hexahedron_VM_signed_3);
setappdata(0,'hexahedron_VM_signed_4',hexahedron_VM_signed_4);
setappdata(0,'hexahedron_VM_signed_5',hexahedron_VM_signed_5);
setappdata(0,'hexahedron_VM_signed_6',hexahedron_VM_signed_6);
setappdata(0,'hexahedron_VM_signed_7',hexahedron_VM_signed_7);
setappdata(0,'hexahedron_VM_signed_8',hexahedron_VM_signed_8);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in radiobutton_solid_hexahedron_stress.
function radiobutton_solid_hexahedron_stress_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_solid_hexahedron_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_solid_hexahedron_stress


% --- Executes on button press in radiobutton_beam_stress.
function radiobutton_beam_stress_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_beam_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_beam_stress




function find_beamstress_elem(hObject, eventdata, handles)     
 
    ibeam_stress=getappdata(0,'ibeam_stress');      
    tn=getappdata(0,'tn');
    
    disp('    ');
    disp(' Find beam stress response elements ');
    disp('    ');
 
    istart=ibeam_stress(1);
    iend=ibeam_stress(2);
 
    setappdata(0,'istart',istart);
    setappdata(0,'iend',iend);
 
    beam_stress_core(hObject, eventdata, handles);    
     
    Z=getappdata(0,'Z');
   
    try
        elem_beam_stress = Z(Z~=0);
    catch
        warndlg('Beam stress elements not found');
        return;
    end            
                    
    num_elem_beam_stress=length(elem_beam_stress);
   
    for i=1:num_elem_beam_stress
        out1=sprintf('  %d',elem_beam_stress(i));
        disp(out1);
    end  
 
    setappdata(0,'num_elem_beam_stress',num_elem_beam_stress);
    setappdata(0,'elem_beam_stress',elem_beam_stress);   
        
%%%
 
    disp('    ');
    disp(' Form BEAM time histories ');
    disp('    ');
 
    setappdata(0,'num_elem_beam_stress',num_elem_beam_stress);
    setappdata(0,'elem_beam_stress',elem_beam_stress);   
    setappdata(0,'ibeam_stress',ibeam_stress);
 
    beam_stress(hObject, eventdata, handles);    
 
    beam_longitudinal_stress_SXC_1=getappdata(0,'beam_longitudinal_stress_SXC_1');    
    beam_longitudinal_stress_SXC_2=getappdata(0,'beam_longitudinal_stress_SXC_2');

    beam_longitudinal_stress_SXD_1=getappdata(0,'beam_longitudinal_stress_SXD_1');    
    beam_longitudinal_stress_SXD_2=getappdata(0,'beam_longitudinal_stress_SXD_2');   
    
    beam_longitudinal_stress_SXE_1=getappdata(0,'beam_longitudinal_stress_SXE_1');    
    beam_longitudinal_stress_SXE_2=getappdata(0,'beam_longitudinal_stress_SXE_2');
    
    beam_longitudinal_stress_SXF_1=getappdata(0,'beam_longitudinal_stress_SXF_1');    
    beam_longitudinal_stress_SXF_2=getappdata(0,'beam_longitudinal_stress_SXF_2');    
    
    
%%% 
 
    disp('  ');
    disp(' Writing beam stress arrays'); 
    disp('  ');        

 
    nt=getappdata(0,'nt');

    iu=getappdata(0,'iu');
 
    scale=1;
 
    if(iu==2)
        scale=386;
    end
    if(iu==4)
        scale=9.81;
    end
    
 
    progressbar;
 
    total=num_elem_beam_stress*nt;
 
    for i=1:num_elem_beam_stress
     
        elem=elem_beam_stress(i);
        
        output_SXC_1=sprintf('beam_longitudinal_stress_SXC_1_%d',elem);        
        output_SXC_2=sprintf('beam_longitudinal_stress_SXC_2_%d',elem);
        
        output_SXD_1=sprintf('beam_longitudinal_stress_SXD_1_%d',elem);        
        output_SXD_2=sprintf('beam_longitudinal_stress_SXD_2_%d',elem);
         
        output_SXE_1=sprintf('beam_longitudinal_stress_SXE_1_%d',elem);        
        output_SXE_2=sprintf('beam_longitudinal_stress_SXE_2_%d',elem);
        
        output_SXF_1=sprintf('beam_longitudinal_stress_SXF_1_%d',elem);        
        output_SXF_2=sprintf('beam_longitudinal_stress_SXF_2_%d',elem);       
        
        

        for j=1:nt
        
            progressbar((i+j)/total);        
        
            beam_longitudinal_stress_SXC_1(j,i)=scale*beam_longitudinal_stress_SXC_1(j,i);    
            beam_longitudinal_stress_SXC_2(j,i)=scale*beam_longitudinal_stress_SXC_2(j,i);
         
            beam_longitudinal_stress_SXD_1(j,i)=scale*beam_longitudinal_stress_SXD_1(j,i);    
            beam_longitudinal_stress_SXD_2(j,i)=scale*beam_longitudinal_stress_SXD_2(j,i);           
        
            beam_longitudinal_stress_SXE_1(j,i)=scale*beam_longitudinal_stress_SXE_1(j,i);    
            beam_longitudinal_stress_SXE_2(j,i)=scale*beam_longitudinal_stress_SXE_2(j,i);            
        
            beam_longitudinal_stress_SXF_1(j,i)=scale*beam_longitudinal_stress_SXF_1(j,i);    
            beam_longitudinal_stress_SXF_2(j,i)=scale*beam_longitudinal_stress_SXF_2(j,i);            
            
        end
        
        
        assignin('base', output_SXC_1, [tn beam_longitudinal_stress_SXC_1(:,i)]);                  
        assignin('base', output_SXC_2, [tn beam_longitudinal_stress_SXC_2(:,i)]);                
        
        assignin('base', output_SXD_1, [tn beam_longitudinal_stress_SXD_1(:,i)]);                  
        assignin('base', output_SXD_2, [tn beam_longitudinal_stress_SXD_2(:,i)]);         
        
        assignin('base', output_SXE_1, [tn beam_longitudinal_stress_SXE_1(:,i)]);                  
        assignin('base', output_SXE_2, [tn beam_longitudinal_stress_SXE_2(:,i)]);                
        
        assignin('base', output_SXF_1, [tn beam_longitudinal_stress_SXF_1(:,i)]);                  
        assignin('base', output_SXF_2, [tn beam_longitudinal_stress_SXF_2(:,i)]);        
        
        
        
 %   disp(' ref 2')
            
        output_TT=sprintf('%s\t %s ',output_SXC_1,output_SXC_2);   
        disp(output_TT);
        output_TT=sprintf('%s\t %s ',output_SXD_1,output_SXD_2);   
        disp(output_TT);     
        output_TT=sprintf('%s\t %s ',output_SXE_1,output_SXE_2);   
        disp(output_TT);
        output_TT=sprintf('%s\t %s ',output_SXF_1,output_SXF_2);   
        disp(output_TT);          
 
    end
 
    progressbar(1);
    
%%

function beam_stress_core(hObject, eventdata, handles)    
   
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
                    

                    if(length(strs)==2 && str2double(strs(1))==0 )
                        
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
   

%%

function beam_stress(hObject, eventdata, handles)  
    
elem_beam_stress=getappdata(0,'elem_beam_stress');
num_elem_beam_stress=getappdata(0,'num_elem_beam_stress');
nt=getappdata(0,'nt');
ibeam_stress=getappdata(0,'ibeam_stress');
sarray=getappdata(0,'sarray');


nm=max(elem_beam_stress);
        
elem_index=zeros(nm,1);
        
for i=1:num_elem_beam_stress
    j=elem_beam_stress(i);
    elem_index(j)=i;
end
 
progressbar;
            
        
beam_longitudinal_stress_SXC_1=zeros(nt,num_elem_beam_stress);
beam_longitudinal_stress_SXC_2=zeros(nt,num_elem_beam_stress);
        
beam_longitudinal_stress_SXD_1=zeros(nt,num_elem_beam_stress);
beam_longitudinal_stress_SXD_2=zeros(nt,num_elem_beam_stress);
        
beam_longitudinal_stress_SXE_1=zeros(nt,num_elem_beam_stress);
beam_longitudinal_stress_SXE_2=zeros(nt,num_elem_beam_stress);
        
beam_longitudinal_stress_SXF_1=zeros(nt,num_elem_beam_stress);
beam_longitudinal_stress_SXF_2=zeros(nt,num_elem_beam_stress);



nndd=nt;


for j=1:nndd
    
    progressbar(j/nndd); 
    
    k=ibeam_stress(j);
    
    while(1)
    
        k=k+1;
        
%%        out1=sprintf(' j=%d k=%d ',j,k);
%%        disp(out1);
                    
        sst=sarray{1}{k};
        strs = strsplit(sst,' ');       
     
        LL=length(strs);
        
        kf=strfind(sst, 'PAGE');
        if(~isempty(kf))
            break;
        end
     
        if(LL==2)
            
            try
                 
                s1=str2num(char(strs(1)));
                s2=str2num(char(strs(2)));
           
                if(s1==0 && ~isnan(s2))
                
                    iv = find(elem_beam_stress==s2,1);
    
                    if(iv>=1)
                                                
                        sst=sarray{1}{k+1};
                        strs = strsplit(sst,' '); 
                        LL=length(strs);                        
                        
                        if(LL==8 || LL==10)
                            
 %                           sst
                            
                            sC1=str2double(char(strs(3)));
                            sD1=str2double(char(strs(4)));
                            sE1=str2double(char(strs(5)));                        
                            sF1=str2double(char(strs(6)));
     
                            
%                            out1=sprintf(' j=%d  max=%8.4g  ',j,qqq);
%                            disp(out1);                            
                            
                            beam_longitudinal_stress_SXC_1(j,iv)=sC1;     
                            beam_longitudinal_stress_SXD_1(j,iv)=sD1; 
                            beam_longitudinal_stress_SXE_1(j,iv)=sE1; 
                            beam_longitudinal_stress_SXF_1(j,iv)=sF1;                             
                            
                            
                            sst=sarray{1}{k+2};
                            strs = strsplit(sst,' '); 
                       
                            sC2=str2double(char(strs(3)));
                            sD2=str2double(char(strs(4)));
                            sE2=str2double(char(strs(5)));                        
                            sF2=str2double(char(strs(6)));
                            
                            beam_longitudinal_stress_SXC_2(j,iv)=sC2;     
                            beam_longitudinal_stress_SXD_2(j,iv)=sD2; 
                            beam_longitudinal_stress_SXE_2(j,iv)=sE2; 
                            beam_longitudinal_stress_SXF_2(j,iv)=sF2;                              
                                 
                        end                         

                        if(iv==num_elem_beam_stress)
                            break;
                        end
                                     
                    end
            
                end
            
            catch
            end
            
        end
    end  
end           

              
pause(0.2);
progressbar(1);          
        
% disp('ref 1')
% max(abs(beam_VM_signed(:,1)))


setappdata(0,'beam_longitudinal_stress_SXC_1',beam_longitudinal_stress_SXC_1);       
setappdata(0,'beam_longitudinal_stress_SXC_2',beam_longitudinal_stress_SXC_2);

setappdata(0,'beam_longitudinal_stress_SXD_1',beam_longitudinal_stress_SXD_1);       
setappdata(0,'beam_longitudinal_stress_SXD_2',beam_longitudinal_stress_SXD_2);

setappdata(0,'beam_longitudinal_stress_SXE_1',beam_longitudinal_stress_SXE_1);       
setappdata(0,'beam_longitudinal_stress_SXE_2',beam_longitudinal_stress_SXE_2);

setappdata(0,'beam_longitudinal_stress_SXF_1',beam_longitudinal_stress_SXF_1);       
setappdata(0,'beam_longitudinal_stress_SXF_2',beam_longitudinal_stress_SXF_2);



%%%

function plot_beam_stress(hObject, eventdata, handles)      
   
fig_num=getappdata(0,'fig_num');
nu=getappdata(0,'nu');
num_elem_beam_stress=getappdata(0,'num_elem_beam_stress');
elem_beam_stress=getappdata(0,'elem_beam_stress');
tn=getappdata(0,'tn');

beam_longitudinal_stress_SXC_1=getappdata(0,'beam_longitudinal_stress_SXC_1');
beam_longitudinal_stress_SXC_2=getappdata(0,'beam_longitudinal_stress_SXC_2');

beam_longitudinal_stress_SXD_1=getappdata(0,'beam_longitudinal_stress_SXD_1');
beam_longitudinal_stress_SXD_2=getappdata(0,'beam_longitudinal_stress_SXD_2');

beam_longitudinal_stress_SXE_1=getappdata(0,'beam_longitudinal_stress_SXE_1');
beam_longitudinal_stress_SXE_2=getappdata(0,'beam_longitudinal_stress_SXE_2');

beam_longitudinal_stress_SXF_1=getappdata(0,'beam_longitudinal_stress_SXF_1');
beam_longitudinal_stress_SXF_2=getappdata(0,'beam_longitudinal_stress_SXF_2');

   
x_label='Time (sec)';
   
if(nu<=2)
    su='Stress (psi)';
else
    su='Stress (Pa)';            
end    
    
for i=1:num_elem_beam_stress
            
    t_string_SXC_1=sprintf('Beam Long SXC Elem %d Grid 1',elem_beam_stress(i));
    t_string_SXC_2=sprintf('Beam Long SXC Elem %d Grid 2',elem_beam_stress(i));
    
    t_string_SXD_1=sprintf('Beam Long SXD Elem %d Grid 1',elem_beam_stress(i));
    t_string_SXD_2=sprintf('Beam Long SXD Elem %d Grid 2',elem_beam_stress(i));   
    
    t_string_SXE_1=sprintf('Beam Long SXE Elem %d Grid 1',elem_beam_stress(i));
    t_string_SXE_2=sprintf('Beam Long SXE Elem %d Grid 2',elem_beam_stress(i));      
    
    t_string_SXF_1=sprintf('Beam Long SXF Elem %d Grid 1',elem_beam_stress(i));
    t_string_SXF_2=sprintf('Beam Long SXF Elem %d Grid 2',elem_beam_stress(i));     
          
    
    data_SXC_1=[tn beam_longitudinal_stress_SXC_1(:,i)];
    data_SXC_2=[tn beam_longitudinal_stress_SXC_2(:,i)];
    
    data_SXD_1=[tn beam_longitudinal_stress_SXD_1(:,i)];
    data_SXD_2=[tn beam_longitudinal_stress_SXD_2(:,i)];   
    
    data_SXE_1=[tn beam_longitudinal_stress_SXE_1(:,i)];
    data_SXE_2=[tn beam_longitudinal_stress_SXE_2(:,i)];    
    
    data_SXF_1=[tn beam_longitudinal_stress_SXF_1(:,i)];
    data_SXF_2=[tn beam_longitudinal_stress_SXF_2(:,i)];  
    
    
    y_label=su;
        
    [fig_num]=subplots_linlin_2x2(fig_num,x_label,...
               y_label,t_string_SXC_1,t_string_SXD_1,t_string_SXE_1,t_string_SXF_1,...
                                          data_SXC_1,data_SXD_1,data_SXE_1,data_SXF_1);
   
                                      
     [fig_num]=subplots_linlin_2x2(fig_num,x_label,...
               y_label,t_string_SXC_2,t_string_SXD_2,t_string_SXE_2,t_string_SXF_2,...
                                          data_SXC_2,data_SXD_2,data_SXE_2,data_SXF_2);                                     
                                      
end 
   
setappdata(0,'fig_num',fig_num);


% --- Executes on button press in radiobutton_plate_quad4_strain.
function radiobutton_plate_quad4_strain_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_plate_quad4_strain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_plate_quad4_strain


function find_quad4stress_elem(hObject, eventdata, handles)     
 
iquad4stress=getappdata(0,'iquad4stress');    
tn=getappdata(0,'tn');    
    
disp('    ');
disp(' Find quad4 stress response elements ');
disp('    ');

istart=iquad4stress(1);
iend=iquad4stress(2);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);

plate_stress_strain_core(hObject, eventdata, handles);    
     
Z=getappdata(0,'Z');
   
try
    elem_quad4stress = Z(Z~=0);
catch
    warndlg('Quad stress elements not found');
    return;
end            
            
            
num_elem_quad4stress=length(elem_quad4stress);
   
for i=1:num_elem_quad4stress
    out1=sprintf('  %d',elem_quad4stress(i));
    disp(out1);
end  

setappdata(0,'num_elem_quad4stress',num_elem_quad4stress);
setappdata(0,'elem_quad4stress',elem_quad4stress);   
        

%%%

disp('    ');
disp(' Form QUAD4 stress time histories ');
disp('    ');

setappdata(0,'num_elem_plate_stress',num_elem_quad4stress);
setappdata(0,'elem_plate_stress',elem_quad4stress);   
setappdata(0,'iplate_stress',iquad4stress);

plate_stress_time_history(hObject, eventdata, handles);

quad4_stress_normal_x=getappdata(0,'plate_normal_x');
quad4_stress_normal_y=getappdata(0,'plate_normal_y');
quad4_stress_shear=getappdata(0,'plate_shear');
quad4_stress_angle_p=getappdata(0,'plate_angle_p');
quad4_stress_major_p=getappdata(0,'plate_major_p');
quad4_stress_minor_p=getappdata(0,'plate_minor_p');
quad4_stress_VM=getappdata(0,'plate_VM');       
quad4_stress_VM_signed=getappdata(0,'plate_VM_signed');

setappdata(0,'quad4_stress_normal_x',quad4_stress_normal_x);
setappdata(0,'quad4_stress_normal_y',quad4_stress_normal_y);
setappdata(0,'quad4_stress_shear',quad4_stress_shear);
setappdata(0,'quad4_stress_VM_signed',quad4_stress_VM_signed);

%%%

disp('  ');
disp(' Writing QUAD4 stress arrays'); 
disp('  ');        
                
for i=1:num_elem_quad4stress
 
    elem=elem_quad4stress(i);
        
    output_S1=sprintf('quad4_stress_normal_x_%d',elem);
    output_S2=sprintf('quad4_stress_normal_y_%d',elem);            
    output_S3=sprintf('quad4_stress_shear_%d',elem);         
    output_S4=sprintf('quad4_stress_angle_p_%d',elem);
    output_S5=sprintf('quad4_stress_major_p_%d',elem);            
    output_S6=sprintf('quad4_stress_minor_p_%d',elem); 
    output_S7=sprintf('quad4_stress_VM_%d',elem);            
    output_S8=sprintf('quad4_stress_VM_signed_%d',elem);     
 
    assignin('base', output_S1, [tn quad4_stress_normal_x(:,i)]);            
    assignin('base', output_S2, [tn quad4_stress_normal_y(:,i)]); 
    assignin('base', output_S3, [tn quad4_stress_shear(:,i)]);             
    assignin('base', output_S4, [tn quad4_stress_angle_p(:,i)]);            
    assignin('base', output_S5, [tn quad4_stress_major_p(:,i)]); 
    assignin('base', output_S6, [tn quad4_stress_minor_p(:,i)]);
    assignin('base', output_S7, [tn quad4_stress_VM(:,i)]); 
    assignin('base', output_S8, [tn quad4_stress_VM_signed(:,i)]); 
    
%    disp(' ref 2')
%    max(abs( quad4_stress_VM_signed(:,i)  ))
            
    disp(output_S1);
    disp(output_S2);
    disp(output_S3); 
    disp(output_S4);
    disp(output_S5);
    disp(output_S6);
    disp(output_S7);
    disp(output_S8);    
    
end

function find_quad4strain_elem(hObject, eventdata, handles)     
 
iquad4strain=getappdata(0,'iquad4strain');    
tn=getappdata(0,'tn');    
    
disp('    ');
disp(' Find quad4 strain response elements ');
disp('    ');

istart=iquad4strain(1);
iend=iquad4strain(2);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);

plate_stress_strain_core(hObject, eventdata, handles);    
     
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
disp(' Form QUAD4 strain time histories ');
disp('    ');

setappdata(0,'num_elem_plate_strain',num_elem_quad4strain);
setappdata(0,'elem_plate_strain',elem_quad4strain);   
setappdata(0,'iplate_strain',iquad4strain);

plate_strain_time_history(hObject, eventdata, handles);

quad4_strain_normal_x=getappdata(0,'plate_normal_x');
quad4_strain_normal_y=getappdata(0,'plate_normal_y');
quad4_strain_shear=getappdata(0,'plate_shear');
quad4_strain_angle_p=getappdata(0,'plate_angle_p');
quad4_strain_major_p=getappdata(0,'plate_major_p');
quad4_strain_minor_p=getappdata(0,'plate_minor_p');
quad4_strain_VM=getappdata(0,'plate_VM');       
quad4_strain_VM_signed=getappdata(0,'plate_VM_signed');

setappdata(0,'quad4_strain_normal_x',quad4_strain_normal_x);
setappdata(0,'quad4_strain_normal_y',quad4_strain_normal_y);
setappdata(0,'quad4_strain_shear',quad4_strain_shear);
setappdata(0,'quad4_strain_VM_signed',quad4_strain_VM_signed);

%%%

disp('  ');
disp(' Writing QUAD4 strain arrays'); 
disp('  ');        
                
for i=1:num_elem_quad4strain
 
    elem=elem_quad4strain(i);
        
    output_S1=sprintf('quad4_strain_normal_x_%d',elem);
    output_S2=sprintf('quad4_strain_normal_y_%d',elem);            
    output_S3=sprintf('quad4_strain_shear_%d',elem);         
    output_S4=sprintf('quad4_strain_angle_p_%d',elem);
    output_S5=sprintf('quad4_strain_major_p_%d',elem);            
    output_S6=sprintf('quad4_strain_minor_p_%d',elem); 
    output_S7=sprintf('quad4_strain_VM_%d',elem);            
    output_S8=sprintf('quad4_strain_VM_signed_%d',elem);     
 
    assignin('base', output_S1, [tn quad4_strain_normal_x(:,i)]);            
    assignin('base', output_S2, [tn quad4_strain_normal_y(:,i)]); 
    assignin('base', output_S3, [tn quad4_strain_shear(:,i)]);             
    assignin('base', output_S4, [tn quad4_strain_angle_p(:,i)]);            
    assignin('base', output_S5, [tn quad4_strain_major_p(:,i)]); 
    assignin('base', output_S6, [tn quad4_strain_minor_p(:,i)]);
    assignin('base', output_S7, [tn quad4_strain_VM(:,i)]); 
    assignin('base', output_S8, [tn quad4_strain_VM_signed(:,i)]); 
    
%    disp(' ref 2')
%    max(abs( quad4_strain_VM_signed(:,i)  ))
            
    disp(output_S1);
    disp(output_S2);
    disp(output_S3); 
    disp(output_S4);
    disp(output_S5);
    disp(output_S6);
    disp(output_S7);
    disp(output_S8);    
            
end       

function plot_quad4strain(hObject, eventdata, handles)      

fig_num=getappdata(0,'fig_num');
nu=getappdata(0,'nu');
num_elem_quad4strain=getappdata(0,'num_elem_quad4strain');
elem_quad4strain=getappdata(0,'elem_quad4strain');
tn=getappdata(0,'tn');

quad4_normal_x=getappdata(0,'quad4_strain_normal_x');
quad4_normal_y=getappdata(0,'quad4_strain_normal_y');
quad4_shear=getappdata(0,'quad4_strain_shear');
quad4_VM_signed=getappdata(0,'quad4_strain_VM_signed');
   
xlabel3='Time (sec)';
   

su='Strain';

    
for i=1:num_elem_quad4strain
            
    t_string=sprintf('Signed Von Mises Strain  Element %d',elem_quad4strain(i));
       
    ylabel1=su;
    ylabel2=su;
    ylabel3=su;
       
    data1=[tn quad4_normal_x(:,i)];
    data2=[tn quad4_normal_y(:,i)];
    data3=[tn quad4_shear(:,i)];
       
    t_string1=sprintf('Strain Normal x  Element %d',elem_quad4strain(i));
    t_string2=sprintf('Strain Normal y  Element %d',elem_quad4strain(i));
    t_string3=sprintf('Strain Shear xy  Element %d',elem_quad4strain(i));
       
       
    [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);
                      
       
    a=[tn quad4_VM_signed(:,i)];
    [fig_num]=plot_TH(fig_num,xlabel3,su,t_string,a);
           
end 
   
setappdata(0,'fig_num',fig_num);


function plate_strain_time_history(hObject, eventdata, handles)  
    
elem_plate_strain=getappdata(0,'elem_plate_strain');
num_elem_plate_strain=getappdata(0,'num_elem_plate_strain');
nt=getappdata(0,'nt');
iplate_strain=getappdata(0,'iplate_strain');
sarray=getappdata(0,'sarray');


nm=max(elem_plate_strain);
        
elem_index=zeros(nm,1);
        
for i=1:num_elem_plate_strain
    j=elem_plate_strain(i);
    elem_index(j)=i;
end

max_iv=elem_index(num_elem_plate_strain);
          
progressbar;
            
nndd=nt;
        
plate_normal_x=zeros(nt,num_elem_plate_strain);
plate_normal_y=zeros(nt,num_elem_plate_strain);
plate_shear=zeros(nt,num_elem_plate_strain);
        
plate_angle_p=zeros(nt,num_elem_plate_strain);        
plate_major_p=zeros(nt,num_elem_plate_strain);
plate_minor_p=zeros(nt,num_elem_plate_strain);
plate_VM=zeros(nt,num_elem_plate_strain); 
plate_VM_signed=zeros(nt,num_elem_plate_strain);  
  
k1=iplate_strain(1);
        
k=k1-1;

for j=1:nndd
    
    progressbar(j/nndd); 
    
    while(1)
    
        k=k+1;
                    
        sst=sarray{1}{k};
        strs = strsplit(sst,' ');       
     
        LL=length(strs);
     
        if(LL==10 || LL==11)
            
            try
                 
                s1=str2num(char(strs(1)));
                s2=str2num(char(strs(2)));
            
                if(s1==0 && ~isnan(s2) && s2>=elem_plate_strain(1))
                
                    iv = find(elem_plate_strain==s2,1);
    
                    if(iv>=1)
                        
                        plate_normal_x(j,iv)=str2double(char(strs(LL-6)));
                        plate_normal_y(j,iv)=str2double(char(strs(LL-5)));
                        plate_shear(j,iv)=str2double(char(strs(LL-4)));
        
                        plate_angle_p(j,iv)=str2double(char(strs(LL-3)));
                        plate_major_p(j,iv)=str2double(char(strs(LL-2)));
                        plate_minor_p(j,iv)=str2double(char(strs(LL-1)));
                        plate_VM(j,iv)=str2double(char(strs(LL)));
                        
                        A=[ plate_major_p(j,iv) ; plate_minor_p(j,iv)];
                        [~,idx]=max(abs(A));
                        plate_VM_signed(j,iv)=plate_VM(j,iv)*sign(A(idx));
                
                        if(iv==num_elem_plate_strain)
                            break;
                        end
                                     
                    end
            
                end
            
            catch
            end
            
        end
    end  
end           

              
pause(0.2);
progressbar(1);          
        
% disp('ref 1')
% max(abs(plate_VM_signed(:,1)))
                
setappdata(0,'plate_normal_x',plate_normal_x);
setappdata(0,'plate_normal_y',plate_normal_y);
setappdata(0,'plate_shear',plate_shear);
          
setappdata(0,'plate_angle_p',plate_angle_p);
setappdata(0,'plate_major_p',plate_major_p);
setappdata(0,'plate_minor_p',plate_minor_p);
setappdata(0,'plate_VM',plate_VM);       
          
setappdata(0,'plate_VM_signed',plate_VM_signed);
              
        


% --- Executes on button press in radiobutton_plate_tria3_strain.
function radiobutton_plate_tria3_strain_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_plate_tria3_strain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_plate_tria3_strain



function find_tria3strain_elem(hObject, eventdata, handles)     
 
itria3strain=getappdata(0,'itria3strain');    
tn=getappdata(0,'tn');    
    
disp('    ');
disp(' Find tria3 strain response elements ');
disp('    ');

istart=itria3strain(1);
iend=itria3strain(2);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);

plate_stress_strain_core(hObject, eventdata, handles);    
     
Z=getappdata(0,'Z');
   
try
    elem_tria3strain = Z(Z~=0);
catch
    warndlg('Tria3 strain elements not found');
    return;
end            
            
            
num_elem_tria3strain=length(elem_tria3strain);
   
for i=1:num_elem_tria3strain
    out1=sprintf('  %d',elem_tria3strain(i));
    disp(out1);
end  

setappdata(0,'num_elem_tria3strain',num_elem_tria3strain);
setappdata(0,'elem_tria3strain',elem_tria3strain);   
        

%%%

disp('    ');
disp(' Form TRIA3 strain time histories ');
disp('    ');

setappdata(0,'num_elem_plate_strain',num_elem_tria3strain);
setappdata(0,'elem_plate_strain',elem_tria3strain);   
setappdata(0,'iplate_strain',itria3strain);

plate_strain_time_history(hObject, eventdata, handles);

tria3_strain_normal_x=getappdata(0,'plate_normal_x');
tria3_strain_normal_y=getappdata(0,'plate_normal_y');
tria3_strain_shear=getappdata(0,'plate_shear');
tria3_strain_angle_p=getappdata(0,'plate_angle_p');
tria3_strain_major_p=getappdata(0,'plate_major_p');
tria3_strain_minor_p=getappdata(0,'plate_minor_p');
tria3_strain_VM=getappdata(0,'plate_VM');       
tria3_strain_VM_signed=getappdata(0,'plate_VM_signed');

setappdata(0,'tria3_strain_normal_x',tria3_strain_normal_x);
setappdata(0,'tria3_strain_normal_y',tria3_strain_normal_y);
setappdata(0,'tria3_strain_shear',tria3_strain_shear);
setappdata(0,'tria3_strain_VM_signed',tria3_strain_VM_signed);

%%%

disp('  ');
disp(' Writing tria3 strain arrays'); 
disp('  ');        
                
for i=1:num_elem_tria3strain
 
    elem=elem_tria3strain(i);
        
    output_S1=sprintf('tria3_strain_normal_x_%d',elem);
    output_S2=sprintf('tria3_strain_normal_y_%d',elem);            
    output_S3=sprintf('tria3_strain_shear_%d',elem);         
    output_S4=sprintf('tria3_strain_angle_p_%d',elem);
    output_S5=sprintf('tria3_strain_major_p_%d',elem);            
    output_S6=sprintf('tria3_strain_minor_p_%d',elem); 
    output_S7=sprintf('tria3_strain_VM_%d',elem);            
    output_S8=sprintf('tria3_strain_VM_signed_%d',elem);     
 
    assignin('base', output_S1, [tn tria3_strain_normal_x(:,i)]);            
    assignin('base', output_S2, [tn tria3_strain_normal_y(:,i)]); 
    assignin('base', output_S3, [tn tria3_strain_shear(:,i)]);             
    assignin('base', output_S4, [tn tria3_strain_angle_p(:,i)]);            
    assignin('base', output_S5, [tn tria3_strain_major_p(:,i)]); 
    assignin('base', output_S6, [tn tria3_strain_minor_p(:,i)]);
    assignin('base', output_S7, [tn tria3_strain_VM(:,i)]); 
    assignin('base', output_S8, [tn tria3_strain_VM_signed(:,i)]); 
    
%    disp(' ref 2')
%    max(abs( tria3_strain_VM_signed(:,i)  ))
            
    disp(output_S1);
    disp(output_S2);
    disp(output_S3); 
    disp(output_S4);
    disp(output_S5);
    disp(output_S6);
    disp(output_S7);
    disp(output_S8);    
            
end       

function plot_tria3strain(hObject, eventdata, handles)      

fig_num=getappdata(0,'fig_num');
nu=getappdata(0,'nu');
num_elem_tria3strain=getappdata(0,'num_elem_tria3strain');
elem_tria3strain=getappdata(0,'elem_tria3strain');
tn=getappdata(0,'tn');

tria3_normal_x=getappdata(0,'tria3_strain_normal_x');
tria3_normal_y=getappdata(0,'tria3_strain_normal_y');
tria3_shear=getappdata(0,'tria3_strain_shear');
tria3_VM_signed=getappdata(0,'tria3_strain_VM_signed');
   
xlabel3='Time (sec)';
   

su='Strain';

    
for i=1:num_elem_tria3strain
            
    t_string=sprintf('Signed Von Mises Strain  Element %d',elem_tria3strain(i));
       
    ylabel1=su;
    ylabel2=su;
    ylabel3=su;
       
    data1=[tn tria3_normal_x(:,i)];
    data2=[tn tria3_normal_y(:,i)];
    data3=[tn tria3_shear(:,i)];
       
    t_string1=sprintf('Strain Normal x  Element %d',elem_tria3strain(i));
    t_string2=sprintf('Strain Normal y  Element %d',elem_tria3strain(i));
    t_string3=sprintf('Strain Shear xy  Element %d',elem_tria3strain(i));
       
       
    [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);
                      
       
    a=[tn tria3_VM_signed(:,i)];
    [fig_num]=plot_TH(fig_num,xlabel3,su,t_string,a);
           
end 
   
setappdata(0,'fig_num',fig_num);


function[node,iflag]=end_node_check(ss)

    node=0;
    iflag=0;

    kk=strfind(ss,'PAGE');
                    
    if(~isempty(kk))
        iflag=1;
    else
        strs = strsplit(ss,' ');
        
        if(length(strs)~=8)
            iflag=1;
        else
            node= str2double(strs(1));
        end
    end
                    
