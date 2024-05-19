function varargout = vibrationdata_psd_sdof_base(varargin)
% VIBRATIONDATA_PSD_SDOF_BASE MATLAB code for vibrationdata_psd_sdof_base.fig
%      VIBRATIONDATA_PSD_SDOF_BASE, by itself, creates a new VIBRATIONDATA_PSD_SDOF_BASE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PSD_SDOF_BASE returns the handle to a new VIBRATIONDATA_PSD_SDOF_BASE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PSD_SDOF_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PSD_SDOF_BASE.M with the given input arguments.
%
%      VIBRATIONDATA_PSD_SDOF_BASE('Property','Value',...) creates a new VIBRATIONDATA_PSD_SDOF_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_psd_sdof_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_psd_sdof_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_psd_sdof_base

% Last Modified by GUIDE v2.5 24-Nov-2020 09:14:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_psd_sdof_base_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_psd_sdof_base_OutputFcn, ...
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


% --- Executes just before vibrationdata_psd_sdof_base is made visible.
function vibrationdata_psd_sdof_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_psd_sdof_base (see VARARGIN)

% Choose default command line output for vibrationdata_psd_sdof_base
handles.output = hObject;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cmap(1,:)=[0 0.1 0.4];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];      % gold
cmap(16,:)=[0 0.8 0.8];     % turquoise   
 
%%%%% axes 1 %%%%%%%%%%%%
 
%%%%%% masses %%%%%%%%%%%%
 
clc; 
axes(handles.axes1);

x=[-5.5 -5.5 5.5 5.5 -5.5];
y=[5.5 6 6 5.5 5.5]-3;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

x=[-4 -4 4 4 -4]; 
y=[3 6 6 3 3]+3.5;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
 
%%%%%% side lines %%%%%%%%%%%%
 
x=[5.5 7.5];
y=[1.5 1.5]+1.25;
plot(x,y,'Color','k');
 
 
x=[4 7.5];
y=[8 8];
plot(x,y,'Color','k');
 
%%%%%% text %%%%%%%%%%%%
 
% text(7,10,'${\ddot{X}}$','Interpreter','latex');

text(8.32,5.15,'..','fontsize',13);
text(8.5,4.5,'y','fontsize',11);

text(8.32,10.65,'..','fontsize',13);
text(8.5,10,'x','fontsize',11);

 
text(-0.9,8,'m','fontsize',11);

text(-5,5.2,'k','fontsize',11);

text(4.5,5.3,'c','fontsize',11);
 
%%%%%% arrows %%%%%%%%%%%%
 
headWidth = 4;
headLength = 4;
 
       
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[7.5 2.75 0 1.5]);        
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[7.5 8 0 1.5]);        
        
 
        
%%%%%% spring %%%%%%%%%%%%        
 
nn=2000;
 
dt=4/(nn-1);
 
t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=sawtooth(2*pi*t,0.5);
 
t=2.5*t/(max(t)-min(t))+2;
 
plot(y-2,t+2,'Color',cmap(5,:),'linewidth',0.75);

x=[-2 -2];
y=[3 min(t+2)];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
 
x=[-2 -2];
y=[max(t)+2 max(t)+2.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 

%%%%%% dashpot %%%%%%%%%%

x=[2.25 2.25];
y=[3 4.625];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.75 2.75];
y=[4.625 4.625];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[2.25 2.25];
y=[5 6.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.25 3.25];
y=[5 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[1.25 1.25];
y=[4.6 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[3.25 3.25];
y=[4.6 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 

%%%%%% end %%%%%%%%%%%%
 
hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-10 12]);
ylim([0 13]);
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


set(handles.edit_Q,'String','10');

set(handles.edit_results,'Enable','off');

set(handles.listbox_method,'Value',1);
set(handles.listbox_interpolate,'Value',1);

set(handles.pushbutton_calculate,'Enable','on');

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off')

set(handles.pushbutton_fatigue,'Enable','off');
set(handles.pushbutton_Steinberg,'Enable','off');

set(handles.edit_input_array,'Visible','on');
set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Enable','on');
set(handles.text_input_array_name,'Enable','on');

listbox_interpolate_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_psd_sdof_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_psd_sdof_base_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save_type,'Value');

if(n==1)
    data=getappdata(0,'AccelResponsePSD');
end
if(n==2)
    data=getappdata(0,'RDResponsePSD');    
end
if(n==3)
    data=getappdata(0,'AccelPowerTrans');
end
    
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

set(handles.pushbutton_fatigue,'Enable','on');
set(handles.pushbutton_Steinberg,'Enable','on');

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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

clear_results(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','off');

n=get(hObject,'Value');

set(handles.edit_output_array,'Enable','off');

set(handles.pushbutton_save,'Enable','off');

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
   
   set(handles.pushbutton_calculate,'Enable','on');
end

% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
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


try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end  


psave=get(handles.listbox_psave,'Value');

k=get(handles.listbox_method,'Value');


set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save,'Enable','on')
set(handles.edit_results,'Enable','off');

 
try

    if(k==1)
        FS=get(handles.edit_input_array,'String');
        THM=evalin('base',FS);   
    else
        THM=getappdata(0,'THM');
    end

catch
    
    warndlg('Input Filename Error');
    
    return;
    
end

n=length(THM(:,1));

if(THM(:,1)<1.0e-20)
    THM(1,:)=[];
end


sminf=get(handles.edit_fmin,'String');
smaxf=get(handles.edit_fmax,'String');

if isempty(sminf)
    string=sprintf('%8.4g',THM(1,1));
    set(handles.edit_fmin,'String',string);
end

if isempty(smaxf)
    string=sprintf('%8.4g',THM(n,1));    
    set(handles.edit_fmax,'String',string);
end


%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[s,input_rms] = calculate_PSD_slopes(THM(:,1),THM(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q=str2num(get(handles.edit_Q,'String'));


fns=get(handles.edit_fn,'String');

if isempty(fns)
    warndlg('Enter Natural Frequency');
    return;
else
    fn=str2num(fns);    
end
 

durs=get(handles.edit_dur,'String');

if isempty(durs)
    warndlg('Enter Duration');
    return;
else
    dur=str2num(durs);    
end



damp=1/(2*Q);

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

if(fn<fmin)
    fmin=fn/2;
end  

if(fn>fmax)
    fmax=2*fn;
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=THM(:,1);
a=THM(:,2);
natural_frequency=fn;
omegan=2*pi*fn;

ni=get(handles.listbox_interpolate,'Value');

kflag=1;

if(ni==1)
   
    ndf=get(handles.listbox_df,'Value');
    
    if(ndf==1)
        df=0.5;
        [fi,ai]=interpolate_PSD(f,a,s,df);
    end
    if(ndf==2)
        df=1;     
        [fi,ai]=interpolate_PSD(f,a,s,df);        
    end
    if(ndf==3)
        kflag=2;
        new_freq(1)=f(1);
        k=2;
        while(1)
            new_freq(k)=new_freq(k-1)*2^(1/48);
            if(new_freq(k)>=f(end))
                break;
            end
            k=k+1;
        end
        new_freq(end)=f(end);
        [fi,ai] = interpolate_PSD_arbitrary_frequency_f(f,a,new_freq);         
    end   

else
    fi=f;
    ai=a;
    nnn=length(f);
    df=(f(end)-f(1))/(nnn-1);
end


%
[a_vrs,rd_vrs,trans,opsd,rd_psd]=...
                 vibrationdata_sdof_ran_engine_function_ard(fi,ai,damp,natural_frequency);
             
p=get(handles.listbox_unit,'Value');


clear length;
nai=length(fi);
%
 

if(p==1)
    rd_vrs=rd_vrs*386;
    rd_psd=rd_psd*386^2;
end
if(p==2)
    rd_vrs=rd_vrs*9.81*1000;
    rd_psd=rd_psd*(9.81*1000)^2;
end
if(p==3)
    rd_vrs=rd_vrs*1000;
    rd_psd=rd_psd*1000^2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn=natural_frequency;
T=dur;
ax=0.5;
[ms]=risk_overshoot(fn,T,ax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
ai=opsd;
 
if(kflag==1)   
    [EP,vo,m0,m1,m2,m4]=spectal_moments(fi,ai,df);    
else
    [EP,vo,m0,m1,m2,m4]=spectal_moments_oct(fi,ai);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

string_acc=sprintf(' SDOF Acceleration Response ');
string_pv=sprintf('\n\n SDOF Pseudo Velocity Response ');
string_rd=sprintf('\n\n SDOF Relative Displacement Response ');

if(p<=2)
    out1=sprintf('\n\n   = %8.3g GRMS',a_vrs);
    out2=sprintf('\n   = %8.3g G 3-sigma',3.*a_vrs);
    out3=sprintf('\n   = %8.3g G %4.3g-sigma (maximum expected)',ms*a_vrs,ms);
else
    out1=sprintf('\n\n   = %8.3g (m/sec^2)RMS',a_vrs);
    out2=sprintf('\n   = %8.3g (m/sec^2) 3-sigma',3.*a_vrs);
    out3=sprintf('\n   = %8.3g (m/sec^2) %4.3g-sigma (maximum expected)',ms*a_vrs,ms);    
end    

if(p==1)
    out4=sprintf('\n\n   = %8.3g inch/sec RMS',omegan*rd_vrs);
    out5=sprintf('\n   = %8.3g inch/sec 3-sigma',omegan*3.*rd_vrs);
    out6=sprintf('\n   = %8.3g inch/sec %4.3g-sigma (maximum expected)',omegan*ms*rd_vrs,ms);     
    
    out7=sprintf('\n\n   = %8.3g inch RMS',rd_vrs);
    out8=sprintf('\n   = %8.3g inch 3-sigma',3.*rd_vrs);
    out9=sprintf('\n   = %8.3g inch %4.3g-sigma (maximum expected)',ms*rd_vrs,ms);   
else
    out4=sprintf('\n\n   = %8.3g mm/sec RMS',omegan*rd_vrs);
    out5=sprintf('\n   = %8.3g mm/sec 3-sigma',omegan*3.*rd_vrs);
    out6=sprintf('\n   = %8.3g mm/sec %4.3g-sigma (maximum expected)',omegan*ms*rd_vrs,ms); 
    
    out7=sprintf('\n\n   = %8.3g mm RMS',rd_vrs);
    out8=sprintf('\n   = %8.3g mm 3-sigma',3.*rd_vrs);
    out9=sprintf('\n   = %8.3g mm %4.3g-sigma (maximum expected)',ms*rd_vrs,ms);     
end

out90=sprintf('\n\n Rate of Up-zero crossings = %7.4g Hz',vo);
out91=sprintf('\n             Rate of peaks = %7.4g Hz',EP);

string_big=strcat(string_acc,out1);
string_big=strcat(string_big,out2);
string_big=strcat(string_big,out3);

string_big=strcat(string_big,string_pv);
string_big=strcat(string_big,out4);
string_big=strcat(string_big,out5);
string_big=strcat(string_big,out6);

string_big=strcat(string_big,string_rd);
string_big=strcat(string_big,out7);
string_big=strcat(string_big,out8);
string_big=strcat(string_big,out9);

string_big=strcat(string_big,out90);
string_big=strcat(string_big,out91);

set(handles.edit_results,'Enable','on');
set(handles.edit_results,'String',string_big);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;


fi=fix_size(fi);
opsd=fix_size(opsd);
a=fix_size(ai);
trans=fix_size(trans);

rd_psd=fix_size(rd_psd);
%
ppp=[fi opsd];
qqq=THM;
%
clear accel_response_psd;
clear power_trans;
%
accel_response_psd=[fi opsd];
power_trans=[fi trans];



rd_response_psd=[fi rd_psd];

%              
x_label=sprintf(' Frequency (Hz)');
%
if(p<=2)
   y_label=sprintf(' Accel (G^2/Hz)');
   leg_a=sprintf('Response %5.3g GRMS',a_vrs);
   leg_b=sprintf('Input %5.3g GRMS',input_rms);   
else
   y_label=sprintf(' Accel ((m/sec^2)^2/Hz)');  
   leg_a=sprintf('Response %5.3g (m/sec^2)RMS',a_vrs);
   leg_b=sprintf('Input %5.3g (m/sec^2)RMS',input_rms);      
end
 
t_string = sprintf(' Power Spectral Density   fn=%g Hz  Q=%g  ',natural_frequency,Q);   
%
[fig_num,h]=plot_PSD_two_sdof_ran_f(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b,fmin,fmax); 
%

if(psave==1)
        
        disp(' ');
        disp(' Plot files:');
        disp(' ');
    
        pname='accel_psd_plot';
        
        out1=sprintf('   %s.png',pname);
        disp(out1);
    
        set(gca,'Fontsize',12);
        print(h,pname,'-dpng','-r300');
    
end      



ppp=[fi trans];  
x_label=sprintf(' Frequency (Hz)');
if(p<=2)
    y_label=sprintf(' Trans (G^2/G^2)'); 
else
    y_label=sprintf(' Trans ((m/sec^2)^2/(m/sec^2)^2)');     
end    
t_string = sprintf(' Power Transmissibility   fn=%g Hz  Q=%g',natural_frequency,Q);   
[fig_num,h]=plot_PSD_function(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
%

accel_power_trans=ppp;

if(psave==1)
        
        pname='power_transmissibility_plot';
        
        out1=sprintf('   %s.png',pname);
        disp(out1);
    
        set(gca,'Fontsize',12);
        print(h,pname,'-dpng','-r300');
    
end   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[s,rd_rms] = calculate_PSD_slopes(rd_response_psd(:,1),rd_response_psd(:,2));

if(p<=1)
    y_label=sprintf('Rel Disp (inch^2/Hz)'); 
    t_string = sprintf(' Relative Displacement PSD   fn=%g Hz  Q=%g \n Overall Level = %7.3g in RMS',natural_frequency,Q,rd_rms);   
else
    y_label=sprintf('Rel Disp (mm^2/Hz)');     
    t_string = sprintf(' Relative Displacement PSD   fn=%g Hz  Q=%g \n Overall Level = %7.3g mm RMS',natural_frequency,Q,rd_rms);       
end 

% [fig_num,h]=plot_PSD_function(fig_num,x_label,y_label,t_string,rd_response_psd,fmin,fmax);


ppp=rd_response_psd;
md=5;
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md)

if(psave==1)
        
    
        pname='rel_disp_plot';
        
        out1=sprintf('   %s.png',pname);
        disp(out1);
    
        set(gca,'Fontsize',12);
        print(h,pname,'-dpng','-r300');
    
end   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'AccelResponsePSD',accel_response_psd);
setappdata(0,'RDResponsePSD',rd_response_psd);
setappdata(0,'AccelPowerTrans',accel_power_trans);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_psd_sdof_base);


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
   set(handles.pushbutton_calculate,'Enable','on');
   clear_results(hObject, eventdata, handles);


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in edit_Q.
function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of edit_Q
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'String','');

function edit_dur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur as text
%        str2double(get(hObject,'String')) returns contents of edit_dur as a double
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_interpolate.
function listbox_interpolate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_interpolate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_interpolate
clear_results(hObject, eventdata, handles);

n=get(handles.listbox_interpolate,'Value');

if(n==1)
    set(handles.listbox_df,'Visible','on');
    set(handles.text_df,'Visible','on');    
else
    set(handles.listbox_df,'Visible','off');
    set(handles.text_df,'Visible','off');       
end



% --- Executes during object creation, after setting all properties.
function listbox_interpolate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_dur and none of its controls.
function edit_dur_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_fmin and none of its controls.
function edit_fmin_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_fmax and none of its controls.
function edit_fmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_fatigue.
function pushbutton_fatigue_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fatigue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=response_PSD_relative_damage;

set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_save_type.
function listbox_save_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save_type


% --- Executes during object creation, after setting all properties.
function listbox_save_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Steinberg.
function pushbutton_Steinberg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Steinberg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Steinberg_PSD_fatigue;
set(handles.s,'Visible','on')


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


% --- Executes on selection change in listbox_df.
function listbox_df_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_df contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_df


% --- Executes during object creation, after setting all properties.
function listbox_df_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_psave.
function listbox10_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
