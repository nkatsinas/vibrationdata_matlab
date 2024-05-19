function varargout = Vibrationdata_dof_Spring(varargin)
% VIBRATIONDATA_DOF_SPRING MATLAB code for Vibrationdata_dof_Spring.fig
%      VIBRATIONDATA_DOF_SPRING, by itself, creates a new VIBRATIONDATA_DOF_SPRING or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_DOF_SPRING returns the handle to a new VIBRATIONDATA_DOF_SPRING or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_DOF_SPRING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_DOF_SPRING.M with the given input arguments.
%
%      VIBRATIONDATA_DOF_SPRING('Property','Value',...) creates a new VIBRATIONDATA_DOF_SPRING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_dof_Spring_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_dof_Spring_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_dof_Spring

% Last Modified by GUIDE v2.5 20-Mar-2014 08:57:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_dof_Spring_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_dof_Spring_OutputFcn, ...
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


% --- Executes just before Vibrationdata_dof_Spring is made visible.
function Vibrationdata_dof_Spring_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_dof_Spring (see VARARGIN)

% Choose default command line output for Vibrationdata_dof_Spring
handles.output = hObject;

set(handles.listbox_dof_spring_properties,'Value',1);


set(handles.listbox_node1,'Value',1);
set(handles.listbox_node2,'Value',1); 
set(handles.listbox_dof_spring_element,'Value',1);


set_listbox_dof_spring_properties(hObject, eventdata, handles);

set_listbox_dof_spring_element(hObject, eventdata, handles);

set_listbox_nodes(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_dof_Spring wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_dof_Spring_OutputFcn(hObject, eventdata, handles) 
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

disp(' return ');

dof_spring_property=getappdata(0,'dof_spring_property')
dof_spring_element =getappdata(0,'dof_spring_element')

delete(Vibrationdata_dof_Spring);


% --- Executes on button press in pushbutton_add_property.
function pushbutton_add_property_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_property (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=0;

try
    dof_spring_property=getappdata(0,'dof_spring_property');
    sz=size(dof_spring_property);
    n=sz(1);
catch
    disp(' no properties');
end

iflag=1;

gproperty=get(handles.edit_property,'String');
gkx=get(handles.edit_kx,'String');
gky=get(handles.edit_ky,'String');
gkz=get(handles.edit_kz,'String');
gkthetax=get(handles.edit_kthetax,'String');
gkthetay=get(handles.edit_kthetay,'String');
gkthetaz=get(handles.edit_kthetaz,'String');

if isempty(gproperty)
    warndlg('Enter property number'); 
    iflag=0;
end    

if isempty(gkx)
   gkx='0';
end  
if isempty(gky)
   gky='0';
end  
if isempty(gkz)
   gkz='0';
end  
if isempty(gkthetax)
   gkthetax='0';
end  
if isempty(gkthetay)
   gkthetay='0';
end  
if isempty(gkthetaz)
   gkthetaz='0';
end  


if(iflag==1)
    property=str2num(gproperty);
    kx=str2num(gkx);
    ky=str2num(gky);
    kz=str2num(gkz);
    kthetax=str2num(gkthetax);
    kthetay=str2num(gkthetay);
    kthetaz=str2num(gkthetaz);

    dof_spring_property(n+1,1)=property;
    dof_spring_property(n+1,2)=kx;
    dof_spring_property(n+1,3)=ky;
    dof_spring_property(n+1,4)=kz;
    dof_spring_property(n+1,5)=kthetax;
    dof_spring_property(n+1,6)=kthetay;
    dof_spring_property(n+1,7)=kthetaz;

    dof_spring_property = sortrows(dof_spring_property,1);
        
    setappdata(0,'dof_spring_property',dof_spring_property);
    
    set_listbox_dof_spring_properties(hObject, eventdata, handles);

end




% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_dof_spring_properties,'Value');

try
    dof_spring_property=getappdata(0,'dof_spring_property');
    dof_spring_property(n,:)=[];
    
catch
    dof_spring_property=[];    
end

dof_spring_property;

setappdata(0,'dof_spring_property',dof_spring_property);
set_listbox_dof_spring_properties(hObject, eventdata, handles);


% --- Executes on selection change in listbox_dof_spring_properties.
function listbox_dof_spring_properties_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dof_spring_properties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dof_spring_properties contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dof_spring_properties

set_listbox_dof_spring_properties(hObject, eventdata, handles);




% --- Executes during object creation, after setting all properties.
function listbox_dof_spring_properties_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dof_spring_properties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kx as text
%        str2double(get(hObject,'String')) returns contents of edit_kx as a double


% --- Executes during object creation, after setting all properties.
function edit_kx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_property_Callback(hObject, eventdata, handles)
% hObject    handle to edit_property (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_property as text
%        str2double(get(hObject,'String')) returns contents of edit_property as a double


% --- Executes during object creation, after setting all properties.
function edit_property_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_property (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ky_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ky (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ky as text
%        str2double(get(hObject,'String')) returns contents of edit_ky as a double


% --- Executes during object creation, after setting all properties.
function edit_ky_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ky (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kz as text
%        str2double(get(hObject,'String')) returns contents of edit_kz as a double


% --- Executes during object creation, after setting all properties.
function edit_kz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kthetax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kthetax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kthetax as text
%        str2double(get(hObject,'String')) returns contents of edit_kthetax as a double


% --- Executes during object creation, after setting all properties.
function edit_kthetax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kthetax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kthetay_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kthetay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kthetay as text
%        str2double(get(hObject,'String')) returns contents of edit_kthetay as a double


% --- Executes during object creation, after setting all properties.
function edit_kthetay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kthetay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kthetaz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kthetaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kthetaz as text
%        str2double(get(hObject,'String')) returns contents of edit_kthetaz as a double


% --- Executes during object creation, after setting all properties.
function edit_kthetaz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kthetaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function set_listbox_dof_spring_properties(hObject, eventdata, handles)
%

%% disp(' set listbox ');

string_th={};

try

    dof_spring_property=getappdata(0,'dof_spring_property');
    
    
    sz=size(dof_spring_property);
    
    if(sz(1)>=1)
        
        n=get(handles.listbox_dof_spring_properties,'Value');
   
        s1=sprintf('%d',dof_spring_property(n,1));
        set(handles.edit_element_property_number,'String',s1);
 
        clear string_th;
    
        for i=1:sz(1)
            string_th{i}=sprintf(' %d  (%7.4g, %7.4g, %7.4g, %7.4g, %7.4g, %7.4g) )',...
                dof_spring_property(i,1),dof_spring_property(i,2),dof_spring_property(i,3),...
                dof_spring_property(i,4),dof_spring_property(i,5),dof_spring_property(i,6),...
                dof_spring_property(i,7));
        end
 
        string_th;
    
        set(handles.listbox_dof_spring_properties,'String',string_th); 
        
        property=sprintf('%d',dof_spring_property(n,1));
        set(handles.edit_property,'String',property);
        
        
        kx=sprintf('%8.4g',dof_spring_property(n,2));
        set(handles.edit_kx,'String',kx);
        
        ky=sprintf('%8.4g',dof_spring_property(n,3));
        set(handles.edit_ky,'String',ky);
        
        kz=sprintf('%8.4g',dof_spring_property(n,4));
        set(handles.edit_kz,'String',kz);
        
  
        kthetax=sprintf('%8.4g',dof_spring_property(n,5));
        set(handles.edit_kthetax,'String',kthetax);
        
        kthetay=sprintf('%8.4g',dof_spring_property(n,6));
        set(handles.edit_kthetay,'String',kthetay);
        
        kthetaz=sprintf('%8.4g',dof_spring_property(n,7));
        set(handles.edit_kthetaz,'String',kthetaz);
                
        
    else    
%%      warndlg('No existing dof_spring_properties ');
    end
        
catch
    dof_spring_property=[];
    setappdata(0,'dof_spring_property',dof_spring_property);    
%%    warndlg('No existing dof_spring_properties ');
end

set(handles.listbox_dof_spring_properties,'String',string_th); 


% --- Executes on button press in pushbutton_edit_property.
function pushbutton_edit_property_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_edit_property (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_dof_spring_properties,'Value');

kflag=1;

try
    dof_spring_property=getappdata(0,'dof_spring_property');
    sz=size(dof_spring_property);
catch
    disp(' no properties');
    kflag=0;
end



if(kflag==1)
    
    iflag=1;

    gproperty=get(handles.edit_property,'String');
    gkx=get(handles.edit_kx,'String');
    gky=get(handles.edit_ky,'String');
    gkz=get(handles.edit_kz,'String');
    gkthetax=get(handles.edit_kthetax,'String');
    gkthetay=get(handles.edit_kthetay,'String');
    gkthetaz=get(handles.edit_kthetaz,'String');

    if isempty(gproperty)
        warndlg('Enter property number'); 
        iflag=0;
    end    

    if isempty(gkx)
        gkx='0';
    end  
    if isempty(gky)
        gky='0';
    end  
    if isempty(gkz)
        gkz='0';
    end  
    if isempty(gkthetax)
        gkthetax='0';
    end  
    if isempty(gkthetay)
        gkthetay='0';
    end  
    if isempty(gkthetaz)
        gkthetaz='0';
    end  

    if(iflag==1)
        property=str2num(gproperty);
        kx=str2num(gkx);
        ky=str2num(gky);
        kz=str2num(gkz);
        kthetax=str2num(gkthetax);
        kthetay=str2num(gkthetay);
        kthetaz=str2num(gkthetaz);

        dof_spring_property(n,1)=property;
        dof_spring_property(n,2)=kx;
        dof_spring_property(n,3)=ky;
        dof_spring_property(n,4)=kz;
        dof_spring_property(n,5)=kthetax;
        dof_spring_property(n,6)=kthetay;
        dof_spring_property(n,7)=kthetaz;

        dof_spring_property = sortrows(dof_spring_property,1);
        
        setappdata(0,'dof_spring_property',dof_spring_property);
    
        set_listbox_dof_spring_properties(hObject, eventdata, handles);

    end

end


% --- Executes on button press in pushbutton_add_element.
function pushbutton_add_element_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n1=get(handles.listbox_node1,'Value');
n2=get(handles.listbox_node2,'Value');

iflag=1;

try
    ncoor=getappdata(0,'ncoor'); 
    sz=size(ncoor);
catch
    iflag=0;
end  

m=0;

try
    dof_spring_element=getappdata(0,'dof_spring_element');
    sz=size(dof_spring_element);
    m=sz(1);
catch
    
end

if(iflag==1)

    if(n1==n2)
        warndlg('The nodes must be different from one another.'); 
    else
        try
            pn=str2num(get(handles.edit_element_property_number,'String'));
        
            dof_spring_element(m+1,:)=[pn n1 n2];
            
            dof_spring_element
      
            setappdata(0,'dof_spring_element',dof_spring_element);
            
            set_listbox_dof_spring_element(hObject, eventdata, handles);
           
%             np=get(handles.listbox_perspective,'Value');
            np=1;  
            [~]=Vibrationdata_Model_Plot(np); 
            
        catch
            
        end    
    end
end

% --- Executes on selection change in listbox_node1.
function listbox_node1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_node1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_node1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_node1


% --- Executes during object creation, after setting all properties.
function listbox_node1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_node1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_node2.
function listbox_node2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_node2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_node2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_node2


% --- Executes during object creation, after setting all properties.
function listbox_node2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_node2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_element_number_Callback(hObject, eventdata, handles)
% hObject    handle to edit_element_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_element_number as text
%        str2double(get(hObject,'String')) returns contents of edit_element_number as a double


% --- Executes during object creation, after setting all properties.
function edit_element_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_element_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_element_property_number_Callback(hObject, eventdata, handles)
% hObject    handle to edit_element_property_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_element_property_number as text
%        str2double(get(hObject,'String')) returns contents of edit_element_property_number as a double


% --- Executes during object creation, after setting all properties.
function edit_element_property_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_element_property_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_dof_spring_element.
function listbox_dof_spring_element_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dof_spring_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dof_spring_element contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dof_spring_element


% --- Executes during object creation, after setting all properties.
function listbox_dof_spring_element_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dof_spring_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_delete_element.
function pushbutton_delete_element_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_dof_spring_element,'Value');

iflag=1;
 
m=0;

try
    dof_spring_element=getappdata(0,'dof_spring_element');
    sz=size(dof_spring_element);
    m=sz(1);
catch
    
end

if(n>m)
    warndlg('Warning: n>m ');
    return;
end

if(m==1)
    clear dof_spring_element;
    dof_spring_element=[]; 
    setappdata(0,'dof_spring_element',dof_spring_element);
    string_th={};
    set(handles.listbox_dof_spring_element,'String',string_th)    
end    

if(m>1)
    dof_spring_element(n,:)=[];
    
    setappdata(0,'dof_spring_element',dof_spring_element);
            
    set_listbox_dof_spring_element(hObject, eventdata, handles);    
end

size(dof_spring_element)
dof_spring_element

if(m>=1)
      set(handles.listbox_dof_spring_element,'Value',1); 
    
%     np=get(handles.listbox_perspective,'Value');
      np=1;  
      [~]=Vibrationdata_Model_Plot(np); 
end            


function set_listbox_dof_spring_element(hObject, eventdata, handles)
%

string_th={};
 
try
 
    dof_spring_element=getappdata(0,'dof_spring_element');
    
%%    disp(' set listbox ');
%%    dof_spring_element
    
catch
    dof_spring_element=[];
    setappdata(0,'dof_spring_element',dof_spring_element);    
%%    warndlg('No existing dof_spring_properties ');
end

sz=size(dof_spring_element);

if(sz(1)>=1)
   
    for i=1:sz(1)
            string_th{i}=sprintf(' %d  %d  %d ',...
                dof_spring_element(i,1),dof_spring_element(i,2),...
                dof_spring_element(i,3));
    end
 
    string_th;
    
    set(handles.listbox_dof_spring_element,'String',string_th)
    
end    
 




function set_listbox_nodes(hObject, eventdata, handles)
%

try

    ncoor=getappdata(0,'ncoor');
    
    sz=size(ncoor);

%%    disp(' set_listbox_nodes  ');
    ncoor;
    sz;
    
    if(sz(1)>=1)
           
        clear string_th;
    
        for i=1:sz(1)
            string_th{i}=sprintf(' %d ',ncoor(i,1));
        end

        set(handles.listbox_node1,'String',string_th); 
        set(handles.listbox_node2,'String',string_th);        
           
    else    
        warndlg('No existing nodes');
    end
        
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);    
    warndlg('No existing nodes');
end
