function varargout = Multiple_PSD_FDS_Envelope_batch(varargin)
% MULTIPLE_PSD_FDS_ENVELOPE_BATCH MATLAB code for Multiple_PSD_FDS_Envelope_batch.fig
%      MULTIPLE_PSD_FDS_ENVELOPE_BATCH, by itself, creates a new MULTIPLE_PSD_FDS_ENVELOPE_BATCH or raises the existing
%      singleton*.
%
%      H = MULTIPLE_PSD_FDS_ENVELOPE_BATCH returns the handle to a new MULTIPLE_PSD_FDS_ENVELOPE_BATCH or the handle to
%      the existing singleton*.
%
%      MULTIPLE_PSD_FDS_ENVELOPE_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIPLE_PSD_FDS_ENVELOPE_BATCH.M with the given input arguments.
%
%      MULTIPLE_PSD_FDS_ENVELOPE_BATCH('Property','Value',...) creates a new MULTIPLE_PSD_FDS_ENVELOPE_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Multiple_PSD_FDS_Envelope_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Multiple_PSD_FDS_Envelope_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Multiple_PSD_FDS_Envelope_batch

% Last Modified by GUIDE v2.5 26-Jul-2018 17:15:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Multiple_PSD_FDS_Envelope_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @Multiple_PSD_FDS_Envelope_batch_OutputFcn, ...
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


% --- Executes just before Multiple_PSD_FDS_Envelope_batch is made visible.
function Multiple_PSD_FDS_Envelope_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Multiple_PSD_FDS_Envelope_batch (see VARARGIN)

% Choose default command line output for Multiple_PSD_FDS_Envelope_batch
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');
set(handles.pushbutton_calculate,'Enable','off'); 

set(handles.listbox_nbreak,'Value',1);

listbox_ndc_Callback(hObject, eventdata, handles);
listbox_n_bexc_Callback(hObject, eventdata, handles);
listbox_input_type_Callback(hObject, eventdata, handles);

listbox_method_Callback(hObject, eventdata, handles);

set(handles.uitable_data,'Data',cell(1,1));

data_s{1,1}='';

set(handles.uitable_data,'Data',data_s);  

set(handles.text_uitable,'Visible','off'); 
set(handles.uitable_data,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Multiple_PSD_FDS_Envelope_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Multiple_PSD_FDS_Envelope_batch_OutputFcn(hObject, eventdata, handles) 
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

delete(Multiple_PSD_FDS_Envelope_batch);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp('  ');
disp(' * * * * * ');
disp('  ');

iu=1;  % G^2/hz



fig_num=1;

% nmetric=get(handles.listbox_metric,'Value');

nmetric=1;  % accel

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

%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

n_damp=get(handles.listbox_ndc,'Value');          


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

n_bex=get(handles.listbox_nfe,'Value');         
n_bex=n_bex;

bex(1)=str2num(get(handles.edit_b1,'String'));

if(n_bex==2)
    bex(2)=str2num(get(handles.edit_b2,'String'));    
end    

T_out=str2num(get(handles.edit_T_out,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

THM=getappdata(0,'THM'); 
sz=size(THM);

fds_ref=zeros(n_damp,n_bex,n_ref);


df=1.;
p=iu;

idc=1;
irp=1;


A=char(get(handles.uitable_data,'Data'));
sdur=str2num(A);  


f=THM(:,1);


for ijk=2:sz(2)
    
    a=THM(:,ijk);    
%
    [s,rms]=calculate_PSD_slopes(f,a);
%    
    [fi,ai]=interpolate_PSD(f,a,s,df);
%
    dur=sdur(ijk-1);
    
    for i=1:n_damp
        
        for j=1:n_bex

            [fn,~,~,~,damage]=...
                vibrationdata_fds_vrs_engine_fn(fi,ai,damp(i),df,p,idc,irp,bex(j),dur,fn);

          
             for iv=1:n_ref
                fds_ref(i,j,iv)=fds_ref(i,j,iv)+damage(iv);                
             end   
          
        end
        
    end
         
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

%
record = 1.0e+90;
grmslow=1.0e+50;
vrmslow=1.0e+50;
drmslow=1.0e+50;

goal=3;

%

xf=zeros(nbreak,1);
xapsd=zeros(nbreak,1);
%

slopec=12;
slopec=(slopec/10.)/log10(2.);

%%%%%%%%%%%%%%

initial=2;
final=2;

disp(' ');
disp(' Generate sample PSDs');
disp(' ');

%
for ik=1:ntrials
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
		drmsp=drms;
		vrmsp=vrms;
		grmsp=grms;
%
        xf=f_sam;
 		xapsd=apsd_sam;	 
        
%
    end
%
    out1=sprintf('   Trial: drms=%10.4g  vrms=%10.4g  grms=%10.4g ',drms,vrms,grms); 
    out2=sprintf('  Record: drms=%10.4g  vrms=%10.4g  grms=%10.4g \n',drmsp,vrmsp,grmsp); 
    disp(out1);
    disp(out2);
%
end
%       

fn=fix_size(fn);
xf=fix_size(xf);
xapsd=fix_size(xapsd);

power_spectral_density=[xf xapsd];

%         
[xapsdfine]=env_interp_best(nbreak,n_ref,xf,xapsd,fn);
%
xapsdfine=fix_size(xapsdfine);         

%
% Calculate the fds of the best psd
% 
[xfds]=env_fds_batch(xapsdfine,n_ref,fn,damp,bex,T_out,iu,nmetric);

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
out1=sprintf(' drms=%10.4g  vrms=%10.4g  grms=%10.4g ',drmsp,vrmsp,grmsp);
disp(out1);	
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
t_string=...
sprintf(' Power Spectral Density  Overall Level = %6.3g GRMS ',grmsp); 
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
setappdata(0,'psd_envelope',power_spectral_density);

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
        output_name=sprintf('envelope_psd_fds_Q%g_b%s',Q(i),sbex);
        output_name2=sprintf('    %s',output_name);
        disp(output_name2);
        assignin('base', output_name, fds1);
%
%%%%%%%%%%%
%       
        output_name_ref=sprintf('input_psd_fds_Q%g_b%s',Q(i),sbex);
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
%
    fds_plot_2x2(fig_num,Q,bex,fn,ff,xx,xfds,fds_ref,nmetric,iu)
%
end 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


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


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

npb=get(handles.listbox_nbreak,'Value');
Multiple_PSD_FDS.npb=npb;

ndc=get(handles.listbox_ndc,'Value');
Multiple_PSD_FDS.ndc=ndc;

nfe=get(handles.listbox_nfe,'Value');
Multiple_PSD_FDS.nfe=nfe;

%%%

input_array=get(handles.edit_input_array,'String');
Multiple_PSD_FDS.input_array=input_array;

try
    THM=evalin('base',input_array);
    Multiple_PSD_FDS.THM=THM;    
catch
end

%%%

fmin=str2num(get(handles.edit_fmin,'String'));
Multiple_PSD_FDS.fmin=fmin;
fmax=str2num(get(handles.edit_fmax,'String'));
Multiple_PSD_FDS.fmax=fmax;

T_out=str2num(get(handles.edit_T_out,'String'));
Multiple_PSD_FDS.T_out=T_out;
ntrials=str2num(get(handles.edit_ntrials,'String'));
Multiple_PSD_FDS.ntrials=ntrials;

Q1=str2num(get(handles.edit_Q1,'String'));
Multiple_PSD_FDS.Q1=Q1;
Q2=str2num(get(handles.edit_Q2,'String'));
Multiple_PSD_FDS.Q2=Q2;
Q3=str2num(get(handles.edit_Q3,'String'));
Multiple_PSD_FDS.Q3=Q3;

b1=str2num(get(handles.edit_b1,'String'));
Multiple_PSD_FDS.b1=b1;
b2=str2num(get(handles.edit_b2,'String'));
Multiple_PSD_FDS.b2=b2;

%%%

A=get(handles.uitable_data,'Data');
Multiple_PSD_FDS.A=A;

%%%

% % %
 
structnames = fieldnames(Multiple_PSD_FDS, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
        save(elk, 'Multiple_PSD_FDS');  
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
% Construct a questdlg with four options
choice = questdlg('Save Complete.  Reset Workspace?', ...
    'Options', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
%%        disp([choice ' Reseting'])
%%        pushbutton_reset_Callback(hObject, eventdata, handles)
        appdata = get(0,'ApplicationData');
        fnsx = fieldnames(appdata);
        for ii = 1:numel(fnsx)
            rmappdata(0,fnsx{ii});
        end
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


% --- Executes on selection change in listbox_n_bexc.
function listbox_n_bexc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_n_bexc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_n_bexc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_n_bexc

n=get(handles.listbox_nfe,'Value');

if(n==1)
   set(handles.text_b2,'Visible','off'); 
   set(handles.edit_b2,'Visible','off');    
else
   set(handles.text_b2,'Visible','on'); 
   set(handles.edit_b2,'Visible','on');     
end



% --- Executes during object creation, after setting all properties.
function listbox_n_bexc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_n_bexc (see GCBO)
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


% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found.');
    return; 
end       

setappdata(0,'THM',THM); 
sz=size(THM);
 
headers1={'Duration (sec)'};  
set(handles.uitable_data,'Data',cell(sz(2)-1,1),'ColumnName',headers1); 
 
set(handles.pushbutton_calculate,'Enable','on'); 
 

set(handles.text_uitable,'Visible','on'); 
set(handles.uitable_data,'Visible','on');  
 
 

    
    

 
 
 
 


% --- Executes on selection change in listbox_nfe.
function listbox_nfe_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nfe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nfe contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nfe


n=get(handles.listbox_nfe,'Value');

if(n==1)
   set(handles.text_b2,'Visible','off'); 
   set(handles.edit_b2,'Visible','off');    
else
   set(handles.text_b2,'Visible','on'); 
   set(handles.edit_b2,'Visible','on');     
end




% --- Executes during object creation, after setting all properties.
function listbox_nfe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nfe (see GCBO)
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
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_calculate,'Enable','off');

set(handles.text_uitable,'Visible','off'); 
set(handles.uitable_data,'Visible','off');  


% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ref 1');
 
[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
disp(' ref 2');
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
disp(' ref 3');
 
structnames

 
% struct
 
try
    Multiple_PSD_FDS=evalin('base','Multiple_PSD_FDS');
catch
    warndlg(' evalin failed ');
    return;
end
 
 
% struct
 
try
    npb=Multiple_PSD_FDS.npb;
    set(handles.listbox_nbreak,'Value',npb);
catch
end

try
    ndc=Multiple_PSD_FDS.ndc;
    set(handles.listbox_ndc,'Value',ndc);    
catch
end

try
    nfe=Multiple_PSD_FDS.nfe;
    set(handles.listbox_nfe,'Value',nfe);       
catch
end

%%%

try
    fmin=Multiple_PSD_FDS.fmin;
    sss=sprintf('%g',fmin);
    set(handles.edit_fmin,'String',sss);
catch
end  

try
    fmax=Multiple_PSD_FDS.fmax;
    sss=sprintf('%g',fmax);    
    set(handles.edit_fmax,'String',sss);
catch
end  

try
    T_out=Multiple_PSD_FDS.T_out;
    sss=sprintf('%g',T_out);    
    set(handles.edit_T_out,'String',sss);
catch
end  

try
    ntrials=Multiple_PSD_FDS.ntrials;
    sss=sprintf('%d',ntrials);
    set(handles.edit_ntrials,'String',sss);
catch
end  

try
    Q1=Multiple_PSD_FDS.Q1;
    sss=sprintf('%g',Q1);
    set(handles.edit_Q1,'String',sss);
catch
end  

try
    Q2=Multiple_PSD_FDS.Q2;
    sss=sprintf('%g',Q2);
    set(handles.edit_Q2,'String',sss);
catch
end  

try
    Q3=Multiple_PSD_FDS.Q3;
    sss=sprintf('%g',Q3);
    set(handles.edit_Q3,'String',sss);
catch
end  

try
    b1=Multiple_PSD_FDS.b1;
    sss=sprintf('%g',b1);
    set(handles.edit_b1,'String',sss);
catch
end  

try
    b2=Multiple_PSD_FDS.b2;
    sss=sprintf('%g',b2);  
    set(handles.edit_b2,'String',sss);
catch
end    

%%%

try
    input_array=Multiple_PSD_FDS.input_array;
    set(handles.edit_input_array,'String',input_array);    
catch
    warndlg('input_array not found');
end

try
    THM=Multiple_PSD_FDS.THM;
    assignin('base',input_array,THM); 
catch
end

%%%

pushbutton_read_Callback(hObject, eventdata, handles);


listbox_ndc_Callback(hObject, eventdata, handles);
listbox_nfe_Callback(hObject, eventdata, handles);


try
    A=Multiple_PSD_FDS.A;
    set(handles.uitable_data,'Data',A);     
catch
    disp('set unsuccessful')
end    
    





% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)

    data=getappdata(0,'psd_envelope');

    output_name=get(handles.edit_output_array,'String');
    assignin('base', output_name, data);

    h = msgbox('Save Complete'); 
end
