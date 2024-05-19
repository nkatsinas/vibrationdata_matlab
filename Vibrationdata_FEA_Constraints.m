function varargout = Vibrationdata_FEA_Constraints(varargin)
% VIBRATIONDATA_FEA_CONSTRAINTS MATLAB code for Vibrationdata_FEA_Constraints.fig
%      VIBRATIONDATA_FEA_CONSTRAINTS, by itself, creates a new VIBRATIONDATA_FEA_CONSTRAINTS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FEA_CONSTRAINTS returns the handle to a new VIBRATIONDATA_FEA_CONSTRAINTS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FEA_CONSTRAINTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FEA_CONSTRAINTS.M with the given input arguments.
%
%      VIBRATIONDATA_FEA_CONSTRAINTS('Property','Value',...) creates a new VIBRATIONDATA_FEA_CONSTRAINTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_FEA_Constraints_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_FEA_Constraints_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_FEA_Constraints

% Last Modified by GUIDE v2.5 21-Mar-2014 11:15:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_FEA_Constraints_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_FEA_Constraints_OutputFcn, ...
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


% --- Executes just before Vibrationdata_FEA_Constraints is made visible.
function Vibrationdata_FEA_Constraints_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_FEA_Constraints (see VARARGIN)

% Choose default command line output for Vibrationdata_FEA_Constraints
handles.output = hObject;

set(handles.pushbutton_save,'Enable','off');

set(handles.listbox_nodes,'Value',1);

set_listbox(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_FEA_Constraints wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_FEA_Constraints_OutputFcn(hObject, eventdata, handles) 
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

delete(Vibrationdata_FEA_Constraints);


% --- Executes on selection change in listbox_nodes.
function listbox_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nodes
set_listbox(hObject, eventdata, handles);

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




% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    ncoor=getappdata(0,'ncoor');
catch
    return;
end


n=get(handles.listbox_nodes,'Value');
i=n-1;

if (get(handles.radiobutton_TX,'Value') == get(handles.radiobutton_TX,'Max'))
	% Radio button is selected-take appropriate action
    if(n==1)
        ncoor(:,5)=1;
    end
    if(n>=2)
        ncoor(i,5)=1;
    end
else
	% Radio button is not selected-take appropriate action
    if(n==1)
        ncoor(:,5)=0;
    end
    if(n>=2)
        ncoor(i,5)=0;
    end    
end

if (get(handles.radiobutton_TY,'Value') == get(handles.radiobutton_TY,'Max'))
	% Radio button is selected-take appropriate action
    if(n==1)
        ncoor(:,6)=1;
    end
    if(n>=2)
        ncoor(i,6)=1;
    end    
else
	% Radio button is not selected-take appropriate action
    if(n==1)
        ncoor(:,6)=0;
    end
    if(n>=2)
        ncoor(i,6)=0;
    end      
end

if (get(handles.radiobutton_TZ,'Value') == get(handles.radiobutton_TZ,'Max'))
	% Radio button is selected-take appropriate action
    if(n==1)
        ncoor(:,7)=1;
    end
    if(n>=2)
        ncoor(i,7)=1;
    end    
else
	% Radio button is not selected-take appropriate action
    if(n==1)
        ncoor(:,7)=0;
    end
    if(n>=2)
        ncoor(i,7)=0;
    end      
end



if (get(handles.radiobutton_RX,'Value') == get(handles.radiobutton_RX,'Max'))
	% Radio button is selected-take appropriate action
    if(n==1)
        ncoor(:,8)=1;
    end
    if(n>=2)
        ncoor(i,8)=1;
    end    
else
	% Radio button is not selected-take appropriate action
    if(n==1)
        ncoor(:,8)=0;
    end
    if(n>=2)
        ncoor(i,8)=0;
    end      
end

if (get(handles.radiobutton_RY,'Value') == get(handles.radiobutton_RY,'Max'))
	% Radio button is selected-take appropriate action
    if(n==1)
        ncoor(:,9)=1;
    end
    if(n>=2)
        ncoor(i,9)=1;
    end    
else
	% Radio button is not selected-take appropriate action
    if(n==1)
        ncoor(:,9)=0;
    end
    if(n>=2)
        ncoor(i,9)=0;
    end      
end

if (get(handles.radiobutton_RZ,'Value') == get(handles.radiobutton_RZ,'Max'))
	% Radio button is selected-take appropriate action
    if(n==1)
        ncoor(:,10)=1;
    end
    if(n>=2)
        ncoor(i,10)=1;
    end    
else
	% Radio button is not selected-take appropriate action
    if(n==1)
        ncoor(:,10)=0;
    end
    if(n>=2)
        ncoor(i,10)=0;
    end      
end


setappdata(0,'ncoor',ncoor);

set_listbox(hObject, eventdata, handles);

msgbox('Constraints Saved');



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




function set_listbox(hObject, eventdata, handles)
%

set(handles.radiobutton_TX,'Value',0);
set(handles.radiobutton_TY,'Value',0);
set(handles.radiobutton_TZ,'Value',0);
set(handles.radiobutton_RX,'Value',0);
set(handles.radiobutton_RY,'Value',0);
set(handles.radiobutton_RZ,'Value',0);


try
    ncoor=getappdata(0,'ncoor');
  
    sz=size(ncoor);
    num_ncoor=sz(1);
       
catch
    ncoor=[];
    setappdata(0,'ncoor',ncoor);    
    warndlg('No existing nodes.  ref 2');
end


if(num_ncoor>=1)     
%%
%%

    set(handles.pushbutton_save,'Enable','on');
    set(handles.listbox_nodes,'Visible','on');  
        
    clear string_th;
    
    string_th{1}='All Nodes';
        
    for i=1:sz(1)
        string_th{i+1}=sprintf(' %d  (%7.4g, %7.4g, %7.4g) ',...
                              ncoor(i,1),ncoor(i,2),ncoor(i,3),ncoor(i,4));
    end

    set(handles.listbox_nodes,'String',string_th); 
        
    n=get(handles.listbox_nodes,'Value');
    
    if(n==1)
        
        atx=1;
        aty=1;
        atz=1;
        arx=1;
        ary=1;
        arz=1;   
    
        for i=1:num_ncoor
            if(ncoor(i,5)==0)
                atx=0;
                break;
            end
        end
        for i=1:num_ncoor
            if(ncoor(i,6)==0)
                aty=0;
                break;
            end
        end
        for i=1:num_ncoor
            if(ncoor(i,7)==0)
                atz=0;
                break;
            end
        end    
        for i=1:num_ncoor
            if(ncoor(i,8)==0)
                arx=0;
                break;
            end
        end
        for i=1:num_ncoor
            if(ncoor(i,9)==0)
                ary=0;
                break;
            end
        end
        for i=1:num_ncoor
            if(ncoor(i,10)==0)
                arz=0;
                break;
            end
        end   
    
        if(atx==1)
            set(handles.radiobutton_TX,'Value',1)
        end
        if(aty==1)
            set(handles.radiobutton_TY,'Value',1)
        end
        if(atz==1)
            set(handles.radiobutton_TZ,'Value',1)
        end    
        if(arx==1)
            set(handles.radiobutton_RX,'Value',1)
        end
        if(ary==1)
            set(handles.radiobutton_RY,'Value',1)
        end
        if(arz==1)
            set(handles.radiobutton_RZ,'Value',1)
        end
        
    end
    
    if(n>1)
    
        i=n-1;
        
        tx=ncoor(i,5);
        ty=ncoor(i,6);
        tz=ncoor(i,7);
        rx=ncoor(i,8);
        ry=ncoor(i,9);
        rz=ncoor(i,10);
    
        if(tx==1)
            set(handles.radiobutton_TX,'Value',1);
        end
        if(ty==1)
            set(handles.radiobutton_TY,'Value',1);
        end
        if(tz==1)
            set(handles.radiobutton_TZ,'Value',1);
        end 
        if(rx==1)
            set(handles.radiobutton_RX,'Value',1);
        end
        if(ry==1)
            set(handles.radiobutton_RY,'Value',1);
        end
        if(rz==1)
            set(handles.radiobutton_RZ,'Value',1);
        end          
    end
else    
    warndlg('No existing nodes.  ref 3');
end
