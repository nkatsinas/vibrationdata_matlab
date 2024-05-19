function varargout = FDS_time_history_synth_wavelets(varargin)
% FDS_TIME_HISTORY_SYNTH_WAVELETS MATLAB code for FDS_time_history_synth_wavelets.fig
%      FDS_TIME_HISTORY_SYNTH_WAVELETS, by itself, creates a new FDS_TIME_HISTORY_SYNTH_WAVELETS or raises the existing
%      singleton*.
%
%      H = FDS_TIME_HISTORY_SYNTH_WAVELETS returns the handle to a new FDS_TIME_HISTORY_SYNTH_WAVELETS or the handle to
%      the existing singleton*.
%
%      FDS_TIME_HISTORY_SYNTH_WAVELETS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FDS_TIME_HISTORY_SYNTH_WAVELETS.M with the given input arguments.
%
%      FDS_TIME_HISTORY_SYNTH_WAVELETS('Property','Value',...) creates a new FDS_TIME_HISTORY_SYNTH_WAVELETS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FDS_time_history_synth_wavelets_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FDS_time_history_synth_wavelets_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FDS_time_history_synth_wavelets

% Last Modified by GUIDE v2.5 30-Aug-2020 19:37:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FDS_time_history_synth_wavelets_OpeningFcn, ...
                   'gui_OutputFcn',  @FDS_time_history_synth_wavelets_OutputFcn, ...
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

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=3;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s);

listbox_num_Callback(hObject, eventdata, handles);

function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double


% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    M1=get(handles.edit_m1,'String');
    FDSsynth.M1=M1;
catch
end

try
    M2=get(handles.edit_m2,'String');
    FDSsynth.M2=M2;
catch
end

try
    M3=get(handles.edit_m3,'String');
    FDSsynth.M3=M3;
catch
end

try
    WTN=get(handles.edit_wavelet_table_name,'String');
    FDSsynth.WTN=WTN;
catch
end

try
    HW=get(handles.listbox_HW,'Value');
    FDSsynth.HW=HW;
catch
end

try
    data=get(handles.uitable_data,'Data');
    FDSsynth.data=data;
catch
end

try
    num=get(handles.listbox_num,'Value');
    FDSsynth.num=num;
catch
end

try
    T=get(handles.edit_T,'String');
    FDSsynth.T=T;
catch
end

try
    sr=get(handles.edit_sr,'String');
    FDSsynth.sr=sr;
catch
end

% % %
 
structnames = fieldnames(FDSsynth, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'FDSsynth'); 
 
    catch
        warndlg('Save error');
        return;
    end
 

    
    
    
% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat', 'Select plot save file');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
% struct
 
try
 
   FDSsynth=evalin('base','FDSsynth');
 
catch
   warndlg(' evalin failed ');
   return;
end
 
%%%%%%%%%%%%%%%%%%%%%

try
    M1=FDSsynth.M1;
    set(handles.edit_m1,'String',M1);
catch
end

try
    M2=FDSsynth.M2;
    set(handles.edit_m2,'String',M2);
catch
end

try
    M3=FDSsynth.M3;
    set(handles.edit_m3,'String',M3);
catch
end


try
    WTN=FDSsynth.WTN; 
    set(handles.edit_wavelet_table_name,'String',WTN);
catch
end

try
    HW=FDSsynth.HW; 
    set(handles.listbox_HW,'Value',HW);
catch
end

try
    num=FDSsynth.num;    
    set(handles.listbox_num,'Value',num);
    listbox_num_Callback(hObject, eventdata, handles);
catch
end

try
    data=FDSsynth.data;
    set(handles.uitable_data,'Data',data);
catch
end

try
    T=FDSsynth.T;    
    set(handles.edit_T,'String',T);
catch
end

try
    sr=FDSsynth.sr;    
    set(handles.edit_sr,'String',sr);
catch
end

% --- Executes just before FDS_time_history_synth_wavelets is made visible.
function FDS_time_history_synth_wavelets_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FDS_time_history_synth_wavelets (see VARARGIN)

% Choose default command line output for FDS_time_history_synth_wavelets
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FDS_time_history_synth_wavelets wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = FDS_time_history_synth_wavelets_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num


Nrows=get(handles.listbox_num,'Value');
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end 

 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end

if(Nrows==4)
    data_s{1,2}='10';
    data_s{2,2}='10';
    data_s{3,2}='30';
    data_s{4,2}='30';
    data_s{1,3}='4';
    data_s{2,3}='8';
    data_s{3,3}='4';
    data_s{4,3}='8';    
end

set(handles.uitable_data,'Data',data_s);

% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 delete(FDS_time_history_synth_wavelets);

function get_table(hObject, eventdata, handles)
%

   jflag=0;
   setappdata(0,'jflag',jflag);

   AA=get(handles.uitable_data,'Data');
   
   A=char(AA);

    N=get(handles.listbox_num,'Value');

    Q=zeros(N,1);
    bex=zeros(N,1);

    k=1;

    for i=1:N
        FDS_name{i}=A(k,:); k=k+1;
        FDS_name{i} = strtrim(FDS_name{i});
    end

    for i=1:N
        Q(i)=str2double(strtrim(A(k,:))); k=k+1;
    end

    for i=1:N
        bex(i)=str2double(strtrim(A(k,:))); k=k+1;
    end
    
    for i=1:N
        data_s{i,1}=FDS_name{i};
        data_s{i,2}=sprintf('%g',Q(i));
        data_s{i,3}=sprintf('%g',bex(i));      
    end
    
    set(handles.uitable_data,'Data',data_s);

% fds_ref
% fds_ref=zeros(n_dam,n_bex,n_ref);

num=N;

for i=1:num

    try
        FS=FDS_name{i};
        aq=evalin('base',FS);  
    catch
        out1=sprintf('FDS array not found: %d %s',i,FS);
        warndlg(out1);
        jflag=1;
        setappdata(0,'jflag',jflag);        
        return; 
    end
    
    if(isempty(aq))
        warndlg('FDS array is empty');
        jflag=1;
        setappdata(0,'jflag',jflag);       
        return;
    end
    
    if(i==1)
        fn=aq(:,1);
        n_ref=length(fn);
        fds_ref=zeros(n_ref,num);
    end
    
    if(length(aq(:,2))~=n_ref)
        warndlg('FDS length error');
        return;
    end
    
    try
       for k=1:n_ref
            fds_ref(k,i)=aq(k,2);
       end
    catch
        warndlg('FDS array error');
        jflag=1;
        setappdata(0,'jflag',jflag);        
        return;         
    end
    
end   

setappdata(0,'fn',fn);
setappdata(0,'N',N);
setappdata(0,'A',A);
setappdata(0,'AA',AA);
setappdata(0,'Q',Q);
setappdata(0,'bex',bex);
setappdata(0,'FDS_name',FDS_name);
setappdata(0,'n_ref',n_ref);    
setappdata(0,'fds_ref',fds_ref);



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


 % --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * ');
disp(' ');

%%%

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    

%%%%%%%%%%

m1=ceil(str2double(get(handles.edit_m1,'String')));
m2=ceil(str2double(get(handles.edit_m2,'String')));
mpa=1;

%%%%%%%%%%


output_name=get(handles.edit_output_array_name,'String');

if isempty(output_name)
   warndlg('Enter Output Name'); 
   return; 
end    


get_table(hObject, eventdata, handles);


jflag=getappdata(0,'jflag');
if(jflag==1)
    return;
end
 
fn=getappdata(0,'fn');
N=getappdata(0,'N');
A=getappdata(0,'A');
Q=getappdata(0,'Q');
bex=getappdata(0,'bex');
FDS_name=getappdata(0,'FDS_name');
fds_ref=getappdata(0,'fds_ref');

n_ref=length(fn);
n_cols=get(handles.listbox_num,'Value');

try
    f1=fn(1);
    f2=fn(end);
catch
    warndlg('fn failed');
    return;
end

T=str2num(get(handles.edit_T,'String'));
sr=str2num(get(handles.edit_sr,'String'));

if(sr<5*fn(end))
    sr
    fn(end)
    warndlg('Sample rate must be >= 5*maximum natural frequency');
    return;
end

%

dur=T;

dt=1/sr;

nt=floor(dur/dt);

t=zeros(nt,1);

for i=1:nt
    t(i)=(i-1)*dt;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


table_name=get(handles.edit_wavelet_table_name,'String');

if isempty(output_name)
   warndlg('Enter Output Name'); 
   return; 
end    

try
    xwavetable1=evalin('base',table_name);  
catch
    warndlg('Wavelet table read failed');
    return;
end


f=xwavetable1(:,2);
amp=xwavetable1(:,3);
NHS=xwavetable1(:,4);
td=xwavetable1(:,5);

num=length(f);


LL_Q10_b4=fds_ref(:,1);
LL_Q10_b8=fds_ref(:,2);
LL_Q30_b4=fds_ref(:,3); 
LL_Q30_b8=fds_ref(:,4);  

cage=zeros(num,1);

Lfn=length(fn);

for i=1:num
    
    [~,j]=min(abs(f(i)-fn));
    
    cage(i)=j;
        
end

yy=zeros(Lfn,4);

for i=1:Lfn
    
    yy(i,1)=LL_Q10_b4(i);
    yy(i,2)=LL_Q10_b8(i);
    yy(i,3)=LL_Q30_b4(i);
    yy(i,4)=LL_Q30_b8(i);

end
    
Qv = [10 30];
bv = [4 8];


zz=1.01;

err_max=1.0e+99;

[accel_input]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t);
[fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);
fdsr=fds;
accelr=accel_input;

ampx=amp;
ampr=amp;

ratio=1;


xi=1;

b1=1;
b2=4;

bb=linspace(b1,b2,m1);

disp(' ');
disp('phase 1a');

progressbar;


for ijk=1:m1
    
    progressbar(ijk/m1);
    
    amp=ampx*bb(ijk);

    [accel_input]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t);
    [fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);
    [err_max,ampr,fdsr,accelr]=fds_wavelet_error_check(err_max,ampr,fdsr,accelr,Lfn,yy,fds,amp,accel_input,ijk,xi);
end
progressbar(1);

amp=ampr;

bw=max(ampr)/max(ampx);

deltab=bb(2)-bb(1);
b1=bw-deltab;
b2=bw+deltab;

bb=linspace(b1,b2,m1);

disp(' ');
disp('phase 1b');

progressbar;

for ijk=1:m1
    
    progressbar(ijk/m1);
    
    amp=ampx*bb(ijk);

    [accel_input]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t);
    [fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);
    [err_max,ampr,fdsr,accelr]=fds_wavelet_error_check(err_max,ampr,fdsr,accelr,Lfn,yy,fds,amp,accel_input,ijk,xi);
end
progressbar(1);

amp=ampr;

bw=max(ampr)/max(ampx);

deltab=bb(2)-bb(1);
b1=bw-deltab;
b2=bw+deltab;

bb=linspace(b1,b2,m1);

disp(' ');
disp('phase 1c');

progressbar;

for ijk=1:m1
    
    progressbar(ijk/m1);
    
    amp=ampx*bb(ijk);

    [accel_input]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t);
    [fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);
    [err_max,ampr,fdsr,accelr]=fds_wavelet_error_check(err_max,ampr,fdsr,accelr,Lfn,yy,fds,amp,accel_input,ijk,xi);
end
progressbar(1);

amp=ampr;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



disp(' ');
disp('phase 2');

progressbar;

for ijk=1:m2

    progressbar(ijk/m2);

    if(ijk<=20 || rand()<0.5)
    
        [fdsr,ampr,accel_input,err_max]=fds_wavelet_random_adjustment(fdsr,ampr,accel_input,yy,num,err_max,accelr,...
                                                  Lfn,amp,ijk,NHS,td,nt,dur,t,fn,Qv,bv,dt,cage,f);  
    else
                                              
        [fdsr,ampr,accel_input,err_max,f,NHS,amp,td]=fds_add_wavelets(fdsr,ampr,accel_input,yy,num,err_max,accelr,...
                                                  Lfn,amp,ijk,NHS,td,nt,dur,t,fn,Qv,bv,dt,cage,f);                                           
    end
end                     

progressbar(1);
                                              
disp(' ');
disp(' Positive Adjust');
disp(' ');

[fdsr,ampr,accelr]=fds_wavelet_positive_adjust(fdsr,ampr,accelr,f,NHS,td,nt,dur,t,fn,Qv,bv,dt,yy,mpa);
%    
acceleration=[t,accelr];

figure(1);
plot(t,accelr);
grid on;
yl = ylim;
ya=max(abs(yl));
ylim([-ya,ya]);
xlabel('Time (sec)');
ylabel('Accel (G)');

xmin=fn(1);
xmax=fn(end);

y1=[fn LL_Q10_b4];
y2=[fn LL_Q10_b8];
y3=[fn LL_Q30_b4];
y4=[fn LL_Q30_b8];

FS21=[fn fdsr(:,1)];
FS22=[fn fdsr(:,2)];
FS23=[fn fdsr(:,3)];
FS24=[fn fdsr(:,4)];

Q=[10 10 30 30];
b=[4 8 4 8];

fig_num=2;
[fig_num]=plot_fds_subplots_2x2_two_curves_Qb(fig_num,y1,y2,y3,y4,FS21,FS22,FS23,FS24,xmin,xmax,Q,b);

try
    nn=zeros(length(f),1);
    
    for i=1:length(f)
        nn(i)=i;
    end
catch
end    


try
    WT=[nn f amp NHS td];
catch
    warndlg('fail: WT');    
    return;
end
   
try
    output_name_wavelet_table=sprintf('%s_wt',output_name'); 
    assignin('base', output_name_wavelet_table, WT);
catch
    warndlg('fail: output_name_wavelet_table');
    return;
end

try
    assignin('base', output_name, acceleration);

    h = msgbox('Save Complete'); 
catch
    warndlg('fail: output_name');
    return;
end

function fds_wavelet_error_check_Callback(hObject, eventdata, handles)
% hObject    handle to fds_wavelet_error_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fds_wavelet_error_check as text
%        str2double(get(hObject,'String')) returns contents of fds_wavelet_error_check as a double


% --- Executes during object creation, after setting all properties.
function fds_wavelet_error_check_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fds_wavelet_error_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_m1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m1 as text
%        str2double(get(hObject,'String')) returns contents of edit_m1 as a double


% --- Executes during object creation, after setting all properties.
function edit_m1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_m2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m2 as text
%        str2double(get(hObject,'String')) returns contents of edit_m2 as a double


% --- Executes during object creation, after setting all properties.
function edit_m2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_m3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m3 as text
%        str2double(get(hObject,'String')) returns contents of edit_m3 as a double


% --- Executes during object creation, after setting all properties.
function edit_m3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_wavelet_table_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wavelet_table_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wavelet_table_name as text
%        str2double(get(hObject,'String')) returns contents of edit_wavelet_table_name as a double


% --- Executes during object creation, after setting all properties.
function edit_wavelet_table_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wavelet_table_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
