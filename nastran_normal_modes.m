function varargout = nastran_normal_modes(varargin)
% NASTRAN_NORMAL_MODES MATLAB code for nastran_normal_modes.fig
%      NASTRAN_NORMAL_MODES, by itself, creates a new NASTRAN_NORMAL_MODES or raises the existing
%      singleton*.
%
%      H = NASTRAN_NORMAL_MODES returns the handle to a new NASTRAN_NORMAL_MODES or the handle to
%      the existing singleton*.
%
%      NASTRAN_NORMAL_MODES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NASTRAN_NORMAL_MODES.M with the given input arguments.
%
%      NASTRAN_NORMAL_MODES('Property','Value',...) creates a new NASTRAN_NORMAL_MODES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nastran_normal_modes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nastran_normal_modes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nastran_normal_modes

% Last Modified by GUIDE v2.5 01-Jan-2018 15:43:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nastran_normal_modes_OpeningFcn, ...
                   'gui_OutputFcn',  @nastran_normal_modes_OutputFcn, ...
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


% --- Executes just before nastran_normal_modes is made visible.
function nastran_normal_modes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nastran_normal_modes (see VARARGIN)

% Choose default command line output for nastran_normal_modes
handles.output = hObject;

set(handles.text_dnode,'Visible','off');  % leave here
set(handles.edit_dnode,'Visible','off'); 

radiobutton_ev_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nastran_normal_modes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nastran_normal_modes_OutputFcn(hObject, eventdata, handles) 
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

delete(nastran_normal_modes);

function eigenvectors(hObject, eventdata, handles)

disp(' ');

nev=str2num(get(handles.edit_nev,'String'));

key_eigenvector=getappdata(0,'key_eigenvector');
num_grid=getappdata(0,'num_grid');
sarray=getappdata(0,'sarray');
num_fn=getappdata(0,'num_fn'); 

if(nev>num_fn)
    nev=num_fn;
end

ine = strfind(sarray{:},'R E A L   E I G E N V E C T O R   N O .');
ine = find(not(cellfun('isempty', ine)));

L=length(ine);

nh=zeros(L,1);

for i=1:L
    
 
    
    ss=sarray{1}{ine(i)};
    ss=strrep(ss,'R E A L   E I G E N V E C T O R   N O .','');
    strs = strsplit(ss,' ');  
    u=str2double(strs(4));
    nh(i)=u;
    
    
%%    out1=sprintf(' i=%d ine(i)=%d L=%d u=%d',i,ine(i),L,u);
%%    disp(out1);
    
end


if(L>1)
    
enode=get(handles.listbox_enode,'Value');
dnode=str2num(get(handles.edit_dnode,'String'));   

if(isempty(dnode))
    warndlg('Enter Node Number');
    return;
end


progressbar;

for ivk=1:nev
    
    progressbar(ivk/nev);
   
    eigenvector_n=zeros(num_grid,7); 

    out1=sprintf(' Extract Eigenvector %d ',ivk);
    disp(out1);
    
    kjk=1;
 
    iflag=0;
    
    istart = find(nh == ivk, 1, 'first');
    iend  = find(nh == ivk, 1, 'last');
    
%%    out1=sprintf(' ivk=%d  istart=%d  iend=%d  ',ivk,istart,iend);
%%    disp(out1);


    for i=ine(istart):ine(iend)
     
        ss=sarray{1}{i}; 
       
        mT1=strfind(ss, 'T1');
     
        if(~isempty(mT1))  
     
            j=i+1; 
         
            while(1)
         
                ss=sarray{1}{j}; 
                strs = strsplit(ss,' ');
            
                nu=str2double(strs(1));
                
                mb=strfind(ss, 'NASTRAN');
            
                if((nu>=1 && nu<=1.0e+07) && isempty(mb))
                    
%%                    out1=sprintf('ivk=%d i=%d nu=%d',ivk,i,nu);
%%                    disp(out1);
%%                    ss
                                  
                    T1=str2double(strs(3));
                    T2=str2double(strs(4));
                    T3=str2double(strs(5));
                    R1=str2double(strs(6));
                    R2=str2double(strs(7));
                    R3=str2double(strs(8));                 
                
                    eigenvector_n(kjk,:)=[nu T1 T2 T3 R1 R2 R3];
                    
                    if(enode==1)
                        
                        if(dnode==nu)
                        
                            disp(' ');
                            disp(' node     T1       T2       T3        R1        R2       R3');
                            out1=sprintf(' %d %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g',[nu T1 T2 T3 R1 R2 R3]);
                            disp(out1);
                            disp(' ');                           
                            
                        end

                    end
                    
                    if(kjk>=num_grid)
                        iflag=1;
                        break;
                    end    
                    kjk=kjk+1;
                
                end

                j=j+1;
            
            end    
         
        end   
        
        if(iflag==1)
            break;
        end        
     
    end

    if(max(max(abs(eigenvector_n)))>0)             
        output_ev=sprintf('eigenvector_%d',ivk);
        assignin('base',output_ev,eigenvector_n);  
    end
end

pause(0.2);
progressbar(1);

for ivk=1:nev
      
    output_ev=sprintf('eigenvector_%d',ivk);
    disp(output_ev);

end



end

% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

   disp('  ');
   disp(' * * * * * * * * * * * * * * ');
   disp('  ');
   
   tic
   
   fig_num=1;

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

rV_fn = get(handles.radiobutton_fn, 'Value');
rV_md = get(handles.radiobutton_md, 'Value');
rV_pf = get(handles.radiobutton_pf, 'Value');
rV_memf = get(handles.radiobutton_memf, 'Value');
rV_ev = get(handles.radiobutton_ev, 'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    skey='NUMBER OF ROOTS FOUND';
  
    inr = strfind(sarray{:},skey);
    inr = find(not(cellfun('isempty', inr)));
    
    if(isempty(inr))
        warndlg(' Number of Roots not found ');
        return;
    end
    
    k=inr(1);
   
    ss=sarray{1}{k};
    
    ss=strrep(ss,'.',''); 
    strs = strsplit(ss,' ');
    
    
    num_fn=round(str2double(strs(5)));
    setappdata(0,'num_fn',num_fn);
    
    out1=sprintf('\n Number of natural frequencies = %d ',num_fn);
    disp(out1);
 
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  skey='NUMBER OF GRID';
  
    ing = strfind(sarray{:},skey);
    ing = find(not(cellfun('isempty', ing)));
    
    if isempty(ing)
        disp(' Number of grid points ');
    end
    
    k=ing(1);
   
    ss=sarray{1}{k};
    
    ss=strrep(ss,'.',''); 
    strs = strsplit(ss,' ');
    
    num_grid=round(str2double(strs(6)));
    
    setappdata(0,'num_grid',num_grid);
    
    out1=sprintf('\n Number of grid points = %d ',num_grid);
    disp(out1);
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    fn=zeros(num_fn,1);
    pf=zeros(num_fn,6);
    memf=zeros(num_fn,6);    
    
    key_mem_fraction=0;
    key_modal_participation=0;
    key_eigenvalue=0; 
    key_eigenvector=0; 
   
    setappdata(0,'key_eigenvector',key_eigenvector);
       
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    skey='R E A L   E I G E N V A L U E S';
  
    inr = strfind(sarray{:},skey);
    inr = find(not(cellfun('isempty', inr)));
    
    if(isempty(inr))
        warndlg(' Real Eigenvalues not found');
        return;
    else
        disp(' Extract natural frequencies');         
        key_eigenvalue=1;
    end
    
    k=inr(1);
    k=k+1;
    
    ss=sarray{1}{k};
    
    mx=strfind(ss, 'MODE');    
    
    if(~isempty(mx))
        
        k=k+1;
        ss=sarray{1}{k};
        my=strfind(ss, 'NO.');
    
        if(~isempty(my))
            
            i=1;
            while(1)
                
                ss=sarray{1}{k+i};
                
                mq=strfind(ss, 'NASTRAN');
                
                if(isempty(mq))
                
                    strs = strsplit(ss,' ');
                
                    nu=str2double(strs(1));
                
                    if(nu>=1 && nu<=num_fn)
                
                        strs = strsplit(ss,' ');
                        fn(nu)=str2double(strs(5));
                
                        out1=sprintf('%d.  %8.4g',nu,fn(nu));
                        disp(out1);
                    
                        if(nu>=num_fn)
                            break;
                        end
                    
                    end 
                end   
                
                i=i+1;
                
            end
        end
        
    end   
            
    output_fn='natural_frequencies';
    assignin('base', output_fn,fn);         
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(rV_ev==1)

    eigenvectors(hObject, eventdata, handles);
 
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
if( rV_md==1)

    [fc,mdens]=modal_density_one_third_octave(fn);
    
    ppp=[fc,mdens];
    md=3;
    x_label='Center Frequency (Hz)';
    y_label='n (modes/Hz)';
    t_string='Modal Density';
    fmin=20;
    fmax=10000;

    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

    disp('  ');
    disp('   fc     Modal Density ');
    disp('  (Hz)     (modes/Hz)   ');

    for j=1:length(fc)
        out1=sprintf(' %8.1f  %8.4f  ',fc(j),mdens(j));
        disp(out1);
    end    

    disp('  ');
    output_md='modal_density';
    assignin('base', output_md, ppp);
    
end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
if( rV_pf==1)   
    
    disp(' ');
 
    skey='MODAL PARTICIPATION FACTORS';
  
    inr = strfind(sarray{:},skey);
    inr = find(not(cellfun('isempty', inr)));
    
    if(isempty(inr))
       disp(' Modal Participation Factor not found ');
    else
       disp(' Extract modal participation factors');        
       key_modal_participation=1;
    end
    
    k=inr(1);
    
    iflag=0;
    
    for ijk=1:20
    
      nijk=k+ijk;  
        
      ss=sarray{1}{nijk};
      mz=strfind(ss, 'NO.');
    
      if(~isempty(mz))     
          
            i=1;
          
            while(1)
                
                ss=sarray{1}{nijk+i};
                
                mq=strfind(ss, 'NASTRAN');
                
                if(isempty(mq))
                
                    strs = strsplit(ss,' ');
                
                    nu=str2double(strs(1));
                
                    if(nu>=1 && nu<=num_fn)
                
                        j=nu;
                        pf(j,1)=str2double(strs(3));
                        pf(j,2)=str2double(strs(4));
                        pf(j,3)=str2double(strs(5));
                        pf(j,4)=str2double(strs(6));
                        pf(j,5)=str2double(strs(7));
                        pf(j,6)=str2double(strs(8));            

                        if(nu>=num_fn )
                        
                            iflag=1;
                        
                            break;
                        end
                    
                    end   
                                    
                end
                
                i=i+1;
                
            end        
          
      end
      
      if(iflag==1)
          break;
      end
      
    end
          
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if( rV_memf==1)

    clear inr;
    
    skey='MODAL EFFECTIVE MASS FRACTION';
  
    inr = strfind(sarray{:},skey);
    inr = find(not(cellfun('isempty', inr)));
    
    if(isempty(inr))
        disp(' Modal Effective Mass Fraction not found ');
    else    
        disp(' Extract effective modal mass fractions ');
        key_mem_fraction=1;
    end
    
%% translation   
    
    for kv=1:length(inr)
        
        k=inr(kv);   
        iflag=0;
        
%        k
    
        ijk=1;

        while(1)
    
            nijk=k+ijk;  
        
            try
                ss=sarray{1}{nijk};
            catch
                break;
            end
      
            mzT1=strfind(ss, 'T1');
            mzT2=strfind(ss, 'T2');      
            mzT3=strfind(ss, 'T3'); 
            
            mzR1=strfind(ss, 'R1');
            mzR2=strfind(ss, 'R2');      
            mzR3=strfind(ss, 'R3');
            
            mb=strfind(ss, 'NASTRAN');
            mc=strfind(ss, 'POINT');
                        
            if(~isempty(mb) || ~isempty(mc))
                break;
            end             
                 
           
            
            if(~isempty(mzT1) || ~isempty(mzT2) || ~isempty(mzT3) || ~isempty(mzR1) || ~isempty(mzR2) || ~isempty(mzR3))  
               
                strsx = strsplit(ss,' ');
                
                nnn=length(strsx)-2;
                
                index=zeros(nnn,1);
                
                for i=1:nnn
                    
                    jj=i+2;
 %                   strsx(jj)
                    
                    a1=strfind(strsx(jj),'T1'); 
                    a2=strfind(strsx(jj),'T2');
                    a3=strfind(strsx(jj),'T3');
                    b1=strfind(strsx(jj),'R1');
                    b2=strfind(strsx(jj),'R2');
                    b3=strfind(strsx(jj),'R3');
  
                    aa1=a1{1,:};
                    aa2=a2{1,:};                   
                    aa3=a3{1,:};
                    
                    bb1=b1{1,:};
                    bb2=b2{1,:};                    
                    bb3=b3{1,:};                          
                    
 %                   whos aa1
                                if(aa1==1)
                                    index(i)=1;
                                end
                                if(aa2==1)                                  
                                    index(i)=2;
                                end
                                if(aa3==1)                                   
                                    index(i)=3;
                                end                               
                                if(bb1==1)                                
                                    index(i)=4;
                                end
                                if(bb2==1)                                   
                                    index(i)=5;
                                end
                                if(bb3==1)                                  
                                    index(i)=6;
                                end
                
                
                end
                
%                index'
                
                
                nijk= nijk+1;
                ss=sarray{1}{nijk};
                ma=strfind(ss, 'FRACTION');
            
%               out1=sprintf(' nijk=%d ',nijk);
%               disp(out1)

                if(~isempty(ma)) 
                    
                    i=1;
          
                    while(1)
                   
                        ss=sarray{1}{nijk+i};
                        strs = strsplit(ss,' ');
                
                        mb=strfind(ss, 'NASTRAN');
                        mc=strfind(ss, 'POINT');
                        
                        if(~isempty(mb) || ~isempty(mc))
                            break;
                        end    
                    
                        nu=str2double(strs(1));
                          
%%                        out1=sprintf('nijk+i=%d  nu=%g  num_fn=%d  ',(nijk+i),nu,num_fn);
%%                        disp(out1)
                        
                        i=i+1;
                        
                        if((nu>=1 && nu<=num_fn) && isempty(mb))
                            
                            strs = strsplit(ss,' ');
                            
                            sL=length(strs);
                            
                            kx=1;
                            
                            for jv=3:2:sL
                                
                                memf(nu,index(kx))=str2double(strs(jv));
                                
                                kx=kx+1;
                                
                            end
                            
%%                           memf(nu,:)
%%                           uuu=input(' enter number')
%%                         
%%                           return
                            
                            if(nu==num_fn)
                                break;
                            end
                             
                        end                            
                        
                    end         
                
                end                     
                
                  
            end            
            
            if(iflag==1)
                break;
            end
      
            ijk=ijk+1;           
            
        end        
        
    end
          
end


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
  nq=1:num_fn;
  nq=fix_size(nq);
  
  if(key_modal_participation==1 && rV_pf==1)

    pfa=abs(pf(:,1:3));
    pfb=abs(pf(:,4:6));    
    
    mma=max(max(pfa))/1000;
    mmb=max(max(pfb))/1000;    
      
    for i=1:num_fn
        for j=1:3
            if(abs(pf(i,j))<mma)
                pf(i,j)=0;
            end    
            if(abs(pf(i,j+3))<mmb)
                pf(i,j+3)=0;
            end    
        end       
    end  
         
      
    output_pf='participation_factors';
    assignin('base',output_pf,pf);  
                          
      
    hFig = figure(fig_num);
    fig_num=fig_num+1;
    xwidth=700;
    ywidth=600;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{27})
    
    BIG=[nq fn pf];
    
    dat =  BIG(:,1:8);
    columnname =   {'n','fn(Hz)','PF T1','PF T2','PF T3',...
       'PF R1','PF R2','PF R3' };
    columnformat = {'numeric','numeric', 'numeric','numeric','numeric','numeric',...
       'numeric','numeric'};
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
 
 end   
  
 %%%%%%   
 
 if(key_mem_fraction==1 && rV_memf==1)

     
     for i=1:num_fn
        for j=1:6
            if(memf(i,j)<1.0e-04)
                memf(i,j)=0;
            end    
        end
     end
     
   output_memf='mem_fraction';
   assignin('base',output_memf,memf); 
 
    hFig = figure(fig_num);
    fig_num=fig_num+1;
    xwidth=700;
    ywidth=600;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{27})

    BIG=[nq fn memf];
    
    
    dat =  BIG(:,1:8);
    columnname =   {'n','fn(Hz)','MEMF T1','MEMF T2','MEMF T3',...
       'MEMF R1','MEMF R2','MEMF R3' };
    columnformat = {'numeric', 'numeric','numeric','numeric','numeric',...
       'numeric','numeric','numeric'};
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
     
 end  
   
%%%%%%

disp(' ');
disp('Output arrays: ');
disp(' ');
  
if(key_eigenvalue==1 && rV_fn==1)
      disp(output_fn);     
end
if(key_eigenvalue==1 && rV_md==1)
      disp(output_md);      
end
if(key_modal_participation==1 && rV_pf==1)
      disp(output_pf);  
end
if(key_mem_fraction==1 && rV_memf==1)
      disp(output_memf);  
end

%%%%%%
 

%%%%%%
 

 
disp(' ');
toc

msgbox('Results written to Matlab Command Window');

  
  


% --- Executes on button press in radiobutton_fn.
function radiobutton_fn_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_fn


% --- Executes on button press in radiobutton_md.
function radiobutton_md_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_md


% --- Executes on button press in radiobutton_pf.
function radiobutton_pf_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_pf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_pf


% --- Executes on button press in radiobutton_memf.
function radiobutton_memf_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_memf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_memf


% --- Executes on button press in radiobutton_ev.
function radiobutton_ev_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_ev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_ev


set(handles.text_nev,'Visible','off');
set(handles.edit_nev,'Visible','off');    
    
set(handles.listbox_enode,'Visible','off'); 
set(handles.text_enode,'Visible','off');
    
set(handles.text_dnode,'Visible','off'); 
set(handles.edit_dnode,'Visible','off'); 
    

rV_ev = get(handles.radiobutton_ev, 'Value');


if(rV_ev==1)
    set(handles.text_nev,'Visible','on');
    set(handles.edit_nev,'Visible','on'); 
    
    set(handles.listbox_enode,'Visible','on'); 
    set(handles.text_enode,'Visible','on');  
    
    set(handles.text_dnode,'Visible','on'); 
    set(handles.edit_dnode,'Visible','on');
    
    set(handles.text_enode,'Visible','on'); 
    set(handles.listbox_enode,'Visible','on');     
   
end





function edit_nev_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nev as text
%        str2double(get(hObject,'String')) returns contents of edit_nev as a double


% --- Executes during object creation, after setting all properties.
function edit_nev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_enode.
function listbox_enode_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_enode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_enode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_enode

n=get(handles.listbox_enode,'Value');

rV_ev = get(handles.radiobutton_ev, 'Value');

set(handles.text_dnode,'Visible','off');
set(handles.edit_dnode,'Visible','off'); 


if(n==1 && rV_ev==1)
    set(handles.text_dnode,'Visible','on');
    set(handles.edit_dnode,'Visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_enode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_enode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dnode_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dnode as text
%        str2double(get(hObject,'String')) returns contents of edit_dnode as a double


% --- Executes during object creation, after setting all properties.
function edit_dnode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
