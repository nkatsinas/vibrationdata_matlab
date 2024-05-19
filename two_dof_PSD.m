function varargout = two_dof_PSD(varargin)
% TWO_DOF_PSD MATLAB code for two_dof_PSD.fig
%      TWO_DOF_PSD, by itself, creates a new TWO_DOF_PSD or raises the existing
%      singleton*.
%
%      H = TWO_DOF_PSD returns the handle to a new TWO_DOF_PSD or the handle to
%      the existing singleton*.
%
%      TWO_DOF_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_PSD.M with the given input arguments.
%
%      TWO_DOF_PSD('Property','Value',...) creates a new TWO_DOF_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_PSD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_PSD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_PSD

% Last Modified by GUIDE v2.5 21-Nov-2021 14:55:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_PSD_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_PSD_OutputFcn, ...
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


% --- Executes just before two_dof_PSD is made visible.
function two_dof_PSD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_PSD (see VARARGIN)

% Choose default command line output for two_dof_PSD
handles.output = hObject;

set(handles.listbox_psave,'Value',2);

set(handles.uibuttongroup_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_PSD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_PSD_OutputFcn(hObject, eventdata, handles) 
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
      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        m2=getappdata(0,'m2');
      unit=getappdata(0,'unit');
%

FS=get(handles.input_edit,'String');

THM=evalin('base',FS);

FS

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
two_damp_omegan=zeros(dof,1);
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
    mm=[m2(1,1); m2(2,2)];
%
    Y=-MST*mm;
%
    for i=1:N 
%
         n=zeros(dof,1);
%
        for j=1:dof
           A=Y(j);
           den= (omn2(j)-om2(i)) + (1i)*(two_damp_omegan(j)*omega(i));
           n(j)=A/den;
        end
        na=-om2(i)*n;
%
         rd(i,:)=ModeShapes*n;
        acc(i,:)=ModeShapes*na;
        acc(i,:)=acc(i,:)+1;  
%
    end 
%
    acc=abs(acc);
%
    if(unit==1)
       rd_trans=[386*rd];
    else
      rd_trans=[9.81*rd];   
    end
%
    rd21_trans=abs(rd_trans(:,2)-rd_trans(:,1)); 
    rd_trans=abs(rd_trans);
%
    acc_trans=[acc]; 
%
power_acc=zeros(N,2);
power_rd_trans=zeros(N,2);
%
for i=1:N
    for j=1:2
        power_acc(i,j)=acc(i,j)^2;
        power_rd(i,j)=rd_trans(i,j)^2;
        power_rd21(i)=rd21_trans(i)^2;
    end
    power_rd21(i)=rd21_trans(i)^2;    
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
xi=zeros(M,1);
yi=zeros(M,1);
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
    for j=1:2
        acc_response_psd(i,j)=power_acc(i,j)*yi(i);
         rd_response_psd(i,j)= power_rd(i,j)*yi(i);
    end
    rd21_response_psd(i)= power_rd21(i)*yi(i);
end
%
temp=freq;
clear freq;
freq=temp(1:P);
%
[~,accel_rms_1]=calculate_PSD_slopes( freq,acc_response_psd(:,1)  );
[~,accel_rms_2]=calculate_PSD_slopes( freq,acc_response_psd(:,2)  );
%
[~,disp_rms_1]=calculate_PSD_slopes(  freq,rd_response_psd(:,1)   );
[~,disp_rms_2]=calculate_PSD_slopes(  freq,rd_response_psd(:,2)   );
[~,disp_rms_21]=calculate_PSD_slopes(  freq,rd21_response_psd   );
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==1)
   dd='in'; 
else
   dd='mm';
%
   disp_rms_1=disp_rms_1*1000;
   disp_rms_2=disp_rms_2*1000; 
   disp_rms_21=disp_rms_21*1000;    
%
end
%
%
%%
psave=get(handles.listbox_psave,'Value');
%
disp(' ');
disp('Acceleration Response ');
out1=sprintf(' Mass 1:  %8.4g GRMS',accel_rms_1);
out2=sprintf(' Mass 2:  %8.4g GRMS',accel_rms_2);
disp(out1);
disp(out2);
%
disp(' ');
disp(' Relative Displacement Response ');
out1=sprintf(' Mass 1:  %8.4g %s RMS',disp_rms_1,dd);
out2=sprintf(' Mass 2:  %8.4g %s RMS \n',disp_rms_2,dd);
disp(out1);
disp(out2);
out3=sprintf(' Mass 2-Mass 1:  %8.4g %s RMS',disp_rms_21,dd);
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
freq=fix_size(freq);
%
setappdata(0,'acc_response_psd_1',[freq acc_response_psd(:,1)]); 
setappdata(0,'acc_response_psd_2',[freq acc_response_psd(:,2)]); 
%

h1=figure(fig_num);
fig_num=fig_num+1;

ymax2=max(acc_response_psd(:,1));
ymax3=max(acc_response_psd(:,2));
%
ymin2=min(acc_response_psd(:,1));
ymin3=min(acc_response_psd(:,2));
%
ymax=max([ymax2, ymax3]);
ymin=min([ymin2, ymin3]);
%
ymax=10^ceil(log10(ymax));
ymin=10^floor(log10(ymin));
%   
if(ymin<ymax*0.0001)
   ymin=ymax*0.0001;
end  
%   
fmin=10^(floor(log10(min(freq))));
fmax=10^(ceil(log10(max(freq))));

%
s0=sprintf('Base Input %6.3g GRMS',input_rms);
s1=sprintf('Mass 1 Response %6.3g GRMS',accel_rms_1);
s2=sprintf('Mass 2 Response %6.3g GRMS',accel_rms_2);    

setappdata(0,'fig_num',fig_num);

plot(THM(:,1),THM(:,2),freq,acc_response_psd(:,1),...
                   freq,acc_response_psd(:,2));
grid on;
title('Acceleration Response PSD ');
xlabel(xlab);
ylabel(ylab_acc);
%
legend (s0,s1,s2); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
axis([fmin,fmax,ymin,ymax]);
%
if(psave==1)
    
    disp(' ');
    disp(' Plot files:');
    disp(' ');
    
    pname='accel_psd_plot';
        
    out1=sprintf('   %s.png',pname);
    disp(out1);
    
    set(gca,'Fontsize',12);
    print(h1,pname,'-dpng','-r300');
    
end    

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==2)
    rd_response_psd=rd_response_psd*1.0e+06;
    rd21_response_psd=rd21_response_psd*1.0e+06;
end
%
rd21_response_psd=fix_size(rd21_response_psd);
%
setappdata(0,'rd_response_psd_1',[freq rd_response_psd(:,1)]); 
setappdata(0,'rd_response_psd_2',[freq rd_response_psd(:,2)]); 
setappdata(0,'rd_response_psd_21',[freq rd21_response_psd]); 
%
h2=figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(freq,rd_response_psd(:,1),freq,rd_response_psd(:,2),freq,rd21_response_psd);
grid on;
xlabel(xlab);
ylabel(ylab_rd);

%
title('Relative Displacement Response PSD');
%
s1=sprintf('mass 1 - base    %6.3g %s RMS',disp_rms_1,dd);
s2=sprintf('mass 2 - base    %6.3g %s RMS',disp_rms_2,dd);
s3=sprintf('mass 2 - mass 1  %6.3g %s RMS',disp_rms_21,dd);
%
legend (s1,s2,s3); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
    ymax2=max(rd_response_psd(:,1));
    ymax3=max(rd_response_psd(:,2));
%
    ymin2=min(rd_response_psd(:,1));
    ymin3=min(rd_response_psd(:,2));
%
    ymax=max([ymax2, ymax3]);
    ymin=min([ymin2, ymin3]);
%
    ymax=10^ceil(log10(ymax));
    ymin=10^floor(log10(ymin));
%   
    if(ymin<ymax*0.00001)
        ymin=ymax*0.00001;
    end    
    axis([fmin,fmax,ymin,ymax]);
    
if(psave==1)
    
    pname='rd_psd_plot';
        
    out1=sprintf('   %s.png',pname);
    disp(out1);
    
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');
    
end        
    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
set(handles.uibuttongroup_save,'Visible','on');

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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(two_dof_PSD);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_output_type,'Value');
 
if(n==1)
    data=getappdata(0,'acc_response_psd_1'); 
end
if(n==2)
    data=getappdata(0,'acc_response_psd_2');
end
if(n==3)
    data=getappdata(0,'rd_response_psd_1'); 
end
if(n==4)
    data=getappdata(0,'rd_response_psd_2'); 
end
if(n==5)
    data=getappdata(0,'rd_response_psd_21'); 
end
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);
 
h = msgbox('Save Complete'); 



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_type.
function listbox_output_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_type


% --- Executes during object creation, after setting all properties.
function listbox_output_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function calculate_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
