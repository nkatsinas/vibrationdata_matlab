function varargout = isolated_transmissibility_frf(varargin)
% ISOLATED_TRANSMISSIBILITY_FRF MATLAB code for isolated_transmissibility_frf.fig
%      ISOLATED_TRANSMISSIBILITY_FRF, by itself, creates a new ISOLATED_TRANSMISSIBILITY_FRF or raises the existing
%      singleton*.
%
%      H = ISOLATED_TRANSMISSIBILITY_FRF returns the handle to a new ISOLATED_TRANSMISSIBILITY_FRF or the handle to
%      the existing singleton*.
%
%      ISOLATED_TRANSMISSIBILITY_FRF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISOLATED_TRANSMISSIBILITY_FRF.M with the given input arguments.
%
%      ISOLATED_TRANSMISSIBILITY_FRF('Property','Value',...) creates a new ISOLATED_TRANSMISSIBILITY_FRF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before isolated_transmissibility_frf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to isolated_transmissibility_frf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help isolated_transmissibility_frf

% Last Modified by GUIDE v2.5 04-Jan-2013 09:20:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @isolated_transmissibility_frf_OpeningFcn, ...
                   'gui_OutputFcn',  @isolated_transmissibility_frf_OutputFcn, ...
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


% --- Executes just before isolated_transmissibility_frf is made visible.
function isolated_transmissibility_frf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to isolated_transmissibility_frf (see VARARGIN)

% Choose default command line output for isolated_transmissibility_frf
handles.output = hObject;




fstart=1;        
fend=2000;        
        
set(handles.fstart_edit,'String',fstart);
set(handles.fend_edit,'String',fend);
        
        
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes isolated_transmissibility_frf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = isolated_transmissibility_frf_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculate_pushbutton.
function calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fstart=str2num(get(handles.fstart_edit,'String'));
  fend=str2num(get(handles.fend_edit,'String'));

   fig_num=getappdata(0,'fig_num');
      damp=getappdata(0,'damping_visc');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
      mass=getappdata(0,'mass');
      unit=getappdata(0,'unit');

omegan=2*pi*fn;        
        
MST=ModeShapes';
%
sz=size(ModeShapes);
dof=(sz(1));
num=dof;
%
N=48;
%
fmin=fstart;
fmax=fend;

[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N);

om2=omega.^2;
%
omn2=omegan.^2;
%
two_damp_omegan=zeros(6,1);
%
for i=1:dof 
    two_damp_omegan(i)=2*damp(i)*omegan(i);
end
%

out1=sprintf('\n number of dofs =%d \n',num);
disp(out1);
%
%
%  Being main loop ********************************************************
%
%  np=number of excitation frequencies
%
%
for iaxis=1:3   
%
     rd=zeros(np,dof);
    acc=zeros(np,dof);
%
    for i=1:np 
%
         n=zeros(6,1);
%
        for j=1:dof
           A=-MST(j,iaxis)*mass;
           den= (omn2(j)-om2(i)) + (1i)*(two_damp_omegan(j)*omega(i));
           n(j)=A/den;
        end
        na=-om2(i)*n;
%
         rd(i,:)=ModeShapes*n;
        acc(i,:)=ModeShapes*na;
        acc(i,iaxis)=acc(i,iaxis)+1;  
%
    end 
%
     rd=abs(rd);
    acc=abs(acc);
%
    if(unit==1)
      rd_trans=[freq 386*rd];
    else
      rd_trans=[freq 9.81*rd];   
    end
    
    acc_trans=[freq acc];
%
    if(iaxis==1)
        figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);
        title_string=' Accel Transmissibility Magnitude  X-axis Excitation';
    end
    if(iaxis==2)
        figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);  
        title_string=' Accel Transmissibility Magnitude  Y-axis Excitation';      
    end
    if(iaxis==3)
        figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);
        title_string=' Accel Transmissibility Magnitude  Z-axis Excitation';        
    end  
 %
    sz=size(acc);
    write_details=0;
    if(write_details==1)
        disp(' ');
        out1=sprintf(' size(acc) %d %d  ',sz(1),sz(2));
        disp(out1);
    end
%
    if(write_details==1)
        sz=size(acc_trans);
        out1=sprintf(' size(acc_trans) %d %d  ',sz(1),sz(2));
        disp(out1);   
    end
 %
    if(iaxis==1)
        trans_x=acc_trans;
        plot(freq,trans_x(:,2),freq,trans_x(:,3),freq,trans_x(:,4));
    end
    if(iaxis==2)
        trans_y=acc_trans; 
        plot(freq,trans_y(:,2),freq,trans_y(:,3),freq,trans_y(:,4));        
    end
    if(iaxis==3)
        trans_z=acc_trans;
        plot(freq,trans_z(:,2),freq,trans_z(:,3),freq,trans_z(:,4));        
    end  
 %
    legend ('X-axis Response','Y-axis Response','Z-axis Response');   
%
    fmin=fstart;
    fmax=fend;
    ymax2=max(acc_trans(:,2));
    ymax3=max(acc_trans(:,3));
    ymax4=max(acc_trans(:,4));
    ymax=ymax2;
    if(ymax<ymax3)
        ymax=ymax3;
    end
    if(ymax<ymax4)
        ymax=ymax4;
    end
 %
    for i=-10:10
        if(ymax<10^i)
            ymax=10^i;
            break;
        end
    end
 %   
    ymin=ymax*0.0001;
    axis([fmin,fmax,ymin,ymax]);
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log'); 
    grid on;
    title(title_string);
    xlabel(' Frequency (Hz) ');
    ylabel(' Trans (G/G) ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    if(iaxis==1)
        figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num); 
        title_string=' Rel Disp Transmissibility Magnitude  X-axis Excitation';
    end
    if(iaxis==2)
        figure(fig_num);
        fig_num=fig_num+1;   
        setappdata(0,'fig_num',fig_num);
        title_string=' Rel Disp Transmissibility Magnitude  Y-axis Excitation';      
    end
    if(iaxis==3)
        figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);
        title_string=' Rel Disp Transmissibility Magnitude  Z-axis Excitation';        
    end  
%
%
    if(iaxis==1)
        rd_trans_x=rd_trans;
        if(unit==2)
            rd_trans_x(:,2)=1000*rd_trans_x(:,2);
            rd_trans_x(:,3)=1000*rd_trans_x(:,3);
            rd_trans_x(:,4)=1000*rd_trans_x(:,4);
        end        
        plot(freq,rd_trans_x(:,2),freq,rd_trans_x(:,3),freq,rd_trans_x(:,4));
    end
    if(iaxis==2)
        rd_trans_y=rd_trans; 
        if(unit==2)
            rd_trans_y(:,2)=1000*rd_trans_y(:,2);
            rd_trans_y(:,3)=1000*rd_trans_y(:,3);
            rd_trans_y(:,4)=1000*rd_trans_y(:,4);
        end         
        plot(freq,rd_trans_y(:,2),freq,rd_trans_y(:,3),freq,rd_trans_y(:,4));        
    end
    if(iaxis==3)
        rd_trans_z=rd_trans;
        if(unit==2)
            rd_trans_z(:,2)=1000*rd_trans_z(:,2);
            rd_trans_z(:,3)=1000*rd_trans_z(:,3);
            rd_trans_z(:,4)=1000*rd_trans_z(:,4);
        end         
        plot(freq,rd_trans_z(:,2),freq,rd_trans_z(:,3),freq,rd_trans_z(:,4));        
    end  
 %
    legend ('X-axis Response','Y-axis Response','Z-axis Response');   
%
    fmin=fstart;
    fmax=fend;
%
    ymax2=max(rd_trans(:,2));
    ymax3=max(rd_trans(:,3));
    ymax4=max(rd_trans(:,4));
    ymax=ymax2;
    if(ymax<ymax3)
        ymax=ymax3;
    end
    if(ymax<ymax4)
        ymax=ymax4;
    end
%
    for i=-10:10
        if(ymax<10^i)
            ymax=10^i;
            break;
        end
    end
    if(unit==2)
        ymax=ymax*1000;
    end
 %   
    ymin=ymax*0.0001;
    axis([fmin,fmax,ymin,ymax]);
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log'); 
    grid on;
    title(title_string);
    xlabel(' Frequency (Hz) ');
    if(unit==1)
        ylabel(' Trans (in/G) ');
    else
        ylabel(' Trans (mm/G) ');       
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
end
%
disp(' ');
disp(' View plots.  Note that some curves may be below lower plot amplitude limit. ');
%
size(trans_x);
%
    power_trans_x(:,1)=trans_x(:,1);
    power_trans_y(:,1)=trans_y(:,1);
    power_trans_z(:,1)=trans_z(:,1);    
%
    rd_power_trans_x(:,1)=rd_trans_x(:,1);
    rd_power_trans_y(:,1)=rd_trans_y(:,1);
    rd_power_trans_z(:,1)=rd_trans_z(:,1);   
%
    clear length;
    nnn=length(trans_x(:,1));
%
    for i=1:nnn
        for j=2:7
           power_trans_x(i,j)=(trans_x(i,j))^2; 
           power_trans_y(i,j)=(trans_y(i,j))^2;    
           power_trans_z(i,j)=(trans_z(i,j))^2;     
 %
           rd_power_trans_x(i,j)=(rd_trans_x(i,j))^2; 
           rd_power_trans_y(i,j)=(rd_trans_y(i,j))^2;    
           rd_power_trans_z(i,j)=(rd_trans_z(i,j))^2;   
        end
    end
%
%%    disp(' ');
%%    disp(' *** Acceleration Transmissibility Output Files *** ');
%%    disp(' ');
%%    disp('   Output File Columns:  ');
%%    disp('     Freq    X     Y     Z     alpha       beta        theta      ');
%%    disp('     (Hz)  (G/G) (G/G) (G/G)  (rad/s^2/G) (rad/s^2/G) (rad/s^2/G) ');
%
%%    disp(' ');
%%    disp('    Output Filenames:  ');
%%    disp('      trans_x  -  X-axis input ')
%%    disp('      trans_y  -  Y-axis input ')    
%%    disp('      trans_z  -  Z-axis input ')
%
    setappdata(0,'trans_x',trans_x); 
    setappdata(0,'trans_y',trans_y);   
    setappdata(0,'trans_z',trans_z);        
%
%%    disp(' ');
%%    disp(' *** Power Transmissibility Output Files *** ');
%%    disp(' ');
%%    disp('   Output File Columns:  ');
%%    disp('     Freq      X         Y         Z       alpha            beta  theta ');
%%    disp('     (Hz)  (G^2/G^2) (G^2/G^2) (G^2/G^2) ((rad/s^2)^2/G^2)    <-   <-   ');
%
%%    disp(' ');
%%    disp('    Acceleration Output Filenames: ');    
%%    disp('      power_trans_x  -  X-axis input ')
%%    disp('      power_trans_y  -  Y-axis input ')    
%%    disp('      power_trans_z  -  Z-axis input ')   
%
    setappdata(0,'power_trans_x',power_trans_x); 
    setappdata(0,'power_trans_y',power_trans_y);   
    setappdata(0,'power_trans_z',power_trans_z); 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%    disp(' ');
%%    disp(' *** Relative Displacement Transmissibility Output Files *** ');
%%    disp(' ');
%%    disp('   Output File Columns:  ');
%%    disp('     Freq    X     Y      Z       alpha    beta     theta   ');
%%    disp('     (Hz)  (in/G) (in/G) (in/G)  (rad/G)  (rad/G)  (rad/G) ');
%
%%    disp(' ');
%%    disp('    Output Filenames:  ');
%%    disp('      rd_trans_x  -  X-axis input ')
%%    disp('      rd_trans_y  -  Y-axis input ')    
%%    disp('      rd_trans_z  -  Z-axis input ')
%
    setappdata(0,'rd_trans_x',rd_trans_x); 
    setappdata(0,'rd_trans_y',rd_trans_y);   
    setappdata(0,'rd_trans_z',rd_trans_z);
%
%%    disp(' ');
%%    disp(' *** Relative Displacement Power Transmissibility Output Files *** ');
%%    disp(' ');
%%    disp('   Output File Columns:  ');
%%    disp('     Freq      X         Y         Z          alpha            beta  theta ');
%%    disp('     (Hz)  (in^2/G^2) (in^2/G^2) (in^2/G^2)  ((rad^2)^2/G^2)    <-   <-   ');
%
%%    disp(' ');
%%    disp('    Relative Displacement Output Filenames: ');    
%%    disp('      rd_power_trans_x  -  X-axis input ')
%%    disp('      rd_power_trans_y  -  Y-axis input ')    
%%    disp('      rd_power_trans_z  -  Z-axis input ')   

frf_flag=1;
setappdata(0,'frf_flag',frf_flag);

msgbox('Calculation complete.  See External Plots. Note that some curves may be below lower plot amplitude limit. ');

function fstart_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fstart_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fstart_edit as text
%        str2double(get(hObject,'String')) returns contents of fstart_edit as a double


% --- Executes during object creation, after setting all properties.
function fstart_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fstart_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fend_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fend_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fend_edit as text
%        str2double(get(hObject,'String')) returns contents of fend_edit as a double


% --- Executes during object creation, after setting all properties.
function fend_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fend_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
