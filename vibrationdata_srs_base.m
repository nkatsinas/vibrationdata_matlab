function varargout = vibrationdata_srs_base(varargin)
% VIBRATIONDATA_SRS_BASE MATLAB code for vibrationdata_srs_base.fig
%      VIBRATIONDATA_SRS_BASE, by itself, creates a new VIBRATIONDATA_SRS_BASE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SRS_BASE returns the handle to a new VIBRATIONDATA_SRS_BASE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SRS_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SRS_BASE.M with the given input arguments.
%
%      VIBRATIONDATA_SRS_BASE('Property','Value',...) creates a new VIBRATIONDATA_SRS_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_srs_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_srs_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_srs_base

% Last Modified by GUIDE v2.5 24-Mar-2021 09:36:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_srs_base_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_srs_base_OutputFcn, ...
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


% --- Executes just before vibrationdata_srs_base is made visible.
function vibrationdata_srs_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_srs_base (see VARARGIN)

% Choose default command line output for vibrationdata_srs_base
handles.output = hObject;

listbox_time_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',2);

set(handles.edit_Q,'String','10');


set(handles.listbox_frequency_spacing,'Value',1);
set(handles.listbox_method,'Value',1);

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');

set(handles.uipanel_srs,'Visible','off');

listbox_method_Callback(hObject, eventdata, handles); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_srs_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_srs_base_OutputFcn(hObject, eventdata, handles) 
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

output_name=strtrim(get(handles.edit_output_array,'String'));

n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'accel_data'); 
end
if(n==2)
    data=getappdata(0,'p_vel_data');
end
if(n==3)
    data=getappdata(0,'rel_disp_data'); 
end
if(n==4)
    adata=getappdata(0,'accel_data'); 
end
if(n==5)
    adata=getappdata(0,'p_vel_data');
end
if(n==6)
    adata=getappdata(0,'rel_disp_data'); 
end
if(n==7)
    data=getappdata(0,'accel_rms');
end

if(n>=4 && n<=6)
       
    n=length(adata(:,1));
    
    for i=1:n
        data(i,:)=[adata(i,1) max([adata(i,2) adata(i,3)])];
    end  

end    
    
assignin('base', output_name, data);
      
  
h = msgbox('Save Complete'); 


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


% --- Executes on selection change in listbox_output_type.
function listbox_output_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_type


% --- Executes during object creation, after setting all properties.
function listbox_output_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
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

set(handles.uipanel_srs,'Visible','off');

n=get(handles.listbox_method,'Value');

set(handles.pushbutton_save,'Enable','off');
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

%%%%%

disp(' ');
disp(' ');
disp(' * * * * * ');
disp(' ');

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
 
if(NFigures>6)
    NFigures=6;
end
 
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


%%%%%

res=get(handles.listbox_residual,'Value');

fspace=get(handles.listbox_frequency_spacing,'Value');

set(handles.uipanel_srs,'Visible','off');

fig_num=1;

iu=get(handles.listbox_unit,'Value');

k=get(handles.listbox_method,'Value');

itu=get(handles.listbox_input_time_unit,'Value');

iflag=1;
 
if(k==1)
     try  
         FS=get(handles.edit_input_array,'String');
         THM=evalin('base',FS);  
         iflag=1;
     catch
         iflag=0; 
         warndlg('Input Array does not exist.  Try again.')
         return;
     end
else
  THM=getappdata(0,'THM');
end
 
if(iflag==0)
    return;
end 

ntime=get(handles.listbox_time,'Value');

if(ntime==2)
    tstart=str2num(get(handles.edit_start_time,'String'));
      tend=str2num(get(handles.edit_end_time,'String'));   
      
     [~,istart]=min(abs(tstart-THM(:,1)));      
       [~,iend]=min(abs(tend-THM(:,1)));      
       
    THM=THM(istart:iend,:);      
       
end

[THM,iflag]=time_check_with_linear_interpolation(THM);

if(iflag==999)
    return;
end


tor=THM(:,1);

if(itu==2)
   THM(:,1)=THM(:,1)/1000; 
end    

y=double(THM(:,2));
yy=y;


n=length(y);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);
sr=1/dt;

out1=sprintf(' sr=%8.4g   dt=%8.4g ',sr,dt);
disp(out1);

Q=str2num(get(handles.edit_Q,'String'));

fstart=str2num(get(handles.edit_start_frequency,'String'));
  fend=str2num(get(handles.edit_plot_fmax,'String'));
  
  
if(isempty(fstart))
   warndlg('Enter Min Plot Frequency');
   return;
end
if(isempty(fend))
   warndlg('Enter Max Plot Frequency');
   return;
end


  
if(fstart>=fend)
   warndlg('Frequency Limit Error');
   return; 
end
  
if(fstart==0)
   fstart=0.1; 
end

  
damp=1/(2*Q);


fmax=sr/5;

[fn,num]=srs_fn(fspace,fstart,fend,fmax);

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%  Initialize coefficients
%

try

    [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
                               
                               
catch
    out1=sprintf(' fspace=%d  fstart=%8.4g  fend=%8.4g  fmax=%8.4g',fspace,fstart,fend,fmax);
    disp(out1);
    size(fn)
    out1=sprintf(' damp=%8.4g  dt=%8.4g ',damp,dt);
    disp(out1);
    warndlg('srs_coefficients failed');
    return;
end
%
%
%  SRS engine
%

a_rms=zeros(num,1);
a_pos=zeros(num,1);
a_neg=zeros(num,1);
rd_pos=zeros(num,1);
rd_neg=zeros(num,1);
pv_pos=zeros(num,1);
pv_neg=zeros(num,1);

NL=length(yy);

progressbar;
for j=1:num
%
    progressbar(j/num); 
%
    if(res==1)
        ML=NL+round((1/fn(j))/dt);
        ys=zeros(ML,1);
        ys(1:NL)=yy;
    else
        ys=yy;
    end
%  
    [~,a_pos(j),a_neg(j),a_rms(j)]=arbit_engine_srs_vrs(a1(j),a2(j),b1(j),b2(j),b3(j),ys);
    

%
    [~,rd_pos(j),rd_neg(j)]=arbit_engine(rd_a1(j),rd_a2(j),rd_b1(j),rd_b2(j),rd_b3(j),ys);
%
    if(iu==1)
        scale_rd=386;
    else    
        scale_rd=9.81*1000;                
    end
    
    rd_pos(j)=rd_pos(j)*scale_rd;
    rd_neg(j)=rd_neg(j)*scale_rd;        
%
    omegan=2*pi*fn(j);
    pv_pos(j)=omegan*rd_pos(j);
    pv_neg(j)=omegan*rd_neg(j);    
%
    if(iu==2)
        pv_pos(j)=pv_pos(j)/10;
        pv_neg(j)=pv_neg(j)/10;
    end
%
end
%
pause(0.3);
progressbar(1);
%
a_neg=abs(a_neg);
pv_neg=abs(pv_neg);
rd_neg=abs(rd_neg);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
fn=fix_size(fn);
a_pos=fix_size(a_pos);
a_neg=fix_size(a_neg);
pv_pos=fix_size(pv_pos);
pv_neg=fix_size(pv_neg);
rd_pos=fix_size(rd_pos);
rd_neg=fix_size(rd_neg);
%
accel_rms=[fn a_rms];
accel_data=[fn a_pos a_neg];
p_vel_data=[fn pv_pos pv_neg];
rel_disp_data=[fn rd_pos rd_neg];
%
h=figure(fig_num);
fig_num=fig_num+1;
plot(tor,THM(:,2));
title('Base Input Acceleration Time History');

if(itu==1)
    xlabel(' Time (sec) ')
else
    xlabel(' Time (msec) ')    
end

if(iu==1 || iu==2)
    ylabel('Accel (G)')
else
    ylabel('Accel (m/sec^2)')    
end
grid on;


psave=get(handles.listbox_psave,'Value');


if(psave==1)
    
    disp(' Plot Files ');
    disp(' ');
    
    pname='base_input_th';
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
    out1=sprintf('   %s.png',pname);
    disp(out1);
       
end


plot_fmax=str2num(get(handles.edit_plot_fmax,'String'));

fmin=fstart;
fmax=fend;

t_string=sprintf('Acceleration SRS Q=%g',Q);

if(iu==1 || iu==2)
    y_lab='Peak Accel (G)';
else
    y_lab='Peak Accel (m/sec^2)';    
end


[fig_num,h]=srs_plot_function_h(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax);


if(psave==1)

    pname='accel_SRS';
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
    out1=sprintf('   %s.png',pname);
    disp(out1);
       
end


t_string=sprintf('Pseudo Velocity SRS Q=%g',Q);
if(iu==1)
    y_lab='Peak Vel (in/sec)';
else
    y_lab='Peak Vel (cm/sec)';    
end
[fig_num,h]=srs_plot_function_h(fig_num,fn,pv_pos,pv_neg,t_string,y_lab,fmin,fmax);

if(psave==1)

    
    pname='pseudo_vel_SRS';
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
    out1=sprintf('   %s.png',pname);
    disp(out1);
       
end


t_string=sprintf('Relative Displacement SRS Q=%g',Q);
if(iu==1)
    y_lab='Peak Rel Disp (in)';
else
    y_lab='Peak Rel Disp (mm)';    
end
[fig_num,h]=srs_plot_function_h(fig_num,fn,rd_pos,rd_neg,t_string,y_lab,fmin,fmax);

if(psave==1)

    
    pname='rel_disp_SRS';
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
    out1=sprintf('   %s.png',pname);
    disp(out1);
       
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'accel_rms',accel_rms);
setappdata(0,'accel_data',accel_data);   
setappdata(0,'p_vel_data',p_vel_data); 
setappdata(0,'rel_disp_data',rel_disp_data);   

set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array,'Enable','on');

n=length(fn);

for i=1:n
    if(fn(i)>plot_fmax)
        i=i-1;
        break;
    end
end

pv_srs=[fn(1:i) pv_pos(1:i) pv_neg(1:i) ];

[fig_num,h]=srs_tripartite_function_h(iu,fig_num,pv_srs,Q);

if(psave==1)

    pname='tripartite_SRS';
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
    out1=sprintf('   %s.png',pname);
    disp(out1);
       
end

set(handles.uipanel_srs,'Visible','on');

mfn=0;
maxa=0;

for i=1:length(fn)
    if( a_pos(i) > maxa)
        maxa=a_pos(i);
        mfn=fn(i);
    end
    if( a_neg(i) > maxa)
        maxa=a_neg(i);
        mfn=fn(i);
    end    
end

mfnv=0;
maxv=0;

for i=1:length(fn)
    if( pv_srs(i,2) > maxv)
        maxv=pv_srs(i,2);
        mfnv=fn(i);
    end
    if( pv_srs(i,3) > maxv)
        maxv=pv_srs(i,3);
        mfnv=fn(i);
    end    
end

yl='G';

if(iu==1)
    y2='in/sec';    
else 
    y2='cm/sec';      
end
disp(' ');
disp(' ******************* ');
disp(' ');
out1=sprintf(' Maximum Response  Q=%g',Q);
out2=sprintf('\n    Acceleration:  %8.4g Hz  %8.4g %s  ',mfn,maxa,yl);
out3=sprintf('  Pseudovelocity:  %8.4g Hz  %8.4g %s  \n',mfnv,maxv,y2);
disp(out1);
disp(out2);
disp(out3);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_srs_base)

% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
set(handles.uipanel_srs,'Visible','off');

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
set(handles.uipanel_srs,'Visible','off');


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_srs,'Visible','off');


% --- Executes on key press with focus on edit_start_frequency and none of its controls.
function edit_start_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_srs,'Visible','off');


% --- Executes on key press with focus on edit_plot_fmax and none of its controls.
function edit_plot_fmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_srs,'Visible','off');


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


% --- Executes on selection change in listbox_input_time_unit.
function listbox_input_time_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_time_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_time_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_time_unit


% --- Executes during object creation, after setting all properties.
function listbox_input_time_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_time_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_time.
function listbox_time_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_time contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_time

n=get(handles.listbox_time,'Value');

if(n==1)
    set(handles.edit_start_time,'Visible','off');
    set(handles.edit_end_time,'Visible','off');    
    set(handles.text_start_time,'Visible','off');
    set(handles.text_end_time,'Visible','off');       
else
    set(handles.edit_start_time,'Visible','on');
    set(handles.edit_end_time,'Visible','on');    
    set(handles.text_start_time,'Visible','on');
    set(handles.text_end_time,'Visible','on');           
end


% --- Executes during object creation, after setting all properties.
function listbox_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_start_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_time as text
%        str2double(get(hObject,'String')) returns contents of edit_start_time as a double


% --- Executes during object creation, after setting all properties.
function edit_start_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_time as text
%        str2double(get(hObject,'String')) returns contents of edit_end_time as a double


% --- Executes during object creation, after setting all properties.
function edit_end_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
