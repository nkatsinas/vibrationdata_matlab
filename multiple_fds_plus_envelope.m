function varargout = multiple_fds_plus_envelope(varargin)
% MULTIPLE_FDS_PLUS_ENVELOPE MATLAB code for multiple_fds_plus_envelope.fig
%      MULTIPLE_FDS_PLUS_ENVELOPE, by itself, creates a new MULTIPLE_FDS_PLUS_ENVELOPE or raises the existing
%      singleton*.
%
%      H = MULTIPLE_FDS_PLUS_ENVELOPE returns the handle to a new MULTIPLE_FDS_PLUS_ENVELOPE or the handle to
%      the existing singleton*.
%
%      MULTIPLE_FDS_PLUS_ENVELOPE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIPLE_FDS_PLUS_ENVELOPE.M with the given input arguments.
%
%      MULTIPLE_FDS_PLUS_ENVELOPE('Property','Value',...) creates a new MULTIPLE_FDS_PLUS_ENVELOPE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multiple_fds_plus_envelope_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multiple_fds_plus_envelope_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multiple_fds_plus_envelope

% Last Modified by GUIDE v2.5 22-Mar-2019 11:37:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multiple_fds_plus_envelope_OpeningFcn, ...
                   'gui_OutputFcn',  @multiple_fds_plus_envelope_OutputFcn, ...
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


% --- Executes just before multiple_fds_plus_envelope is made visible.
function multiple_fds_plus_envelope_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multiple_fds_plus_envelope (see VARARGIN)

% Choose default command line output for multiple_fds_plus_envelope
handles.output = hObject;


set(handles.pushbutton_save,'Enable','off');

listbox_type_Callback(hObject, eventdata, handles);

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes multiple_fds_plus_envelope wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = multiple_fds_plus_envelope_OutputFcn(hObject, eventdata, handles) 
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

delete(maximum_envelope_alt);

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

THM=getappdata(0,'THM');
num=getappdata(0,'num');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tt=get(handles.edit_title,'String');
xx=get(handles.edit_xlab,'String');
yy=get(handles.edit_ylab,'String');


ntype=get(handles.listbox_type,'Value');


sz=size(THM);

n=sz(1);
m=sz(2);

maxa=zeros(n,1);

    for i=1:n
        maxa(i)=max(THM(i,2:m));
    end    
    maxa=[THM(:,1) maxa];
    
    [p9550,p9550_lognormal]=p9550_function(THM(:,2:m));
    
    x_label=xx;
    y_label=yy;
    t_string=tt;
    ppp=maxa;
    fmin=THM(1,1);
    fmax=THM(n,1);

    if(ntype==2)
        f=maxa(:,1);
        dB=maxa(:,2);
        n_type=1;
        [fig_num]=spl_plot(fig_num,n_type,f,dB);
    else
        [fig_num]=plot_loglog_function_leg(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,'Maximum');       
    
        md=15;
 
        ppp1=[THM(:,1) p9550_lognormal];
        ppp2=[THM(:,1) p9550];       
        ppp3=maxa;

        leg1='P95/50 lognormal';
        leg2='P95/50';
        leg3='Maximum';        
        
        [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp=[maxa(:,1) p9550_lognormal p9550  maxa(:,2)   THM(:,2:m)];

array_name=getappdata(0,'array_name');

leg{1}='P95/50 log';
leg{2}='P95/50';
leg{3}='Maximum';

for i=1:num
    str=array_name{i};
    str=strrep(str,'_',' ');
    leg{i+3}=str;
end


[fig_num]=plot_loglog_multiple_function_none(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
setappdata(0,'maxa',maxa);
setappdata(0,'p9550',[THM(:,1) p9550]);
setappdata(0,'p9550_lognormal',[THM(:,1) p9550_lognormal]);

set(handles.pushbutton_save,'Enable','on');

msgbox('Calculation complete');




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


m=get(handles.listbox_type,'Value');


set(handles.text_title,'Visible','off');
set(handles.edit_title,'Visible','off');
set(handles.text_xlab,'Visible','off');
set(handles.edit_xlab,'Visible','off');
set(handles.text_ylab,'Visible','off');
set(handles.edit_ylab,'Visible','off');

    if(m~=2)
        set(handles.text_title,'Visible','on');
        set(handles.edit_title,'Visible','on');
        set(handles.text_xlab,'Visible','on');
        set(handles.edit_xlab,'Visible','on');
        set(handles.text_ylab,'Visible','on');
        set(handles.edit_ylab,'Visible','on');        
    end

%%%%%%%%%%

if(m==1)
    sss='Frequency (Hz)';
end
if(m==2)
    sss='Center Frequency (Hz)';
end
if(m==3)
    sss='Natural Frequency (Hz)';
end
if(m==4)
    sss='Natural Frequency (Hz)';
end


set(handles.edit_xlab,'String',sss);





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
Ncolumns=1;

for i=1:Nrows
    data_s{i,1}='';
end    

cn={'FDS Name'};

set(handles.uitable_data,'Data',data_s,'ColumnName',cn);
set(handles.pushbutton_save,'Enable','off');

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
    data=getappdata(0,'data'); 
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
            assignin('base',array_name{i},[THM(:,1) THM(:,i+1)]); 
        catch
        end      
   
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
catch
    warndlg('Input Arrays read failed');
    return;
end

try
    
    num=get(handles.listbox_num,'Value');

    for i=1:num

        try
            FS=array_name{i};
            aq=evalin('base',FS);  
        catch
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
    warndlg('get table failed');
    return;
end

setappdata(0,'num',num);
setappdata(0,'n_ref',n_ref);
setappdata(0,'THM',THM);
setappdata(0,'array_name',array_name); 


% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off');
