function varargout = Vibrationdata_Point_Mass(varargin)
% VIBRATIONDATA_POINT_MASS MATLAB code for Vibrationdata_Point_Mass.fig
%      VIBRATIONDATA_POINT_MASS, by itself, creates a new VIBRATIONDATA_POINT_MASS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_POINT_MASS returns the handle to a new VIBRATIONDATA_POINT_MASS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_POINT_MASS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_POINT_MASS.M with the given input arguments.
%
%      VIBRATIONDATA_POINT_MASS('Property','Value',...) creates a new VIBRATIONDATA_POINT_MASS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_Point_Mass_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_Point_Mass_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_Point_Mass

% Last Modified by GUIDE v2.5 19-Mar-2014 10:11:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_Point_Mass_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_Point_Mass_OutputFcn, ...
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


% --- Executes just before Vibrationdata_Point_Mass is made visible.
function Vibrationdata_Point_Mass_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_Point_Mass (see VARARGIN)

% Choose default command line output for Vibrationdata_Point_Mass
handles.output = hObject;

set(handles.listbox_point_mass,'Value',1);
set(handles.listbox_perspective,'Value',1);



try
    ncoor=getappdata(0,'ncoor');
    sz=size(ncoor);
    m=sz(1);
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);    
end

if(m>=1)

    set_listbox(hObject, eventdata, handles);
    display_point_masses(hObject, eventdata, handles);

    listbox_nodes_Callback(hObject, eventdata, handles);

    set(handles.pushbutton_Add_Mass,'Enable','on');    
    set(handles.pushbutton_delete_point_mass,'Enable','on');
    
    set(handles.edit_point_mass,'Enable','on'); 
    set(handles.edit_Jx,'Enable','on'); 
    set(handles.edit_Jy,'Enable','on');    
    set(handles.edit_Jz,'Enable','on'); 
    set(handles.listbox_nodes,'Enable','on'); 
    set(handles.listbox_point_mass,'Enable','on');  
    set(handles.listbox_perspective,'Enable','on');     
else

    set(handles.pushbutton_Add_Mass,'Enable','off');    
    set(handles.pushbutton_delete_point_mass,'Enable','off');    
    set(handles.edit_point_mass,'Enable','off'); 
    set(handles.edit_Jx,'Enable','off'); 
    set(handles.edit_Jy,'Enable','off');    
    set(handles.edit_Jz,'Enable','off'); 
    set(handles.listbox_nodes,'Enable','off'); 
    set(handles.listbox_point_mass,'Enable','off');  
    set(handles.listbox_perspective,'Enable','off');
    
    warndlg('No existing nodes.');
end    
    
    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_Point_Mass wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_Point_Mass_OutputFcn(hObject, eventdata, handles) 
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
delete(Vibrationdata_Point_Mass);


% --- Executes on button press in pushbutton_Add_Mass.
function pushbutton_Add_Mass_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Add_Mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

stt=get(handles.edit_point_mass,'String');
sJx=get(handles.edit_Jx,'String');
sJy=get(handles.edit_Jy,'String');
sJz=get(handles.edit_Jz,'String');

node=str2num(get(handles.edit_node,'String'));

n=0;

try
   point_mass=getappdata(0,'point_mass');
   sz=size(point_mass);
   n=sz(1);
catch
   point_mass=[]; 
end    


iflag=1;

if isempty(stt)
    warndlg('Enter Mass value')
    iflag=0;     
end   


if isempty(sJx)
    warndlg('Enter Jx value')
    iflag=0;     
end   


if isempty(sJy)
    warndlg('Enter Jy value')
    iflag=0; 
end   

if isempty(sJz)
    warndlg('Enter Jz value')
    iflag=0; 
end   


if(iflag==1)
    pm=str2num(stt);
    Jx=str2num(sJx);    
    Jy=str2num(sJy);   
    Jz=str2num(sJz);   
     
    point_mass(n+1,:)=[node pm Jx Jy Jz];
 
    point_mass = sortrows(point_mass,1);
    
    setappdata(0,'point_mass',point_mass);
    
    display_point_masses(hObject, eventdata, handles);   
    
    n=get(handles.listbox_perspective,'Value');
    [~]=Vibrationdata_Model_Plot(n); 
    
     msgbox('Point mass added');  
else
%    msgbox('Point mass NOT added');      
end    
    



function edit_point_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_point_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_point_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_nodes.
function listbox_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nodes



try
    ncoor=getappdata(0,'ncoor');
    sz=size(ncoor);
    m=sz(1);
        
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);    
    warndlg('No existing nodes.  ref 1');
end

if(m>=1)
    n=get(handles.listbox_nodes,'Value');
    
    ss=sprintf('%d',ncoor(n,1));
    
    set(handles.edit_node,'String',ss);
end



% --- Executes during object creation, after setting all properties.
function listbox_nodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_node as text
%        str2double(get(hObject,'String')) returns contents of edit_node as a double


% --- Executes during object creation, after setting all properties.
function edit_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function set_listbox(hObject, eventdata, handles)
%

iflag=0;

try

    ncoor=getappdata(0,'ncoor');
    
    iflag=1;
        
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);    
    warndlg('No existing nodes.  ref 2');
end

if(iflag==1)
 sz=size(ncoor);
    
    if(sz(1)>=1)
        
    
        set(handles.listbox_nodes,'Visible','on');  

        
        n=get(handles.listbox_nodes,'Value');
        
        sz(1);

        clear string_th;
    
        for i=1:sz(1)
            string_th{i}=sprintf(' %d  (%7.4g, %7.4g, %7.4g) ',ncoor(i,1),ncoor(i,2),ncoor(i,3),ncoor(i,4));
        end

    
        set(handles.listbox_nodes,'String',string_th); 
        
        
    else    
        warndlg('No existing nodes.  ref 3');
    end
end


% --- Executes on selection change in listbox_point_mass.
function listbox_point_mass_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_point_mass contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_point_mass


% --- Executes during object creation, after setting all properties.
function listbox_point_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function display_point_masses(hObject, eventdata, handles)
%
iflag=0;

try
    point_mass=getappdata(0,'point_mass');
    iflag=1;
    set(handles.pushbutton_delete_point_mass,'Visible','on');

catch
    point_mass=[];
    setappdata(0,'point_mass',point_mass);
    set(handles.pushbutton_delete_point_mass,'Visible','off');
    warndlg(' No existing point masses ');
end


if(iflag==1)
    sz=size(point_mass);
    
    if(sz(1)>=1 && sz(2)==5)
            
        set(handles.listbox_point_mass,'Visible','on');  
        
        n=get(handles.listbox_point_mass,'Value');
        
        sz(1);

        clear string_th;
    
        for i=1:sz(1)
            string_th{i}=sprintf(' %d  %7.4g %7.4g %7.4g %7.4g',...
            point_mass(i,1),point_mass(i,2),point_mass(i,3),point_mass(i,4),point_mass(i,5));
        end
 
        set(handles.listbox_point_mass,'String',string_th); 
        
        
    else    
%%        warndlg('No existing point masses.  ref 3');
    end
end


% --- Executes on button press in pushbutton_delete_point_mass.
function pushbutton_delete_point_mass_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%
iflag=0;

try
    point_mass=getappdata(0,'point_mass');
    iflag=1;
        
catch
    point_mass=[];
    setappdata(0,'point_mass',point_mass);   
end

if(iflag==1)
    
    kflag=0;
    
    try
        n=get(handles.listbox_point_mass,'Value');
        kflag=1;
    catch
        
    end
    
    if(kflag==1)
     
        sz=size(point_mass);
        
        m=sz(1);
   
        if(m>=1)
            point_mass(n,:)=[];
            setappdata(0,'point_mass',point_mass); 
            display_point_masses(hObject, eventdata, handles);
            
            sz=size(point_mass);
            if(sz(1)<1)
                clear string_th;
                string_th{1}='';
                set(handles.listbox_point_mass,'String',string_th);
                n=get(handles.listbox_perspective,'Value');
                [~]=Vibrationdata_Model_Plot(n); 
                return;
            end
            
            set(handles.listbox_point_mass,'Value',1);
            
        else
            set(handles.listbox_point_mass,'String','');   
            set(handles.pushbutton_delete_point_mass,'Enable','off');
        end
        
        n=get(handles.listbox_perspective,'Value');
        [~]=Vibrationdata_Model_Plot(n); 
           
    end
    
end    


% --- Executes on selection change in listbox_perspective.
function listbox_perspective_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_perspective (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_perspective contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_perspective


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



function edit_Jx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Jx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Jx as text
%        str2double(get(hObject,'String')) returns contents of edit_Jx as a double


% --- Executes during object creation, after setting all properties.
function edit_Jx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Jx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Jy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Jy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Jy as text
%        str2double(get(hObject,'String')) returns contents of edit_Jy as a double


% --- Executes during object creation, after setting all properties.
function edit_Jy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Jy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Jz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Jz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Jz as text
%        str2double(get(hObject,'String')) returns contents of edit_Jz as a double


% --- Executes during object creation, after setting all properties.
function edit_Jz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Jz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
