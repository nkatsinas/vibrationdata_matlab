function varargout = vibrationdata_read_ascii_text(varargin)
% VIBRATIONDATA_READ_ASCII_TEXT MATLAB code for vibrationdata_read_ascii_text.fig
%      VIBRATIONDATA_READ_ASCII_TEXT, by itself, creates a new VIBRATIONDATA_READ_ASCII_TEXT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_READ_ASCII_TEXT returns the handle to a new VIBRATIONDATA_READ_ASCII_TEXT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_READ_ASCII_TEXT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_READ_ASCII_TEXT.M with the given input arguments.
%
%      VIBRATIONDATA_READ_ASCII_TEXT('Property','Value',...) creates a new VIBRATIONDATA_READ_ASCII_TEXT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_read_ascii_text_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_read_ascii_text_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_read_ascii_text

% Last Modified by GUIDE v2.5 25-Apr-2018 11:51:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_read_ascii_text_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_read_ascii_text_OutputFcn, ...
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


% --- Executes just before vibrationdata_read_ascii_text is made visible.
function vibrationdata_read_ascii_text_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_read_ascii_text (see VARARGIN)

% Choose default command line output for vibrationdata_read_ascii_text
handles.output = hObject;

set(handles.pushbutton_select_input,'Visible','off');
set(handles.text_append,'Visible','off');
set(handles.edit_append,'Visible','off');
set(handles.text_first_column,'Visible','off');

set(handles.text_ext,'Visible','off');
set(handles.listbox_ext,'Visible','off');

set(handles.pushbutton_enter,'Visible','off');

set(handles.listbox_header,'Value',1);

set(handles.pushbutton_separate,'Visible','off');

set(handles.pushbutton_export_ascii,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_read_ascii_text wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_read_ascii_text_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_read_ascii_text);


% --- Executes on button press in pushbutton_select_input.
function pushbutton_select_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_export_ascii,'Visible','off');
set(handles.text_ext,'Visible','off');
set(handles.listbox_ext,'Visible','off');

set(handles.pushbutton_separate,'Visible','off');
set(handles.text_append,'Visible','off');
set(handles.edit_append,'Visible','off');
set(handles.text_first_column,'Visible','off');

n=get(handles.listbox_header,'Value');


if(n==1)
    [filename, pathname] = uigetfile('*.*');
    filename = fullfile(pathname, filename);
    THM=importdata(filename);
    setappdata(0,'THM',THM);
else
    read_data(hObject, eventdata, handles);
end

setappdata(0,'pathname',pathname);

set(handles.pushbutton_enter,'Visible','on');

%%%%%%%%%%%%%%%%

function read_data(hObject, eventdata, handles)
%
[filename, pathname] = uigetfile('*.*');
filename = fullfile(pathname, filename); 
fid = fopen(filename,'r');
%
j=1;
%
for i=1:20000000
%
    clear THF;
    THF = fgets(fid);
    if(THF==-1)
         if(max(size(THF))==1)
             break;
         end
    end
%
     clear aaa;
     aaa = sscanf(THF,'%g');
     aaa=aaa';
%%
    iflag=1;
%    
    k = findstr(THF,'0');   
    if(k>=1)
      iflag=2;
    else
      k = findstr(THF,'1');
      if(k>=1)
        iflag=2;
      else
        k = findstr(THF,'2');
        if(k>=1)
          iflag=2;
        else
          k = findstr(THF,'3');
          if(k>=1)
            iflag=2;
          else
            k = findstr(THF,'4');
            if(k>=1)
              iflag=2;
            else
              k = findstr(THF,'5');
              if(k>=1)
                iflag=2;
              else
                k = findstr(THF,'6');
                if(k>=1)
                  iflag=2;
                else
                  k = findstr(THF,'7');
                  if(k>=1)
                    iflag=2;
                  else
                    k = findstr(THF,'8');
                    if(k>=1)
                      iflag=2;
                    else
                      k = findstr(THF,'9');
                      if(k>=1)
                        iflag=2;
                      end                               
                    end                        
                  end                     
                end                    
              end                 
            end    
          end              
        end             
      end     
    end            
%%
    if(iflag==2)
        THM(j,:)=aaa;
        j=j+1;
    end
%
end
%
setappdata(0,'THM',THM);

% --- Executes on button press in pushbutton_enter.
function pushbutton_enter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.pushbutton_export_ascii,'Visible','off');
set(handles.text_ext,'Visible','off');
set(handles.listbox_ext,'Visible','off');

THM=getappdata(0,'THM');

new_name=get(handles.edit_array_name,'String');

setappdata(0,'new_name',new_name);

sz=size(THM);
disp(' ');
out1=sprintf(' size:  %d x %d  ',sz(1),sz(2));
disp(out1);

%
assignin('base', new_name, THM);

if(sz(2)>2)
    set(handles.pushbutton_separate,'Visible','on');
    set(handles.text_append,'Visible','on');
    set(handles.edit_append,'Visible','on');    
    set(handles.text_first_column,'Visible','on');
else
    set(handles.pushbutton_separate,'Visible','off');    
    set(handles.text_append,'Visible','off');
    set(handles.edit_append,'Visible','off');    
    set(handles.text_first_column,'Visible','off');
end


h = msgbox('Import Complete'); 





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


% --- Executes on selection change in listbox_header.
function listbox_header_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_header (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_header contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_header


% --- Executes during object creation, after setting all properties.
function listbox_header_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_header (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_array_name and none of its controls.
function edit_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_enter,'Visible','off');

set(handles.pushbutton_select_input,'Visible','on');


% --- Executes on button press in pushbutton_separate.
function pushbutton_separate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_separate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FS=getappdata(0,'new_name');
THM=evalin('base',FS); 

n=str2num(get(handles.edit_append,'String'));  

sz=size(THM);

m=sz(2);

disp(' ');
disp(' Matlab Workspace Output arrays ');


for i=2:m
    q=[THM(:,1) THM(:,i)];
    
    new_name=sprintf('%s_%d',FS,n);
    
    out1=sprintf('  %s',new_name);
    disp(out1);
    
    assignin('base', new_name, q);

    
    n=n+1;
end

setappdata(0,'THM',THM);
setappdata(0,'FS',FS);
setappdata(0,'m',m);

set(handles.text_ext,'Visible','on');
set(handles.listbox_ext,'Visible','on');

set(handles.pushbutton_export_ascii,'Visible','on');

h = msgbox('Array names shown in command window'); 


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
