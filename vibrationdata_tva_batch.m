function varargout = vibrationdata_tva_batch(varargin)
% VIBRATIONDATA_TVA_BATCH MATLAB code for vibrationdata_tva_batch.fig
%      VIBRATIONDATA_TVA_BATCH, by itself, creates a new VIBRATIONDATA_TVA_BATCH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TVA_BATCH returns the handle to a new VIBRATIONDATA_TVA_BATCH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TVA_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TVA_BATCH.M with the given input arguments.
%
%      VIBRATIONDATA_TVA_BATCH('Property','Value',...) creates a new VIBRATIONDATA_TVA_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_tva_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_tva_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_tva_batch

% Last Modified by GUIDE v2.5 20-Sep-2021 09:53:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_tva_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_tva_batch_OutputFcn, ...
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


% --- Executes just before vibrationdata_tva_batch is made visible.
function vibrationdata_tva_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_tva_batch (see VARARGIN)

% Choose default command line output for vibrationdata_tva_batch
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_tva_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_tva_batch_OutputFcn(hObject, eventdata, handles) 
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

set(handles.text_input_sarray,'Visible','on');
set(handles.edit_input_array,'Visible','on');

set(handles.edit_input_array,'String',' ');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
    
   set(handles.text_input_sarray,'Visible','off');
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

num=get(handles.listbox_num,'Value');
N=num;

try
    data=get(handles.uitable_data,'Data');
    A=char(data); 

    k=1;

    for i=1:N
        sarray{i}=A(k,:); k=k+1;
        sarray{i} = strtrim(sarray{i});
    end 

catch
    warndlg('Input Arrays read failed');
    return;
end

%%%

YS=get(handles.edit_yaxis_label,'String');

tstart=str2num(get(handles.edit_tstart,'String'));
tend=str2num(get(handles.edit_tend,'String'));

seg=str2num(get(handles.edit_segment_duration,'String'));

p=get(handles.listbox_overlap,'Value');

po=(p-1)*0.1;

for ijk=1:num

    clear THM;
    
    fprintf(' array %d of %d \n',ijk,num);
    
    try
        THM=evalin('base',strtrim(sarray{ijk}));
    catch
        out1=sprintf('Error: %s  not found',sarray{ijk});
        warndlg(out1);
        return;
    end

    [~,i]=min(abs(tstart-THM(:,1)));
    [~,j]=min(abs(tend-THM(:,1)));

    THM=THM(i:j,:);

    if(seg<1.0e-05)
        warndlg('Segment Duration is too low');
        return;
    end

    amp=THM(:,2);
    tim=THM(:,1);
    nn = size(amp);
    n = nn(1); 

    disp(' ')
    disp(' time stats ')
    disp(' ')
    tmx=max(tim);
    tmi=min(tim);
% 
    fprintf('\n start  = %g sec    end = %g sec            \n',tmi,tmx);
    dt=(tmx-tmi)/n;
    sr=1/dt;
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
    fprintf('\n ns=%d \n',ns);

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

    nnn=i-1;

    fprintf('\n nnn=%d  step=%d\n\n',nnn,step);

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
    tt=zeros(nnn,1);
    kt=zeros(nnn,1);
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
    
        [mu,sd,xrms,~,xkt]=kurtosis_stats(x);
    
        av(i)=mu;
        sds(i)=sd;
        rms(i)=xrms;
        kt(i)=xkt;
    
        tt(i)=(tim(j1)+tim(j2))/2.;
%
        for k=2:max(size(x))
            if(x(k)*x(k-1)<0)
                zc(i)=zc(i)+1;
            end
        end

%%%%    
        t=tim(j1:j2);
        tt(i)=mean(t);
    
%%%%
        j1=j1+step;
        j2=j2+step;
% 
    end
%
    output_name1{ijk}=sprintf('%s_rms',sarray{ijk});
    output_name2{ijk}=sprintf('%s_std',sarray{ijk});
    output_name3{ijk}=sprintf('%s_mean',sarray{ijk});    
    
    figure(ijk);
    plot(tt,rms);
    grid on;
    xlabel('Time (sec)');
    ylabel(YS);
    ts=sprintf('Time History   %s',sarray{ijk});
    
    ts=strrep(ts,'_',' ');
    title(ts);
    
    
    assignin('base', output_name1{ijk}, [tt rms]);   
    assignin('base', output_name2{ijk}, [tt sds]);  
    assignin('base', output_name3{ijk}, [tt av]);    
%
end

fprintf('\n Output arrays \n');

for ijk=1:num
    fprintf('\n %s\n',output_name1{ijk});
    fprintf(' %s\n',output_name2{ijk});
    fprintf(' %s\n',output_name3{ijk});    
end



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_tva_batch)


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
if(n==6)
    data=getappdata(0,'kurtosis');    
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
 
set(handles.uitable_data,'Data',data_s,'ColumnName','Time History Array');




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


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
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


% --- Executes on selection change in listbox_delete.
function listbox_delete_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_delete contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_delete
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
