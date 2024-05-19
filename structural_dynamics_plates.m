function varargout = structural_dynamics_plates(varargin)
% STRUCTURAL_DYNAMICS_PLATES MATLAB code for structural_dynamics_plates.fig
%      STRUCTURAL_DYNAMICS_PLATES, by itself, creates a new STRUCTURAL_DYNAMICS_PLATES or raises the existing
%      singleton*.
%
%      H = STRUCTURAL_DYNAMICS_PLATES returns the handle to a new STRUCTURAL_DYNAMICS_PLATES or the handle to
%      the existing singleton*.
%
%      STRUCTURAL_DYNAMICS_PLATES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRUCTURAL_DYNAMICS_PLATES.M with the given input arguments.
%
%      STRUCTURAL_DYNAMICS_PLATES('Property','Value',...) creates a new STRUCTURAL_DYNAMICS_PLATES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before structural_dynamics_plates_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to structural_dynamics_plates_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help structural_dynamics_plates

% Last Modified by GUIDE v2.5 19-Apr-2017 18:09:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @structural_dynamics_plates_OpeningFcn, ...
                   'gui_OutputFcn',  @structural_dynamics_plates_OutputFcn, ...
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


% --- Executes just before structural_dynamics_plates is made visible.
function structural_dynamics_plates_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to structural_dynamics_plates (see VARARGIN)

% Choose default command line output for structural_dynamics_plates
handles.output = hObject;

set(handles.listbox_analysis_2,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes structural_dynamics_plates wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = structural_dynamics_plates_OutputFcn(hObject, eventdata, handles) 
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
delete(structural_dynamics_plates);


% --- Executes on button press in pushbutton_analysis_1.
function pushbutton_analysis_1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    



n=get(handles.listbox_analysis_1,'Value');


if(n==1)
    handles.s=rectangular_plate_bending;
end
if(n==2)
    handles.s=vibrationdata_rectangular_plate_uniform_pressure;
end
if(n==3)
    handles.s=rectangular_plate_uniform_pressure_large_deflection;
end
if(n==4)
    handles.s=rectangular_plate_bending_corners;
end
if(n==5)
    handles.s=rectangular_plate_simply_supported;
end
if(n==6)
    handles.s=rectangular_plate_fixed_free_fixed_free;
end
if(n==7)
    handles.s=rectangular_plate_fixed_fixed_fixed_fixed;
end
if(n==8)
    handles.s=vibrationdata_rectangular_plate_fea;
end   
if(n==9)
    handles.s=thick_rectangular_plate_bending_fea;
end   
 
 
set(handles.s,'Visible','on'); 



% --- Executes on selection change in listbox_analysis_2.
function listbox_analysis_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_2


% --- Executes during object creation, after setting all properties.
function listbox_analysis_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_analysis_1.
function listbox_analysis_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_1


% --- Executes during object creation, after setting all properties.
function listbox_analysis_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analysis_2.
function pushbutton_analysis_2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis_2,'Value');

if(n==1)
    handles.s=circular_plate_bending;
end
if(n==2)
    handles.s=annular_plate_bending;
end  
 
set(handles.s,'Visible','on'); 
