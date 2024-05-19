function varargout = multiple_fds_damage_summation(varargin)
% MULTIPLE_FDS_DAMAGE_SUMMATION MATLAB code for multiple_fds_damage_summation.fig
%      MULTIPLE_FDS_DAMAGE_SUMMATION, by itself, creates a new MULTIPLE_FDS_DAMAGE_SUMMATION or raises the existing
%      singleton*.
%
%      H = MULTIPLE_FDS_DAMAGE_SUMMATION returns the handle to a new MULTIPLE_FDS_DAMAGE_SUMMATION or the handle to
%      the existing singleton*.
%
%      MULTIPLE_FDS_DAMAGE_SUMMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIPLE_FDS_DAMAGE_SUMMATION.M with the given input arguments.
%
%      MULTIPLE_FDS_DAMAGE_SUMMATION('Property','Value',...) creates a new MULTIPLE_FDS_DAMAGE_SUMMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multiple_fds_damage_summation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multiple_fds_damage_summation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multiple_fds_damage_summation

% Last Modified by GUIDE v2.5 21-May-2020 18:13:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multiple_fds_damage_summation_OpeningFcn, ...
                   'gui_OutputFcn',  @multiple_fds_damage_summation_OutputFcn, ...
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


% --- Executes just before multiple_fds_damage_summation is made visible.
function multiple_fds_damage_summation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multiple_fds_damage_summation (see VARARGIN)

% Choose default command line output for multiple_fds_damage_summation
handles.output = hObject;
listbox_yplotlimits_Callback(hObject, eventdata, handles);

set(handles.listbox_change_Qb,'Value',1);

set(handles.pushbutton_save,'Enable','off');

listbox_type_Callback(hObject, eventdata, handles);

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes multiple_fds_damage_summation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = multiple_fds_damage_summation_OutputFcn(hObject, eventdata, handles) 
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

delete(multiple_fds_damage_summation);

% --- Executes on button press in pushbutton_calculation.
function pushbutton_calculation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

get_table_data(hObject, eventdata, handles);
jflag=getappdata(0,'jflag');

if(jflag==1)
    return;
end

THM=getappdata(0,'THM');

sz=size(THM);

L=sz(1);
mm=sz(2);

snev=getappdata(0,'snev');

num=get(handles.listbox_num,'Value');

nev=ones(num,1);

for i=1:num
    nev(i)=str2double(snev{i});
end

damage=zeros(L,1);

for i=1:L
    for j=2:num+1
        damage(i)=damage(i)+THM(i,j)*nev(j-1);
    end    
end

ppp=[ THM(:,1) damage  THM(:,2:end)   ];

setappdata(0,'envelope',ppp(:,1:2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string=get(handles.edit_title,'String');

x_label='Natural Frequency (Hz)';

b=str2double(get(handles.edit_b,'String'));

y_label=sprintf('Damage log10(G^%g)',b);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aleg=getappdata(0,'aleg');


leg{1}='Sum';

for i=1:num
    str=aleg{i};
    str=strrep(str,'_',' ');
    leg{i+1}=str;
end

fmin=THM(1,1);
fmax=THM(end,1);

ny=get(handles.listbox_yplotlimits,'Value');

if(ny==2)
    ymin=str2double(get(handles.edit_ymin,'String'));
    ymax=str2double(get(handles.edit_ymax,'String'));
end

[fig_num]=plot_loglog_multiple_function_none_fds(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);

if(ny==2)
    a=[ ymin ymax ];
    ylim([ min(a) max(a)]);
end

set(handles.pushbutton_save,'Enable','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

change(hObject, eventdata, handles);
set(handles.pushbutton_save,'Enable','off');

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

set(handles.text_title,'Visible','on');
set(handles.edit_title,'Visible','on');
   

%%%


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

data=getappdata(0,'envelope');

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




cn={'FDS','Legend','Num Events'};

Ncolumns=3;


%%%%
 
Nrows=get(handles.listbox_num,'Value');
 
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
 
% disp(' ref 1');
% data_s
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


% --- Executes on button press in pushbutton_save_file.
function pushbutton_save_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    save2=get(handles.listbox_save,'Value');
    MaxAlt.save=save2;
catch
end


try
    name2=get(handles.edit_output_array_name2,'String');
    MaxAlt.name2=name2;
catch
end


try 
    num=get(handles.listbox_num,'Value');
    MaxAlt.num=num;
catch
end  

try
    type=get(handles.listbox_type,'Value');
    MaxAlt.type=type;
catch
end

try
    title=get(handles.edit_title,'String');
    MaxAlt.title=title;    
catch
end

try
    xlab=get(handles.edit_xlab,'String');
    MaxAlt.xlab=xlab;   
catch
end

try
    ylab=get(handles.edit_ylab,'String');
    MaxAlt.ylab=ylab;   
catch
end

try
    get_table_data(hObject, eventdata, handles);

    THM=getappdata(0,'THM');
    MaxAlt.THM=THM;   
    
catch
end

try
    data=get(handles.uitable_data,'Data'); 
    MaxAlt.data=data;      
catch
end


try
    array_name=getappdata(0,'array_name'); 
    MaxAlt.array_name=array_name;      
catch
end

% % %
 
structnames = fieldnames(MaxAlt, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'MaxAlt'); 
 
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

   MaxAlt=evalin('base','MaxAlt');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%

try
    save=MaxAlt.save;
    set(handles.listbox_save,'Value',save);
catch
end

try
    name2=MaxAlt.name2;    
    set(handles.edit_output_array_name2,'String',name2);
catch
end


try 
    num=MaxAlt.num;
    set(handles.listbox_num,'Value',num);
    listbox_num_Callback(hObject, eventdata, handles);
catch
end    
   
try
    type=MaxAlt.type;    
    set(handles.listbox_type,'Value',type);
    change(hObject, eventdata, handles);
catch
end
    
%%%

try
    title=MaxAlt.title; 
    set(handles.edit_title,'String',title);
catch
end

try
    xlab=MaxAlt.xlab;      
    set(handles.edit_xlab,'String',xlab);
catch
end

try
    ylab=MaxAlt.ylab;     
    set(handles.edit_ylab,'String',ylab);
catch
end
    
%%%
%%%
 
try
    data=MaxAlt.data;  
    disp(' ref 2');
    set(handles.uitable_data,'Data',data);
catch
end

try
    array_name=MaxAlt.array_name;  
catch
end

try
    THM=MaxAlt.THM;   
catch
end


try
    
    for i=1:num
    
        try
            temp=evalin('base',array_name{i});
        catch
        end
            
        try 
            assignin('base',array_name{i},[THM(:,1) THM(:,i+1)]); 
        catch
        end      
   
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function get_table_data(hObject, eventdata, handles)

jflag=0;

try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
catch
    warndlg('get table failed 1');
    return;
end
    
try
    N=get(handles.listbox_num,'Value');

    k=1;

    
    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        data_s{i,1}=array_name{i};
    end 
    
    for i=1:N
        aleg{i}=A(k,:); k=k+1;
        aleg{i} = strtrim(aleg{i});
        data_s{i,2}=aleg{i};       
    end 
    
    for i=1:N
        snev{i}=A(k,:); k=k+1;
        snev{i} = strtrim(snev{i});
        data_s{i,3}=snev{i};       
    end 
catch
    warndlg('get table failed 2');
    return;    
end

try
    
%    disp(' ref 3');
%    data_s
    set(handles.uitable_data,'Data',data_s);
catch
    warndlg('Put back failed');
end


try
    
    num=get(handles.listbox_num,'Value');

    for i=1:num

        try
            FS=array_name{i};
            aq=evalin('base',FS);  
        catch
            jflag=1;
            setappdata(0,'jflag',jflag);
            i
            num
            array_name{i}
            FS
            warndlg('Input array not found ');
            return; 
        end
    
        if(i==1)
            fn=aq(:,1);
            n_ref=length(fn);
            THM=zeros(n_ref,num+1);
            THM(:,1)=fn;
        end
    
        if(length(aq(:,1))~=n_ref)
            warndlg('Array length error');
            return;
        end
    
        try
            THM(:,i+1)=aq(:,2);
        catch
            warndlg('FDS array error');
            return;         
        end
        
    end

catch
    jflag=1;
    warndlg('get table failed');
    return;
end

setappdata(0,'num',num);
setappdata(0,'n_ref',n_ref);
setappdata(0,'THM',THM);
setappdata(0,'array_name',array_name); 
setappdata(0,'aleg',aleg);
setappdata(0,'snev',snev);
setappdata(0,'jflag',jflag);

% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=3;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  

% disp(' ref 4');
% data_s
set(handles.uitable_data,'Data',data_s);


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


cn={'FDS','Legend','Num Events'};




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

% disp(' ref 5');
% data_s
set(handles.uitable_data,'Data',data_s,'ColumnName',cn);



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


% --- Executes on button press in pushbutton_change_Qb.
function pushbutton_change_Qb_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_change_Qb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

get_table_data(hObject, eventdata, handles);



n=get(handles.listbox_change_Qb,'Value');

if(n==1)
    Q=10;
    b=4;
end
if(n==2)
    Q=10;
    b=8;    
end
if(n==3)
    Q=30;
    b=8;    
end
if(n==4)
    Q=30;
    b=4;    
end


array_name=getappdata(0,'array_name');
aleg=getappdata(0,'aleg');
snev=getappdata(0,'snev');

N=get(handles.listbox_num,'Value');



    
for i=1:N
    if(Q==10)
        array_name{i} = strrep(array_name{i},'Q30','Q10');
    else
        array_name{i} = strrep(array_name{i},'Q10','Q30');        
    end
    if(b==4)
        array_name{i} = strrep(array_name{i},'b8','b4');
    else
        array_name{i} = strrep(array_name{i},'b4','b8');        
    end    
end



for i=1:N
    data_s{i,1}=array_name{i};
    data_s{i,2}=aleg{i}; 
    data_s{i,3}=snev{i};
end 

% disp(' ref 6');
% data_s
set(handles.uitable_data,'Data',data_s);


ss=get(handles.edit_output_array_name2,'String');

t_string=get(handles.edit_title,'String');

if(Q==10)
        ss = strrep(ss,'Q30','Q10');
        t_string=strrep(t_string,'Q=30','Q=10');
else
        ss = strrep(ss,'Q10','Q30');       
        t_string=strrep(t_string,'Q=10','Q=30');
end
if(b==4)
        ss = strrep(ss,'b8','b4');
        t_string=strrep(t_string,'b=8','b=4');        
else
        ss = strrep(ss,'b4','b8'); 
        t_string=strrep(t_string,'b=4','b=8');         
end 

set(handles.edit_output_array_name2,'String',ss);
set(handles.edit_title,'String',t_string);

% --- Executes on selection change in listbox_change_Qb.
function listbox_change_Qb_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_change_Qb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_change_Qb contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_change_Qb
pushbutton_change_Qb_Callback(hObject, eventdata, handles)

n=get(handles.listbox_change_Qb,'Value');

if(n==1 || n==4)
    b=4;
end
if(n==2 || n==3)
    b=8;
end

ss=sprintf('%g',b);

set(handles.edit_b,'String',ss);

% --- Executes during object creation, after setting all properties.
function listbox_change_Qb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_change_Qb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_change_ev.
function listbox_change_ev_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_change_ev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_change_ev contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_change_ev
pushbutton_ev_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox_change_ev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_change_ev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ev.
function pushbutton_ev_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_legend.
function listbox_legend_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_legend contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_legend


% --- Executes during object creation, after setting all properties.
function listbox_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ch.
function pushbutton_ch_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% need to redo this instead of using function

b=get(handles.edit_new,'String');
a=get(handles.edit_old,'String');

try
    data_s=get(handles.uitable_data,'Data');
    A=char(data_s);
catch
    warndlg('get table failed 1');
    return;
end
    
try
    N=get(handles.listbox_num,'Value');

    k=1;

    for i=1:N
        ax=A(k,:); k=k+1;
        ax = strtrim(ax);
        data_s{i,1}=strrep(ax,a,b);
    end 
    
    for i=1:N
        bx=A(k,:); k=k+1;
        bx = strtrim(bx);
        data_s{i,2}=strrep(bx,a,b);     
    end 
    
catch
    warndlg('get table failed 2');
    return;    
end


% disp('ref 8');
% data_s
set(handles.uitable_data,'Data',data_s);

ss=get(handles.edit_output_array_name2,'String');

ss = strrep(ss,a,b);

set(handles.edit_output_array_name2,'String',ss);





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



function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits.
function listbox_yplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits
n=get(handles.listbox_yplotlimits,'Value');

if(n==1)
    set(handles.edit_ymin,'Enable','off');
    set(handles.edit_ymax,'Enable','off'); 
else
    set(handles.edit_ymin,'Enable','on');
    set(handles.edit_ymax,'Enable','on');  
end


% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_output_array_name2 and none of its controls.
function edit_output_array_name2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
