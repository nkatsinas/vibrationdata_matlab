function varargout = vibrationdata_read_csv(varargin)
% VIBRATIONDATA_READ_CSV MATLAB code for vibrationdata_read_csv.fig
%      VIBRATIONDATA_READ_CSV, by itself, creates a new VIBRATIONDATA_READ_CSV or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_READ_CSV returns the handle to a new VIBRATIONDATA_READ_CSV or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_READ_CSV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_READ_CSV.M with the given input arguments.
%
%      VIBRATIONDATA_READ_CSV('Property','Value',...) creates a new VIBRATIONDATA_READ_CSV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_read_csv_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_read_csv_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_read_csv

% Last Modified by GUIDE v2.5 17-Jun-2020 09:24:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_read_csv_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_read_csv_OutputFcn, ...
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


% --- Executes just before vibrationdata_read_csv is made visible.
function vibrationdata_read_csv_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_read_csv (see VARARGIN)

% Choose default command line output for vibrationdata_read_csv
handles.output = hObject;


set(handles.edit_num,'String',' ');
set(handles.edit_num,'Enable','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_read_csv wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_read_csv_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_read_csv)


% --- Executes on button press in pushbutton_select_input.
function pushbutton_select_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.*');
filename = fullfile(pathname, filename); 
fid = fopen(filename,'r');

%%%%%%%%%%%%%%%%

max_line=str2double(get(handles.edit_max_line,'String'));

N=max_line;

sarray = textscan(fid,'%s',N,'Delimiter','\n');
fclose(fid);

[ihead]=find_header_lines(sarray);

ss=sprintf('%d',ihead);

set(handles.edit_num,'String',ss);
set(handles.edit_num,'Enable','on');

setappdata(0,'sarray',sarray);
setappdata(0,'ihead',ihead);
setappdata(0,'filename',filename);



% --- Executes on button press in pushbutton_enter.
function pushbutton_enter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp(' ');

disp(' Output arrays: ');

ihead=str2num(get(handles.edit_num,'String'));
istart=ihead+1;

sarray=getappdata(0,'sarray');
irow=cellfun(@length,sarray);
out1=sprintf(' %d number of lines',irow);
disp(out1);

name=strtrim(get(handles.edit_array_name,'String'));

max_line=str2double(get(handles.edit_max_line,'String'));


irow=min([ irow max_line ]);

for i=istart:irow

    sq=sarray{1}{i};
    newStr = strrep(sq,',,',',NaN,');
    newStr = strrep(newStr,',,',',');
    
    sarray{1}{i}=newStr;
end


try
    strs = strsplit(sarray{1}{istart},',');
catch
    
end


icol=length(strs);

out1=sprintf(' irow=%d  icol=%d',irow,icol);
disp(out1);



N=zeros(irow-istart+1,icol);

progressbar;

for i=istart:irow
    
    progressbar(i/irow);
    
    ss=sarray{1}{i};        
    strs = strsplit(ss,','); 
    
    for j=1:icol
    
        N(i-istart+1,j)=str2double(strs(j));
        
    end    
    
end

progressbar(1);

t=N(:,1);

progressbar;

for j=2:icol
    
    clear v;
    
    progressbar(j/icol);
    
    k=1;

    for i=istart:irow
        
        ijk=i-istart+1;
        
        NN=N(ijk,j);
       
        if(~isnan(NN))
            v(k,1)=t(ijk);
            v(k,2)=NN;
            k=k+1;
        end    
        
    end
    
    try
        output_name=sprintf('%s_%d',name,(j-1));
    
        assignin('base', output_name, v);
    
        out1=sprintf('  %s',output_name);
        disp(out1);
    catch
    end
    
end    

progressbar(1);

msgbox('Import complete');



function edit_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_separate.
function pushbutton_separate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_separate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function edit_append_Callback(hObject, eventdata, handles)
% hObject    handle to edit_append (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_append as text
%        str2double(get(hObject,'String')) returns contents of edit_append as a double


% --- Executes during object creation, after setting all properties.
function edit_append_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_append (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_export_ascii.
function pushbutton_export_ascii_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export_ascii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nu=get(handles.listbox_ext,'Value');

THM=getappdata(0,'THM');
 FS=getappdata(0,'FS');
  m=getappdata(0,'m');
  
pathname=getappdata(0,'pathname');  


disp(' ');
disp(' External Output arrays ');


for i=2:m
    q=[THM(:,1) THM(:,i)];

    n=i-1;
    
    if(nu==1)
        new_name=sprintf('%s_%d.dat',FS,n);
    else
        new_name=sprintf('%s_%d.txt',FS,n);       
    end
        
    out1=sprintf('  %s',new_name);
    disp(out1);
    
    filename = fullfile(pathname, new_name);
    
    save(filename,'q','-ASCII')  
 
end

msgbox('Export complete');


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ext.
function listbox_ext_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ext contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ext


% --- Executes during object creation, after setting all properties.
function listbox_ext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num as text
%        str2double(get(hObject,'String')) returns contents of edit_num as a double


% --- Executes during object creation, after setting all properties.
function edit_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_max_line_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max_line as text
%        str2double(get(hObject,'String')) returns contents of edit_max_line as a double


% --- Executes during object creation, after setting all properties.
function edit_max_line_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
