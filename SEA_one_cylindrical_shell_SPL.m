function varargout = SEA_one_cylindrical_shell_SPL(varargin)
% SEA_ONE_CYLINDRICAL_SHELL_SPL MATLAB code for SEA_one_cylindrical_shell_SPL.fig
%      SEA_ONE_CYLINDRICAL_SHELL_SPL, by itself, creates a new SEA_ONE_CYLINDRICAL_SHELL_SPL or raises the existing
%      singleton*.
%
%      H = SEA_ONE_CYLINDRICAL_SHELL_SPL returns the handle to a new SEA_ONE_CYLINDRICAL_SHELL_SPL or the handle to
%      the existing singleton*.
%
%      SEA_ONE_CYLINDRICAL_SHELL_SPL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_ONE_CYLINDRICAL_SHELL_SPL.M with the given input arguments.
%
%      SEA_ONE_CYLINDRICAL_SHELL_SPL('Property','Value',...) creates a new SEA_ONE_CYLINDRICAL_SHELL_SPL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_one_cylindrical_shell_SPL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_one_cylindrical_shell_SPL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_one_cylindrical_shell_SPL

% Last Modified by GUIDE v2.5 21-Sep-2018 12:48:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_one_cylindrical_shell_SPL_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_one_cylindrical_shell_SPL_OutputFcn, ...
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


% --- Executes just before SEA_one_cylindrical_shell_SPL is made visible.
function SEA_one_cylindrical_shell_SPL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_one_cylindrical_shell_SPL (see VARARGIN)

% Choose default command line output for SEA_one_cylindrical_shell_SPL
handles.output = hObject;


%%%%%%%%%%%%%

cn={'Variable'};

data_s{1,1} = 'Center Freq (Hz)';  
data_s{2,1} = 'Input SPL (dB)'; 
data_s{3,1} = 'Loss Factor'; 
 

data_t{1,1} = 'Center Freq (Hz)';  
data_t{2,1} = 'Input SPL (dB)'; 
 
set(handles.uitable_variables_3,'Data',data_s,'ColumnName',cn);
set(handles.uitable_variables_2,'Data',data_t,'ColumnName',cn);


%%%%%%%%%%%%%


n=getappdata(0,'listbox_q');
    
if(isempty(n))
    n=1;
end
set(handles.listbox_q,'Value',n); 
   
try
    if(n==1)
        FS=getappdata(0,'SPL_three_name');   
    else
        FS=getappdata(0,'SPL_two_name');       
    end
    set(handles.edit_input_array,'String',FS);
catch
end


try
    uniform=getappdata(0,'uniform');   
    sss=sprintf('%g',uniform);
    set(handles.edit_uniform,'String',sss);
catch
end 

listbox_q_Callback(hObject, eventdata, handles);

set(handles.listbox_q,'Visible','on');  % leave here


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_one_cylindrical_shell_SPL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_one_cylindrical_shell_SPL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_enter.
function pushbutton_enter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_q,'Value');
setappdata(0,'listbox_q',n);  




try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end


sz=size(THM);

if(n==1)

    if(sz(2)~=3)
        warndlg('Input Array must have three columns');
        return;
    end

else

    if(sz(2)~=2)
        warndlg('Input Array must have two columns');
        return;
    end

end

if(n==2)
     
    setappdata(0,'SPL_two',THM);
    setappdata(0,'SPL_two_name',FS);   
  
    
    lf=str2num(get(handles.edit_uniform,'String'));
    
    setappdata(0,'uniform',lf);  
    
    if isempty(lf)
        warndlg('Enter uniform loss factor');
        return;
    end
    
    THM(:,3)=lf;        
        
end


setappdata(0,'SPL_three',THM);
setappdata(0,'SPL_three_name',FS);



delete(SEA_one_cylindrical_shell_SPL);



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


% --- Executes on selection change in listbox_array_type.
function listbox_array_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_array_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_array_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_array_type

n=get(handles.listbox_array_type,'Value');

if(n==1)
   set(handles.text_uniform,'Visible','off');
   set(handles.edit_uniform,'Visible','off');   
else
   set(handles.text_uniform,'Visible','on');
   set(handles.edit_uniform,'Visible','on');       
end




% --- Executes during object creation, after setting all properties.
function listbox_array_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_array_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    A = imread('sandwich_lf.jpg');
    figure(995) 
    imshow(A,'border','tight','InitialMagnification',100)       


% --- Executes during object creation, after setting all properties.
function pushbutton_enter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_array_type.
function listbox__Callback(hObject, eventdata, handles)
% hObject    handle to listbox_array_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_array_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_array_type


% --- Executes during object creation, after setting all properties.
function listbox__CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_array_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_uniform_Callback(hObject, eventdata, handles)
% hObject    handle to edit_uniform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_uniform as text
%        str2double(get(hObject,'String')) returns contents of edit_uniform as a double


% --- Executes during object creation, after setting all properties.
function edit_uniform_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_uniform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_q.
function listbox_q_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_q contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_q
n=get(handles.listbox_q,'Value');

if(n==1)
   set(handles.text_uniform,'Visible','off');
   set(handles.edit_uniform,'Visible','off');   
else
   set(handles.text_uniform,'Visible','on');
   set(handles.edit_uniform,'Visible','on');       
end


% --- Executes during object creation, after setting all properties.
function listbox_q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
