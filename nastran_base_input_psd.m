function varargout = nastran_base_input_psd(varargin)
% NASTRAN_BASE_INPUT_PSD MATLAB code for nastran_base_input_psd.fig
%      NASTRAN_BASE_INPUT_PSD, by itself, creates a new NASTRAN_BASE_INPUT_PSD or raises the existing
%      singleton*.
%
%      H = NASTRAN_BASE_INPUT_PSD returns the handle to a new NASTRAN_BASE_INPUT_PSD or the handle to
%      the existing singleton*.
%
%      NASTRAN_BASE_INPUT_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NASTRAN_BASE_INPUT_PSD.M with the given input arguments.
%
%      NASTRAN_BASE_INPUT_PSD('Property','Value',...) creates a new NASTRAN_BASE_INPUT_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nastran_base_input_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nastran_base_input_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nastran_base_input_psd

% Last Modified by GUIDE v2.5 28-Apr-2018 16:30:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nastran_base_input_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @nastran_base_input_psd_OutputFcn, ...
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


% --- Executes just before nastran_base_input_psd is made visible.
function nastran_base_input_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nastran_base_input_psd (see VARARGIN)

% Choose default command line output for nastran_base_input_psd
handles.output = hObject;

listbox_input_unit_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nastran_base_input_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nastran_base_input_psd_OutputFcn(hObject, eventdata, handles) 
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

delete(nastran_base_input_psd);


% --- Executes on button press in pushbutton_read_f06.
function pushbutton_read_f06_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_f06 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;
setappdata(0,'fig_num',fig_num);



fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

if(isempty(fmin))
    warndlg('Enter fmin');
    return;
end
if(isempty(fmax))
    warndlg('Enter fmax');
    return;
end

setappdata(0,'fmin',fmin);
setappdata(0,'fmax',fmax);


iu=get(handles.listbox_input_unit,'Value');
setappdata(0,'iu',iu);


   setappdata(0,'metric_displacement',0);
   setappdata(0,'metric_velocity',0);
   setappdata(0,'metric_acceleration',0);

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
   
   setappdata(0,'rb_displacement',rb_displacement);
   setappdata(0,'rb_velocity',rb_velocity);
   setappdata(0,'rb_acceleration',rb_acceleration);
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   find_number_frequency_points(hObject, eventdata, handles);
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   metric_displacement=getappdata(0,'metric_displacement');
   metric_velocity=getappdata(0,'metric_velocity');
   metric_acceleration=getappdata(0,'metric_acceleration');

   disp(' ');
   out1=sprintf(' metric_acceleration=%d rb_acceleration=%d \n',metric_acceleration,rb_acceleration);
   disp(out1);
   
   
   if(metric_displacement==1 && rb_displacement==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_displacement(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
   end      
   
   
   out1=sprintf(' metric_velocity=%d  rb_velocity=%d \n',metric_velocity,rb_velocity);
   disp(out1);
   
   if(metric_velocity==1 && rb_velocity==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_velocity(hObject, eventdata, handles);
 
        fig_num=getappdata(0,'fig_num');
      
   end        
   if(metric_acceleration==1 && rb_acceleration==1)
    
        setappdata(0,'fig_num',fig_num);
        
        plot_acceleration(hObject, eventdata, handles);
      
   end     
   

   disp(' ');
   
   msgbox(' Calculation complete ');

function find_number_frequency_points(hObject, eventdata, handles)
   
disp('  ');
disp(' Find number of frequency points... ');
disp('  ');     
    
sarray=getappdata(0,'sarray'); 

rb_displacement=getappdata(0,'rb_displacement');
rb_velocity=getappdata(0,'rb_velocity');
rb_acceleration=getappdata(0,'rb_acceleration');


    idd=0;
    idv=0;
    ida=0;
    ipsd=0;
    num_node_disp=0;
    num_node_velox=0;
    num_node_accel=0;
   
    
    ipsd = strfind(sarray{:}, '( POWER SPECTRAL DENSITY FUNCTION )');
    ipsd = find(not(cellfun('isempty', ipsd)));    
    
    ipsd1=ipsd(1);
    
    
    if(rb_displacement==1)    
        idd = strfind(sarray{:}, 'D I S P L A C E M E N T   V E C T O R');
        idd = find(not(cellfun('isempty', idd)));
        
        for i=length(idd):-1:1
            
            nu=idd(i)+1;
            ss=sarray{1}{nu};      
            kk=strfind(ss,'POWER SPECTRAL DENSITY FUNCTION');
                    
            if(isempty(kk))            
                idd(i)=[];
            end    
        end
            
        num_node_disp = length(idd);
    end
    
    if(rb_velocity==1)
        idv = strfind(sarray{:}, 'V E L O C I T Y    V E C T O R');
        idv = find(not(cellfun('isempty', idv)));
                
        for i=length(idv):-1:1
            
            nu=idv(i)+1;
            ss=sarray{1}{nu};  
            
            kk=strfind(ss,'POWER SPECTRAL DENSITY FUNCTION');
                    
            if(isempty(kk))            
                idv(i)=[];
            end    
        
        end    
            
        num_node_velox = length(idv);

    end
    
    if(rb_acceleration==1)
        ida = strfind(sarray{:}, 'A C C E L E R A T I O N    V E C T O R');
        ida = find(not(cellfun('isempty', ida)));
            
        for i=length(ida):-1:1
             
            nu=ida(i)+1;
            ss=sarray{1}{nu};      
            kk=strfind(ss,'POWER SPECTRAL DENSITY FUNCTION');
                    
            if(isempty(kk))            
                ida(i)=[];
            end          
        
        end    
            
        num_node_accel = length(ida);
        setappdata(0,'num_node_accel',num_node_accel);
        
    end
    
    
    setappdata(0,'idd',idd);
    setappdata(0,'num_node_disp',num_node_disp);    
    setappdata(0,'idv',idv);
    setappdata(0,'num_node_velox',num_node_velox);
    setappdata(0,'ida',ida);
    setappdata(0,'num_node_accel',num_node_accel);        
    
        
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
    
    
    if(num_node_disp>0)
        metric_displacement=1;
    end
    if(num_node_velox>0)
        metric_velocity=1;          
    end   
    if(num_node_accel>0)
        metric_acceleration=1;          
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
 
    setappdata(0,'metric_displacement',metric_displacement);    
    setappdata(0,'metric_velocity',metric_velocity); 
    setappdata(0,'metric_acceleration',metric_acceleration); 
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
   out1=sprintf(' num_node_disp=%d  num_node_velox=%d  num_node_accel=%d ',num_node_disp,num_node_velox,num_node_accel);
   disp(out1);
 
   
   
   zflag=0;
   setappdata(0,'zflag',zflag);
   
   nf=length(fn);
   
   if(nf==0)
       out1=sprintf('f06 file must contain displacement, velocity, acceleration');
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

function find_acceleration_nodes(hObject, eventdata, handles)

iu1=get(handles.listbox_input_unit,'Value');
iu2=get(handles.listbox_output_unit,'Value'); 
iu3=get(handles.listbox_additional_unit,'Value');

a_scale=1;
vd_scale=1;    

if(iu1==1) % G^2/Hz input
    
    if(iu2==1) % G^2/Hz output
        if(iu3==1)
            vd_scale=386^2;  
            iu_nv=1;         
        else    
            vd_scale=9.81^2;
            iu_nv=2;      
        end    
    end
    if(iu2==2) % (in/sec^2)^2/Hz output
        a_scale=386^2;
        vd_scale=386^2;
        iu_nv=1;             
    end
    if(iu2==3) % (m/sec^2)^2/Hz output
        a_scale=9.81^2;
        vd_scale=9.81^2;
        iu_nv=2;     
    end    
    
end
if(iu1==2) % (in/sec^2)^2/Hz input
    
    if(iu2==1) % G^2/Hz output
        a_scale=1/386^2;     
    end
    iu_nv=1;    
  
end
if(iu1==3) % (m/sec^2)^2/Hz input
    iu_nv=2;
end    

if(iu_nv==1)
        velox_su='Vel ((in/sec)^2/Hz)';
        velox_sr='(in/sec) RMS';
        disp_su='Disp (in^2/Hz)';
        disp_sr='in RMS';       
else
        velox_su='Vel ((m/sec)^2/Hz)';
        velox_sr='(m/sec) RMS'; 
        disp_su='Disp (m^2/Hz)';
        disp_sr='m RMS';              
end

setappdata(0,'a_scale',a_scale);
setappdata(0,'vd_scale',vd_scale);

setappdata(0,'velox_su',velox_su);
setappdata(0,'velox_sr',velox_sr);
setappdata(0,'disp_su',disp_su);
setappdata(0,'disp_sr',disp_sr);


    sarray=getappdata(0,'sarray');
    ida=getappdata(0,'ida');
    fn=getappdata(0,'fn');
    nf=getappdata(0,'nf');  
    
    disp('    ');
    disp(' Find acceleration response nodes ');
        
    j=1;
    
    jk=1;
        
    iflag=0;
        

    
    for i=ida(1):ida(2)
                        
        ss=sarray{1}{i};
            
        k=strfind(ss, 'POINT ID.');
            
        if(~isempty(k))
                
                while(1) 
                    ss=sarray{1}{i+j};

                    if(length(ss)<=2)  
                        iflag=1;
                        break;
                    else
                        strs = strsplit(ss,' ');
                        if( strcmp(char(strs(2)),'G'))
                            node_accel(jk)= str2double(strs(1));
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
   
   for i=1:num_node_accel
       out1=sprintf('  %d',node_accel(i));
       disp(out1);
   end    
   
   
   setappdata(0,'num_node_accel',num_node_accel);
   setappdata(0,'node_accel',node_accel);
    
   
   qflag=0;
   setappdata(0,'qflag',qflag);
      
   
%%%%%%%%% 


for i=1:num_node_accel
    j=node_accel(i);
    node_index(j)=i;
end


TM1=zeros(nf,num_node_accel);
TM2=zeros(nf,num_node_accel);
TM3=zeros(nf,num_node_accel);
RM1=zeros(nf,num_node_accel);
RM2=zeros(nf,num_node_accel);
RM3=zeros(nf,num_node_accel); 


progressbar;
            
nndd=nf;
        

for j=1:nndd
                
    progressbar(j/nndd); 
            
    k1=ida(j);
                
    k=k1-1;
                
    while(1)
                    
        k=k+1;
                                        
        sst=sarray{1}{k};             
      
        ka=strfind(sst, 'POINT ID.');
            
        if(~isempty(ka))
                        
            for ijk=1:num_node_accel 
                sst=sarray{1}{k+ijk};
                strs = strsplit(sst,' ');
                iv=node_index(str2num(char(strs(1))));
                
 %%               sst
                        
                TM1(j,iv)=str2double(char(strs(3)))*a_scale;
                TM2(j,iv)=str2double(char(strs(4)))*a_scale;
                TM3(j,iv)=str2double(char(strs(5)))*a_scale;  
                RM1(j,iv)=str2double(char(strs(6)));
                RM2(j,iv)=str2double(char(strs(7)));
                RM3(j,iv)=str2double(char(strs(8)));   
                            
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

for i=1:num_node_accel
 
    node=node_accel(i);
        
    output_TM1=sprintf('accel_%d_psd_T1',node);
    output_TM2=sprintf('accel_%d_psd_T2',node);            
    output_TM3=sprintf('accel_%d_psd_T3',node);         
    output_RM1=sprintf('accel_%d_psd_R1',node);
    output_RM2=sprintf('accel_%d_psd_R2',node);            
    output_RM3=sprintf('accel_%d_psd_R3',node); 
       
    assignin('base', output_TM1, [fn TM1(:,i)]);            
    assignin('base', output_TM2, [fn TM2(:,i)]); 
    assignin('base', output_TM3, [fn TM3(:,i)]);             
    assignin('base', output_RM1, [fn RM1(:,i)]);            
    assignin('base', output_RM2, [fn RM2(:,i)]); 
    assignin('base', output_RM3, [fn RM3(:,i)]); 
            
    output_TT=sprintf('%s\t %s\t %s',output_TM1,output_TM2,output_TM3);
    output_RR=sprintf('%s\t %s\t %s',output_RM1,output_RM2,output_RM3);
    disp(output_TT);
    disp(output_RR);    
           
end


%%%%%%%%%
   

function find_velocity_nodes(hObject, eventdata, handles)


    
    sarray=getappdata(0,'sarray');
    idv=getappdata(0,'idv');
    fn=getappdata(0,'fn');
    nf=getappdata(0,'nf');  
    nrd=getappdata(0,'nrd');     
    
    disp('    ');
    disp(' Find velocity response nodes ');
        
    j=1;
    
    jk=1;
        
    iflag=0;
        
    for i=idv(1):idv(2)
                        
        ss=sarray{1}{i};
            
        k=strfind(ss, 'POINT ID.');
            
        if(~isempty(k))
                
                while(1) 
                    ss=sarray{1}{i+j};

                    if(length(ss)<=2)
                        iflag=1;
                        break;
                    else
                        strs = strsplit(ss,' ');
                        if( strcmp(char(strs(2)),'G'))
                            node_velox(jk)= str2double(strs(1));
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
   
%%%%%%%%%


for i=1:num_node_velox
    j=node_velox(i);
    node_index(j)=i;
end




TM1=zeros(nf,num_node_velox);
TM2=zeros(nf,num_node_velox);
TM3=zeros(nf,num_node_velox);
RM1=zeros(nf,num_node_velox);
RM2=zeros(nf,num_node_velox);
RM3=zeros(nf,num_node_velox); 

vd_scale=getappdata(0,'vd_scale');

progressbar;
            
nndd=nf;
        

for j=1:nndd
                
    progressbar(j/nndd); 
            
    k1=idv(j);
                
    k=k1-1;
                
    while(1)
                    
        k=k+1;
                                        
        sst=sarray{1}{k};             
                         
        ka=strfind(sst, 'POINT ID.');
            
        if(~isempty(ka))
                        
            for ijk=1:num_node_velox 
                sst=sarray{1}{k+ijk};
                strs = strsplit(sst,' ');
                iv=node_index(str2num(char(strs(1))));
                
 %%               sst
                        
                TM1(j,iv)=str2double(char(strs(3)))*vd_scale;
                TM2(j,iv)=str2double(char(strs(4)))*vd_scale;
                TM3(j,iv)=str2double(char(strs(5)))*vd_scale;  
                RM1(j,iv)=str2double(char(strs(6)));
                RM2(j,iv)=str2double(char(strs(7)));
                RM3(j,iv)=str2double(char(strs(8)));   
                            
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

for i=1:num_node_velox
 
    node=node_velox(i);
        
    output_TM1=sprintf('velox_%d_psd_T1',node);
    output_TM2=sprintf('velox_%d_psd_T2',node);            
    output_TM3=sprintf('velox_%d_psd_T3',node);         
    output_RM1=sprintf('velox_%d_psd_R1',node);
    output_RM2=sprintf('velox_%d_psd_R2',node);            
    output_RM3=sprintf('velox_%d_psd_R3',node); 
       
    assignin('base', output_TM1, [fn TM1(:,i)]);            
    assignin('base', output_TM2, [fn TM2(:,i)]); 
    assignin('base', output_TM3, [fn TM3(:,i)]);             
    assignin('base', output_RM1, [fn RM1(:,i)]);            
    assignin('base', output_RM2, [fn RM2(:,i)]); 
    assignin('base', output_RM3, [fn RM3(:,i)]); 
            
    output_TT=sprintf('%s\t %s\t %s',output_TM1,output_TM2,output_TM3);
    output_RR=sprintf('%s\t %s\t %s',output_RM1,output_RM2,output_RM3);
    disp(output_TT);
    disp(output_RR);   
end    

%%%%%%%%%%%%%%%%%


function find_displacement_nodes(hObject, eventdata, handles)
    
iu1=get(handles.listbox_input_unit,'Value');
iu2=get(handles.listbox_output_unit,'Value');   

scale=1;
    
if(iu1==1)
    if(iu2==1)
        scale=386^2;
    else
        scale=9.81^2;        
    end
end



    sarray=getappdata(0,'sarray');
    idd=getappdata(0,'idd');
    fn=getappdata(0,'fn');
    nf=getappdata(0,'nf');  
    
    disp('    ');
    disp(' Find displacement response nodes ');
        
    j=1;
    
    jk=1;
        
    iflag=0;
        
    
    for i=idd(1):idd(2)
                        
        ss=sarray{1}{i};
            
        k=strfind(ss, 'POINT ID.');
            
        if(~isempty(k))
                
                while(1) 
                    ss=sarray{1}{i+j};

                    if(length(ss)<=2)                          
                        iflag=1;
                        break;
                    else
                        strs = strsplit(ss,' ');
                        if( strcmp(char(strs(2)),'G'))
                            node_disp(jk)= str2double(strs(1));
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
   
   
%%%%%%%%% 


for i=1:num_node_disp
    j=node_disp(i);
    node_index(j)=i;
end



TM1=zeros(nf,num_node_disp);
TM2=zeros(nf,num_node_disp);
TM3=zeros(nf,num_node_disp);
RM1=zeros(nf,num_node_disp);
RM2=zeros(nf,num_node_disp);
RM3=zeros(nf,num_node_disp); 

vd_scale=getappdata(0,'vd_scale');

progressbar;
            
nndd=nf;
        

for j=1:nndd
                
    progressbar(j/nndd); 
            
    k1=idd(j);
                
    k=k1-1;
                
    while(1)
                    
        k=k+1;
                                        
        sst=sarray{1}{k};                    
                    
        ka=strfind(sst, 'POINT ID.');
            
        if(~isempty(ka))
                        
            for ijk=1:num_node_disp 
                sst=sarray{1}{k+ijk};
                strs = strsplit(sst,' ');
                iv=node_index(str2num(char(strs(1))));
                        
                TM1(j,iv)=str2double(char(strs(3)))*vd_scale;
                TM2(j,iv)=str2double(char(strs(4)))*vd_scale;
                TM3(j,iv)=str2double(char(strs(5)))*vd_scale;  
                RM1(j,iv)=str2double(char(strs(6)));
                RM2(j,iv)=str2double(char(strs(7)));
                RM3(j,iv)=str2double(char(strs(8)));   
                
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
        
    output_TM1=sprintf('disp_%d_psd_T1',node);
    output_TM2=sprintf('disp_%d_psd_T2',node);            
    output_TM3=sprintf('disp_%d_psd_T3',node);         
    output_RM1=sprintf('disp_%d_psd_R1',node);
    output_RM2=sprintf('disp_%d_psd_R2',node);            
    output_RM3=sprintf('disp_%d_psd_R3',node); 
       
    assignin('base', output_TM1, [fn TM1(:,i)]);            
    assignin('base', output_TM2, [fn TM2(:,i)]); 
    assignin('base', output_TM3, [fn TM3(:,i)]);             
    assignin('base', output_RM1, [fn RM1(:,i)]);            
    assignin('base', output_RM2, [fn RM2(:,i)]); 
    assignin('base', output_RM3, [fn RM3(:,i)]); 
            
    output_TT=sprintf('%s\t %s\t %s',output_TM1,output_TM2,output_TM3);
    output_RR=sprintf('%s\t %s\t %s',output_RM1,output_RM2,output_RM3);
    disp(output_TT);
    disp(output_RR);   
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


% --- Executes on selection change in listbox_input_unit.
function listbox_input_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_unit


nopt=get(handles.listbox_input_unit,'Value');


set(handles.listbox_output_unit, 'String', '');


if(nopt==1)
       string_th{1}=sprintf('G^2/Hz');   
       string_th{2}=sprintf('(in/sec^2)^2/Hz');        
       string_th{3}=sprintf('(m/sec^2)^2/Hz'); 
end
if(nopt==2)
       string_th{1}=sprintf('G^2/Hz');       
       string_th{2}=sprintf('(in/sec^2)^2/Hz'); 
end
if(nopt==3)
       string_th{1}=sprintf('(m/sec^2)^2/Hz'); 
end


additional_units(hObject, eventdata, handles)

set(handles.listbox_output_unit,'String',string_th)   




function additional_units(hObject, eventdata, handles)


set(handles.text_additional_unit,'Visible','off');
set(handles.listbox_additional_unit,'Visible','off');


n1=get(handles.listbox_input_unit,'Value');
n2=get(handles.listbox_output_unit,'Value');

if(n1==1 && n2==1)
    
    set(handles.text_additional_unit,'Visible','on');
    set(handles.listbox_additional_unit,'Visible','on');
    
end



% --- Executes during object creation, after setting all properties.
function listbox_input_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_plot_options.
function listbox_plot_options_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plot_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plot_options contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plot_options


% --- Executes during object creation, after setting all properties.
function listbox_plot_options_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plot_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function plot_acceleration(hObject, eventdata, handles)      
   

nopt=get(handles.listbox_plot_options,'Value');

fmin=getappdata(0,'fmin');
fmax=getappdata(0,'fmax');


nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_node_accel=getappdata(0,'num_node_accel');
node_accel=getappdata(0,'node_accel');


xlabel3='Freq (Hz)';


iu1=get(handles.listbox_input_unit,'Value');
iu2=get(handles.listbox_output_unit,'Value');


if(iu1==1)
    
    if(iu2==1)
        su='Accel (G^2/Hz)'; 
        sr='GRMS';        
    end
    if(iu2==2)
        su='Accel ((in/sec^2)^2/Hz)'; 
        sr='in RMS';         
    end
    if(iu2==3)
        su='Accel ((m/sec^2)^2/Hz)'; 
        sr='(m/sec^2) RMS';         
    end    
    
end
if(iu1==2)
    
    if(iu2==1)
        su='Accel (G^2/Hz)'; 
        sr='GRMS';        
    end
    if(iu2==2)
        su='Accel ((in/sec^2)^2/Hz)'; 
        sr='in RMS';         
    end

end
if(iu1==3)
    su='Accel ((m/sec^2)^2/Hz)';
    sr='(m/sec^2) RMS';
end


        
ylabel1=su;
ylabel2=su;
ylabel3=su;        

disp(' ');
disp(' Overall Acceleration Levels ');

for i=1:num_node_accel
            
    node=node_accel(i);
        
    output_T1=sprintf('accel_%d_psd_T1',node);
    output_T2=sprintf('accel_%d_psd_T2',node);            
    output_T3=sprintf('accel_%d_psd_T3',node);     
            
    data1=evalin('base',output_T1); 
    data2=evalin('base',output_T2); 
    data3=evalin('base',output_T3);  
    
             
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
    

    rms1=0;
    rms2=0;
    rms3=0;
   
    if( min(pdata1(:,2) > 0))
        [~,rms1] = calculate_PSD_slopes(pdata1(:,1),pdata1(:,2));
    end
    if( min(pdata2(:,2) > 0))
        [~,rms2] = calculate_PSD_slopes(pdata2(:,1),pdata2(:,2));
    end    
    if( min(pdata3(:,2) > 0))
        [~,rms3] = calculate_PSD_slopes(pdata3(:,1),pdata3(:,2));
    end
          
    t_string1=sprintf('PSD  Node %d T1  %7.3g %s',node,rms1,sr);
    t_string2=sprintf('PSD  Node %d T2  %7.3g %s',node,rms2,sr);
    t_string3=sprintf('PSD  Node %d T3  %7.3g %s',node,rms3,sr);    
    

    TT1=sprintf('  accel_%d_psd_T1   %7.3g %s',node,rms1,sr);
    TT2=sprintf('  accel_%d_psd_T2   %7.3g %s',node,rms2,sr);   
    TT3=sprintf('  accel_%d_psd_T3   %7.3g %s',node,rms3,sr);  
    
    
    if(nopt==1)
        ppp=pdata1;
        t_string=t_string1;
        disp(TT1);
    end        
    if(nopt==2)
        ppp=pdata2;     
        t_string=t_string2;
        disp(TT2);        
    end        
    if(nopt==3)
        ppp=pdata3;       
        t_string=t_string3; 
        disp(TT3);        
    end    
    if(nopt<=3)
        md=6;
        x_label=xlabel3;
        y_label=ylabel1;
        if(min(ppp(:,2))>0)
            [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
        else
            disp(' Plot not generated because minimum amplitude is zero ');           
        end
    else    
        [fig_num]=subplots_three_loglog_three_titles_ff(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,pdata1,pdata2,pdata3,t_string1,t_string2,t_string3,fmin,fmax);
        disp(TT1);
        disp(TT2);
        disp(TT3);         
    end
    
end
        

setappdata(0,'fig_num',fig_num);

%%%

function plot_velocity(hObject, eventdata, handles)      
   

nopt=get(handles.listbox_plot_options,'Value');

fmin=getappdata(0,'fmin');
fmax=getappdata(0,'fmax');

nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_node_velox=getappdata(0,'num_node_velox');
node_velox=getappdata(0,'node_velox');


xlabel3='Freq (Hz)';


su=getappdata(0,'velox_su');
sr=getappdata(0,'velox_sr');


ylabel1=su;
ylabel2=su;
ylabel3=su;      

disp(' ');
disp(' Overall Velocity Levels ');

        
for i=1:num_node_velox
            
    node=node_velox(i);
        
    output_T1=sprintf('velox_%d_psd_T1',node);
    output_T2=sprintf('velox_%d_psd_T2',node);            
    output_T3=sprintf('velox_%d_psd_T3',node);     
            
    data1=evalin('base',output_T1); 
    data2=evalin('base',output_T2); 
    data3=evalin('base',output_T3);  
    
             
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
    

    rms1=0;
    rms2=0;
    rms3=0;
   
    if( min(pdata1(:,2) > 0))
        [~,rms1] = calculate_PSD_slopes(pdata1(:,1),pdata1(:,2));
    end
    if( min(pdata2(:,2) > 0))
        [~,rms2] = calculate_PSD_slopes(pdata2(:,1),pdata2(:,2));
    end    
    if( min(pdata3(:,2) > 0))
        [~,rms3] = calculate_PSD_slopes(pdata3(:,1),pdata3(:,2));
    end   
          
    t_string1=sprintf('PSD  Node %d T1  %7.3g %s',node,rms1,sr);
    t_string2=sprintf('PSD  Node %d T2  %7.3g %s',node,rms2,sr);
    t_string3=sprintf('PSD  Node %d T3  %7.3g %s',node,rms3,sr);    
    
    TT1=sprintf('  velox_%d_psd_T1   %7.3g %s',node,rms1,sr);
    TT2=sprintf('  velox_%d_psd_T2   %7.3g %s',node,rms2,sr);   
    TT3=sprintf('  velox_%d_psd_T3   %7.3g %s',node,rms3,sr);      
    
    
    if(nopt==1)
        ppp=pdata1;
        t_string=t_string1;
        disp(TT1);
    end        
    if(nopt==2)
        ppp=pdata2;     
        t_string=t_string2;        
        disp(TT2);        
    end        
    if(nopt==3)
        ppp=pdata3;       
        t_string=t_string3;
        disp(TT3);       
    end    
    if(nopt<=3)
        md=6;
        x_label=xlabel3;
        y_label=ylabel1;
        if(min(ppp(:,2))>0)
            [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
        else
            disp(' Plot not generated because minimum amplitude is zero ');           
        end
    else    
        [fig_num]=subplots_three_loglog_three_titles_ff(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,pdata1,pdata2,pdata3,t_string1,t_string2,t_string3,fmin,fmax);
        disp(TT1);
        disp(TT2);
        disp(TT3);        
    end
    
end
        

setappdata(0,'fig_num',fig_num);

%%%

function plot_displacement(hObject, eventdata, handles)      
   

nopt=get(handles.listbox_plot_options,'Value');

fmin=getappdata(0,'fmin');
fmax=getappdata(0,'fmax');

nf=getappdata(0,'nf');


fig_num=getappdata(0,'fig_num');
num_node_disp=getappdata(0,'num_node_disp');
node_disp=getappdata(0,'node_disp');


xlabel3='Freq (Hz)';

su=getappdata(0,'disp_su');
sr=getappdata(0,'disp_sr');


ylabel1=su;
ylabel2=su;
ylabel3=su;        


disp(' ');
disp(' Overall Displacement Levels ');

        
for i=1:num_node_disp
            
    node=node_disp(i);
        
    output_T1=sprintf('disp_%d_psd_T1',node);
    output_T2=sprintf('disp_%d_psd_T2',node);            
    output_T3=sprintf('disp_%d_psd_T3',node);     
            
    data1=evalin('base',output_T1); 
    data2=evalin('base',output_T2); 
    data3=evalin('base',output_T3);  
    
             
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
    
   
    rms1=0;
    rms2=0;
    rms3=0;
   
    if( min(pdata1(:,2) > 0))
        [~,rms1] = calculate_PSD_slopes(pdata1(:,1),pdata1(:,2));
    end
    if( min(pdata2(:,2) > 0))
        [~,rms2] = calculate_PSD_slopes(pdata2(:,1),pdata2(:,2));
    end    
    if( min(pdata3(:,2) > 0))
        [~,rms3] = calculate_PSD_slopes(pdata3(:,1),pdata3(:,2));
    end
    
    
    t_string1=sprintf('PSD  Node %d T1  %7.3g %s',node,rms1,sr);
    t_string2=sprintf('PSD  Node %d T2  %7.3g %s',node,rms2,sr);
    t_string3=sprintf('PSD  Node %d T3  %7.3g %s',node,rms3,sr);    
    
    TT1=sprintf('  disp_%d_psd_T1   %7.3g %s',node,rms1,sr);
    TT2=sprintf('  disp_%d_psd_T2   %7.3g %s',node,rms2,sr);   
    TT3=sprintf('  disp_%d_psd_T3   %7.3g %s',node,rms3,sr);       
    
    
    if(nopt==1)
        ppp=pdata1;
        t_string=t_string1;
        disp(TT1);
    end        
    if(nopt==2)
        ppp=pdata2;     
        t_string=t_string2; 
        disp(TT2);        
    end        
    if(nopt==3)
        ppp=pdata3;       
        t_string=t_string3;
        disp(TT3);        
    end    
    if(nopt<=3)
        md=6;
        x_label=xlabel3;
        y_label=ylabel1;
        if(min(ppp(:,2))>0)
            [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
        else
            disp(' Plot not generated because minimum amplitude is zero ');           
        end
    else    
        [fig_num]=subplots_three_loglog_three_titles_ff(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,pdata1,pdata2,pdata3,t_string1,t_string2,t_string3,fmin,fmax);
        disp(TT1);
        disp(TT2);
        disp(TT3);        
    end
    
end
        

setappdata(0,'fig_num',fig_num);

%%%


% --- Executes on selection change in listbox_output_unit.
function listbox_output_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_unit

additional_units(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_output_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_additional_unit.
function listbox_additional_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_additional_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_additional_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_additional_unit


% --- Executes during object creation, after setting all properties.
function listbox_additional_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_additional_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
