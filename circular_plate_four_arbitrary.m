function varargout = circular_plate_four_arbitrary(varargin)
% CIRCULAR_PLATE_FOUR_ARBITRARY MATLAB code for circular_plate_four_arbitrary.fig
%      CIRCULAR_PLATE_FOUR_ARBITRARY, by itself, creates a new CIRCULAR_PLATE_FOUR_ARBITRARY or raises the existing
%      singleton*.
%
%      H = CIRCULAR_PLATE_FOUR_ARBITRARY returns the handle to a new CIRCULAR_PLATE_FOUR_ARBITRARY or the handle to
%      the existing singleton*.
%
%      CIRCULAR_PLATE_FOUR_ARBITRARY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCULAR_PLATE_FOUR_ARBITRARY.M with the given input arguments.
%
%      CIRCULAR_PLATE_FOUR_ARBITRARY('Property','Value',...) creates a new CIRCULAR_PLATE_FOUR_ARBITRARY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circular_plate_four_arbitrary_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circular_plate_four_arbitrary_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circular_plate_four_arbitrary

% Last Modified by GUIDE v2.5 19-Sep-2014 15:09:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circular_plate_four_arbitrary_OpeningFcn, ...
                   'gui_OutputFcn',  @circular_plate_four_arbitrary_OutputFcn, ...
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


% --- Executes just before circular_plate_four_arbitrary is made visible.
function circular_plate_four_arbitrary_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circular_plate_four_arbitrary (see VARARGIN)

% Choose default command line output for circular_plate_four_arbitrary
handles.output = hObject;

clc;

fstr='circular_plate_four.png';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
pos1 = getpixelposition(handles.axes1,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes circular_plate_four_arbitrary wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circular_plate_four_arbitrary_OutputFcn(hObject, eventdata, handles) 
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
handles.s=circular_plate_four_points_base;

set(handles.s,'Visible','on');

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;
%
FS=get(handles.input_edit,'String');
%
THM=evalin('base',FS);
%
    t=THM(:,1);
    num_steps=length(t);
    
    num=num_steps;
    
    abase=THM(:,2);
  
%
    dt=(t(num)-t(1))/(num-1);
%
    sr=1./dt;
%
    disp(' ')
    disp(' Time Step ');
    dtmin=min(diff(t));
    dtmax=max(diff(t));
%
    out4 = sprintf(' dtmin  = %8.4g sec  ',dtmin);
    out5 = sprintf(' dt     = %8.4g sec  ',dt);
    out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
    disp(out4)
    disp(out5)
    disp(out6)
%
    disp(' ')
    disp(' Sample Rate ');
    out4 = sprintf(' srmin  = %8.4g samples/sec  ',1/dtmax);
    out5 = sprintf(' sr     = %8.4g samples/sec  ',1/dt);
    out6 = sprintf(' srmax  = %8.4g samples/sec  \n',1/dtmin);
    disp(out4)
    disp(out5)
    disp(out6)
%
if(((dtmax-dtmin)/dt)>0.01)
    disp(' ')
    disp(' Warning:  time step is not constant.')
end
%

%
    fmax=sr/10;
%
    out7=sprintf('\n maximum frequency limit for modal transient analysis: fmax=%9.5g Hz \n',fmax);
    disp(out7);

    if(fmax==0)
        return;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

try
    damp=getappdata(0,'damp_ratio');
catch
    warndlg('Damping array does not exist.');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn=getappdata(0,'fn');
part=getappdata(0,'part');  
PF=part;

Z=getappdata(0,'Z'); 
Z_theta=getappdata(0,'Z_theta'); 
Z_r=getappdata(0,'Z_r'); 

iu=getappdata(0,'iu');
E=getappdata(0,'E');
h=getappdata(0,'T');
radius=getappdata(0,'radius');   
mu=getappdata(0,'mu');
rho=getappdata(0,'rho');
total_mass=getappdata(0,'total_mass');
BC=getappdata(0,'BC');

fig_num=getappdata(0,'fig_num');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_loc=get(handles.listbox_location,'Value');

if(n_loc==1)  
    r=0;    
    theta=0;
end
if(n_loc==2) 
    r=0.5;        
    theta=0;  
end
if(n_loc==3)
    r=1;        
    theta=0;
end
if(n_loc==4)
    r=0.5;        
    theta=pi/4;    
end
r=r*radius;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmax=1.0e+90;
rmax=1.0e+90;

i_theta=1;
i_r=1;

for i=1:length(Z_theta)

    terr=abs(Z_theta(i)-theta);
    
    if(terr<tmax)
        tmax=terr;
        i_theta=i;
    end
    
end
for i=1:length(Z_r)

    rerr=abs(Z_r(i)-r);
    
    if(rerr<rmax)
        rmax=rerr;
        i_r=i;
    end    
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_nodes=1;
num_modes=1;

       rd=zeros(num_steps,1);
       rv=zeros(num_steps,1);
       ra=zeros(num_steps,1);
%
        nrd=zeros(num_steps,num_nodes);
        nrv=zeros(num_steps,num_nodes);
        nra=zeros(num_steps,num_nodes); 

   [a1,a2,ra_b1,ra_b2,ra_b3,rv_b1,rv_b2,rv_b3,rd_b1,rd_b2,rd_b3]=...
                srs_coefficients_avd(fn,damp,dt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
    for j=1:num_modes
%
%
        if(abs(PF(j))>0 && fn(j)<fmax)
%
            yp=-abase*PF(j);
%
            back   =[     1, -a1(j), -a2(j) ];
%
%   relative velocity
%
            clear forward;
            forward=[ rv_b1(j),  rv_b2(j),  rv_b3(j) ];    
            nrv(:,j)=filter(forward,back,yp);
%
%   relative displacement
%
            clear forward;
            forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];      
            nrd(:,j)=filter(forward,back,yp);
%
%   relative acceleration
%
            clear forward;  
            forward=[ ra_b1(j),  ra_b2(j),  ra_b3(j) ];    
            nra(:,j)=filter(forward,back,yp); 
%
%
            ZZ=Z(i_r,i_theta);
%
%
            rd(:)= rd(:) +part(j)*ZZ*nrd(:,j);
            rv(:)= rv(:) +part(j)*ZZ*nrv(:,j);             
            ra(:)= ra(:) +part(j)*ZZ*nra(:,j);  
%
        end
%
    end
%
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    acc=ra+abase;

    if(iu==1)
        rd=rd*386;
        rv=rv*386;
    else
        rd=rd*9.81*1000;
        rv=rv*9.81;       
    end    
    
    theta=theta*180/pi;
     
    disp(' ');
    disp(' Peak Response Values ');
    disp(' ');
    out1=sprintf('          Acceleration = %8.4g G',max(abs(acc)));
%   
 

    if(iu==1)
        out2=sprintf('     Relative Velocity = %8.4g in/sec',max(abs(rv)));          
        out3=sprintf(' Relative Displacement = %8.4g in',max(abs(rd)));  

    else
        out2=sprintf('     Relative Velocity = %8.4g m/sec',max(abs(rv)));         
        out3=sprintf(' Relative Displacement = %8.4g mm',max(abs(rd)));

    end
%    
    disp(out1);
    disp(out2);
    disp(out3);

    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%

    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rd);
%    
    if(iu==1)
        out1=sprintf(' Relative Displacement at r=%g in theta=%g deg',r,theta);
        ylabel('Rel Disp (in) ');
    else
        out1=sprintf(' Relative Displacement at r=%g m  theta=%g deg',r,theta);
        ylabel('Rel Disp (m) ');
    end
    title(out1);
    xlabel('Time(sec)');
    grid on;
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rv);
%
    if(iu==1)
        out1=sprintf(' Relative Velocity at r=%g in  theta=%g deg',r,theta);        
        ylabel('Rel Vel (in/sec) ');
    else
        out1=sprintf(' Relative Velocity at r=%g m  theta=%g deg',r,theta);        
        ylabel('Rel Vel (m/sec) ');
    end
    title(out1);    
    xlabel('Time(sec)');
    grid on    
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,abase);
%
    if(iu==1)
        out1=sprintf(' Base Input Acceleration ');
    else
        out1=sprintf(' Base Input Acceleration ');       
    end
    title(out1);
    ylabel('Accel (G) ');
    xlabel('Time(sec)'); 
    grid on;
%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc);
%
    if(iu==1)
        out1=sprintf(' Response Acceleration at r=%g in theta=%g deg',r,theta);
    else
        out1=sprintf(' Response Acceleration at r=%g m  theta=%g deg',r,theta);       
    end
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)'); 
    grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
t=fix_size(t);
acc=fix_size(acc);
rv=fix_size(rv);
rd=fix_size(rd);
%
acc=[t acc];
rv=[t rv];
rd=[t rd];
      
setappdata(0,'acceleration',acc);
setappdata(0,'relative_velocity',rv);
setappdata(0,'relative_displacement',rd);
                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%

setappdata(0,'fig_num',fig_num);

set(handles.uipanel_save,'Visible','on');





% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_response,'Value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
   data=getappdata(0,'relative_velocity');
end
if(n==3)
    data=getappdata(0,'relative_displacement');
end


output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 



% --- Executes on selection change in listbox_location.
function listbox_location_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_location


% --- Executes during object creation, after setting all properties.
function listbox_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_response.
function listbox_response_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_response contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_response


% --- Executes during object creation, after setting all properties.
function listbox_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_edit_Callback(hObject, eventdata, handles)
% hObject    handle to input_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_edit as text
%        str2double(get(hObject,'String')) returns contents of input_edit as a double


% --- Executes during object creation, after setting all properties.
function input_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
