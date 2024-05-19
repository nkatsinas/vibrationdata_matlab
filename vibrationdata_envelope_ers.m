function varargout = vibrationdata_envelope_ers(varargin)
% VIBRATIONDATA_ENVELOPE_ERS MATLAB code for vibrationdata_envelope_ers.fig
%      VIBRATIONDATA_ENVELOPE_ERS, by itself, creates a new VIBRATIONDATA_ENVELOPE_ERS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ENVELOPE_ERS returns the handle to a new VIBRATIONDATA_ENVELOPE_ERS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ENVELOPE_ERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ENVELOPE_ERS.M with the given input arguments.
%
%      VIBRATIONDATA_ENVELOPE_ERS('Property','Value',...) creates a new VIBRATIONDATA_ENVELOPE_ERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_envelope_ers_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_envelope_ers_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_envelope_ers

% Last Modified by GUIDE v2.5 03-Nov-2015 10:49:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_envelope_ers_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_envelope_ers_OutputFcn, ...
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


% --- Executes just before vibrationdata_envelope_ers is made visible.
function vibrationdata_envelope_ers_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_envelope_ers (see VARARGIN)

% Choose default command line output for vibrationdata_envelope_ers
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_method,'Value',1);
set(handles.listbox_nbreak,'Value',1);

listbox_ndc_Callback(hObject, eventdata, handles);

listbox_input_type_Callback(hObject, eventdata, handles);

listbox_method_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_envelope_ers wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_envelope_ers_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_envelope_ers);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dscale=str2num(get(handles.edit_dscale,'String'));

fig_num=1;

%% ioct=get(handles.listbox_interpolation,'Value');

ioct=4;

ntrials=str2num(get(handles.edit_ntrials,'String'));

out1=sprintf('\n ntrials=%d \n',ntrials);
disp(out1);

if(ioct==1)
    oct=1/3;
end
if(ioct==2)
    oct=1/6;
end
if(ioct==3)
    oct=1/12;
end
if(ioct==4)
    oct=1/24;
end
ocn=oct;

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


fmin=str2num(get(handles.edit_fmin,'String'));
f1=fmin;

fmax=str2num(get(handles.edit_fmax,'String'));
f2=fmax;

foct=log(f2/f1)/log(2);

while(foct<oct)
    nbreak=nbreak-1;
    if(nbreak<=2)
        nbreak=2;
        break;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

n_damp=get(handles.listbox_ndc,'Value');          
ndc=n_damp;

Q(1)=str2num(get(handles.edit_Q1,'String'));

if(n_damp>=2)
    Q(2)=str2num(get(handles.edit_Q2,'String'));    
end    
if(n_damp>=3)
    Q(3)=str2num(get(handles.edit_Q3,'String'));    
end    

damp=zeros(n_damp,1);

for i=1:n_damp
    damp(i)=1/(2*Q(i));
    
    if(damp(i)>=1.0e-10 && damp(i)<=0.5)
    else
        warndlg('Q value error');
        out1=sprintf(' i=%d damp=%8.4g  Q=%8.4g ',i,damp(i),Q(i));
        disp(out1);
        return;
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
T_out=str2num(get(handles.edit_T_out,'String'));


iu=get(handles.listbox_unit,'Value');

k=get(handles.listbox_method,'Value');

iflag=1;
 
if(k==1)
     try  
         FS=get(handles.edit_input_array,'String');
         THM=evalin('base',FS);  
         iflag=1;
     catch
         iflag=0; 
         warndlg('Input Array does not exist.  Try again.')
     end
else
  THM=getappdata(0,'THM');
end
 
if(iflag==0)
    return;
end 

t=double(THM(:,1));
base=double(THM(:,2));


figure(fig_num);
fig_num=fig_num+1;

plot(t,base);
grid on;
title('Base Input');
if(iu==1)
    ylabel('Accel(G)');
else
    ylabel('Accel(m/sec^2)');    
end    
xlabel('Time(sec)');

n=length(base);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);

%%%%%%%%%%%%%%

%
record = 1.0e+90;
grmslow=1.0e+50;
vrmslow=1.0e+50;
drmslow=1.0e+50;

goal=3;

%
slope=zeros(nbreak,1);
fn=zeros(nbreak,1);
apsd_samfine=zeros(nbreak,1);
ers_samfine=zeros(nbreak,1);
xf=zeros(nbreak,1);
xapsd=zeros(nbreak,1);
%

slopec=12;
slopec=(slopec/10.)/log10(2.);

fn(1)=f1;
j=2;
while(1)
    fn(j)=fn(j-1)*2^(ocn);
    if(fn(j)>f2)
        fn(j)=f2;
        break;
    end
    j=j+1;
end
%
fn=fix_size(fn);
n_ref=length(fn);

%%%%%%%%%%%%%%

pbar=1;  

[ers_ref,slabel]=env_ers_th_direct(base,dt,fn,damp,iu,pbar);


sz=size(ers_ref);

xers=zeros(sz(1),sz(2));


%%%%%%%%%%%%%%

if(dscale ~=1)
    ers_ref=ers_ref*dscale;
end
%%%%%%%%%%%%%%

initial=2;
final=2;

disp(' ');
disp(' Generate sample PSDs');
disp(' ');

%

syn_dur=100./fn(1);
tmax=syn_dur;

n_fn=length(fn);
sr=10*fn(n_fn);
dtx=1/sr;
np=syn_dur/dtx;
[np,whitex,tw]=PSD_syn_white_noise(tmax,dtx,np);


out1=sprintf(' sr=%9.5g  dt=%9.5g',sr,dt);
disp(out1);


for i=2:18
    
   nm=2^i;
   
   if(np<nm)
        num_white=2^(i-1);
        white_noise=whitex(1:num_white);
        tt=tw(1:num_white);
        break;
   end     
    
end    

syn_dur=tw(num_white);

out1=sprintf('\n  syn_dur=%8.4g sec \n',syn_dur);
disp(out1);

df=1/(num_white*dtx); 

error_max=1.0e+90;

%
progressbar;

for ik=1:ntrials
%
    progressbar(ik/ntrials);
%	   
    if(rand()>0.5 || ik<20)
%	   
			% Generate the sample psd
            [f_sam,apsd_sam]=...
                env_generate_sample_psd(n_ref,nbreak,npb,fn,ik,slopec,initial,final,f1,f2);            
%
    else
%
			[f_sam,apsd_sam]=...
                env_generate_sample_psd2(n_ref,nbreak,npb,fn,xf,xapsd,slopec,initial,final,ik,f1,f2);
%
    end

%%
%
    f_sam=fix_size(f_sam);
    apsd_sam=fix_size(apsd_sam);
    interp_psdin=[f_sam apsd_sam];

    a11=max(apsd_sam);
    a22=min(apsd_sam);
    
    if(a22<1.0e-20)
    
        out1=sprintf('\n max(apsd_sam)=%8.4g  min(apsd_sam)=%8.4g \n',a11,a22);
        disp(out1);    
    
    end

%      Calculate the ers of the sample psd
    dam=damp;    
    [ers_sam,base_sam]=env_ers(interp_psdin,fn,dam,iu,white_noise,num_white,syn_dur,df,dt);    
%
    sts=T_out/syn_dur; 
    ers_sam=ers_sam*sts;

%      Compare the sample ers with the reference ers
    [scale]=env_compare_ers(n_ref,ers_ref,ers_sam);
%
%      scale the psd

    apsd_sam=apsd_sam*scale;
     ers_sam= ers_sam*scale;
    base_sam=base_sam*sqrt(scale);
%       
%	 
    [error]=env_checklow_ers(ers_ref,ers_sam);
%        

    if(error<error_max)      
%
        error_max=error;
%
        xf=f_sam;
 		xapsd=apsd_sam;
        xers=ers_sam;
        xbase=base_sam;
%
%      calculate the grms value 
%             
        [grms]=env_grms_sam(nbreak,f_sam,apsd_sam);
%
        [vrms]=env_vrms_sam(nbreak,f_sam,apsd_sam);
%
        [drms]=env_drms_sam(nbreak,f_sam,apsd_sam);
%
        out1=sprintf('\n **  error=%8.4g drms=%10.4g  vrms=%10.4g  grms=%10.4g \n',error_max,drms,vrms,grms);  
        disp(out1);    
        
%
    else
        
        out1=sprintf('\n   trial error=%8.4g  error_max=%8.4g \n',error,error_max);  
        disp(out1);           
%
    end
    

%
end

pause(0.3);
progressbar(1);

%  
tt=fix_size(tt);
xbase=fix_size(xbase);
white_noise=fix_size(white_noise);

data=[tt(1:length(xbase)) xbase];
output_name='xbase';
assignin('base', output_name, data);

data=[tt white_noise];
output_name='white_noise';
assignin('base', output_name, data);



xf=fix_size(xf);
xapsd=fix_size(xapsd);

%
power_spectral_density=[xf xapsd];



%
% Calculate the ers of the best psd
%
[grms]=env_grms_sam(nbreak,xf,xapsd);
%
[vrms]=env_vrms_sam(nbreak,xf,xapsd);
%
[drms]=env_drms_sam(nbreak,xf,xapsd);
%
disp('_____________________________________________________________________');
%
%
disp('Optimum Case');
disp(' ');
disp(' Freq(Hz)  Accel(G^2/Hz) ');
for i=1:nbreak
    out1=sprintf(' %6.1f \t%8.4g  ',power_spectral_density(i,1),power_spectral_density(i,2));
    disp(out1);
end    
%
out1=sprintf(' drms=%10.4g  vrms=%10.4g  grms=%10.4g ',drms,vrms,grms);
disp(out1);

setappdata(0,'power_spectral_density',power_spectral_density);


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
t_string=...
sprintf(' Power Spectral Density  Overall Level = %6.3g GRMS ',grms); 
if(iu==1)
    ylab='Accel (G^2/Hz)';
else
    ylab='Accel ((m/sec^2)^2/Hz)';    
end    
x_label=sprintf(' Frequency (Hz)');
[fig_num]=plot_PSD_function(fig_num,x_label,ylab,t_string,power_spectral_density,fmin,fmax);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

xers=abs(xers);
ers_ref=abs(ers_ref);



for i=1:length(damp)
    figure(fig_num);
    plot(fn,xers(i,:),fn,ers_ref(i,:));
    leg_a=sprintf('PSD Envelope');
    leg_b=sprintf('Measured Data');    
    legend(leg_a,leg_b,'Location','northwest');
    out1=sprintf('Energy Response Spectra  Q=%g',Q(i));
    title(out1);
    ylabel(slabel);
    xlabel('Natural Frequency (Hz)');
    xlim([fmin fmax]);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale',...
               'log','YScale','log','XminorTick','on','YminorTick','on'); 
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);
    grid on;

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end     
    
    yymax=max([ max(xers(i,:)) max(ers_ref(i,:)) ]);
    yymin=min([ min(xers(i,:)) min(ers_ref(i,:)) ]);

    ymin=10^(floor(log10(yymin)));
    ymax=10^(ceil(log10(yymax)));


    ylim([ymin ymax]);    
   
    fig_num=fig_num+1;
    
    output_name=sprintf('psd_ers_Q%g',Q(i));
    output_name2=sprintf('    %s',output_name);
    disp(output_name2);
    assignin('base', output_name, [fn xers(i,:)']);

    output_name_ref=sprintf('time_history_ers_Q%g',Q(i));
    assignin('base', output_name_ref, [fn ers_ref(i,:)']);
    output_name3=sprintf('    %s',output_name_ref);
    disp(output_name3);    
    
end    



listbox_save_Callback(hObject, eventdata, handles);
set(handles.uipanel_save,'Visible','on');



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

set(handles.uipanel_save,'Visible','off');

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

n=get(handles.listbox_save,'Value');


if(n==1)

    data=getappdata(0,'power_spectral_density');

    output_name=get(handles.edit_output_array,'String');
    assignin('base', output_name, data);

    h = msgbox('Save Complete'); 
    
end
if(n==2)
    msgbox('PSD ERS already saved per name(s) in Matlab Command Window'); 
end   
if(n==3)
    msgbox('Time History ERS already saved per name(s) in Matlab Command Window'); 
end   



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

n=get(handles.listbox_ndc,'Value');

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

n=get(handles.listbox_nfec,'Value');

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

n=get(handles.listbox_save,'Value');

if(n>=2)
    set(handles.edit_output_array,'Visible','off');    
else
    set(handles.edit_output_array,'Visible','on');       
end


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
