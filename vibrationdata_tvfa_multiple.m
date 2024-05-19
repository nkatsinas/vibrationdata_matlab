function varargout = vibrationdata_tvfa_multiple(varargin)
% VIBRATIONDATA_TVFA_MULTIPLE MATLAB code for vibrationdata_tvfa_multiple.fig
%      VIBRATIONDATA_TVFA_MULTIPLE, by itself, creates a new VIBRATIONDATA_TVFA_MULTIPLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TVFA_MULTIPLE returns the handle to a new VIBRATIONDATA_TVFA_MULTIPLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TVFA_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TVFA_MULTIPLE.M with the given input arguments.
%
%      VIBRATIONDATA_TVFA_MULTIPLE('Property','Value',...) creates a new VIBRATIONDATA_TVFA_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_tvfa_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_tvfa_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_tvfa_multiple

% Last Modified by GUIDE v2.5 16-Oct-2019 11:57:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_tvfa_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_tvfa_multiple_OutputFcn, ...
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


% --- Executes just before vibrationdata_tvfa_multiple is made visible.
function vibrationdata_tvfa_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_tvfa_multiple (see VARARGIN)

% Choose default command line output for vibrationdata_tvfa_multiple
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_tvfa_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_tvfa_multiple_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

set(handles.edit_input_array,'String',' ');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');

   set(handles.edit_input_array,'enable','off')
   
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

fig_num=1;

tpi=2*pi;

num=get(handles.listbox_num,'Value');

kv=num;


YS=get(handles.edit_yaxis_label,'String');

p=get(handles.listbox_overlap,'Value');

po=(p-1)*0.1;

tstart=str2num(get(handles.edit_tstart,'String'));
tend=str2num(get(handles.edit_tend,'String'));

seg=str2num(get(handles.edit_segment_duration,'String'));

if(seg<1.0e-05)
    warndlg('Segment Duration is too low');
    return;
end

get_table_data(hObject, eventdata, handles);

array_name=getappdata(0,'array_name');


for ivk=1:kv
    
    try
        FS=array_name{ivk};
        THM=evalin('base',FS);  
    catch
        warndlg('Input array not found ');
        return; 
    end    

    [~,i]=min(abs(tstart-THM(:,1)));
    [~,j]=min(abs(tend-THM(:,1)));

    THM=THM(i:j,:);

    amp=THM(:,2);
    tim=THM(:,1);
    nn = size(amp);
    n = nn(1);

    mu=mean(amp);
    sd=std(amp);
    mx=max(amp);
    mi=min(amp);
    rms=sqrt(sd^2+mu^2);
    kt=0.;
    tt_max=0.;
    tt_min=0.;
%1
    for i=1:n
        if( amp(i)==mx)
            tt_max=tim(i);
        end
        if( amp(i)==mi)
            tt_min=tim(i);
        end
        kt=kt+amp(i)^4;
    end      
    kt=kt/(n*sd^4);
%1
    disp(' ')
    disp(' time stats ')
    disp(' ')
    tmx=max(tim);
    tmi=min(tim);
% disp(out0)
    out3 = sprintf(' start  = %g sec    end = %g sec            ',tmi,tmx);
    dt=(tmx-tmi)/n;
    sr=1./dt;
    out4 = sprintf(' SR  = %8.4g samples/sec    dt = %8.4g sec            ',sr,dt);
    out5 = sprintf('\n number of samples = %d  ',n);
    disp(out3)
    disp(out4)
    disp(out5)
    disp(' ')
    disp(' amplitude stats ')
    disp(' ')
    out0 = sprintf(' number of points = %d ',n);
    out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
    out2a = sprintf(' max  = %9.4g  at  = %8.4g sec            ',mx,tt_max);
    out2b = sprintf(' min  = %9.4g  at  = %8.4g sec            ',mi,tt_min);
    out5  = sprintf('\n kurtosis  = %8.4g ',kt);
%
    disp(out1)
    disp(out2a)
    disp(out2b)
    disp(out5)
%
    dur=tmx-tmi;
%
    if(seg>dur/4)
        seg=dur/4;
        string=sprintf('%8.3g',seg);
        set(handles.edit_segment_duration,'String',string);
    end
%

    ns=fix(sr*seg);
%
    out1=sprintf(' ns=%d ',ns);
    disp(out1);

    step=floor(ns*(1-po));


    i=1;
    j1=1;
    j2=1+ns;

    maxn=1.0e+06;

    while(1)

        if((j2)>n)
            break;
        end
    
        j1=j1+step;
        j2=j2+step;
    
        i=i+1;
    
        if(i>maxn)
            break;
        end    
    
    end 

    nnn=i;

    disp(' ');
    out1=sprintf('\n nnn=%d  step=%d\n',nnn,step);
    disp(out1);

    if(nnn==0)
        warndlg('nnn=0');
        return;
    end
    if(step==0)
        warndlg('step=0');
        return;
    end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

    zc=zeros(nnn,1);
    sds=zeros(nnn,1);
    rms=zeros(nnn,1);
    av=zeros(nnn,1);
    peak=zeros(nnn,1);
    tt=zeros(nnn,1);
    freq=zeros(nnn,1);
%
    j1=1;
    j2=1+ns;

    for i=1:nnn
        if(j2>n)
            break;
        end
%
        clear x;
        zc(i)=0;
        x=amp(j1:j2);
      
        if(isempty(x))
            break;
        end
        
        sds(i)=std(x);
    
        av(i)=mean(x);
%       peak(i)=max(abs(x));
        rms(i)=sqrt( sds(i)^2 + av(i)^2 );
        tt(i)=(tim(j1)+tim(j2))/2.;
%
        for k=2:max(size(x))
            if(x(k)*x(k-1)<0)
                zc(i)=zc(i)+1;
            end
        end

%%%%    

        nfr=1;
        a=x;
        amp_orig=x;
        t=tim(j1:j2);
        dur=t(end)-t(1);
        tt(i)=mean(t);
    
        [~,~,Ar,Br,omeganr]=sine_find_function(dur,a,amp_orig,t,dt,nfr);    
        peak(i)=norm([Ar Br]);
    
    
        px=sqrt(2)*rms(i);
        if(peak(i)<px)
            peak(i)=px;
        end
    
        freq(i)=omeganr/tpi;
%%%%
        j1=j1+step;
        j2=j2+step;
% 
    end
%
    freq=fix_size(freq);
%
    clear length;
    n=length(tt);
    if(tt(n)<tt(n-1))
        tt(n)=[];
        sds(n)=[];
        av(n)=[];
        peak(n)=[];
        rms(n)=[];
        zc(n)=[];
        freq(n)=[];
    end
%
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(tim,amp)
    xlabel(' Time (sec)');
    ylabel(YS);
    grid on;
    ss=sprintf('Time History  %s',array_name{ivk});
    ss=strrep(ss,'_',' ');    
    title(ss);
%

    figure(fig_num);
    fig_num=fig_num+1;

    plot(tt,peak,tt,rms,tt,sds,'-.',tt,av);

    
    legend ('peak','rms','std dev','average');    
    xlabel(' Time (sec)');
    ylabel(YS);
    ss=sprintf('Segmented Time History  %s',array_name{ivk});
    ss=strrep(ss,'_',' ');    
    title(ss);
    grid;
    

    figure(fig_num);
    fig_num=fig_num+1;
    plot(tt,freq);  
    setappdata(0,'frequency',[tt freq]);
    title('Frequency vs. Time');
    xlabel(' Time (sec)');
    ylabel(' Freq (Hz)');
    grid;
    ss=sprintf('Frequency vs. Time  %s',array_name{ivk});
    ss=strrep(ss,'_',' ');    
    title(ss);
    
    figure(fig_num);
    fig_num=fig_num+1;
    plot(tt,freq,'.');  
    xlabel(' Time (sec)');
    ylabel(' Freq (Hz)');
    grid;
    ss=sprintf('Frequency vs. Time  %s',array_name{ivk});
    ss=strrep(ss,'_',' ');    
    title(ss);   

    figure(fig_num);
    plot(freq,peak,'.');  
    ss=sprintf('Peak vs. Frequency  %s',array_name{ivk});
    ss=strrep(ss,'_',' ');
    title(ss);
    string=sprintf('Peak %s',YS);
    ylabel(string);
    xlabel(' Freq (Hz)');
    grid;

    
    peaka=[tt peak];
    RMS=[tt rms];
    stddev=[tt sds];
    meana=[tt av];
    frequency=[tt freq];
    
    array_name_peak{ivk}=sprintf('%s_peak',array_name{ivk});
    assignin('base',array_name_peak{ivk},peaka);    
  
    array_name_RMS{ivk}=sprintf('%s_RMS',array_name{ivk});
    assignin('base',array_name_RMS{ivk},RMS); 
    
    array_name_stddev{ivk}=sprintf('%s_stddev',array_name{ivk});
    assignin('base',array_name_stddev{ivk},stddev);
    
    array_name_mean{ivk}=sprintf('%s_mean',array_name{ivk});
    assignin('base',array_name_mean{ivk},meana);   
    
    array_name_frequency{ivk}=sprintf('%s_frequency',array_name{ivk});
    assignin('base',array_name_frequency{ivk},frequency); 
     
end

disp(' ');
disp(' Output Arrays ');
disp(' ');

for ivk=1:kv
    disp(array_name_peak{ivk});  
    disp(array_name_RMS{ivk});
    disp(array_name_stddev{ivk});
    disp(array_name_mean{ivk});
    disp(array_name_frequency{ivk});
    disp(' ');
end

disp(' ');

msgbox('Calculation complete');


function get_table_data(hObject, eventdata, handles)


try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    
    N=get(handles.listbox_num,'Value');

    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        data_s{i,1}=array_name{i};
    end 
         
    try
        set(handles.uitable_data,'Data',data_s);
    catch
        warndlg('Put back failed');
    end

catch
    warndlg('Input Arrays read failed');
    return;
end

setappdata(0,'array_name',array_name); 




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_tvfa_multiple)


function edit_segment_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_segment_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_segment_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_segment_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_yaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_yaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_overlap.
function listbox_overlap_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_overlap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_overlap


% --- Executes during object creation, after setting all properties.
function listbox_overlap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_segment_duration and none of its controls.
function edit_segment_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_yaxis_label and none of its controls.
function edit_yaxis_label_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_function,'Value');
n

if(n==1)
    data=getappdata(0,'peak');    
end
if(n==2)
    data=getappdata(0,'RMS');    
end
if(n==3)
    data=getappdata(0,'stddev');    
end
if(n==4)
    data=getappdata(0,'mean');    
end
if(n==5)
    data=getappdata(0,'frequency');    
end


output_name=get(handles.edit_output_array,'String');
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


% --- Executes on selection change in listbox_function.
function listbox_function_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_function contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_function


% --- Executes during object creation, after setting all properties.
function listbox_function_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tstart_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tstart as text
%        str2double(get(hObject,'String')) returns contents of edit_tstart as a double


% --- Executes during object creation, after setting all properties.
function edit_tstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tend as text
%        str2double(get(hObject,'String')) returns contents of edit_tend as a double


% --- Executes during object creation, after setting all properties.
function edit_tend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tend (see GCBO)
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

cn={'Time History Array Name'};

%%%%

Nrows=get(handles.listbox_num,'Value');
Ncolumns=1;

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

set(handles.uitable_data,'Data',data_s,'ColumnName',cn);




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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=1;
 
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
 
Ncolumns=1;
 
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
            data_s{i,j}='';
            try
                data_s{i,j}=A{i,j};
            catch
            end
            
        end    
    end   
 
end
 
nd=get(handles.listbox_delete,'Value');
 
if(nd<=Nrows)
    
    temp=data_s;
    clear data_s;
    
    
    
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
    overlap=get(handles.listbox_overlap,'Value'); 
    tvfa.overlap=overlap;      
catch
end

try
    num=get(handles.listbox_num,'Value'); 
    tvfa.num=num;         
catch
end

try
    yaxis_label=get(handles.edit_yaxis_label,'String'); 
    tvfa.yaxis_label=yaxis_label;      
catch
end

try
    segment_duration=get(handles.edit_segment_duration,'String'); 
    tvfa.segment_duration=segment_duration;      
catch
end

try
    tstart=get(handles.edit_tstart,'String'); 
    tvfa.tstart=tstart;      
catch
end

try
    tend=get(handles.edit_tend,'String'); 
    tvfa.tend=tend;      
catch
end

try
    data=get(handles.uitable_data,'data'); 
    tvfa.data=data;      
catch
end


% % %
 
structnames = fieldnames(tvfa, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    try
 
        save(elk, 'tvfa'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');



% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%

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

   tvfa=evalin('base','tvfa');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%


%%%%

try
    overlap=tvfa.overlap;  
    set(handles.listbox_overlap,'Value',overlap);      
catch
end

try
    num=tvfa.num;  
    set(handles.listbox_num,'Value',num);         
catch
end

try
    yaxis_label=tvfa.yaxis_label;     
    set(handles.edit_yaxis_label,'String',yaxis_label);      
catch
end

try
    segment_duration=tvfa.segment_duration;       
    set(handles.edit_segment_duration,'String',segment_duration);    
catch
end

try
    tstart=tvfa.tstart; 
    set(handles.edit_tstart,'String',tstart);      
catch
end

try
    tend=tvfa.tend;     
    set(handles.edit_tend,'String',tend);      
catch
end

try
    data=tvfa.data;    
    set(handles.uitable_data,'data',data);       
catch
end
