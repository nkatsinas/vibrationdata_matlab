function varargout = vibrationdata_spl_batch(varargin)
% VIBRATIONDATA_SPL_BATCH MATLAB code for vibrationdata_spl_batch.fig
%      VIBRATIONDATA_SPL_BATCH, by itself, creates a new VIBRATIONDATA_SPL_BATCH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SPL_BATCH returns the handle to a new VIBRATIONDATA_SPL_BATCH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SPL_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SPL_BATCH.M with the given input arguments.
%
%      VIBRATIONDATA_SPL_BATCH('Property','Value',...) creates a new VIBRATIONDATA_SPL_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_spl_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_spl_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_spl_batch

% Last Modified by GUIDE v2.5 23-Jul-2019 14:57:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_spl_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_spl_batch_OutputFcn, ...
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


% --- Executes just before vibrationdata_spl_batch is made visible.
function vibrationdata_spl_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_spl_batch (see VARARGIN)

% Choose default command line output for vibrationdata_spl_batch
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_spl_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_spl_batch_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_spl_batch);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('  ');
disp(' * * * * * ');
disp('  ');

m=get(handles.listbox_unit,'Value');


if(m==1)
    ref = 2.9e-09;
end
if(m==2) 
    ref = 20.e-06;
end


try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
        
    N=get(handles.listbox_num,'Value');

    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
    end 
    
    for i=1:N
        leg{i}=A(k,:); k=k+1;
        leg{i} = strtrim(leg{i});
    end 
    
catch
    warndlg('Input Arrays read failed');
    return;
end

ext=get(handles.edit_extension,'String');
 
kv=N;

for ijk=1:kv
    
    output_array{ijk}=strcat(array_name{ijk},ext);
    
    THM=evalin('base',array_name{ijk}); 
    setappdata(0,'THM',THM);
    
    advise(hObject, eventdata, handles);

    tim=THM(:,1);
    amp=THM(:,2);
    tmi=tim(1);
%
    mu=mean(amp);
    amp=amp-mu;

%%%%%%%%

    io=2;  %   50% overlapp

    str=getappdata(0,'numsegments'); % number of segments

    dt=getappdata(0,'dt');

    n=length(tim);

    nv=getappdata(0,'idx');

    NW=str(nv);

    mmm = 2^fix(log(n/NW)/log(2));
%
    df=1/(mmm*dt);
%
    [mk,freq,~,~,NW]=FFT_time_freq_set(mmm,NW,dt,df,tmi,io);
%
    [store,~,~,~,~]=FFT_core_seg(NW,mmm,mk,freq,amp,io);                               
%
    store=store';
%
    sz=size(store);
    imax=sz(1);
    jmax=sz(2);
    full=zeros(imax,1);
    
    for i=1:imax
 %
        ms=0;  
        for j=1:jmax
            ms=ms+0.5*store(i,j)^2;
        end
 %
        full(i)=sqrt(ms/jmax);   % rms
    end
%
    full=sqrt(2)*full;  % peak
%
    [fl,fc,fu,~]=one_third_octave_frequencies();
%
    [band_rms]=convert_FFT_to_one_third(freq,fl,fu,full);                   
%
    [splevel,~]=convert_one_third_octave_mag_to_dB(band_rms,ref);
%
    [pf,pspl,~]=trim_acoustic_SPL(fc,splevel,ref);  
%
    pf=fix_size(pf);
    pspl=fix_size(pspl);

    SPL=[pf pspl];
    
    assignin('base', output_array{ijk}, SPL);
    
    n_type=1;
    
    f=pf;
    dB=pspl;
    
    tstring=leg{ijk};
    
    [fig_num]=spl_plot_title(fig_num,n_type,f,dB,tstring);    
    
end


disp(' ');
disp(' Output SPL arrays ');
disp(' ');

for ijk=1:kv 
    out1=sprintf('  %s',output_array{ijk});
    disp(out1);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function advise(hObject, eventdata, handles)
%

THM=getappdata(0,'THM');
t=THM(:,1);

n=length(t);
 
dur=t(n)-t(1);
dt=dur/(n-1);

NC=18;
%
ss=zeros(NC,1);
seg=zeros(NC,1);
i_seg=zeros(NC,1);
%
for i=4:NC
    ss(i) = 2^i;
    seg(i) =n/ss(i);
    i_seg(i) = fix(seg(i));
end
%
disp(' ');
out4 = sprintf(' Number of   Samples per   Time per    df');
out5 = sprintf('  Segments     Segment      Segment      ');
%
disp(out4)
disp(out5)
%
%
k=1;
for i=4:NC
    if( i_seg(i)>0)
        str(k) = (i_seg(i));
        tseg=dt*ss(i);
        ddf=1/tseg;
        out4 = sprintf(' \t  %d  \t  %d  \t   %6.3f  \t  %6.3f',str(k),ss(i),tseg,ddf);
        disp(out4)
        data(k,:)=[str(k),ss(i),tseg,ddf];
        k=k+1;
    end
end
%
 
[~,idx]=min(abs(data(:,4)-3)); 

setappdata(0,'numsegments',str);
setappdata(0,'dt',dt);
setappdata(0,'idx',idx);    
   
    
    
    



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num

Ncolumns=2;

Nrows=get(handles.listbox_num,'Value');
 
A=get(handles.uitable_data,'Data');

[data_s]=clear_data_s(Nrows);


if(~isempty(A))
    
    sz=size(A);
    Arows=sz(1);    
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s);


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
data_s=get(handles.uitable_data,'Data');

nd=get(handles.listbox_delete,'Value');


if(nd<=Nrows)
    
    temp=data_s;
    clear data_s;
    
    for j=1:Ncolumns
        data_s{1,j}='';    
    end
    
    for i=1:(nd-1)
        for j=1:Ncolumns
            try
                data_s{i,j}=temp{i,j};
            catch
            end        
        end    
    end  
    
    for i=(nd+1):Nrows
        for j=1:Ncolumns
            try
                data_s{i-1,j}=temp{i,j};
            catch
            end
            
        end    
    end      
    
    Nrows=Nrows-1;
    set(handles.listbox_num,'Value',Nrows);    
end
 
set(handles.uitable_data,'Data',data_s);
 
set(handles.listbox_num,'Value',Nrows);


% --- Executes on selection change in listbox_delete.
function listbox_delete_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_delete contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_delete


% --- Executes during object creation, after setting all properties.
function listbox_delete_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    num=get(handles.listbox_num,'value');
    SPLbatch.num=num;       
catch
end
try
    data=get(handles.uitable_data,'data');
    SPLbatch.data=data;       
catch
end
try
    unit=get(handles.listbox_unit,'Value');
    SPLbatch.unit=unit;
catch
end
try
    ext=get(handles.edit_extension,'String');
    SPLbatch.ext=ext;
catch
end




% % %
 
 structnames = fieldnames(SPLbatch, '-full'); % fields in the struct
  
% % %
 
    [writefname, writepname] = uiputfile('*.mat','Save data as');
 
    writepfname = fullfile(writepname, writefname);
    
    pattern = '.mat';
    replacement = '';
    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

try
    save(elk, 'SPLbatch'); 
catch
    warndlg('Save error');
    return;
end
 
out1=sprintf('Save Complete: %s',writefname);
disp(out1);
msgbox(out1);




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
   SPLbatch=evalin('base','SPLbatch');
catch
   warndlg(' evalin failed ');
   setappdata(0,'eflag',1);   
   return;
end

%%%%%%%%%%%%

try
    num=SPLbatch.num;     
    set(handles.listbox_num,'value',num);      
catch
end
try
    data=SPLbatch.data;       
    set(handles.uitable_data,'data',data);
catch
end
try
    unit=SPLbatch.unit;    
    set(handles.listbox_unit,'Value',unit);
catch
end
try
    ext=SPLbatch.ext;    
    set(handles.edit_extension,'String',ext);
catch
end



% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


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

function[data_s]=clear_data_s(Nrows)

    for i=1:Nrows
        data_s{i,1}='';
        data_s{i,2}='';
    end
