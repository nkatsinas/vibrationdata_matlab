function varargout = isolated_arbitrary_base_input(varargin)
% ISOLATED_ARBITRARY_BASE_INPUT MATLAB code for isolated_arbitrary_base_input.fig
%      ISOLATED_ARBITRARY_BASE_INPUT, by itself, creates a new ISOLATED_ARBITRARY_BASE_INPUT or raises the existing
%      singleton*.
%
%      H = ISOLATED_ARBITRARY_BASE_INPUT returns the handle to a new ISOLATED_ARBITRARY_BASE_INPUT or the handle to
%      the existing singleton*.
%
%      ISOLATED_ARBITRARY_BASE_INPUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISOLATED_ARBITRARY_BASE_INPUT.M with the given input arguments.
%
%      ISOLATED_ARBITRARY_BASE_INPUT('Property','Value',...) creates a new ISOLATED_ARBITRARY_BASE_INPUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before isolated_arbitrary_base_input_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to isolated_arbitrary_base_input_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help isolated_arbitrary_base_input

% Last Modified by GUIDE v2.5 04-Jan-2013 14:44:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @isolated_arbitrary_base_input_OpeningFcn, ...
                   'gui_OutputFcn',  @isolated_arbitrary_base_input_OutputFcn, ...
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


% --- Executes just before isolated_arbitrary_base_input is made visible.
function isolated_arbitrary_base_input_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to isolated_arbitrary_base_input (see VARARGIN)

% Choose default command line output for isolated_arbitrary_base_input
handles.output = hObject;

%% clc;
set(hObject, 'Units', 'pixels');
axes(handles.axes1);
bg = imread('isolated_box_RB.jpg');
info.Width=400;
info.Height=345;

axes(handles.axes1);
image(bg);
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [250 40 info.Width info.Height]);
axis off; 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes isolated_arbitrary_base_input wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = isolated_arbitrary_base_input_OutputFcn(hObject, eventdata, handles) 
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

  fig_num=getappdata(0,'fig_num');
      damp=getappdata(0,'damping_visc');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
      mass=getappdata(0,'mass');
      
      units=getappdata(0,'unit');
      
      if isempty(units)
          units=getappdata(0,'units');
      end
      
%

FS=get(handles.input_edit,'String');

THM=evalin('base',FS);
 
iaxis=get(handles.axis_listbox,'Value');

    t=THM(:,1);
    base=THM(:,2);
    num=length(t);
    tt=t;
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
ncontinue=1;
if(((dtmax-dtmin)/dt)>0.01)
    disp(' ')
    disp(' Warning:  time step is not constant.  ')
    Icon='warn';
    Title='Warning';
    Message='Time step is not constant.'; 
    msgbox(Message,Title,Icon);
end
if(ncontinue==1)
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(t,base);
    grid on;
    xlabel('Time(sec)');
    ylabel('Accel(G)');
    title('Base Input ');
%
    Q=ModeShapes;
    MST=ModeShapes';
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Digital Recursive Filtering Relationship 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                              srs_coefficients(fn,damp,dt);
%
    clear temp;
    temp=base;
    clear base;
    ntt=length(temp)+round((1.5/fn(1))/dt);
    base=zeros(ntt,1);
    base(1:length(temp))=temp;
%
    clear t;
    t=linspace(0,(ntt-1)*dt,ntt);
%
    nt=ntt;
%
    rd=zeros(nt,6);
    ra=zeros(nt,6);
%
    x=zeros(nt,6);
    a=zeros(nt,6);
%    
    acc=zeros(nt,6);
%
    for j=1:6
%
%   Acceleration Response
%
        yy=MST(j,iaxis)*mass*base;
        yy=yy';
%
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        a(:,j)=filter(forward,back,yy);
%
        a(:,j)=a(:,j)-yy(:);
%
%   Relative Displacement Response   
%
        rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
        rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];     
%    
        x(:,j)=filter(rd_forward,rd_back,yy);
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    for i=1:nt 
        rd(i,:)=Q(:,1:6)*x(i,1:6)';
        ra(i,:)=Q(:,1:6)*a(i,1:6)';  
%
        acc(i,:)=ra(i,:);
    end
%
    acc(:,iaxis)=acc(:,iaxis)+base;
%
    clear a;
    a=acc;
%
    if(units==1)
       rd=rd*386;
    else
       rd=rd*9.81*1000;     
    end
%
    for iv=1:3
%
        figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);       
        plot(t,rd(:,iv));
        grid on; 
        xlabel('Time(sec)');
        if(iaxis==1)
            out1=sprintf('Relative Displacement Response to X-axis Input Pulse');
        end  
        if(iaxis==2)
            out1=sprintf('Relative Displacement Response to Y-axis Input Pulse');
        end
         if(iaxis==3)
            out1=sprintf('Relative Displacement Response to Z-axis Input Pulse');
        end         
        title(out1);
        if(units==1)
            ylabel('Rel Disp(in)');
        else
            ylabel('Rel Disp(mm)');    
        end
        if(iv==1)
           legend ('X-axis Response');   
        end
        if(iv==2)
           legend ('Y-axis Response');   
        end
        if(iv==3)
           legend ('Z-axis Response');   
        end        
%
        figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);      
        plot(t,a(:,iv));
        grid on;
        xlabel('Time(sec)');
        if(iaxis==1)
            out1=sprintf('Acceleration Response to X-axis Input Pulse');
        end  
        if(iaxis==2)
            out1=sprintf('Acceleration Response to Y-axis Input Pulse');
        end
         if(iaxis==3)
            out1=sprintf('Acceleration Response to Z-axis Input Pulse');
        end         
        title(out1);

        ylabel('Accel(G)');
   
        if(iv==1)
           legend ('X-axis Response');   
        end
        if(iv==2)
           legend ('Y-axis Response');   
        end
        if(iv==3)
           legend ('Z-axis Response');   
        end        
%
    end
%
        ax=a(:,1);
        ay=a(:,2);
        az=a(:,3);
        rdx=rd(:,1);
        rdy=rd(:,2);
        rdz=rd(:,3);
%
        if(max(abs(ax))<1.0e-09 )
            ax=0.;
        end
        if(max(abs(ay))<1.0e-09 )
            ay=0.;
        end
        if(max(abs(az))<1.0e-09 )
            az=0.;
        end   
%
        if(max(abs(rdx))<1.0e-09 )
            rdx=0.;
        end
        if(max(abs(rdy))<1.0e-09 )
            rdy=0.;
        end
        if(max(abs(rdz))<1.0e-09 )
            rdz=0.;
        end         
%
        if(iaxis==1)
            out1=sprintf('\n X-axis input');
        end  
        if(iaxis==2)
            out1=sprintf('\n Y-axis input');
        end  
        if(iaxis==3)
            out1=sprintf('\n Z-axis input');
        end  
        
        disp(out1);
        
        disp(' ');
        disp('  Acceleration Response (G)');
        disp('              max       min  ');
        out1=sprintf('  X-axis:  %7.4g   %7.4g ',max(ax),min(ax));
        out2=sprintf('  Y-axis:  %7.4g   %7.4g ',max(ay),min(ay));
        out3=sprintf('  Z-axis:  %7.4g   %7.4g ',max(az),min(az));
        disp(out1);
        disp(out2);
        disp(out3);
%
        disp(' ');
        if(units==1)
            disp('  Relative Displacement Response (inch) ');
        else
            disp('  Relative Displacement Response (mm) ');            
        end
        disp('              max      min  ');
        out1=sprintf('  X-axis:  %7.4g   %7.4g ',max(rdx),min(rdx));
        out2=sprintf('  Y-axis:  %7.4g   %7.4g ',max(rdy),min(rdy));
        out3=sprintf('  Z-axis:  %7.4g   %7.4g ',max(rdz),min(rdz));
        disp(out1);
        disp(out2);
        disp(out3);
    end

msgbox('Calculation complete.  Output written to Matlab Command Window.');



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


% --- Executes on selection change in axis_listbox.
function axis_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to axis_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns axis_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from axis_listbox


% --- Executes during object creation, after setting all properties.
function axis_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axis_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
