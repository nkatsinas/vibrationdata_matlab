function varargout = Vibrationdata_material(varargin)
% VIBRATIONDATA_MATERIAL MATLAB code for Vibrationdata_material.fig
%      VIBRATIONDATA_MATERIAL, by itself, creates a new VIBRATIONDATA_MATERIAL or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_MATERIAL returns the handle to a new VIBRATIONDATA_MATERIAL or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_MATERIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_MATERIAL.M with the given input arguments.
%
%      VIBRATIONDATA_MATERIAL('Property','Value',...) creates a new VIBRATIONDATA_MATERIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_material_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_material_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_material

% Last Modified by GUIDE v2.5 11-Apr-2014 08:25:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_material_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_material_OutputFcn, ...
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


% --- Executes just before Vibrationdata_material is made visible.
function Vibrationdata_material_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_material (see VARARGIN)

% Choose default command line output for Vibrationdata_material
handles.output = hObject;

set(handles.listbox_material,'Value',1);
set(handles.listbox_unit,'Value',1);

listbox_material_Callback(hObject, eventdata, handles);

existing_material(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_material wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function existing_material(hObject, eventdata, handles)
%
set(handles.listbox_existing_material,'Enable','off');

try
    material=getappdata(0,'material');
    sz=size(material); 
    nnn=max(material(:,1))+1;
    ss=sprintf('%d',nnn);
    set(handles.edit_num,'String',ss);
    if(sz(1)==0)
        material=[];
    end    
catch
    return;
end

if(sz(1)==0)
    set(handles.edit_num,'String','1');
end

if(sz(1)>=1)
    
    material=sortrows(material,1);
    
    set(handles.listbox_existing_material,'Value',1);

    clear string_th;

    string_th = cell(sz(1),1);
    
%    out1=sprintf('sz1=%d',sz(1));
%    disp(out1);

    for i=1:sz(1)
        string_th{i}=sprintf('%d, %8.4g, %8.4g, %g',material(i,1),material(i,2),material(i,3),material(i,4));
    end

    set(handles.listbox_existing_material,'Enable','on');
    set(handles.listbox_existing_material,'string',string_th);
end


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_material_OutputFcn(hObject, eventdata, handles) 
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

delete(Vibrationdata_material);


% --- Executes on button press in pushbutton_enter_material.
function pushbutton_enter_material_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

num=str2num(get(handles.edit_num,'String'));
EM=str2num(get(handles.edit_EM,'String'));
PO=str2num(get(handles.edit_PO,'String'));
MD=str2num(get(handles.edit_MD,'String'));

try
    material=getappdata(0,'material');
    sz=size(material);
    n=sz(1);
catch
    n=0;
end

material(n+1,1)=num; 
material(n+1,2)=EM; 
material(n+1,3)=MD; 
material(n+1,4)=PO;

setappdata(0,'material',material);
existing_material(hObject, eventdata, handles);



function edit_EM_Callback(hObject, eventdata, handles)
% hObject    handle to edit_EM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_EM as text
%        str2double(get(hObject,'String')) returns contents of edit_EM as a double


% --- Executes during object creation, after setting all properties.
function edit_EM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_EM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_MD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_MD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_MD as text
%        str2double(get(hObject,'String')) returns contents of edit_MD as a double


% --- Executes during object creation, after setting all properties.
function edit_MD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_MD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_PO_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PO as text
%        str2double(get(hObject,'String')) returns contents of edit_PO as a double


% --- Executes during object creation, after setting all properties.
function edit_PO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

listbox_material_Callback(hObject, eventdata, handles);

n=get(handles.listbox_unit,'Value');

if(n==1)
    set(handles.text_EM,'String','Elastic Modulus (psi)');
    set(handles.text_MD,'String','Mass Density (lbf sec^2/in^4)');    
else
    set(handles.text_EM,'String','Elastic Modulus (Pa)');
    set(handles.text_MD,'String','Mass Density (kg/m^3)');      
end


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

n=get(handles.listbox_material,'Value');
m=get(handles.listbox_unit,'Value');

if(n==1)  % Aluminum
    if(m==1)
        se='1e+07';
        sm='0.000259';
    else
        se='70e+09';
        sm='2700';        
    end
    sp='0.33';
end
if(n==2)  % Steel
    if(m==1)
        se='3e+07';
        sm='0.000725';    
    else
        se='205e+09';
        sm='7700';        
    end
    sp='0.3';    
end
if(n==3)  % Copper
    if(m==1)
        se='1.6e+07';
        sm='0.000834';    
    else
        se='110e+09';
        sm='8900';        
    end
    sp='0.33';    
end
if(n==4)  % Other
    se=' ';
    sp=' ';
    sm=' ';
end

set(handles.edit_EM,'String',se);
set(handles.edit_PO,'String',sp);
set(handles.edit_MD,'String',sm);


% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    material=getappdata(0,'material');
catch
    msgbox('No existing materials')
    return;
end

sz=size(material);

n=get(handles.listbox_existing_material,'Value');

if(sz(1)==1 && n==1)
    
    material=[];
    setappdata(0,'material',material);
    set(handles.listbox_existing_material,'string','');
end    
    
if(sz(1)>1 && n>=1 && n<=sz(1))

    material(n,:)=[];
    setappdata(0,'material',material);
    existing_material(hObject, eventdata, handles);
end




% --- Executes on selection change in listbox_existing_material.
function listbox_existing_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_existing_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_existing_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_existing_material


% --- Executes during object creation, after setting all properties.
function listbox_existing_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_existing_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num as text
%        str2double(get(hObject,'String')) returns contents of edit_num as a double


% --- Executes during object creation, after setting all properties.
function edit_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
