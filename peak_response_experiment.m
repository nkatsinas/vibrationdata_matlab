function varargout = peak_response_experiment(varargin)
% PEAK_RESPONSE_EXPERIMENT MATLAB code for peak_response_experiment.fig
%      PEAK_RESPONSE_EXPERIMENT, by itself, creates a new PEAK_RESPONSE_EXPERIMENT or raises the existing
%      singleton*.
%
%      H = PEAK_RESPONSE_EXPERIMENT returns the handle to a new PEAK_RESPONSE_EXPERIMENT or the handle to
%      the existing singleton*.
%
%      PEAK_RESPONSE_EXPERIMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEAK_RESPONSE_EXPERIMENT.M with the given input arguments.
%
%      PEAK_RESPONSE_EXPERIMENT('Property','Value',...) creates a new PEAK_RESPONSE_EXPERIMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before peak_response_experiment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to peak_response_experiment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help peak_response_experiment

% Last Modified by GUIDE v2.5 29-Jul-2022 17:11:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @peak_response_experiment_OpeningFcn, ...
                   'gui_OutputFcn',  @peak_response_experiment_OutputFcn, ...
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


% --- Executes just before peak_response_experiment is made visible.
function peak_response_experiment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to peak_response_experiment (see VARARGIN)

% Choose default command line output for peak_response_experiment
handles.output = hObject;

listbox_1_Callback(hObject, eventdata, handles);

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
 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes peak_response_experiment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = peak_response_experiment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


tic

disp(' ');
disp(' * * * * * * * ');
disp(' ');

fig_num=1;

num=str2num(get(handles.edit_num,'String'));
tmax=str2num(get(handles.edit_duration,'String'));
sr=str2num(get(handles.edit_sr,'String'));
sigma=str2num(get(handles.edit_sd,'String'));

m=get(handles.listbox_1,'Value');
     
dt=1/sr;   
np=ceil(tmax/dt);
TT=linspace(0,(np-1)*dt,np); 
  
%%%    [a] = normrnd_function(sigma,np);
 
clear length;
np=length(TT);
 
fn=str2num(get(handles.edit_fn,'String'));
 Q=str2num(get(handles.edit_Q,'String'));

damp=1/(2*Q);

%
%  Initialize coefficients
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    order=6;

    if(m==1)
%
%    iband:   1=lowpass  2=highpass  3=bandpass 
%
      fl=str2num(get(handles.edit8,'String'));
      if(fl>sr/2.)
          fl=0.49*sr;
          msgbox('Note: lowpass filter frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fl);
          set(handles.edit8,'String',out1);         
      end
      Wn=fl/(sr/2);
      [bb,aa] = butter(order,Wn,'low');
        flag = isstable(bb,aa);
        if(flag==1)
            fprintf('\n filter is stable \n');
        else
            fprintf('\n filter is unstable \n');            
        end            
%
    end
%      
    if(m==2)
        
      fh=str2num(get(handles.edit8,'String'));
      if(fh>sr/2.)
          fh=0.49*sr;
          msgbox('Note: lower frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fh);
          set(handles.edit8,'String',out1);         
      end
 
      fl=str2num(get(handles.edit9,'String'));
      if(fl>sr/2.)
          fl=0.49*sr;
          msgbox('Note: upper frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fl);
          set(handles.edit9,'String',out1);         
      end     
            
        ff=[fl fh];
        fh=min(ff);
        fl=max(ff);

        Wn=fh/(sr/2);
        [bb1,aa1] = butter(order,Wn,'high');
        flag = isstable(bb1,aa1);
        if(flag==1)
            fprintf('\n filter is stable \n');
        else
            fprintf('\n filter is unstable \n');            
        end        
        Wn=fl/(sr/2);
        [bb2,aa2] = butter(order,Wn,'low');
        flag = isstable(bb2,aa2);
        if(flag==1)
            fprintf('\n filter is stable \n');
        else
            fprintf('\n filter is unstable \n');            
        end        
      
    end
    

ax=0.5;
[ps]=risk_overshoot(fn,tmax,ax);

crest=zeros(num,1);
ssd=zeros(num,1);
maxa=zeros(num,1);

disp(' i   Trial   Mean    Median   Expected 50%');

progressbar;

for i=1:num    

    progressbar(i/num);
    
    a=randn(np,1);
%
    a=fix_size(a);
%
    a=a-mean(a);
    a=a*sigma/std(a);
%
    if(m<=2)
 
      if(m==1)  
        a=filter(bb,aa,a);
      else
        a=filter(bb1,aa1,a);
        a=filter(bb2,aa2,a);        
      end
%    scale for the std deviation
%
      ave=mean(a);
      stddev=std(a);
      sss=sigma/stddev;
%    
      a=(a-ave)*sss;        
        
    end   
    
    [a_resp,a_pos,a_neg]=arbit_engine(a1,a2,b1,b2,b3,a);
    
     maxa(i)=max([ a_pos  a_neg  ]);
    crest(i)=maxa(i)/std(a_resp);
    ssd(i)=std(a_resp);
    
    fprintf(' %d  %8.4g   %8.4g  %8.4g  %8.4g  \n',i,crest(i),mean(crest(1:i)),median(crest(1:i)),ps);
    
end
pause(0.2);
progressbar(1);

disp(' ');
disp(' Crest Factor Results ');
disp(' ');
fprintf(' Range: %8.4g to %8.4g \n',min(crest),max(crest));
fprintf(' mean = %8.4g    \n',mean(crest));
fprintf(' median = %8.4g  \n',median(crest));
fprintf(' std dev = %8.4g  \n',std(crest));

fprintf('\n Expected Peak = %8.4g sigma (Overshoot 50 percent) \n',ps);

if(num>=2)
    ax=1/num;
    [ps]=risk_overshoot(fn,tmax,ax);
    fprintf('\n Upper threshold for one crest factor point = %8.4g  (%5.3g percent) \n',ps,ax*100);
end

disp(' ');
disp(' Peak Acceleration Results (G)');
disp(' ');
fprintf(' Range: %8.4g to %8.4g \n',min(maxa),max(maxa));
fprintf(' mean = %8.4g    \n',mean(maxa));
fprintf(' median = %8.4g  \n',median(maxa));
fprintf(' std dev = %8.4g  \n',std(maxa));


nbars=num/100;
if(nbars<=3000)
    nbars=31;
end
if(nbars<=100)
    nbars=20;
end
if(nbars<=10)
    nbars=3;
end
if(nbars<=1)
    nbars=1;
end
if(nbars>400)
    nbars=400;
end

figure(fig_num);
fig_num=fig_num+1;
histogram(ssd,nbars)
ylabel('Counts');
title('Histogram');
xlabel('Standard Deviation');
% qq=get(gca,'xlim');

figure(fig_num);
fig_num=fig_num+1;
histogram(crest,nbars)
ylabel('Counts');
title('Histogram');
xlabel('Crest Factor');
% qq=get(gca,'xlim');

setappdata(0,'crest_factor_array',crest);
setappdata(0,'peak_accel_array',maxa); 
disp(' ');
toc

% --- Executes on button press in pushbutton_retur
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(peak_response_experiment);


function edit_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num as text
%        str2double(get(hObject,'String')) returns contents of edit_num as a double


% --- Executes during object creation, after setting all properties.
function edit_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sd as text
%        str2double(get(hObject,'String')) returns contents of edit_sd as a double


% --- Executes during object creation, after setting all properties.
function edit_sd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_1.
function listbox_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_1

n=get(handles.listbox_1,'Value');


set(handles.text_s8,'Visible','off');
set(handles.edit8,'Visible','off'); 
set(handles.text_s9,'Visible','off');
set(handles.edit9,'Visible','off'); 


if(n<=2)
    set(handles.text_s8,'Visible','on');
    set(handles.edit8,'Visible','on');  
end


if(n==1)
   sss='Low Pass Frequency (Hz)'; 
   set(handles.text_s8,'String',sss);
end
if(n==2)
   sss1='Lower Frequency (Hz)'; 
   sss2='Upper Frequency (Hz)'; 
   set(handles.text_s8,'String',sss1); 
   set(handles.text_s9,'String',sss2);
   set(handles.text_s9,'Visible','on');
   set(handles.edit9,'Visible','on');       
end



% --- Executes during object creation, after setting all properties.
function listbox_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
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

n=get(handles.listbox_save,'Value');

output_name=get(handles.edit_output_name,'String');

if(n==1)
    data=getappdata(0,'crest_factor_array');
else
    data=getappdata(0,'peak_accel_array');    
end

assignin('base', output_name,data);

msgbox('Save Complete'); 


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    num=get(handles.edit_num,'String');
    PeakExperiment.num=num;      
catch
end

try
    duration=get(handles.edit_duration,'String');
    PeakExperiment.duration=duration;      
catch
end

try
    sr=get(handles.edit_sr,'String');
    PeakExperiment.sr=sr;      
catch
end

try
    sd=get(handles.edit_sd,'String');
    PeakExperiment.sd=sd;      
catch
end

try
    L1=get(handles.listbox_1,'Value');
    PeakExperiment.L1=L1;      
catch
end

try
    e8=get(handles.edit_e8,'String');
    PeakExperiment.e8=e8;      
catch
end

try
    e9=get(handles.edit_e9,'String');
    PeakExperiment.e9=e9;      
catch
end

try
    fn=get(handles.edit_fn,'String');
    PeakExperiment.fn=fn;      
catch
end

try
    Q=get(handles.edit_Q,'String');
    PeakExperiment.Q=Q;      
catch
end



% % %
 
structnames = fieldnames(PeakExperiment, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'PeakExperiment'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');




% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat', 'Select plot save file');

NAME = [pathname,filename];

struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try

   PeakExperiment=evalin('base','PeakExperiment');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%



try
    num=PeakExperiment.num;     
    set(handles.edit_num,'String',num);
catch
end

try
    duration=PeakExperiment.duration;     
    set(handles.edit_duration,'String',duration);     
catch
end

try
    sr=PeakExperiment.sr;    
    set(handles.edit_sr,'String',sr);      
catch
end

try
    sd=PeakExperiment.sd;     
    set(handles.edit_sd,'String',sd);     
catch
end

try
    L1=PeakExperiment.L1;      
    set(handles.listbox_1,'Value',L1);    
catch
end

try
    e8=PeakExperiment.e8;          
    set(handles.edit_e8,'String',e8);
catch
end

try
    e9=PeakExperiment.e9;      
    set(handles.edit_e9,'String',e9);    
catch
end

try
    fn=PeakExperiment.fn;          
    set(handles.edit_fn,'String',fn);
catch
end

try
    Q=PeakExperiment.Q;        
    set(handles.edit_Q,'String',Q);  
catch
end


listbox_1_Callback(hObject, eventdata, handles);




function edit_output_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_theory.
function pushbutton_theory_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_theory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=peak_sigma_random;
set(handles.s,'Visible','on');
