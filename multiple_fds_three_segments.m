function varargout = multiple_fds_three_segments(varargin)
% MULTIPLE_FDS_THREE_SEGMENTS MATLAB code for multiple_fds_three_segments.fig
%      MULTIPLE_FDS_THREE_SEGMENTS, by itself, creates a new MULTIPLE_FDS_THREE_SEGMENTS or raises the existing
%      singleton*.
%
%      H = MULTIPLE_FDS_THREE_SEGMENTS returns the handle to a new MULTIPLE_FDS_THREE_SEGMENTS or the handle to
%      the existing singleton*.
%
%      MULTIPLE_FDS_THREE_SEGMENTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIPLE_FDS_THREE_SEGMENTS.M with the given input arguments.
%
%      MULTIPLE_FDS_THREE_SEGMENTS('Property','Value',...) creates a new MULTIPLE_FDS_THREE_SEGMENTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multiple_fds_three_segments_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multiple_fds_three_segments_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multiple_fds_three_segments

% Last Modified by GUIDE v2.5 19-Apr-2019 14:51:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multiple_fds_three_segments_OpeningFcn, ...
                   'gui_OutputFcn',  @multiple_fds_three_segments_OutputFcn, ...
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


% --- Executes just before multiple_fds_three_segments is made visible.
function multiple_fds_three_segments_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multiple_fds_three_segments (see VARARGIN)

% Choose default command line output for multiple_fds_three_segments
handles.output = hObject;

set(handles.listbox_oct,'Value',2);

listbox_num_Callback(hObject, eventdata, handles);


Nrows=2;
Ncolumns=1;

set(handles.listbox_Q,'Value',Nrows);

cn={'Q'};
ssq{1,1}='10';
ssq{2,1}='30';

set(handles.uitable_Q,'Data',cell(Nrows,Ncolumns),'ColumnName',cn);
set(handles.uitable_Q,'Data',ssq,'ColumnName',cn);


set(handles.listbox_b,'Value',Nrows);

cn={'b'};
ssb{1,1}='4';
ssb{2,1}='8';

set(handles.uitable_b,'Data',cell(Nrows,Ncolumns),'ColumnName',cn);
set(handles.uitable_b,'Data',ssb,'ColumnName',cn);


try
    load NSreadtemp.mat
catch    
end



try
    nflights=NSreadtemp.nflights;
    set(handles.listbox_num,'Value',nflights);
catch
end


listbox_num_Callback(hObject, eventdata, handles);


try
    data=NSreadtemp.data;
    set(handles.uitable_data,'Data',data);
catch
    disp('data none');
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes multiple_fds_three_segments wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = multiple_fds_three_segments_OutputFcn(hObject, eventdata, handles) 
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

delete(multiple_fds_three_segments);

% --- Executes on button press in pushbutton_calculation.
function pushbutton_calculation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' * * * * * ');
disp(' ');


%%% evalin('base', 'close all')
setappdata(0,'fig_num',1);


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');

fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));


get_table_data(hObject, eventdata, handles);


na=get(handles.listbox_num,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

array_name=getappdata(0,'array_name');
leg=getappdata(0,'leg');


Q=getappdata(0,'Q');
bex=getappdata(0,'bex');

start_time=getappdata(0,'start_time');
end_time=getappdata(0,'end_time');  

ioct=1+get(handles.listbox_oct,'Value');

[fn,~]=octaves(ioct);

[~,i1]=min(abs(fn-fmin));
[~,i2]=min(abs(fn-fmax));

fn=fn(i1:i2);
nf=length(fn);

nQ=length(Q);
nbex=length(bex);

nc=nQ*nbex;

for i=1:na  % array

    disp(' '); 
    try
        FS=array_name{i};
        THM=evalin('base',FS);
        disp(FS);
        
        amp=double(THM(:,2));
        tim=double(THM(:,1));
        t=tim;
        n = length(amp)
        
        duration=tim(n)-tim(1);
        dt=duration/(n-1);
        difft=diff(t);
        dtmin=min(difft);
        dtmax=max(difft);
%
        out4 = sprintf('\n dtmin  = %8.4g sec  ',dtmin);
        out5 = sprintf(' dt     = %8.4g sec  ',dt);
        out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
        
        disp(out4);
        disp(out5);
        disp(out6);

    catch
        warndlg('input array not found');
        return;
    end    
    
    
    

    [~, i1] = min(abs(t-start_time(i,1)));    
    [~, i2] = min(abs(t-end_time(i,1)));
    [~, i3] = min(abs(t-start_time(i,2)));    
    [~, i4] = min(abs(t-end_time(i,2)));
    [~, i5] = min(abs(t-start_time(i,2)));    
    [~, i6] = min(abs(t-end_time(i,2)));    
    
    
    fds_th=zeros(nf,nc);
    
    
    disp(' segment 1');
    yy1=amp(i1:i2);
    [fds_th]=fds_engine(fds_th,yy1,nf,nQ,Q,nbex,bex,fn,dt);
    clear yy1;
    
    disp(' segment 2');
    yy2=amp(i3:i4);
    [fds_th]=fds_engine(fds_th,yy2,nf,nQ,Q,nbex,bex,fn,dt);
    clear yy2;
    
    disp(' segment 3');
    yy3=amp(i5:i6);
    [fds_th]=fds_engine(fds_th,yy3,nf,nQ,Q,nbex,bex,fn,dt);
    clear yy3;    
      
%%%    
    
%%%

    disp(' ');
    disp(' export arrays ');
    disp(' ');
     
    kv=1;
    
    for ij=1:nQ
        for ik=1:nbex
            name=sprintf('%s_fds_Q%g_b%g',FS,Q(ij),bex(ik));
            name = strrep(name,'.','_');
            data=[fn fds_th(:,kv)];
            kv=kv+1;
            assignin('base',name,data);
            out1=sprintf('  %s ',name);
            disp(out1);
        end   
    end
    disp(' ');
    
    AL=leg{i};
    [fig_num]=multiple_fds_plot(fig_num,Q,bex,fn,fds_th,AL,nc);

end

msgbox('Calculation complete');






% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

change(hObject, eventdata, handles);


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


% --- Executes on selection change in listbox_one.
function listbox_one_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_one contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_one


change(hObject, eventdata, handles);


function change(hObject, eventdata, handles)
%


% --- Executes during object creation, after setting all properties.
function listbox_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xlab_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xlab as text
%        str2double(get(hObject,'String')) returns contents of edit_xlab as a double


% --- Executes during object creation, after setting all properties.
function edit_xlab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
function pushbutton_calculation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'maxa');
end
if(n==2)
    data=getappdata(0,'p9550');
end
if(n==3)
    data=getappdata(0,'p9550_lognormal');
end

output_array_name=strtrim(get(handles.edit_output_array_name2,'String'));
assignin('base',output_array_name,data);

msgbox('Save Complete');



% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name2 as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name2 as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name2 (see GCBO)
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
Ncolumns=8;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    

try

    if(~isempty(A))
    
        M=min([ Arows Nrows ]);
    
        for i=1:M
            for j=1:Ncolumns
                data_s{i,j}=A{i,j};
            end    
        end   
 
    end

catch
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


% --- Executes on button press in pushbutton_save_file.
function pushbutton_save_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try 
    fmin=get(handles.edit_fmin,'String');
    FDSMultiple.fmin=fmin;
catch
end 
try 
    fmax=get(handles.edit_fmax,'String');
    FDSMultiple.fmax=fmax;
catch
end  


try 
    num=get(handles.listbox_num,'Value');
    FDSMultiple.num=num;
catch
end  



try 
    num=get(handles.listbox_num,'Value');
    FDSMultiple.num=num;
catch
end  

try 
    nQ=get(handles.listbox_Q,'Value');
    FDSMultiple.nQ=nQ;
catch
end  

try 
    nb=get(handles.listbox_b,'Value');
    FDSMultiple.nb=nb;
catch
end  

%%%

try
    get_table_data(hObject, eventdata, handles);

    THM=getappdata(0,'THM');
    FDSMultiple.THM=THM; 
    
catch
end

try
    data=getappdata(0,'data'); 
    FDSMultiple.data=data;      
catch
end


try
    array_name=getappdata(0,'array_name'); 
    FDSMultiple.array_name=array_name;      
catch
end

try
    Qd=get(handles.uitable_Q,'data');
    FDSMultiple.Qd=Qd;       
catch
end

try
    bd=get(handles.uitable_b,'data');
    FDSMultiple.bd=bd;       
catch
end

% % %
 
structnames = fieldnames(FDSMultiple, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'FDSMultiple'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');

% --- Executes on button press in pushbutton_load_plot.
function pushbutton_load_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_plot (see GCBO)
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

   FDSMultiple=evalin('base','FDSMultiple');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%


try 
    fmin=FDSMultiple.fmin;    
    set(handles.edit_fmin,'String',fmin);
catch
end 
try 
    fmax=FDSMultiple.fmax;    
    set(handles.edit_fmax,'String',fmax);
catch
end 


%%%%%%%%%%%%


try 
    num=FDSMultiple.num;
    set(handles.listbox_num,'Value',num);
    listbox_num_Callback(hObject, eventdata, handles);
catch
end    
   
try
    type=FDSMultiple.type;    
    set(handles.listbox_type,'Value',type);
    change(hObject, eventdata, handles);
catch
end
    
    
%%%
%%%
 
try
    data=FDSMultiple.data;  
    set(handles.uitable_data,'Data',data);
catch
end

try
    array_name=FDSMultiple.array_name;  
catch
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try 
    nQ=FDSMultiple.nQ;    
    set(handles.listbox_Q,'Value',nQ);
catch
end  

try 
    nb=FDSMultiple.nb;    
    set(handles.listbox_b,'Value',nb);
catch
end  


listbox_Q_Callback(hObject, eventdata, handles);
listbox_b_Callback(hObject, eventdata, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    Qd=FDSMultiple.Qd;     
    set(handles.uitable_Q,'data',Qd);      
catch
end
 
try
    bd=FDSMultiple.bd;        
    set(handles.uitable_b,'data',bd);   
catch
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function get_table_data(hObject, eventdata, handles)

try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    N=get(handles.listbox_num,'Value');    
    
    start_time=zeros(N,3);
      end_time=zeros(N,3);
    
    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        
%        try
%            xx=evalin('base',array_name{i});
%        catch
%            warndlg('input array not found');
%            return;
%        end    
    
    end
        
    for i=1:N
        leg{i}=A(k,:); k=k+1;
        leg{i} = strtrim(leg{i});
    end
    
    for i=1:N
        a=A(k,:); k=k+1;
        start_time(i,1) = str2double(strtrim(a));
    end    
    
    for i=1:N
        a=A(k,:); k=k+1;
        end_time(i,1) = str2double(strtrim(a));
    end   
    
    for i=1:N
        a=A(k,:); k=k+1;
        start_time(i,2) = str2double(strtrim(a));
    end    
    
    for i=1:N
        a=A(k,:); k=k+1;
        end_time(i,2) = str2double(strtrim(a));
    end       
    
    for i=1:N
        a=A(k,:); k=k+1;
        start_time(i,3) = str2double(strtrim(a));
    end    
    
    for i=1:N
        a=A(k,:); k=k+1;
        end_time(i,3) = str2double(strtrim(a));
    end 
    
    setappdata(0,'leg',leg);
    setappdata(0,'start_time',start_time);
    setappdata(0,'end_time',end_time);     
    setappdata(0,'array_name',array_name);
    
catch
    warndlg('Input Arrays read failed');
    return;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


nQ=get(handles.listbox_Q,'Value');
Q=zeros(nQ,1);

try
    k=1;
   
    C=get(handles.uitable_Q,'data');
    C=char(C);
    
    for i=1:nQ
        Q(i)=str2double(strtrim(C(k,:))); k=k+1;
    end
    
catch
    warndlg('Combinations Step 3 failed');
    return;
end



nb=get(handles.listbox_b,'Value');
bex=zeros(nb,1);

try
    k=1;
    
    C=get(handles.uitable_b,'data');
    C=char(C);
    
    for i=1:nb
        bex(i)=str2double(strtrim(C(k,:))); k=k+1;
    end
    
catch
    warndlg('Combinations Step 4 failed');
    return;
end
    
    
try

 
    setappdata(0,'Q',Q);
    setappdata(0,'bex',bex);
    
catch
    warndlg('Combinations failed');
    return;    
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in listbox_Q.
function listbox_Q_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_Q contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_Q

Nrows=get(handles.listbox_Q,'Value');
Ncolumns=1;
cn={'Q'};

set(handles.uitable_Q,'Data',cell(Nrows,Ncolumns),'ColumnName',cn);




% --- Executes during object creation, after setting all properties.
function listbox_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_Q (see GCBO)
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


% --- Executes on selection change in listbox_oct.
function listbox_oct_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_oct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_oct contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_oct


% --- Executes during object creation, after setting all properties.
function listbox_oct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_oct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable_data.
function uitable_data_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_b.
function listbox_b_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_b contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_b

Nrows=get(handles.listbox_b,'Value');
Ncolumns=1;
cn={'b'};

set(handles.uitable_b,'Data',cell(Nrows,Ncolumns),'ColumnName',cn);



% --- Executes during object creation, after setting all properties.
function listbox_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=8;
 
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
 
Ncolumns=8;
 
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
