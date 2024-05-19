function varargout = Vibrationdata_Import_Model(varargin)
% VIBRATIONDATA_IMPORT_MODEL MATLAB code for Vibrationdata_Import_Model.fig
%      VIBRATIONDATA_IMPORT_MODEL, by itself, creates a new VIBRATIONDATA_IMPORT_MODEL or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_IMPORT_MODEL returns the handle to a new VIBRATIONDATA_IMPORT_MODEL or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_IMPORT_MODEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_IMPORT_MODEL.M with the given input arguments.
%
%      VIBRATIONDATA_IMPORT_MODEL('Property','Value',...) creates a new VIBRATIONDATA_IMPORT_MODEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_Import_Model_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_Import_Model_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_Import_Model

% Last Modified by GUIDE v2.5 06-Mar-2014 14:46:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_Import_Model_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_Import_Model_OutputFcn, ...
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


% --- Executes just before Vibrationdata_Import_Model is made visible.
function Vibrationdata_Import_Model_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_Import_Model (see VARARGIN)

% Choose default command line output for Vibrationdata_Import_Model
handles.output = hObject;

set(handles.listbox_method,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_Import_Model wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_Import_Model_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

n=get(hObject,'Value');


set(handles.pushbutton_read_data,'Visible','on');
set(handles.edit_input_array,'String',' ');

if(n==1)
   set(handles.edit_input_array,'enable','on'); 
   
else
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');
   
   set(handles.edit_input_array,'enable','off')    
end


% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Return.
function pushbutton_Return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(Vibrationdata_Import_Model);


% --- Executes on button press in pushbutton_read_data.
function pushbutton_read_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_method,'Value');

flag_ncoor=0;
flag_point_mass=0;
flag_dof_spring_property=0;
flag_dof_spring_element=0;
flag_rigid_link=0;
flag_damping_type=0;
flag_uniform_dratio=0;
flag_table_dratio=0;
flag_table_Q=0;
flag_uniform_Q=0;
flag_material=0;


j_nodes=1;
j_pm=1;
j_dof_spring=1;
j_dof_spring_element=1;
j_rigid_link=1;
j_damping_type=1;
j_uniform_dratio=1;
j_table_dratio=1;
j_table_Q=1;
j_uniform_Q=1;
j_material=0;


if(n==1)
    
    try
        FS=get(handles.edit_input_array,'String');
        THF=evalin('base',FS);       
    catch
        warndlg('Warning: input array does not exist');
        return; 
    end

    sz=size(THF);
   
    for i=1:sz(1)
%
        k1 = findstr(THF(i,:),'node');
        k2 = findstr(THF(i,:),'point_mass');
        k3 = findstr(THF(i,:),'dof_spring_property');
        k4 = findstr(THF(i,:),'dof_spring_element');
        k5 = findstr(THF(i,:),'rigid_link');
        
        k6 = findstr(THF(i,:),'damping_type');  
        k7 = findstr(THF(i,:),'uniform_dratio'); 
        k8 = findstr(THF(i,:),'table_dratio'); 
        k9 = findstr(THF(i,:),'table_Q'); 
        k10= findstr(THF(i,:),'uniform_Q'); 
%
        k11= findstr(THF(i,:),'material'); 
%
        if(k1>=1)
            new_string = strrep(THF(i,:),'node', '');
            ncoor(j_nodes,:)=str2num(new_string);
            j_nodes=j_nodes+1;
            flag_ncoor=1;
        end
%        
        if(k2>=1)
            new_string = strrep(THF(i,:),'point_mass', '');
            point_mass(j_pm,:)=str2num(new_string);
            j_pm=j_pm+1;
            flag_point_mass=1;
        end        
%
        if(k3>=1)
            new_string = strrep(THF(i,:),'dof_spring_property', '');
            dof_spring_property(j_dof_spring,:)=str2num(new_string);
            j_dof_spring=j_dof_spring+1;
            flag_dof_spring_property=1;
        end   
%
        if(k4>=1)
            new_string = strrep(THF(i,:),'dof_spring_element', '');
            dof_spring_element(j_dof_spring_element,:)=str2num(new_string);
            j_dof_spring_element=j_dof_spring_element+1;
            flag_dof_spring_element=1;
        end   
%
        if(k5>=1)
            new_string = strrep(THF(i,:),'rigid_link', '');
            rigid_link(j_rigid_link,:)=str2num(new_string);
            j_rigid_link=j_rigid_link+1;
            flag_rigid_link=1;
        end         
        
        if(k6>=1)
            new_string = strrep(THF(i,:),'damping_type', '');
            damping_type=str2num(new_string); % only one damping type allowed
            flag_damping_type=1;
        end    
        
        if(k7>=1)
            new_string = strrep(THF(i,:),'uniform_dratio', '');
            uniform_dratio=str2num(new_string); % only one uniform dratio allowed
            flag_uniform_dratio=1;
        end            
        
        if(k8>=1)
            new_string = strrep(THF(i,:),'table_dratio', '');
            table_dratio(j_table_dratio,:)=str2num(new_string);
            j_table_dratio=j_table_dratio+1;
            flag_table_dratio=1;
        end    
        
        if(k9>=1)
            new_string = strrep(THF(i,:),'table_Q', '');
            table_Q(j_table_Q,:)=str2num(new_string);
            j_table_Q=j_table_Q+1;
            flag_table_Q=1;
        end    
        
        if(k10>=1)
            new_string = strrep(THF(i,:),'uniform_Q', '');
            uniform_Q=str2num(new_string); % only one uniform Q allowed
            flag_uniform_Q=1;
        end    
        
        if(k11>=1)
            new_string = strrep(THF(i,:),'material', '');
            material(j_material,:)=str2num(new_string);
            j_material=j_material+1;
            flag_material=1;
        end    
%
    end   

end
   
if(n==2)
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');

   for i=1:20000000
%
        clear THF;
        THF = fgets(fid);
        if(THF==-1)
            if(max(size(THF))==1)
                break;
            end
        end
%
        k1 = findstr(THF,'node');
        k2 = findstr(THF,'point_mass');
        k3 = findstr(THF,'dof_spring_property');
        k4 = findstr(THF,'dof_spring_element');  
        k5 = findstr(THF,'rigid_link');        
        k6 = findstr(THF,'damping_type');  
        k7 = findstr(THF,'uniform_dratio');  
        k8 = findstr(THF,'table_dratio');  
        k9 = findstr(THF,'table_Q');          
        k10 = findstr(THF,'uniform_Q');          
        k11 = findstr(THF,'material');
        
%        
        if(k1>=1)
            new_string = strrep(THF,'node', '');
            ncoor(j_nodes,:)=str2num(new_string);
            j_nodes=j_nodes+1;
            flag_ncoor=1;
        end
%        
        if(k2>=1)
            new_string = strrep(THF,'point_mass', '');
            point_mass(j_pm,:)=str2num(new_string);
            j_pm=j_pm+1;
            flag_point_mass=1;
        end      
%        
        if(k3>=1)
            new_string = strrep(THF,'dof_spring_property', '');
            dof_spring_property(j_dof_spring,:)=str2num(new_string);
            j_dof_spring=j_dof_spring+1;
            flag_dof_spring_property=1;
        end       
%        
        if(k4>=1)
            new_string = strrep(THF,'dof_spring_element', '');
            dof_spring_element(j_dof_spring_element,:)=str2num(new_string);
            j_dof_spring_element=j_dof_spring_element+1;
            flag_dof_spring_element=1;
        end    
        if(k5>=1)
            new_string = strrep(THF,'rigid_link', '');
            rigid_link(j_rigid_link,:)=str2num(new_string);
            j_rigid_link=j_rigid_link+1;
            flag_rigid_link=1;
        end          
%             
        if(k6>=1)
            new_string = strrep(THF(i,:),'damping_type', '');
            damping_type=str2num(new_string); % only one damping type allowed
            flag_damping_type=1;
        end    
        
        if(k7>=1)
            new_string = strrep(THF(i,:),'uniform_dratio', '');
            uniform_dratio=str2num(new_string); % only one uniform dratio allowed
            flag_uniform_dratio=1;
        end            
        
        if(k8>=1)
            new_string = strrep(THF(i,:),'table_dratio', '');
            table_dratio(j_table_dratio,:)=str2num(new_string);
            j_table_dratio=j_table_dratio+1;
            flag_table_dratio=1;
        end    
        
        if(k9>=1)
            new_string = strrep(THF(i,:),'table_Q', '');
            table_Q(j_table_Q,:)=str2num(new_string);
            j_table_Q=j_table_Q+1;
            flag_table_Q=1;
        end    
        
        if(k10>=1)
            new_string = strrep(THF(i,:),'uniform_Q', '');
            uniform_Q=str2num(new_string); % only one uniform Q allowed
            flag_uniform_Q=1;
        end
        
        if(k11>=1)
            new_string = strrep(THF(i,:),'material', '');
            material(j_material,:)=str2num(new_string);
            j_material=j_material+1;
            flag_material=1;
        end   
        
%
   end          
   
end

if(n==3)
   [filename, pathname] = uigetfile('*.*');
   xfile = fullfile(pathname, filename);
%        
   [num,txt] = xlsread(xfile);
   
   n=size(num);
      
   for i=1:n
       k1 = findstr(char(txt(i)),'node'); 
       k2 = findstr(char(txt(i)),'point_mass');
       k3 = findstr(char(txt(i)),'dof_spring_property');
       k4 = findstr(char(txt(i)),'dof_spring_element');
       k5 = findstr(char(txt(i)),'rigid_link');
       k6 = findstr(char(txt(i)),'damping_type'); 
       k7 = findstr(char(txt(i)),'uniform_dratio');
       k8 = findstr(char(txt(i)),'table_dratio');
       k9 = findstr(char(txt(i)),'table_Q');
       k10= findstr(char(txt(i)),'uniform_Q');       
       k11= findstr(char(txt(i)),'material'); 
       
       if(k1>=1)
          ncoor(j_nodes,:)=num(i,:);
          j_nodes=j_nodes+1; 
          flag_ncoor=1;
       end    
%      
       if(k2>=1)
          point_mass(j_pm,:)=num(i,:);
          j_pm=j_pm+1;
          flag_point_mass=1;
       end
%      
       if(k3>=1)
          dof_spring_property(j_dof_spring,:)=num(i,:);
          j_dof_spring=j_dof_spring+1;
          flag_dof_spring_property=1;
       end
%      
       if(k4>=1)
          dof_spring_element(j_dof_spring_element,:)=num(i,:);
          j_dof_spring_element=j_dof_spring_element+1;
          flag_dof_spring_element=1;
       end       
       if(k5>=1)
          rigid_link(j_rigid_link,:)=num(i,:);
          j_rigid_link=j_rigid_link+1;
          flag_rigid_link=1;
       end
       
%%
       if(k6>=1)
          damping_type=num(i,:);
          flag_damping_type=1;
       end
       if(k7>=1)
          uniform_dratio=num(i,:);
          flag_uniform_dratio=1;
       end
       if(k8>=1)
          table_dratio(j_table_dratio,:)=num(i,:);
          table_dratio=j_table_dratio+1;
          flag_table_dratio=1;
       end
       if(k9>=1)
          table_Q(j_table_Q,:)=num(i,:);
          j_table_Q=j_table_Q+1;
          flag_table_Q=1;
       end
       if(k10>=1)
          uniform_Q=num(i,:);
          flag_uniform_Q=1;
       end       
%%
       if(k11>=1)
          material(j_material,:)=num(i,:);
          j_material=j_material+1;
          flag_material=1;
       end  
%%
   end
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kflag=0;

if(flag_rigid_link==1)
    rigid_link=rigid_link(:,1:8);
    rigid_link = sortrows(rigid_link,1);
    setappdata(0,'rigid_link',rigid_link);    
    kflag=1;
end

if(flag_dof_spring_element==1)
    dof_spring_element = sortrows(dof_spring_element,1);
    setappdata(0,'dof_spring_element',dof_spring_element);    
    kflag=1;
end

if(flag_dof_spring_property==1)
    dof_spring_property = sortrows(dof_spring_property,1);
    setappdata(0,'dof_spring_property',dof_spring_property);    
    kflag=1;
end

if(flag_point_mass==1)
    point_mass = sortrows(point_mass,1);
    setappdata(0,'point_mass',point_mass);    
    kflag=1;
end

if(flag_ncoor==1)
    ncoor = sortrows(ncoor,1);
    setappdata(0,'ncoor',ncoor);    
    kflag=1;
end

%%%

if(flag_damping_type==1)
    damping_type=damping_type(1:2);
    setappdata(0,'damping_type',damping_type);    
    kflag=1;
end

if(flag_uniform_dratio==1)
    uniform_dratio=uniform_dratio(1);
    uniform_dratio = sortrows(uniform_dratio,1);
    setappdata(0,'uniform_dratio',uniform_dratio);    
    kflag=1;
end

if(flag_uniform_Q==1)
    uniform_Q=uniform_Q(1);
    uniform_Q = sortrows(uniform_Q,1);
    setappdata(0,'uniform_Q',uniform_Q);    
    kflag=1;
end


if(flag_table_dratio==1)
    table_dratio=table_dratio(:,2);
    setappdata(0,'table_dratio',table_dratio);    
    kflag=1;
end

if(flag_table_Q==1)
    table_Q=table_Q(:,2);    
    setappdata(0,'table_Q',table_Q);    
    kflag=1;
end

if(flag_material==1)
    material=material(:,1:4);    
    setappdata(0,'material',material);    
    kflag=1;
end


%%%

if(kflag==1)
    
    if(flag_ncoor==1)
        sz=size(ncoor);
        out1=sprintf('Import File Complete.  %d nodes',sz(1));
        msgbox(out1);
    else
        out1=sprintf('Warning: Import File Complete.  zero nodes');
        wardbox(out1);
    end    
    
end

%% disp('go to plot');

%% ncoor

np=1;
Vibrationdata_Model_Plot(np);
  
