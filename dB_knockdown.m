function varargout = dB_knockdown(varargin)
% DB_KNOCKDOWN MATLAB code for dB_knockdown.fig
%      DB_KNOCKDOWN, by itself, creates a new DB_KNOCKDOWN or raises the existing
%      singleton*.
%
%      H = DB_KNOCKDOWN returns the handle to a new DB_KNOCKDOWN or the handle to
%      the existing singleton*.
%
%      DB_KNOCKDOWN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DB_KNOCKDOWN.M with the given input arguments.
%
%      DB_KNOCKDOWN('Property','Value',...) creates a new DB_KNOCKDOWN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dB_knockdown_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dB_knockdown_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dB_knockdown

% Last Modified by GUIDE v2.5 09-Apr-2021 09:22:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dB_knockdown_OpeningFcn, ...
                   'gui_OutputFcn',  @dB_knockdown_OutputFcn, ...
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


% --- Executes just before dB_knockdown is made visible.
function dB_knockdown_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dB_knockdown (see VARARGIN)

% Choose default command line output for dB_knockdown
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);
listbox_num_fb_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dB_knockdown wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dB_knockdown_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_label=get(handles.edit_ylab,'String');

at=get(handles.listbox_type,'Value');

fmin=str2double(get(handles.edit_fmin,'String'));
fmax=str2double(get(handles.edit_fmax,'String'));


ext=get(handles.edit_extension,'String');

disp('  ');
disp(' * * * * * ');
disp('  ');

get_table_data(hObject, eventdata, handles);
array_name=getappdata(0,'array_name');
tstring=getappdata(0,'tstring');



try
    data=get(handles.uitable_data_fb,'Data');
    B=char(data);
        
    m=get(handles.listbox_num_fb,'Value');

    k=1;

    for i=1:m
        aa=B(k,:); k=k+1;
        f1(i) = str2double(strtrim(aa));
    end 
    
    for i=1:m
        bb=B(k,:); k=k+1;
        f2(i) = str2double(strtrim(bb));
    end 
    
    for i=1:m
        cc=B(k,:); k=k+1;
        dB(i) = str2double(strtrim(cc));
    end     
    
catch
    warndlg('Frequency bands read failed');
    return;
end

N=get(handles.listbox_num,'Value');
kv=N;

disp(' ');
disp(' Output arrays ');
disp(' ');

for i=1:kv
    
    THM=evalin('base',array_name{i});
    output=strcat(array_name{i},ext);
    
    sz=size(THM);
    
    f=THM(:,1);
    
    num=sz(1);
    
    for j=1:num
        
        for k=1:m
            if(f(j)>=f1(k) && f(j)<=f2(k))
                if(at==1)
                    THM(j,2)=THM(j,2)-dB(k);
                end
                if(at==2)
                    THM(j,2)=THM(j,2)*10^(-dB(k)/10);
                end
                if(at==3)
                    THM(j,2)=THM(j,2)*10^(-dB(k)/20);                
                end
                break;
            end
        end
   
    end
    
    x_label='Frequency (Hz)';
    t_string=tstring(i);
    ppp=THM;
    
    if(at==1)
        [fig_num,h2]=...
        plot_loglin_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
    end
    if(at>=2)
        [fig_num,h2]=...
        plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);        
    end

    assignin('base', output, THM);
    fprintf(' %s \n',output);
    
    if(i==1)
        ppp1=THM;
    end
    if(i==2)
        ppp2=THM;
    end
    if(i==3)
        ppp3=THM;
    end
    if(i==4)
        ppp4=THM;
    end    

end

if(N==4)
    
    t_string1=tstring(1);
    t_string2=tstring(2);
    t_string3=tstring(3);
    t_string4=tstring(4);    
    
    if(at==1)
        [fig_num]=subplots_loglin_1x4(fig_num,x_label,...
               y_label,t_string1,t_string2,t_string3,t_string4,ppp1,ppp2,ppp3,ppp4,fmin,fmax);
    end
end


    



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(dB_knockdown);


% --- Executes during object creation, after setting all properties.
function pushbutton_return_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num
cn={'Input Array Name','Title'};

%%%%
 
Nrows=get(handles.listbox_num,'Value');
Ncolumns=2;
 
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
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


% --- Executes on selection change in listbox_num_fb.
function listbox_num_fb_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_fb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_fb contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_fb
cn={'Start Freq (Hz)','End Freq (Hz)','dB'};

%%%%
 
Nrows=get(handles.listbox_num_fb,'Value');
Ncolumns=3;
 
A=get(handles.uitable_data_fb,'Data');
 
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
 
set(handles.uitable_data_fb,'Data',data_s,'ColumnName',cn);



% --- Executes during object creation, after setting all properties.
function listbox_num_fb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_fb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylab_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylab as text
%        str2double(get(hObject,'String')) returns contents of edit_ylab as a double


% --- Executes during object creation, after setting all properties.
function edit_ylab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ch.
function pushbutton_ch_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

get_table_data(hObject, eventdata, handles);
array_name=getappdata(0,'array_name');
tstring=getappdata(0,'tstring');

b=get(handles.edit_new,'String');
a=get(handles.edit_old,'String');

N=get(handles.listbox_num,'Value');

for i=1:N
    array_name{i} = strrep(array_name{i},a,b);
    data_s{i,1}=array_name{i};
    tstring{i} = strrep(tstring{i},a,b);    
    data_s{i,2}=tstring{i};
end

set(handles.uitable_data,'Data',data_s);

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
    end 
    
    for i=1:N
        tstring{i}=A(k,:); k=k+1;
        tstring{i} = strtrim(tstring{i});
    end     
    
catch
    warndlg('Input Arrays read failed');
    return;
end

setappdata(0,'array_name',array_name);
setappdata(0,'tstring',tstring);



% --- Executes during object creation, after setting all properties.
function pushbutton_ch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





function edit_old_Callback(hObject, eventdata, handles)
% hObject    handle to edit_old (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_old as text
%        str2double(get(hObject,'String')) returns contents of edit_old as a double


% --- Executes during object creation, after setting all properties.
function edit_old_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_old (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new as text
%        str2double(get(hObject,'String')) returns contents of edit_new as a double


% --- Executes during object creation, after setting all properties.
function edit_new_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
    y_label=get(handles.edit_ylab,'String');
    dBk.y_label=y_label;
catch
end
   
try
    at=get(handles.listbox_type,'Value');
    dBk.at=at;
catch
end
   
try
    fmin=str2double(get(handles.edit_fmin,'String'));
    fmax=str2double(get(handles.edit_fmax,'String'));
    dBk.fmin=fmin;
    dBk.fmax=fmax;
catch
end
   
try
    A=get(handles.uitable_data,'Data');
    dBk.A=A;
catch
end

try
    B=get(handles.uitable_data_fb,'Data');
    dBk.B=B;
catch
end   

try
    ext=get(handles.edit_extension,'String');
    dBk.ext=ext;
catch
end   



try
    num=get(handles.listbox_num,'Value');
    num_fb=get(handles.listbox_num_fb,'Value');
    dBk.num=num;
    dBk.num_fb=num_fb;
catch
end

% % %
 
structnames = fieldnames(dBk, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'dBk'); 
 
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
   dBk=evalin('base','dBk');
catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%

try
    ext=dBk.ext;    
    set(handles.edit_extension,'String',ext);
catch
end   



try
    y_label=dBk.y_label;    
    set(handles.edit_ylab,'String',y_label);
catch
end
   
try
    at=dBk.at;    
    set(handles.listbox_type,'Value',at);
catch
end
   
try
    fmin=dBk.fmin;
    fmax=dBk.fmax;    
    ss=sprintf('%g',fmin);
    st=sprintf('%g',fmax);    
    set(handles.edit_fmin,'String',ss);
    set(handles.edit_fmax,'String',st);
catch
end
   
try
    A=dBk.A; 
    set(handles.uitable_data,'Data',A);
catch
end

try
    B=dBk.B;    
    set(handles.uitable_data_fb,'Data',B);
catch
end   

try
    num=dBk.num;
    num_fb=dBk.num_fb;    
    set(handles.listbox_num,'Value',num);
    set(handles.listbox_num_fb,'Value',num_fb);
catch
end

listbox_num_Callback(hObject, eventdata, handles);
listbox_num_fb_Callback(hObject, eventdata, handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton_save_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
