function varargout = sdof_arbitrary(varargin)
% SDOF_ARBITRARY MATLAB code for sdof_arbitrary.fig
%      SDOF_ARBITRARY, by itself, creates a new SDOF_ARBITRARY or raises the existing
%      singleton*.
%
%      H = SDOF_ARBITRARY returns the handle to a new SDOF_ARBITRARY or the handle to
%      the existing singleton*.
%
%      SDOF_ARBITRARY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SDOF_ARBITRARY.M with the given input arguments.
%
%      SDOF_ARBITRARY('Property','Value',...) creates a new SDOF_ARBITRARY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sdof_arbitrary_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sdof_arbitrary_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sdof_arbitrary

% Last Modified by GUIDE v2.5 23-Jan-2013 12:50:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sdof_arbitrary_OpeningFcn, ...
                   'gui_OutputFcn',  @sdof_arbitrary_OutputFcn, ...
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


% --- Executes just before sdof_arbitrary is made visible.
function sdof_arbitrary_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sdof_arbitrary (see VARARGIN)

% Choose default command line output for sdof_arbitrary
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sdof_arbitrary wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sdof_arbitrary_OutputFcn(hObject, eventdata, handles) 
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
%
  fig_num=getappdata(0,'fig_num');
      damp=getappdata(0,'damping');
        fn=getappdata(0,'fn');
      iu=getappdata(0,'unit');
      Q=getappdata(0,'Q');
%
FS=get(handles.input_edit,'String');
%
THM=evalin('base',FS);
%
    limit=1.0e+90;
%
    sz=size(THM);
    for i=1:sz(1)
        if(THM(i,1)>-limit && THM(i,1)<limit)
        else
            THM(i,:)=[];
            sz(1)=sz(1)-1;
        end
    end
%
    t=THM(:,1);
    base=THM(:,2);
    clear length;
    num=length(t);
    tt=t;
%
    dt=(t(num)-t(1))/(num-1);
%
    out1=sprintf('\n %8.4g  %8.4g \n',t(num),t(1));
    disp(out1);
    out1=sprintf(' num=%d ',num);
    disp(out1);
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
%
%  Initialize coefficients
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);    
%
%  SRS engine
%
disp(' ')
disp(' Calculating acceleration');
%
yy=base;
n=num;
%
for j=1:1
%
    forward=[ b1(j),  b2(j),  b3(j) ];
    back   =[     1, -a1(j), -a2(j) ];
%    
    a_resp=filter(forward,back,yy);
%
    x_pos(j)= max(a_resp);
    x_neg(j)= min(a_resp);
%
    disp(' ')
    disp(' Calculating relative displacement');
%
    rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
    rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];  
%    
    rd_resp=filter(rd_forward,rd_back,yy);
%
    rd_pos(j)= max(rd_resp);
    rd_neg(j)= min(rd_resp);
end
disp(' ')
disp(' Acceleration Response ')
disp(' ')

peak=max(abs(a_resp));
if(abs(x_neg(1))>peak)
    peak=abs(x_neg(1));
end
%
[mu,sd,rms,sk,kt]=kurtosis_stats(a_resp);
arms=rms;
kurtosis=kt;

%
 out9=sprintf('\n absolute peak = %8.2f G',peak);
out10=sprintf('\n       maximum = %9.2f G',x_pos(1));
  out11=sprintf('       minimum = %9.2f G',x_neg(1));
  out12=sprintf('       overall = %9.2f GRMS',arms);
out13=sprintf('\n          mean = %9.2f G',mu);
  out14=sprintf('       std dev = %9.2f G',sd);
  out15=sprintf('  crest factor = %9.2f',peak/sd);
  out16=sprintf('      kurtosis = %9.2f',kurtosis);  
%
disp(out9);
disp(out10)
disp(out11)
disp(out12)
disp(out13)
disp(out14)
disp(out15)
disp(out16)
%
disp(' ')
disp(' Relative Displacement Response ')
mu=mean(rd_resp);
sd=std(rd_resp);
%
if(iu==1)
    rd_rms=sqrt(sd^2+mu^2)*386.;
    out10=sprintf('\n maximum = %10.3g inch',rd_pos(1)*386.);
    out11=sprintf(' minimum = %10.3g inch',rd_neg(1)*386.);
    out12=sprintf(' overall = %10.3g inch RMS',rd_rms);
else
    rd_rms=sqrt(sd^2+mu^2)*9.81*1000;
    out10=sprintf('\n maximum = %10.3g mm',rd_pos(1)*9.81*1000);
    out11=sprintf(' minimum = %10.3g mm',rd_neg(1)*9.81*1000);
    out12=sprintf(' overall = %10.3g mm RMS',rd_rms);    
end
disp(out10)
disp(out11)
disp(out12)
%
nn=length(a_resp);
%
tmin=t(1);
tmax=(t(1)+(nn-1)*dt);
%
tt=linspace(tmin,tmax,nn);
ymin=1.3*min(a_resp);
ymax=1.3*max(a_resp);
if(abs(ymin)>abs(ymax))
    ymax=abs(ymin); 
end
if(abs(ymax)>abs(ymin))
    ymin=-abs(ymax); 
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%  Output 
%
clear acceleration;
clear rel_disp;
disp(' ');
acceleration(:,1)=tt';
acceleration(:,2)=a_resp';
%
rel_disp(:,1)=tt';
if(iu==1)
    rel_disp(:,2)=(rd_resp*386.)';
else
    rel_disp(:,2)=(rd_resp*9.81*1000)';    
end    
%
%
%  Plot acceleration response
%

t_string = sprintf(' SDOF Acceleration Response   fn=%7.3g Hz   Q=%7.3g ',fn(1),Q);
y_label=sprintf('Accel (G)');
x_label=sprintf('Time (sec)');   
[fig_num]=plot_TH(fig_num,x_label,y_label,t_string,acceleration);
%


    t_string = sprintf(' SDOF Relative Displacement  Response   fn=%7.3g Hz   Q=%7.3g ',fn(1),Q);
    if(iu==1)
        y_label=sprintf('Relative Disp (inch)');
    else
        y_label=sprintf('Relative Disp (mm)');       
    end
    x_label=sprintf('Time (sec)');   
    [fig_num]=plot_TH(fig_num,x_label,y_label,t_string,rel_disp);    

%     
end
                  
msgbox('Calculation complete.  Output written to Matlab Command Window.');      

setappdata(0,'fig_num',fig_num);


% --- Executes on button press in return_pushbutton.
function return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(sdof_arbitrary);


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
