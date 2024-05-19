function varargout = SEA_four_homogeneous_cylindrical_shells_SPL(varargin)
% SEA_FOUR_HOMOGENEOUS_CYLINDRICAL_SHELLS_SPL MATLAB code for SEA_four_homogeneous_cylindrical_shells_SPL.fig
%      SEA_FOUR_HOMOGENEOUS_CYLINDRICAL_SHELLS_SPL, by itself, creates a new SEA_FOUR_HOMOGENEOUS_CYLINDRICAL_SHELLS_SPL or raises the existing
%      singleton*.
%
%      H = SEA_FOUR_HOMOGENEOUS_CYLINDRICAL_SHELLS_SPL returns the handle to a new SEA_FOUR_HOMOGENEOUS_CYLINDRICAL_SHELLS_SPL or the handle to
%      the existing singleton*.
%
%      SEA_FOUR_HOMOGENEOUS_CYLINDRICAL_SHELLS_SPL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_FOUR_HOMOGENEOUS_CYLINDRICAL_SHELLS_SPL.M with the given input arguments.
%
%      SEA_FOUR_HOMOGENEOUS_CYLINDRICAL_SHELLS_SPL('Property','Value',...) creates a new SEA_FOUR_HOMOGENEOUS_CYLINDRICAL_SHELLS_SPL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_four_homogeneous_cylindrical_shells_SPL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_four_homogeneous_cylindrical_shells_SPL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_four_homogeneous_cylindrical_shells_SPL

% Last Modified by GUIDE v2.5 05-Nov-2021 19:20:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_four_homogeneous_cylindrical_shells_SPL_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_four_homogeneous_cylindrical_shells_SPL_OutputFcn, ...
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


% --- Executes just before SEA_four_homogeneous_cylindrical_shells_SPL is made visible.
function SEA_four_homogeneous_cylindrical_shells_SPL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_four_homogeneous_cylindrical_shells_SPL (see VARARGIN)

% Choose default command line output for SEA_four_homogeneous_cylindrical_shells_SPL
handles.output = hObject;


%%%%%%%%%%%%%


data_s{1,1} = 'Center Freq (Hz)';  
data_s{2,1} = 'Input SPL 1 (dB)'; 
data_s{3,1} = 'Input SPL 2 (dB)'; 
data_s{4,1} = 'Input SPL 3 (dB)'; 
data_s{5,1} = 'Input SPL 4 (dB)'; 
data_s{6,1} = 'Loss Factor 1'; 
data_s{7,1} = 'Loss Factor 2'; 
data_s{8,1} = 'Loss Factor 3'; 
data_s{9,1} = 'Loss Factor 4';  

data_t{1,1} = 'Center Freq (Hz)';  
data_t{2,1} = 'Input SPL 1 (dB)'; 
data_t{3,1} = 'Input SPL 2 (dB)'; 
data_t{4,1} = 'Input SPL 3 (dB)'; 
data_t{5,1} = 'Input SPL 4 (dB)'; 


set(handles.uitable_variables_9,'Data',data_s);
set(handles.uitable_variables_5,'Data',data_t);


%%%%%%%%%%%%%


try
   
    n=getappdata(0,'listbox_array_type');
    if(n<=2)
        set(handles.listbox_array_type,'Value',n); 
    else
        set(handles.listbox_array_type,'Value',1);        
    end
catch
end

if(~isempty(n))

    try  

        if(n==1)
            FS=getappdata(0,'SPL_nine_name');
        end
        if(n==2)
            FS=getappdata(0,'SPL_five_name');
        end 
        
        if(~isempty(FS))
            set(handles.edit_input_array,'String',FS);
        end    
    
    catch
    end

end



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_four_homogeneous_cylindrical_shells_SPL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_four_homogeneous_cylindrical_shells_SPL_OutputFcn(hObject, eventdata, handles) 
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


n=get(handles.listbox_array_type,'Value');
setappdata(0,'listbox_array_type',n);  


try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end


sz=size(THM);

if(sz(2)~=9 && n==1)
    warndlg('Input Array must have nine columns');
    return;
end

if(sz(2)~=5 && n==2)
    warndlg('Input Array must have five columns');
    return;
end

if(n==2)
   
    f=THM(:,1);    
    
    setappdata(0,'SPL_five',THM);
    setappdata(0,'SPL_five_name',FS);   
  
    
    for i=1:sz(1)
        
        lf=0.3/(f(i)^0.63);          
       
        THM(i,6:9)=lf;        
        
    end

end


setappdata(0,'SPL_nine',THM);
setappdata(0,'SPL_nine_name',FS);



delete(SEA_four_homogeneous_cylindrical_shells_SPL);



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
