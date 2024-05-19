function varargout = acceleration_correction_batch(varargin)
% ACCELERATION_CORRECTION_BATCH MATLAB code for acceleration_correction_batch.fig
%      ACCELERATION_CORRECTION_BATCH, by itself, creates a new ACCELERATION_CORRECTION_BATCH or raises the existing
%      singleton*.
%
%      H = ACCELERATION_CORRECTION_BATCH returns the handle to a new ACCELERATION_CORRECTION_BATCH or the handle to
%      the existing singleton*.
%
%      ACCELERATION_CORRECTION_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACCELERATION_CORRECTION_BATCH.M with the given input arguments.
%
%      ACCELERATION_CORRECTION_BATCH('Property','Value',...) creates a new ACCELERATION_CORRECTION_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before acceleration_correction_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to acceleration_correction_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help acceleration_correction_batch

% Last Modified by GUIDE v2.5 12-Feb-2019 16:13:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @acceleration_correction_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @acceleration_correction_batch_OutputFcn, ...
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


% --- Executes just before acceleration_correction_batch is made visible.
function acceleration_correction_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to acceleration_correction_batch (see VARARGIN)

% Choose default command line output for acceleration_correction_batch
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);
listbox_channels_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes acceleration_correction_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);listbox_n_CreateFcn(hObject, eventdata, handles)


% --- Outputs from this function are returned to the command line.
function varargout = acceleration_correction_batch_OutputFcn(hObject, eventdata, handles) 
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

delete(acceleration_correction_batch)


function avd_engine(hObject, eventdata, handles)
    
    y=getappdata(0,'y');
    tt=getappdata(0,'tt');
    dt=getappdata(0,'dt'); 
    
%%


     fc=str2num(get(handles.edit_hpf,'String'));
    npe=str2num(get(handles.edit_npe,'String'));
    

    num=length(y);

    y=detrend(y);      
    [y]=Butterworth_filter_highpass_function(y,fc,dt);  
    
    [y]=half_cosine_fade_perc(y,npe);
 
    v=zeros(num,1);
    v(1)=y(1)*dt/2;
 
    for i=2:(num-1)
        v(i)=v(i-1)+y(i)*dt;
    end
    v(num)=v(num-1)+y(num)*dt/2;

    v=detrend(v);
    [v]=half_cosine_fade_perc(v,npe);

    d=zeros(num,1);
    d(1)=v(1)*dt/2;
 
    for i=2:(num-1)
        d(i)=d(i-1)+v(i)*dt;
    end
    d(num)=d(num-1)+v(num)*dt/2;
 
    d=fix_size(d);
    [d]=half_cosine_fade_perc(d,npe);
%
    n = 2;
    p = polyfit(tt,d,n);
    d= d - (  p(1)*tt.^2 + p(2)*tt + p(3));
    
    [d]=half_cosine_fade_perc(d,npe);

 %%%%%%%%%%%
    
    [vv]=differentiate_function(d,dt);
    [aa]=differentiate_function(vv,dt);     

%%
    
    setappdata(0,'q',aa);
    
    

function correct_avd(hObject, eventdata, handles)


    mchoice=getappdata(0,'mchoice');
    nchan=getappdata(0,'nchan');


    THM=getappdata(0,'THM');

    sz=size(THM);
    
    nrow=sz(1);    
    ncol=sz(2);
    
    if(mchoice==2 && nchan<ncol)
        ncol=nchan;
    end
    
    

    dt=(THM(nrow,1)-THM(1,1))/(nrow-1);
    
    ccc=zeros(nrow,ncol);
    
    ccc(:,1)=THM(:,1);
    
    tt=THM(:,1);
    
    setappdata(0,'tt',tt);
    setappdata(0,'dt',dt);   
    
    for i=2:ncol
        
 %       [q]=avd_engine(dt,tt,THM(:,i));
 
        y=THM(:,i);
        
        setappdata(0,'y',y);
 
        avd_engine(hObject, eventdata, handles);
    
        q=getappdata(0,'q');
        
        ccc(:,i)=q;
        
    end
    
    setappdata(0,'ccc',ccc);



%%%%%%


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    A=char(get(handles.uitable_data,'Data'));  
catch
    warndlg('Array name error');
    return;
end


disp(' ');
disp(' * * * * * ');
disp(' ');

nchan=0;  % leave as is

m=get(handles.listbox_channels,'Value');

if(m==2)
    nchan=str2num(get(handles.edit_nchan,'String'));    
end

setappdata(0,'mchoice',m);
setappdata(0,'nchan',nchan);



num=get(handles.listbox_num,'Value');



for i=1:num
    ss = strtrim(A(i,:)); 
    
    ssc=sprintf('%s_corrected',ss);
    
    sscc(i,:)=ssc;
    
    THM=evalin('base',ss);
    
    setappdata(0,'THM',THM);
    
%%    [ccc]=correct_avd(THM);  

    correct_avd(hObject, eventdata, handles);
    
    ccc=getappdata(0,'ccc');
    
    assignin('base',ssc, ccc); 
    
    aout=sprintf('%s.txt',ssc);
    
    save(aout,'ccc','-ASCII')
    
    sz=size(THM);
    ncol=sz(2);   
    
    if(m==2 && nchan<ncol)
        ncol=nchan;
    end
    
    for j=2:ncol
        
        sx=sprintf('%s_c%d',ss,(j-1));
        
        assignin('base',sx, [ccc(:,1) ccc(:,j)]); 
    end
    
    
end

disp(' ');
disp(' * * * * * ');
disp(' ');
disp('  Matlab arrays ');
disp(' ');

for i=1:num
    out1=sprintf('%s',sscc(i,:));
    disp(out1); 
end


disp(' ');
disp(' Multicolumn corrected files written as external ASCII text files.');
disp(' ');
disp(' Individual column files also written to Matlab workspace.');






% --- Executes on selection change in listbox_n.
function listbox_n_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_n contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_n

Nrows=get(handles.listbox_n,'Value');
Ncolumns=1;

set(handles.uitable_data,'Data',cell(Nrows,Ncolumns));

% --- Executes during object creation, after setting all properties.
function listbox_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
%        contents{get(hObject,'Value')} returns selected item from listbox

iflag=0;

try
    A=char(get(handles.uitable_data,'Data'));
    iflag=1;
    
catch
end
    
%%%%%%%%%%%%%%%%%


Nrows=get(handles.listbox_num,'Value');
Ncolumns=1;

headers1={'Array Name'};

set(handles.uitable_data,'Data',cell(Nrows,Ncolumns),'ColumnName',headers1);

%%%%%%%%%%%%%%%%%

m=Nrows;

if(iflag==1)
    
    sz=size(A);
    
    if(sz(1)>m)
        sz(1)=m;
    end
    
    for i = 1:m
       data_s{i,1} = ' ';
    end
    
    try

        for i = 1:sz(1)
            data_s{i,1} = strtrim(A(i,:));
        end

    catch
    end   

    set(handles.uitable_data,'Data',data_s);
        
end





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


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hpf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hpf as text
%        str2double(get(hObject,'String')) returns contents of edit_hpf as a double


% --- Executes during object creation, after setting all properties.
function edit_hpf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_npe_Callback(hObject, eventdata, handles)
% hObject    handle to edit_npe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_npe as text
%        str2double(get(hObject,'String')) returns contents of edit_npe as a double


% --- Executes during object creation, after setting all properties.
function edit_npe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_npe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_channels.
function listbox_channels_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_channels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_channels contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_channels


n=get(handles.listbox_channels,'Value');

if(n==1)
    set(handles.text_nchan,'Visible','off');
    set(handles.edit_nchan,'Visible','off');
else
    set(handles.text_nchan,'Visible','on');
    set(handles.edit_nchan,'Visible','on');    
end





% --- Executes during object creation, after setting all properties.
function listbox_channels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_channels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nchan_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nchan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nchan as text
%        str2double(get(hObject,'String')) returns contents of edit_nchan as a double


% --- Executes during object creation, after setting all properties.
function edit_nchan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nchan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
