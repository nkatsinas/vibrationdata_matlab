function varargout = ss_plate_bending_pf_transient(varargin)
% SS_PLATE_BENDING_PF_TRANSIENT MATLAB code for ss_plate_bending_pf_transient.fig
%      SS_PLATE_BENDING_PF_TRANSIENT, by itself, creates a new SS_PLATE_BENDING_PF_TRANSIENT or raises the existing
%      singleton*.
%
%      H = SS_PLATE_BENDING_PF_TRANSIENT returns the handle to a new SS_PLATE_BENDING_PF_TRANSIENT or the handle to
%      the existing singleton*.
%
%      SS_PLATE_BENDING_PF_TRANSIENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SS_PLATE_BENDING_PF_TRANSIENT.M with the given input arguments.
%
%      SS_PLATE_BENDING_PF_TRANSIENT('Property','Value',...) creates a new SS_PLATE_BENDING_PF_TRANSIENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ss_plate_bending_pf_transient_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ss_plate_bending_pf_transient_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ss_plate_bending_pf_transient

% Last Modified by GUIDE v2.5 18-May-2017 13:27:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ss_plate_bending_pf_transient_OpeningFcn, ...
                   'gui_OutputFcn',  @ss_plate_bending_pf_transient_OutputFcn, ...
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


% --- Executes just before ss_plate_bending_pf_transient is made visible.
function ss_plate_bending_pf_transient_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ss_plate_bending_pf_transient (see VARARGIN)

% Choose default command line output for ss_plate_bending_pf_transient
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

iu=getappdata(0,'iu');

if(iu==2)
    sss='The input array must have two columns:  Time(sec) & Force(N)';
else
    sss='The input array must have two columns:  Time(sec) & Force(lbf)';    
end

set(handles.text_force_unit,'String',sss);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ss_plate_bending_pf_transient wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ss_plate_bending_pf_transient_OutputFcn(hObject, eventdata, handles) 
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

delete(ss_plate_bending_pf_transient);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    



   fig_num=getappdata(0,'fig_num');
   
   
damp=str2num(get(handles.edit_damp,'String'));
      
      
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




force_x=str2num(get(handles.edit_force_x,'String'));
force_y=str2num(get(handles.edit_force_y,'String'));

force_x=force_x*L/100;
force_y=force_y*W/100;


n_loc=get(handles.listbox_location,'Value');

if(n_loc==1)
    resp_loc=[ 0.5*L   0.5*W ];
end
if(n_loc==2)
    resp_loc=[ 0.5*L   0.25*W ];
end
if(n_loc==3)
    resp_loc=[ 0.25*L   0.5*W ];
end
if(n_loc==4)
    resp_loc=[ 0.25*L   0.25*W ];
end
if(n_loc==5)
    resp_loc=[ force_x   force_y ];
end

x=resp_loc(1,1);
y=resp_loc(1,2);

pax=x*pi/a;
pby=y*pi/b;

pax_pf=force_x*pi/a;
pby_pf=force_y*pi/b;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
FS=get(handles.input_edit,'String');
%
THM=evalin('base',FS);
%
    t=THM(:,1);
    num_steps=length(t);
    
    num=num_steps;
    
    applied_force=THM(:,2);
  
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
        
%%%%%%  

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

    damp=damp*ones(num_modes,1);

    [a1,a2,ra_b1,ra_b2,ra_b3,rv_b1,rv_b2,rv_b3,rd_b1,rd_b2,rd_b3]=...
                srs_coefficients_avd(fn(1:num_modes),damp(1:num_modes),dt);

%
    fmax=sr/10;
%
    out1=sprintf('\n maximum frequency limit for modal transient analysis: fmax=%9.5g Hz \n',fmax);
    disp(out1);
%
    progressbar;
    for j=1:num_modes
        progressbar(j/num_modes);
%
        if( fn(j)<fmax)
%
            yp=applied_force*Amn*sin(m_index(j)*pax_pf)*sin(n_index(j)*pby_pf);        
%
            back   =[     1, -a1(j), -a2(j) ];
%
%   velocity
%
            clear forward;
            forward=[ rv_b1(j),  rv_b2(j),  rv_b3(j) ];    
            nrv(:,j)=filter(forward,back,yp);
%
%   displacement
%
            clear forward;
            forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];      
            nrd(:,j)=filter(forward,back,yp);
            nbm(:,j)=nrd(:,j);
%
%   acceleraiton
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
    pause(0.3);
    progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

    disp(' ');
    disp(' calculating stress...');

    acc=ra;
%
    if(iu==1)
        acc=acc/386;     
    else
        acc=acc/9.81;
        rd=rd*1000;      
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
    

        
    [vM,Tr,~,~]=von_Mises_Tresca_plane_stress(sxx,syy,txy);

%
    disp(' ');
    disp(' Peak Response Values ');
    disp(' ');
    out1=sprintf('          Acceleration = %8.4g G',max(abs(acc)));
%   
 

    if(iu==1)
        out2=sprintf('     Velocity = %8.4g in/sec',max(abs(rv)));          
        out3=sprintf(' Displacement = %8.4g in',max(abs(rd)));  
        out4=sprintf('\n      von Mises Stress = %8.4g psi',max(abs(vM)));
        out5=sprintf('         Tresca Stress = %8.4g psi',max(abs(Tr)));  
        ss='psi';
    else
        out2=sprintf('     Velocity = %8.4g m/sec',max(abs(rv)));         
        out3=sprintf(' Displacement = %8.4g mm',max(abs(rd)));
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

disp(' ');
disp(' generating plots... ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%

    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,applied_force);
%
    if(iu==1)
        out1=sprintf('Applied Force at x=%g in  y=%g in',force_x,force_y);
    else
        out1=sprintf('Applied Force at x=%g m  y=%g m',force_x,force_y);
    end
    
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)'); 
    grid on;

    [fig_num]=plate_stress_plots(fig_num,x,y,t,rd,rv,acc,sxx,syy,txy,vM,Tr,iu);
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
disp(' ');
disp('Calculation complete');

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



function edit_force_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force_x as text
%        str2double(get(hObject,'String')) returns contents of edit_force_x as a double


% --- Executes during object creation, after setting all properties.
function edit_force_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_force_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force_y as text
%        str2double(get(hObject,'String')) returns contents of edit_force_y as a double


% --- Executes during object creation, after setting all properties.
function edit_force_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_damp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damp as text
%        str2double(get(hObject,'String')) returns contents of edit_damp as a double


% --- Executes during object creation, after setting all properties.
function edit_damp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
