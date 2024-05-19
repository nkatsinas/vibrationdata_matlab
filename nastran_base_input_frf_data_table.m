function varargout = nastran_base_input_frf_data_table(varargin)
% NASTRAN_BASE_INPUT_FRF_DATA_TABLE MATLAB code for nastran_base_input_frf_data_table.fig
%      NASTRAN_BASE_INPUT_FRF_DATA_TABLE, by itself, creates a new NASTRAN_BASE_INPUT_FRF_DATA_TABLE or raises the existing
%      singleton*.
%
%      H = NASTRAN_BASE_INPUT_FRF_DATA_TABLE returns the handle to a new NASTRAN_BASE_INPUT_FRF_DATA_TABLE or the handle to
%      the existing singleton*.
%
%      NASTRAN_BASE_INPUT_FRF_DATA_TABLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NASTRAN_BASE_INPUT_FRF_DATA_TABLE.M with the given input arguments.
%
%      NASTRAN_BASE_INPUT_FRF_DATA_TABLE('Property','Value',...) creates a new NASTRAN_BASE_INPUT_FRF_DATA_TABLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nastran_base_input_frf_data_table_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nastran_base_input_frf_data_table_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nastran_base_input_frf_data_table

% Last Modified by GUIDE v2.5 04-Aug-2021 14:36:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nastran_base_input_frf_data_table_OpeningFcn, ...
                   'gui_OutputFcn',  @nastran_base_input_frf_data_table_OutputFcn, ...
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


% --- Executes just before nastran_base_input_frf_data_table is made visible.
function nastran_base_input_frf_data_table_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nastran_base_input_frf_data_table (see VARARGIN)

% Choose default command line output for nastran_base_input_frf_data_table
handles.output = hObject;



listbox_rd_Callback(hObject, eventdata, handles);

set(handles.listbox_units,'Value',2);

clear(hObject, eventdata, handles);

num_elem_quad4stress =0; 
num_elem_tria3stress=0;

num_elem_quad4strain =0; 
num_elem_tria3strain=0;


num_node_disp=0;
num_node_velox=0;
num_node_accel=0;

setappdata(0,'num_node_disp',num_node_disp);
setappdata(0,'num_node_velox',num_node_velox);
setappdata(0,'num_node_accel',num_node_accel);

elem_quad4stress=0;
elem_tria3stress=0;

elem_quad4strain=0;
elem_tria3strain=0;


setappdata(0,'num_elem_quad4stress',num_elem_quad4stress );
setappdata(0,'num_elem_tria3stress',num_elem_tria3stress);

setappdata(0,'elem_quad4stress',elem_quad4stress);
setappdata(0,'elem_tria3stress',elem_tria3stress);

setappdata(0,'num_elem_quad4strain',num_elem_quad4strain);
setappdata(0,'num_elem_tria3strain',num_elem_tria3strain);

setappdata(0,'elem_quad4strain',elem_quad4strain);
setappdata(0,'elem_tria3strain',elem_tria3strain);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nastran_base_input_frf_data_table wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nastran_base_input_frf_data_table_OutputFcn(hObject, eventdata, handles) 
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

   tic
  
   clear_all_figures(nastran_base_input_frf);
   
   iu=get(handles.listbox_units,'Value');
   setappdata(0,'iu',iu);
   
   setappdata(0,'metric_displacement',0);
   setappdata(0,'metric_velocity',0);
   setappdata(0,'metric_acceleration',0);
   
   setappdata(0,'metric_quad4stress',0);
   setappdata(0,'metric_tria3stress',0);
   
   setappdata(0,'metric_quad4strain',0);
   setappdata(0,'metric_tria3strain',0);   
   
   
   fig_num=1;
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
   
   
   rb_beam_stress = get(handles.radiobutton_beam_stress, 'Value');   
   
   if(rb_acceleration==0)
       warndlg('Acceleration required');
       return;
   end
    
   setappdata(0,'rb_displacement',rb_displacement);
   setappdata(0,'rb_velocity',rb_velocity);
   setappdata(0,'rb_acceleration',rb_acceleration);
   
   setappdata(0,'rb_plate_quad4_stress',rb_plate_quad4_stress);
   setappdata(0,'rb_plate_quad4_strain',rb_plate_quad4_strain);   
   
   setappdata(0,'rb_plate_tria3_stress',rb_plate_tria3_stress);   
   setappdata(0,'rb_plate_tria3_strain',rb_plate_tria3_strain);     
   
   
   setappdata(0,'rb_beam_stress',rb_beam_stress);    
   
   
   ex_axis=get(handles.listbox_axis,'Value');
   setappdata(0,'ex_axis',ex_axis);
   
   base_input_node=str2num(get(handles.edit_base_input_node,'String'));
   setappdata(0,'base_input_node',base_input_node);
   
   %%%%%%%%%%%%
   
   find_number_frequency_points(hObject, eventdata, handles);
   
   zflag=getappdata(0,'zflag');
   nflag=getappdata(0,'nflag');
   
   if(zflag==1 || nflag==1)
       return;
   end
   
   %%%%%%%%%%%%
 
   metric_displacement=getappdata(0,'metric_displacement');
   metric_velocity=getappdata(0,'metric_velocity');
   metric_acceleration=getappdata(0,'metric_acceleration');
   
   metric_quad4stress=getappdata(0,'metric_quad4stress');
   metric_quad4strain=getappdata(0,'metric_quad4strain');
   
   metric_tria3stress=getappdata(0,'metric_tria3stress');
   metric_tria3strain=getappdata(0,'metric_tria3strain');   
   
   metric_beamstress=getappdata(0,'metric_beamstress');
   

   
   if(metric_displacement==1 && rb_displacement==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_displacement(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
   end      
   if(metric_velocity==1 && rb_velocity==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_velocity(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
   end        
   if(metric_acceleration==1 && rb_acceleration==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_acceleration(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
   end     
   if(metric_quad4stress==1 && rb_plate_quad4_stress==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_quad4stress(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
   end      
   if(metric_quad4strain==1 && rb_plate_quad4_strain==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_quad4strain(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
   end      
   
   
   if(metric_tria3stress==1 && rb_plate_tria3_stress==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_tria3stress(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
   end
   if(metric_tria3strain==1 && rb_plate_tria3_strain==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_tria3strain(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
   end   
   
   
   
   if(metric_beamstress==1 && rb_beam_stress==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_beamstress(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
   end     
   
   
set(handles.pushbutton_sine,'Enable','on');
  
disp(' ');   
disp(' Calculation complete');   
disp(' ');   
msgbox('Calculation complete');

%%%%%%%%%%%%

function find_number_frequency_points(hObject, eventdata, handles)
       
disp('  ');
disp(' Find number of frequency points... ');
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


num_node_disp=0;
num_node_velox=0;
num_node_accel=0;

num_elem_quad4stress =0;
num_elem_quad4strain =0;

num_elem_tria3stress=0;   
num_elem_tria3strain=0; 

num_elem_beamstress=0;
   
    if(rb_displacement==1)    
        idd = strfind(sarray{:}, 'C O M P L E X   D I S P L A C E M E N T   V E C T O R');
        idd = find(not(cellfun('isempty', idd)));
        num_node_disp = length(idd);
    end
    
    if(rb_velocity==1)
        idv = strfind(sarray{:}, 'C O M P L E X   V E L O C I T Y   V E C T O R');
        idv = find(not(cellfun('isempty', idv)));
        num_node_velox = length(idv);
    end
    
    if(rb_acceleration==1)
        ida = strfind(sarray{:}, 'C O M P L E X   A C C E L E R A T I O N   V E C T O R');
        ida = find(not(cellfun('isempty', ida)));
        num_node_accel = length(ida);
        setappdata(0,'num_node_accel',num_node_accel);
        
        if(num_node_accel==0)
            warndlg('Acceleration required');
            return;
        end
        
    end
    
    if(rb_plate_quad4_stress==1)
        iquad4stress = strfind(sarray{:}, 'S T R E S S E S   I N   Q U A D R I L A T E R A L   E L E M E N T S   ( Q U A D 4 )');
        iquad4stress = find(not(cellfun('isempty', iquad4stress)));
        num_elem_quad4stress = length(iquad4stress);   
    end
     if(rb_plate_quad4_strain==1)
        iquad4strain = strfind(sarray{:}, 'S T R A I N S   I N   Q U A D R I L A T E R A L   E L E M E N T S   ( Q U A D 4 )');
        iquad4strain = find(not(cellfun('isempty', iquad4strain)));
        num_elem_quad4strain = length(iquad4strain);   
    end   
    
    
    
    if(rb_plate_tria3_stress==1)
        itria3stress = strfind(sarray{:},'S T R E S S E S   I N   T R I A N G U L A R   E L E M E N T S   ( T R I A 3 )');
        itria3stress = find(not(cellfun('isempty', itria3stress)));
        num_elem_tria3stress = length(itria3stress);   
    end
    if(rb_plate_tria3_strain==1)
        itria3strain = strfind(sarray{:},'S T R A I N S   I N   T R I A N G U L A R   E L E M E N T S   ( T R I A 3 )');
        itria3strain = find(not(cellfun('isempty', itria3strain)));
        num_elem_tria3strain = length(itria3strain);   
    end
    

    if(rb_beam_stress==1)    
        ibeam_stress = strfind(sarray{:}, 'C O M P L E X   S T R E S S E S   I N   B E A M   E L E M E N T S');
        ibeam_stress = find(not(cellfun('isempty', ibeam_stress)));
        num_elem_beamstress = length(ibeam_stress);
    end    
    
    
    
    
    idf = strfind(sarray{:}, 'FREQUENCY =');
    idf = find(not(cellfun('isempty', idf)));
%%%    num_freq = length(idf); 

    
    num_freq=1;

    tb=0;
    
    i=1;
    
    ijk=1;
    
    while(1)
    
        j=idf(i);   
        ss=sarray{1}{j};        
        strs = strsplit(ss,' ');

        if( strcmp(char(strs(1)),'FREQUENCY'))

            tb=str2double(strs(3));
            fmin=tb; 
            fn(ijk)=tb;
            ione=i+1;
            break;
        end    
            
        i=i+1;    
        
    end
    
    for i=(ione-2):-1:1
        idf(i)=[];
    end
    
    ijk=ijk+1;
    
    
    idfL=length(idf);
    
    out1=sprintf(' idfL = %d ',idfL);
    disp(out1);
    
    progressbar;
    
    for i=2:idfL
        
        progressbar(i/idfL);
        
        j=idf(i);
        
        ss=sarray{1}{j};
        strs = strsplit(ss,' ');
        tt=str2double(strs(3));
        
        if(tt>tb)
            tb=tt;
            fn(ijk)=tb;
            ijk=ijk+1;
        end
    end

    
    pause(0.2);
    progressbar(1);
        
    metric_displacement=0;
    metric_velocity=0;
    metric_acceleration=0;
    
    metric_quad4stress=0;
    metric_quad4strain=0;    
    
    metric_tria3stress=0;
    metric_tria3strain=0;    
    
    metric_beamstress=0;
    
    if(num_node_disp>0)
        metric_displacement=1;
    end
    if(num_node_velox>0)
        metric_velocity=1;          
    end   
    if(num_node_accel>0)
        metric_acceleration=1;          
    end
    
    if(num_elem_quad4stress >0)
        metric_quad4stress=1;          
    end 
    if(num_elem_quad4strain >0)
        metric_quad4strain=1;          
    end     
    
    if(num_elem_tria3stress>0)
        metric_tria3stress=1;          
    end  
    if(num_elem_tria3strain>0)
        metric_tria3strain=1;          
    end      
    
    if(num_elem_beamstress>0)
        metric_beamstress=1;          
    end     
    
    
    if(rb_displacement==0 || num_node_disp==0)
        metric_displacement=0;      
    end 
    if(rb_velocity==0 || num_node_velox==0)
        metric_velocity=0;           
    end 
    if(rb_acceleration==0 || num_node_accel==0)
        metric_acceleration=0;       
    end 
    
    if(rb_plate_quad4_stress==0 || num_elem_quad4stress ==0)
        metric_quad4stress=0;      
    end     
    if(rb_plate_quad4_strain==0 || num_elem_quad4strain ==0)
        metric_quad4strain=0;      
    end         
    
    
    if(rb_plate_tria3_stress==0 || num_elem_tria3stress==0)
        metric_tria3stress=0;      
    end  
    if(rb_plate_tria3_strain==0 || num_elem_tria3strain==0)
        metric_tria3strain=0;      
    end  
    
    
    if(rb_beam_stress==0 || num_elem_beamstress==0)
        metric_beamstress=0;      
    end     
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
   out1=sprintf(' num_node_disp=%d  num_node_velox=%d  num_node_accel=%d ',num_node_disp,num_node_velox,num_node_accel);
   disp(out1);
   
   out1=sprintf(' num_elem_quad4stress =%d num_elem_quad4strain=%d ',num_elem_quad4stress,num_elem_quad4strain);
   disp(out1);
   
   out1=sprintf(' num_elem_tria3stress =%d num_elem_tria3strain=%d ',num_elem_tria3stress,num_elem_tria3strain);
   disp(out1);
   
   
   out1=sprintf(' num_elem_beamstress =%d ',num_elem_beamstress);
   disp(out1)
   
   zflag=0;
   setappdata(0,'zflag',zflag);
   
   nf=length(fn);
   
   if(nf==0)
       out1=sprintf('f06 file must contain displacement, velocity, acceleration, \n quad4 stress, tria3 stress or beam stress');
       warndlg(out1);
       zflag=1;
       setappdata(0,'zflag',zflag);
       return;
   end
   
    
   disp(' ');
   disp(' Form frequency vector...');
   disp(' ');   
   
   fn=fix_size(fn);
      
   setappdata(0,'fn',fn);
   
   out1=sprintf(' fmin=%9.5g  fmax=%9.5g  nf=%9.5g',fn(1),fn(nf),nf);
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
   
   
   try
        setappdata(0,'idf',idf);
   catch
        warndlg('Frequency column error');
        return;
   end
        
   
   disp(' find frequency')
   
       
   setappdata(0,'num_node_disp',num_node_disp);
   setappdata(0,'num_node_velox',num_node_velox);
   setappdata(0,'num_node_accel',num_node_accel);
   
   setappdata(0,'num_elem_quad4stress',num_elem_quad4stress );
   setappdata(0,'num_elem_quad4strain',num_elem_quad4strain );   
   
   setappdata(0,'num_elem_tria3stress',num_elem_tria3stress);
   setappdata(0,'num_elem_tria3strain',num_elem_tria3strain);  
   
   setappdata(0,'num_elem_beamstress',num_elem_beamstress);  
   setappdata(0,'num_freq',num_freq);

   setappdata(0,'metric_displacement',metric_displacement);
   setappdata(0,'metric_velocity',metric_velocity);
   setappdata(0,'metric_acceleration',metric_acceleration);
   
   setappdata(0,'metric_quad4stress',metric_quad4stress);
   setappdata(0,'metric_quad4strain',metric_quad4strain);   
   
   setappdata(0,'metric_tria3stress',metric_tria3stress);
   setappdata(0,'metric_tria3strain',metric_tria3strain);   
   
   setappdata(0,'metric_beamstress',metric_beamstress);
   
   setappdata(0,'nf',nf);   
   setappdata(0,'fn',fn);  
  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

   if(metric_acceleration==1 && rb_acceleration==1)

        find_acceleration_nodes(hObject, eventdata, handles);    
   
        nflag=getappdata(0,'nflag');
        
        if(nflag==1)
            return;
        end
        
   end    

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
        find_velocity_nodes(hObject, eventdata, handles);    
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

   if(metric_beamstress==1 && rb_beam_stress==1)
        find_beamstress_elem(hObject, eventdata, handles);      
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  




function find_quad4stress_elem(hObject, eventdata, handles)     
 
iquad4stress=getappdata(0,'iquad4stress');    
fn=getappdata(0,'fn');    
    
disp('    ');
disp(' Find quad4 stress response elements ');
disp('    ');

istart=iquad4stress(1);
iend=iquad4stress(2);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);

plate_stress_core(hObject, eventdata, handles);    
     
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
disp(' Form QUAD 4 stress frfs ');
disp('    ');

setappdata(0,'num_elem_plate_stress',num_elem_quad4stress);
setappdata(0,'elem_plate_stress',elem_quad4stress);   
setappdata(0,'iplate_stress',iquad4stress);

plate_stress_frf(hObject, eventdata, handles);

quad4_normal_x=getappdata(0,'plate_normal_x');
quad4_normal_y=getappdata(0,'plate_normal_y');
quad4_shear=getappdata(0,'plate_shear');
quad4_VM=getappdata(0,'plate_VM');       

setappdata(0,'quad4_normal_x',quad4_normal_x);
setappdata(0,'quad4_normal_y',quad4_normal_y);
setappdata(0,'quad4_shear',quad4_shear);
setappdata(0,'quad4_VM_signed',quad4_VM);

%%%

disp('  ');
disp(' Writing QUAD4 stress arrays'); 
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

quad4_VM_power_trans=zeros(nf,num_elem_quad4stress);

progressbar;

total=num_elem_quad4stress*nf;

for i=1:num_elem_quad4stress
     
    elem=elem_quad4stress(i);
        
    output_S1=sprintf('quad4_stress_normal_x_frf_%d',elem);
    output_S2=sprintf('quad4_stress_normal_y_frf_%d',elem);            
    output_S3=sprintf('quad4_stress_shear_frf_%d',elem);         
    output_S7=sprintf('quad4_stress_VM_frf_%d',elem);     
    output_S9=sprintf('quad4_stress_VM_power_trans_%d',elem);    

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

function find_tria3stress_elem(hObject, eventdata, handles)     
 
itria3stress=getappdata(0,'itria3stress');    
fn=getappdata(0,'fn');    
    
disp('    ');
disp(' Find tria3 stress response elements ');
disp('    ');

istart=itria3stress(1);
iend=itria3stress(2);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);

plate_stress_core(hObject, eventdata, handles);    
     
Z=getappdata(0,'Z');
   
try
    elem_tria3stress = Z(Z~=0);
catch
    warndlg('Quad stress elements not found');
    return;
end            
            
            
num_elem_tria3stress=length(elem_tria3stress);
   
for i=1:num_elem_tria3stress
    out1=sprintf('  %d',elem_tria3stress(i));
    disp(out1);
end  

setappdata(0,'num_elem_tria3stress',num_elem_tria3stress);
setappdata(0,'elem_tria3stress',elem_tria3stress);   
        
%%%

disp('    ');
disp(' Form TRIA 3 frfs ');
disp('    ');

setappdata(0,'num_elem_plate_stress',num_elem_tria3stress);
setappdata(0,'elem_plate_stress',elem_tria3stress);   
setappdata(0,'iplate_stress',itria3stress);

plate_stress_frf(hObject, eventdata, handles);

tria3_normal_x=getappdata(0,'plate_normal_x');
tria3_normal_y=getappdata(0,'plate_normal_y');
tria3_shear=getappdata(0,'plate_shear');
tria3_VM=getappdata(0,'plate_VM');       

setappdata(0,'tria3_stress_normal_x',tria3_normal_x);
setappdata(0,'tria3_stress_normal_y',tria3_normal_y);
setappdata(0,'tria3_stress_shear',tria3_shear);
setappdata(0,'tria3_stress_VM_signed',tria3_VM);

%%%

disp('  ');
disp(' Writing TRIA3 stress arrays'); 
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

tria3_VM_power_trans=zeros(nf,num_elem_tria3stress);

for i=1:num_elem_tria3stress
 
    elem=elem_tria3stress(i);
        
    output_S1=sprintf('tria3_stress_normal_x_frf_%d',elem);
    output_S2=sprintf('tria3_stress_normal_y_frf_%d',elem);            
    output_S3=sprintf('tria3_stress_shear_frf_%d',elem);         
    output_S7=sprintf('tria3_stress_VM_frf_%d',elem);             
    output_S9=sprintf('tria3_stress_VM_power_trans_%d',elem);
    
    
    for j=1:nf
        tria3_normal_x(j,i)=scale*tria3_normal_x(j,i)/abase_mag(j);
        tria3_normal_y(j,i)=scale*tria3_normal_y(j,i)/abase_mag(j);
        tria3_shear(j,i)=scale*tria3_shear(j,i)/abase_mag(j);
        tria3_VM(j,i)=scale*tria3_VM(j,i)/abase_mag(j);
        tria3_VM_power_trans(j,i)=tria3_VM(j,i)^2;       
    end
    
    
    assignin('base', output_S1, [fn tria3_normal_x(:,i)]);            
    assignin('base', output_S2, [fn tria3_normal_y(:,i)]); 
    assignin('base', output_S3, [fn tria3_shear(:,i)]);             
    assignin('base', output_S7, [fn tria3_VM(:,i)]);
    assignin('base', output_S9, [fn tria3_VM_power_trans(:,i)]);      
        
    
%    disp(' ref 2')
%    max(abs( tria3_VM_signed(:,i)  ))
            
    TT_output=sprintf('%s\t %s\t %s',output_S1,output_S2,output_S3); 
    
    disp(TT_output);
    disp(output_S7);  
    disp(output_S9);      
   
end

%%


function find_tria3strain_elem(hObject, eventdata, handles)     
 
itria3strain=getappdata(0,'itria3strain');    
fn=getappdata(0,'fn');    
    
disp('    ');
disp(' Find tria3 strain response elements ');
disp('    ');

istart=itria3strain(1);
iend=itria3strain(2);

setappdata(0,'istart',istart);
setappdata(0,'iend',iend);

plate_strain_core(hObject, eventdata, handles);    
     
Z=getappdata(0,'Z');
   
try
    elem_tria3strain = Z(Z~=0);
catch
    warndlg('Quad strain elements not found');
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
disp(' Form TRIA 3 frfs ');
disp('    ');

setappdata(0,'num_elem_plate_strain',num_elem_tria3strain);
setappdata(0,'elem_plate_strain',elem_tria3strain);   
setappdata(0,'iplate_strain',itria3strain);

plate_strain_frf(hObject, eventdata, handles);

tria3_normal_x=getappdata(0,'plate_normal_x');
tria3_normal_y=getappdata(0,'plate_normal_y');
tria3_shear=getappdata(0,'plate_shear');
tria3_VM=getappdata(0,'plate_VM');       

setappdata(0,'tria3_strain_normal_x',tria3_normal_x);
setappdata(0,'tria3_strain_normal_y',tria3_normal_y);
setappdata(0,'tria3_strain_shear',tria3_shear);
setappdata(0,'tria3_strain_VM_signed',tria3_VM);

%%%

disp('  ');
disp(' Writing TRIA3 strain arrays'); 
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

tria3_VM_power_trans=zeros(nf,num_elem_tria3strain);

for i=1:num_elem_tria3strain
 
    elem=elem_tria3strain(i);
        
    output_S1=sprintf('tria3_strain_normal_x_frf_%d',elem);
    output_S2=sprintf('tria3_strain_normal_y_frf_%d',elem);            
    output_S3=sprintf('tria3_strain_shear_frf_%d',elem);         
    output_S7=sprintf('tria3_strain_VM_frf_%d',elem);             
    output_S9=sprintf('tria3_strain_VM_power_trans_%d',elem);
    
    
    for j=1:nf
        tria3_normal_x(j,i)=scale*tria3_normal_x(j,i)/abase_mag(j);
        tria3_normal_y(j,i)=scale*tria3_normal_y(j,i)/abase_mag(j);
        tria3_shear(j,i)=scale*tria3_shear(j,i)/abase_mag(j);
        tria3_VM(j,i)=scale*tria3_VM(j,i)/abase_mag(j);
        tria3_VM_power_trans(j,i)=tria3_VM(j,i)^2;       
    end
    
    
    assignin('base', output_S1, [fn tria3_normal_x(:,i)]);            
    assignin('base', output_S2, [fn tria3_normal_y(:,i)]); 
    assignin('base', output_S3, [fn tria3_shear(:,i)]);             
    assignin('base', output_S7, [fn tria3_VM(:,i)]);
    assignin('base', output_S9, [fn tria3_VM_power_trans(:,i)]);      
        
    
%    disp(' ref 2')
%    max(abs( tria3_VM_signed(:,i)  ))
            
    TT_output=sprintf('%s\t %s\t %s',output_S1,output_S2,output_S3); 
    
    disp(TT_output);
    disp(output_S7);  
    disp(output_S9);      
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function find_beamstress_elem(hObject, eventdata, handles)     
 
    ibeam_stress=getappdata(0,'ibeam_stress');    
    fn=getappdata(0,'fn');    
    
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
        elem_beamstress = Z(Z~=0);
    catch
        warndlg('Beam stress elements not found');
        return;
    end            
                    
    num_elem_beamstress=length(elem_beamstress);
   
    for i=1:num_elem_beamstress
        out1=sprintf('  %d',elem_beamstress(i));
        disp(out1);
    end  
 
    setappdata(0,'num_elem_beamstress',num_elem_beamstress);
    setappdata(0,'elem_beamstress',elem_beamstress);   
        
%%%
 
    disp('    ');
    disp(' Form BEAM frfs ');
    disp('    ');
 
    setappdata(0,'num_elem_beam_stress',num_elem_beamstress);
    setappdata(0,'elem_beam_stress',elem_beamstress);   
    setappdata(0,'ibeam_stress',ibeam_stress);
 
    beam_stress_frf(hObject, eventdata, handles);    
 
    beam_longitudinal_stress_frf_1=getappdata(0,'beam_longitudinal_stress_1');
    beam_longitudinal_stress_phase_1=getappdata(0,'beam_longitudinal_phase_1');
    
    beam_longitudinal_stress_frf_2=getappdata(0,'beam_longitudinal_stress_2');
    beam_longitudinal_stress_phase_2=getappdata(0,'beam_longitudinal_phase_2');
    
%%% 
 
    disp('  ');
    disp(' Writing beam stress arrays'); 
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
 
    beam_longitudinal_stress_power_trans_1=zeros(nf,num_elem_beamstress);
    beam_longitudinal_stress_power_trans_2=zeros(nf,num_elem_beamstress);  
 
    progressbar;
 
    total=num_elem_beamstress*nf;
 
    for i=1:num_elem_beamstress
     
        elem=elem_beamstress(i);
        
        output_S1=sprintf('beam_longitudinal_stress_frf_1_%d',elem);
        output_S9=sprintf('beam_longitudinal_stress_power_trans_1_%d',elem); 
        
        output_S2=sprintf('beam_longitudinal_stress_frf_2_%d',elem);
        output_S10=sprintf('beam_longitudinal_stress_power_trans_2_%d',elem);        

        for j=1:nf
        
            progressbar((i+j)/total);        
        
            beam_longitudinal_stress_frf_1(j,i)=scale*beam_longitudinal_stress_frf_1(j,i)/abase_mag(j);
            beam_longitudinal_stress_power_trans_1(j,i)=beam_longitudinal_stress_frf_1(j,i)^2;    

            beam_longitudinal_stress_frf_2(j,i)=scale*beam_longitudinal_stress_frf_2(j,i)/abase_mag(j);
            beam_longitudinal_stress_power_trans_2(j,i)=beam_longitudinal_stress_frf_2(j,i)^2;  
            
        end
        
        
        assignin('base', output_S1, [fn beam_longitudinal_stress_frf_1(:,i)]);            
        assignin('base', output_S9, [fn beam_longitudinal_stress_power_trans_1(:,i)]);         
        
        assignin('base', output_S2, [fn beam_longitudinal_stress_frf_2(:,i)]);            
        assignin('base', output_S10, [fn beam_longitudinal_stress_power_trans_2(:,i)]);       
        
 %   disp(' ref 2')
            
        output_TT=sprintf('%s\t %s ',output_S1,output_S9);   
        disp(output_TT);
        output_TT=sprintf('%s\t %s ',output_S2,output_S10);   
        disp(output_TT);       
   
    end
 
    progressbar(1);
    
%%


function beam_stress_frf(hObject, eventdata, handles)  
    
elem_beam_stress=getappdata(0,'elem_beam_stress');
num_elem_beam_stress=getappdata(0,'num_elem_beam_stress');
nf=getappdata(0,'nf');
ibeam_stress=getappdata(0,'ibeam_stress');
sarray=getappdata(0,'sarray');


nm=max(elem_beam_stress);
        
elem_index=zeros(nm,1);
        
for i=1:num_elem_beam_stress
    j=elem_beam_stress(i);
    elem_index(j)=i;
end
 
progressbar;
            
nndd=nf;
        
beam_longitudinal_stress_1=zeros(nf,num_elem_beam_stress);
beam_longitudinal_stress_2=zeros(nf,num_elem_beam_stress);
beam_longitudinal_phase_1=zeros(nf,num_elem_beam_stress);
beam_longitudinal_phase_2=zeros(nf,num_elem_beam_stress);


k1=ibeam_stress(1);
        
k=k1-1;

C=pi/180;


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
        
        kf=strfind(sst, 'FRF');
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
                        
                        if(LL==7)
                            
 %                           sst
                            
                            sC1=str2double(char(strs(4)));
                            sD1=str2double(char(strs(5)));
                            sE1=str2double(char(strs(6)));                        
                            sF1=str2double(char(strs(7)));
                            
                            qqq=max([sC1 sD1 sE1 sF1]);
                            
%                            out1=sprintf(' j=%d  max=%8.4g  ',j,qqq);
%                            disp(out1);
                            
                            
                            beam_longitudinal_stress_1(j,iv)=max([sC1 sD1 sE1 sF1]);     
                            beam_longitudinal_stress_1(j,iv);
                        end  
                        
                        sst=sarray{1}{k+2};
                        strs = strsplit(sst,' '); 
                        LL=length(strs);
                        
                        if(LL==4)
                            phC1=C*str2double(char(strs(1)));
                            phD1=C*str2double(char(strs(2)));
                            phE1=C*str2double(char(strs(3)));                        
                            phF1=C*str2double(char(strs(4))); 
                        end                       
                        
                        sst=sarray{1}{k+3};
                        strs = strsplit(sst,' '); 
                        LL=length(strs);
                        
                        if(LL==7)
%%                            sst
                            sC1=str2double(char(strs(4)));
                            sD1=str2double(char(strs(5)));
                            sE1=str2double(char(strs(6)));                        
                            sF1=str2double(char(strs(7)));
                            
                            beam_longitudinal_stress_2(j,iv)=max([sC1 sD1 sE1 sF1]);                           
                        end                         
                        
                        sst=sarray{1}{k+4};
                        strs = strsplit(sst,' '); 
                        LL=length(strs);
                        
                        if(LL==4)
                            phC1=C*str2double(char(strs(1)));
                            phD1=C*str2double(char(strs(2)));
                            phE1=C*str2double(char(strs(3)));                        
                            phF1=C*str2double(char(strs(4))); 
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


setappdata(0,'beam_longitudinal_stress_1',beam_longitudinal_stress_1);       
setappdata(0,'beam_longitudinal_stress_2',beam_longitudinal_stress_2);
setappdata(0,'beam_longitudinal_phase_1',beam_longitudinal_phase_1);       
setappdata(0,'beam_longitudinal_phase_2',beam_longitudinal_phase_2);



function plate_stress_frf(hObject, eventdata, handles)  
    
elem_plate_stress=getappdata(0,'elem_plate_stress');
num_elem_plate_stress=getappdata(0,'num_elem_plate_stress');
nf=getappdata(0,'nf');
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
            
nndd=nf;
        
plate_normal_x=zeros(nf,num_elem_plate_stress);
plate_normal_y=zeros(nf,num_elem_plate_stress);
plate_shear=zeros(nf,num_elem_plate_stress);        
plate_VM=zeros(nf,num_elem_plate_stress); 

  
k1=iplate_stress(1);
        
k=k1-1;

C=pi/180;

NQ=360;                        
dp=C*0.5;


for j=1:nndd
    
    progressbar(j/nndd); 
    
    while(1)
    
        k=k+1;
                    
        sst=sarray{1}{k};
        strs = strsplit(sst,' ');       
     
        LL=length(strs);
     
        if(LL==12)
            
            try
                 
                s1=str2num(char(strs(1)));
                s2=str2num(char(strs(2)));
            
                if(s1==0 && ~isnan(s2) && s2>=elem_plate_stress(1))
                
                    iv = find(elem_plate_stress==s2,1);
    
                    if(iv>=1)
                        
                        plate_normal_x(j,iv)=str2double(char(strs(LL-8)));
                        plate_normal_y(j,iv)=str2double(char(strs(LL-5)));
                        plate_shear(j,iv)=str2double(char(strs(LL-2)));

                        sst=sarray{1}{k+1};
                        strs = strsplit(sst,' '); 
                        LL=length(strs);
                        
                        phx=C*str2double(char(strs(LL-6)));
                        phy=C*str2double(char(strs(LL-3)));
                        phs=C*str2double(char(strs(LL)));                        
                      
                        
                        qqq=zeros(NQ,1);
                        
                        for i=1:NQ
                        
                           p=(i-1)*dp; 
                            
                           sxx=plate_normal_x(j,iv)*sin(phx+p);
                           syy=plate_normal_y(j,iv)*sin(phy+p);
                           sxy=plate_shear(j,iv)*sin(phs+p);
                           term=sxx^2 + syy^2 - sxx*syy + 3*sxy^2;
                           qqq(i)=sqrt(term); 
                                               
                        end

                        plate_VM(j,iv)=max(abs(qqq));                  
                
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
setappdata(0,'plate_VM',plate_VM);       

              
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

function plate_stress_core(hObject, eventdata, handles)    
   
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


function find_displacement_nodes(hObject, eventdata, handles)
    
    sarray=getappdata(0,'sarray');
    idd=getappdata(0,'idd');
    fn=getappdata(0,'fn');
    nf=getappdata(0,'nf');  
    
    disp('    ');
    disp(' Find displacement response nodes ');
    disp('    ');
        
    j=1;
    
    jk=1;
        
    iflag=0;
        
    for i=idd(1):idd(2)
                        
        ss=sarray{1}{i};
            
        k=strfind(ss, 'POINT ID.');
            
        if(~isempty(k))
                
                while(1) 
                    ss=sarray{1}{i+j};
                  
                    kk=strfind(ss,'FRF');
                    
                    if(~isempty(kk))
                        iflag=1;
                        break;
                    else
                        strs = strsplit(ss,' ');
                        if( strcmp(char(strs(3)),'G'))
                            node_disp(jk)= str2double(strs(2));
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
   
   num_node_disp=length(node_disp);
   
   for i=1:num_node_disp
       out1=sprintf('  %d',node_disp(i));
       disp(out1);
   end    
   
   setappdata(0,'num_node_disp',num_node_disp);
   setappdata(0,'node_disp',node_disp);
      
   qflag=0;
   setappdata(0,'qflag',qflag);
   
   nrd=get(handles.listbox_rd,'Value');
   setappdata(0,'nrd',nrd);

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
   

nflag=getappdata(0,'nflag');

if(nflag==1)
   return; 
end

disp('    ');
disp(' Form displacement FRF ');
disp('    ');
        
nm=max(node_disp);
        
node_index=zeros(nm,1);
        
for i=1:num_node_disp
    j=node_disp(i);
    node_index(j)=i;
end
                
progressbar;
            
nndd=nf;
        
TM1=zeros(nf,num_node_disp);
TM2=zeros(nf,num_node_disp);
TM3=zeros(nf,num_node_disp);
RM1=zeros(nf,num_node_disp);
RM2=zeros(nf,num_node_disp);
RM3=zeros(nf,num_node_disp);        
                 
TP1=zeros(nf,num_node_disp);
TP2=zeros(nf,num_node_disp);
TP3=zeros(nf,num_node_disp);
RP1=zeros(nf,num_node_disp);
RP2=zeros(nf,num_node_disp);
RP3=zeros(nf,num_node_disp);   

TC1=zeros(nf,num_node_disp);
TC2=zeros(nf,num_node_disp);
TC3=zeros(nf,num_node_disp);
RC1=zeros(nf,num_node_disp);
RC2=zeros(nf,num_node_disp);
RC3=zeros(nf,num_node_disp);  
        

 
C=pi/180;

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
                        
            for ijk=1:2:2*num_node_disp 
                sst=sarray{1}{k+ijk};
                strs = strsplit(sst,' ');
                iv=node_index(str2num(char(strs(2))));
                        
                TM1(j,iv)=str2double(char(strs(4)));
                TM2(j,iv)=str2double(char(strs(5)));
                TM3(j,iv)=str2double(char(strs(6)));  
                RM1(j,iv)=str2double(char(strs(7)));
                RM2(j,iv)=str2double(char(strs(8)));
                RM3(j,iv)=str2double(char(strs(9)));   
                
                sst=sarray{1}{k+ijk+1};
                strs = strsplit(sst,' ');
                
                TP1(j,iv)=C*str2double(char(strs(1)));
                TP2(j,iv)=C*str2double(char(strs(2)));
                TP3(j,iv)=C*str2double(char(strs(3)));  
                RP1(j,iv)=C*str2double(char(strs(4)));
                RP2(j,iv)=C*str2double(char(strs(5)));
                RP3(j,iv)=C*str2double(char(strs(6)));   
         
                TC1(j,iv)=TM1(j,iv)*( cos(TP1(j,iv)) + 1i*sin(TP1(j,iv))  );
                TC2(j,iv)=TM2(j,iv)*( cos(TP2(j,iv)) + 1i*sin(TP2(j,iv))  );
                TC3(j,iv)=TM3(j,iv)*( cos(TP3(j,iv)) + 1i*sin(TP3(j,iv))  );
                RC1(j,iv)=RM1(j,iv)*( cos(RP1(j,iv)) + 1i*sin(RP1(j,iv))  );
                RC2(j,iv)=RM2(j,iv)*( cos(RP2(j,iv)) + 1i*sin(RP2(j,iv))  );
                RC3(j,iv)=RM3(j,iv)*( cos(RP3(j,iv)) + 1i*sin(RP3(j,iv))  );                  
                
                
            end
                        
            break;
                           
        end
    end
end
 
%%
pause(0.2);
progressbar(1);       
        
abase_complex=getappdata(0,'abase_complex');
abase_mag=getappdata(0,'abase_mag');

disp('  ');
disp(' Writing displacement arrays'); 
disp('  ');        

iu=getappdata(0,'iu');

scale=1;
 
if(iu==2)
    scale=386;
end
if(iu==4)
    scale=9.81;
end


TM1_power_trans=zeros(num_node_disp,nf);
TM2_power_trans=zeros(num_node_disp,nf);
TM3_power_trans=zeros(num_node_disp,nf);
                
progressbar;

total=num_node_disp*nf;

for i=1:num_node_disp
    
    node=node_disp(i);
        
    output_TM1=sprintf('disp_%d_mag_frf_T1',node);
    output_TM2=sprintf('disp_%d_mag_frf_T2',node);            
    output_TM3=sprintf('disp_%d_mag_frf_T3',node);         
    output_RM1=sprintf('disp_%d_mag_frf_R1',node);
    output_RM2=sprintf('disp_%d_mag_frf_R2',node);            
    output_RM3=sprintf('disp_%d_mag_frf_R3',node); 
 
    output_TM1_power_trans=sprintf('disp_%d_power_trans_T1',node);
    output_TM2_power_trans=sprintf('disp_%d_power_trans_T2',node);            
    output_TM3_power_trans=sprintf('disp_%d_power_trans_T3',node);     
    
    
    for j=1:nf

        progressbar((i*j)/total); 
        
        TM1(j,i)=scale*TM1(j,i)/abase_mag(j);            
        TM2(j,i)=scale*TM2(j,i)/abase_mag(j); 
        TM3(j,i)=scale*TM3(j,i)/abase_mag(j);             
        RM1(j,i)=scale*RM1(j,i)/abase_mag(j);            
        RM2(j,i)=scale*RM2(j,i)/abase_mag(j); 
        RM3(j,i)=scale*RM3(j,i)/abase_mag(j);
        
        TM1_power_trans(j,i)=TM1(j,i)^2;
        TM2_power_trans(j,i)=TM2(j,i)^2;
        TM3_power_trans(j,i)=TM3(j,i)^2;      
        
    end    
    
    assignin('base', output_TM1, [fn TM1(:,i)]);            
    assignin('base', output_TM2, [fn TM2(:,i)]); 
    assignin('base', output_TM3, [fn TM3(:,i)]);             
    assignin('base', output_RM1, [fn RM1(:,i)]);            
    assignin('base', output_RM2, [fn RM2(:,i)]); 
    assignin('base', output_RM3, [fn RM3(:,i)]);    
    
    assignin('base', output_TM1_power_trans, [fn TM1_power_trans(:,i)]);            
    assignin('base', output_TM2_power_trans, [fn TM2_power_trans(:,i)]); 
    assignin('base', output_TM3_power_trans, [fn TM3_power_trans(:,i)]);  
    

        
    output_TT=sprintf('%s\t %s\t %s',output_TM1,output_TM2,output_TM3);
    output_RR=sprintf('%s\t %s\t %s',output_RM1,output_RM2,output_RM3);
    disp(output_TT);
    disp(output_RR);    
    
    output_power_trans=sprintf('%s\t %s\t %s',output_TM1_power_trans,output_TM2_power_trans,output_TM3_power_trans);    
    
    
%%    
    
    output_TC1=sprintf('disp_%d_complex_frf_T1',node);
    output_TC2=sprintf('disp_%d_complex_frf_T2',node);            
    output_TC3=sprintf('disp_%d_complex_frf_T3',node);         
    output_RC1=sprintf('disp_%d_complex_frf_R1',node);
    output_RC2=sprintf('disp_%d_complex_frf_R2',node);            
    output_RC3=sprintf('disp_%d_complex_frf_R3',node); 
 
    for j=1:nf
    
        TC1(j,i)=scale*TC1(j,i)/abase_complex(j);            
        TC2(j,i)=scale*TC2(j,i)/abase_complex(j); 
        TC3(j,i)=scale*TC3(j,i)/abase_complex(j);             
        RC1(j,i)=scale*RC1(j,i)/abase_complex(j);            
        RC2(j,i)=scale*RC2(j,i)/abase_complex(j); 
        RC3(j,i)=scale*RC3(j,i)/abase_complex(j);
        
    end      
        
    assignin('base', output_TC1, [fn TC1(:,i)]);            
    assignin('base', output_TC2, [fn TC2(:,i)]); 
    assignin('base', output_TC3, [fn TC3(:,i)]);             
    assignin('base', output_RC1, [fn RC1(:,i)]);            
    assignin('base', output_RC2, [fn RC2(:,i)]); 
    assignin('base', output_RC3, [fn RC3(:,i)]);    
    
 
    output_TT=sprintf('%s\t %s\t %s',output_TC1,output_TC2,output_TC3);
    output_RR=sprintf('%s\t %s\t %s',output_RC1,output_RC2,output_RC3);
    disp(output_TT);
    disp(output_RR);    
    
    disp(output_power_trans);    
        
end
    
progressbar(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nrd==1)
             
    j=node_index(reference_node);
            
    progressbar;
    
    for i=1:num_node_disp
            
        progressbar(i/num_node_disp);         
        
        node=node_disp(i);
                
        if(node~=reference_node)
                
            output_TC1=sprintf('rel_disp_complex_frf_%d_%d_T1',node,reference_node);
            output_TC2=sprintf('rel_disp_complex_frf_%d_%d_T2',node,reference_node);            
            output_TC3=sprintf('rel_disp_complex_frf_%d_%d_T3',node,reference_node); 
            
            for k=1:nf
    
                TC1(k,i)=(TC1(k,i)-TC1(k,j))/abase_complex(j);            
                TC2(k,i)=(TC2(k,i)-TC2(k,j))/abase_complex(j); 
                TC3(k,i)=(TC3(k,i)-TC3(k,j))/abase_complex(j);             
        
            end 
 
            
            assignin('base', output_TC1, [fn TC1(:,i)]);            
            assignin('base', output_TC2, [fn TC2(:,i)]); 
            assignin('base', output_TC3, [fn TC3(:,i)]);             
            
            output_TT=sprintf('%s\t %s\t %s',output_TC1,output_TC2,output_TC3);
            disp(output_TT);             
                
 %%           
            
            output_TM1=sprintf('rel_disp_mag_frf_%d_%d_T1',node,reference_node);
            output_TM2=sprintf('rel_disp_mag_frf_%d_%d_T2',node,reference_node);            
            output_TM3=sprintf('rel_disp_mag_frf_%d_%d_T3',node,reference_node);          
 
            output_TM1_power_trans=sprintf('rel_disp_%d_%d_power_trans_T1',node,reference_node);
            output_TM2_power_trans=sprintf('rel_disp_%d_%d_power_trans_T2',node,reference_node);            
            output_TM3_power_trans=sprintf('rel_disp_%d_%d_power_trans_T3',node,reference_node);     
           
            
            assignin('base', output_TM1, [fn abs(TC1(:,i))]);            
            assignin('base', output_TM2, [fn abs(TC2(:,i))]); 
            assignin('base', output_TM3, [fn abs(TC3(:,i))]);  
            
            assignin('base', output_TM1_power_trans, [fn abs(TC1(:,i)).*abs(TC1(:,i))]);            
            assignin('base', output_TM2_power_trans, [fn abs(TC2(:,i)).*abs(TC2(:,i))]); 
            assignin('base', output_TM3_power_trans, [fn abs(TC3(:,i)).*abs(TC3(:,i))]);              
            
            output_TT=sprintf('%s\t %s\t %s',output_TM1,output_TM2,output_TM3);
            disp(output_TT);
            
            output_TT_power_trans=sprintf('%s\t %s\t %s',output_TM1_power_trans,output_TM2_power_trans,output_TM3_power_trans);
            disp(output_TT_power_trans);            
            
            
        end
                
    end
       
end

progressbar(1);
           

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
    
  

function find_velocity_nodes(hObject, eventdata, handles)

    abase_complex=getappdata(0,'abase_complex');
    abase_mag=getappdata(0,'abase_mag');
    
    sarray=getappdata(0,'sarray');
    idv=getappdata(0,'idv');
    fn=getappdata(0,'fn');
    nf=getappdata(0,'nf');  
    nrd=getappdata(0,'nrd');     
    
    disp('    ');
    disp(' Find velocity response nodes ');
    disp('    ');
        
    j=1;
    
    jk=1;
        
    iflag=0;
        
    for i=idv(1):idv(2)
                        
        ss=sarray{1}{i};
            
        k=strfind(ss, 'POINT ID.');
            
        if(~isempty(k))
                
                while(1) 
                    ss=sarray{1}{i+j};
                  
                    kk=strfind(ss,'FRF');
                    
                    if(~isempty(kk))
                        iflag=1;
                        break;
                    else
                        strs = strsplit(ss,' ');
                        if( strcmp(char(strs(3)),'G'))
                            node_velox(jk)= str2double(strs(2));
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
   
   num_node_velox=length(node_velox);
   
   for i=1:num_node_velox
       out1=sprintf('  %d',node_velox(i));
       disp(out1);
   end    
   
   setappdata(0,'num_node_velox',num_node_velox);
   setappdata(0,'node_velox',node_velox);
    
   
   qflag=0;
   setappdata(0,'qflag',qflag);
   

disp('    ');
disp(' Form velocity FRF ');
disp('    ');
        
nm=max(node_velox);
        
node_index=zeros(nm,1);
        
for i=1:num_node_velox
    j=node_velox(i);
    node_index(j)=i;
end
                
progressbar;
            
nndd=nf;
        
TM1=zeros(nf,num_node_velox);
TM2=zeros(nf,num_node_velox);
TM3=zeros(nf,num_node_velox);
RM1=zeros(nf,num_node_velox);
RM2=zeros(nf,num_node_velox);
RM3=zeros(nf,num_node_velox);        
                 
TP1=zeros(nf,num_node_velox);
TP2=zeros(nf,num_node_velox);
TP3=zeros(nf,num_node_velox);
RP1=zeros(nf,num_node_velox);
RP2=zeros(nf,num_node_velox);
RP3=zeros(nf,num_node_velox);   

TC1=zeros(nf,num_node_velox);
TC2=zeros(nf,num_node_velox);
TC3=zeros(nf,num_node_velox);
RC1=zeros(nf,num_node_velox);
RC2=zeros(nf,num_node_velox);
RC3=zeros(nf,num_node_velox);  
        

 
C=pi/180;

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
                        
            for ijk=1:2:2*num_node_velox 
                sst=sarray{1}{k+ijk};
                strs = strsplit(sst,' ');
                iv=node_index(str2num(char(strs(2))));
                        
                TM1(j,iv)=str2double(char(strs(4)));
                TM2(j,iv)=str2double(char(strs(5)));
                TM3(j,iv)=str2double(char(strs(6)));  
                RM1(j,iv)=str2double(char(strs(7)));
                RM2(j,iv)=str2double(char(strs(8)));
                RM3(j,iv)=str2double(char(strs(9)));   
                
                sst=sarray{1}{k+ijk+1};
                strs = strsplit(sst,' ');
                
                TP1(j,iv)=C*str2double(char(strs(1)));
                TP2(j,iv)=C*str2double(char(strs(2)));
                TP3(j,iv)=C*str2double(char(strs(3)));  
                RP1(j,iv)=C*str2double(char(strs(4)));
                RP2(j,iv)=C*str2double(char(strs(5)));
                RP3(j,iv)=C*str2double(char(strs(6)));   
         
                TC1(j,iv)=TM1(j,iv)*( cos(TP1(j,iv)) + 1i*sin(TP1(j,iv))  );
                TC2(j,iv)=TM2(j,iv)*( cos(TP2(j,iv)) + 1i*sin(TP2(j,iv))  );
                TC3(j,iv)=TM3(j,iv)*( cos(TP3(j,iv)) + 1i*sin(TP3(j,iv))  );
                RC1(j,iv)=RM1(j,iv)*( cos(RP1(j,iv)) + 1i*sin(RP1(j,iv))  );
                RC2(j,iv)=RM2(j,iv)*( cos(RP2(j,iv)) + 1i*sin(RP2(j,iv))  );
                RC3(j,iv)=RM3(j,iv)*( cos(RP3(j,iv)) + 1i*sin(RP3(j,iv))  );                  
                
                
            end
                        
            break;
                           
        end
    end
end
 
%%
pause(0.2);
progressbar(1);       
        
disp('  ');
disp(' Writing velocity arrays'); 
disp('  ');        


iu=getappdata(0,'iu');

scale=1;

if(iu==2)
    scale=386;
end
if(iu==4)
    scale=9.81;
end


TM1_power_trans=zeros(num_node_velox,nf);
TM2_power_trans=zeros(num_node_velox,nf);
TM3_power_trans=zeros(num_node_velox,nf);

progressbar;

total=num_node_velox*nf;
                
for i=1:num_node_velox
 
    node=node_velox(i);
        
    output_TM1=sprintf('velox_%d_mag_frf_T1',node);
    output_TM2=sprintf('velox_%d_mag_frf_T2',node);            
    output_TM3=sprintf('velox_%d_mag_frf_T3',node);         
    output_RM1=sprintf('velox_%d_mag_frf_R1',node);
    output_RM2=sprintf('velox_%d_mag_frf_R2',node);            
    output_RM3=sprintf('velox_%d_mag_frf_R3',node); 
    
    output_TM1_power_trans=sprintf('velox_%d_power_trans_T1',node);
    output_TM2_power_trans=sprintf('velox_%d_power_trans_T2',node);            
    output_TM3_power_trans=sprintf('velox_%d_power_trans_T3',node);         
    

    for j=1:nf
        
        progressbar((i+j)/total);        
    
        TM1(j,i)=scale*TM1(j,i)/abase_mag(j);            
        TM2(j,i)=scale*TM2(j,i)/abase_mag(j); 
        TM3(j,i)=scale*TM3(j,i)/abase_mag(j);             
        RM1(j,i)=scale*RM1(j,i)/abase_mag(j);            
        RM2(j,i)=scale*RM2(j,i)/abase_mag(j); 
        RM3(j,i)=scale*RM3(j,i)/abase_mag(j);
        
        TM1_power_trans(j,i)=TM1(j,i)^2;
        TM2_power_trans(j,i)=TM2(j,i)^2;
        TM3_power_trans(j,i)=TM3(j,i)^2; 
       
    end    
    
    assignin('base', output_TM1, [fn TM1(:,i)]);            
    assignin('base', output_TM2, [fn TM2(:,i)]); 
    assignin('base', output_TM3, [fn TM3(:,i)]);             
    assignin('base', output_RM1, [fn RM1(:,i)]);            
    assignin('base', output_RM2, [fn RM2(:,i)]); 
    assignin('base', output_RM3, [fn RM3(:,i)]);
    
    assignin('base', output_TM1_power_trans, [fn TM1_power_trans(:,i)]);            
    assignin('base', output_TM2_power_trans, [fn TM2_power_trans(:,i)]); 
    assignin('base', output_TM3_power_trans, [fn TM3_power_trans(:,i)]);        
          
      
    
    output_TT=sprintf('%s\t %s\t %s',output_TM1,output_TM2,output_TM3);
    output_RR=sprintf('%s\t %s\t %s',output_RM1,output_RM2,output_RM3);
    disp(output_TT);
    disp(output_RR);    
    
%%    
    
    output_TC1=sprintf('velox_%d_complex_frf_T1',node);
    output_TC2=sprintf('velox_%d_complex_frf_T2',node);            
    output_TC3=sprintf('velox_%d_complex_frf_T3',node);         
    output_RC1=sprintf('velox_%d_complex_frf_R1',node);
    output_RC2=sprintf('velox_%d_complex_frf_R2',node);            
    output_RC3=sprintf('velox_%d_complex_frf_R3',node); 
 

    for j=1:nf
    
        TC1(j,i)=scale*TC1(j,i)/abase_complex(j);            
        TC2(j,i)=scale*TC2(j,i)/abase_complex(j); 
        TC3(j,i)=scale*TC3(j,i)/abase_complex(j);             
        RC1(j,i)=scale*RC1(j,i)/abase_complex(j);            
        RC2(j,i)=scale*RC2(j,i)/abase_complex(j); 
        RC3(j,i)=scale*RC3(j,i)/abase_complex(j);
        
    end        
    
    assignin('base', output_TC1, [fn TC1(:,i)]);            
    assignin('base', output_TC2, [fn TC2(:,i)]); 
    assignin('base', output_TC3, [fn TC3(:,i)]);             
    assignin('base', output_RC1, [fn RC1(:,i)]);            
    assignin('base', output_RC2, [fn RC2(:,i)]); 
    assignin('base', output_RC3, [fn RC3(:,i)]);
            
    output_TT=sprintf('%s\t %s\t %s',output_TC1,output_TC2,output_TC3);
    output_RR=sprintf('%s\t %s\t %s',output_RC1,output_RC2,output_RC3);
    disp(output_TT);
    disp(output_RR);   
 
    
    output_power_trans=sprintf('%s\t %s\t %s',output_TM1_power_trans,output_TM2_power_trans,output_TM3_power_trans);    
    disp(output_power_trans);        
   
end

progressbar;

if(nrd==1)

    reference_node=getappdata(0,'reference_node');
    
    j=node_index(reference_node);
            
    for i=1:num_node_velox
            
        progressbar(i/num_node_velox);         
        
        node=node_velox(i);
                
        if(node~=reference_node)
                
            output_TC1=sprintf('rel_velox_complex_frf_%d_%d_T1',node,reference_node);
            output_TC2=sprintf('rel_velox_complex_frf_%d_%d_T2',node,reference_node);            
            output_TC3=sprintf('rel_velox_complex_frf_%d_%d_T3',node,reference_node); 
           
            output_TM1_power_trans=sprintf('rel_velox_power_trans_%d_%d_T1',node,reference_node);
            output_TM2_power_trans=sprintf('rel_velox_power_trans_%d_%d_T2',node,reference_node);            
            output_TM3_power_trans=sprintf('rel_velox_power_trans_%d_%d_T3',node,reference_node); 
            
            
            for k=1:nf
    
                TC1(k,i)=(TC1(k,i)-TC1(k,j))/abase_complex(j);            
                TC2(k,i)=(TC2(k,i)-TC2(k,j))/abase_complex(j); 
                TC3(k,i)=(TC3(k,i)-TC3(k,j))/abase_complex(j);             
        
            end 
 
            
            assignin('base', output_TC1, [fn TC1(:,i)]);            
            assignin('base', output_TC2, [fn TC2(:,i)]); 
            assignin('base', output_TC3, [fn TC3(:,i)]);             
            
            output_TT=sprintf('%s\t %s\t %s',output_TC1,output_TC2,output_TC3);
            disp(output_TT);             
                
 %%           
            
            output_TM1=sprintf('rel_velox_mag_frf_%d_%d_T1',node,reference_node);
            output_TM2=sprintf('rel_velox_mag_frf_%d_%d_T2',node,reference_node);            
            output_TM3=sprintf('rel_velox_mag_frf_%d_%d_T3',node,reference_node);          
 
            assignin('base', output_TM1, [fn abs(TC1(:,i))]);            
            assignin('base', output_TM2, [fn abs(TC2(:,i))]); 
            assignin('base', output_TM3, [fn abs(TC3(:,i))]);             
            
            assignin('base', output_TM1_power_trans, [fn abs(TC1(:,i)).*abs(TC1(:,i))]);            
            assignin('base', output_TM2_power_trans, [fn abs(TC2(:,i)).*abs(TC2(:,i))]); 
            assignin('base', output_TM3_power_trans, [fn abs(TC3(:,i)).*abs(TC3(:,i))]); 
            
             
            output_TT=sprintf('%s\t %s\t %s',output_TM1,output_TM2,output_TM3);
            disp(output_TT);
            
            output_TT_power_trans=sprintf('%s\t %s\t %s',output_TM1_power_trans,output_TM2_power_trans,output_TM3_power_trans);
            disp(output_TT_power_trans);
            
            
        end
                
    end
             
end

progressbar(1);
          
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function find_acceleration_nodes(hObject, eventdata, handles)

    abase_complex=getappdata(0,'abase_complex');
    abase_mag=getappdata(0,'abase_mag');
    
    sarray=getappdata(0,'sarray');
    ida=getappdata(0,'ida');
    fn=getappdata(0,'fn');
    nf=getappdata(0,'nf');  
    
    disp('    ');
    disp(' Find acceleration response nodes ');
    disp('    ');
        
    j=1;
    
    jk=1;
        
    iflag=0;
        
    for i=ida(1):ida(2)
                        
        ss=sarray{1}{i};
            
        k=strfind(ss, 'POINT ID.');
            
        if(~isempty(k))
                
                while(1) 
                    ss=sarray{1}{i+j};
                  
                    kk=strfind(ss,'FRF');
                    
                    if(~isempty(kk))
                        iflag=1;
                        break;
                    else
                        strs = strsplit(ss,' ');
                        if( strcmp(char(strs(3)),'G'))
                            node_accel(jk)= str2double(strs(2));
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
   
   num_node_accel=length(node_accel);
   
   base_input_node=getappdata(0,'base_input_node');
   ex_axis=getappdata(0,'ex_axis');
   
   
   zflag=0;
   
   for i=1:num_node_accel
       out1=sprintf('  %d',node_accel(i));
       disp(out1);
       
       if(node_accel(i)==base_input_node)
           zflag=1;
       end
       
   end    
   
   if(zflag==0)
       warndlg('Base input node not found');
       return;
   end
   
   setappdata(0,'num_node_accel',num_node_accel);
   setappdata(0,'node_accel',node_accel);
    
   
   qflag=0;
   setappdata(0,'qflag',qflag);
   

disp('    ');
disp(' Form acceleration FRF ');
disp('    ');
        
nm=max(node_accel);
        
node_index=zeros(nm,1);
        
for i=1:num_node_accel
    j=node_accel(i);
    node_index(j)=i;
end
                
progressbar;
            
nndd=nf;
        
TM1=zeros(nf,num_node_accel);
TM2=zeros(nf,num_node_accel);
TM3=zeros(nf,num_node_accel);
RM1=zeros(nf,num_node_accel);
RM2=zeros(nf,num_node_accel);
RM3=zeros(nf,num_node_accel);        
                 
TP1=zeros(nf,num_node_accel);
TP2=zeros(nf,num_node_accel);
TP3=zeros(nf,num_node_accel);
RP1=zeros(nf,num_node_accel);
RP2=zeros(nf,num_node_accel);
RP3=zeros(nf,num_node_accel);   

TC1=zeros(nf,num_node_accel);
TC2=zeros(nf,num_node_accel);
TC3=zeros(nf,num_node_accel);
RC1=zeros(nf,num_node_accel);
RC2=zeros(nf,num_node_accel);
RC3=zeros(nf,num_node_accel);  
        

 
C=pi/180;

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
                        
            for ijk=1:2:2*num_node_accel 
                sst=sarray{1}{k+ijk};
                strs = strsplit(sst,' ');
                try
                    iv=node_index(str2num(char(strs(2))));
                    TM1(j,iv)=str2double(char(strs(4)));
                catch
                    disp(' ref 100');
                    disp('sst');
                    sst
                    disp('strs');
                    strs
                    disp('strs(4)');
                    strs(4)
                    disp('char(strs(4)))');
                    (char(strs(4)))
                    j
                    iv
                    return;
                end
                TM2(j,iv)=str2double(char(strs(5)));
                TM3(j,iv)=str2double(char(strs(6)));  
                RM1(j,iv)=str2double(char(strs(7)));
                RM2(j,iv)=str2double(char(strs(8)));
                RM3(j,iv)=str2double(char(strs(9)));   
                
                sst=sarray{1}{k+ijk+1};
                strs = strsplit(sst,' ');
                
                try
                    TP1(j,iv)=C*str2double(char(strs(1)));
                    TP2(j,iv)=C*str2double(char(strs(2)));
                    TP3(j,iv)=C*str2double(char(strs(3)));  
                    RP1(j,iv)=C*str2double(char(strs(4)));
                    RP2(j,iv)=C*str2double(char(strs(5)));
                    RP3(j,iv)=C*str2double(char(strs(6)));   
                catch
                    disp('ref 200');
                    disp('strs');
                    strs 
                    return;
                end
                    
                TC1(j,iv)=TM1(j,iv)*( cos(TP1(j,iv)) + 1i*sin(TP1(j,iv))  );
                TC2(j,iv)=TM2(j,iv)*( cos(TP2(j,iv)) + 1i*sin(TP2(j,iv))  );
                TC3(j,iv)=TM3(j,iv)*( cos(TP3(j,iv)) + 1i*sin(TP3(j,iv))  );
                RC1(j,iv)=RM1(j,iv)*( cos(RP1(j,iv)) + 1i*sin(RP1(j,iv))  );
                RC2(j,iv)=RM2(j,iv)*( cos(RP2(j,iv)) + 1i*sin(RP2(j,iv))  );
                RC3(j,iv)=RM3(j,iv)*( cos(RP3(j,iv)) + 1i*sin(RP3(j,iv))  );                  
                
                
            end
                        
            break;
                           
        end
    end
end
 
%%
pause(0.2);
progressbar(1);       
        
disp('  ');
disp(' Writing acceleration arrays'); 
disp('  ');        

progressbar;

for i=1:num_node_accel
    
    progressbar(i/num_node_accel);     
    
    node=node_accel(i);    
   
        if(node==base_input_node)

            
            if(ex_axis==1)
                setappdata(0,'abase_complex',TC1(:,i));
                setappdata(0,'abase_mag',TM1(:,i)); 
            end
            if(ex_axis==2)
                setappdata(0,'abase_complex',TC2(:,i));
                setappdata(0,'abase_mag',TM2(:,i));    
            end
            if(ex_axis==3)
                setappdata(0,'abase_complex',TC3(:,i));
                setappdata(0,'abase_mag',TM3(:,i));    
            end        
        
            break;
            
        end
     
end

progressbar(1);


abase_mag=getappdata(0,'abase_mag');
abase_complex=getappdata(0,'abase_complex');

nflag=0;
setappdata(0,'nflag',nflag);

if(max(abase_mag)==0)
    nflag=1;
    setappdata(0,'nflag',nflag);
    warndlg(' Base magnitude is zero.  Check Input Axis. ');
    return;
end


TM1_power_trans=zeros(num_node_accel,nf);
TM2_power_trans=zeros(num_node_accel,nf);
TM3_power_trans=zeros(num_node_accel,nf);

       
progressbar;

total=num_node_accel*nf;

for i=1:num_node_accel
 

    
    node=node_accel(i);
        
    output_TM1=sprintf('accel_%d_mag_frf_T1',node);
    output_TM2=sprintf('accel_%d_mag_frf_T2',node);            
    output_TM3=sprintf('accel_%d_mag_frf_T3',node);         
    output_RM1=sprintf('accel_%d_mag_frf_R1',node);
    output_RM2=sprintf('accel_%d_mag_frf_R2',node);            
    output_RM3=sprintf('accel_%d_mag_frf_R3',node); 
    
    output_TM1_power_trans=sprintf('accel_%d_power_trans_T1',node);
    output_TM2_power_trans=sprintf('accel_%d_power_trans_T2',node);            
    output_TM3_power_trans=sprintf('accel_%d_power_trans_T3',node);     
    
 
    
    for j=1:nf
        
        progressbar((i*j)/total);         
    
        TM1(j,i)=TM1(j,i)/abase_mag(j);            
        TM2(j,i)=TM2(j,i)/abase_mag(j); 
        TM3(j,i)=TM3(j,i)/abase_mag(j);             
        RM1(j,i)=RM1(j,i)/abase_mag(j);            
        RM2(j,i)=RM2(j,i)/abase_mag(j); 
        RM3(j,i)=RM3(j,i)/abase_mag(j);
        
        TM1_power_trans(j,i)=TM1(j,i)^2;
        TM2_power_trans(j,i)=TM2(j,i)^2;
        TM3_power_trans(j,i)=TM3(j,i)^2; 
       
    end    
        
    assignin('base', output_TM1, [fn TM1(:,i)]);            
    assignin('base', output_TM2, [fn TM2(:,i)]); 
    assignin('base', output_TM3, [fn TM3(:,i)]);             
    assignin('base', output_RM1, [fn RM1(:,i)]);            
    assignin('base', output_RM2, [fn RM2(:,i)]); 
    assignin('base', output_RM3, [fn RM3(:,i)]);
    
    assignin('base', output_TM1_power_trans, [fn TM1_power_trans(:,i)]);            
    assignin('base', output_TM2_power_trans, [fn TM2_power_trans(:,i)]); 
    assignin('base', output_TM3_power_trans, [fn TM3_power_trans(:,i)]);    

    
            
    output_TT=sprintf('%s\t %s\t %s',output_TM1,output_TM2,output_TM3);
    output_RR=sprintf('%s\t %s\t %s',output_RM1,output_RM2,output_RM3);
    disp(output_TT);
    disp(output_RR);    
    
%%    
    
    output_TC1=sprintf('accel_%d_complex_frf_T1',node);
    output_TC2=sprintf('accel_%d_complex_frf_T2',node);            
    output_TC3=sprintf('accel_%d_complex_frf_T3',node);         
    output_RC1=sprintf('accel_%d_complex_frf_R1',node);
    output_RC2=sprintf('accel_%d_complex_frf_R2',node);            
    output_RC3=sprintf('accel_%d_complex_frf_R3',node); 
 
    for j=1:nf
    
        TC1(j,i)=TC1(j,i)/abase_complex(j);            
        TC2(j,i)=TC2(j,i)/abase_complex(j); 
        TC3(j,i)=TC3(j,i)/abase_complex(j);             
        RC1(j,i)=RC1(j,i)/abase_complex(j);            
        RC2(j,i)=RC2(j,i)/abase_complex(j); 
        RC3(j,i)=RC3(j,i)/abase_complex(j);
        
    end
    
    
    assignin('base', output_TC1, [fn TC1(:,i)]);            
    assignin('base', output_TC2, [fn TC2(:,i)]); 
    assignin('base', output_TC3, [fn TC3(:,i)]);             
    assignin('base', output_RC1, [fn RC1(:,i)]);            
    assignin('base', output_RC2, [fn RC2(:,i)]); 
    assignin('base', output_RC3, [fn RC3(:,i)]);
            
    output_TT=sprintf('%s\t %s\t %s',output_TC1,output_TC2,output_TC3);
    output_RR=sprintf('%s\t %s\t %s',output_RC1,output_RC2,output_RC3);
    disp(output_TT);
    disp(output_RR);    
    
    output_power_trans=sprintf('%s\t %s\t %s',output_TM1_power_trans,output_TM2_power_trans,output_TM3_power_trans);    
    disp(output_power_trans);    
    
    
       
end

progressbar(1);
    



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
fmax=str2num(get(handles.edit_fmax,'String'));

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
fmax=str2num(get(handles.edit_fmax,'String'));

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
fmax=str2num(get(handles.edit_fmax,'String'));

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


%%%%%%%%

function plot_quad4stress(hObject, eventdata, handles)      
   

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

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
fmax=str2num(get(handles.edit_fmax,'String'));

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
fmax=str2num(get(handles.edit_fmax,'String'));

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
fmax=str2num(get(handles.edit_fmax,'String'));


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
fmax=str2num(get(handles.edit_fmax,'String'));

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


function plate_strain_frf(hObject, eventdata, handles)  
    
elem_plate_strain=getappdata(0,'elem_plate_strain');
num_elem_plate_strain=getappdata(0,'num_elem_plate_strain');
nf=getappdata(0,'nf');
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
            
nndd=nf;
        
plate_normal_x=zeros(nf,num_elem_plate_strain);
plate_normal_y=zeros(nf,num_elem_plate_strain);
plate_shear=zeros(nf,num_elem_plate_strain);        
plate_VM=zeros(nf,num_elem_plate_strain); 

  
k1=iplate_strain(1);
        
k=k1-1;

C=pi/180;

NQ=360;                        
dp=C*0.5;


for j=1:nndd
    
    progressbar(j/nndd); 
    
    while(1)
    
        k=k+1;
                    
        sst=sarray{1}{k};
        strs = strsplit(sst,' ');       
     
        LL=length(strs);
     
        if(LL==12)
            
            try
                 
                s1=str2num(char(strs(1)));
                s2=str2num(char(strs(2)));
            
                if(s1==0 && ~isnan(s2) && s2>=elem_plate_strain(1))
                
                    iv = find(elem_plate_strain==s2,1);
    
                    if(iv>=1)
                        
                        plate_normal_x(j,iv)=str2double(char(strs(LL-8)));
                        plate_normal_y(j,iv)=str2double(char(strs(LL-5)));
                        plate_shear(j,iv)=str2double(char(strs(LL-2)));

                        sst=sarray{1}{k+1};
                        strs = strsplit(sst,' '); 
                        LL=length(strs);
                        
                        phx=C*str2double(char(strs(LL-6)));
                        phy=C*str2double(char(strs(LL-3)));
                        phs=C*str2double(char(strs(LL)));                        
                      
                        
                        qqq=zeros(NQ,1);
                        
                        for i=1:NQ
                        
                           p=(i-1)*dp; 
                            
                           sxx=plate_normal_x(j,iv)*sin(phx+p);
                           syy=plate_normal_y(j,iv)*sin(phy+p);
                           sxy=plate_shear(j,iv)*sin(phs+p);
                           term=sxx^2 + syy^2 - sxx*syy + 3*sxy^2;
                           qqq(i)=sqrt(term); 
                                               
                        end

                        plate_VM(j,iv)=max(abs(qqq));                  
                
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
setappdata(0,'plate_VM',plate_VM);       

              
%%


% --- Executes on button press in radiobutton_plate_tria3_strain.
function radiobutton_plate_tria3_strain_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_plate_tria3_strain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_plate_tria3_strain

%%%%%%%%

function plot_tria3strain(hObject, eventdata, handles)      
   

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_elem_tria3strain=getappdata(0,'num_elem_tria3strain');
elem_tria3strain=getappdata(0,'elem_tria3strain');

    
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
        
for i=1:num_elem_tria3strain
            
    elem=elem_tria3strain(i);
        
    output_T1=sprintf('tria3_strain_VM_frf_%d',elem);   
            
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
