function varargout = vibrationdata_sdof_base(varargin)
% VIBRATIONDATA_SDOF_BASE MATLAB code for vibrationdata_sdof_base.fig
%      VIBRATIONDATA_SDOF_BASE, by itself, creates a new VIBRATIONDATA_SDOF_BASE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SDOF_BASE returns the handle to a new VIBRATIONDATA_SDOF_BASE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SDOF_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SDOF_BASE.M with the given input arguments.
%
%      VIBRATIONDATA_SDOF_BASE('Property','Value',...) creates a new VIBRATIONDATA_SDOF_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_sdof_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_sdof_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_sdof_base

% Last Modified by GUIDE v2.5 10-Nov-2014 17:04:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_sdof_base_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_sdof_base_OutputFcn, ...
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


% --- Executes just before vibrationdata_sdof_base is made visible.
function vibrationdata_sdof_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_sdof_base (see VARARGIN)

% Choose default command line output for vibrationdata_sdof_base
handles.output = hObject;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=1:8
    for j=1:2
       A{i,j}='';
    end
end

for j=1:8
    A{j,2}='No';    
end

A{3,2}='Yes';
A{4,2}='Yes';

A{1,1}='Base Input';
A{2,1}='Accel Response';
A{3,1}='Time Histories';
A{4,1}='Time Histories & Histograms';
A{5,1}='Relative Displacement';
A{6,1}='Response Accel Instant Histogram';
A{7,1}='Response Accel Peak Value Histogram';
A{8,1}='Response Accel Envelopes';

set(handles.uitable_plots,'Data',A);

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

set(handles.edit_Q,'String','10');

set(handles.listbox_method,'Value',1);

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');

set(handles.edit_results,'Enable','off');

set(handles.pushbutton_rainflow_fatigue,'Enable','off');
set(handles.pushbutton_Steinberg,'Enable','off');


set(handles.pushbutton_statistics,'Enable','off');
set(handles.pushbutton_psd,'Enable','off');

listbox_method_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_sdof_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_sdof_base_OutputFcn(hObject, eventdata, handles) 
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

n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'accel_data'); 
end
if(n==2)
    data=getappdata(0,'rel_disp_data'); 
end
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 

set(handles.pushbutton_rainflow_fatigue,'Enable','on');
set(handles.pushbutton_Steinberg,'Enable','on');

set(handles.pushbutton_statistics,'Enable','on');
set(handles.pushbutton_psd,'Enable','on');

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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
n=get(handles.listbox_method,'Value');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_input_array,'String',' ');

set(handles.edit_input_array,'Visible','on');
set(handles.text_input_array_name,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'Visible','off');
   set(handles.text_input_array_name,'Visible','off');    
    
   set(handles.edit_input_array,'enable','off')
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
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


disp(' ');
disp(' * * * * * ');
disp(' ');

set(handles.edit_results,'Enable','on');

k=get(handles.listbox_method,'Value');

iu=get(handles.listbox_unit,'Value');
 
if(k==1)
    try
        FS=get(handles.edit_input_array,'String');
        THM=evalin('base',FS); 
    catch
        warndlg('Input array not found');
        return;
    end
else
  THM=getappdata(0,'THM');
end

sz=size(THM);

if(sz(2)~=2)
   warndlg('Input array must have two columns'); 
   return; 
end

[THM,iflag]=time_check_with_linear_interpolation(THM);

if(iflag==999)
    return;
end

y=double(THM(:,2));
yy=y;

n=length(y);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);

Q=str2num(get(handles.edit_Q,'String'));
fn=str2num(get(handles.edit_fn,'String'));

if(isempty(fn)==1)
    warndlg('Enter natural frequency');
    return;
end

damp=1/(2*Q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Initialize coefficients
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
%
%
%  SRS engine
%

a_pos=zeros(1,1);
a_neg=zeros(1,1);
rd_pos=zeros(1,1);
rd_neg=zeros(1,1);

for j=1:1
%
    disp(' ')
    disp(' Calculating absolute acceleration');
%
    [a_resp,a_pos(j),a_neg(j)]=arbit_engine(a1(j),a2(j),b1(j),b2(j),b3(j),yy);
    
    zdd=a_resp-y;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    disp(' ')
    disp(' Calculating relative displacement');
%
    [rd_resp,rd_pos(j),rd_neg(j)]=arbit_engine(rd_a1(j),rd_a2(j),rd_b1(j),rd_b2(j),rd_b3(j),yy);
    
    z=rd_resp;
    
    omegan=2*pi*fn;
    tdo=2*damp*omegan; 
%
    om2=omegan^2;

    zd=(-yy-zdd-om2*z)/tdo;
    
    EK=0;
    ED=0;
    EA=0;
    
    for i=1:length(z)
        EK=EK+zdd(i)*zd(i);
        ED=ED+tdo*zd(i)^2;
        EA=EA+om2*z(i)*zd(i);
    end
%
    EK=EK*dt;
    ED=ED*dt;
    EA=EA*dt;   
%
%
    if(iu==1)
        scale=386;
    end
    if(iu==2)
        scale=9.81*1000;        
    end
    if(iu==3)
        scale=1000;        
    end    
%
    rd_resp=rd_resp*scale;
    rd_pos(j)=rd_pos(j)*scale;
    rd_neg(j)=rd_neg(j)*scale;

    if(iu==1)
        escale=386^2;
        slabel='(in/sec)^2';
    end 
    if(iu==2)
        escale=9.81^2;  
        slabel='(m/sec)^2';    
    end 
    if(iu==3)
        escale=1;  
        slabel='(m/sec)^2';        
    end
    
    EK=EK*escale;
    ED=ED*escale;
    EA=EA*escale;
%
    EI=EK+ED+EA; 
 
    EK=abs(EK);
    ED=abs(ED);
    EA=abs(EA);
    EI=abs(EI);

    ss1='Kinetic Energy = ';
    ss2='Dissipated Energy = ';
    ss3='Absorbed Energy = ';
    ss4='Total Energy = ';

end
%
om=2*pi*fn;
om2=om^2;
%
zd=(-yy-zdd-om2*z)/(2*damp*om);
%
[~,a_sd,a_rms,sk,kt]=kurtosis_stats(a_resp);
[~,~,rd_rms,~,~]=kurtosis_stats(rd_resp);

%
if(iu==1 || iu==2)
    big_string=sprintf(' Acceleration Response (G) \n');
else
    big_string=sprintf(' Acceleration Response (m/sec^2) \n');
end

crest=(max([a_pos(1) abs(a_neg(1))]))/a_sd;


[pszcr,peak_rate,tpa,pa]=zero_crossing_function_alt(THM(:,1),a_resp,dur);
[rf]=Rice_frequency(a_resp,dt);



string1=sprintf('\n\n max=%8.4g',a_pos(1));
string2=sprintf('\n min=%8.4g',-a_neg(1));
string3=sprintf('\n\n RMS=%8.4g',a_rms);
string4=sprintf('\n std dev=%8.4g',std(a_resp));
string5=sprintf('\n mean=%8.4g',mean(a_resp));
string6=sprintf('\n\n crest factor=%7.3g',crest);
string7=sprintf('\n skewness=%7.3g',sk);
string8=sprintf('\n kurtosis=%7.3g',kt);

string_rf=sprintf('\n\n Rice Characteristic Frequency = %8.4g Hz ',rf);
string_zc=sprintf('\n Positive Slope Zero Cross Rate = %8.4g Hz ',pszcr);  
string_pr=sprintf('\n Peak Rate = %8.4g Hz ',peak_rate);    


big_string=strcat(big_string,string1);
big_string=strcat(big_string,string2);
big_string=strcat(big_string,string3); 
big_string=strcat(big_string,string4); 
big_string=strcat(big_string,string5); 
big_string=strcat(big_string,string6); 
big_string=strcat(big_string,string7);
big_string=strcat(big_string,string8);
%


if(iu==1)
    string8=sprintf('\n\n Relative Displacement (in) \n');    
else
    string8=sprintf('\n\n Relative Displacement (mm) \n');    
end
    
string9=sprintf('\n\n max=%7.3g',rd_pos(1));
string10=sprintf('\n min=%7.3g',rd_neg(1));
string11=sprintf('\n RMS=%7.3g',rd_rms);

    
big_string=strcat(big_string,string8);
big_string=strcat(big_string,string9);
big_string=strcat(big_string,string10);
big_string=strcat(big_string,string11); 


big_string=strcat(big_string,string_rf);    
big_string=strcat(big_string,string_zc); 
big_string=strcat(big_string,string_pr); 

ss1='Kinetic Energy/Mass = ';
ss2='Dissipated Energy/Mass = ';
ss3='Absorbed Energy/Mass = ';
ss4='Total Energy/Mass = ';
 
sss=sprintf('\n\n %s %8.4g %s \n %s %8.4g %s \n %s %8.4g %s \n %s %8.4g %s',ss1,EK,slabel,ss2,ED,slabel,ss3,EA,slabel,ss4,EI,slabel);

big_string=strcat(big_string,sss);  


out12=sprintf('\n Q=%g ',Q);
disp(out12);

set(handles.edit_results,'String',big_string);
disp(' ');
disp(big_string);



spa=pa/a_sd;
npa=length(pa);

  L3=length(spa(spa > 3.0));
L3p5=length(spa(spa > 3.5));
  L4=length(spa(spa > 4.0));
L4p5=length(spa(spa > 4.5));
  L5=length(spa(spa > 5.0));
L5p5=length(spa(spa > 5.5));
  L6=length(spa(spa > 6.0));

disp(' ');
disp(' Number of Peaks >= n-sigma');
disp(' ');

out1=sprintf(' 3.0-sigma    %d  or %7.3g percent',L3,100*L3/npa);
out2=sprintf(' 3.5-sigma    %d  or %7.3g percent',L3p5,100*L3p5/npa);
out3=sprintf(' 4.0-sigma    %d  or %7.3g percent',L4,100*L4/npa);
out4=sprintf(' 4.5-sigma    %d  or %7.3g percent',L4p5,100*L4p5/npa);
out5=sprintf(' 5.0-sigma    %d  or %7.3g percent',L5,100*L5/npa);
out6=sprintf(' 5.5-sigma    %d  or %7.3g percent',L5p5,100*L5p5/npa);
out7=sprintf(' 6.0-sigma    %d  or %7.3g percent',L6,100*L6/npa);

disp(out1);
disp(out2);
disp(out3);
disp(out4);  
disp(out5);
disp(out6);
disp(out7);
  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

disp(' ');
disp(' Acceleration Input & Response Statistics ');
disp(' ');

[rho]=Pearson_coefficient(yy,a_resp);

out1=sprintf(' Pearson product-moment correlation coefficient = %8.4g ',rho);
disp(out1);    


disp(' ');
disp(' Covariance Matrix: ');
disp(' ');
    
cvm = cov(yy,a_resp)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A=char(get(handles.uitable_plots,'Data'));

k=1;

    for i=1:8
        pq{i}=A(k,:); k=k+1;
        pq{i} = strtrim(pq{i});
    end

    for i=1:8
        pyn{i}=A(k,:); k=k+1;
        pyn{i} = strtrim(pyn{i});
    end
    

accel_data=[THM(:,1) a_resp];

rel_disp_data=[THM(:,1) rd_resp];
%
fig_num=1;
%
data1=THM;
data2=[THM(:,1),a_resp];
xlabel2=' Time(sec) ';
nbars=31;

figure(fig_num)
fig_num=fig_num+1;
plot(THM(:,1),THM(:,2),THM(:,1),a_resp);
xlabel(' Time(sec) ');
legend('Base Input','Response');
if(iu==1 || iu==2)
    ylabel('Accel (G)')
else
    ylabel('Accel (m/sec^2)')    
end
grid on;
title('Acceleration Time History');

if(contains(pyn{1},'Yes'))
    figure(fig_num);
    fig_num=fig_num+1;
    plot(THM(:,1),THM(:,2));
    
    title('Base Input Acceleration Time History');
    xlabel(' Time(sec) ')
    if(iu==1 || iu==2)
        ylabel('Accel (G)')
    else
        ylabel('Accel (m/sec^2)')    
    end
    grid on;
end

if(contains(pyn{2},'Yes'))
    figure(fig_num);
    fig_num=fig_num+1;
    plot(THM(:,1),a_resp);
    out1=sprintf('Acceleration Response fn=%g Hz  Q=%g',fn,Q);
    title(out1);
    xlabel(' Time(sec) ')
    if(iu==1 || iu==2)
        ylabel('Accel (G)')
    else
        ylabel('Accel (m/sec^2)')    
    end
    grid on;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(contains(pyn{3},'Yes'))

    if(iu==1 || iu==2)
        ylabel1='Accel (G)';
        ylabel2='Accel (G)'; 
    else
        ylabel1='Accel (m/sec^2)';
        ylabel2='Accel (m/sec^2)';     
    end

    t_string1=('Base Input');
    t_string2=sprintf('Acceleration Response fn=%g Hz  Q=%g',fn,Q);

    [fig_num]=...
    subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,...
                                          data1,data2,t_string1,t_string2);

end

if(contains(pyn{4},'Yes'))                                      
    nbars=31;                                      
                                      
    [fig_num]=plot_two_time_histories_histograms(fig_num,xlabel2,...
                    ylabel1,ylabel2,data1,data2,t_string1,t_string2,nbars);             
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(contains(pyn{5},'Yes')) 
    figure(fig_num);
    fig_num=fig_num+1;
    plot(THM(:,1),rd_resp);
    out1=sprintf('Relative Displacement fn=%g Hz  Q=%g',fn,Q);
    title(out1);
    xlabel(' Time(sec) ')
    if(iu==1)
        ylabel('Rel Disp (in)')
    else
        ylabel('Rel Disp (mm)')    
    end
    grid on;

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(contains(pyn{6},'Yes')) 

    xx=max(abs(a_resp));
    x=linspace(-xx,xx,nbars);       
    figure(fig_num);
    fig_num=fig_num+1;
    histogram(a_resp,x)
    ylabel(' Counts');
    if(iu==1 || iu==2)
        xlabel('Accel (G)')
    else
        xlabel('Accel (m/sec^2)')    
    end  
    title('Response Acceleration Histogram');

end

if(contains(pyn{7},'Yes')) 
    
    figure(fig_num);
    fig_num=fig_num+1;
    xx=max(abs(pa));
    nbar=floor(nbars*(2/3));
    x=linspace(0,xx,nbar);       
    histogram(pa,x)
    ylabel(' Counts');
    if(iu==1 || iu==2)
        xlabel('Accel (G)')
    else
        xlabel('Accel (m/sec^2)')    
    end  
    title('Absolute Acceleration Peak Value Distribution');

end

if(contains(pyn{8},'Yes')) 

    [envp,envn]=time_history_envelope(THM(:,1),a_resp,dt,pszcr);

    figure(fig_num);
    fig_num=fig_num+1;
    plot(THM(:,1),a_resp,THM(:,1),envp,THM(:,1),envn);
    legend('Time History','Max Envelope','Min Envelope');
    out1=sprintf('Acceleration Response fn=%g Hz  Q=%g',fn,Q);
    title(out1);
    xlabel(' Time(sec) ')
    if(iu==1 || iu==2)
        ylabel('Accel (G)')
    else
        ylabel('Accel (m/sec^2)')    
    end
    grid on;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'accel_data',accel_data);    
setappdata(0,'rel_disp_data',rel_disp_data);   

set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array,'Enable','on');





% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_sdof_base)


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
set(handles.edit_results,'String',' ');
set(handles.edit_results,'Enable','Off');

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



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double
set(handles.edit_results,'Enable','off');
set(handles.edit_results,'String',' ');

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
set(handles.edit_results,'Enable','off');
set(handles.edit_results,'String',' ');

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


% --- Executes on button press in pushbutton_rainflow_fatigue.
function pushbutton_rainflow_fatigue_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rainflow_fatigue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_rainflow;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_statistics.
function pushbutton_statistics_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_statistics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_statistics;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_psd.
function pushbutton_psd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_psd;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_Steinberg.
function pushbutton_Steinberg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Steinberg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Steinberg_TH_fatigue;    
set(handles.s,'Visible','on'); 
