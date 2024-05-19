function varargout = ss_plate_psd(varargin)
% SS_PLATE_PSD MATLAB code for ss_plate_psd.fig
%      SS_PLATE_PSD, by itself, creates a new SS_PLATE_PSD or raises the existing
%      singleton*.
%
%      H = SS_PLATE_PSD returns the handle to a new SS_PLATE_PSD or the handle to
%      the existing singleton*.
%
%      SS_PLATE_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SS_PLATE_PSD.M with the given input arguments.
%
%      SS_PLATE_PSD('Property','Value',...) creates a new SS_PLATE_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ss_plate_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ss_plate_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ss_plate_psd

% Last Modified by GUIDE v2.5 03-Sep-2014 14:01:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ss_plate_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @ss_plate_psd_OutputFcn, ...
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


% --- Executes just before ss_plate_psd is made visible.
function ss_plate_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ss_plate_psd (see VARARGIN)

% Choose default command line output for ss_plate_psd
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ss_plate_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ss_plate_psd_OutputFcn(hObject, eventdata, handles) 
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
delete(ss_plate_psd);



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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * ');
disp(' ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FS=get(handles.input_edit,'String');
%
THM=evalin('base',FS);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=getappdata(0,'fig_num');

      damp=getappdata(0,'damp_ratio');
   
      if(length(damp)==0)
          warndlg('damping vector does not exist');
          return;
      end    
      
      
      fbig=getappdata(0,'fbig');
        iu=getappdata(0,'iu');
        unit=iu;
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
part=fbig(:,4);

m_index=fbig(:,6);
n_index=fbig(:,7);

num=length(fn);

try
    mt=getappdata(0,'mt');

    if(mt<num)
        num=mt;
    end
  
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

pax=x*pi/a;
pby=y*pi/b;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   clear f;
   fmax=max(THM(:,1));
   nf=10000;
   n=length(fn);
%
   disp(' ');
%
   f=zeros(nf,1);
   f(1)=0.8*THM(1,1);
   for k=2:nf
        f(k)=f(k-1)*2^(1/48);
        if(f(k)>fmax)
            break;
        end    
   end
   nf=max(size(f));
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
[accel_trans,rv_trans,rd_trans,vM_trans,HA,Hv,H,HM_stress_vM,Hsxx,Hsyy,Htxy]...
        =ss_plate_trans_core(nf,f,fn,damp,pax,pby,part,Amn,fbig,a,b,T,E,mu,iu);
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PSD_in=THM;
%


[acc_response_psd]=psd_mult_trans(PSD_in,accel_trans);
 [rv_response_psd]=psd_mult_trans(PSD_in,rv_trans);
 [rd_response_psd]=psd_mult_trans(PSD_in,rd_trans);
 [vM_response_psd]=psd_mult_trans(PSD_in,vM_trans);


setappdata(0,'acc_response_psd',acc_response_psd); 
setappdata(0,'rv_response_psd',rv_response_psd); 
setappdata(0,'rd_response_psd',rd_response_psd); 
setappdata(0,'vM_response_psd',vM_response_psd); 

%    
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
[~,accel_rms]=calculate_PSD_slopes( acc_response_psd(:,1),acc_response_psd(:,2)  );
%
[~,vel_rms]=calculate_PSD_slopes(  rv_response_psd(:,1),rv_response_psd(:,2)  );
%
[~,disp_rms]=calculate_PSD_slopes(  rd_response_psd(:,1),rd_response_psd(:,2)  );
%
[~,vM_rms]=calculate_PSD_slopes(  vM_response_psd(:,1),vM_response_psd(:,2)  );
%



freq=acc_response_psd(:,1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==1)
   dd='in';
   vv='in/sec';
   ss='psi';
else
   dd='mm';
   vv='m/sec';
   ss='MPa';
   vM_rms=vM_rms/(1.0e+06);
%
   disp_rms=disp_rms*1000;
%
end
%
%
%%
%
disp(' ');
disp('Acceleration Response ');
out1=sprintf(' %8.4g GRMS',accel_rms);
disp(out1);
%
disp(' ');
disp('Relative Velocity Response ');
out1=sprintf(' %8.4g %s RMS',vel_rms,vv);
disp(out1);
%
disp(' ');
disp(' Relative Displacement Response ');
out1=sprintf(' %8.4g %s RMS',disp_rms,dd);
disp(out1);
%
disp(' ');
disp(' von Mises Response ');
out1=sprintf(' %8.4g %s RMS',vM_rms,ss);
disp(out1);
%%

if(n_loc==1)
    
    [Hunt_rms]=Hunt_plate_stress(E,rho,mu,a,b,vel_rms,ss);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
xlab=sprintf(' Frequency (Hz)');
ylab_acc=sprintf('Accel (G^2/Hz)');
%
if(unit==1)
    ylab_rv=sprintf('Rel Vel (in/sec)^2/Hz)');
    ylab_rd=sprintf('Rel Disp (inch^2/Hz)');
    ylab_ss=sprintf('Stress (psi^2/Hz)');    
else
    ylab_rv=sprintf('Rel Vel (m/sec)^2/Hz)');    
    ylab_rd=sprintf('Rel Disp (mm^2/Hz)');
    ylab_ss=sprintf('Stress (Pa^2/Hz)');      
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[~,input_rms]=calculate_PSD_slopes( THM(:,1),THM(:,2) );
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(THM(:,1),THM(:,2),acc_response_psd(:,1),acc_response_psd(:,2));
grid on;
xlabel(xlab);
ylabel(ylab_acc);
%
title('Acceleration Response PSD ');
%
s0=sprintf('Base Input %6.3g GRMS',input_rms);
s1=sprintf('Response %6.3g GRMS',accel_rms);
%
legend (s0,s1); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
%
    ymin=10^(floor(log10(min(THM(:,2)))));
    ymax=10^(ceil(log10(max(acc_response_psd(:,2)))));
    
    fmin=10^(floor(log10(min(freq))));
    fmax=10^(ceil(log10(max(freq))));
    axis([fmin,fmax,ymin,ymax]);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(rv_response_psd(:,1),rv_response_psd(:,2));
grid on;
xlabel(xlab);
ylabel(ylab_rv);
%
title('Relative Velocity Response PSD');
%
s1=sprintf('Response %6.3g %s RMS',vel_rms,vv);
%
legend(s1); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
    ymin=10^(floor(log10(min(rv_response_psd(:,2)))));
    ymax=10^(ceil(log10(max(rv_response_psd(:,2)))));
 %   
    if(ymin<ymax*1.0e-05)
        ymin=ymax*1.0e-05;
    end    
    
    axis([fmin,fmax,ymin,ymax]);
%

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==2)  % convert to mm^2
    rd_response_psd(:,2)=rd_response_psd(:,2)*1.0e+06;
end
%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(rd_response_psd(:,1),rd_response_psd(:,2));
grid on;
xlabel(xlab);
ylabel(ylab_rd);
%
title('Relative Displacement Response PSD');
%
s1=sprintf('Response %6.3g %s RMS',disp_rms,dd);
%
legend(s1); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
    ymin=10^(floor(log10(min(rd_response_psd(:,2)))));
    ymax=10^(ceil(log10(max(rd_response_psd(:,2)))));
 %   
    if(ymin<ymax*1.0e-05)
        ymin=ymax*1.0e-05;
    end    
    
    axis([fmin,fmax,ymin,ymax]);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(vM_response_psd(:,1),vM_response_psd(:,2));
grid on;
xlabel(xlab);
ylabel(ylab_ss);
%
title('von Mises Stress PSD');
%
s1=sprintf('Response %6.3g %s RMS',vM_rms,ss);
%
legend(s1); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
    ymin=10^(floor(log10(min(vM_response_psd(:,2)))));
    ymax=10^(ceil(log10(max(vM_response_psd(:,2)))));
 %   
    if(ymin<ymax*1.0e-05)
        ymin=ymax*1.0e-05;
    end    
    
    axis([fmin,fmax,ymin,ymax]);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(handles.uipanel_save,'Visible','on');

setappdata(0,'fig_num',fig_num);


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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

if(n==1)
    data=getappdata(0,'acc_response_psd');
end
if(n==2)
    data=getappdata(0,'rv_response_psd');
end
if(n==3)
    data=getappdata(0,'rd_response_psd');
end
if(n==4)
    data=getappdata(0,'vM_response_psd');
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


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
