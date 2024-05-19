function varargout = vibrationdata_vrs_base_pair(varargin)
% VIBRATIONDATA_VRS_BASE_PAIR MATLAB code for vibrationdata_vrs_base_pair.fig
%      VIBRATIONDATA_VRS_BASE_PAIR, by itself, creates a new VIBRATIONDATA_VRS_BASE_PAIR or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_VRS_BASE_PAIR returns the handle to a new VIBRATIONDATA_VRS_BASE_PAIR or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_VRS_BASE_PAIR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_VRS_BASE_PAIR.M with the given input arguments.
%
%      VIBRATIONDATA_VRS_BASE_PAIR('Property','Value',...) creates a new VIBRATIONDATA_VRS_BASE_PAIR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_vrs_base_pair_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_vrs_base_pair_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_vrs_base_pair

% Last Modified by GUIDE v2.5 05-Dec-2019 15:00:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_vrs_base_pair_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_vrs_base_pair_OutputFcn, ...
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


% --- Executes just before vibrationdata_vrs_base_pair is made visible.
function vibrationdata_vrs_base_pair_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_vrs_base_pair (see VARARGIN)

% Choose default command line output for vibrationdata_vrs_base_pair
handles.output = hObject;

listbox_calculate_Callback(hObject, eventdata, handles);

Nrows=2;
Ncolumns=3;

for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    
set(handles.uitable_data,'Data',data_s);


set(handles.edit_Q,'String','10');

set(handles.uipanel_save,'Visible','off');

listbox_calculate_Callback(hObject, eventdata, handles);
set(handles.pushbutton_calculate,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_vrs_base_pair wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_vrs_base_pair_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_vrs_base_pair);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

disp(' ');
disp(' * * * * * * * * * * * ');
disp(' ');

iu=get(handles.listbox_unit,'Value');
p=iu;


nfds=get(handles.listbox_calculate,'value');

idc=2;
bex=0;

if(nfds==2)
    bex=str2num(get(handles.edit_fatigue_exponent,'String'));
    idc=1;
end    

irp=get(handles.listbox_FDS_type,'value');



try
    
    data=get(handles.uitable_data,'Data');
    A=char(data);

    N=2;
    T=zeros(N,1);
    
    k=1;
    
    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
    end 
    for i=1:N
        leg{i}=A(k,:); k=k+1;
        leg{i} = strrep(leg{i},'_','');
        leg{i} = strtrim(leg{i});
    end
    for i=1:N
        dur{i}=A(k,:); k=k+1;
        dur{i} = strrep(dur{i},'_','');
        dur{i} = strtrim(dur{i});
        T(i)=str2double(dur{i});
    end    
catch
    warndlg(' ');
    return;
end


try
    THM_1=evalin('base',array_name{1});   
catch   
    FS
    warndlg('Input Filename 1 Error');
    return;
end

if(THM_1(:,1)<1.0e-20)
    THM_1(1,:)=[];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    THM_2=evalin('base',array_name{2});  
catch    
    FS
    warndlg('Input Filename 2 Error');
    return;
end

if(THM_2(:,1)<1.0e-20)
    THM_2(1,:)=[];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sminf=get(handles.edit_fmin,'String');
smaxf=get(handles.edit_fmax,'String');

if isempty(sminf)
    warndlg('Enter minimum frequency');
    return;    
end

if isempty(smaxf)
    warndlg('Enter maximum frequency');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q=str2num(get(handles.edit_Q,'String'));
damp=1/(2*Q);

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,input_rms_1] = calculate_PSD_slopes(THM_1(:,1),THM_1(:,2));
[~,input_rms_2] = calculate_PSD_slopes(THM_2(:,1),THM_2(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

df=0.5;
s=0;
%
f=THM_1(:,1);
a=THM_1(:,2);
[fi_1,ai_1]=interpolate_PSD(f,a,s,df);

dur=T(1);

[fn1,avrs1,pv_vrs1,rd_vrs1,damage1]=...
             vibrationdata_fds_vrs_engine(fi_1,ai_1,damp,df,p,idc,irp,bex,dur);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=THM_2(:,1);
a=THM_2(:,2);
[fi_2,ai_2]=interpolate_PSD(f,a,s,df);

dur=T(2);

[fn2,avrs2,pv_vrs2,rd_vrs2,damage2]=...
             vibrationdata_fds_vrs_engine(fi_2,ai_2,damp,df,p,idc,irp,bex,dur);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


avrs1=abs(avrs1);
avrs2=abs(avrs2);

fn1=fix_size(fn1);
fn2=fix_size(fn2);

avrs1=fix_size(avrs1);
avrs2=fix_size(avrs2);

accel_vrs_grms_1=[fn1 avrs1];
accel_vrs_grms_2=[fn2 avrs2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='Power Spectral Density';
x_label='Frequency (Hz)';

if(iu<=2)
    y_label='Accel (G^2/Hz)';
else
    y_label='Accel ((m/sec^2)^2/Hz)';    
end    

ppp=THM_1;
qqq=THM_2;


leg1=leg{1};
leg2=leg{2};

leg_a=sprintf('%s %6.3g GRMS',leg1,input_rms_1);
leg_b=sprintf('%s %6.3g GRMS',leg2,input_rms_2);

md=5;

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp,qqq,leg_a,leg_b,fmin,fmax,md);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
t_string = sprintf(' Acceleration Vibration Response Spectrum Q=%g ',Q);
x_label='Natural Frequency (Hz)';


if(iu<=2)
    y_label='Accel (GRMS)';
else
    y_label='Accel (m/sec^2 RMS)'; 
end  


md=5;


ppp1=accel_vrs_grms_1;
ppp2=accel_vrs_grms_2;

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
clear length;

L1=length(fn1);
accel_vrs_peak_1=zeros(L1,1);

ax=0.5;

for i=1:L1
    [ms]=risk_overshoot(fn1(i),T(1),ax);
    accel_vrs_peak_1(i)=ms*avrs1(i);
end


L2=length(fn2);
accel_vrs_peak_2=zeros(L2,1);

for i=1:L2
    [ms]=risk_overshoot(fn2(i),T(2),ax);    
    accel_vrs_peak_2(i)=ms*avrs2(i);
end

%%%%

t_string = sprintf(' Peak Acceleration Vibration Response Spectrum Q=%g ',Q);
x_label='Natural Frequency (Hz)';


if(iu<=2)
    y_label='Peak Accel (G)';
else
    y_label='Peak Accel (m/sec^2)'; 
end  


md=5;

fn1=abs(fn1);
fn2=abs(fn2);
accel_vrs_peak_1=abs(accel_vrs_peak_1);
accel_vrs_peak_2=abs(accel_vrs_peak_2);

ppp1=[ fn1 accel_vrs_peak_1];
ppp2=[ fn2 accel_vrs_peak_2];

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
             y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(idc==1)
%
    disp(' ');
    disp(' The fatigue damage spectrum is (peak-valley)/2 ');
    if(irp==1)
       out1 = sprintf(' Acceleration Fatigue Damage Spectrum Q=%g b=%g',Q,bex);
       if(iu<=2)
           ylab=sprintf('Damage Index [log10(G^{ %g })]',bex);
       else
           ylab=sprintf('Damage Index [log10((m/sec^2)^{ %g })]',bex);           
       end    
    end
    if(irp==2)
       if(iu==1) 
            out1 = sprintf(' Pseudo Velocity Fatigue Damage Spectrum Q=%g b=%g',Q,bex);
            ylab=sprintf('Damage Index [log10(ips^{ %g })]',bex);             
       else
            out1 = sprintf(' Pseudo Velocity Fatigue Damage Spectrum Q=%g b=%g',Q,bex);           
            ylab=sprintf('Damage Index [log10((m/sec)^{ %g })]',bex);         
       end    
    end
    if(irp==3)
       if(iu==1)  
            out1 = sprintf(' Relative Disp Fatigue Damage Spectrum Q=%g b=%g',Q,bex); 
            ylab=sprintf('Damage Index [log10(in^{ %g })]',bex);
       else
            out1 = sprintf(' Relative Disp Fatigue Damage Spectrum Q=%g b=%g',Q,bex); 
            ylab=sprintf('Damage Index [log10(mm^{ %g })]',bex);            
       end    
    end
%
    ppp=[ fn1 damage1];
    qqq=[ fn2 damage2];

    leg_a=leg1;
    leg_b=leg2;
    
    y_label=ylab;
    x_label='Natural Frequency (Hz)';
    
    tstring=out1;
   
    [fig_num,h2]=plot_fds_two_alt_h2(fig_num,x_label,y_label,ppp,qqq,leg_a,leg_b,tstring,fmin,fmax);

%     
%    set(handles.edit_output_array_fds,'enable','on')
%    set(handles.pushbutton_save_FDS,'enable','on')
%
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'accel_vrs_grms_1',accel_vrs_grms_1);
setappdata(0,'accel_vrs_grms_2',accel_vrs_grms_2);

setappdata(0,'accel_vrs_peak_1',accel_vrs_peak_1);
setappdata(0,'accel_vrs_peak_2',accel_vrs_peak_2);

if(nfds==2)
    setappdata(0,'damage1',damage1);
    setappdata(0,'damage2',damage2);
end 

set(handles.uipanel_save,'Visible','on');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_type,'Value');


if(n==1)
    data_1=getappdata(0,'accel_vrs_grms_1');
    data_2=getappdata(0,'accel_vrs_grms_2');
end
if(n==2)
    data_1=getappdata(0,'accel_vrs_peak_1');
    data_2=getappdata(0,'accel_vrs_peak_2');    
end
if(n==3)
    data_1=getappdata(0,'damage1');
    data_2=getappdata(0,'damage2');    
end

    
output_name_1=get(handles.edit_output_array_1,'String');
output_name_2=get(handles.edit_output_array_2,'String');

assignin('base', output_name_1, data_1);
assignin('base', output_name_2, data_2);

msgbox('Save Complete'); 


function edit_output_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_1 (see GCBO)
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

%%% set(handles.pushbutton_calculate,'Enable','off');

n=get(handles.listbox_method,'Value');


set(handles.edit_output_array_1,'Enable','off');

set(handles.pushbutton_save,'Enable','off');

set(handles.edit_input_array_1,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array_1,'Visible','on');

if(n==1)
   set(handles.edit_input_array_1,'enable','on') 
else
   set(handles.edit_input_array_1,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array_1,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
   
   set(handles.pushbutton_calculate,'Enable','on');
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



function edit_input_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

set(handles.uipanel_save,'Visible','off');
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



function edit_dur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur as text
%        str2double(get(hObject,'String')) returns contents of edit_dur as a double


% --- Executes during object creation, after setting all properties.
function edit_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_sigma.
function listbox_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_sigma contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_sigma


% --- Executes during object creation, after setting all properties.
function listbox_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_amp.
function listbox_output_amp_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_amp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_amp


% --- Executes during object creation, after setting all properties.
function listbox_output_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_VRS.
function pushbutton_VRS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_VRS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_calculate.
function listbox_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_calculate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_calculate

% set(handles.edit_output_array_fds,'enable','off')
% set(handles.pushbutton_save_FDS,'enable','off')
set(handles.uipanel_save,'Visible','off');
n=get(handles.listbox_calculate,'value');

set(handles.listbox_output_type,'String',' ')
string_th{1}=sprintf('VRS RMS');
string_th{2}=sprintf('VRS Peak');

if(n==1)
    set(handles.text_fatigue_exponent,'visible','off');
    set(handles.edit_fatigue_exponent,'visible','off');
    set(handles.text_fatigue_type,'visible','off');
    set(handles.listbox_FDS_type,'visible','off');    

else
    set(handles.text_fatigue_exponent,'visible','on');
    set(handles.edit_fatigue_exponent,'visible','on');  
    set(handles.text_fatigue_type,'visible','on');
    set(handles.listbox_FDS_type,'visible','on');     
    string_th{3}=sprintf('FDS');
end

set(handles.listbox_output_type,'String',string_th);
set(handles.listbox_output_type,'Value',1);



% --- Executes during object creation, after setting all properties.
function listbox_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fatigue_exponent_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fatigue_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fatigue_exponent as text
%        str2double(get(hObject,'String')) returns contents of edit_fatigue_exponent as a double


% --- Executes during object creation, after setting all properties.
function edit_fatigue_exponent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fatigue_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_FDS_type.
function listbox_FDS_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_FDS_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_FDS_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_FDS_type
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_FDS_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_FDS_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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



function edit_input_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_legend_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_legend_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_legend_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_legend_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_legend_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_legend_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_legend_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_legend_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_legend_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_legend_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_legend_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_legend_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox15_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


% --- Executes during object creation, after setting all properties.
function listbox15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on key press with focus on edit_fatigue_exponent and none of its controls.
function edit_fatigue_exponent_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fatigue_exponent (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');
