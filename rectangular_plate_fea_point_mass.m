function varargout = rectangular_plate_fea_point_mass(varargin)
% RECTANGULAR_PLATE_FEA_POINT_MASS MATLAB code for rectangular_plate_fea_point_mass.fig
%      RECTANGULAR_PLATE_FEA_POINT_MASS, by itself, creates a new RECTANGULAR_PLATE_FEA_POINT_MASS or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_PLATE_FEA_POINT_MASS returns the handle to a new RECTANGULAR_PLATE_FEA_POINT_MASS or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_PLATE_FEA_POINT_MASS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_PLATE_FEA_POINT_MASS.M with the given input arguments.
%
%      RECTANGULAR_PLATE_FEA_POINT_MASS('Property','Value',...) creates a new RECTANGULAR_PLATE_FEA_POINT_MASS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_plate_fea_point_mass_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_plate_fea_point_mass_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_plate_fea_point_mass

% Last Modified by GUIDE v2.5 08-May-2015 10:46:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_plate_fea_point_mass_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_plate_fea_point_mass_OutputFcn, ...
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


% --- Executes just before rectangular_plate_fea_point_mass is made visible.
function rectangular_plate_fea_point_mass_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_plate_fea_point_mass (see VARARGIN)

% Choose default command line output for rectangular_plate_fea_point_mass
handles.output = hObject;

pushbutton_reset_Callback(hObject, eventdata, handles);

iu=getappdata(0,'iu');

if(iu==1)
    set(handles.text_mass,'String','Mass (lbm)');
else
    set(handles.text_mass,'String','Mass (kg)');    
end



try

    THM=evalin('base','point_mass_matrix');   
    point_mass_matrix=THM;
    point_mass_matrix=unique(point_mass_matrix,'rows');    
    setappdata(0,'point_mass_matrix',point_mass_matrix)
       
    n=length(point_mass_matrix(:,1));
            
    k=1;
    for i=1:n
    
        node=point_mass_matrix(i,1);
        mass=point_mass_matrix(i,2);
   
        if(node>0)
            string_f{k}=sprintf('%g  %g',node,mass);
            k=k+1;
        end    
    
    end

    if(n>=1)
        set(handles.listbox_point_mass,'String',string_f);
    end
         
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rectangular_plate_fea_point_mass wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rectangular_plate_fea_point_mass_OutputFcn(hObject, eventdata, handles) 
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

point_mass_matrix=getappdata(0,'point_mass_matrix');
assignin('base', 'point_mass_matrix', point_mass_matrix);

%% vibrationdata_rectangular_plate_fea('update_all_masses',hObject, eventdata, handles)

close(rectangular_plate_fea_point_mass);


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


point_mass_matrix=getappdata(0,'point_mass_matrix');
iu=getappdata(0,'iu');

sz=size(point_mass_matrix);

N=sz(1);

node_matrix=getappdata(0,'node_matrix');

sz=size(node_matrix);

if(max(sz)<=0)
    warndlg('node_matrix does not exist');
    return;
end


dx=getappdata(0,'dx');
dy=getappdata(0,'dy');



fig_num=200;
h=figure(fig_num);

if(iu==1)
    plot(node_matrix(:,1),node_matrix(:,2),'.');
else
    plot(1000*node_matrix(:,1),1000*node_matrix(:,2),'.');    
end

%
clear nodex;
clear nodey;
nodex=node_matrix(:,1);
nodey=node_matrix(:,2);
%

%
for i=1:N
   if(point_mass_matrix(i,1)>0) 
       
        string=sprintf('%d %g',point_mass_matrix(i,1),point_mass_matrix(i,2));
  
        p=point_mass_matrix(i,1);
        
        if(iu==1)
            text(nodex(p),nodey(p),string);
        else
            text(1000*nodex(p),1000*nodey(p),string);            
        end
            
   end     
end
if(iu==1)
    title('Point Masses (node, lbm)');
    xlabel('X (in)');
    ylabel('Y (in)');
else
    title('Point Masses (node, kg)');    
    xlabel('X (mm)');
    ylabel('Y (mm)');    
end
grid on;
%
xmax=max(nodex)+dx/2;
ymax=max(nodey)+dy/2;
%
xmin=min(nodex)-dx/2;
ymin=min(nodey)-dy/2;
%
axis([xmin,xmax,ymin,ymax]);

%
xmax=max(nodex)+dx/2;
ymax=max(nodey)+dy/2;
%
xmin=min(nodex)-dx/2;
ymin=min(nodey)-dy/2;
%
if(iu==1)
    axis([xmin,xmax,ymin,ymax]);
else
    xxmin=xmin*1000;
    xxmax=xmax*1000;    
    yymin=ymin*1000;
    yymax=ymax*1000;       
    axis([xxmin,xxmax,yymin,yymax]);    
end    
%




pname='point_mass.png';        
out1=sprintf('plot file:   %s',pname);
disp(out1);
set(gca,'Fontsize',12);
print(h,pname,'-dpng','-r300');




% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


point_mass_matrix=zeros(1,2);
setappdata(0,'point_mass_matrix',point_mass_matrix);
set(handles.listbox_point_mass,'String','')



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


% --- Executes on button press in pushbutton_enter_data.
function pushbutton_enter_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

point_mass_matrix=getappdata(0,'point_mass_matrix');

try
    point_mass_matrix=sortrows(point_mass_matrix,1);
catch
    disp('ref 1');
    point_mass_matrix=zeros(1,2);
end
    

sz=size(point_mass_matrix);
n=sz(1);



node=str2num(get(handles.edit_node,'String'));
mass=str2num(get(handles.edit_mass,'String'));


if(point_mass_matrix(1,1)==0)
    point_mass_matrix=[node mass];
else
    point_mass_matrix(n+1,1)=node;
    point_mass_matrix(n+1,2)=mass;    
end
    
point_mass_matrix=unique(point_mass_matrix,'rows');

n=length(point_mass_matrix(:,1));

setappdata(0,'point_mass_matrix',point_mass_matrix);



k=1;
for i=1:n
    
    node=point_mass_matrix(i,1);
    mass=point_mass_matrix(i,2);
   
    if(node>0)
        string_f{k}=sprintf('%d, %6.3g',node,mass);
        k=k+1;
    end    
    
end



set(handles.listbox_point_mass,'String',string_f)


function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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
