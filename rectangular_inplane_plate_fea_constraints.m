function varargout = rectangular_inplane_plate_fea_constraints(varargin)
% RECTANGULAR_INPLANE_PLATE_FEA_CONSTRAINTS MATLAB code for rectangular_inplane_plate_fea_constraints.fig
%      RECTANGULAR_INPLANE_PLATE_FEA_CONSTRAINTS, by itself, creates a new RECTANGULAR_INPLANE_PLATE_FEA_CONSTRAINTS or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_INPLANE_PLATE_FEA_CONSTRAINTS returns the handle to a new RECTANGULAR_INPLANE_PLATE_FEA_CONSTRAINTS or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_INPLANE_PLATE_FEA_CONSTRAINTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_INPLANE_PLATE_FEA_CONSTRAINTS.M with the given input arguments.
%
%      RECTANGULAR_INPLANE_PLATE_FEA_CONSTRAINTS('Property','Value',...) creates a new RECTANGULAR_INPLANE_PLATE_FEA_CONSTRAINTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_inplane_plate_fea_constraints_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_inplane_plate_fea_constraints_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_inplane_plate_fea_constraints

% Last Modified by GUIDE v2.5 02-Feb-2016 17:10:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_inplane_plate_fea_constraints_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_inplane_plate_fea_constraints_OutputFcn, ...
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


% --- Executes just before rectangular_inplane_plate_fea_constraints is made visible.
function rectangular_inplane_plate_fea_constraints_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_inplane_plate_fea_constraints (see VARARGIN)

% Choose default command line output for rectangular_inplane_plate_fea_constraints
handles.output = hObject;

try
    fig_num=getappdata(0,'fig_num');
catch
    fig_num=1;
end
setappdata(0,'fig_num',fig_num)

set(handles.topBClistbox,'Value',1);
set(handles.leftBClistbox,'Value',1);
set(handles.bottomBClistbox,'Value',1);
set(handles.rightBClistbox,'Value',1);

ip_constraint_matrix_right=[0 0 0];
ip_constraint_matrix_top=[0 0 0];
ip_constraint_matrix_left=[0 0 0];
ip_constraint_matrix_bottom=[0 0 0];
ip_constraint_matrix_added=[0 0 0];



setappdata(0,'ip_constraint_matrix_right',ip_constraint_matrix_right);
setappdata(0,'ip_constraint_matrix_top',ip_constraint_matrix_top);
setappdata(0,'ip_constraint_matrix_left',ip_constraint_matrix_left);
setappdata(0,'ip_constraint_matrix_bottom',ip_constraint_matrix_bottom);
setappdata(0,'ip_constraint_matrix_added',ip_constraint_matrix_added);

Ux_only=[1 0 ];   
Uy_only=[0 1 ];
fixed=[1 1 ]; 


setappdata(0,'fixed',fixed);
setappdata(0,'Ux_only',Ux_only);
setappdata(0,'Uy_only',Uy_only);


%%%%%%%

set(hObject, 'Units', 'pixels');
axes(handles.axes1);
bg = imread('plate_inplane_image.jpg');
info.Width=235;
info.Height=121;
 
axes(handles.axes1);
image(bg);
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [170 140 info.Width info.Height]);
axis off; 

%%%%%%%

    
try
        THM=evalin('base','ip_constraint_matrix');   
        ip_constraint_matrix=THM;
        ip_constraint_matrix=unique(ip_constraint_matrix,'rows');    
        setappdata(0,'ip_constraint_matrix',ip_constraint_matrix);
        setappdata(0,'ip_constraint_matrix_added',ip_constraint_matrix_added);    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% combine

            for ijk=1:5

                sz=size(ip_constraint_matrix);

                N=sz(1);

                for i=1:N-1
                    for j=i+1:N
                        if(ip_constraint_matrix(i,1)==ip_constraint_matrix(j,1))
                            for k=2:3
                                an=ip_constraint_matrix(i,k)+ip_constraint_matrix(j,k);
                                if(an>1)
                                    an=1;
                                end
                                ip_constraint_matrix(i,k)=an;
                                ip_constraint_matrix(j,k)=an;
                            end
                        end    
                    end    
                end    
    
            end

            ip_constraint_matrix=unique(ip_constraint_matrix,'rows');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            sz=size(ip_constraint_matrix);
            N=sz(1);

            k=1;
            for i=1:N
                if(ip_constraint_matrix(i,1)>0)
                    string_f{k}=sprintf(' %d %d %d ',ip_constraint_matrix(i,1),ip_constraint_matrix(i,2),ip_constraint_matrix(i,3));
                    k=k+1;
                end         
            end   

            set(handles.listbox_constrained_nodes,'String',string_f); 
 
catch 
                set(handles.listbox_constrained_nodes,'String',' '); 
end

try
    ematrix=evalin('base','ematrix');
            
    e1=ematrix(1);
    e2=ematrix(2);
    e3=ematrix(3);
    e4=ematrix(4);    

    if(e1==0)
        e1=1;
    end
    if(e2==0)
        e2=1;
    end    
    if(e3==0)
        e3=1;
    end
    if(e4==0)
        e4=1;
    end   
        
    set(handles.bottomBClistbox,'Value',e1);
    set(handles.rightBClistbox,'Value',e2);
    set(handles.topBClistbox,'Value',e3);
    set(handles.leftBClistbox,'Value',e4);
end


%%%%%%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rectangular_inplane_plate_fea_constraints wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rectangular_inplane_plate_fea_constraints_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function update_constraints_Callback(hObject, eventdata, handles)
%

ip_constraint_matrix_right=getappdata(0,'ip_constraint_matrix_right');
ip_constraint_matrix_left=getappdata(0,'ip_constraint_matrix_left');
ip_constraint_matrix_top=getappdata(0,'ip_constraint_matrix_top');
ip_constraint_matrix_bottom=getappdata(0,'ip_constraint_matrix_bottom');

ip_constraint_matrix_added=getappdata(0,'ip_constraint_matrix_added');


ip_constraint_matrix=[ ip_constraint_matrix_right;...
                    ip_constraint_matrix_left; ...
                    ip_constraint_matrix_top;  ...
                    ip_constraint_matrix_bottom; ... 
                    ip_constraint_matrix_added];

ip_constraint_matrix=sortrows(ip_constraint_matrix,1);


iflag=1;

while(iflag==1)
    
    iflag=0;
    
    N=length(ip_constraint_matrix(:,1));

    for i=1:N
        if(ip_constraint_matrix(i,1)==0)
            ip_constraint_matrix(i,:)=[];
            iflag=1;
            break;
        end
    end

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% combine

for ijk=1:5

    sz=size(ip_constraint_matrix);

    N=sz(1);

    for i=1:N-1
        for j=i+1:N
            if(ip_constraint_matrix(i,1)==ip_constraint_matrix(j,1))
                for k=2:3
                    an=ip_constraint_matrix(i,k)+ip_constraint_matrix(j,k);
                    if(an>1)
                        an=1;
                    end
                    ip_constraint_matrix(i,k)=an;
                    ip_constraint_matrix(j,k)=an;
                end
            end    
        end    
    end    

end

ip_constraint_matrix=unique(ip_constraint_matrix,'rows');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


sz=size(ip_constraint_matrix);
N=sz(1);

for i=1:N
    string_f{i}=sprintf(' %d %d %d',ip_constraint_matrix(i,1),ip_constraint_matrix(i,2),ip_constraint_matrix(i,3));
end   

if(N>=1)
    set(handles.listbox_constrained_nodes,'String',string_f); 
else
    set(handles.listbox_constrained_nodes,'String','');     
end

setappdata(0,'ip_constraint_matrix',ip_constraint_matrix);
assignin('base', 'ip_constraint_matrix', ip_constraint_matrix);

e1=get(handles.bottomBClistbox,'Value');
e2=get(handles.rightBClistbox,'Value');
e3=get(handles.topBClistbox,'Value');
e4=get(handles.leftBClistbox,'Value');

ematrix=[e1 e2 e3 e4];
assignin('base', 'ematrix', ematrix);


% --- Executes on button press in pushbutton_update_return.
function pushbutton_update_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ip_constraint_matrix=getappdata(0,'ip_constraint_matrix');
assignin('base', 'ip_constraint_matrix', ip_constraint_matrix);

delete(rectangular_inplane_plate_fea_constraints);


% --- Executes on selection change in topBClistbox.
function topBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to topBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns topBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from topBClistbox

nx=getappdata(0,'nx');
ny=getappdata(0,'ny');

fixed=getappdata(0,'fixed');
Uy_only=getappdata(0,'Uy_only');
Ux_only=getappdata(0,'Ux_only');
ip_constraint_matrix_top=zeros(1,3);

icn=1;

e3=get(handles.topBClistbox,'Value');


if(e3==2)     
    for i=(nx*(ny-1)+1):(nx*ny) 
        ip_constraint_matrix_top(icn,:)=[i Ux_only];
        icn=icn+1;
    end        
end
if(e3==3)     
    for i=(nx*(ny-1)+1):(nx*ny) 
        ip_constraint_matrix_top(icn,:)=[i Uy_only];
        icn=icn+1;
    end        
end
if(e3==4)  
    for i=(nx*(ny-1)+1):(nx*ny) 
        ip_constraint_matrix_top(icn,:)=[i fixed];
        icn=icn+1;
    end
end   

setappdata(0,'ip_constraint_matrix_top',ip_constraint_matrix_top);

update_constraints_Callback(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function topBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to topBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in leftBClistbox.
function leftBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns leftBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from leftBClistbox

ip_constraint_matrix_added=getappdata(0,'ip_constraint_matrix_added');



nx=getappdata(0,'nx');
ny=getappdata(0,'ny');

fixed=getappdata(0,'fixed');
Uy_only=getappdata(0,'Uy_only');
Ux_only=getappdata(0,'Ux_only');
ip_constraint_matrix_left=zeros(1,3);

icn=1;

e4=get(handles.leftBClistbox,'Value');

if(e4==2)
	ijk=1;
    for j=1:ny
            ip_constraint_matrix_left(icn,:)=[ijk Ux_only];
            icn=icn+1;             
            ijk=ijk+nx;
    end          
end
if(e4==3)
	ijk=1;
    for j=1:ny
            ip_constraint_matrix_left(icn,:)=[ijk Uy_only];
            icn=icn+1;             
            ijk=ijk+nx;
    end          
end
if(e4==4)
    ijk=1;
    for j=1:ny
        ip_constraint_matrix_left(icn,:)=[ijk fixed];
        icn=icn+1;  
        ijk=ijk+nx;
    end     
end   



setappdata(0,'ip_constraint_matrix_left',ip_constraint_matrix_left);

update_constraints_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function leftBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rightBClistbox.
function rightBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rightBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rightBClistbox

nx=getappdata(0,'nx');
ny=getappdata(0,'ny');

fixed=getappdata(0,'fixed');
Uy_only=getappdata(0,'Uy_only');
Ux_only=getappdata(0,'Ux_only');
ip_constraint_matrix_right=zeros(1,3);

icn=1;

e2=get(handles.rightBClistbox,'Value');

if(e2==2)
    ijk=nx;
    for j=1:ny
        ip_constraint_matrix_right(icn,:)=[ijk Ux_only];
        icn=icn+1;           
        ijk=ijk+nx;
    end        
end
if(e2==3)
    ijk=nx;
    for j=1:ny
        ip_constraint_matrix_right(icn,:)=[ijk Uy_only];
        icn=icn+1;           
        ijk=ijk+nx;
    end        
end
if(e2==4)
     ijk=nx;
     for j=1:ny
         ip_constraint_matrix_right(icn,:)=[ijk fixed];
         icn=icn+1;           
         ijk=ijk+nx;
     end          
end

setappdata(0,'ip_constraint_matrix_right',ip_constraint_matrix_right);

update_constraints_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function rightBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in bottomBClistbox.
function bottomBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to bottomBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns bottomBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bottomBClistbox

nx=getappdata(0,'nx');
ny=getappdata(0,'ny');

fixed=getappdata(0,'fixed');
Uy_only=getappdata(0,'Uy_only');
Ux_only=getappdata(0,'Ux_only');
ip_constraint_matrix_bottom=zeros(1,3);

icn=1;

e1=get(handles.bottomBClistbox,'Value');

if(e1==2)
    for i=1:nx
        ip_constraint_matrix_bottom(icn,:)=[i Ux_only];
        icn=icn+1;
    end        
end
if(e1==3)
    for i=1:nx
        ip_constraint_matrix_bottom(icn,:)=[i Uy_only];
        icn=icn+1;
    end        
end
if(e1==4)
    for i=1:nx 
        ip_constraint_matrix_bottom(icn,:)=[i fixed];
        icn=icn+1;
    end
end

setappdata(0,'ip_constraint_matrix_bottom',ip_constraint_matrix_bottom);

update_constraints_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function bottomBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bottomBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.topBClistbox,'Value',1);
set(handles.leftBClistbox,'Value',1);
set(handles.bottomBClistbox,'Value',1);
set(handles.rightBClistbox,'Value',1);

ip_constraint_matrix_top=zeros(1,3);
ip_constraint_matrix_left=zeros(1,3);
ip_constraint_matrix_bottom=zeros(1,3);
ip_constraint_matrix_right=zeros(1,3);

ip_constraint_matrix_added=zeros(1,3);



setappdata(0,'ip_constraint_matrix_top',ip_constraint_matrix_top);
setappdata(0,'ip_constraint_matrix_left',ip_constraint_matrix_left);
setappdata(0,'ip_constraint_matrix_bottom',ip_constraint_matrix_bottom);
setappdata(0,'ip_constraint_matrix_right',ip_constraint_matrix_right);

setappdata(0,'ip_constraint_matrix_added',ip_constraint_matrix_added);

ip_constraint_matrix=zeros(1,3);
setappdata(0,'ip_constraint_matrix',ip_constraint_matrix);
assignin('base', 'ip_constraint_matrix','');

ematrix=zeros(1,3);
setappdata(0,'ematrix',ematrix);
assignin('base', 'ematrix','');

set(handles.listbox_constrained_nodes,'String',''); 


update_constraints_Callback(hObject, eventdata, handles);

% --- Executes on selection change in listbox_pinned_nodes.
function listbox_pinned_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pinned_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pinned_nodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pinned_nodes


% --- Executes during object creation, after setting all properties.
function listbox_pinned_nodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pinned_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_constrained_nodes.
function listbox_constrained_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_constrained_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_constrained_nodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_constrained_nodes


% --- Executes during object creation, after setting all properties.
function listbox_constrained_nodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_constrained_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_add_rx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_add_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_add_rx as text
%        str2double(get(hObject,'String')) returns contents of edit_add_rx as a double


% --- Executes during object creation, after setting all properties.
function edit_add_rx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_add_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_add_rx.
function pushbutton_add_rx_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_add_constraint_Callback(hObject, eventdata, handles)
% hObject    handle to edit_add_constraint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_add_constraint as text
%        str2double(get(hObject,'String')) returns contents of edit_add_constraint as a double


% --- Executes during object creation, after setting all properties.
function edit_add_constraint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_add_constraint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_add_constraint.
function pushbutton_add_constraint_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_constraint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

k=get(handles.listbox_constraint,'Value');

n=str2num(get(handles.edit_add_constraint,'String'));

ip_constraint_matrix_added=getappdata(0,'ip_constraint_matrix');

sz=size(ip_constraint_matrix_added);


m=sz(1);

ip_constraint_matrix_added(m+1,1)=n;

if(k==1)
    ip_constraint_matrix_added(m+1,2:3)=[1 0 ];
end
if(k==2)
    ip_constraint_matrix_added(m+1,2:3)=[0 1 ];
end
if(k==3)
    ip_constraint_matrix_added(m+1,2:3)=[1 1 ];
end



setappdata(0,'ip_constraint_matrix_added',ip_constraint_matrix_added);


update_constraints_Callback(hObject, eventdata, handles);




% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    fig_num=getappdata(0,'fig_num');
catch
    fig_num=1;
end
setappdata(0,'fig_num',fig_num)


ip_constraint_matrix=getappdata(0,'ip_constraint_matrix');
iu=getappdata(0,'iu');

sz=size(ip_constraint_matrix);

N=sz(1);

node_matrix=getappdata(0,'node_matrix');

sz=size(node_matrix);

if(max(sz)<=0)
    warndlg('node_matrix does not exist');
    return;
end


dx=getappdata(0,'dx');
dy=getappdata(0,'dy');


h=figure(fig_num);
fig_num=fig_num+1;

if(iu==1)
    plot(node_matrix(:,1),node_matrix(:,2),'.');
else
    plot(1000*node_matrix(:,1),1000*node_matrix(:,2),'.');    
end

title('Constraints (Ux,Uy)  0=free 1=constrained');
%
clear nodex;
clear nodey;
nodex=node_matrix(:,1);
nodey=node_matrix(:,2);
%

%
for i=1:N
   if(ip_constraint_matrix(i,1)>0) 
       
%%        string=sprintf('%d',ip_constraint_matrix(i,1));
  
        string='';

        if(ip_constraint_matrix(i,2)==1)        
            string=strcat(string,'1');
        else
            string=strcat(string,'0');            
        end
        if(ip_constraint_matrix(i,3)==1)
            string=strcat(string,'1');
        else
            string=strcat(string,'0');                        
        end
         
        p=ip_constraint_matrix(i,1);
        
        
        if(iu==1)
            text(nodex(p),nodey(p),string);
        else
            text(1000*nodex(p),1000*nodey(p),string);            
        end
   end     
end
if(iu==1)
    xlabel('X (in)');
    ylabel('Y (in)');
else
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

if(iu==1)
    axis([xmin,xmax,ymin,ymax]);
else
    xxmin=1000*xmin;
    xxmax=1000*xmax;
    yymin=1000*ymin;
    yymax=1000*ymax;    
    axis([xxmin,xxmax,yymin,yymax]);    
end
    
setappdata(0,'fig_num',fig_num)

pname='constraints.png';        
out1=sprintf('plot file:   %s',pname);
disp(out1);
set(gca,'Fontsize',12);
print(h,pname,'-dpng','-r300');


% --- Executes on selection change in listbox7.
function listbox7_Callback(hObject, eventdata, handles)
% hObject    handle to listbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox7


% --- Executes during object creation, after setting all properties.
function listbox7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_add_ry_Callback(hObject, eventdata, handles)
% hObject    handle to edit_add_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_add_ry as text
%        str2double(get(hObject,'String')) returns contents of edit_add_ry as a double


% --- Executes during object creation, after setting all properties.
function edit_add_ry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_add_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ry.
function pushbutton_ry_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in listbox_constraint.
function listbox_constraint_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_constraint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_constraint contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_constraint


% --- Executes during object creation, after setting all properties.
function listbox_constraint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_constraint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_add_fixed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_add_fixed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_add_fixed as text
%        str2double(get(hObject,'String')) returns contents of edit_add_fixed as a double


% --- Executes during object creation, after setting all properties.
function edit_add_fixed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_add_fixed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_fixed_nodes.
function listbox_fixed_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fixed_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fixed_nodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fixed_nodes


% --- Executes during object creation, after setting all properties.
function listbox_fixed_nodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fixed_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_reset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
