function varargout = FDS_time_history_synth(varargin)
% FDS_TIME_HISTORY_SYNTH MATLAB code for FDS_time_history_synth.fig
%      FDS_TIME_HISTORY_SYNTH, by itself, creates a new FDS_TIME_HISTORY_SYNTH or raises the existing
%      singleton*.
%
%      H = FDS_TIME_HISTORY_SYNTH returns the handle to a new FDS_TIME_HISTORY_SYNTH or the handle to
%      the existing singleton*.
%
%      FDS_TIME_HISTORY_SYNTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FDS_TIME_HISTORY_SYNTH.M with the given input arguments.
%
%      FDS_TIME_HISTORY_SYNTH('Property','Value',...) creates a new FDS_TIME_HISTORY_SYNTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FDS_time_history_synth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FDS_time_history_synth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FDS_time_history_synth

% Last Modified by GUIDE v2.5 28-Aug-2020 13:05:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FDS_time_history_synth_OpeningFcn, ...
                   'gui_OutputFcn',  @FDS_time_history_synth_OutputFcn, ...
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


% --- Executes just before FDS_time_history_synth is made visible.
function FDS_time_history_synth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FDS_time_history_synth (see VARARGIN)

% Choose default command line output for FDS_time_history_synth
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FDS_time_history_synth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FDS_time_history_synth_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    


output_name=get(handles.edit_output_array_name,'String');

if isempty(output_name)
   warndlg('Enter Output Name'); 
   return; 
end    

HW=get(handles.listbox_HW,'Value');

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

dt=1/sr;

nt=floor(T/dt);

t=zeros(nt,1);

for i=1:nt
    t(i)=(i-1)*dt;
end

nf=length(fn);
%                  

a=zeros(nt,1);

b=bex;


try
    if(n_cols==1)
        [a,fds]=fds_synth_one(Q,b,fds_ref,fn,nf,dt,T,t,HW);
    end
    if(n_cols==4)
        if(Q(1)==Q(2) && Q(3)==Q(4) && b(1)==b(3) && b(2)==b(4))
            try
                [a,fds]=fds_synth_four(Q,b,fds_ref,fn,nf,dt,T,t,HW);
            catch
                warndlg('fds_synth_four error');
                return;
            end
        end
    end
    if(n_cols~=1 && n_cols~=4)
        msgbox('Option to be added in next revision');
        return;
    end
catch
    warndlg('fds error');
    return;
end


figure(1)
plot(t,a);
out=sprintf('Synthesized Time History  %7.3g GRMS ',std(a));
title(out);
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
yl = ylim;
ya=max(abs(yl));
ylim([-ya,ya]);


xmin=fn(1);
xmax=fn(end);

b=bex;

fig_num=2;

y1=[fn fds_ref(:,1)];
FS21=[fn fds(:,1)];

if(n_cols==1)
    [fig_num]=plot_fds_subplots_1x1_two_curves_Qb(fig_num,y1,FS21,xmin,xmax,Q,b);
end    
if(n_cols==2)
    msgbox('FDS plot to be added in next revision');
end    
if(n_cols==3)
    msgbox('FDS plot to be added in next revision');
end    

if(n_cols==4)
    y2=[fn fds_ref(:,2)];
    y3=[fn fds_ref(:,3)];
    y4=[fn fds_ref(:,4)];
    FS22=[fn fds(:,2)];
    FS23=[fn fds(:,3)];
    FS24=[fn fds(:,4)];
    [fig_num]=plot_fds_subplots_2x2_two_curves_Qb(fig_num,y1,y2,y3,y4,FS21,FS22,FS23,FS24,xmin,xmax,Q,b);
end

setappdata(0,'new_th',[t a]);
setappdata(0,'fds',[fn fds]);

try
    assignin('base', output_name, [t a]);

    h = msgbox('Save Complete'); 
catch
    warndlg('fail: output_name');
    return;
end



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 delete(FDS_time_history_synth);

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


% --- Executes on selection change in listbox_HW.
function listbox_HW_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_HW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_HW contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_HW


% --- Executes during object creation, after setting all properties.
function listbox_HW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_HW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
