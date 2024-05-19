function varargout = vibrationdata_envelope_fds_batch(varargin)
% VIBRATIONDATA_ENVELOPE_FDS_BATCH MATLAB code for vibrationdata_envelope_fds_batch.fig
%      VIBRATIONDATA_ENVELOPE_FDS_BATCH, by itself, creates a new VIBRATIONDATA_ENVELOPE_FDS_BATCH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ENVELOPE_FDS_BATCH returns the handle to a new VIBRATIONDATA_ENVELOPE_FDS_BATCH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ENVELOPE_FDS_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ENVELOPE_FDS_BATCH.M with the given input arguments.
%
%      VIBRATIONDATA_ENVELOPE_FDS_BATCH('Property','Value',...) creates a new VIBRATIONDATA_ENVELOPE_FDS_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_envelope_fds_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_envelope_fds_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_envelope_fds_batch

% Last Modified by GUIDE v2.5 03-Jul-2017 11:24:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_envelope_fds_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_envelope_fds_batch_OutputFcn, ...
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


% --- Executes just before vibrationdata_envelope_fds_batch is made visible.
function vibrationdata_envelope_fds_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_envelope_fds_batch (see VARARGIN)

% Choose default command line output for vibrationdata_envelope_fds_batch
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');
set(handles.pushbutton_rescale,'Visible','off');
set(handles.pushbutton_vd_psds,'Visible','off');


set(handles.listbox_nbreak,'Value',1);

       iu=getappdata(0,'iu');
       im=getappdata(0,'fds_metric');
        Q=getappdata(0,'Q');
      bex=getappdata(0,'bex');
total_fds=getappdata(0,'total_fds');
     fmin=getappdata(0,'fmin');
     fmax=getappdata(0,'fmax');


try
        set(handles.listbox_units,'Value',iu);
end
try
        set(handles.listbox_metric,'Value',im);
end
try
        sfmax=sprintf('%g',fmax);
        sfmin=sprintf('%g',fmin);
    
        set(handles.edit_fmax,'String',sfmax);
        set(handles.edit_fmin,'String',sfmin);        
end

try

    n_damp=length(Q);
    n_bex=length(bex);

    nrows=n_damp*n_bex;
    setappdata(0,'nrows',nrows);
    
    ijk=1;
    
    for i=1:n_damp
    
        for j=1:n_bex
    
            data{ijk,1}=total_fds{i};
            data{ijk,2}=sprintf('%g',Q(i));
            data{ijk,3}=sprintf('%g',bex(j));
            ijk=ijk+1;
        
        end

    end

    set(handles.uitable1,'Data',data);

end

% et(handles.uitable1,'Data',{'hello';'world'})


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_envelope_fds_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_envelope_fds_batch_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_envelope_fds_batch);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp(' * * * * * * * * * * ');
disp('  ');

fig_num=1;

iu=get(handles.listbox_units,'Value');


A=char(get(handles.uitable1,'Data'));

sz=size(A);

ncols=3;
nrows=sz(1)/ncols;

N=nrows;

FDS_array=A(1:N,:);
Q=str2num(A(N+1:2*N,:));
bex=str2num(A(2*N+1:3*N,:));




QQ=unique(Q);
bbex=unique(bex);

n_bex=length(bbex);
n_damp=length(QQ);

nQQ=length(QQ);
   
damp=zeros(nQQ,1);

for i=1:nQQ
    
    damp(i)=1/(2*QQ(i));
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


FDSM=evalin('base',FDS_array(1,:));

fn=FDSM(:,1);
n_ref=length(fn);



fds_ref=zeros(n_damp,n_bex,n_ref);

ijk=1;


for i=1:n_damp
    for j=1:n_bex

        
        FDS_array(ijk,:)
        FDSM=evalin('base',FDS_array(ijk,:));
        
        for k=1:n_ref
            fds_ref(i,j,k)=FDSM(k,2);
        end
        
        ijk=ijk+1;
        
    end
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
ntrials=str2num(get(handles.edit_ntrials,'String'));
 
out1=sprintf('\n ntrials=%d \n',ntrials);
disp(out1);

 
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
    nbreak=length(fn);    
end 

 
fmin=str2num(get(handles.edit_fmin,'String'));
f1=fmin;
 
fmax=str2num(get(handles.edit_fmax,'String'));
f2=fmax;
 
foct=log(f2/f1)/log(2);

oct=1/24;
 
while(foct<oct)
    nbreak=nbreak-1;
    if(nbreak<=2)
        nbreak=2;
        break;
    end
end

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

T_out=str2num(get(handles.edit_T_out,'String'));

setappdata(0,'T_out',T_out);

iu=get(handles.listbox_units,'Value');
 
%%%%%%%%%%%%%%

dscale=str2num(get(handles.edit_dscale,'String'));
  
if(dscale ~=1)
    fds_ref=fds_ref*dscale;
end

%%%%%%%%%%%%%%
 
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

dscale=str2num(get(handles.edit_dscale,'String'));

if(dscale ~=1)
    fds_ref=fds_ref*dscale;
end

%%%%%%%%%%%%%%
 
drmsp=0;
vrmsp=0;
grmsp=0;


initial=2;
final=2;
 
disp(' ');
disp(' Generate sample PSDs');
disp(' ');

nmetric=get(handles.listbox_metric,'Value');

%
for ik=1:ntrials
%      
    if(rand()>0.5 || ik<20 || npb==7)
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

    [apsd_sam,grms,vrms,drms]=...
    env_fds_batch_interpolated_scale(f_sam,apsd_sam,nbreak,n_ref,fn,iu,damp,bex,T_out,nmetric,fds_ref);

%    
    [iflag,record]=env_checklow(grms,vrms,drms,grmslow,vrmslow,drmslow,record,goal);
%       

    if( length(unique(f_sam))==nbreak ) 
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
    end
%
    out1=sprintf('   Trial: drms=%10.4g  vrms=%10.4g  grms=%10.4g ',drms,vrms,grms); 
    out2=sprintf('  Record: drms=%10.4g  vrms=%10.4g  grms=%10.4g \n',drmsp,vrmsp,grmsp); 
    disp(out1);
    disp(out2);
%
end

disp('  ');
disp(' ref 1 ');
disp('  ');

for i=1:length(xf)
    out1=sprintf(' %7.4g  %7.4g ',xf(i),xapsd(i));
    disp(out1);
end
disp(' ');


[power_spectral_density,grms,xfds]=...
    envelope_fds_post_interpolation(nbreak,xf,xapsd,fn,n_ref,damp,bex,T_out,iu,nmetric,f_sam);


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[fig_num,fds1,fds2]=...
    env_fds_batch_plots(iu,grms,T_out,fig_num,damp,bex,bbex,n_ref,xfds,fds_ref,...
                        fn,nmetric,power_spectral_density,fmin,fmax,Q,QQ);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
setappdata(0,'psd_fds',fds1);
setappdata(0,'th_fds',fds2);
 
disp(' ');
disp(' The fatigue damage spectra is calculated from the amplitude (peak-valley)/2 ');
 
setappdata(0,'power_spectral_density',power_spectral_density); 

set(handles.uipanel_save,'Visible','on');

set(handles.pushbutton_rescale,'Visible','on');

setappdata(0,'fig_num',fig_num);

[power_spectral_density,grms,xfds]=...
    envelope_fds_post_interpolation(nbreak,xf,xapsd,fn,n_ref,damp,bex,T_out,iu,nmetric,f_sam);


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[fig_num,fds1,fds2]=...
    env_fds_batch_plots(iu,grms,T_out,fig_num,damp,bex,bbex,n_ref,xfds,fds_ref,...
                        fn,nmetric,power_spectral_density,fmin,fmax,Q,QQ);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
setappdata(0,'psd_fds',fds1);
setappdata(0,'th_fds',fds2);
setappdata(0,'damp',damp);
setappdata(0,'fn',fn);
setappdata(0,'nbreak',nbreak);
setappdata(0,'n_ref',n_ref);
setappdata(0,'iu',iu);
setappdata(0,'bex',bex);
setappdata(0,'bbex',bbex);
setappdata(0,'nmetric',nmetric);
setappdata(0,'fds_ref',fds_ref);
setappdata(0,'Q',Q);
setappdata(0,'QQ',QQ);


 
disp(' ');
disp(' The fatigue damage spectra is calculated from the amplitude (peak-valley)/2 ');
 
setappdata(0,'power_spectral_density',power_spectral_density); 

set(handles.uipanel_save,'Visible','on');

set(handles.pushbutton_rescale,'Visible','on');
set(handles.pushbutton_vd_psds,'Visible','on');





setappdata(0,'fig_num',fig_num);
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
set(handles.uipanel_save,'Visible','off');
set(handles.pushbutton_rescale,'Visible','off');
set(handles.pushbutton_vd_psds,'Visible','off');

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
set(handles.uipanel_save,'Visible','off');
set(handles.pushbutton_rescale,'Visible','off');
set(handles.pushbutton_vd_psds,'Visible','off');

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


% --- Executes on key press with focus on edit_ntrials and none of its controls.
function edit_ntrials_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');
set(handles.pushbutton_rescale,'Visible','off');
set(handles.pushbutton_vd_psds,'Visible','off');

% --- Executes on key press with focus on edit_T_out and none of its controls.
function edit_T_out_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_T_out (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');
set(handles.pushbutton_rescale,'Visible','off');
set(handles.pushbutton_vd_psds,'Visible','off');

% --- Executes on button press in pushbutton_rescale.
function pushbutton_rescale_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rescale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;


fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));


bex=getappdata(0,'bex');
bbex=getappdata(0,'bbex');
damp=getappdata(0,'damp');
fn=getappdata(0,'fn');
nbreak=getappdata(0,'nbreak');
n_ref=getappdata(0,'n_ref');
iu=getappdata(0,'iu');
data=getappdata(0,'power_spectral_density');
nmetric=getappdata(0,'nmetric');
fds_ref=getappdata(0,'fds_ref');
Q=getappdata(0,'Q');
QQ=getappdata(0,'QQ');


x = inputdlg('Enter new PSD duration (sec):');

sss=x{1};

x=str2num(sss);

if(x>=0.01 && x<1.e+10)

    set(handles.edit_T_out,'String',sss);

else
    
    warndlg('New time is invalid');
    return;
    
end

T_out=x;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f_sam=data(:,1);
apsd_sam=data(:,2);


[apsd_sam,grms,vrms,drms]=...
env_fds_batch_interpolated_scale(f_sam,apsd_sam,nbreak,n_ref,fn,iu,damp,bex,T_out,nmetric,fds_ref);


xf=f_sam;
xapsd=apsd_sam;


[power_spectral_density,grms,xfds]=...
    envelope_fds_post_interpolation(nbreak,xf,xapsd,fn,n_ref,damp,bex,T_out,iu,nmetric,f_sam);


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[fig_num,fds1,fds2]=...
    env_fds_batch_plots(iu,grms,T_out,fig_num,damp,bex,bbex,n_ref,xfds,fds_ref,...
                        fn,nmetric,power_spectral_density,fmin,fmax,Q,QQ);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
setappdata(0,'psd_fds',fds1);
setappdata(0,'th_fds',fds2);
 
disp(' ');
disp(' The fatigue damage spectra is calculated from the amplitude (peak-valley)/2 ');
 
setappdata(0,'power_spectral_density',power_spectral_density); 

set(handles.uipanel_save,'Visible','on');

set(handles.pushbutton_rescale,'Visible','on');

setappdata(0,'fig_num',fig_num);

xf=power_spectral_density(:,1);
xapsd=power_spectral_density(:,2);

[power_spectral_density,grms,xfds]=...
    envelope_fds_post_interpolation(nbreak,xf,xapsd,fn,n_ref,damp,bex,T_out,iu,nmetric,f_sam);


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[fig_num,fds1,fds2]=...
    env_fds_batch_plots(iu,grms,T_out,fig_num,damp,bex,bbex,n_ref,xfds,fds_ref,...
                        fn,nmetric,power_spectral_density,fmin,fmax,Q,QQ);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
setappdata(0,'psd_fds',fds1);
setappdata(0,'th_fds',fds2);
 
disp(' ');
disp(' The fatigue damage spectra is calculated from the amplitude (peak-valley)/2 ');
 
setappdata(0,'power_spectral_density',power_spectral_density); 

set(handles.uipanel_save,'Visible','on');

%


% --- Executes on button press in pushbutton_vd_psds.
function pushbutton_vd_psds_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_vd_psds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_psd_rms;  
set(handles.s,'Visible','on');       
