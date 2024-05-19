function varargout = vibrationdata_envelope_fds(varargin)
% VIBRATIONDATA_ENVELOPE_FDS MATLAB code for vibrationdata_envelope_fds.fig
%      VIBRATIONDATA_ENVELOPE_FDS, by itself, creates a new VIBRATIONDATA_ENVELOPE_FDS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ENVELOPE_FDS returns the handle to a new VIBRATIONDATA_ENVELOPE_FDS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ENVELOPE_FDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ENVELOPE_FDS.M with the given input arguments.
%
%      VIBRATIONDATA_ENVELOPE_FDS('Property','Value',...) creates a new VIBRATIONDATA_ENVELOPE_FDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_envelope_fds_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_envelope_fds_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_envelope_fds

% Last Modified by GUIDE v2.5 09-Aug-2018 11:13:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_envelope_fds_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_envelope_fds_OutputFcn, ...
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


% --- Executes just before vibrationdata_envelope_fds is made visible.
function vibrationdata_envelope_fds_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_envelope_fds (see VARARGIN)

% Choose default command line output for vibrationdata_envelope_fds
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_method,'Value',1);
set(handles.listbox_input_type,'Value',1);
set(handles.listbox_nbreak,'Value',1);

listbox_ndc_Callback(hObject, eventdata, handles);
listbox_nfec_Callback(hObject, eventdata, handles);
listbox_input_type_Callback(hObject, eventdata, handles);

listbox_method_Callback(hObject, eventdata, handles);

set(handles.listbox_num_eng,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_envelope_fds wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_envelope_fds_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_envelope_fds);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

goal=get(handles.listbox_goal,'Value');

dscale=str2num(get(handles.edit_dscale,'String'));

fig_num=1;

nmetric=get(handles.listbox_metric,'Value');

ntype=get(handles.listbox_input_type,'Value');

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
if(npb==7)
    nbreak=5;    
end
if(npb==8)
    nbreak=6;    
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

n_bex=get(handles.listbox_nfec,'Value');         
nfe=n_bex;

bex(1)=str2num(get(handles.edit_b1,'String'));

if(n_bex==2)
    bex(2)=str2num(get(handles.edit_b2,'String'));    
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


%
slope=zeros(nbreak,1);
fn=zeros(nbreak,1);
apsd_samfine=zeros(nbreak,1);
fds_samfine=zeros(nbreak,1);
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
n_ref=length(fn);

%%%%%%%%%%%%%%

if(ntype==1)  % random
%
    num_eng=get(handles.listbox_num_eng,'Value');
%
    if(num_eng==1)
        [fds_ref]=env_fds_th_direct(base,dt,fn,damp,bex,iu,nmetric);        
    else
        [fds_ref]=env_fds_th2(base,dt,fn,damp,bex,iu,nmetric);
    end    
%    
else          % sine
%    
    [fds_ref]=env_fds_th_sine(base,dt,fn,damp,bex,iu,nmetric);       
%
end    

if(dscale ~=1)
    fds_ref=fds_ref*dscale;
end
%%%%%%%%%%%%%%

initial=2;
final=2;

disp(' ');
disp(' Generate sample PSDs');
disp(' ');

%

progressbar;

NLL=round(ntrials/10);
if(NLL<10)
    NLL=10;
end

for ik=1:ntrials
    
    progressbar(ik/ntrials);
    
%	   
    if(rand()>0.5 || ik<NLL)
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
%      Interpolate the sample psd
    [fn,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,fn);
% 

    a11=max(apsd_samfine);
    a22=min(apsd_samfine);
    
    if(a22<1.0e-20)
    
        out1=sprintf('\n max(apsd_samfine)=%8.4g  min(apsd_samfine)=%8.4g \n',a11,a22);
        disp(out1);    
    
    end

%      Calculate the fds of the sample psd
    [fds_samfine]=env_fds_batch(apsd_samfine,n_ref,fn,damp,bex,T_out,iu,nmetric);    
%    
%      Compare the sample fds with the reference fds
    [scale]=env_compare(n_ref,fds_ref,fds_samfine,bex);
%
%      scale the psd
    scale=(scale^2.);
    apsd_sam=apsd_sam*scale;
%       
%      calculate the grms value 
%             
    [grms]=env_grms_sam(nbreak,f_sam,apsd_sam);
%
    [vrms]=env_vrms_sam(nbreak,f_sam,apsd_sam);
%
    [drms]=env_drms_sam(nbreak,f_sam,apsd_sam);
%	 
    [iflag,record]=env_checklow(grms,vrms,drms,grmslow,vrmslow,drmslow,record,goal);
%       
    if(iflag==1)      
%
        if(drms<drmslow)
            drmslow=drms;
        end
		if(vrms<vrmslow)
			vrmslow=vrms;
        end
		if(grms<grmslow)
			grmslow=grms;
        end
%
        f_sam=fix_size(f_sam);
        apsd_sam=fix_size(apsd_sam);

        xf=f_sam;
 		xapsd=apsd_sam;
        
        power_spectral_density=[f_sam(1:nbreak) apsd_sam(1:nbreak)];
        
        drms_rec=drms;
        vrms_rec=vrms;
        grms_rec=grms;
 
        out1=sprintf('\n Trial %ld, PSD Coordinates \n',ik);
        disp(out1);
        disp('  Freq(Hz)  Accel(G^2/Hz) '); 
        for i=1:nbreak
            out1=sprintf(' %8.2f \t %8.4g ',f_sam(i),apsd_sam(i));
            disp(out1);
        end
        disp(' ');
        
%
        out1=sprintf('   Trial: drms=%10.4g  vrms=%10.4g  grms=%10.4g ',drms,vrms,grms); 
        out2=sprintf('  Record: drms=%10.4g  vrms=%10.4g  grms=%10.4g \n',drms_rec,vrms_rec,grms_rec); 
        disp(out1);
        disp(out2);
%
    end

%
end

xf=round(xf);

pause(0.3);
progressbar(1);

%       
% Interpolate the best psd
%
sz=size(fn);
if(sz(2)>sz(1))
    fn=fn';
end 
%         
[xapsdfine]=env_interp_best(nbreak,n_ref,xf,xapsd,fn);
%
sz=size(xapsdfine);
if(sz(2)>sz(1))
    xapsdfine=xapsdfine';
end 
%
sz=size(xf);
if(sz(2)>sz(1))
    xf=xf';
end 
%
sz=size(xapsd);
if(sz(2)>sz(1))
    xapsd=xapsd';
end           
%


%
% Calculate the fds of the best psd
% 
[xfds]=env_fds_batch(xapsdfine,n_ref,fn,damp,bex,T_out,iu,nmetric);
%
% [grms]=env_grms_sam(nbreak,f_sam,xapsd);
%
% [vrms]=env_vrms_sam(nbreak,f_sam,xapsd);
%
% [drms]=env_drms_sam(nbreak,f_sam,xapsd);
%
   grms=grms_rec;
   vrms=vrms_rec;
   drms=drms_rec;

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

disp(' ');
disp('  PSD output array:  psd_envelope ');
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
for i=1:length(damp)
    for j=1:length(bex)
%
        xx=zeros(n_ref,1);
        ff=zeros(n_ref,1);
%        
        for k=1:n_ref
            xx(k)=xfds(i,j,k);
            ff(k)=fds_ref(i,j,k);
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
        sbex=sprintf('%g',bex(j));
        sbex=strrep(sbex, '.', 'p');
        output_name=sprintf('psd_fds_Q%g_b%s',Q(i),sbex);
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
        leg_a=sprintf('PSD Envelope');
        leg_b=sprintf('Measured Data');
%
        [fig_num]=...
        plot_fds_two(fig_num,x_label,ylab,fds1,fds2,leg_a,leg_b,Q(i),bex(j),iu,nmetric);
%
    end
end    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(length(damp)==2 && length(bex)==2)
    [fig_num]=fds_plot_2x2(fig_num,Q,bex,fn,ff,xx,xfds,fds_ref,nmetric,iu);
end    
 

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

setappdata(0,'psd_fds',fds1);
setappdata(0,'th_fds',fds2);

disp(' ');
disp(' The fatigue damage spectra is calculated from the amplitude (peak-valley)/2 ');

setappdata(0,'power_spectral_density',power_spectral_density); 

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

n=get(handles.listbox_input_type,'Value');

if(n==1)
   set(handles.uipanel_numerical_engine,'Visible','on'); 
else
   set(handles.uipanel_numerical_engine,'Visible','off'); 
end


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
    msgbox('PSD FDS already saved per name(s) in Matlab Command Window'); 
end   
if(n==3)
    msgbox('Time History FDS already saved per name(s) in Matlab Command Window'); 
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
