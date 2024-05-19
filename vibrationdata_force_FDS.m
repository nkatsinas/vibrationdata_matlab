function varargout = vibrationdata_force_FDS(varargin)
% VIBRATIONDATA_FORCE_FDS MATLAB code for vibrationdata_force_FDS.fig
%      VIBRATIONDATA_FORCE_FDS, by itself, creates a new VIBRATIONDATA_FORCE_FDS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FORCE_FDS returns the handle to a new VIBRATIONDATA_FORCE_FDS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FORCE_FDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FORCE_FDS.M with the given input arguments.
%
%      VIBRATIONDATA_FORCE_FDS('Property','Value',...) creates a new VIBRATIONDATA_FORCE_FDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_force_FDS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_force_FDS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_force_FDS

% Last Modified by GUIDE v2.5 05-Aug-2014 11:11:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_force_FDS_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_force_FDS_OutputFcn, ...
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


% --- Executes just before vibrationdata_force_FDS is made visible.
function vibrationdata_force_FDS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_force_FDS (see VARARGIN)

% Choose default command line output for vibrationdata_force_FDS
handles.output = hObject;

set(handles.edit_Q,'String','10');

set(handles.listbox_method,'Value',1);
set(handles.listbox_engine,'Value',2);

set(handles.pushbutton_save_FDS,'Enable','off');
set(handles.edit_output_array_fds,'Enable','off');

listbox_force_unit_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_force_FDS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_force_FDS_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_force_FDS);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

ndof=1;

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


iu=get(handles.listbox_force_unit,'Value');

k=get(handles.listbox_method,'Value');

iflag=1;
 
if(k==1)
     try  
         FS=get(handles.edit_input_array,'String');
         THM=evalin('base',FS);  
         iflag=1;
     catch
         iflag=0; 
         warndlg('Input Array does not exist.  Try again.')
     end
else
  THM=getappdata(0,'THM');
end
 
if(iflag==0)
    return;
end 


y=double(THM(:,2));
yy=y;

force=y;


n=length(y);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);
sr=1/dt;

im=get(handles.listbox_metric,'Value');

num_eng=get(handles.listbox_engine,'Value');

Q=str2num(get(handles.edit_Q,'String'));

bex=str2num(get(handles.edit_bex,'String'));

dchoice=1.;

fstart=str2num(get(handles.edit_start_frequency,'String'));
fend=str2num(get(handles.edit_plot_fmax,'String'));

fmin=fstart;

damp=1/(2*Q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn(1)=fstart;

fmax=sr/8;

if fn(1)>sr/30.
    fn(1)=sr/30.;
end
%
j=1;
while(1)
    if (fn(j) > sr/8. || fn(j)>fend)
        break
    end
    fn(j+1)=fn(1)*(2. ^ (j*oct));
    j=j+1;
end
%
fn=fn';
%
n=length(fn);
%
damage=zeros(n,1);
%
pos=zeros(n,1);
neg=zeros(n,1);

num_eng=get(handles.listbox_engine,'Value');

mass=str2num(get(handles.edit_mass,'String'));
mass_orig=mass;

if(iu==1)
    mass=mass/386;
end

ff=force/mass;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

progressbar;
%
rm=zeros(n,1);
for i=1:n
    rm(i)=i;
end    
%
for ik=1:n
%
        if(ik>1)
            k=ceil(length(rm)*rand()); 
            i=rm(k);
        else
            i=1;
        end    
        rm(k)=[];
%
        progressbar(ik/n);
%
        omegan=2*pi*fn(i);
     
        if(im<=3)
            [a1,a2,df1,df2,df3,vf1,vf2,vf3,af1,af2,af3]=...
                   ramp_invariant_filter_coefficients(ndof,omegan,damp,dt);
        else
            [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                   srs_coefficients(fn(i),damp,dt);         
        end
%
        if(im==1) % acceleration
%
            a_forward=[   af1,  af2, af3 ];
            a_back   =[     1, -a1, -a2 ]; 
            y_resp=filter(a_forward,a_back,ff);
%        
            if(iu==1)
                y_resp=y_resp/386;
            end
            if(iu==2)
                y_resp=y_resp/9.81;
            end        
        end
%
        if(im==2) % velocity
            v_forward=[   vf1,  vf2, vf3 ];
            v_back   =[     1, -a1, -a2 ];
            y_resp=filter(v_forward,v_back,ff);      
        end
%
        if(im==3) % displacement
            d_forward=[   df1,  df2, df3 ];
            d_back   =[     1, -a1, -a2 ];
            y_resp=filter(d_forward,d_back,ff);        
            if(iu>=2)
                y_resp=y_resp*1000;
            end
        end
%
        if(im==4) % transmitted force
            back   =[     1, -a1, -a2 ];
            aa_forward=[ b1,  b2,  b3 ];
%    
            y_resp=filter(aa_forward,back,force);        
        end    
%
%%
%
        if(num_eng==1)
%
            [range_cycles]=vibrationdata_rainflow_function_basic(y_resp);
            D=0;
            sz=size(range_cycles);
            for iv=1:sz(1)
                D=D+range_cycles(iv,2)*( 0.5*range_cycles(iv,1) )^bex;
            end  
%
        else
%            
            [L,C,AverageAmp,MaxAmp,AverageMean,MinValley,MaxPeak,D]=rainflow_fds_mex(y_resp,dchoice,bex);              
%
        end    
%
%%        out1=sprintf(' %d %8.4g %8.4g \n',i,fn(i),D);
%%        disp(out1);
        damage(i)=D;
        pos(i)=max(y_resp);
        neg(i)=abs(min(y_resp));
%
end
pause(0.3)
progressbar(1);
%
fn=fix_size(fn);
pos=fix_size(pos);
neg=fix_size(neg);
damage=fix_size(damage);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

figure(fig_num);
fig_num=fig_num+1;
plot(THM(:,1),force);
grid on;
xlabel('Time (sec)');
if(iu==1)
    ylabel('Force (lbf)');    
else
    ylabel('Force (N)');
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
irp=im;

    disp(' ');
    disp(' The fatigue damage spectrum is (peak-valley)/2 ');
    if(irp==1)
       if(iu==1)
             out1 = sprintf(' Acceleration FDS mass=%g lbm Q=%g b=%g',mass_orig,Q,bex);
             out_srs = sprintf(' Acceleration SRS mass=%g kg Q=%g',mass_orig,Q);            
       else
             out1 = sprintf(' Acceleration FDS mass=%g kg Q=%g b=%g',mass_orig,Q,bex);
             out_srs = sprintf(' Acceleration SRS mass=%g kg Q=%g',mass_orig,Q);              
       end
       if(iu<=2) 
            ylab=sprintf('Damage Index (G^{ %g })',bex);
            ylab_srs='Peak Accel (G)';           
       else
            ylab=sprintf('Damage Index ((m/sec^2)^{ %g })',bex);
            ylab_srs='Peak Accel (m/sec^2)';                    
       end    
    end
    if(irp==2)
       if(iu==1) 
            out1 = sprintf(' Velocity FDS mass=%g lbm Q=%g b=%g',mass_orig,Q,bex);
            out_srs = sprintf(' Velocity SRS mass=%g lbm Q=%g',mass_orig,Q);             
            ylab=sprintf('Damage Index (ips^{ %g })',bex);  
            ylab_srs='Peak Vel (ips)';            
       else
            out1 = sprintf(' Velocity FDS mass=%g kg Q=%g b=%g',mass_orig,Q,bex); 
            out_srs = sprintf(' Velocity SRS mass=%g kg Q=%g',mass_orig,Q);             
            ylab=sprintf('Damage Index ((m/sec)^{ %g })',bex); 
            ylab_srs='Peak Vel (m/sec)';             
       end    
    end
    if(irp==3)
       if(iu==1)  
            out1 = sprintf(' Displacement FDS mass=%g lbm Q=%g b=%g',mass_orig,Q,bex);
            out_srs = sprintf(' Displacement SRS mass=%g lbm Q=%g',mass_orig,Q);            
            ylab=sprintf('Damage Index (in^{ %g })',bex);
            ylab_srs='Peak Disp (in)';             
       else
            out1 = sprintf(' Displacement FDS mass=%g kg Q=%g b=%g',mass_orig,Q,bex);
            out_srs = sprintf(' Displacement SRS mass=%g kg Q=%g',mass_orig,Q);                
            ylab=sprintf('Damage Index (mm^{ %g })',bex); 
            ylab_srs='Peak Disp (mm)';             
       end    
    end
    if(irp==4)
       if(iu==1)  
            out1 = sprintf(' Transmitted Force Fatigue Damage Spectrum Q=%g b=%g',Q,bex); 
            ylab=sprintf('Damage Index (lbf^{ %g })',bex);
            ylab_srs='Trans Force (lbf)';
            out_srs = sprintf(' Transmitted Force  Shock Response Spectrum Q=%g',Q);           
       else
            out1 = sprintf(' Transmitted Force Fatigue Damage Spectrum Q=%g b=%g',Q,bex); 
            ylab=sprintf('Damage Index (N^{ %g })',bex);
            ylab_srs='Trans Force (N)'; 
            out_srs = sprintf(' Transmitted Force  Shock Response Spectrum Q=%g',Q);            
       end    
    end    
%%
%%

    figure(fig_num);
    fig_num=fig_num+1;
    plot(fn,pos,fn,neg);
    legend ('positive','negative');
    xlabel('Natural Frequency (Hz)');
    grid on;
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
    title(out_srs);
    ymax=10^ceil(log10(max(pos)));
    ymin=10^floor(log10(min(pos)));
    if(ymin==ymax)
        ymin=ymax/10;
    end
    xlim([fmin fmax])
    ylim([ymin ymax])
    ylabel(ylab_srs);
%
    if(round(fmin)==20 && round(fmax)==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
    end
    if(round(fmin)==10 && round(fmax)==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
    end

%%
%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(fn,damage);
    xlabel('Natural Frequency (Hz)');
    grid on;
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
    title(out1);
    ymax=10^ceil(log10(max(damage)));
    mind=ymax;
    for i=1:n
        if(damage(i)>1.0e-08 && damage(i)<mind)
            mind=damage(i);
        end
    end
    ymin=10^floor(log10(mind));
    if(ymin==ymax)
        ymin=ymax/10;
    end
    if(ymin<ymax/1.0e+07)
        ymin=ymax/1.0e+07;
    end    
    xlim([fmin fmax])
    ylim([ymin ymax])    
    ylabel(ylab);
%
    if(round(fmin)==20 && round(fmax)==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
    end
    if(round(fmin)==10 && round(fmax)==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
    end
%     
    set(handles.edit_output_array_fds,'enable','on')
    set(handles.pushbutton_save_FDS,'enable','on')
%


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
fds_array=[fn damage];
setappdata(0,'fds',fds_array);

set(handles.pushbutton_save_FDS,'Enable','on');
set(handles.edit_output_array_fds,'Enable','on');


% --- Executes on button press in pushbutton_save_FDS.
function pushbutton_save_FDS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_FDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'fds');
output_name=get(handles.edit_output_array_fds,'String');
assignin('base', output_name, data);
 
h = msgbox('Save Complete'); 



function edit_output_array_fds_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_fds as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_fds as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_fds_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

n=get(hObject,'Value');

set(handles.pushbutton_save_FDS,'Enable','off');
set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end



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


% --- Executes on selection change in listbox_force_unit.
function listbox_force_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_unit

p=get(handles.listbox_force_unit,'Value');

if(p==1)
    set(handles.text_mass_label,'String','Mass (lbm)');
else
    set(handles.text_mass_label,'String','Mass (kg)');    
end



% --- Executes during object creation, after setting all properties.
function listbox_force_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function edit_bex_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bex as text
%        str2double(get(hObject,'String')) returns contents of edit_bex as a double


% --- Executes during object creation, after setting all properties.
function edit_bex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bex (see GCBO)
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


% --- Executes on selection change in listbox_metric.
function listbox_metric_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_metric contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_metric


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
