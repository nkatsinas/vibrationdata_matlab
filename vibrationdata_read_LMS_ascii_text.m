function varargout = vibrationdata_read_LMS_ascii_text(varargin)
% VIBRATIONDATA_READ_LMS_ASCII_TEXT MATLAB code for vibrationdata_read_LMS_ascii_text.fig
%      VIBRATIONDATA_READ_LMS_ASCII_TEXT, by itself, creates a new VIBRATIONDATA_READ_LMS_ASCII_TEXT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_READ_LMS_ASCII_TEXT returns the handle to a new VIBRATIONDATA_READ_LMS_ASCII_TEXT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_READ_LMS_ASCII_TEXT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_READ_LMS_ASCII_TEXT.M with the given input arguments.
%
%      VIBRATIONDATA_READ_LMS_ASCII_TEXT('Property','Value',...) creates a new VIBRATIONDATA_READ_LMS_ASCII_TEXT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_read_LMS_ascii_text_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_read_LMS_ascii_text_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_read_LMS_ascii_text

% Last Modified by GUIDE v2.5 20-Mar-2018 15:04:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_read_LMS_ascii_text_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_read_LMS_ascii_text_OutputFcn, ...
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


% --- Executes just before vibrationdata_read_LMS_ascii_text is made visible.
function vibrationdata_read_LMS_ascii_text_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_read_LMS_ascii_text (see VARARGIN)

% Choose default command line output for vibrationdata_read_LMS_ascii_text
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_read_LMS_ascii_text wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_read_LMS_ascii_text_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_read_LMS_ascii_text);


% --- Executes on button press in pushbutton_select_input.
function pushbutton_select_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

read_data(hObject, eventdata, handles);

%%%%%%%%%%%%%%%%

function read_data(hObject, eventdata, handles)
%

[filename, pathname] = uigetfile('*.*');
filename = fullfile(pathname, filename); 
fid = fopen(filename,'r');
%

disp(' * * * * * * * * * ');

disp(' ');
disp(' Reading data... ');
disp(' ');

LL=0;

ijk=1;
%
for i=1:20000000
%
    clear THF;
    clear CTHF;
    
    THF = fgets(fid);
    if(THF==-1)
         if(max(size(THF))==1)
             break;
         end
    end
    
    CTHF=char(THF);
%
 
    str2double(CTHF);
    sx=strsplit(THF,' ');
    bbb=str2num(char(sx(1)));
     
    if(~isnan(bbb))

        sz=size(bbb);
        LL=sz(2);
        
%        bbb(1,1)
%        bbb(1,2)
%        bbb(1,3)
%        bbb(1,4)

        if(LL==2 || LL==4 || LL==6 )
            data1(ijk,1)=bbb(1,1); 
            data1(ijk,2)=bbb(1,2);
            ijk=ijk+1;
        end
        if(LL==4 || LL==6)
            data2(ijk,1)=bbb(1,3); 
            data2(ijk,2)=bbb(1,4);      
        end    
        if(LL==6)  
            data3(ijk,1)=bbb(1,5); 
            data3(ijk,2)=bbb(1,6);   
        end        
       
    end
end

out1=sprintf('\n  LL=%d  \n',LL);
disp(out1);


    
% plot


ss=get(handles.edit_array_name,'String');

fig_num=1;

disp(' Generate plots ');

y_label=get(handles.edit_ylabel,'String');

n=2;

ssT=strrep(ss,'_',' ');

if(LL==2 || LL==4 || LL==6 )
    t_string=sprintf('%s Channel 1',ssT);
    [fig_num]=plot_time_history(fig_num,y_label,t_string,data1,n);
    setappdata(0,'data1',data1);
end
if(LL==4 || LL==6)
    t_string=sprintf('%s Channel 2',ssT);  
    [fig_num]=plot_time_history(fig_num,y_label,t_string,data2,n); 
    setappdata(0,'data2',data2);    
end    
if(LL==6)  
    t_string=sprintf('%s Channel 3',ssT);    
    [fig_num]=plot_time_history(fig_num,y_label,t_string,data3,n); 
    setappdata(0,'data3',data3);        
end



% save data

if(LL==2 || LL==4 || LL==6 )
    
    disp(' ');
    disp('Output Arrays ');
    disp(' ');
    
    output_1=sprintf('%s_1',ss);
    disp(output_1);
    assignin('base', output_1, data1);  
end
if(LL==4 || LL==6)
    output_2=sprintf('%s_2',ss);
    disp(output_2);    
    assignin('base', output_2, data2);    
end    
if(LL==6)
    output_3=sprintf('%s_3',ss);
    disp(output_3);    
    assignin('base', output_3, data3);    
end

disp(' ');
disp(' Calculation complete ');



% --- Executes on button press in pushbutton_enter.
function pushbutton_enter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

THM=getappdata(0,'THM');

new_name=get(handles.edit_array_name,'String');

setappdata(0,'new_name',new_name);

%
assignin('base', new_name, THM);


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

set(handles.pushbutton_select_input,'Visible','on');


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



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
