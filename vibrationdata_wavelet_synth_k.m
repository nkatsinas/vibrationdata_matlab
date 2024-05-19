function varargout = vibrationdata_wavelet_synth(varargin)
% VIBRATIONDATA_WAVELET_SYNTH MATLAB code for vibrationdata_wavelet_synth.fig
%      VIBRATIONDATA_WAVELET_SYNTH, by itself, creates a new VIBRATIONDATA_WAVELET_SYNTH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_WAVELET_SYNTH returns the handle to a new VIBRATIONDATA_WAVELET_SYNTH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_WAVELET_SYNTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_WAVELET_SYNTH.M with the given input arguments.
%
%      VIBRATIONDATA_WAVELET_SYNTH('Property','Value',...) creates a new VIBRATIONDATA_WAVELET_SYNTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_wavelet_synth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_wavelet_synth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_wavelet_synth

% Last Modified by GUIDE v2.5 08-Jul-2019 11:38:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_wavelet_synth_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_wavelet_synth_OutputFcn, ...
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


% --- Executes just before vibrationdata_wavelet_synth is made visible.
function vibrationdata_wavelet_synth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_wavelet_synth (see VARARGIN)

% Choose default command line output for vibrationdata_wavelet_synth
handles.output = hObject;

set(handles.pushbutton_plot,'Visible','off');

set(handles.pushbutton_read_data,'Visible','on'); 

set(handles.listbox_method,'Value',1);
set(handles.listbox_octave_spacing,'Value',3);
set(handles.listbox_strategy,'Value',1);
set(handles.listbox_units,'Value',1);
set(handles.listbox_condition,'Value',2);
set(handles.listbox_output_array,'Value',1);

set(handles.edit_Q,'String','10');

set(handles.text_suggest_sample_rate,'String',' ');
set(handles.text_condition_suggestion,'String',' ');

set(handles.uipanel_sample_rate,'visible','off');
set(handles.text_suggest_sample_rate,'visible','off');
set(handles.edit_sample_rate,'visible','off');

set(handles.pushbutton_calculate,'visible','off');

set(handles.uipanel_conditon_type,'visible','off');
set(handles.text_condition_suggestion,'visible','off');
set(handles.edit_condition,'visible','off');

set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_export,'Visible','off');
set(handles.listbox_output_array,'Visible','off');
set(handles.edit_output_array,'Visible','off');
set(handles.text_output_array,'Visible','off'); 

set(handles.uipanel_select_condition,'Visible','off'); 
%% set(handles.listbox_condition,'Visible','off'); 
listbox_strategy_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_wavelet_synth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_wavelet_synth_OutputFcn(hObject, eventdata, handles) 
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

%% h = msgbox('Intermediate Results are written in Command Window');

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );

if(NFigures>6)
    NFigures=6;
end

for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%

setappdata(0,'fig_num',1);

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  srs_spec_input=evalin('base',FS);   
else
  srs_spec_input=getappdata(0,'srs_spec_input');
end

f=srs_spec_input(:,1);
a=srs_spec_input(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MAXTRIALS=20000;
K100=100000;
K200=200000;
NUM=500;
MAX=125;
exponent=1;  % initialize only
%
tpi=2.*pi;
%
niter=100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear aspec;
clear length;

n=length(f);

aspec=a;
%
ffirst=f(1);
flast=f(n);

s1=sprintf('(suggest >= %g)',10*flast);
set(handles.text_suggest_sample_rate,'String',s1);

ss=sprintf('%9.6g',10*flast);
set(handles.edit_sample_rate,'String',ss);

set(handles.uipanel_select_condition,'Visible','on'); 
listbox_condition_Callback(hObject, eventdata, handles);

last_f=f(n);
last_a=a(n);
%
clear fr;
clear r;
fr=f;
 r=a;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%  Calculate slopes between input points
%
clear length;
num=length(fr);
%
s=zeros(num-1,1);
%
for i=1:(num-1)
    a=(log(r(i+1))-log(r(i)));
    b=(log(fr(i+1))-log(fr(i)));
    s(i)=a/b;
end
%
clear f;
clear spec;
 
%
%%  Interpolate
%
f(1)= fr(1);
fa=fr(1);
fb=fr(1);
spec(1)=r(1);
%
ioct=get(handles.listbox_octave_spacing,'Value');

%
octave=(1./3.);
%
if ioct==2
    octave=(1./6.);
end
%
if ioct==3
    octave=(1./12.);
end
%
if ioct==4
    octave=(1./24.);
end
%
f(1)=fr(1);
spec(1)=r(1);
i=2;
%
while(1) 
    ff=(2.^octave)*fb;
    fb=ff;
    if(ff>fr(num))
        break;
    end    
%
    if( ff >= fr(1))
%
        for j=1:num
%
            if(ff == fr(j))
						f(i)=ff;
						spec(i)=r(j);
                        nspec=i;
                        i=i+1;                        
						break;
            end
            if(ff < fr(j) && j>1)
%					
						f(i)=ff;
						az=(log10(r(j-1)));
						az=az+(s(j-1)*(log10(ff)-log10(fr(j-1))));
						spec(i)=10.^az;
                        nspec=i;
                        i=i+1;
						break;
            end
%
        end
    end
end
%
frlast=max(fr);
%
if(frlast > f(nspec))
          nspec=nspec+1;
		     f(nspec)=fr(num);
		  spec(nspec)=r(num);
end
amp_start= spec/16;
arlast=amp_start(nspec);   
%
if(nspec > NUM)  
		   out1=sprintf('\n Warning: number of specification points reduced. ');
           disp(out1);
		   nspec=NUM;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

Q=str2num(get(handles.edit_Q,'String'));

damp = (1./(2.*Q));

istrat=get(handles.listbox_strategy,'Value');


ntrials=str2num(get(handles.edit_trials,'String'));

if(ntrials> MAXTRIALS)
%	  
		  ntrials=MAXTRIALS;
%
          out1=sprintf('\n Warning: number of trials reduced to %ld \n',ntrials);
          disp(out1);
end
%
ym=zeros(ntrials,1);
vm=zeros(ntrials,1);
dm=zeros(ntrials,1);
em=zeros(ntrials,1);   
im=zeros(ntrials,1);   
km=zeros(ntrials,1); 
dskm=zeros(ntrials,1); 
%

iunit=get(handles.listbox_units,'Value');

dunit='mm';
vunit='m/sec';
aunit='G';
%
if(iunit==1)
		  dunit='inch';
		  vunit='in/sec';
end
if(iunit==3)
		  aunit='m/sec^2';
end


sr=str2num(get(handles.edit_sample_rate,'String'));
dt=1/sr;

iw=str2num(get(handles.edit_iw,'String'));
ew=str2num(get(handles.edit_ew,'String'));
dw=str2num(get(handles.edit_dw,'String'));
vw=str2num(get(handles.edit_vw,'String'));
aw=str2num(get(handles.edit_aw,'String'));
cw=str2num(get(handles.edit_crest,'String'));
kw=str2num(get(handles.edit_kw,'String'));
dskw=str2num(get(handles.edit_dskw,'String'));

nct=get(handles.listbox_condition,'Value');

if(nct==1) % points

    nt=str2num(get(handles.edit_condition,'String'));
    dur=nt*dt;
    rnp=ceil(sr*(1.6/f(1)));
    s1=sprintf(' (Recommend >= %d) ',rnp);

else % duration (sec)
    dur=str2num(get(handles.edit_condition,'String'));
    nt=round(dur/dt); 
    s1=sprintf(' (Recommend >= %8.4g) ',1.6/f(1));

    ss=sprintf('%8.4g',1.6/f(1));
%%    set(handles.edit_condition,'String',ss);    
    
end

set(handles.text_condition_suggestion,'String',s1);

out1=sprintf('\n dt=%9.4g sec   dur=%8.4f sec  sr=%9.4g sample/sec  nt=%ld \n',dt,dur,sr,nt);
disp(out1);
%
if(dur < 1.5/f(1))
%
        dur=1.6/f(1);
		out1=sprintf('\n\n Warning: duration is too short.\n\n Duration is reset to %f ',dur);
        disp(out1);
        
        ss=sprintf('%8.4g',dur);
        set(handles.edit_condition,'String',ss);
        
%%%        warndlg(out1,'Warning');
%
end
%        
tic
disp(' ');
%
[a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(f,damp,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

K400=400e+03;

errorbefore=0.;
%
ijk=0;
%
if(nt < K400)
%
    out1=sprintf('             Peak        Peak         Peak         ');
    out2=sprintf('   Trial     Accel       Vel          Disp      T.Error      I.Error');
%
    disp(out1);
    disp(out2);
%                
	if(iunit==1)
        out3=sprintf('             (G)         (in/sec)     (in)       ');
    end
	if(iunit==2)
        out3=sprintf('             (G)         (m/sec)      (mm)       ');
    end
    if(iunit==3)
        out3=sprintf('             (m/sec^2)   (m/sec)      (mm)       ');
    end
    disp(out3);
%
    ichoice = 1;
%
    omegaf=tpi*f;
    local_amp=zeros(nspec,1);
    over_period=zeros(nspec,1);
    onep5_period=zeros(nspec,1);
%
    for i=1:nspec 
         over_period(i)=(1.0/f(i));
        onep5_period(i)=(1.5/f(i));
    end
%
%
    wavelet=zeros(nspec,nt);
%
    sym=zeros(ntrials,1);
    svm=zeros(ntrials,1);
    sdm=zeros(ntrials,1);
    sem=zeros(ntrials,1);
    sim=zeros(ntrials,1);
    scm=zeros(ntrials,1);
    skm=zeros(ntrials,1);
    sdskm=zeros(ntrials,1);
%
    irec=1.0e+99;
    yrec=1.0e+99;
    crec=1.0e+99;

    progressbar;
    for inn=1:ntrials	
         progressbar(inn/ntrials)        
        
        local_record = 1.0e+99;
%
        exponent = 0.5;
%
        if( rand()< 0.4 )
%
            exponent = ( 0.40 + 0.1*rand() );
%
        end
%       
        if(istrat==1) % reverse sine sweep
            [amp,td,nhs,stype]=ws_synth3(amp_start,dur,onep5_period,ntrials,inn,f,nspec);
        end    
        if(istrat==2) % random
            [amp,td,nhs,stype]=ws_synth1(amp_start,dur,onep5_period,inn,f,nspec);            
        end
        if(istrat==3) % exponential decay
            [amp,td,nhs,stype]=ws_synth_exp(amp_start,dur,onep5_period,inn,f,nspec);
        end
        ampr=amp;
%        
        nspec=max(size(spec));
%
        ichoice=ichoice+1;
        igen=inn;

        upper=zeros(nspec,1); 
%
        for i=1:nspec
            upper(i) = (nhs(igen,i)/(2.*f(i)));
            if( nhs(igen,i) == 0 || abs(upper(i))<1.0e-20  )
                out1=sprintf(' f=%8.4g  u=%8.4g  nhs=%d',f(i),upper(i),nhs(igen,i));
                disp(out1);
                input(' ctrl-C');
            end
        end  
%%%
%
        re1=0;
        re2=0;
        rnv=0;
%        
        for nv=1:niter  
%
            [wavelet,th] = ws_gen_time(nhs,amp,omegaf,upper,nt,dt,td,igen,nv,wavelet,nspec);             
%                    
            [~,~,xmax,xmin]=ws_srs(nspec,th,a1,a2,b1,b2,b3,f);
%                    
            [error,irror]=ws_srs_error(spec,xmax,xmin,nspec);
%
            if( irror < local_record )   %% end criteria
%					
                for i=1:nspec
%						
                    local_amp(i)=amp(igen,i);
                    local_record = irror;
%
                end
            end
%			
            if(inn>1 && nv>= 10 && ymax >= 1.5*yrec)
                break;
            end
            if(inn>1 && nv>= 10 && crest >= 1.4*crec)
                break;
            end           
            if(nv>= 10 && 20*abs(irror) >= 1.5*irec)
                break;
            end
            if(nv>= 20 && 20*abs(irror) >= 1.2*irec)
                break;
            end
            if(nv>= 100 && irror >= errorbefore)
                break;
            end
%
            if(nv>= 2 && irror < errorbefore)
%
                for i=1:nspec
                    amp(igen,i)=local_amp(i);
                end
%
                store_amp(igen,:)=amp(igen,:);
                store_NHS(igen,:)=nhs(igen,:);
                store_td(igen,:) =td(igen,:);
%
                ymax=max(abs(th));
                [vmax,dmax,vth,dth]=ws_max_param_alt_dv(iunit,th,dt);
%
                irror=(local_record);
%
                re1=20.*error;
                re2=20.*irror;
                rnv=nv;
%
                [mu,sd,rms,sk,kt]=kurtosis_stats(th); 
                [dmu,dsd,drms,dsk,dkt]=kurtosis_stats(dth);
%                 [pszcr,peak_rate,pa]=zero_crossing_function(th,dur);
%                if(pszcr==0)
%                     pszcr=1;
%                 end
%                dsk=1/pszcr;
 
%                [v]=differentiate_function(th,dt);
%                dsk=max(abs(v));
 
%
                dsk=abs(dsk); 

                crest=abs(ymax/sd); 
                 
                sym(inn)=abs(ymax);
                svm(inn)=abs(vmax);
                sdm(inn)=abs(dmax);
                sem(inn)=abs(error);
                sim(inn)=abs(irror);
                scm(inn)=crest;
                skm(inn)=kt;
                sdskm(inn)=dsk;
                
                ampr=amp;
                
                        
            end
%

            errorbefore=irror;
%
            if(nv<10 || rand()<0.6)
                [amp]=ws_scale(xmax,xmin,spec,exponent,ampr,inn,nspec);
            else
                for i=1:nspec
                    amp(i)=ampr(i)*(0.9+0.2*rand());
                end    
            end
%
        end
             
        
        out1=sprintf('      %ld %10.2f %12.3f %12.3f %11.2f %10.2f  %ld  crest=%7.2f dsk=%7.2f \n yrec=%8.4g  crec=%7.2f  irec=%7.2f \n',inn,ymax,vmax,dmax,re1,re2,rnv,crest,dsk,yrec,crec,irec);
     	disp(out1);
%
		ijk=ijk+1;
    end
    
    progressbar(1);
    pause(0.3);    
%
    for jk=1:ntrials
        ym(jk)=sym(jk);
        vm(jk)=svm(jk);
        dm(jk)=sdm(jk);
        em(jk)=sem(jk);
        im(jk)=sim(jk);
        cm(jk)=scm(jk);
        km(jk)=skm(jk);
        dskm(jk)=sdskm(jk);
    end


%
    rntrials=ntrials;
%
    fig_num=1;
    displacement_limit=1e+09;
%   
        [iwin,nrank,dm,drank]=ws_rankfunctions_kt(rntrials,ym,vm,dm,em,im,cm,km,dskm,nspec,aunit,vunit,dunit,displacement_limit,iw,ew,dw,vw,aw,cw,kw,dskw);    
%
        [acceleration,velocity,displacement]=ws_th_from_wavelet_table(iwin,store_amp,store_NHS,store_td,dur,dt,nt,iunit,f);
%
        [fig_num]=plot_avd_time_histories_subplots(acceleration,velocity,displacement,iunit,fig_num);
%          
        wavelet_table=zeros(nspec,5);
        for i=1:nspec
             wavelet_table(i,1)=i;
             wavelet_table(i,2)=store_amp(iwin,i);
             wavelet_table(i,3)=f(i);
             wavelet_table(i,4)=store_NHS(iwin,i);
             wavelet_table(i,5)=store_td(iwin,i);
        end
%          
        disp(' Output Time Histories:');
        disp('   displacement ');
        disp('   velocity ');
        disp('   acceleration ');
        disp('   shock_response_spectrum ');
        disp(' ');
        disp('   wavelet_table  [index  accel(G)  freq(Hz)  number of half-sines  delay(sec)]');
%           
           th=acceleration(:,2);
           [~,~,xmax,xmin]=ws_srs(nspec,th,a1,a2,b1,b2,b3,f);           
%
         [Shock_Response_Spectrum,fig_num]=...
          wavelet_synth_srs_plot(f,fr,xmax,xmin,aspec,damp,iunit,fig_num);
%    

        assignin('base', 'acceleration', acceleration);
        assignin('base', 'velocity', velocity );
        assignin('base', 'displacement', displacement);
        assignin('base', 'shock_response_spectrum', Shock_Response_Spectrum);
        assignin('base', 'wavelet_table', wavelet_table);         
%
        setappdata(0,'f',f); 
        setappdata(0,'fr',fr); 
        setappdata(0,'xmax',xmax);    
        setappdata(0,'xmin',xmin); 
        setappdata(0,'aspec',aspec); 
        setappdata(0,'damp',damp);        

        setappdata(0,'displacement',displacement); 
        setappdata(0,'velocity',velocity); 
        setappdata(0,'acceleration',acceleration); 
        setappdata(0,'shock_response_spectrum',Shock_Response_Spectrum); 
        setappdata(0,'wavelet_table',wavelet_table); 
        setappdata(0,'fig_num',fig_num);
        setappdata(0,'iunit',iunit);
        
        set(handles.uipanel_save,'Visible','on');
        set(handles.uipanel_export,'Visible','on');
        set(handles.listbox_output_array,'Visible','on');
        set(handles.edit_output_array,'Visible','on');
        set(handles.text_output_array,'Visible','on');        
%
else
%
	out1=sprintf('\n\n  Error: too many samples.\n\n');
    disp(out1);
%    
end  %% end nt loop
%        

set(handles.pushbutton_plot,'Visible','on');




disp(' '); 
toc



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_wavelet_synth);


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
set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

n=get(hObject,'Value');

if(n==1)
   set(handles.pushbutton_read_data,'Visible','off');     
    
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.pushbutton_read_data,'Visible','off');
   
   set(handles.edit_input_array,'enable','off')
   
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   srs_spec_input = fscanf(fid,'%g %g',[2 inf]);
   srs_spec_input=srs_spec_input';
    
   setappdata(0,'srs_spec_input',srs_spec_input);
   
   activate_sample_rate(hObject, eventdata, handles)
   
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


% --- Executes on selection change in listbox_octave_spacing.
function listbox_octave_spacing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_octave_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_octave_spacing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_octave_spacing


% --- Executes during object creation, after setting all properties.
function listbox_octave_spacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_octave_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_strategy.
function listbox_strategy_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_strategy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_strategy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_strategy

n=get(handles.listbox_strategy,'Value');

if(n==3)
    set(handles.edit_iw,'String','3');
    set(handles.edit_ew,'String','2');
%%    set(handles.listbox_octave_spacing,'Value',4);
else
    set(handles.edit_iw,'String','1');    
    set(handles.edit_ew,'String','1');    
%%    set(handles.listbox_octave_spacing,'Value',3);    
end



% --- Executes during object creation, after setting all properties.
function listbox_strategy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_strategy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trials as text
%        str2double(get(hObject,'String')) returns contents of edit_trials as a double


% --- Executes during object creation, after setting all properties.
function edit_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


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



function edit_sample_rate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sample_rate as text
%        str2double(get(hObject,'String')) returns contents of edit_sample_rate as a double


% --- Executes during object creation, after setting all properties.
function edit_sample_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_iw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_iw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_iw as text
%        str2double(get(hObject,'String')) returns contents of edit_iw as a double


% --- Executes during object creation, after setting all properties.
function edit_iw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ew_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ew as text
%        str2double(get(hObject,'String')) returns contents of edit_ew as a double


% --- Executes during object creation, after setting all properties.
function edit_ew_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dw as text
%        str2double(get(hObject,'String')) returns contents of edit_dw as a double


% --- Executes during object creation, after setting all properties.
function edit_dw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_vw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vw as text
%        str2double(get(hObject,'String')) returns contents of edit_vw as a double


% --- Executes during object creation, after setting all properties.
function edit_vw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aw as text
%        str2double(get(hObject,'String')) returns contents of edit_aw as a double


% --- Executes during object creation, after setting all properties.
function edit_aw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_condition.
function listbox_condition_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_condition contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_condition

n=get(handles.listbox_condition,'Value');

if(n==2)
    set(handles.uipanel_conditon_type,'Title','Enter Duration (sec)');
else
    set(handles.uipanel_conditon_type,'Title','Enter Number of Points');    
end

activate_duration(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_condition_Callback(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_condition as text
%        str2double(get(hObject,'String')) returns contents of edit_condition as a double


% --- Executes during object creation, after setting all properties.
function edit_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_sample_rate.
function pushbutton_sample_rate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_duration.
function pushbutton_duration_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_read_data.
function pushbutton_read_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    FS=get(handles.edit_input_array,'String');
    srs_spec_input=evalin('base',FS);  

    setappdata(0,'srs_spec_input',srs_spec_input);

catch
   warndlg('Input array not found'); 
   return; 
end

activate_sample_rate(hObject, eventdata, handles);
set(handles.pushbutton_calculate,'visible','on');

function activate_sample_rate(hObject, eventdata, handles)
%
disp('activate');

try
    srs_spec_input=getappdata(0,'srs_spec_input');
catch
    warndlg('Input SRS not found');
    return;
end       
    
set(handles.uipanel_sample_rate,'visible','on');
set(handles.text_suggest_sample_rate,'visible','on');
set(handles.edit_sample_rate,'visible','on');
   
flast=max(srs_spec_input(:,1));
s1=sprintf('(suggest >= %g)',10*flast);
set(handles.text_suggest_sample_rate,'String',s1);
ss=sprintf('%9.6g',10*flast);
set(handles.edit_sample_rate,'String',ss);

set(handles.uipanel_select_condition,'Visible','on'); 
listbox_condition_Callback(hObject, eventdata, handles)


% --- Executes on key press with focus on edit_condition and none of its controls.
function edit_condition_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_calculate,'visible','on');


% --- Executes on key press with focus on edit_sample_rate and none of its controls.
function edit_sample_rate_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_sample_rate (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_select_condition,'Visible','on'); 
set(handles.listbox_condition,'Visible','on'); 

activate_duration(hObject, eventdata, handles);

function activate_duration(hObject, eventdata, handles)

set(handles.uipanel_conditon_type,'visible','on');
set(handles.text_condition_suggestion,'visible','on');
set(handles.edit_condition,'visible','on');

n=get(handles.listbox_condition,'Value');

srs_spec_input=getappdata(0,'srs_spec_input');

fmin=srs_spec_input(1,1);

T=1/fmin;

sr=str2num(get(handles.edit_sample_rate,'String'));

np=sr*T*2.0;

if(n==1)
    s1=sprintf('(suggest >= %g)',np);
    np
else
    s1=sprintf('(suggest >= %g)',1.6*T);
end
set(handles.text_condition_suggestion,'String',s1); 

% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_array,'value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
end
if(n==4)
    data=getappdata(0,'shock_response_spectrum');
end
if(n==5)
    data=getappdata(0,'wavelet_table');
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 



% --- Executes on selection change in listbox_output_array.
function listbox_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_array


% --- Executes during object creation, after setting all properties.
function listbox_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_array (see GCBO)
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


% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'acceleration');
assignin('base','export_signal_nastran',data);
 
handles.s=Vibrationdata_export_to_Nastran;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=getappdata(0,'fig_num');
acceleration=getappdata(0,'acceleration');
velocity=getappdata(0,'velocity');
displacement=getappdata(0,'displacement');
iunit=getappdata(0,'iunit');

[fig_num,ha,hv,hd]=plot_avd_time_histories_h(acceleration,velocity,displacement,iunit,fig_num);


%    

f=getappdata(0,'f'); 
fr=getappdata(0,'fr'); 
xmax=getappdata(0,'xmax');    
xmin=getappdata(0,'xmin'); 
aspec=getappdata(0,'aspec'); 
damp=getappdata(0,'damp');    
        
 
[Shock_Response_Spectrum,fig_num]=...
      wavelet_synth_srs_plot_h(f,fr,xmax,xmin,aspec,damp,iunit,fig_num);       



function edit_kw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kw as text
%        str2double(get(hObject,'String')) returns contents of edit_kw as a double


% --- Executes during object creation, after setting all properties.
function edit_kw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dskw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dskw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dskw as text
%        str2double(get(hObject,'String')) returns contents of edit_dskw as a double


% --- Executes during object creation, after setting all properties.
function edit_dskw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dskw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_crest_Callback(hObject, eventdata, handles)
% hObject    handle to edit_crest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_crest as text
%        str2double(get(hObject,'String')) returns contents of edit_crest as a double


% --- Executes during object creation, after setting all properties.
function edit_crest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_crest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
