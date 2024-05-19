function varargout = ss_plate_arbitrary(varargin)
% SS_PLATE_ARBITRARY MATLAB code for ss_plate_arbitrary.fig
%      SS_PLATE_ARBITRARY, by itself, creates a new SS_PLATE_ARBITRARY or raises the existing
%      singleton*.
%
%      H = SS_PLATE_ARBITRARY returns the handle to a new SS_PLATE_ARBITRARY or the handle to
%      the existing singleton*.
%
%      SS_PLATE_ARBITRARY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SS_PLATE_ARBITRARY.M with the given input arguments.
%
%      SS_PLATE_ARBITRARY('Property','Value',...) creates a new SS_PLATE_ARBITRARY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ss_plate_arbitrary_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ss_plate_arbitrary_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ss_plate_arbitrary

% Last Modified by GUIDE v2.5 28-Aug-2014 16:36:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ss_plate_arbitrary_OpeningFcn, ...
                   'gui_OutputFcn',  @ss_plate_arbitrary_OutputFcn, ...
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


% --- Executes just before ss_plate_arbitrary is made visible.
function ss_plate_arbitrary_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ss_plate_arbitrary (see VARARGIN)

% Choose default command line output for ss_plate_arbitrary
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ss_plate_arbitrary wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ss_plate_arbitrary_OutputFcn(hObject, eventdata, handles) 
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

delete(ss_plate_arbitrary);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

   fig_num=getappdata(0,'fig_num');
   
      damp=getappdata(0,'damp_ratio');
   
      if(length(damp)==0)
          warndlg('damping vector does not exist');
          return;
      end    
      
      
      fbig=getappdata(0,'fbig');
        iu=getappdata(0,'iu');
 num_nodes=getappdata(0,'num_nodes');   

         L=getappdata(0,'L');   
         W=getappdata(0,'W'); 
         T=getappdata(0,'T');
         E=getappdata(0,'E');
         rho=getappdata(0,'rho');
         mu=getappdata(0,'mu');
         
       Amn=getappdata(0,'Amn');         
        
a=L;
b=W;
h=T;
       
fn=fbig(:,1);
PF=fbig(:,4);

m_index=fbig(:,6);
n_index=fbig(:,7);

num=length(fn);

try
    mt=getappdata(0,'mt');

    if(mt<num)
        num=mt;
    end
  
end   

num_modes=get(handles.listbox_num_modes,'Value');

if(num_modes > num)
    num_modes=num;
end

n_loc=get(handles.listbox_location,'Value');

if(n_loc==1)
    x=0.5*L;
    y=0.5*W;
end
if(n_loc==2)
    x=0.5*L;
    y=0.25*W;
end
if(n_loc==3)
    x=0.25*L;
    y=0.5*W;
end
if(n_loc==4)
    x=0.25*L;
    y=0.25*W;
end
if(n_loc==5)
    x=0;
    y=0;
end

pax=x*pi/a;
pby=y*pi/b;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
            ZZ=Amn*sin(m_index(j)*pax)*sin(n_index(j)*pby);                 
%     
             rd(:)= rd(:) +ZZ*nrd(:,j);
             rv(:)= rv(:) +ZZ*nrv(:,j);             
             ra(:)= ra(:) +ZZ*nra(:,j); 
%
             ZZxx=-(pi*m_index(j)/a)^2*ZZ;
             ZZyy=-(pi*n_index(j)/b)^2*ZZ;
             ZZxy= (pi^2/(a*b))*m_index(j)*n_index(j)*cos(m_index(j)*pax)*cos(n_index(j)*pby);
%
             sxx(:)=sxx(:)+ (ZZxx+mu*ZZyy)*nrd(:,j);
             syy(:)=syy(:)+ (mu*ZZxx+ZZyy)*nrd(:,j);
             txy(:)=txy(:)+ ZZxy*nrd(:,j);
%
        end
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
    acc=ra+abase;
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
    z=h/2;
    term1=-(E*z/(1-mu^2));    
    term2=-(E*z/(1+mu));
%
    sxx=sxx*term1;
    syy=syy*term1;
    txy=txy*term2;
%
    clear length;
    n=length(sxx);
    vM=zeros(n,1);
    Tr=zeros(n,1);
    
    for i=1:n
        
        [vM(i),Tr(i),~,~]=von_Mises_Tresca_plane_stress(sxx(i),syy(i),txy(i));
               
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
           out5=sprintf('         Tresca Stress = %8.4g psi',max(abs(Tr)));       
        ss='psi';
    else
        out2=sprintf('     Relative Velocity = %8.4g m/sec',max(abs(rv)));         
        out3=sprintf(' Relative Displacement = %8.4g mm',max(abs(rd)));
        out4=sprintf('\n      von Mises Stress = %8.4g Pa',max(abs(vM)));
        out5=sprintf('                       = %8.4g MPa',max(abs(vM))/(1.0e+06));  
           out6=sprintf('         Tresca Stress = %8.4g Pa',max(abs(Tr)));    
           out7=sprintf('                       = %8.4g Pa',max(abs(Tr))/(1.0e+06));               
        ss='Pa';
    end
%    
    disp(out1);
    disp(out2);
    disp(out3);
    disp(out4);
    disp(out5);
    
    if(iu==2)
        disp(out6);
        disp(out7);       
    end
    
    vel=max(abs(rv));
    
    if(n_loc==1)
        [Hunt_peak]=Hunt_plate_stress_shock(E,rho,mu,a,b,vel,ss);            
    end    
%
%
t=fix_size(t);
acc=fix_size(acc);
rv=fix_size(rv);
rd=fix_size(rd);
vM=fix_size(vM);
sxx=fix_size(sxx);
syy=fix_size(syy);
txy=fix_size(txy);
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


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    xlabel3='Time (sec)';
    
    if(iu==1)
        ylabel1='Stress (psi)';
        ylabel2='Stress (psi)';
        ylabel3='Stress (psi)';
    else
        ylabel1='Stress (Pa)';
        ylabel2='Stress (Pa)';
        ylabel3='Stress (Pa)';     
    end
    
    data1=[t sxx];
    data2=[t syy];
    data3=[t txy];
    
    
    if(iu==1)
        t_string1=sprintf(' Sxx Stress at x=%g in  y=%g in',x,y);        
        t_string2=sprintf(' Syy Stress at x=%g in  y=%g in',x,y);      
        t_string3=sprintf(' Txy Stress at x=%g in  y=%g in',x,y);              
    else
        t_string1=sprintf(' Sxx Stress at x=%g m  y=%g m',x,y);        
        t_string2=sprintf(' Syy Stress at x=%g m  y=%g m',x,y);      
        t_string3=sprintf(' Txy Stress at x=%g m  y=%g m',x,y);        
    end
    
    
    [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);
    
    
    xlabel2='Time (sec)';
    
    if(iu==1)
        ylabel1='Stress (psi)';
        ylabel2='Stress (psi)';
    else
        ylabel1='Stress (Pa)';
        ylabel2='Stress (Pa)';
    end
    
    data1=[t vM];
    data2=[t Tr];


    if(iu==1)
        t_string1=sprintf('von Mises Stress at x=%g in  y=%g in',x,y);        
        t_string2=sprintf('Tresca Stress at x=%g in  y=%g in',x,y);      
    else
        t_string1=sprintf('von Mises Stress at x=%g m  y=%g m',x,y);        
        t_string2=sprintf('Tresca Stress at x=%g m  y=%g m',x,y);           
    end    
    
       
    [fig_num]=subplots_two_linlin_two_titles_xzero(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);    
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

    [rho]=Pearson_coefficient(sxx,syy);
    
    if(rho>=0 && rho<=1)

        figure(fig_num)
        fig_num=fig_num+1;
        plot(sxx,syy,'b.','MarkerSize',1);
        if(iu==1)
            tstring=sprintf('Bending Stress Scatter Plot, Response at x=%g in  y=%g in \n Pearson Coefficient= %6.3g',x,y,rho);
            ylabel('Syy (psi) ');
            xlabel('Sxx (psi) ');
        else
            tstring=sprintf('Bending Stress Scatter Plot, Response at x=%g m  y=%g m \n Pearson Coefficient= %6.3g',x,y,rho);     
            ylabel('Syy (Pa) ');
            xlabel('Sxx (Pa) ');        
        end
        title(tstring);
        grid on;
    
        [xx]=get(gca,'xlim');
        [yy]=get(gca,'ylim');

        Qmax=max([ abs(xx) abs(yy)  ]);

        [Qmax]=ytick_linear_scale(Qmax);

        xlim([-Qmax,Qmax]);
        ylim([-Qmax,Qmax]);

        axis square;    
    
    end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% disp(' ref 1 ');


%
acc=[t acc];
rv=[t rv];
rd=[t rd];
vMs=[t vM];
stensor=[t sxx syy txy];
      
setappdata(0,'acceleration',acc);
setappdata(0,'relative_velocity',rv);
setappdata(0,'relative_displacement',rd);
setappdata(0,'bending_stress',vMs);
setappdata(0,'bending_stress_tensor',stensor);

%% disp(' ref 2 ');

                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%

setappdata(0,'fig_num',fig_num);

%% disp(' ref 3 ');

set(handles.uipanel_save,'Visible','on');

%% disp(' ref 4 ');

% --- Executes on selection change in listbox_num_modes.
function listbox_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_modes


% --- Executes during object creation, after setting all properties.
function listbox_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
if(n==5)
    data=getappdata(0,'bending_stress_tensor');
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
