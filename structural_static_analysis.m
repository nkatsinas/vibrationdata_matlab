function varargout = structural_static_analysis(varargin)
% STRUCTURAL_STATIC_ANALYSIS MATLAB code for structural_static_analysis.fig
%      STRUCTURAL_STATIC_ANALYSIS, by itself, creates a new STRUCTURAL_STATIC_ANALYSIS or raises the existing
%      singleton*.
%
%      H = STRUCTURAL_STATIC_ANALYSIS returns the handle to a new STRUCTURAL_STATIC_ANALYSIS or the handle to
%      the existing singleton*.
%
%      STRUCTURAL_STATIC_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRUCTURAL_STATIC_ANALYSIS.M with the given input arguments.
%
%      STRUCTURAL_STATIC_ANALYSIS('Property','Value',...) creates a new STRUCTURAL_STATIC_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before structural_static_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to structural_static_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help structural_static_analysis

% Last Modified by GUIDE v2.5 07-Jun-2020 20:28:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @structural_static_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @structural_static_analysis_OutputFcn, ...
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


% --- Executes just before structural_static_analysis is made visible.
function structural_static_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to structural_static_analysis (see VARARGIN)

% Choose default command line output for structural_static_analysis
handles.output = hObject;

listbox_analysis_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes structural_static_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = structural_static_analysis_OutputFcn(hObject, eventdata, handles) 
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

delete(structural_static_analysis)


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis
n=get(handles.listbox_analysis,'Value');

string_th{1}=' ';
set(handles.listbox_specific,'String',string_th); 
set(handles.listbox_specific,'Value',1);

if(n==1) % continuum mechanics
    string_th{1}='Principal Stress & Strain, von Mises, Tresca';
    string_th{2}='Stress vector on a plane with normal unit vector n';
    string_th{3}='Stress from Plane Strain';
    string_th{4}='Tensor Coordinate Frame Transformation';
    string_th{5}='Cylinder Torsion & Internal Pressure';  
    string_th{6}='Deviatoric Stress Tensor';
    string_th{7}='Octahedral Stress';
    set(handles.listbox_specific,'String',string_th);      
end
if(n==2) % stress toolbox
    string_th{1}='Spherical Bearing Stress';            
    string_th{2}='Principal, von Mises & Tresca Stress';
    string_th{3}='Stress from Plane Strain';            
    string_th{4}='Octahedral Stress';                   
    string_th{5}='Railcar Axle in Four-Point Bending';
    string_th{6}='Solid Cylinder or Shell under Torsion & Internal Pressure';
    string_th{7}='Principal, von Mises, Tresca, for Multiaxis Time History';
    string_th{8}='Beam, Peak Bending Stress';    
    set(handles.listbox_specific,'String',string_th);  
end
if(n==3) % spacecraft clamp band
    handles.s=spacecraft_clamp_band;
    set(handles.s,'Visible','on')    
end
if(n==4) % buckling
    handles.s=column_buckling;
    set(handles.s,'Visible','on');
end
if(n==5) % bolt calculations
    string_th{1}='Bolt Preload';            
    string_th{2}='Bolt Torque Preload';    
    set(handles.listbox_specific,'String',string_th);   
end



% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

m=get(handles.listbox_analysis,'Value');

n=get(handles.listbox_specific,'Value');

if(m==1)
    
    if(n==1)
        handles.s=principal_stress_strain;
    end
    if(n==2)
        handles.s=stress_plane_normal;
    end
    if(n==3)
        handles.s=stress_from_plane_strain;
    end
    if(n==4)
        handles.s=tensor_coordinate_frame_transformation;
    end
    if(n==5)
        handles.s=cylinder_torsion;
    end
    if(n==6)
        handles.s=deviatoric_stress_tensor;
    end
    if(n==7)
        handles.s=octahedral_stress;
    end
      
end
if(m==2)
    
    if(n==1)
        handles.s=bearing_stress;
    end  
    if(n==2)
        handles.s=principal_stress_strain;
    end
    if(n==3)
        handles.s=stress_from_plane_strain;
    end
    if(n==4)
        handles.s=octahedral_stress;
    end
    if(n==5)
        handles.s=railcar_axle_four_point_bending;
    end
    if(n==6)
        handles.s=cylinder_torsion;
    end
    if(n==7)
        handles.s= vibrationdata_equivalent_uniaxial;   
    end
    if(n==8)
        handles.s= vibrationdata_stress_velocity;   
    end   
        
end 
if(m==3)
    handles.s=spacecraft_clamp_band;    
end 
if(m==4)
    handles.s=column_buckling;    
end 
if(m==5)
    if(n==1)
        handles.s=bolt_preload;   
    end
    if(n==2)
        handles.s=bolt_torque_preload;   
    end       
end 

set(handles.s,'Visible','on');    

% --- Executes on selection change in listbox_specific.
function listbox_specific_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_specific (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_specific contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_specific
pushbutton_analyze_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_specific_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_specific (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_analyze_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
