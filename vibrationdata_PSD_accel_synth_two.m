function varargout = vibrationdata_PSD_accel_synth_two(varargin)
% VIBRATIONDATA_PSD_ACCEL_SYNTH_TWO MATLAB code for vibrationdata_PSD_accel_synth_two.fig
%      VIBRATIONDATA_PSD_ACCEL_SYNTH_TWO, by itself, creates a new VIBRATIONDATA_PSD_ACCEL_SYNTH_TWO or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PSD_ACCEL_SYNTH_TWO returns the handle to a new VIBRATIONDATA_PSD_ACCEL_SYNTH_TWO or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PSD_ACCEL_SYNTH_TWO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PSD_ACCEL_SYNTH_TWO.M with the given input arguments.
%
%      VIBRATIONDATA_PSD_ACCEL_SYNTH_TWO('Property','Value',...) creates a new VIBRATIONDATA_PSD_ACCEL_SYNTH_TWO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_PSD_accel_synth_two_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_PSD_accel_synth_two_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_PSD_accel_synth_two

% Last Modified by GUIDE v2.5 21-Apr-2020 19:52:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_PSD_accel_synth_two_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_PSD_accel_synth_two_OutputFcn, ...
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


% --- Executes just before vibrationdata_PSD_accel_synth_two is made visible.
function vibrationdata_PSD_accel_synth_two_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_PSD_accel_synth_two (see VARARGIN)

% Choose default command line output for vibrationdata_PSD_accel_synth_two
handles.output = hObject;


set(handles.listbox_numrows,'Value',1);
set(handles.listbox_metric,'Value',1);
set(handles.listbox_units,'Value',1);

set(handles.pushbutton_calculate,'Enable','off');
set(handles.listbox_numrows,'Enable','off');
set(handles.uitable_advise,'Visible','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_processing_option,'Visible','off');

set(handles.listbox_numrows,'String',' ');

set(handles.edit_output_array_1,'Enable','off');
set(handles.pushbutton_save,'Enable','off');


YL='Accel';

setappdata(0,'wnd_label',YL); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_PSD_accel_synth_two wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_PSD_accel_synth_two_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_PSD_accel_synth_two);

function clear_table(hObject, eventdata, handles)
%
set(handles.listbox_numrows,'Enable','off');
set(handles.uitable_advise,'Visible','off');
set(handles.listbox_numrows,'Visible','off')
set(handles.text_select_processing_option,'Visible','off');

% --- Executes on button press in pushbutton_view_options.
function pushbutton_view_options_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.listbox_numrows,'Enable','on');
set(handles.uitable_advise,'Visible','on');
set(handles.listbox_numrows,'Visible','on');
set(handles.text_select_processing_option,'Visible','on');

set(handles.listbox_numrows,'String',' ');

try  
  FS1=get(handles.edit_input_array_1,'String');
  THM1=evalin('base',FS1);   
catch
  warndlg('Input Array 1 not found');
  return;
end
 
try  
  FS2=get(handles.edit_input_array_2,'String');
  THM2=evalin('base',FS2);   
catch
  warndlg('Input Array 2 not found');
  return;
end

if(THM1(1,1)~=THM2(1,1))
    warndlg('Input PSDs must have same starting frequency');
    return;
end
if(THM1(end,1)~=THM2(end,1))
    warndlg('Input PSDs must have same starting frequency');
    return;
end


maxf=max(THM1(:,1));

A=get(handles.edit_duration,'String');

iflag=0;

if isempty(A)
    warndlg(' Enter Duration ');
else
    dur=str2num(A);
    iflag=1;
end    


if(iflag==1)

    [data,dt,sr,n,max_num_rows]=advise_syn(maxf,dur);
    
    setappdata(0,'dt',dt);    
    setappdata(0,'sr',sr);
    setappdata(0,'n',n);      

    for i=1:max_num_rows
        handles.number(i)=i;
    end

    set(handles.listbox_numrows,'String',handles.number);

    cn={'No. of Segments ','Samples/Segments','Time/Segment (sec)','df (Hz)','dof'};

    set(handles.uitable_advise,'Data',data,'ColumnWidth','auto','ColumnName',cn);

    setappdata(0,'advise_data',data);
    
    set(handles.pushbutton_calculate,'Enable','on');


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



fig_num=1;

iunit=get(handles.listbox_units,'Value');

set(handles.pushbutton_save,'Enable','On');    
set(handles.edit_output_array_1,'Enable','On'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try  
  FS1=get(handles.edit_input_array_1,'String');
  THM1=evalin('base',FS1);   
catch
  warndlg('Input Array 1 not found');
  return;
end
 
try  
  FS2=get(handles.edit_input_array_2,'String');
  THM2=evalin('base',FS2);   
catch
  warndlg('Input Array 2 not found');
  return;
end

if(THM1(1,1)~=THM2(1,1))
    warndlg('Input PSDs must have same starting frequency');
    return;
end
if(THM1(end,1)~=THM2(end,1))
    warndlg('Input PSDs must have same starting frequency');
    return;
end
if(THM1(1,1)<1.0e-09)
    warndlg('Staring frequency must be > 0');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%

dur=str2num(get(handles.edit_duration,'String'));

dt=getappdata(0,'dt');    
sr=getappdata(0,'sr');
n=getappdata(0,'n'); 
np=n;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

advise_data=getappdata(0,'advise_data');

q=get(handles.listbox_numrows,'Value');

NW=advise_data(q,1);  % Number of Segments

out1=sprintf(' NW= %d ',NW);
disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

freq1=THM1(:,1);
amp1=THM1(:,2);
freq2=THM2(:,1);
amp2=THM2(:,2);

freq_spec1=freq1;
original_spec1=THM1;
freq_spec2=freq2;
original_spec2=THM2;
%


freq1(end+1)=freq1(end)*2^(1/48);
amp1(end+1)=amp1(end);

freq2(end+1)=freq2(end)*2^(1/48);
amp2(end+1)=amp2(end);


[slope1,rms1] = calculate_PSD_slopes(freq1,amp1);
[slope2,rms2] = calculate_PSD_slopes(freq2,amp2);



spec_rms1=rms1;
spec_rms2=rms2;

md=6;
x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';
ppp1=THM1;
ppp2=THM2;
leg1=sprintf('PSD 1  %8.3g GRMS',rms1);
leg2=sprintf('PSD 2  %8.3g GRMS',rms2);

fmin=THM1(1,1);
fmax=THM1(end,1);


t_string='Power Spectral Density';

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
%

dimension=getappdata(0,'wnd_label');  
tmax=dur;

%   
%  Generate White Noise 
%
[np1,white_noise1,~]=PSD_syn_white_noise(tmax,dt,np);
[np2,white_noise2,~]=PSD_syn_white_noise(tmax,dt,np);
%
m_choice=1; % mean removal
h_choice=1; % rectangular window

[~,~,~,complex_FFT1]=full_FFT_core(m_choice,h_choice,white_noise1,np1,dt);
[~,~,~,complex_FFT2]=full_FFT_core(m_choice,h_choice,white_noise2,np1,dt); 

XX=zeros(np1,1); 
YY=zeros(np1,1);

nphase=get(handles.listbox_phase,'Value');


if(nphase>=1)   

    phi=ones(np1,1);

    if(nphase==1)
       for i=1:np1
          phi(i)=360*rand();
       end   
    end
    if(nphase==2)
        phi=phi*0;    
    end    
    if(nphase==3)
        phi=phi*45;    
    end
    if(nphase==4)
        phi=phi*90;    
    end
    if(nphase==5)
        phi=phi*135;    
    end
    if(nphase==6)
        phi=phi*180;    
    end
    if(nphase==7)
        phi=phi*-45;        
    end
    if(nphase==8)
        phi=phi*-90;      
    end
    if(nphase==9)
        phi=phi*-135;      
    end

   phi=(phi)*pi/180;

    
   for i=1:np1
        
        aa1=complex_FFT1(i,2);
        bb1=complex_FFT1(i,3);
        alpha1=atan2(bb1,aa1);
        
        theta=alpha1-phi(i);
        
        XX(i)=( cos(alpha1) + (1i)*sin(alpha1)); 
        YY(i)=( cos(theta) + (1i)*sin(theta)); 
   end
   
  white_noise1=ifft(XX); 
  white_noise2=ifft(YY);
  
  np2=np1;
   
end

clear phi;
clear theta;
clear alpha1;



%
%  Interpolate PSD spec
%
mmm=round(np/2);
%
df1=1/(np1*dt);
df2=1/(np2*dt);


[~,spec1]=interpolate_PSD_spec(np1,freq1,amp1,slope1,df1);
[~,spec2]=interpolate_PSD_spec(np2,freq2,amp2,slope2,df2);
%
fmax=freq1(end);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
nsegments = 1;
%
sq_spec1=sqrt(spec1);
sq_spec2=sqrt(spec2);
%
% [fig_num]=wnb_PSD_plot(fig_num,original_spec,out1,dimension,unit);
%

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


if(nsegments==0)
    disp('nsegment error');
    return;
end

df=df1;

[Y1,psd_th1,nL1]=PSD_syn_FFT_core(nsegments,mmm,np1,fmax,df1,sq_spec1,white_noise1);
[Y2,psd_th2,nL2]=PSD_syn_FFT_core(nsegments,mmm,np2,fmax,df2,sq_spec2,white_noise2);
%

disp('r1');

[TT1,psd_th1,dt1]=PSD_syn_scale_time_history(psd_th1,rms1,np1,tmax);
[TT2,psd_th2,dt2]=PSD_syn_scale_time_history(psd_th2,rms2,np2,tmax);
%


disp('r2');

[amp1,mr_choice,h_choice,mH]=...
                       wnb_PSD_syn_verify(TT1,psd_th1,spec_rms1,dt1,df,mmm,NW);

[amp2,mr_choice,h_choice,mH]=...
                       wnb_PSD_syn_verify(TT2,psd_th2,spec_rms2,dt2,df,mmm,NW);                   
                   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
nnt=4;
%
clear freq_spec1;
clear amp_spec1;
clear freq_spec2;
clear amp_spec2;
%
%
freq_spec1=original_spec1(:,1);
 amp_spec1=original_spec1(:,2);
freq_spec2=original_spec2(:,1);
 amp_spec2=original_spec2(:,2);
%
%
iunit=get(handles.listbox_units,'Value');

assignin('base', 'iunit', iunit);

%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[amp1,velox1,dispx1,freq1,full1,tim1,df1]=...
      wnaccel_psd_syn_correction_two(nnt,amp1,dt1,spec_rms1,NW,freq_spec1,...
                          amp_spec1,mr_choice,h_choice,TT1,iunit,spec_rms1);
scale1=std(amp1)/spec_rms1;
 
amp1=amp1*scale1;
velox1=velox1*scale1;
dispx1=dispx1*scale1;

full1=full1*scale1^2;

freq1=fix_size(freq1);
full1=fix_size(full1);
% [zmax1,fmax1]=find_max([freq1 full1]);
%
%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[amp2,velox2,dispx2,freq2,full2,tim2,df2]=...
      wnaccel_psd_syn_correction_two(nnt,amp2,dt2,spec_rms2,NW,freq_spec2,...
                          amp_spec2,mr_choice,h_choice,TT2,iunit,spec_rms2);
scale2=std(amp2)/spec_rms2;
 
amp2=amp2*scale2;
velox2=velox2*scale2;
dispx2=dispx2*scale2;

full2=full2*scale2^2;

freq2=fix_size(freq2);
full2=fix_size(full2);
% [zmax2,fmax2]=find_max([freq2 full2]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear sum;
ms1=sum(full1);
ms2=sum(full2);
%
% rms=sqrt(ms*df);
%

[mu1,sd1,rms1,sk1,kt1]=kurtosis_stats(amp1);
[mu2,sd2,rms2,sk2,kt2]=kurtosis_stats(amp2);
crest1=max(abs(amp1))/rms1;
crest2=max(abs(amp2))/rms2;


disp(' ');
disp(' Signal 1');
disp(' ');
out4 = sprintf('  Overall RMS = %10.3g ',rms1);
out5 = sprintf('  Three Sigma = %10.3g ',3*rms1);

    mx1=max(amp1);
    mi1=min(amp1);
    
out6 = sprintf('      Maximum = %8.4g ',mx1);
out7 = sprintf('      Minimum = %8.4g ',mi1);


out8 = sprintf('     Kurtosis = %10.3g ',kt1);
out9 = sprintf(' Crest Factor = %10.3g ',crest1);

disp(out4)
disp(out5)
disp(' ');
disp(out6)
disp(out7)
disp(' ');
disp(out8)
disp(out9)

disp(' ');
disp(' Signal 2');
disp(' ');
out4 = sprintf('  Overall RMS = %10.3g ',rms2);
out5 = sprintf('  Three Sigma = %10.3g ',3*rms2);

    mx2=max(amp2);
    mi2=min(amp2);
    
out6 = sprintf('      Maximum = %8.4g ',mx2);
out7 = sprintf('      Minimum = %8.4g ',mi2);


out8 = sprintf('     Kurtosis = %10.3g ',kt2);
out9 = sprintf(' Crest Factor = %10.3g ',crest2);

disp(out4)
disp(out5)
disp(' ');
disp(out6)
disp(out7)
disp(' ');
disp(out8)
disp(out9)


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

[rho]=Pearson_coefficient(amp1,amp2);

disp(' ')
out1=sprintf(' Pearson coefficient = %8.4g ',rho);
disp(out1);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear TT1;
clear psd_TH1;
%
TT1=tim1;
psd_TH1=amp1;
psd_velox1=velox1;
psd_dispx1=dispx1;
%
TT1=fix_size(TT1);
%
clear length;
na1=length(psd_TH1);
%
temp1=TT1(1:na1);
clear TT1;
TT1=temp1;

%
psd_velox1=fix_size(psd_velox1);
psd_dispx1=fix_size(psd_dispx1);

psd_synthesis_accel1=[TT1 psd_TH1];
psd_synthesis_velox1=[TT1 psd_velox1];
psd_synthesis_dispx1=[TT1 psd_dispx1];


setappdata(0,'psd_synthesis_accel1',psd_synthesis_accel1); 
setappdata(0,'psd_synthesis_velox1',psd_synthesis_velox1); 
setappdata(0,'psd_synthesis_dispx1',psd_synthesis_dispx1); 

ng1=length(TT1);

%%%%%%%%

clear TT2;
clear psd_TH2;
%
TT2=tim2;
psd_TH2=amp2;
psd_velox2=velox2;
psd_dispx2=dispx2;
%
TT2=fix_size(TT2);
%
clear length;
na2=length(psd_TH2);
%
temp2=TT2(1:na2);
clear TT2;
TT2=temp2;

%
psd_velox2=fix_size(psd_velox2);
psd_dispx2=fix_size(psd_dispx2);

psd_synthesis_accel2=[TT2 psd_TH2];
psd_synthesis_velox2=[TT2 psd_velox2];
psd_synthesis_dispx2=[TT2 psd_dispx2];

setappdata(0,'psd_synthesis_accel2',psd_synthesis_accel2); 
setappdata(0,'psd_synthesis_velox2',psd_synthesis_velox2); 
setappdata(0,'psd_synthesis_dispx2',psd_synthesis_dispx2); 

ng2=length(TT2);
out1=sprintf('\n signal 1: %d points    signal 2: %d points \n',ng1,ng2);
disp(out1);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             
SS1='Signal 1';
SS2='Signal 2';

fmin=THM1(1,1);
fmax=THM1(end,1);

psave=2;

[fig_num]=synth_two_plots(fig_num,TT1,psd_TH1,psd_velox1,...
                     psd_dispx1,psave,SS1,freq_spec1,amp_spec1,freq1,full1,iunit,rms1,fmin,fmax);
[fig_num]=synth_two_plots(fig_num,TT2,psd_TH2,psd_velox2,...
                     psd_dispx2,psave,SS2,freq_spec2,amp_spec2,freq2,full2,iunit,rms2,fmin,fmax);
                 

freq1=fix_size(freq1);

full1=fix_size(full1);
psd_syn1=[freq1 full1];
setappdata(0,'psd_syn1',psd_syn1);

freq2=fix_size(freq2);

full2=fix_size(full2);
psd_syn2=[freq2 full2];
setappdata(0,'psd_syn2',psd_syn2);


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


[fig_num]=cpsd_two(fig_num,mr_choice,h_choice,psd_TH1,psd_TH2,fmin,fmax,q,advise_data,TT1);
%
 

a=psd_TH1;
b=psd_TH2;
figure(fig_num);
fig_num=fig_num+1;
plot(a,b,'bo','MarkerSize',1);
grid on;
xlabel('Signal 1  Accel (G)');
ylabel('Signal 2  Accel (G)');
out2=sprintf('Scatter Plot, Pearson Coefficient= %6.3g',rho);
title(out2)

[xx]=get(gca,'xlim');
[yy]=get(gca,'ylim');

Qmax=max([ abs(xx) abs(yy)  ]);

[Qmax]=ytick_linear_scale(Qmax);

xlim([-Qmax,Qmax]);
ylim([-Qmax,Qmax]);

axis square;

set(handles.pushbutton_save,'Enable','on');

%%%

function[fig_num]=cpsd_two(fig_num,mr_choice,h_choice,psd_TH1,psd_TH2,fmin,fmax,q,advise_data,TT1)
%
    A=psd_TH1;
    B=psd_TH2;
%
t=TT1;
num=length(t);
dt=(t(num)-t(1))/(num-1);

dur=num*dt;


n=num;

NW=advise_data(q,1);  % Number of Segments

mmm = 2^fix(log(n/NW)/log(2));
%
df=1./(mmm*dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pfmin=fmin;
pfmax=fmax;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  mH=((mmm/2)-1);
%
    full=zeros(mH,1);
    mag_seg=zeros(mH,1);
%
    nov=0;
%
    clear amp_seg_A;
    clear amp_seg_B;
%
    CPSD=zeros(mmm,1); 
    PSD_A=zeros(mmm,1); 
    PSD_B=zeros(mmm,1); 
%
    for ijk=1:(2*NW-1)
%
        amp_seg_A=zeros(mmm,1);
        amp_seg_A(1:mmm)=A((1+ nov):(mmm+ nov));  
%
        amp_seg_B=zeros(mmm,1);
        amp_seg_B(1:mmm)=B((1+ nov):(mmm+ nov));  
%
        nov=nov+fix(mmm/2);
%
        [complex_FFT_A]=CFFT_core(amp_seg_A,mmm,mH,mr_choice,h_choice);
        [complex_FFT_B]=CFFT_core(amp_seg_B,mmm,mH,mr_choice,h_choice);        
%
        CPSD=CPSD+(conj(complex_FFT_A)).*complex_FFT_B/df;   % two-sided
        PSD_A=PSD_A+(conj(complex_FFT_A)).*complex_FFT_A/df;
        PSD_B=PSD_B+(conj(complex_FFT_B)).*complex_FFT_B/df;
%
    end
%
    den=df*(2*NW-1);
    CPSD=CPSD/den;
    PSD_A=PSD_A/den;
    PSD_B=PSD_B/den; 
%
    CPSD_mag=abs(CPSD);
    CPSD_phase=(180/pi)*atan2(imag(CPSD),real(CPSD));
%
    COH=zeros(mH,1);
    for i=1:mH
        COH(i)=CPSD_mag(i)^2/( PSD_A(i)*PSD_B(i) );
    end    
%
    fmax=(mH-1)*df;
    freq=linspace(0,fmax,mH);
 %   
    clear sum;
    ms=sum(CPSD_mag);
%
    rms=sqrt(ms*df);
%
    disp(' ');
    out4 = sprintf(' Overall RMS = %10.3g ',rms);
    out5 = sprintf(' Three Sigma = %10.3g ',3*rms);
    disp(out4)
    disp(out5)
    disp(' ');
%
    CPSD_m(1)=CPSD_mag(1);
    CPSD_m(2:mH)=2*CPSD_mag(2:mH);
%
    rms=sqrt(df*sum(CPSD_m));
%
    CPSD_p=CPSD_phase(1:mH);
%

ff=freq;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[xtt,xTT,iflag]=xtick_label(pfmin,pfmax);

   YS='G';
   t_string=sprintf('Cross Power Spectral Density %6.3g %sRMS Overall ',rms,YS);
%
    figure(fig_num);
    fig_num=fig_num+1;
%
    subplot(3,1,1);
    plot(ff,CPSD_p);
    title(t_string);
    grid on;
    ylabel('Phase (deg)');
    axis([fmin,fmax,-180,180]);

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);    
    end  
    xlim([fmin,fmax]);
    
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','ytick',[-180,-90,0,90,180]);
%
    subplot(3,1,[2 3]);
    plot(ff,CPSD_m);
    grid on;
    xlabel('Frequency(Hz)');
    ylabel('Accel (G^2/Hz)');
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log');
%
    [~,ii]=min(abs(ff-pfmin));
    [~,jj]=min(abs(ff-pfmax));

    ymax=10^(ceil(log10(max(CPSD_m(ii:jj)))));
    ymin=10^(floor(log10(min(CPSD_m(ii:jj)))));
%
    if(ymin<ymax/10000)
        ymin=ymax/10000;
    end
%
    axis([fmin,fmax,ymin,ymax]);    

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);    
    end  
    xlim([fmin,fmax]);    
    
%
    ff=fix_size(ff);
    CPSD_m=fix_size(CPSD_m);
    CPSD_p=fix_size(CPSD_p);
%
    figure(fig_num);
    fig_num=fig_num+1;
    
    plot(freq,COH);
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','lin');
    xlabel('Frequency(Hz)'); 
    ylabel('(\gamma_x_y)^2'); 
    title('Coherence');   
    ymin=0.;
    ymax=1.;
    axis([fmin,fmax,ymin,ymax]);
    
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);    
    end  
    xlim([fmin,fmax]);    
%

    [xmax,fmax]=find_max([ff CPSD_m]);
%
    out5 = sprintf('\n Peak occurs at %10.5g Hz ',fmax);
    disp(out5)
%

cpsd=[ff CPSD_m CPSD_p];
setappdata(0,'Cross_PSD',cpsd);

assignin('base','PSD_A',PSD_A);

%
function edit_output_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_metric,'Value');



if(n==1)
    data1=getappdata(0,'psd_synthesis_accel1'); 
    data2=getappdata(0,'psd_synthesis_accel2');     
end
if(n==2)
    data1=getappdata(0,'psd_synthesis_velox1'); 
    data2=getappdata(0,'psd_synthesis_velox2');     
end
if(n==3)
    data1=getappdata(0,'psd_synthesis_dispx1');    
    data2=getappdata(0,'psd_synthesis_dispx2');    
end
if(n==4)
    data1=getappdata(0,'psd_syn1');    
    data2=getappdata(0,'psd_syn2');        
end

output_array1=get(handles.edit_output_array_1,'String');
assignin('base', output_array1, data1);
output_array2=get(handles.edit_output_array_2,'String');
assignin('base', output_array2, data2);

h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_numrows.
function listbox_numrows_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numrows contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numrows


% --- Executes during object creation, after setting all properties.
function listbox_numrows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

set(handles.pushbutton_calculate,'Enable','off');

clear_table(hObject, eventdata, handles);

set(handles.uitable_advise,'Visible','off');

n=get(hObject,'Value');

set(handles.pushbutton_view_options,'Enable','on');


set(handles.edit_output_array_1,'Enable','off');


set(handles.pushbutton_save,'Enable','off');

set(handles.edit_input_array_1,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array_1,'Visible','on');

if(n==1)
   set(handles.edit_input_array_1,'enable','on') 
else
   set(handles.edit_input_array_1,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array_1,'Visible','off');   
   
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






function edit_input_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
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


% --- Executes during object creation, after setting all properties.
function edit_dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_metric.
function listbox_metric_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_metric contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_metric


% --- Executes during object creation, after setting all properties.
function listbox_metric_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

n=get(handles.listbox_units,'Value');

setappdata(0,'iu',n);



% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array_1 and none of its controls.
function edit_input_array_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_table(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_table(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_SDOF_Response.
function pushbutton_SDOF_Response_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SDOF_Response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_sdof_base;    

set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_add_sine.
function pushbutton_add_sine_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=vibrationdata_add_sine_tones;    

set(handles.s,'Visible','on'); 


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



function edit_output_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_phase.
function listbox_phase_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_phase contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_phase


% --- Executes during object creation, after setting all properties.
function listbox_phase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%


function[fig_num]=synth_two_plots(fig_num,TT,psd_TH,psd_velox,...
                     psd_dispx,psave,SS,freq_spec,amp_spec,freq,full,iunit,rms,fmin,fmax)

h1=figure(fig_num);
fig_num=fig_num+1;
plot(TT,psd_TH);
xlabel('Time (sec)');
out1=sprintf('Acceleration Time History Synthesis %s %7.3g GRMS',SS,std(psd_TH));
title(out1);
out_dim_unit=sprintf('Accel (G)');
ylabel(out_dim_unit);
grid on;

if(psave==1)
    
    disp(' ');
    disp(' Plot files:');
    disp(' ');
    
    pname=sprintf('accel_th_plot_%s',ss);
        
    out1=sprintf('   %s.png',pname);
    disp(out1);
    
    set(gca,'Fontsize',12);
    print(h1,pname,'-dpng','-r300');
    
end  


h2=figure(fig_num);
fig_num=fig_num+1;
plot(TT,psd_velox);

if(iunit==1)
    unit='in/sec';
else
    unit='cm/sec';    
end

xlabel('Time (sec)');
out1=sprintf('Velocity Time History Synthesis %s  %7.3g %s rms',SS,std(psd_velox),unit);
title(out1);
out_dim_unit=sprintf('Velocity (%s)',unit);
ylabel(out_dim_unit);
grid on;

if(psave==1)
    
    pname=sprintf('velox_th_plot_%s',SS);
        
    out1=sprintf('   %s.png',pname);
    disp(out1);
    
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');
    
end  

h3=figure(fig_num);
fig_num=fig_num+1;
plot(TT,psd_dispx);

if(iunit==1)
    unit='in';
else
    unit='mm';    
end

xlabel('Time (sec)');
out1=sprintf('Displacement Time History Synthesis %s %7.3g %s rms',SS,std(psd_dispx),unit);
title(out1);
out_dim_unit=sprintf('Disp (%s)',unit);
ylabel(out_dim_unit);
grid on;

if(psave==1)
    
    pname=sprintf('disp_th_plot_%s',SS);
        
    out1=sprintf('   %s.png',pname);
    disp(out1);
    
    set(gca,'Fontsize',12);
    print(h3,pname,'-dpng','-r300');
    
end  



nbar=31;

xx=max(abs(psd_TH));
x=linspace(-xx,xx,nbar);       
h4=figure(fig_num);
fig_num=fig_num+1;
hist(psd_TH,x)
ylabel(' Counts');
xlabel('Accel(G)');  
out1=sprintf('Acceleration Histogram %s',SS);
title(out1);


if(psave==1)
    
    pname=sprintf('histogram_plot_%s',SS);
        
    out1=sprintf('   %s.png',pname);
    disp(out1);
    
    set(gca,'Fontsize',12);
    print(h4,pname,'-dpng','-r300');
    
end  


size(freq);
size(full);

min(freq);
max(freq);
min(full);
max(full);

freq=fix_size(freq);
full=fix_size(full);

h5=figure(fig_num);
fig_num=fig_num+1;
plot(freq,full,'b',freq_spec,amp_spec,'r',...
           freq_spec,sqrt(2)*amp_spec,'k',freq_spec,amp_spec/sqrt(2),'k');
legend ('Synthesis','Specification','+/- 1.5 dB tol ');
%   
fmin=freq_spec(1);
fmax=max(freq_spec);
ymax=max(full);
%  
xlabel(' Frequency (Hz)');
out1=sprintf(' Accel (G^2/Hz)  ');
ylabel(out1); 

at = sprintf(' Power Spectral Density %s  Overall Level = %6.3g GRMS ',SS,rms);   
title(at);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
grid;
%
tb=sqrt(sqrt(2));
ymax=10^(ceil(+0.1+log10(ymax)));
ymin = min(amp_spec/tb);
ymin=10^(floor(-0.1+log10(ymin)));
%

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end


%
xlim([fmin,fmax]);
ylim([ymin,ymax]);

if(psave==1)
    
    pname=sprintf('psd_plot_%s',SS);
        
    out1=sprintf('   %s.png',pname);
    disp(out1);
    
    set(gca,'Fontsize',12);
    print(h5,pname,'-dpng','-r300');
    
end  
