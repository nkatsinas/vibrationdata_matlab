function varargout = Vibrationdata_fea_damping(varargin)
% VIBRATIONDATA_FEA_DAMPING MATLAB code for Vibrationdata_fea_damping.fig
%      VIBRATIONDATA_FEA_DAMPING, by itself, creates a new VIBRATIONDATA_FEA_DAMPING or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FEA_DAMPING returns the handle to a new VIBRATIONDATA_FEA_DAMPING or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FEA_DAMPING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FEA_DAMPING.M with the given input arguments.
%
%      VIBRATIONDATA_FEA_DAMPING('Property','Value',...) creates a new VIBRATIONDATA_FEA_DAMPING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_fea_damping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_fea_damping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_fea_damping

% Last Modified by GUIDE v2.5 29-Mar-2014 11:59:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_fea_damping_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_fea_damping_OutputFcn, ...
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


% --- Executes just before Vibrationdata_fea_damping is made visible.
function Vibrationdata_fea_damping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_fea_damping (see VARARGIN)

% Choose default command line output for Vibrationdata_fea_damping
handles.output = hObject;

set(handles.listbox_options,'Value',1);
set(handles.listbox_coordinates,'Value',1);

listbox_coordinates_Callback(hObject, eventdata, handles)

try  
    dtype=getappdata(0,'damping_type'); 
    dtype;
    
    
    if(dtype(1)==1)  % uniform
        set(handles.listbox_options,'Value',1);
    else             % table
        set(handles.listbox_options,'Value',2);        
    end     
    
    
    if(dtype(2)==1)  % Q
        set(handles.listbox_unit,'Value',1);
    else  % dratio
        set(handles.listbox_unit,'Value',2);        
    end    
        
    if(dtype(1)==1) % uniform
        try
            if(dtype(2)==1)
                 d=getappdata(0,'uniform_Q');                  
            else
                 d=getappdata(0,'uniform_dratio');    
            end
            
            s1=sprintf('%8.4g',d);            
            set(handles.edit_value,'String',s1);
        catch
        end     
    end    
    if(dtype(1)==2)  % table
        
%        disp(' try get table data');
        
        try

            if(dtype(2)==1)
                dtab=getappdata(0,'table_Q') 
                set(handles.text_coordinates,'String','Enter Freq & Q Values');
            else
                dtab=getappdata(0,'table_dratio');  
                set(handles.text_coordinates,'String','Enter Freq & Damping Ratio Values');                
            end
            
            sz=size(dtab);
            
            if(sz(1)>=2 && sz(1)<=5)
                
%                disp(' in sz ');
                
                dtab_string=cell(sz(1),2); 
                
                for ij=1:sz(1)
                    dtab_string(ij,1)={dtab(ij,1)};
                    dtab_string(ij,2)={dtab(ij,2)};
                end


%                disp('s1');
                set(handles.listbox_coordinates,'Value',(sz(1)-1));   
%                disp('s2');
                set(handles.uitable_coordinates,'Data',dtab_string);
%                disp('s3');
            end
            
        catch
        end     
    end       
    
catch
    
end    
    
Change_Entry(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_fea_damping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_fea_damping_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function Change_Entry(hObject, eventdata, handles)

n=get(handles.listbox_unit,'Value');

m=get(handles.listbox_options,'Value');

% disp('Change');
n;
m;

set(handles.text_uniform,'Visible','off');
set(handles.edit_value,'Visible','off');
set(handles.text_coordinates,'Visible','off');
set(handles.text_press_enter,'Visible','off');
set(handles.uitable_coordinates,'Visible','off');
set(handles.listbox_coordinates,'Visible','off');
set(handles.text_number_coordinates,'Visible','off');

if(m==1)
    
    set(handles.edit_value,'Visible','on'); 
    set(handles.text_uniform,'Visible','on');
    
    if(n==1)
        set(handles.text_uniform,'String','Uniform Q');    
    else
        set(handles.text_uniform,'String','Uniform Damping Ratio');          
    end
    
else
      
    set(handles.text_coordinates,'Visible','on');
    set(handles.text_press_enter,'Visible','on');
    set(handles.uitable_coordinates,'Visible','on');    
    set(handles.listbox_coordinates,'Visible','on');
    set(handles.text_number_coordinates,'Visible','on');    
    
    if(n==1)
        set(handles.text_coordinates,'String','Enter Freq & Q Values');
    else
        set(handles.text_coordinates,'String','Enter Freq & Damping Ratio Values');
    end
    
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(Vibrationdata_fea_damping);


% --- Executes on selection change in listbox_options.
function listbox_options_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_options contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_options
Change_Entry(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_options_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

Change_Entry(hObject, eventdata, handles);


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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' in sav ');

n_unit=get(handles.listbox_unit,'Value');
 
if(n_unit==1)  % Q
   dtype(2)=1; 
else      % dratio
   dtype(2)=2;
end
 
mopt=get(handles.listbox_options,'Value');
 
n_unit;
dtype;
mopt;
 
if(mopt==1) % uniform
 
    dtype(1)=1;
    
    A=str2num(get(handles.edit_value,'String'));
    
    if(n_unit==1) % Q
     
        Q=A;
        dratio= 1/(2*A);
        msgbox('Q Value Saved'); 
        
    else     % Damping Ratio
           
        dratio=A;
        Q= 1/(2*A);
        msgbox('Damping Value Saved'); 
    end
    
    setappdata(0,'uniform_Q',Q);
    setappdata(0,'uniform_dratio',dratio);
    setappdata(0,'damping_type',dtype);  
    
else  % table
    
    disp(' in table ');
    
    dtype(1)=2;
    
    m=get(handles.listbox_coordinates,'Value');
    N=m+1;
    
    try
        N;
        
        Z=get(handles.uitable_coordinates,'Data');
        
        try 
            A=char(Z);   
            B=str2num(A);
        catch
            try
              B=cell2mat(Z);
            catch
            end
        end    
 
        freq=B(1:N);
        amp=B((N+1):(2*N));
        
        freq=fix_size(freq);
        amp=fix_size(amp);
            
    catch
        warndlg('Warning: check coordinates');
        return; 
    end    
    
    n_unit;
    
    if(n_unit==1) % Q
        
        Qt=amp;
        
        clear dratio;
        dratio=zeros(N,1);
        for i=1:N
            dratio(i)= 1/(2*amp(i));
        end
        
            
    else     % Damping Ratio
        
        dratio=amp;
        
        clear Qt;
        Qt=zeros(N,1);
        for i=1:N
            Qt(i)= 1/(2*amp(i));
        end
        
    end
    
    disp('ref 1');
    
    freq=fix_size(freq);
    dratio=fix_size(dratio);
    
    dtab=[freq dratio];
    Qtab=[freq Qt];
    
    disp('ref 2');
    
    setappdata(0,'table_Q',Qtab);
    setappdata(0,'table_dratio',dtab); 
    dtype
    setappdata(0,'damping_type',dtype);  
    
    disp('ref 3');
    
    if(n_unit==1)
        msgbox('Q Table Saved');     
    else
        msgbox('Damping Table Saved'); 
    end
    
    disp('ref 4');
  
end





function edit_value_Callback(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_value as text
%        str2double(get(hObject,'String')) returns contents of edit_value as a double


% --- Executes during object creation, after setting all properties.
function edit_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_coordinates.
function listbox_coordinates_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_coordinates contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_coordinates

m=get(handles.listbox_coordinates,'Value');
n=m+1;

Nrows=n;
Ncolumns=2;
 
set(handles.uitable_coordinates,'Data',cell(Nrows,Ncolumns));



% --- Executes during object creation, after setting all properties.
function listbox_coordinates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_clear.
function pushbutton_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.edit_value,'String','');
set(handles.uitable_coordinates,'Data','');

a=[];

setappdata(0,'damping_type',a);
setappdata(0,'uniform_dratio',a);
setappdata(0,'table_dratio',a);
setappdata(0,'uniform_Q',a);
setappdata(0,'table_Q',a);

listbox_coordinates_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function pushbutton_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
