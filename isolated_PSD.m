function varargout = isolated_PSD(varargin)
% ISOLATED_PSD MATLAB code for isolated_PSD.fig
%      ISOLATED_PSD, by itself, creates a new ISOLATED_PSD or raises the existing
%      singleton*.
%
%      H = ISOLATED_PSD returns the handle to a new ISOLATED_PSD or the handle to
%      the existing singleton*.
%
%      ISOLATED_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISOLATED_PSD.M with the given input arguments.
%
%      ISOLATED_PSD('Property','Value',...) creates a new ISOLATED_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before isolated_PSD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to isolated_PSD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help isolated_PSD

% Last Modified by GUIDE v2.5 07-Jan-2013 10:23:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @isolated_PSD_OpeningFcn, ...
                   'gui_OutputFcn',  @isolated_PSD_OutputFcn, ...
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


% --- Executes just before isolated_PSD is made visible.
function isolated_PSD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to isolated_PSD (see VARARGIN)

% Choose default command line output for isolated_PSD
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

% UIWAIT makes isolated_PSD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = isolated_PSD_OutputFcn(hObject, eventdata, handles) 
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
      unit=getappdata(0,'unit');
%

try
    FS=get(handles.input_edit,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found');
    return;
end
    
iaxis=get(handles.axis_listbox,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omegan=2*pi*fn;        
        
MST=ModeShapes';
%
sz=size(ModeShapes);
dof=(sz(1));
num=dof;
%
THM=fix_size(THM);
%
sz=size(THM);
n=sz(1);
%
fstart=THM(1,1);
fend=THM(n,1);
%
if(fstart<=0)
    msgbox('Error: starting frequency must be >0 ');
end
%
N=48;
%
noct=log(fend/fstart)/log(2);
np=floor(noct*N);
%
freq=zeros(np,1);
%
R=2^(1/N);
%
freq(1)=fstart;
for i=2:np
    freq(i)=freq(i-1)*R;
end
freq(np)=fend;
%
N=np;
%
sz=size(freq);
if(sz(2)>sz(1))
    freq=freq';
end
%
omega=2*pi*freq;
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
     rd=zeros(N,dof);
    acc=zeros(N,dof);
%
    for i=1:N 
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
       rd_trans=[386*rd];
    else
      rd_trans=[9.81*rd];   
    end
%    
    acc_trans=[acc]; 
%
power_acc=zeros(N,3);
power_rd_trans=zeros(N,3);
%
for i=1:N
    for j=1:3
        power_acc(i,j)=acc(i,j)^2;
        power_rd(i,j)=rd_trans(i,j)^2;
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
y=double(THM(:,2));
x=double(THM(:,1)); 
%
xL=log10(x);
yL=log10(y);
xiL=log10(freq);
%
yiL = interp1(xL,yL,xiL);
%
clear xi;
clear yi;
clear freq;
clear length;
M=length(yiL);
%
for i=1:M
    xi(i)=10^xiL(i);
    yi(i)=10^yiL(i);
end
%
freq=xi;
%
P=min([ length(power_acc(:,1)) length(yi)]);
%
for i=1:P
    for j=1:3
        acc_response_psd(i,j)=power_acc(i,j)*yi(i);
         rd_response_psd(i,j)= power_rd(i,j)*yi(i);
    end
end
%
temp=freq;
clear freq;
freq=temp(1:P);
%
[~,accel_rms_x]=calculate_PSD_slopes( freq,acc_response_psd(:,1)  );
[~,accel_rms_y]=calculate_PSD_slopes( freq,acc_response_psd(:,2)  );
[~,accel_rms_z]=calculate_PSD_slopes( freq,acc_response_psd(:,3)  );
%
[~,disp_rms_x]=calculate_PSD_slopes(  freq,rd_response_psd(:,1)   );
[~,disp_rms_y]=calculate_PSD_slopes(  freq,rd_response_psd(:,2)   );
[~,disp_rms_z]=calculate_PSD_slopes(  freq,rd_response_psd(:,3)   );
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==1)
   dd='in'; 
else
   dd='mm';
%
   disp_rms_x=disp_rms_x*1000;
   disp_rms_y=disp_rms_y*1000;
   disp_rms_z=disp_rms_z*1000; 
%
end
%
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
%
disp(out1);
%
maxA=max([ accel_rms_x accel_rms_y accel_rms_z  ]);
maxRD=max([ disp_rms_x disp_rms_y disp_rms_z  ]);
%
LL=maxA/1000;
%
if(accel_rms_x<LL)
    accel_rms_x=0;
end   
%
if(accel_rms_y<LL)
    accel_rms_y=0;
end    
%
if(accel_rms_z<LL)
    accel_rms_z=0;
end    
%
%%
%
LL=maxRD/1000;
%
if(disp_rms_x<LL)
    disp_rms_x=0;
end   
%
if(disp_rms_y<LL)
    disp_rms_y=0;
end    
%
if(disp_rms_z<LL)
    disp_rms_z=0;
end  
%
%%
%
disp(' ');
disp(' C.G. Acceleration Response ');
out1=sprintf('  X-axis:  %8.4g GRMS',accel_rms_x);
out2=sprintf('  Y-axis:  %8.4g GRMS',accel_rms_y);
out3=sprintf('  Z-axis:  %8.4g GRMS',accel_rms_z);
disp(out1);
disp(out2);
disp(out3);
%
disp(' ');
disp(' C.G. Relative Displacement Response ');
out1=sprintf('  X-axis:  %8.4g %s RMS',disp_rms_x,dd);
out2=sprintf('  Y-axis:  %8.4g %s RMS',disp_rms_y,dd);
out3=sprintf('  Z-axis:  %8.4g %s RMS',disp_rms_z,dd);
disp(out1);
disp(out2);
disp(out3);
%%
%
xlab=sprintf(' Frequency (Hz)');
ylab_acc=sprintf('Accel (G^2/Hz)');
%
if(unit==1)
    ylab_rd=sprintf('Rel Disp (inch^2/Hz)');
else
    ylab_rd=sprintf('Rel Disp (mm^2/Hz)');
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[~,input_rms]=calculate_PSD_slopes( THM(:,1),THM(:,2)  );
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(THM(:,1),THM(:,2),freq,acc_response_psd(:,1),...
                   freq,acc_response_psd(:,2),freq,acc_response_psd(:,3));
grid on;
xlabel(xlab);
ylabel(ylab_acc);
%
if(iaxis==1)
    title('Acceleration Response PSD  X-axis Input');
end
if(iaxis==2)
    title('Acceleration Response PSD  Y-axis Input');
end
if(iaxis==3)
    title('Acceleration Response PSD  Z-axis Input');
end
%
s0=sprintf('Base Input %6.3g GRMS',input_rms);
s1=sprintf('X-axis Response %6.3g GRMS',accel_rms_x);
s2=sprintf('Y-axis Response %6.3g GRMS',accel_rms_y);
s3=sprintf('Z-axis Response %6.3g GRMS',accel_rms_z);
%
legend (s0,s1,s2,s3); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
    ymax2=max(acc_response_psd(:,1));
    ymax3=max(acc_response_psd(:,2));
    ymax4=max(acc_response_psd(:,3));
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
    fmin=10^(floor(log10(min(freq))));
    fmax=10^(ceil(log10(max(freq))));
    axis([fmin,fmax,ymin,ymax]);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==2)
    rd_response_psd=rd_response_psd*1.0e+06;
end
%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(freq,rd_response_psd(:,1),freq,rd_response_psd(:,2),freq,rd_response_psd(:,3));
grid on;
xlabel(xlab);
ylabel(ylab_rd);
%
if(iaxis==1)
    title('Relative Displacement Response PSD  X-axis Input');
end
if(iaxis==2)
    title('Relative Displacement Response PSD  Y-axis Input');
end
if(iaxis==3)
    title('Relative Displacement Response PSD  Z-axis Input');
end
%
s1=sprintf('X-axis Response %6.3g %s RMS',disp_rms_x,dd);
s2=sprintf('Y-axis Response %6.3g %s RMS',disp_rms_y,dd);
s3=sprintf('Z-axis Response %6.3g %s RMS',disp_rms_z,dd);
%
legend (s1,s2,s3); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
    ymax2=max(rd_response_psd(:,1));
    ymax3=max(rd_response_psd(:,2));
    ymax4=max(rd_response_psd(:,3));
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
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
msgbox('Calculation complete.  Output written to Matlab Command Window.');


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
