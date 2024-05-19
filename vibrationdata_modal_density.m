function varargout = vibrationdata_modal_density(varargin)
% VIBRATIONDATA_MODAL_DENSITY MATLAB code for vibrationdata_modal_density.fig
%      VIBRATIONDATA_MODAL_DENSITY, by itself, creates a new VIBRATIONDATA_MODAL_DENSITY or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_MODAL_DENSITY returns the handle to a new VIBRATIONDATA_MODAL_DENSITY or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_MODAL_DENSITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_MODAL_DENSITY.M with the given input arguments.
%
%      VIBRATIONDATA_MODAL_DENSITY('Property','Value',...) creates a new VIBRATIONDATA_MODAL_DENSITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_modal_density_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_modal_density_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_modal_density

% Last Modified by GUIDE v2.5 19-Sep-2017 13:18:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_modal_density_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_modal_density_OutputFcn, ...
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


% --- Executes just before vibrationdata_modal_density is made visible.
function vibrationdata_modal_density_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_modal_density (see VARARGIN)

% Choose default command line output for vibrationdata_modal_density
handles.output = hObject;

listbox_structure_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_modal_density wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_modal_density_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_structure,'Value');

if(n>=3 && n<=5) 
    ncons=get(handles.listbox_construction,'Value');
end

if(n==1)
    handles.s=acoustic_modal_density;
end
if(n==2)
    handles.s=beam_modal_density;
end

%%

if(n==3)  % rectangular
    
   if(ncons==1) % homogeneous
        
       handles.s=plate_modal_density;   
        
   else         % honeycomb sandwich
   
       handles.s=honeycomb_sandwich_modal_density;  % rectangular, circular, annular
       
   end
   
end

if(n==4)  % circular
    
   if(ncons==1) % homogeneous
       
        handles.s=circular_plate_modal_density;
        
   else         % honeycomb sandwich
       
       handles.s=honeycomb_sandwich_modal_density;  % rectangular, circular, annular
        
   end
   
end

if(n==5)   % annular
        
   if(ncons==1) % homogeneous
        handles.s=circular_plate_modal_density;
        
   else         % honeycomb sandwich
       handles.s=honeycomb_sandwich_modal_density;  % rectangular, circular, annular
   end
   
end

%%%

if(n==6)
   handles.s=unstiffened_cylinder_modal_density;
end

set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_structure.
function listbox_structure_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_structure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_structure

n=get(handles.listbox_structure,'Value');

set(handles.text_construction,'Visible','off');
set(handles.listbox_construction,'Visible','off');

if(n>=3 && n <=5)
    
    set(handles.text_construction,'Visible','on');
    set(handles.listbox_construction,'Visible','on');    
    
end



% --- Executes during object creation, after setting all properties.
function listbox_structure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_construction.
function listbox_construction_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_construction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_construction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_construction


% --- Executes during object creation, after setting all properties.
function listbox_construction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_construction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_misc.
function listbox_misc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_misc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_misc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_misc


% --- Executes during object creation, after setting all properties.
function listbox_misc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_misc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze_misc.
function pushbutton_analyze_misc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze_misc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=convert_fn_modal_density;

set(handles.s,'Visible','on'); 
