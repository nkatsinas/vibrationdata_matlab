function varargout = coupling_loss_factor(varargin)
% COUPLING_LOSS_FACTOR MATLAB code for coupling_loss_factor.fig
%      COUPLING_LOSS_FACTOR, by itself, creates a new COUPLING_LOSS_FACTOR or raises the existing
%      singleton*.
%
%      H = COUPLING_LOSS_FACTOR returns the handle to a new COUPLING_LOSS_FACTOR or the handle to
%      the existing singleton*.
%
%      COUPLING_LOSS_FACTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COUPLING_LOSS_FACTOR.M with the given input arguments.
%
%      COUPLING_LOSS_FACTOR('Property','Value',...) creates a new COUPLING_LOSS_FACTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coupling_loss_factor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coupling_loss_factor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coupling_loss_factor

% Last Modified by GUIDE v2.5 30-Dec-2015 08:56:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coupling_loss_factor_OpeningFcn, ...
                   'gui_OutputFcn',  @coupling_loss_factor_OutputFcn, ...
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


% --- Executes just before coupling_loss_factor is made visible.
function coupling_loss_factor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coupling_loss_factor (see VARARGIN)

% Choose default command line output for coupling_loss_factor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes coupling_loss_factor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = coupling_loss_factor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_return.
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(coupling_loss_factor);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

b=get(handles.listbox_band,'Value');

if(n==1)
    if(b==1)
        handles.s=clf_L_Beam_single;            
    else
        handles.s=clf_L_Beam;        
    end

end
if(n==2)
    if(b==1)
        handles.s=clf_L_Plate_single;         
    else
        handles.s=clf_L_Plate;            
    end
    
end
if(n==3)
    if(b==1)
        handles.s=clf_bolted_joint_two_structures;        
    else
        handles.s=clf_bolted_joint_two_structures_multi;        
    end    
end

if(n==4)
    if(b==1)
        handles.s=clf_line_joint_plates;        
    else
        handles.s=clf_line_joint_plates_multi;        
    end
   
end
if(n==5)
    if(b==1)
        handles.s=clf_line_joint_plates_hs;        
    else
        handles.s=clf_line_joint_plates_multi_hs;        
    end
   
end

if(n==6)
    if(b==1)
        handles.s=point_bridge_two_structures;        
    else
        handles.s=point_bridge_two_structures_multi;        
    end
    
end
if(n==7)
    if(b==1)
        handles.s=radiation_efficiency_panel_single;         
    else
        handles.s=radiation_efficiency_panel;         
    end
    
end
if(n==8)
    if(b==1)
        handles.s=CLF_reciprocity;         
    else
        handles.s=CLF_reciprocity_multi;          
    end
end

set(handles.s,'Visible','on'); 




% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


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


% --- Executes on button press in pushbutton_defintion.
function pushbutton_defintion_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_defintion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('clf_definition2.jpg');
figure(999) 
imshow(A,'border','tight','InitialMagnification',100)
     
     


% --- Executes on selection change in listbox_band.
function listbox_band_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band


% --- Executes during object creation, after setting all properties.
function listbox_band_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
