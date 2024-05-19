function varargout = rectangular_plate_corners_arbitrary(varargin)
% RECTANGULAR_PLATE_CORNERS_ARBITRARY MATLAB code for rectangular_plate_corners_arbitrary.fig
%      RECTANGULAR_PLATE_CORNERS_ARBITRARY, by itself, creates a new RECTANGULAR_PLATE_CORNERS_ARBITRARY or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_PLATE_CORNERS_ARBITRARY returns the handle to a new RECTANGULAR_PLATE_CORNERS_ARBITRARY or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_PLATE_CORNERS_ARBITRARY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_PLATE_CORNERS_ARBITRARY.M with the given input arguments.
%
%      RECTANGULAR_PLATE_CORNERS_ARBITRARY('Property','Value',...) creates a new RECTANGULAR_PLATE_CORNERS_ARBITRARY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_plate_corners_arbitrary_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_plate_corners_arbitrary_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_plate_corners_arbitrary

% Last Modified by GUIDE v2.5 02-Sep-2014 15:14:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_plate_corners_arbitrary_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_plate_corners_arbitrary_OutputFcn, ...
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


% --- Executes just before rectangular_plate_corners_arbitrary is made visible.
function rectangular_plate_corners_arbitrary_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_plate_corners_arbitrary (see VARARGIN)

% Choose default command line output for rectangular_plate_corners_arbitrary
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rectangular_plate_corners_arbitrary wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rectangular_plate_corners_arbitrary_OutputFcn(hObject, eventdata, handles) 
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
setappdata(0,'rectangular_plate_bending_corners_key',1);

handles.s=rectangular_plate_corners_base;   
set(handles.s,'Visible','on'); 
delete(rectangular_plate_corners_arbitrary);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

T=getappdata(0,'T');

L=getappdata(0,'L');
W=getappdata(0,'W');


iu=getappdata(0,'iu');
 
E=getappdata(0,'E');
rho=getappdata(0,'rho');
mu=getappdata(0,'mu');
 
ZAA=getappdata(0,'ZAA');
zbar=T/2;

Ezbar=E*zbar;

fn=getappdata(0,'fn');
alpha=getappdata(0,'alpha_r');
beta=getappdata(0,'beta_r');
gamma=getappdata(0,'gamma_r');
 
part=getappdata(0,'part');

PF=part;

damp=getappdata(0,'damp_ratio');
 
fig_num=getappdata(0,'fig_num');
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
a=L;
b=W;
h=T;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_loc=get(handles.listbox_location,'Value');
 
xc=0.5*L;
yc=0.5*W;
 
if(n_loc==1)
    x=xc-0.5*L;
    y=yc-0.5*W;
end
if(n_loc==2)
    x=xc-0.5*L;
    y=yc-0.25*W;
end
if(n_loc==3)
    x=xc-0.25*L;
    y=yc-0.5*W;
end
if(n_loc==4)
    x=xc-0.25*L;
    y=yc-0.25*W;
end

[Z,d2Zdx2,d2Zdy2,d2Zdxdy,SXX,SYY,TXY]=...
                               plate_corner_Z(x,y,a,b,alpha,beta,gamma,mu,ZAA);
                           
ZZ=Z;
                xc=0.5*app.L;
                yc=0.5*app.W;

                xo=x;
                yo=y;
                x=xc-x;
                y=yc-y;

                num_modes=1;
num_modes=1;

num_nodes=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
FS=get(handles.edit_input,'String');
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
        
       rd=zeros(num_steps,1);
       rv=zeros(num_steps,1);
       ra=zeros(num_steps,1);
%
       sxx=zeros(num_steps,1);
       syy=zeros(num_steps,1);
       txy=zeros(num_steps,1);
%
        nrd=zeros(num_steps,num_nodes);
        nrv=zeros(num_steps,num_nodes);
        nra=zeros(num_steps,num_nodes); 
%

    [a1,a2,ra_b1,ra_b2,ra_b3,rv_b1,rv_b2,rv_b3,rd_b1,rd_b2,rd_b3]=...
                srs_coefficients_avd(fn(1:num_modes),damp(1:num_modes),dt);

%
    fmax=sr/10;
%
    out1=sprintf('\n maximum frequency limit for modal transient analysis: fmax=%9.5g Hz \n',fmax);
    disp(out1);
%
    for j=1:num_modes
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
            nbm(:,j)=nrd(:,j);
%
%   relative acceleraiton
%
            clear forward;  
            forward=[ ra_b1(j),  ra_b2(j),  ra_b3(j) ];    
            nra(:,j)=filter(forward,back,yp); 
%               
%     
             rd(:)= rd(:) +ZZ*nrd(:,j);
             rv(:)= rv(:) +ZZ*nrv(:,j);             
             ra(:)= ra(:) +ZZ*nra(:,j); 
%
             sxx(:)=sxx(:)+ SXX*nrd(:,j);
             syy(:)=syy(:)+ SYY*nrd(:,j);
             txy(:)=txy(:)+ TXY*nrd(:,j);
%
        end
%
    end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
    acc=ra+abase;
%
    sxx=sxx*(Ezbar/(1-mu^2));
    syy=syy*(Ezbar/(1-mu^2));
    txy=txy*(Ezbar/(1+mu));
%
    if(iu==1)
        rd=rd*386;
        rv=rv*386;
        sxx=sxx*386;
        syy=syy*386;
        txy=txy*386;
    else
        rd=rd*9.81*1000;
        rv=rv*9.81; 
        sxx=sxx*9.81;
        syy=syy*9.81;
        txy=txy*9.81;        
    end
       
%
    clear length;
    n=length(sxx);
    vM=zeros(n,1);
    for i=1:n
        vM(i)=sqrt( sxx(i)^2 + syy(i)^2 - sxx(i)*syy(i) + 3*txy(i)^2 );
    end
%
    disp(' ');
    disp(' Peak Response Values ');
    disp(' ');
    out1=sprintf('          Acceleration = %8.4g G',max(abs(acc)));
%   
 

    if(iu==1)
        out2=sprintf('     Relative Velocity = %8.4g in/sec',max(abs(rv)));          
        out3=sprintf(' Relative Displacement = %8.4g in',max(abs(rd)));  
        out4=sprintf('\n      von Mises Stress = %8.4g psi',max(abs(vM)));
        ss='psi';
    else
        out2=sprintf('     Relative Velocity = %8.4g m/sec',max(abs(rv)));         
        out3=sprintf(' Relative Displacement = %8.4g mm',max(abs(rd)));
        out4=sprintf('\n      von Mises Stress = %8.4g Pa',max(abs(vM)));       
        ss='PA';
    end
%    
    disp(out1);
    disp(out2);
    disp(out3);
    disp(out4);   

    

if(n_loc==1)
    
    sv=max(abs(rv))*rho*sqrt(E/rho);
    svl=1.9*sv;
    svh=2.5*sv;

    if(iu==1)
        out7=sprintf('\n  Stress-Velocity:   %8.4g to %8.4g  psi',svl,svh);  
    else
        out7=sprintf('\n  Stress-Velocity:   %8.4g to %8.4g  Pa',svl,svh); 
    end

    disp(out7);
end
    
    
  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%

    x=xc-x;
    y=yc-y;
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rd);
%    
    if(iu==1)
        out1=sprintf(' Relative Displacement at x=%g in  y=%g in',x,y);
        ylabel('Rel Disp(in) ');
    else
        out1=sprintf(' Relative Displacement at x=%g m  y=%g m',x,y);
        ylabel('Rel Disp(m) ');
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
        out1=sprintf(' Relative Velocity at x=%g in  y=%g in',x,y);        
        ylabel('Rel Vel (in/sec) ');
    else
        out1=sprintf(' Relative Velocity at x=%g m  y=%g m',x,y);        
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
    ylabel('Accel(G) ');
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
        out1=sprintf(' Response Acceleration at x=%g in  y=%g in',x,y);
    else
        out1=sprintf(' Response Acceleration at x=%g m  y=%g m',x,y);       
    end
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)'); 
    grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,sxx);
%
    if(iu==1)
        out1=sprintf(' Sxx Stress at x=%g in  y=%g in',x,y);        
        ylabel('Stress(psi) ');
    else
        out1=sprintf(' Sxx Stress at x=%g m  y=%g m',x,y);       
        ylabel('Stress(Pa) ');
    end
    title(out1);    
    xlabel('Time(sec)');
    grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,syy);
%
    if(iu==1)
        out1=sprintf(' Syy Stress at x=%g in  y=%g in',x,y);        
        ylabel('Stress(psi) ');
    else
        out1=sprintf(' Syy Stress at x=%g m  y=%g m',x,y);       
        ylabel('Stress(Pa) ');
    end
    title(out1);    
    xlabel('Time(sec)');
    grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,vM);
%
    if(iu==1)
        out1=sprintf(' von Mises Stress at x=%g in  y=%g in',x,y);        
        ylabel('Stress(psi) ');
    else
        out1=sprintf(' von Mises Stress at x=%g m  y=%g m',x,y);       
        ylabel('Stress(Pa) ');
    end
    title(out1);    
    xlabel('Time(sec)');
    grid on;
%
%
t=fix_size(t);
acc=fix_size(acc);
rv=fix_size(rv);
rd=fix_size(rd);
vM=fix_size(vM);
%
acc=[t acc];
rv=[t rv];
rd=[t rd];
vMs=[t vM];
      
setappdata(0,'acceleration',acc);
setappdata(0,'relative_velocity',rv);
setappdata(0,'relative_displacement',rd);
setappdata(0,'bending_stress',vMs);
                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%

setappdata(0,'fig_num',fig_num);

set(handles.uipanel_save,'Visible','on');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





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



function edit_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input as text
%        str2double(get(hObject,'String')) returns contents of edit_input as a double


% --- Executes during object creation, after setting all properties.
function edit_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
if(n==4)
    data=getappdata(0,'bending_stress');
end


output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 



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
