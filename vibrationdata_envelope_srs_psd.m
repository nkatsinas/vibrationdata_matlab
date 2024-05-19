function varargout = vibrationdata_envelope_srs_psd(varargin)
% VIBRATIONDATA_ENVELOPE_SRS_PSD MATLAB code for vibrationdata_envelope_srs_psd.fig
%      VIBRATIONDATA_ENVELOPE_SRS_PSD, by itself, creates a new VIBRATIONDATA_ENVELOPE_SRS_PSD or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ENVELOPE_SRS_PSD returns the handle to a new VIBRATIONDATA_ENVELOPE_SRS_PSD or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ENVELOPE_SRS_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ENVELOPE_SRS_PSD.M with the given input arguments.
%
%      VIBRATIONDATA_ENVELOPE_SRS_PSD('Property','Value',...) creates a new VIBRATIONDATA_ENVELOPE_SRS_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_envelope_srs_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_envelope_srs_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_envelope_srs_psd

% Last Modified by GUIDE v2.5 19-Feb-2018 10:58:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_envelope_srs_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_envelope_srs_psd_OutputFcn, ...
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


% --- Executes just before vibrationdata_envelope_srs_psd is made visible.
function vibrationdata_envelope_srs_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_envelope_srs_psd (see VARARGIN)

% Choose default command line output for vibrationdata_envelope_srs_psd
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

listbox_goal_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_envelope_srs_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_envelope_srs_psd_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_envelope_srs_psd);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    FS=get(handles.edit_input_array_name,'String');
    SRS=evalin('base',FS);  
catch
    warndlg('Input Array does not exist.  Try again.')
    return;
end

rng(4);

fig_num=1;

ngoal=get(handles.listbox_goal,'Value');

dur=1;
if(ngoal==2)
    dur=str2num(get(handles.edit_duration,'String'));
end

Q=str2num(get(handles.edit_Q,'String'));

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

nt=str2num(get(handles.edit_nt,'String'));
ntrials=nt;

set(handles.uipanel_save,'Visible','on');

%%

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
    nbreak=6;    
end
if(npb==10)
    nbreak=7;    
end
if(npb==11)
    nbreak=8;    
end


%%

ioct=4;

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

%%

f1=fmin;
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


ppp=[SRS(:,1) SRS(:,2)];

t_string='Shock Response Spectrum Q=10';
x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';
                 
md=5;                 
                 
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);             

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

record = 1.0e+90;
grmslow=1.0e+50;
vrmslow=1.0e+50;
drmslow=1.0e+50;

goal=3;

%
fn=zeros(nbreak,1);
xf=zeros(nbreak,1);
xapsd=zeros(nbreak,1);
%

slopec=12;
slopec=(slopec/10.)/log10(2.);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

% Interpolate the reference SRS

sz=size(SRS);

num_srs=sz(1);

f=SRS(:,1);
a=SRS(:,2);

s=zeros(num_srs-1,1);

for i=1:(num_srs-1)
        s(i)=log(  a(i+1) / a(i)  )/log( f(i+1) / f(i) );
end    

srs_ref=zeros(n_ref,1);

for i=1:n_ref
   
    srs_ref(i)=1e-10;

   for j=1:(num_srs-1)
       if(fn(i)>=f(j) && fn(i)<=f(j+1))
			srs_ref(i)=a(j)*( ( fn(i) / f(j) )^ s(j) ); 
            break;
       end
   end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initial=2;
final=2;

error_max=1.0e+90;

%
for ik=1:ntrials
%	   
    if(rand()>0.3 || ik<20)
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
       [~,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,fn);  
%
%      Calculate the peak vrs of the sample psd
%
       [vrs_samfine_grms,vrs_samfine_peak]=...
                         vibrationdata_vrs_sample(fn,apsd_samfine,Q,dur);
                     
       if(ngoal==1)  % 3-sigma
           vrs_samfine_amp=3*vrs_samfine_grms;           
       else
           vrs_samfine_amp=vrs_samfine_peak;
       end    
                     
%    
%      Compare the sample peak vrs with the reference srs
%
        scale=0.;
%
        for i=1:n_ref 
		    if( vrs_samfine_amp(i) < 1.0e-30)
			    out1=sprintf('\n Error:  vrs_samfine(%ld])=%10.4g ',i,vrs_samfine_amp(i));
                disp(out1);
                warndlg('Error:  see Command Window');
			    return;
            end
            if(  (srs_ref(i)/vrs_samfine_amp(i)) > scale )
			    scale=(srs_ref(i)/vrs_samfine_amp(i));
            end
        end
%
%      scale the psd
    vrs_samfine_amp=vrs_samfine_amp*scale;
    
    
    scale=(scale^2.);
    apsd_sam=apsd_sam*scale;
%
    error=0;
%
    for i=1:n_ref 
        dB=20*log10( vrs_samfine_amp(i) / srs_ref(i));
        
        if(  dB > error )
                error=dB;
        end
    end
%
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
    if(iflag==1 && (error<error_max || error < 3))      
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
        xapsdfine=apsd_samfine*scale;
%
        if(error<error_max)
            error_max=error;
        end
%
    end
%
    out1=sprintf('   Trial: drms=%8.4g  vrms=%8.4g  grms=%8.4g error=%8.4g ',drms,vrms,grms,error); 
    out2=sprintf('  Record: drms=%8.4g  vrms=%8.4g  grms=%8.4g error=%8.4g \n',drmsp,vrmsp,grmsp,error_max); 
    disp(out1);
    disp(out2);
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%       
% Interpolate the best psd
%
    [grms]=env_grms_sam(nbreak,xf,xapsd);
%
    [vrms]=env_vrms_sam(nbreak,xf,xapsd);
%
    [drms]=env_drms_sam(nbreak,xf,xapsd);
%
fn=fix_size(fn);
xf=fix_size(xf);
xapsd=fix_size(xapsd);
xapsdfine=fix_size(xapsdfine);

%            
power_spectral_density=[xf xapsd];

%      Calculate vrs
[vrs_grms,vrs_peak]=vibrationdata_vrs_sample(fn,xapsdfine,Q,dur);

vrs_peak=fix_size(vrs_peak);
vrs_grms=fix_size(vrs_grms);

vrs_peak=[fn vrs_peak];
vrs_three_sigma=[fn 3*vrs_grms];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
ylab='Accel (G^2/Hz)';
x_label=sprintf(' Frequency (Hz)');
[fig_num]=plot_PSD_function(fig_num,x_label,ylab,t_string,power_spectral_density,fmin,fmax);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

md=5;

ppp1=SRS;
leg1='SRS';

if(ngoal==1)
    ppp2=vrs_three_sigma;
    leg2='VRS 3-sigma';
    setappdata(0,'vrs_three_sigma',vrs_three_sigma);    
else
    ppp2=vrs_peak;
    leg2='VRS Peak';    
    setappdata(0,'vrs_peak',vrs_peak);       
end


x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';

t_string=sprintf('Peak Response Comparison  Q=%g',Q);


[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'power_spectral_density',power_spectral_density);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_type,'Value');
output_name=get(handles.edit_output_array_name,'String');

ngoal=get(handles.listbox_goal,'Value');

if(n==1)
    data=getappdata(0,'power_spectral_density');
else
    if(ngoal==1)
        data=getappdata(0,'vrs_peak');
    else
        data=getappdata(0,'vrs_three_sigma');        
    end
end    

assignin('base', output_name, data);

h = msgbox('Save Complete'); 



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_fmin and none of its controls.
function edit_fmin_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_fmax and none of its controls.
function edit_fmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');



function edit_nt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nt as text
%        str2double(get(hObject,'String')) returns contents of edit_nt as a double


% --- Executes during object creation, after setting all properties.
function edit_nt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nt (see GCBO)
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


% --- Executes on selection change in listbox_goal.
function listbox_goal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_goal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_goal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_goal

set(handles.listbox_output_type, 'String', '');
string_th{1}=sprintf('PSD');

ngoal=get(handles.listbox_goal,'Value');

if(ngoal==1)  % 3-sigma
    set(handles.edit_duration,'Visible','off');
    set(handles.text_duration,'Visible','off');   
    string_th{2}=sprintf('VRS 3-sigma');      
else
    set(handles.edit_duration,'Visible','on');
    set(handles.text_duration,'Visible','on');
    string_th{2}=sprintf('VRS Peak');      
end

set(handles.listbox_output_type,'String',string_th)   



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
