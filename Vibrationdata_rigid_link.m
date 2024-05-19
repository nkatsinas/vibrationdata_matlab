function varargout = Vibrationdata_rigid_link(varargin)
% VIBRATIONDATA_RIGID_LINK MATLAB code for Vibrationdata_rigid_link.fig
%      VIBRATIONDATA_RIGID_LINK, by itself, creates a new VIBRATIONDATA_RIGID_LINK or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RIGID_LINK returns the handle to a new VIBRATIONDATA_RIGID_LINK or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RIGID_LINK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RIGID_LINK.M with the given input arguments.
%
%      VIBRATIONDATA_RIGID_LINK('Property','Value',...) creates a new VIBRATIONDATA_RIGID_LINK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_rigid_link_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_rigid_link_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_rigid_link

% Last Modified by GUIDE v2.5 24-Mar-2014 15:02:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_rigid_link_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_rigid_link_OutputFcn, ...
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


% --- Executes just before Vibrationdata_rigid_link is made visible.
function Vibrationdata_rigid_link_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_rigid_link (see VARARGIN)

% Choose default command line output for Vibrationdata_rigid_link
handles.output = hObject;

set(handles.listbox_link_ed,'Visible','off');
set(handles.pushbutton_delete,'Visible','off');
set(handles.pushbutton_edit,'Visible','off');

set(handles.listbox_primary_node,'Value',1);
set(handles.listbox_secondary_node,'Value',1);
set(handles.listbox_link_ed,'Value',1);

set_listbox_nodes(hObject, eventdata, handles);

set_listbox_link_ed(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_rigid_link wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_rigid_link_OutputFcn(hObject, eventdata, handles) 
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

delete(Vibrationdata_rigid_link);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

np=get(handles.listbox_primary_node,'Value');
ns=get(handles.listbox_secondary_node,'Value');

TX=get(handles.radiobutton_TX,'Value');
TY=get(handles.radiobutton_TY,'Value');
TZ=get(handles.radiobutton_TZ,'Value');
RX=get(handles.radiobutton_RX,'Value');
RY=get(handles.radiobutton_RY,'Value');
RZ=get(handles.radiobutton_RZ,'Value');

nr=0;

try
    rigid_link=getappdata(0,'rigid_link');
    sz=size(rigid_link);
    nr=sz(1);
catch
end    

% nr

if(nr>0)
   
    for i=1:nr
        
%         out1=sprintf(' %d %d %d  ',np,rigid_link(i,1),rigid_link(i,1));
%         disp(out1);
        
        if(np==rigid_link(i,2))
            
           warndlg('Warning: rigid links cannot be connected to other rigid links yet'); 
            
           return; 
        end
        
        if(ns==rigid_link(i,1))
            
           warndlg('Warning: rigid links cannot be connected to other rigid links yet'); 
            
           return; 
        end
        
        if(ns==rigid_link(i,2))
            
           warndlg('Warning: rigid links cannot be connected to other rigid links yet'); 
            
           return; 
        end
        
    end
    
end

if(np~=ns)
    
    if(TX==0 && TY==0 && TZ==0 && RX==0 && RY==0 && RZ==0)
        
        warndlg('Warning: at least one dof must be selected');
        
    else
        
        n=1;
        
        try
           rigid_link=getappdata(0,'rigid_link');
           sz=size(rigid_link);
           n=sz(1)+1;
           
           rigidlink
           n;
           
        catch
 
        end
        
        rigid_link;
 
        
        rigid_link(n,:)=[np ns TX TY TZ RX RY RZ];        

        setappdata(0,'rigid_link',rigid_link);

        set_listbox_link_ed(hObject, eventdata, handles);
        
        out1=sprintf('Rigid link no. %d added',n);
        msgbox(out1);
        
        set(handles.listbox_link_ed,'Visible','on');
        set(handles.pushbutton_delete,'Visible','on');
        set(handles.pushbutton_edit,'Visible','on');
        
        Vibrationdata_Model_Plot(1);

    end    
    
else
    warndlg('Warning: primary and secondary nodes must be different');
end






% --- Executes on selection change in listbox_primary_node.
function listbox_primary_node_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_primary_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_primary_node contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_primary_node


% --- Executes during object creation, after setting all properties.
function listbox_primary_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_primary_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_TX.
function radiobutton_TX_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_TX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_TX


% --- Executes on button press in radiobutton_TY.
function radiobutton_TY_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_TY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_TY


% --- Executes on button press in radiobutton_TZ.
function radiobutton_TZ_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_TZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_TZ


% --- Executes on button press in radiobutton_RX.
function radiobutton_RX_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_RX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_RX


% --- Executes on button press in radiobutton_RY.
function radiobutton_RY_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_RY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_RY


% --- Executes on button press in radiobutton_RZ.
function radiobutton_RZ_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_RZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_RZ


% --- Executes on selection change in listbox_secondary_node.
function listbox_secondary_node_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_secondary_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_secondary_node contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_secondary_node


% --- Executes during object creation, after setting all properties.
function listbox_secondary_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_secondary_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_link.
function listbox_link_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_link contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_link


% --- Executes during object creation, after setting all properties.
function listbox_link_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_link (see GCBO)
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

n=get(handles.listbox_link_ed,'Value');

try
    
   rigid_link=getappdata(0,'rigid_link'); 

   rigid_link(n,:)=[];
   
  
   setappdata(0,'rigid_link',rigid_link);
   
   set(handles.listbox_link_ed,'Value',1);
   
   set_listbox_link_ed(hObject, eventdata, handles);
   
   out1=sprintf('Rigid link %d deleted. \nRemaining links automatically renumbered.',n);
   msgbox(out1);
   
   Vibrationdata_Model_Plot(1);

catch
    
   warndlg('Waring:  no existing rigid links');
   
end



% --- Executes on selection change in listbox_link_ed.
function listbox_link_ed_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_link_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_link_ed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_link_ed

set_listbox_link_ed(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_link_ed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_link_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_edit.
function pushbutton_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_link_ed,'Value');

try
    
    rigid_link=getappdata(0,'rigid_link');
    
    np=str2num(get(handles.edit_ed_primary_node,'String'));
    ns=str2num(get(handles.edit_ed_secondary_node,'String'));
     
    TX=get(handles.radiobutton_edTX,'Value');
    TY=get(handles.radiobutton_edTY,'Value');
    TZ=get(handles.radiobutton_edTZ,'Value');
    RX=get(handles.radiobutton_edRX,'Value');
    RY=get(handles.radiobutton_edRY,'Value');
    RZ=get(handles.radiobutton_edRZ,'Value');

    rigid_link(n,:)=[np ns TX TY TZ RX RY RZ]; 
    
    setappdata(0,'rigid_link',rigid_link);
    
    set_listbox_link_ed(hObject, eventdata, handles);
    
    msgbox('Edit complete');
    
    Vibrationdata_Model_Plot(1);

catch
    
end


function edit_link_no_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link_no (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link_no as text
%        str2double(get(hObject,'String')) returns contents of edit_link_no as a double


% --- Executes during object creation, after setting all properties.
function edit_link_no_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link_no (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function set_listbox_nodes(hObject, eventdata, handles)
%

try

    ncoor=getappdata(0,'ncoor');
    
    sz=size(ncoor);
        
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);    
    warndlg('No existing nodes');
end


if(sz(1)>=1)
    
    disp(' set_listbox_nodes  ');
    ncoor;
    sz;
    
    if(sz(1)>=1)
           
        clear string_th;
    
        for i=1:sz(1)
            string_th{i}=sprintf(' %d ',ncoor(i,1));
        end

        set(handles.listbox_primary_node,'String',string_th); 
        set(handles.listbox_secondary_node,'String',string_th);        
           
    else    
        warndlg('No existing nodes');
    end
    
end


% --- Executes on selection change in listbox_link_ed.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_link_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_link_ed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_link_ed


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_link_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_edTX.
function radiobutton_edTX_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_edTX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_edTX


% --- Executes on button press in radiobutton_edTY.
function radiobutton_edTY_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_edTY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_edTY


% --- Executes on button press in radiobutton_edTZ.
function radiobutton_edTZ_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_edTZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_edTZ


% --- Executes on button press in radiobutton_edRX.
function radiobutton_edRX_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_edRX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_edRX


% --- Executes on button press in radiobutton_edRY.
function radiobutton_edRY_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_edRY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_edRY


% --- Executes on button press in radiobutton_edRZ.
function radiobutton_edRZ_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_edRZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_edRZ


function set_listbox_link_ed(hObject, eventdata, handles)


set(handles.radiobutton_edTX,'Value',0);
set(handles.radiobutton_edTY,'Value',0);
set(handles.radiobutton_edTZ,'Value',0);
   
set(handles.radiobutton_edRX,'Value',0);
set(handles.radiobutton_edRY,'Value',0);
set(handles.radiobutton_edRZ,'Value',0); 


n=get(handles.listbox_link_ed,'Value');


try 
   rigid_link=getappdata(0,'rigid_link'); 
   sz=size(rigid_link);
 
   rigid_link;
   
catch
   warndlg('Warning: no existing rigid links');  
end

if(n>sz(1))
    n=1;
end

clear string_th;
set(handles.listbox_link_ed,'String',''); 
   

if(sz(1)>=1)
    
   set(handles.listbox_link_ed,'Visible','on'); 
   set(handles.listbox_link_ed,'Enable','on'); 
   
   set(handles.listbox_link_ed,'Visible','on'); 
   set(handles.listbox_link_ed,'Enable','on'); 
   
   set(handles.pushbutton_delete,'Visible','on');
   set(handles.pushbutton_edit,'Visible','on');
   
   clear string_th;
   
   for i=1:sz(1)
     string_th{i}=sprintf('%d',i);  
   end
    
   set(handles.listbox_link_ed,'String',string_th); 
   
   edTX=rigid_link(n,3);
   edTY=rigid_link(n,4);
   edTZ=rigid_link(n,5);
   
   edRX=rigid_link(n,6);
   edRY=rigid_link(n,7);
   edRZ=rigid_link(n,8);  
   
   
   if(edTX==1)
        set(handles.radiobutton_edTX,'Value',1);
   end

   if(edTY==1)   
        set(handles.radiobutton_edTY,'Value',1);
   end
   
   if(edTZ==1)
        set(handles.radiobutton_edTZ,'Value',1);
   end
      
   if(edRX==1)
        set(handles.radiobutton_edRX,'Value',1);
   end
   
   if(edRY==1)
        set(handles.radiobutton_edRY,'Value',1);
   end
   
   if(edRZ==1)
        set(handles.radiobutton_edRZ,'Value',1);   
   end 
   
   s1=sprintf('%d',rigid_link(n,1));
   s2=sprintf('%d',rigid_link(n,2));
   
   set(handles.edit_ed_primary_node,'String',s1);
   set(handles.edit_ed_secondary_node,'String',s2);
    
end


function edit_ed_primary_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ed_primary_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ed_primary_node as text
%        str2double(get(hObject,'String')) returns contents of edit_ed_primary_node as a double


% --- Executes during object creation, after setting all properties.
function edit_ed_primary_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ed_primary_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ed_secondary_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ed_secondary_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ed_secondary_node as text
%        str2double(get(hObject,'String')) returns contents of edit_ed_secondary_node as a double


% --- Executes during object creation, after setting all properties.
function edit_ed_secondary_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ed_secondary_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
