function varargout = vibrationdata_FDS_batch(varargin)
% VIBRATIONDATA_FDS_BATCH MATLAB code for vibrationdata_FDS_batch.fig
%      VIBRATIONDATA_FDS_BATCH, by itself, creates a new VIBRATIONDATA_FDS_BATCH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FDS_BATCH returns the handle to a new VIBRATIONDATA_FDS_BATCH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FDS_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FDS_BATCH.M with the given input arguments.
%
%      VIBRATIONDATA_FDS_BATCH('Property','Value',...) creates a new VIBRATIONDATA_FDS_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_FDS_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_FDS_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_FDS_batch

% Last Modified by GUIDE v2.5 31-May-2017 09:00:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_FDS_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_FDS_batch_OutputFcn, ...
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


% --- Executes just before vibrationdata_FDS_batch is made visible.
function vibrationdata_FDS_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_FDS_batch (see VARARGIN)

% Choose default command line output for vibrationdata_FDS_batch
handles.output = hObject;

set(handles.listbox_psave,'Value',1);
set(handles.listbox_plots,'Value',2);

set(handles.pushbutton_psd_envelope,'Visible','off');

listbox_ndc_Callback(hObject, eventdata, handles);
listbox_nfec_Callback(hObject, eventdata, handles);
listbox_plots_Callback(hObject, eventdata, handles);

%%%%    listbox_plots_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_FDS_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_FDS_batch_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on selection change in listbox_metric.
function listbox_metric_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_metric contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_metric
set(handles.pushbutton_psd_envelope,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_metric_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * ');
disp('  ');
 

nfont=10;
 
dchoice=1.;

x_label='Natural Frequency (Hz)';
 
try
    FS=get(handles.edit_input_array,'String');
    sarray=evalin('base',FS);
catch
    warndlg('Input string array not found.');
    return; 
end    
 
if(iscell(sarray)==0)
    warndlg('Input must be array of strings (class=cell)');  
    return;
end
 

num_eng=get(handles.listbox_engine,'Value');
 
np=get(handles.listbox_plots,'Value'); 
 
if(np==1)
 
    psave=get(handles.listbox_psave,'Value');    
    nfont=str2num(get(handles.edit_font_size,'String'));    
 
end    
 
kv=length(sarray);


%%%
 
ioct=get(handles.listbox_interpolation,'Value');
 
if(ioct==1)
    oct=1/3;
end
if(ioct==2)
    oct=1/6;
end
if(ioct==3)
    oct=1/12;
end
if(ioct==4)
    oct=1/24;
end

%%%
 
fstart=str2num(get(handles.edit_start_frequency,'String'));
  fend=str2num(get(handles.edit_plot_fmax,'String'));
 
%%%
 
fn(1)=fstart;
%
j=1;
while(1)
    fn(j+1)=fn(1)*(2. ^ (j*oct));
    
    if(fn(j+1)>fend)
        break;
    end
    
    j=j+1;
end

fn=fn(1:j);

if(fn(j)<fend)
    fn(j+1)=fend;
end


%
fn=fix_size(fn);
%
nfn=length(fn);
 

iu=get(handles.listbox_unit,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

n_damp=get(handles.listbox_ndc,'Value');          
ndc=n_damp;

Q(1)=str2num(get(handles.edit_Q1,'String'));

if(n_damp>=2)
    Q(2)=str2num(get(handles.edit_Q2,'String'));    
end    

damp=zeros(n_damp,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

for i=1:n_damp
    damp(i)=1/(2*Q(i));
    
    if(damp(i)>=1.0e-10 && damp(i)<=0.5)
    else
        warndlg('Q value error');
        out1=sprintf(' i=%d damp=%8.4g  Q=%8.4g ',i,damp(i),Q(i));
        disp(out1);
        return;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

n_bex=get(handles.listbox_nfec,'Value');         
nfe=n_bex;

bex(1)=str2num(get(handles.edit_b1,'String'));

if(n_bex==2)
    bex(2)=str2num(get(handles.edit_b2,'String'));    
end    




im=get(handles.listbox_metric,'Value');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
damage=zeros(kv,n_damp,n_bex);
total_damage=zeros(nfn,n_damp,n_bex);

disp(' ');
disp(' Calculating.  May be slow... ');
disp(' ');

ijk=1;

mm=(kv*n_damp*n_bex);

nout=mm*nfn;

progressbar;
 
for i=1:kv
    
    try
        sqqq=char(sarray(i,:));        
        THM=evalin('base',sqqq);

    catch
        warndlg(' Array input error ');
        return; 
    end
 
    t=double(THM(:,1));
    y=double(THM(:,2));
    
    n=length(y);
 
    dur=THM(n,1)-THM(1,1);
 
    dt=dur/(n-1);
    sr=1/dt;

    for iq=1:n_damp
    
       for j=1:nfn       
         
            if(im==1)
                [y_resp]=arbit_function_accel(fn(j),damp(iq),dt,y);   
            else
                [y_resp]=arbit_function_rd(fn(j),damp(iq),dt,y);
            end
%
            if(im==2) % pseudo velocity (approx)
%         
                [y_resp]=differentiate_function(y_resp,dt);
%
                if(iu==1)
                    y_resp=y_resp*386;
                else
                    y_resp=y_resp*9.81*1000;
                end
%
            end
%
            if(im==3) % relative displacement
                if(iu==1)
                    y_resp=y_resp*386;
                else
                    y_resp=y_resp*9.81*1000;
                end
            end        
        
            for ib=1:n_bex

                 progressbar(ijk/nout);
                 ijk=ijk+1;
  
%
                if(num_eng==1)
%
                    [range_cycles]=vibrationdata_rainflow_function_basic_np(y_resp);
                    D=0;
                    sz=size(range_cycles);
                    
                    for iv=1:sz(1)
                        D=D+range_cycles(iv,2)*( 0.5*range_cycles(iv,1) )^bex(ib);
                    end  
%
                else

%            
                    [ac1,ac2,nkv]=rainflow_basic_dyn_mex(y_resp);
            
                    D=0;
                    for iv=1:nkv
                        D=D+ac2(iv)*(ac1(iv))^bex;
                    end            
%
                end    
%
                damage(j,i,iq,ib)=D;
                total_damage(j,iq,ib)=total_damage(j,iq,ib)+D;
        
                out1=sprintf('%s fn=%8.4g  Q=%8.4g  b=%8.4g D=%8.4g',sqqq,fn(j),Q(iq),bex(ib),D);
                disp(out1);

            end
           
        end
     end
end     

pause(0.3);
progressbar(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
disp(' Saving data...');


fig_num=1;  % leave here

ijk=1;

for i=1:kv
       
    for iq=1:n_damp
        

        for ib=1:n_bex
                                 
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
       
                sx=char(sarray(i,:));
        
                if(im==1)
           
                    t_string=sprintf(' Acceleration FDS Q=%g b=%g \n %s',Q(iq),bex(ib),sx);
 
                    if(iu==1 || iu==2)
                        y_label=sprintf('Relative Damage (G^{%g})',bex(ib));
                    else
                        y_label=sprintf('Relative Damage (m/sec^2)^{%g}',bex(ib));   
                    end
            
                end
                if(im==2)
            
                    t_string=sprintf(' Pseudo Velocity FDS Q=%g b=%g \n %s',Q(iq),bex(ib),sx);
                    if(iu==1)
                        y_label=sprintf('Relative Damage (in/sec)^{%g}',bex(ib));
                    else
                        y_label=sprintf('Relative Damage (m/sec)^{%g}',bex(ib));
                    end
                
                end 
                if(im==3)
            
                    t_string=sprintf(' Relative Displacement FDS Q=%g b=%g \n %s',Q(iq),bex(ib),sx);
                    if(iu==1)
                        y_label=sprintf('Relative Damage (in^{%g})',bex(ib));
                    else
                        y_label=sprintf('Relative Damage (mm^{%g})',bex(ib));    
                    end
            
                end 
                
                   
                ww=zeros(nfn,1);
   
                for j=1:nfn
        
                    ww(j)=damage(j,i,iq,ib);
        
                end
        
                sdata=[fn ww];

                

                ppp=sdata;
                fmin=fstart;
                fmax=fend;
            
                
            if(np==1)                  
                
       
                t_string=strrep(t_string, '_',' ');
                
                [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
        
                set(gca,'Fontsize',nfont);
%        set(h2, 'Position', [20 20 550 450]);

        
                if(psave>1)
            
                    pname=char(sarray(i,:));  
       
                    sbex=sprintf('%g',bex(ib));
                    sbex=strrep(sbex, '.', 'p'); 
                    ext=sprintf('_Q%g_b%s',Q(iq),sbex);
                    pname=strcat(pname,ext);
                    
                    if(psave==2)
                        print(h2,pname,'-dmeta','-r300');
                        out1=sprintf('%s.emf',pname');
                    end  
                    if(psave==3)
                        print(h2,pname,'-dpng','-r300');
                        out1=sprintf('%s.png',pname');           
                    end
                    image_file{ijk}=out1;            
                    ijk=ijk+1;  
                end            
                
            end      
        end         
    end  
end

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 


if(np==1)
 
    if(psave>1)
        disp(' ');
        disp(' External Plot Names ');
        disp(' ');
               
        for i=1:mm
            out1=sprintf(' %s',image_file{i});
            disp(out1);
        end        
    end
        
end
 

disp('  ');
disp('  Individual Output Arrays ');
disp('  ');
 
for i=1:kv
   
    sqqq=char(sarray(i,:));     
    
    for iq=1:n_damp
        for ib=1:n_bex
    
               sbex=sprintf('%g',bex(ib));
               sbex=strrep(sbex, '.', 'p'); 
               ext=sprintf('_Q%g_b%s',Q(iq),sbex);
               vsqqq=strcat(sqqq,ext);
               
               ss=zeros(nfn,1);
               for j=1:nfn
                    ss(j)=damage(j,i,iq,ib);
               end
               
               assignin('base', vsqqq, [fn ss]);
               
               out1=sprintf('  %s',vsqqq);
               disp(out1);
        end
    end
end
 
output_name='fds_array';
    

disp(' ');
disp('Output array names stored in string array:');
disp(output_name);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Total damage arrays ');
disp(' ');


ijk=1;


for iq=1:n_damp
    for ib=1:n_bex

        sbex=sprintf('%g',bex(ib));
        sbex=strrep(sbex, '.', 'p'); 
        ext=sprintf('_Q%g_b%s',Q(iq),sbex);

        total_damage_string=sprintf('total_damage%s',ext);
        
        total_fds{ijk}=strcat('total_damage',ext);
        
        ijk=ijk+1;
        
        [y_label,t_string]=FDS_ylabel_title(Q,bex,iq,ib,im,iu);

        ppp=zeros(nfn,2);
        
        for j=1:nfn
            ppp(j,:)=[ fn(j) total_damage(j,iq,ib)];
        end

        [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

        sdata=ppp;

        assignin('base', total_damage_string, sdata);

        out1=sprintf('  %s',total_damage_string);
        disp(out1);
        
  
        
    end 
end    

%%%%%%%%%%%

md=10;

if(n_bex==1 && n_damp==2)
       
        ppp1=zeros(nfn,2);
        ppp2=zeros(nfn,2);        
        
        for j=1:nfn
            ppp1(j,:)=[ fn(j) total_damage(j,1,1)];
            ppp2(j,:)=[ fn(j) total_damage(j,2,1)];            
        end
        
        leg1=sprintf('Q=%g',Q(1));
        leg2=sprintf('Q=%g',Q(2));
        
        [y_label,t_string]=FDS_ylabel_title_2(bex,1,im,iu);
        
        [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
           
end

%%%%%%%%%%%


if(n_bex==2 && n_damp==1)
    
    data1=zeros(nfn,2);
    data2=zeros(nfn,2);     
    
    for j=1:nfn
        data1(j,:)=[ fn(j) total_damage(j,1,1)];
        data2(j,:)=[ fn(j) total_damage(j,1,2)];            
    end
    
    [ylabel1,t_string1]=FDS_ylabel_title(Q,bex,1,1,im,iu);
    [ylabel2,t_string2]=FDS_ylabel_title(Q,bex,1,2,im,iu);
    
    xlabel='Natural Frequency (Hz)';
    
    [fig_num,h2]=...
        subplots_two_loglog_1x2_h2(fig_num,xlabel,ylabel1,ylabel2,data1,data2,t_string1,t_string2,nfont);    
    
end    

%%%%%%%%%%%

if(n_bex==2 && n_damp==2)
    
    data11=zeros(nfn,2);
    data21=zeros(nfn,2);     

    data12=zeros(nfn,2);
    data22=zeros(nfn,2);
    
    for j=1:nfn
        data11(j,:)=[ fn(j) total_damage(j,1,1)];
        data21(j,:)=[ fn(j) total_damage(j,2,1)];  
        data12(j,:)=[ fn(j) total_damage(j,1,2)];
        data22(j,:)=[ fn(j) total_damage(j,2,2)];         
    end
    
    [ylabel1,t_string1]=FDS_ylabel_title_3(bex,1,im,iu);
    [ylabel2,t_string2]=FDS_ylabel_title_3(bex,2,im,iu);
    
    xlabel2='Natural Frequency (Hz)';
    
    leg11=sprintf('Q=%g',Q(1));
    leg21=sprintf('Q=%g',Q(2));
    leg12=sprintf('Q=%g',Q(1));
    leg22=sprintf('Q=%g',Q(2));
    
    [fig_num,h2]=subplots_two_loglog_2x2_h2(fig_num,xlabel2,...
                     ylabel1,ylabel2,data11,data21,data12,data22,...
                     leg11,leg21,leg12,leg22,t_string1,t_string2,nfont); 
end  


%% total_fds

setappdata(0,'iu',iu);
setappdata(0,'fds_metric',im);
setappdata(0,'Q',Q);
setappdata(0,'bex',bex);
setappdata(0,'total_fds',total_fds);
setappdata(0,'fmax',fmax);
setappdata(0,'fmin',fmin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

set(handles.pushbutton_psd_envelope,'Visible','on');

disp(' ');

msgbox('Calculation complete.  See Command Window');



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_FDS_batch)

% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
set(handles.pushbutton_psd_envelope,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_start_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_start_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_start_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plot_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plot_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_plot_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_plot_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_psd_envelope,'Visible','off');


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_start_frequency and none of its controls.
function edit_start_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_plot_fmax and none of its controls.
function edit_plot_fmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on listbox_unit and none of its controls.
function listbox_unit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency_spacing.
function listbox_frequency_spacing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_spacing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_spacing


% --- Executes during object creation, after setting all properties.
function listbox_frequency_spacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_residual.
function listbox_residual_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_residual contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_residual


% --- Executes during object creation, after setting all properties.
function listbox_residual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_extension_Callback(hObject, eventdata, handles)
% hObject    handle to edit_extension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_extension as text
%        str2double(get(hObject,'String')) returns contents of edit_extension as a double


% --- Executes during object creation, after setting all properties.
function edit_extension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_extension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_plots.
function listbox_plots_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plots contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plots

np=get(handles.listbox_plots,'Value');

if(np==1)

    set(handles.listbox_psave,'Visible','on');
    set(handles.text_export,'Visible','on');    
    
    set(handles.text_font_size,'Visible','on');
    set(handles.edit_font_size,'Visible','on');
   
else
    
    set(handles.listbox_psave,'Visible','off');
    set(handles.text_export,'Visible','off');
    
    set(handles.text_font_size,'Visible','off');
    set(handles.edit_font_size,'Visible','off');
end    


% --- Executes during object creation, after setting all properties.
function listbox_plots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_font_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_font_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_font_size as text
%        str2double(get(hObject,'String')) returns contents of edit_font_size as a double


% --- Executes during object creation, after setting all properties.
function edit_font_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_font_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_engine.
function listbox_engine_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_engine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_engine


% --- Executes during object creation, after setting all properties.
function listbox_engine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_interpolation.
function listbox_interpolation_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_interpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_interpolation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_interpolation
set(handles.pushbutton_psd_envelope,'Visible','off');

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


% --- Executes on selection change in listbox_nfec.
function listbox_nfec_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nfec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nfec contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nfec
set(handles.pushbutton_psd_envelope,'Visible','off');
n=get(handles.listbox_nfec,'Value');

if(n==1)
   set(handles.text_b2,'Visible','off'); 
   set(handles.edit_b2,'Visible','off');    
else
   set(handles.text_b2,'Visible','on'); 
   set(handles.edit_b2,'Visible','on');     
end

% --- Executes during object creation, after setting all properties.
function listbox_nfec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nfec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b1 as text
%        str2double(get(hObject,'String')) returns contents of edit_b1 as a double


% --- Executes during object creation, after setting all properties.
function edit_b1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b2 as text
%        str2double(get(hObject,'String')) returns contents of edit_b2 as a double


% --- Executes during object creation, after setting all properties.
function edit_b2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ndc.
function listbox_ndc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ndc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ndc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ndc
set(handles.pushbutton_psd_envelope,'Visible','off');
n=get(handles.listbox_ndc,'Value');

set(handles.text_Q2,'Visible','off'); 
set(handles.edit_Q2,'Visible','off');  


if(n>=2)
   set(handles.text_Q2,'Visible','on'); 
   set(handles.edit_Q2,'Visible','on');     
end
  



% --- Executes during object creation, after setting all properties.
function listbox_ndc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ndc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q2 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q2 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_psd_envelope.
function pushbutton_psd_envelope_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_psd_envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_envelope_fds_batch;

set(handles.s,'Visible','on');


% --- Executes on key press with focus on edit_Q1 and none of its controls.
function edit_Q1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_psd_envelope,'Visible','off');


% --- Executes on key press with focus on edit_Q2 and none of its controls.
function edit_Q2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_psd_envelope,'Visible','off');


% --- Executes on key press with focus on edit_b1 and none of its controls.
function edit_b1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_b1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_psd_envelope,'Visible','off');


% --- Executes on key press with focus on edit_b2 and none of its controls.
function edit_b2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_psd_envelope,'Visible','off');
