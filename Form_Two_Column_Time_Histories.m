function varargout = Form_Two_Column_Time_Histories(varargin)
% FORM_TWO_COLUMN_TIME_HISTORIES MATLAB code for Form_Two_Column_Time_Histories.fig
%      FORM_TWO_COLUMN_TIME_HISTORIES, by itself, creates a new FORM_TWO_COLUMN_TIME_HISTORIES or raises the existing
%      singleton*.
%
%      H = FORM_TWO_COLUMN_TIME_HISTORIES returns the handle to a new FORM_TWO_COLUMN_TIME_HISTORIES or the handle to
%      the existing singleton*.
%
%      FORM_TWO_COLUMN_TIME_HISTORIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORM_TWO_COLUMN_TIME_HISTORIES.M with the given input arguments.
%
%      FORM_TWO_COLUMN_TIME_HISTORIES('Property','Value',...) creates a new FORM_TWO_COLUMN_TIME_HISTORIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Form_Two_Column_Time_Histories_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Form_Two_Column_Time_Histories_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Form_Two_Column_Time_Histories

% Last Modified by GUIDE v2.5 08-Jan-2021 12:31:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Form_Two_Column_Time_Histories_OpeningFcn, ...
                   'gui_OutputFcn',  @Form_Two_Column_Time_Histories_OutputFcn, ...
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


% --- Executes just before Form_Two_Column_Time_Histories is made visible.
function Form_Two_Column_Time_Histories_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Form_Two_Column_Time_Histories (see VARARGIN)

% Choose default command line output for Form_Two_Column_Time_Histories
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Form_Two_Column_Time_Histories wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Form_Two_Column_Time_Histories_OutputFcn(hObject, eventdata, handles) 
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

delete(Form_Two_Column_Time_Histories);


% --- Executes on button press in pushbutton_process.
function pushbutton_process_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * ');
disp('  ');


ext=get(handles.edit_ext,'String');

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


tstart=str2double(get(handles.edit_tstart,'String'));
tend=str2double(get(handles.edit_tend,'String'));


disp(' ');
disp(' Output Arrays ');
disp('  ');

for i=1:N
    ss=array_name{i};
    
    THM=evalin('base',array_name{i});
    
    out1=sprintf('data=[ THM.Time THM.Data ];');
    eval(out1);
    
    [~,i1]=min(abs(THM.Time-tstart));
    [~,i2]=min(abs(THM.Time-tend));  
    
    data=data(i1:i2,:);
    
    name=sprintf('%s%s',ss,ext);
    assignin('base',name,data);
    fprintf('%s %s\n',name,THM.UserData);
end




msgbox('Process Complete');



function edit_ext_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ext as text
%        str2double(get(hObject,'String')) returns contents of edit_ext as a double


% --- Executes during object creation, after setting all properties.
function edit_ext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ext (see GCBO)
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
cn={'Channel Name'};

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


% --- Executes on button press in pushbutton_delete_array.
function pushbutton_delete_array_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=1;
 
data_s=get(handles.uitable_data,'Data');

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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    data=get(handles.uitable_data,'Data');
    Engine.data=data;
catch
end
try
    num=get(handles.listbox_num,'Value');
    Engine.num=num;
catch
end

% % %
 
structnames = fieldnames(Engine, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'Engine'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');




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

   Engine=evalin('base','Engine');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%

try
    data=Engine.data;
    set(handles.uitable_data,'Data',data);
catch
end
try
    num=Engine.num; 
    set(handles.listbox_num,'Value',num);
catch
end

listbox_num_Callback(hObject, eventdata, handles);



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
