function varargout = vibrationdata_fea_preprocessor(varargin)
% VIBRATIONDATA_FEA_PREPROCESSOR MATLAB code for vibrationdata_fea_preprocessor.fig
%      VIBRATIONDATA_FEA_PREPROCESSOR, by itself, creates a new VIBRATIONDATA_FEA_PREPROCESSOR or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FEA_PREPROCESSOR returns the handle to a new VIBRATIONDATA_FEA_PREPROCESSOR or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FEA_PREPROCESSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FEA_PREPROCESSOR.M with the given input arguments.
%
%      VIBRATIONDATA_FEA_PREPROCESSOR('Property','Value',...) creates a new VIBRATIONDATA_FEA_PREPROCESSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_fea_preprocessor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_fea_preprocessor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_fea_preprocessor

% Last Modified by GUIDE v2.5 16-Mar-2020 12:24:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_fea_preprocessor_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_fea_preprocessor_OutputFcn, ...
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


% --- Executes just before vibrationdata_fea_preprocessor is made visible.
function vibrationdata_fea_preprocessor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_fea_preprocessor (see VARARGIN)

% Choose default command line output for vibrationdata_fea_preprocessor
handles.output = hObject;

set(handles.listbox_perspective,'Value',1);

figure(1);
a=0;
b=0;
c=0;
plot3(a,b,c);

delete_model(hObject, eventdata, handles);  % need to do it this way

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_fea_preprocessor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function delete_model(hObject, eventdata, handles)
%
ncoor=[];
point_mass=[];
dof_spring_property=[];
dof_spring_element=[];
rigid_link=[];

setappdata(0,'ncoor',ncoor);
setappdata(0,'point_mass',point_mass);
setappdata(0,'dof_spring_property',dof_spring_property);
setappdata(0,'dof_spring_element',dof_spring_element);
setappdata(0,'rigid_link',rigid_link);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(isappdata(0,'damping_type'))
    rmappdata(0,'damping_type'); 
end
if(isappdata(0,'uniform_Q'))
    rmappdata(0,'uniform_Q'); 
end
if(isappdata(0,'uniform_dratio'))
    rmappdata(0,'uniform_dratio'); 
end
if(isappdata(0,'table_Q'))
    rmappdata(0,'table_Q'); 
end
if(isappdata(0,'table_dratio'))
    rmappdata(0,'table_dratio'); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(isappdata(0,'mass'))
    rmappdata(0,'mass'); 
end
if(isappdata(0,'stiffness'))
    rmappdata(0,'stiffness'); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(isappdata(0,'fn'))
    rmappdata(0,'fn'); 
end
if(isappdata(0,'ModeShapes'))
    rmappdata(0,'ModeShapes'); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1); 


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_fea_preprocessor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Nodes_Callback(hObject, eventdata, handles)
% hObject    handle to Nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Elements_Callback(hObject, eventdata, handles)
% hObject    handle to Elements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Materials_Callback(hObject, eventdata, handles)
% hObject    handle to Materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Properties_Callback(hObject, eventdata, handles)
% hObject    handle to Properties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Constraints_Callback(hObject, eventdata, handles)
% hObject    handle to Constraints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Vibrationdata_FEA_Constraints;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
np=get(handles.listbox_perspective,'Value');
Vibrationdata_Model_Plot(np);

% --------------------------------------------------------------------
function Manually_Add_Callback(hObject, eventdata, handles)
% hObject    handle to Manually_Add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=Vibrationdata_FEA_Manually_Add_Node;    
set(handles.s,'Visible','on'); 




% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = msgbox({'vibrationdata_fea_preprocessor.m  ver 1.5 ';'by Tom Irvine';...
                                          'Email: tom@irvinemail.org'});



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on selection change in listbox_perspective.
function listbox_perspective_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_perspective (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_perspective contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_perspective

np=get(handles.listbox_perspective,'Value')
Vibrationdata_Model_Plot(np);

% --- Executes during object creation, after setting all properties.
function listbox_perspective_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_perspective (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function listbox_node_labels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_node_labels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Files_Callback(hObject, eventdata, handles)
% hObject    handle to Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Import_Model_Callback(hObject, eventdata, handles)
% hObject    handle to Import_Model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=Vibrationdata_Import_Model;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function Export_Model_Callback(hObject, eventdata, handles)
% hObject    handle to Export_Model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Vibrationdata_Export_Model;    
set(handles.s,'Visible','on'); 





% --------------------------------------------------------------------
function Modify_Callback(hObject, eventdata, handles)
% hObject    handle to Modify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Modify_Nodes_Callback(hObject, eventdata, handles)
% hObject    handle to Modify_Nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function Edit_Node_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=Vibrationdata_Edit_Node;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_clear_model.
function pushbutton_clear_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete_model(hObject, eventdata, handles);

figure(1);
a=0;
b=0;
c=0;
plot3(a,b,c);



% --- Executes during object creation, after setting all properties.
function uipanel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function axes1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --------------------------------------------------------------------
function Add_Node_Callback(hObject, eventdata, handles)
% hObject    handle to Add_Node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=Vibrationdata_FEA_Manually_Add_Node;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function Copy_Node_Callback(hObject, eventdata, handles)
% hObject    handle to Copy_Node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=Vibrationdata_FEA_Copy_Node;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function Check_Coincident_Nodes_Callback(hObject, eventdata, handles)
% hObject    handle to Check_Coincident_Nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=Vibrationdata_Check_Coincident_Node;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function Point_Mass_Callback(hObject, eventdata, handles)
% hObject    handle to Point_Mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Vibrationdata_Point_Mass;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function dof_Spring_Callback(hObject, eventdata, handles)
% hObject    handle to dof_Spring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Vibrationdata_dof_Spring;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function Analyze_Callback(hObject, eventdata, handles)
% hObject    handle to Analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Vibrationdata_fea_Analyze;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function Normal_Modes_Callback(hObject, eventdata, handles)
% hObject    handle to Normal_Modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Rigid_Link_Callback(hObject, eventdata, handles)
% hObject    handle to Rigid_Link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Vibrationdata_rigid_link;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function Damping_Callback(hObject, eventdata, handles)
% hObject    handle to Damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Vibrationdata_fea_damping;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function Beam_Callback(hObject, eventdata, handles)
% hObject    handle to Beam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

warndlg('Beam option to be added in future revision');
return;

try
    beam_property=getappdata(0,'beam_property');
catch
    warndlg('No existing beam properties'); 
    return;
end  

handles.s=Vibrationdata_beam_element;    
set(handles.s,'Visible','on'); 


% --------------------------------------------------------------------
function Material_Callback(hObject, eventdata, handles)
% hObject    handle to Material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

warndlg('Material option to be added in future revision');
return;

handles.s=Vibrationdata_material;    
set(handles.s,'Visible','on');

% --------------------------------------------------------------------
function Property_Callback(hObject, eventdata, handles)
% hObject    handle to Property (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    material=getappdata(0,'material');
catch
    warndlg('No existing materials'); 
    return;
end   

handles.s=Vibrationdata_beam_property;    
set(handles.s,'Visible','on');

% --------------------------------------------------------------------
function Element_Callback(hObject, eventdata, handles)
% hObject    handle to Element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Vibrationdata_beam_element;    
set(handles.s,'Visible','on'); 


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
