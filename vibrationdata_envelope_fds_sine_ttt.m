function varargout = vibrationdata_envelope_fds_sine(varargin)
% VIBRATIONDATA_ENVELOPE_FDS_SINE MATLAB code for vibrationdata_envelope_fds_sine.fig
%      VIBRATIONDATA_ENVELOPE_FDS_SINE, by itself, creates a new VIBRATIONDATA_ENVELOPE_FDS_SINE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ENVELOPE_FDS_SINE returns the handle to a new VIBRATIONDATA_ENVELOPE_FDS_SINE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ENVELOPE_FDS_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ENVELOPE_FDS_SINE.M with the given input arguments.
%
%      VIBRATIONDATA_ENVELOPE_FDS_SINE('Property','Value',...) creates a new VIBRATIONDATA_ENVELOPE_FDS_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_envelope_fds_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_envelope_fds_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_envelope_fds_sine

% Last Modified by GUIDE v2.5 15-Apr-2021 19:11:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_envelope_fds_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_envelope_fds_sine_OutputFcn, ...
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


% --- Executes just before vibrationdata_envelope_fds_sine is made visible.
function vibrationdata_envelope_fds_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_envelope_fds_sine (see VARARGIN)

% Choose default command line output for vibrationdata_envelope_fds_sine
handles.output = hObject;

set(handles.listbox_octave,'Value',7);

listbox_num_sine_Callback(hObject, eventdata, handles);

listbox_input_type_Callback(hObject, eventdata, handles);

%%%%%%%%%


set(handles.listbox_num,'Value',4);
Nrows=get(handles.listbox_num,'Value');
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end

data_s{1,2}='10';
data_s{2,2}='10';
data_s{3,2}='30';
data_s{4,2}='30';
 
data_s{1,3}='4';
data_s{2,3}='8';
data_s{3,3}='4';
data_s{4,3}='8';

 
set(handles.uitable_data,'Data',data_s);



% set(handles.listbox_num_eng,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_envelope_fds_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_envelope_fds_sine_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_envelope_fds_sine);


function get_table(hObject, eventdata, handles)
%

   jflag=0;
   setappdata(0,'jflag',jflag);

   AA=get(handles.uitable_data,'Data');
   
   A=char(AA);

    N=get(handles.listbox_num,'Value');

    Q=zeros(N,1);
    bex=zeros(N,1);

    k=1;

    for i=1:N
        FDS_name{i}=A(k,:); k=k+1;
        FDS_name{i} = strtrim(FDS_name{i});
    end

    for i=1:N
        Q(i)=str2double(strtrim(A(k,:))); k=k+1;
    end

    for i=1:N
        bex(i)=str2double(strtrim(A(k,:))); k=k+1;
    end
    
    for i=1:N
        data_s{i,1}=FDS_name{i};
        data_s{i,2}=sprintf('%g',Q(i));
        data_s{i,3}=sprintf('%g',bex(i));      
    end
    
    set(handles.uitable_data,'Data',data_s);

% fds_ref
% fds_ref=zeros(n_dam,n_bex,n_ref);

num=N;

for i=1:num

    try
        FS=FDS_name{i};
        aq=evalin('base',FS);  
    catch
        out1=sprintf('FDS array not found: %d %s',i,FS);
        warndlg(out1);
        jflag=1;
        setappdata(0,'jflag',jflag);        
        return; 
    end
    
    if(isempty(aq))
        warndlg('FDS array is empty');
        jflag=1;
        setappdata(0,'jflag',jflag);       
        return;
    end
    
    if(i==1)
        fn=aq(:,1);
        n_ref=length(fn);
        fds_ref=zeros(n_ref,num);
    end
    
    if(length(aq(:,2))~=n_ref)
        warndlg('FDS length error');
        return;
    end
    
    try
       for k=1:n_ref
            fds_ref(k,i)=aq(k,2);
       end
    catch
        warndlg('FDS array error');
        jflag=1;
        setappdata(0,'jflag',jflag);        
        return;         
    end
    
end   

setappdata(0,'fn',fn);
setappdata(0,'N',N);
setappdata(0,'A',A);
setappdata(0,'AA',AA);
setappdata(0,'Q',Q);
setappdata(0,'bex',bex);
setappdata(0,'FDS_name',FDS_name);
setappdata(0,'n_ref',n_ref);    
setappdata(0,'fds_ref',fds_ref);



% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

tic

tpi=2*pi;

%%%

num_sine=get(handles.listbox_num_sine,'Value');


name=get(handles.edit_save_name,'String');

if(isempty(name))
   warndlg('Enter model output name');
   return;    
end

%%%


get_table(hObject, eventdata, handles);

jflag=getappdata(0,'jflag');
if(jflag==1)
    return;
end
 
fn=getappdata(0,'fn');
N=getappdata(0,'N');
A=getappdata(0,'A');
Q=getappdata(0,'Q');
bex=getappdata(0,'bex');
FDS_name=getappdata(0,'FDS_name');
n_ref=getappdata(0,'n_ref');    
fds_ref=getappdata(0,'fds_ref');

try
    f1=fn(1);
    f2=fn(end);
catch
    warndlg('fn failed');
    return;
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

nmetric=get(handles.listbox_metric,'Value');

ntrials=str2num(get(handles.edit_ntrials,'String'));

fprintf('\n ntrials=%d \n\n',ntrials);

npb=get(handles.listbox_nbreak,'Value');

if(npb==1)
    nbreak=2;
end
if(npb==2)
    nbreak=3;    
end
if(npb==3)
    nbreak=3;    
end
if(npb==4)
    nbreak=4;    
end
if(npb==5)
    nbreak=4;    
end
if(npb==6)
    nbreak=5;    
end
if(npb==7)
    nbreak=5;    
end
if(npb==8)
    nbreak=6;    
end
if(npb==9)
    nbreak=5;    
end
if(npb==10)
    nbreak=4;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


damp=zeros(N,1);

for i=1:N
    damp(i)=1/(2*Q(i));
    
    if(damp(i)>=1.0e-10 && damp(i)<=0.5)
    else
        warndlg('Q value error');
        fprintf(' i=%d damp=%8.4g  Q=%8.4g \n',i,damp(i),Q(i));
        return;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
T_out=str2double(get(handles.edit_T_out,'String'));

iu=get(handles.listbox_unit,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
record = 1.0e+90;
grmslow=1.0e+50;
vrmslow=1.0e+50;
drmslow=1.0e+50;


%
xf=zeros(nbreak,1);
xapsd=zeros(nbreak,1);
%

slopec=str2double(get(handles.edit_slope,'String'));
slopec=(slopec/10.)/log10(2.);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% goal=get(handles.listbox_goal,'Value');

initial=2;
final=2;

one_half=1/2;

%
NLL=round(ntrials*0.25);
if(NLL<10)
    NLL=10;
end


ip=get(handles.listbox_octave,'Value');

if(ip==1)
    plateau=5/2;
end
if(ip==2)
    plateau=2;
end
if(ip==3)
    plateau=3/2;
end
if(ip==4)
    plateau=1;
end
if(ip==5)
    plateau=2/3;
end
if(ip==6)
    plateau=1/2; 
end
if(ip==7)
    plateau=1/3; 
end


ff=zeros(num_sine,1);
smax=zeros(num_sine,1);

try

    AS=get(handles.uitable_sine,'Data');
    
    if(isempty(AS))
        warndlg('Sine data not read');
        return;        
    end
 
    AS=char(AS);

    for i=1:num_sine
        ff(i) = str2double(strtrim(AS(i,:)));
    end 
    xfs=ff;
    fs_samp=ff;
catch
    warndlg('Sine data not read');
    return;
end


dur_temp=3;

sz=size(fds_ref);

n=sz(2);

fprintf('\n  Sine Freq & Accel (G) \n\n');

for ik=1:num_sine
    
    sr=0;
    
    [~,ii]=min(abs(ff(ik)-fn));
    cy=ff(ik)*T_out;
     
    for i=1:n
        s=(fds_ref(ii,i)/cy)^(1/bex(i));
        s=s/Q(i);
%        fprintf('%d Q=%g b=%g ff=%8.4g fn=%8.4g cy=%8.4g fds=%8.4g  s=%7.3g\n',i,Q(i),bex(i),ff(ik),fn(ii),cy,fds_ref(ii,i),s);
        if(s>sr)
            sr=s;
        end
    end 
    
    smax(ik)=sr;   
    
    fprintf(' %8.4g  %8.4g  \n',ff(ik),smax(ik));      
     
end

n=1;

while(1)
        n=n*2;
        nf=floor(log(n)/log(2));
        n=2^nf;
    
        dt=dur_temp/(n-1);
        sr=1/dt;
        
        if(sr>=10*fn(end))
            break
        end
end 
np=n;

tmax=np*dt;
df=1/tmax;

nsegments = 1;
mmm=round(np/2);

tt=(0:(np-1))*dt;
tt=tt';

ssine=zeros(np,1);
for ik=1:num_sine
    ssine=ssine+smax(ik)*sin(tpi*xfs(ik)*tt);
end
xsine=smax;

%
% generate white noise
%

m_choice=1; % mean removal
h_choice=1; % rectangular window

[white_noise,~]=white_noise_and_fft(tmax,m_choice,h_choice,np,dt);

total_rec=1.0e+90;

%
disp(' ');
disp(' Generate sample PSDs');
disp(' ');


progressbar;

for ik=1:ntrials
    
    progressbar(ik/ntrials);
%	   
    fs_samp=xfs;
    
    if(min(fs_samp)<1.0)
        warndlg('fs_samp error ref 1');
        fs_samp
        return;
    end
    

    if(rand()>0.7 || ik<NLL)
%	   
        % Generate the sample psd
        [f_sam,apsd_sam,~,slopec,sine_samp]=...
            env_generate_sample_psd_sine(n_ref,nbreak,npb,fn,slopec,initial,final,f1,f2,plateau,smax);
        kflag=1;
%
    else
%
        if(rand()>0.5)
            [f_sam,apsd_sam,~,slopec,sine_samp]=...
                env_generate_sample_psd2_sine(nbreak,npb,xf,xapsd,slopec,f1,f2,plateau,xsine);
            kflag=2;
            
        else
            
            
            sine_samp=xsine;
            apsd_sam=xapsd;
            
            q=rand();
            if(q<0.5)
             [f_sam,apsd_sam,max_sss,slopec,fs_samp,sine_samp]=...
                env_generate_sample_psd3_sine(nbreak,npb,xf,xapsd,slopec,f1,f2,plateau,xfs,xsine);
                kflag=3;
            end    
            if(npb~=5)
                if(q>=0.5)
                    sine_samp=sine_samp*(1+0.1*rand());
                    kflag=4;
                end
            else
                if(rand()>0.5)
                    sine_samp=sine_samp*(1+0.1*rand());
                    kflag=4;
                else    
                    f_sam(2)=xf(2)*(0.98+0.04*rand());
                    f_sam(3)=xf(3)*(0.98+0.04*rand());
                    f_sam=sort(f_sam);
                    kflag=5;
                end    
            end
        end
%
    end

%
    freq=f_sam;
    amp=apsd_sam;
    
    [slope,grms] = calculate_PSD_slopes(freq,amp);    
    [~,spec]=interpolate_PSD_spec_notext(np,freq,amp,slope,df);
%
    fmax=freq(end);

%   Synthesize time history for sample sine

    ssine=zeros(np,1);
    for i=1:num_sine
        ssine=ssine+sine_samp(i)*sin(tpi*fs_samp(i)*tt);
    end
    
%   Synthesize time history for sample PSD
%
    sq_spec=sqrt(spec);
%
    [~,psd_th,~]=PSD_syn_FFT_core_notext(nsegments,mmm,np,fmax,df,sq_spec,white_noise);
    
    psd_th=psd_th*(grms/std(psd_th));

    sor_th=psd_th+ssine;  
    
%    figure(100)
%    plot(tt,sor_th);

%      Calculate the fds of the sample sine-on-random time history

    yy=sor_th;
    nf=length(fn);
    
    uQ=unique(Q);
    ubex=unique(bex);
    
    nuQ=length(uQ);
    nubex=length(ubex);
    
    nc=nuQ*nubex;
    fds_th=zeros(nf,nc);
    
    [fds_th]=fds_engine_noprogress(fds_th,yy,nf,nuQ,uQ,nubex,ubex,fn,dt);
    
    fds_samfine=fds_th*(T_out/dur_temp);
%    
%      Compare the sample fds with the reference fds
    [scale]=env_compare_alt(n_ref,fds_ref,fds_samfine,bex);

%
%      scale the time history psd

    sor_th=sor_th*scale;
    sine_samp=sine_samp*scale;
    apsd_sam=apsd_sam*scale^2;
    
    max_dB=0;
    dB_diff=0;
    for j=1:n_ref
        for k=1:length(bex)
            fds_samfine(j,k)=((fds_samfine(j,k)^(1/bex(k)))*scale)^bex(k);
            term=abs(log10(fds_samfine(j,k)/fds_ref(j,k)));
            dB_diff=dB_diff+ term;
            if(term>max_dB)
                max_dB=term;
            end
        end
    end        

%    [grms_psd]=env_grms_sam(nbreak,f_sam,apsd_sam);
    
   %  grms=(grms_psd^2*std(sor_th))^(1/3);
   
  
    
%    dB_diff=dB_diff*max_dB*grms;
    
    
     [v]=integrate_function(sor_th,dt);
      v = 386*detrend( v , 1 );
      vrms=std(v);
    
  %    [d]=integrate_function(v,dt);
  %    d = detrend( d , 1 );
  %  drms=std(d);    
    
 %   [vrms]=env_vrms_sam(nbreak,f_sam,apsd_sam);
    total_diff=sqrt(vrms)*std(sor_th)*dB_diff;
    
    
%       
%      calculate the grms value 
%             
%    [grms]=env_grms_sam(nbreak,f_sam,apsd_sam);
%    [vrms]=env_vrms_sam(nbreak,f_sam,apsd_sam);
%    [drms]=env_drms_sam(nbreak,f_sam,apsd_sam);
%	 
%    [iflag,record]=env_checklow2(grms,vrms,drms,grmslow,vrmslow,drmslow,record,goal,apsd_sam);
%

 
    [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);

    if( (total_rec>total_diff && max_sss<slopec && min_fff>one_half) || ik==1)      
%
  %      dB_rec=dB_diff;
  
  
        total_rec=total_diff;

%          if(drms<drmslow)
%              drmslow=drms;
%          end
%  		if(vrms<vrmslow)
%  			vrmslow=vrms;
%          end
%  		if(grms<grmslow)
%  			grmslow=grms;
%         end
%
        f_sam=fix_size(f_sam);
        apsd_sam=fix_size(apsd_sam);

        xf=f_sam;
 		xapsd=apsd_sam;
        xsine=sine_samp;
        xfs=fs_samp;       
        
%        drms_rec=drms;
%        vrms_rec=vrms;
%        grms_rec=grms;
 
        fprintf('\n Trial %ld, PSD Coordinates  kflag=%d \n\n',ik,kflag);
       
        disp('  Freq(Hz)  Accel(G^2/Hz) '); 
        for i=1:nbreak
            fprintf(' %8.2f \t %8.4g \n',f_sam(i),apsd_sam(i));
        end
        
        fprintf('\n Sine Coordinates \n  Freq(Hz)  Accel(G) \n'); 
        for i=1:num_sine
            fprintf(' %8.2f \t %8.4g \n',fs_samp(i),sine_samp(i));            
        end
        
        disp(' ');     
        
%
        fprintf('   Trial: total_diff=%8.4g  grms=%8.4g  \n',total_rec,std(sor_th));  
        
    if(min(fs_samp)<1.0)
        warndlg('fs_samp error ref 4a');
        disp('fs_samp error ref 4a ');
        kflag
        fs_samp
        return;
    end 
    if(min(xfs)<1.0)
        warndlg('fs_samp error ref 4b');
        disp('fs_samp error ref 4b ');
        kflag
        xfs
        return;
    end
        
%%%        out1=sprintf(' %8.4g %8.4g \n\n',max_sss,slopec);
%%%       disp(out1);
        
%
    end
    
    if(min(fs_samp)<1.0)
        warndlg('fs_samp error ref 5a');
        disp('fs_samp error ref 5a ');
        kflag
        fs_samp
        return;
    end  
    if(min(xfs)<1.0)
        warndlg('fs_samp error ref 5b');
        disp('fs_samp error ref 5b ');
        kflag
        xfs
        return;
    end    

%
end

% xf=round(xf);

pause(0.3);
progressbar(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% stage 1

power_spectral_density=[xf,xapsd];
xsine=[xfs xsine];
dur=T_out;


[accel_th,vel_th,disp_th]=sine_on_random_synthesis_function(dur,power_spectral_density,xsine);
[xfds]=env_fds_batch_th(accel_th,fn,Q,bex);

%      Compare the sample fds with the reference fds
    [scale]=env_compare_alt(n_ref,fds_ref,xfds,bex);


    xsine(:,2)=xsine(:,2)*scale;
    xapsd=xapsd*scale^2;

    accel_th(:,2)=accel_th(:,2)*scale;
    vel_th(:,2)=vel_th(:,2)*scale;
    disp_th(:,2)=disp_th(:,2)*scale;   
   
    power_spectral_density=[xf,xapsd];
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% stage 2

    [xfds]=env_fds_batch_th(accel_th,fn,Q,bex);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


tt=accel_th(:,1);
a=accel_th(:,2);
v=vel_th(:,2);
d=disp_th(:,2);

ay='Accel (G)';
vy='Vel (in/sec)';
dy='Disp (in)';

aat='Acceleration';
vvt='Velocity';
ddt='Displacement';

[fig_num,hp]=plot_avd_time_histories_subplots_altp_titles(fig_num,tt,a,v,d,ay,vy,dy,aat,vvt,ddt);

%
disp('_____________________________________________________________________');
%
%
disp('Optimum Case   (copy and paste into Excel)');
disp(' ');

fprintf(' PSD: Freq(Hz) \t Accel(G^2/Hz)  \n');

for i=1:nbreak
    fprintf('    %6.1f \t%8.4g  \n',power_spectral_density(i,1),power_spectral_density(i,2));
end

fprintf('\n Sine: Freq(Hz) \tAccel(G)  \n');

for ik=1:num_sine 
    fprintf('       %g \t %8.4g  \n',xfs(ik),xsine(ik,2));  
end

fprintf('\n Overall levels \n     disp=%10.4g in rms  \n velocity=%10.4g in/sec rms \n    accel=%10.4g G rms \n',std(d),std(v),std(a));

ppp1=power_spectral_density;
ppp2=xsine;
tstring=sprintf(' Sine-on-Random Level  %7.3g GRMS overall',std(accel_th(:,2)));
md=3;

fmin=str2double(get(handles.edit_fmin,'String'));
fmax=str2double(get(handles.edit_fmax,'String'));

[fig_num]=plot_double_y_SOR(fig_num,ppp1,ppp2,tstring,fmin,fmax,md);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

disp(' ');
disp('  PSD output arrays:  psd_envelope ');
disp(' ');

assignin('base','psd_envelope',power_spectral_density);

%
x_label=sprintf(' Natural Frequency (Hz)');
ylab='Damage Index';
%
disp(' ');
disp(' FDS output arrays: ');
disp('   ');
%

uiu=(length(unique(damp))+length(unique(bex)));

for i=1:length(damp)
    
%
        xx=zeros(n_ref,1);
        ff=zeros(n_ref,1);
%        
        for k=1:n_ref
            xx(k)=xfds(k,i);
            ff(k)=fds_ref(k,i);
        end
%
        xx=fix_size(xx);
        ff=fix_size(ff);
        fn=fix_size(fn);
%
        fds1=[fn xx];
        fds2=[fn ff];
%
%%%%%%%%%%%
%
        sbex=sprintf('%g',bex(i));
        sbex=strrep(sbex, '.', 'p');
        output_name=sprintf('sor_fds_Q%g_b%s',Q(i),sbex);
        output_name2=sprintf('    %s',output_name);
        disp(output_name2);
        assignin('base', output_name, fds1);
%
%%%%%%%%%%%
%       
        output_name_ref=sprintf('time_history_fds_Q%g_b%s',Q(i),sbex);
        assignin('base', output_name_ref, fds2);

        output_name3=sprintf('    %s',output_name_ref);
        disp(output_name3);        
%
%%%%%%%%%%%
%
        if(uiu~=4)
            leg_a=sprintf('Sine-on-Random Envelope');
            leg_b=sprintf('Measured Data');
%
            [fig_num,h3]=...
            plot_fds_two_h2(fig_num,x_label,ylab,fds1,fds2,leg_a,leg_b,Q(i),bex(i),iu,nmetric);    
        
        end
%
    
end    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(uiu==4)
    [fig_num,h3]=fds_plot_2x2_alt_h2(fig_num,Q,bex,fn,ff,xx,xfds,fds_ref,nmetric,iu);
    
    try
        pname='fds_comparison_plot.emf';
        print(h3,pname,'-dmeta','-r300');
    catch
    end    
                                     
end    
 
%%%%%

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

setappdata(0,'sor_fds',fds1);
setappdata(0,'th_fds',fds2);

disp(' ');
disp(' The fatigue damage spectra is calculated from the amplitude (peak-valley)/2 ');

setappdata(0,'power_spectral_density',power_spectral_density); 

listbox_save_Callback(hObject, eventdata, handles);


output_name=strtrim(get(handles.edit_output_array,'String'));

if(isempty(output_name))
    warndlg('Enter output PSD name');
    return;
end    


data=getappdata(0,'power_spectral_density');
assignin('base', output_name, data);



output_name_psd=sprintf('%s_psd',output_name);
assignin('base', output_name_psd,power_spectral_density);

output_name_sine=sprintf('%s_sine',output_name);
assignin('base', output_name_sine, xsine);

output_name_th=sprintf('%s_th',output_name);
output_name_th=strrep(output_name_th,'psd','');
assignin('base', output_name_th, accel_th);

disp(' ');
disp(' Output files ');
fprintf('         psd: %s \n',output_name_psd);
fprintf('        sine: %s \n',output_name_sine);
fprintf('time history: %s \n\n',output_name_th);



%%

try
    pname=sprintf('%s_fds_compare_plot.emf',output_name);
    print(h3,pname,'-dmeta','-r300');
    out1=sprintf(' %s',pname);
    disp(out1);
catch
end

%%

pushbutton_save_model_Callback(hObject, eventdata, handles);


disp(' ');
toc



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
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

   [THM]=read_ascii_or_csv(filename);
   setappdata(0,'THM',THM);
   
   msgbox('Input data read complete');

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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


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



% --- Executes on selection change in listbox_input_type.
function listbox_input_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_type

% n=get(handles.listbox_input_type,'Value');

% n=1;

% if(n==1)
%   set(handles.uipanel_numerical_engine,'Visible','on'); 
% else
%   set(handles.uipanel_numerical_engine,'Visible','off'); 
% end


% --- Executes during object creation, after setting all properties.
function listbox_input_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
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





function edit_T_out_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T_out as text
%        str2double(get(hObject,'String')) returns contents of edit_T_out as a double


% --- Executes during object creation, after setting all properties.
function edit_T_out_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ndc.
function listbox_ndc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ndc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ndc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ndc

% n=get(handles.listbox_ndc,'Value');

n=1;

set(handles.text_Q2,'Visible','off'); 
set(handles.edit_Q2,'Visible','off');  
set(handles.text_Q3,'Visible','off'); 
set(handles.edit_Q3,'Visible','off');    

if(n>=2)
   set(handles.text_Q2,'Visible','on'); 
   set(handles.edit_Q2,'Visible','on');     
end
if(n>=3)
   set(handles.text_Q3,'Visible','on'); 
   set(handles.edit_Q3,'Visible','on');     
end


% --- Executes during object creation, after setting all properties.
function listbox_ndc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ndc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_nfec.
function listbox_nfec_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nfec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nfec contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nfec

% n=get(handles.listbox_nfec,'Value');

n=1;

if(n==1)
   set(handles.text_b2,'Visible','off'); 
   set(handles.edit_b2,'Visible','off');    
else
   set(handles.text_b2,'Visible','on'); 
   set(handles.edit_b2,'Visible','on');     
end



% --- Executes during object creation, after setting all properties.
function listbox_nfec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nfec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q2 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q2 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b1 as text
%        str2double(get(hObject,'String')) returns contents of edit_b1 as a double


% --- Executes during object creation, after setting all properties.
function edit_b1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b2 as text
%        str2double(get(hObject,'String')) returns contents of edit_b2 as a double


% --- Executes during object creation, after setting all properties.
function edit_b2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ntrials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ntrials as text
%        str2double(get(hObject,'String')) returns contents of edit_ntrials as a double


% --- Executes during object creation, after setting all properties.
function edit_ntrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_nbreak.
function listbox_nbreak_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nbreak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nbreak contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nbreak


% --- Executes during object creation, after setting all properties.
function listbox_nbreak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nbreak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_eng.
function listbox_num_eng_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_eng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_eng contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_eng


% --- Executes during object creation, after setting all properties.
function listbox_num_eng_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_eng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


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



function edit_dscale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dscale as text
%        str2double(get(hObject,'String')) returns contents of edit_dscale as a double


% --- Executes during object creation, after setting all properties.
function edit_dscale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q3 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q3 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_goal.
function listbox_goal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_goal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_goal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_goal


% --- Executes during object creation, after setting all properties.
function listbox_goal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_goal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num



Nrows=get(handles.listbox_num,'Value');
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end
 
set(handles.uitable_data,'Data',data_s);



% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    get_table(hObject, eventdata, handles);
catch
    warndlg('get_table error');
    return;
end


try
    listbox_num_sine=get(handles.listbox_num_sine,'Value');
    FDSEnvSOR.listbox_num_sine=listbox_num_sine;
catch
end

try
    uitable_sine=get(handles.uitable_sine,'Data');
    FDSEnvSOR.uitable_sine=uitable_sine;
catch
end

    
try
    listbox_num=get(handles.listbox_num,'Value');
    FDSEnvSOR.listbox_num=listbox_num;
    num=listbox_num;
catch
end

try
    listbox_unit=get(handles.listbox_unit,'Value');
    FDSEnvSOR.listbox_unit=listbox_unit;
catch
end

try
    listbox_metric=get(handles.listbox_metric,'Value');
    FDSEnvSOR.listbox_metric=listbox_metric;
catch
end

try
    listbox_nbreak=get(handles.listbox_nbreak,'Value');
    FDSEnvSOR.listbox_nbreak=listbox_nbreak;
catch
end

try
    listbox_goal=get(handles.listbox_goal,'Value');
    FDSEnvSOR.listbox_goal=listbox_goal;
catch
end

try
    T=get(handles.edit_T_out,'String');
    FDSEnvSOR.T=T;
catch
end

try
    ntrials=get(handles.edit_ntrials,'String');
    FDSEnvSOR.ntrials=ntrials;
catch
end

try
    output_array=get(handles.edit_output_array,'String');
    FDSEnvSOR.output_array=output_array;    
catch
end

get_table(hObject, eventdata, handles)

jflag=getappdata(0,'jflag');
if(jflag==1)
    return;
end
 

fn=getappdata(0,'fn');
N=getappdata(0,'N');
A=getappdata(0,'A');
AA=getappdata(0,'AA');
Q=getappdata(0,'Q');
bex=getappdata(0,'bex');
FDS_name=getappdata(0,'FDS_name');
n_ref=getappdata(0,'n_ref');    
fds_ref=getappdata(0,'fds_ref');


try
    FDSEnvSOR.fn=fn;
catch
end
try
    FDSEnvSOR.N=N;
catch
end
try
    FDSEnvSOR.A=A;
catch
end
try
    FDSEnvSOR.AA=AA;
catch
end
try
    FDSEnvSOR.Q=Q;
catch
end
try
    FDSEnvSOR.bex=bex;
catch
end
try
    FDSEnvSOR.FDS_name=FDS_name;
catch
end
try
    FDSEnvSOR.n_ref=n_ref;
catch
end
try
    FDSEnvSOR.fds_ref=fds_ref;
catch
end


try
    array_name=getappdata(0,'FDS_name'); 
catch
    warndlg('Array name error');
    return;
end
   
try
    if(num>=1)
        try
            THM1=evalin('base',array_name{1});
            FDSEnvSOR.THM1=THM1;
            FDSEnvSOR.FS1=array_name{1};
        catch
            warndlg('THM1 error');
            return;
        end
    end
    if(num>=2)
        try
            THM2=evalin('base',array_name{2});
            FDSEnvSOR.THM2=THM2;
            FDSEnvSOR.FS2=array_name{2};
        catch
            warndlg('THM2 error');
            return;           
        end
    end
    if(num>=3)
        try
            THM3=evalin('base',array_name{3});
            FDSEnvSOR.THM3=THM3;
            FDSEnvSOR.FS3=array_name{3};
        catch
            warndlg('THM3 error');
            return;            
        end    
    end  
    if(num>=4)
        try
            THM4=evalin('base',array_name{4});
            FDSEnvSOR.THM4=THM4;
            FDSEnvSOR.FS4=array_name{4};
        catch
            warndlg('THM4 error');
            return;               
        end
    end
    if(num>=5)
        try
            THM5=evalin('base',array_name{5});
            FDSEnvSOR.THM5=THM5;
            FDSEnvSOR.FS5=array_name{5};
        catch
            warndlg('THM5 error');
            return;               
        end            
    end
    if(num>=6)
        try
            THM6=evalin('base',array_name{6});
            FDSEnvSOR.THM6=THM6;
            FDSEnvSOR.FS6=array_name{6};
            warndlg('THM6 error');
            return;      
        catch    
        end              
    end       
catch
    fprintf('\n num=%d \n',num);
    warndlg('Save error 2');
    return;
end 


% % %
 
structnames = fieldnames(FDSEnvSOR, '-full'); % fields in the struct
  
% % %
 
 %%%  [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
%%    elk=sprintf('%s%s',writepname,writefname);

    
 %%   try
 
 %%       save(elk, 'FDSEnvSOR'); 
 
%%    catch
 %%       warndlg('Save error');
 %%       return;
 %%   end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 


%%

try
   name=strtrim(get(handles.edit_save_name,'String'));
   FDSEnvSOR.name=name;   
catch
   warndlg('Enter model output name');
   return;
end

if(isempty(name))
   warndlg('Enter model output name');
   return;    
end

    name=strrep(name,'.mat','');
    name=strrep(name,'_model',''); 
    name2=sprintf('%s_model',name);
    name=sprintf('%s_model.mat',name);


    try
        save(name, 'FDSEnvSOR'); 
    catch
        name
        warndlg('Save error b');
        return;
    end
 
%%%@@@@@

%    disp('**ref b1**');
    
  
    
    try
        filename = 'vibrationdata_envelope_fds_alt_load_list.txt';
        THM=importdata(filename);
        sz=size(THM);
        nrows=sz(1);
        
 %       out1=sprintf('nrows=%d',nrows);
 %       disp(out1);
                
 %        THM
        

    catch
         THM=[];
         disp('no read 1');       
    end
    
    try
        fileID = fopen('backup_vibrationdata_envelope_fds_alt_load_list.txt','w');
        for row = 1:nrows
            fprintf(fileID,'%s\n',char(THM{row,:}));
        end
        fclose(fileID);
        
     
        fileID = fopen('backup2_vibrationdata_envelope_fds_alt_load_list.txt','w');
        for row = 1:nrows
            fprintf(fileID,'%s\n',THM{row,:});
        end
        fclose(fileID);       
    catch
        disp(' backup failed');
    end
    
%    disp('**ref b2**');
    
   try 
        [THM,nrows]=THM_save(THM,name2);
   catch
   end
   
   try
        fileID = fopen(filename,'w');

        for row = 1:nrows
            fprintf(fileID,'%s\n',char(THM{row,:}));
        end
        fclose(fileID);
   catch
   end
%%%@@@@@
    
    
out1=sprintf('Save Complete: %s',name);
msgbox(out1);

%%%%%%%%%%%%%%%%%%%%




% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    [filename, pathname] = uigetfile('*.mat');

    setappdata(0,'filename',filename);
    setappdata(0,'pathname',pathname);
 
    load_core(hObject, eventdata, handles)
catch
end


function load_core(hObject, eventdata, handles)

disp('*** ref 1 ***');

filename=strtrim(getappdata(0,'filename'));
% pathname=getappdata(0,'pathname')

try
%    NAME = [pathname,filename];
    NAME=filename;
    struct=load(NAME);
catch    
    NAME
    warndlg('load failed');
    return;
end

try
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try

   FDSEnvSOR=evalin('base','FDSEnvSOR');

catch
   warndlg(' evalin failed ');
   return;
end

% FDSEnvSOR

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    listbox_num=FDSEnvSOR.listbox_num;    
    set(handles.listbox_num,'Value',listbox_num);
    listbox_num_Callback(hObject, eventdata, handles);
catch
end

try
    listbox_unit=FDSEnvSOR.listbox_unit;    
    set(handles.listbox_unit,'Value',listbox_unit);
catch
end

try
    listbox_metric=FDSEnvSOR.listbox_metric;     
    set(handles.listbox_metric,'Value',listbox_metric);    
catch
end

try
    listbox_nbreak=FDSEnvSOR.listbox_nbreak;    
    set(handles.listbox_nbreak,'Value',listbox_nbreak);
catch
end

try
    listbox_goal=FDSEnvSOR.listbox_goal;    
    set(handles.listbox_goal,'Value',listbox_goal);
catch
end


try
    output_array=FDSEnvSOR.output_array;      
    set(handles.edit_output_array,'String',output_array);  
catch
end

try
    T=FDSEnvSOR.T;    
    set(handles.edit_T_out,'String',T);
catch
end

try
    ntrials=FDSEnvSOR.ntrials;    
    set(handles.edit_ntrials,'String',ntrials);
catch
end

cn={'FDS Array Name','Q','b'};

try
    AA=FDSEnvSOR.AA;    
catch
    warndlg('no AA data');
end
try
    set(handles.uitable_data,'Data',AA,'ColumnName',cn);
catch
    warndlg('AA set error');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FDS_name=FDSEnvSOR.FDS_name;  
catch
end

try
    fds_ref=FDSEnvSOR.fds_ref;   
catch
end


try
    listbox_num_sine=FDSEnvSOR.listbox_num_sine;    
    set(handles.listbox_num_sine,'Value',listbox_num_sine);
catch
end

try
    uitable_sine=FDSEnvSOR.uitable_sine;    
    set(handles.uitable_sine,'Data',uitable_sine);
    listbox_num_sine_Callback(hObject, eventdata, handles);
catch
end





try
    
    for i=1:num
    
        try 
            assignin('base', FDS_name{i},[fn  fds_ref(:,i)]); 
        catch
        end      
   
    end
    
catch    
end


try
   name=FDSEnvSOR.name;    
   set(handles.edit_save_name,'String',name);      
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(FDSEnvSOR.FS1);
 
    iflag=0;
    
    try
        temp=evalin('base',FS1);
        ss=sprintf('Replace %s with Previously Saved Array',FS1);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM1=FDSEnvSOR.THM1;
            assignin('base',FS1,THM1); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS2=strtrim(FDSEnvSOR.FS2);
 
    iflag=0;
    
    try
        temp=evalin('base',FS2);
        ss=sprintf('Replace %s with Previously Saved Array',FS2);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM2=FDSEnvSOR.THM2;
            assignin('base',FS2,THM2); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    FS3=strtrim(FDSEnvSOR.FS3);
 
    iflag=0;
    
    try
        temp=evalin('base',FS3);
        ss=sprintf('Replace %s with Previously Saved Array',FS3);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM3=FDSEnvSOR.THM3;
            assignin('base',FS3,THM3); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS4=strtrim(FDSEnvSOR.FS4);
 
    iflag=0;
    
    try
        temp=evalin('base',FS4);
        ss=sprintf('Replace %s with Previously Saved Array',FS4);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM4=FDSEnvSOR.THM4;
            assignin('base',FS4,THM4); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS5=strtrim(FDSEnvSOR.FS5);
 
    iflag=0;
    
    try
        temp=evalin('base',FS5);
        ss=sprintf('Replace %s with Previously Saved Array',FS5);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM5=FDSEnvSOR.THM5;
            assignin('base',FS5,THM5); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS6=strtrim(FDSEnvSOR.FS6);
 
    iflag=0;
    
    try
        temp=evalin('base',FS6);
        ss=sprintf('Replace %s with Previously Saved Array',FS6);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM6=FDSEnvSOR.THM6;
            assignin('base',FS6,THM6); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

try
    
    AA=get(handles.uitable_data,'Data');
   
    A=char(AA);

    N=get(handles.listbox_num,'Value');

    Q=zeros(N,1);
    bex=zeros(N,1);

    k=1;

    for i=1:N
        FDS_name{i}=A(k,:); k=k+1;
        FDS_name{i} = strtrim(FDS_name{i});
    end

    for i=1:N
        Q(i)=str2double(strtrim(A(k,:))); k=k+1;
    end

    for i=1:N
        bex(i)=str2double(strtrim(A(k,:))); k=k+1;
    end
    
    for i=1:N
        data_s{i,1}=FDS_name{i};
        data_s{i,2}=sprintf('%g',Q(i));
        data_s{i,3}=sprintf('%g',bex(i));      
    end
    
    set(handles.uitable_data,'Data',data_s);
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

catch
    warndlg('Load Failed');
end    


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=3;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s);



function edit_save_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_name as text
%        str2double(get(hObject,'String')) returns contents of edit_save_name as a double


% --- Executes during object creation, after setting all properties.
function edit_save_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_slope_Callback(hObject, eventdata, handles)
% hObject    handle to edit_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_slope as text
%        str2double(get(hObject,'String')) returns contents of edit_slope as a double


% --- Executes during object creation, after setting all properties.
function edit_slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_load_model_list.
function pushbutton_load_model_list_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vibrationdata_envelope_fds_alt_load;

uiwait()

uiresume(vibrationdata_envelope_fds_alt_load)

delete(vibrationdata_envelope_fds_alt_load);
    
Lflag=getappdata(0,'Lflag');


if(Lflag==0)
    
    load_core(hObject, eventdata, handles);

    delete(vibrationdata_envelope_fds_alt_load);

else
    delete(vibrationdata_envelope_fds_alt_load);    
end


% --- Executes on selection change in listbox_octave.
function listbox_octave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_octave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_octave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_octave


% --- Executes during object creation, after setting all properties.
function listbox_octave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_octave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_sine.
function listbox_num_sine_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_sine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_sine



Nrows=get(handles.listbox_num_sine,'Value');
Ncolumns=1;
 
A=get(handles.uitable_sine,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end

cn={'Freq (Hz)'};
 
set(handles.uitable_sine,'Data',data_s,'ColumnName',cn);

% --- Executes during object creation, after setting all properties.
function listbox_num_sine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end