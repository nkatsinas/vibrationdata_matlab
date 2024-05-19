function varargout = Vibrationdata_fea_Analyze(varargin)
% VIBRATIONDATA_FEA_ANALYZE MATLAB code for Vibrationdata_fea_Analyze.fig
%      VIBRATIONDATA_FEA_ANALYZE, by itself, creates a new VIBRATIONDATA_FEA_ANALYZE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FEA_ANALYZE returns the handle to a new VIBRATIONDATA_FEA_ANALYZE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FEA_ANALYZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FEA_ANALYZE.M with the given input arguments.
%
%      VIBRATIONDATA_FEA_ANALYZE('Property','Value',...) creates a new VIBRATIONDATA_FEA_ANALYZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_fea_Analyze_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_fea_Analyze_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_fea_Analyze

% Last Modified by GUIDE v2.5 15-Mar-2017 12:06:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_fea_Analyze_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_fea_Analyze_OutputFcn, ...
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


% --- Executes just before Vibrationdata_fea_Analyze is made visible.
function Vibrationdata_fea_Analyze_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_fea_Analyze (see VARARGIN)

% Choose default command line output for Vibrationdata_fea_Analyze
handles.output = hObject;

set(handles.uipanel_mode,'Visible','off');

try
    mass=getappdata(0,'mass',mass);
    stiffness=getappdata(0,'stiffness',stiffness);    
    set(handles.pushbutton_solve_normal_modes,'Enable','on');     
    
catch
    
    set(handles.pushbutton_solve_normal_modes,'Enable','off');    
end

set(handles.listbox_save,'Value',1);
listbox_save_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_fea_Analyze wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_fea_Analyze_OutputFcn(hObject, eventdata, handles) 
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

delete(Vibrationdata_fea_Analyze);


% --- Executes on button press in pushbutton_mass_stiffness.
function pushbutton_mass_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mass_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_FRF,'Enable','off');
set(handles.pushbutton_plot_mode_shapes,'Enable','off');
set(handles.uipanel_mode,'Visible','off');

set(handles.pushbutton_solve_normal_modes,'Enable','off');

try
    ncoor=getappdata(0,'ncoor');
    sz=size(ncoor);
    num_ncoor=sz(1);
catch
    warndlg('No existing nodes');
    return;
end

%%%%%%%%%

try
    point_mass=getappdata(0,'point_mass');
    sz=size(point_mass);
    num_point_mass=sz(1);    
catch
end

%%%%%%%%%

try
    dof_spring_property=getappdata(0,'dof_spring_property');
    sz=size(dof_spring_property);
    num_dof_spring_property=sz(1);    
catch
end    

%%%%%%%%%

try
    dof_spring_element=getappdata(0,'dof_spring_element');
    sz=size(dof_spring_element);
    num_dof_spring_element=sz(1);     
catch
end    

try
    rigid_link=getappdata(0,'rigid_link');
    sz=size(rigid_link);
    num_rigid_link=sz(1);     
catch
end    

num_ncoor;

if(num_ncoor==1)
    warndlg('Only one node');
end
if(num_ncoor>=2)
    
    m=num_point_mass+2*num_dof_spring_element;
    
    node=zeros(m,1);
    
    j=1;
    
    for i=1:num_point_mass
        node(j)=point_mass(i,1);
        j=j+1;
    end
    
    for i=1:num_dof_spring_element
        node(j)=dof_spring_element(i,2);        
        j=j+1;   
        node(j)=dof_spring_element(i,3);  
        j=j+1;        
    end    
    
    node;

    grid = unique(node);
    grid = sort(grid);
    
    clear length;
    grid_length=length(grid);
    
    ndof=6*grid_length;
    
         mass=zeros(ndof,ndof);
    stiffness=zeros(ndof,ndof);
    
%%

    dof_map=zeros(ndof,2);
    
    for i=1:grid_length
        k=1;
        
        dof_map(6*i-5,1)=i;
        dof_map(6*i-5,2)=k;
    
        dof_map(6*i-4,1)=i;
        dof_map(6*i-4,2)=k+1;
        
        dof_map(6*i-3,1)=i;
        dof_map(6*i-3,2)=k+2;
         
        dof_map(6*i-2,1)=i;
        dof_map(6*i-2,2)=k+3;
    
        dof_map(6*i-1,1)=i;
        dof_map(6*i-1,2)=k+4;
        
        dof_map(6*i,1)=i;
        dof_map(6*i,2)=k+5;       
        
    end


%%
    
    for i=1:num_point_mass
    
        for k=1:grid_length
            if(grid(k)==point_mass(i,1))
                j=6*k-5;
                break;
            end
        end
        
        if(j==0)
            warndlg('Point mass grid not detected');
        end
        
            mass(j,j)=point_mass(i,2);
        mass(j+1,j+1)=point_mass(i,2);
        mass(j+2,j+2)=point_mass(i,2);       
        mass(j+3,j+3)=point_mass(i,3);       
        mass(j+4,j+4)=point_mass(i,4);
        mass(j+5,j+5)=point_mass(i,5);      
    end    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for i=1:num_dof_spring_element
                
        
        for k=1:num_dof_spring_property
            if(dof_spring_property(k,1)==dof_spring_element(i,1))
                kx=dof_spring_property(k,2);
                ky=dof_spring_property(k,3);
                kz=dof_spring_property(k,4);
                kthetax=dof_spring_property(k,5);
                kthetay=dof_spring_property(k,6);
                kthetaz=dof_spring_property(k,7);
            end
        end
        
 
        for k=1:grid_length
            if(grid(k)==dof_spring_element(i,2))
                d1=6*k-5;
                break;
            end
        end    
        
        for k=1:grid_length
            if(grid(k)==dof_spring_element(i,3))
                d2=6*k-5;
                break;
            end
        end 
 
        d1;
        d2;
    
        s=zeros(12,12);
        
        s(1,1)= kx;
        s(1,7)=-kx;
        s(7,7)= kx;
        
        s(2,2)= ky;
        s(2,8)=-ky;
        s(8,8)= ky;
        
        s(3,3)= kz;
        s(3,9)=-kz;
        s(9,9)= kz;        
         
        s(4,4)= kthetax;
        s(4,10)=-kthetax;
        s(10,10)= kthetax;
        
        s(5,5)= kthetay;
        s(5,11)=-kthetay;
        s(11,11)= kthetay;
        
        s(6,6)= kthetaz;
        s(6,12)=-kthetaz;
        s(12,12)= kthetaz;       
        
        for ij=1:11
            for kj=(ij+1):12
                s(kj,ij)=s(ij,kj);
            end
        end    
        
        T=zeros(12,ndof);
        
           T(1,d1)=1;
         T(2,d1+1)=1;
         T(3,d1+2)=1;
         T(4,d1+3)=1;
         T(5,d1+4)=1;
         T(6,d1+5)=1; 
        
           T(7,d2)=1;
         T(8,d2+1)=1;
         T(9,d2+2)=1;        
        T(10,d2+3)=1;
        T(11,d2+4)=1;
        T(12,d2+5)=1;         
            
        stiffness=stiffness+(T'*s*T);
        
    end
    
    stiffness;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    j=1;
    
    for i=1:num_ncoor

        if(ncoor(i,5)==1)
            cdof(j)=6*i-5;
            j=j+1;
        end
        if(ncoor(i,6)==1)
            cdof(j)=6*i-4;
            j=j+1;
        end        
        if(ncoor(i,7)==1)
            cdof(j)=6*i-3;
            j=j+1;
        end        
        if(ncoor(i,8)==1)
            cdof(j)=6*i-2;
            j=j+1;
        end
        if(ncoor(i,9)==1)
            cdof(j)=6*i-1;
            j=j+1;
        end        
        if(ncoor(i,10)==1)
            cdof(j)=6*i;
            j=j+1;
        end   
    end
    
    nc=j-1;
        
        
    for nv=nc:-1:1
            
        k=cdof(nv);
        
%%        out1=sprintf('k=%d',k);
%%        disp(out1);
            
        mass(k,:)=[];
        mass(:,k)=[];
            
        stiffness(k,:)=[];
        stiffness(:,k)=[];
    
        dof_map(k,:)=[];
        
    end

    dof_map;
    
    if(num_rigid_link>=1)
    
        rigid_link=sortrows(rigid_link,2);
        rigid_link=flipud(rigid_link);
    
        rigid_link;
        
        mass;
        
        sz=size(dof_map);
        nn=sz(1);
        
        for i=1:num_rigid_link
            
            ds=0;
            dp=0;
            
            for j=1:nn
                if(rigid_link(i,1)==dof_map(j,1))
                    np=rigid_link(i,1);
                    dp=j;
                    d2=dof_map(j,2);
                    break;
                end                
            end
            
            for j=1:nn             
                if(rigid_link(i,2)==dof_map(j,1))
                    ns=rigid_link(i,2);
                    ds=j; 
                    break;
                end
            end
            
            
%            out1=sprintf(' i=%d  dp=%d  ds=%d   ',i,dp,ds);
%            disp(out1);
            
            if(ds>0 && dp>0)
                
                mass(dp,:)=mass(dp,:)+mass(ds,:);
                mass(ds,:)=[];
                mass(:,dp)=mass(:,dp)+mass(:,ds);
                mass(:,ds)=[];
                
                stiffness(dp,:)=stiffness(dp,:)+stiffness(ds,:);
                stiffness(ds,:)=[];
                stiffness(:,dp)=stiffness(:,dp)+stiffness(:,ds);
                stiffness(:,ds)=[];                
                
            end
            
        end
    
    end
    
    mass;
 
%  Check for zeros on mass diagonal

    sz=size(mass);
    
    iflag=1;
    
    for i=1:sz(1)
        if(abs(mass(i,i)<=1.0e-20))
            iflag=0;
        end
    end
    
    if(iflag==0)
        warndlg('Warning: mass matrix has zero on diagonal');
    end    
    
%
 
    mass
    stiffness

    setappdata(0,'mass',mass);
    setappdata(0,'stiffness',stiffness);  
 
    msgbox('Mass & Stiffness Matrices Generated');
    
    set(handles.pushbutton_solve_normal_modes,'Enable','on');
    
end




% --- Executes on button press in pushbutton_solve_normal_modes.
function pushbutton_solve_normal_modes_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_solve_normal_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_FRF,'Enable','off');

kflag=1;

try
    ncoor=getappdata(0,'ncoor');
    sz=size(ncoor);
    n_nodes=sz(1);
catch
    warndlg('No existing nodes');
    return;
end

try
    mass=getappdata(0,'mass');
catch
    warndlg('Warning: mass matrix does not exist');
    kflag=0;
end

try
    stiffness=getappdata(0,'stiffness');  
catch
    warndlg('Warning: stiffness matrix does not exist');    
    kflag=0;
end    
    
    
if(kflag==1)
    [fn,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);
    
    fn=fix_size(fn);
    setappdata(0,'fn',fn);
    setappdata(0,'ModeShapes',ModeShapes);  
    
    clear length;
    dof=length(fn);
    
	disp(' Natural Frequencies ');
    disp(' n     f(Hz)');

    for i=1:dof
        out1=sprintf(' %d %10.5g ',i,fn(i));
        disp(out1);
    end

    ModeShapes
    
%%

    % ModeShapes;

    tdof=n_nodes*6;

    MSF=zeros(tdof,dof);
    
    adof=1;
    
%%%    size(MSF)
%%%    size(ModeShapes)
    
    for i=1:n_nodes
        
        if(ncoor(i,5)==0)
            bdof=6*i-5;
            MSF(bdof,:)=ModeShapes(adof,:);
            adof=adof+1;
        end    
        if(ncoor(i,6)==0)
            bdof=6*i-4;
            MSF(bdof,:)=ModeShapes(adof,:);
            adof=adof+1;
        end  
        if(ncoor(i,7)==0)
            bdof=6*i-3;
            MSF(bdof,:)=ModeShapes(adof,:);
            adof=adof+1;
        end          
        if(ncoor(i,8)==0)
            bdof=6*i-2;
            MSF(bdof,:)=ModeShapes(adof,:);
            adof=adof+1;
        end    
        if(ncoor(i,9)==0)
            bdof=6*i-1;
            MSF(bdof,:)=ModeShapes(adof,:);
            adof=adof+1;            
        end  
        if(ncoor(i,10)==0)
            bdof=6*i;
            MSF(bdof,:)=ModeShapes(adof,:);
            adof=adof+1;
        end         
       
    end

    for i=1:dof
       MSF(:,i)=MSF(:,i)/max(abs(MSF(:,i)));
    end
%%
    
    msgbox('Results written to Matlab Command Window');
    
    setappdata(0,'MSF',MSF);
    
    set(handles.pushbutton_FRF,'Enable','on');
    set(handles.pushbutton_plot_mode_shapes,'Enable','on');    
    set(handles.uipanel_mode,'Visible','on');
    
    n=length(fn);

    set(handles.listbox_mode, 'String', '');

    for i=1:n
        string_f{i}=sprintf('%d',i);  
    end

    set(handles.listbox_mode,'String',string_f); 
    
else
    errordlg('Analysis failed');
end


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save

n=get(handles.listbox_save,'Value');

if(n==1)
    set(handles.text_name1,'String','Mass');
    set(handles.text_name2,'String','Stiffness');
else
    set(handles.text_name1,'String','Natural Freq (Hz)'); 
    set(handles.text_name2,'String','Normal Modes');      
end


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
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

n=get(handles.listbox_save,'Value');

if(n==1)
    data1=getappdata(0,'mass');
    data2=getappdata(0,'stiffness');
else
    data1=getappdata(0,'fn');
    data2=getappdata(0,'ModeShapes');    
end    

output_name1=get(handles.edit_name1,'String');
output_name2=get(handles.edit_name2,'String');

assignin('base', output_name1,data1);
assignin('base', output_name2,data2);

msgbox('Save Complete');


function edit_name1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name1 as text
%        str2double(get(hObject,'String')) returns contents of edit_name1 as a double


% --- Executes during object creation, after setting all properties.
function edit_name1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_name2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name2 as text
%        str2double(get(hObject,'String')) returns contents of edit_name2 as a double


% --- Executes during object creation, after setting all properties.
function edit_name2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_FRF.
function pushbutton_FRF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Vibrationdata_fea_frf;    

set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_damping.
function pushbutton_damping_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=Vibrationdata_fea_damping;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_plot_mode_shapes.
function pushbutton_plot_mode_shapes_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_mode_shapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fn=getappdata(0,'fn');
MSF=getappdata(0,'MSF');

num=get(handles.listbox_mode,'Value');
 np=get(handles.listbox_v,'Value');

Vibrationdata_Model_Plot_ModeShapes(np,fn,MSF,num);




% --- Executes on selection change in listbox_mode.
function listbox_mode_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mode


% --- Executes during object creation, after setting all properties.
function listbox_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_v.
function listbox_v_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_v contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_v


% --- Executes during object creation, after setting all properties.
function listbox_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
