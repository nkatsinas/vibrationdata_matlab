function varargout = response_PSD_plus_min_workmanship_PSD(varargin)
% RESPONSE_PSD_PLUS_MIN_WORKMANSHIP_PSD MATLAB code for response_PSD_plus_min_workmanship_PSD.fig
%      RESPONSE_PSD_PLUS_MIN_WORKMANSHIP_PSD, by itself, creates a new RESPONSE_PSD_PLUS_MIN_WORKMANSHIP_PSD or raises the existing
%      singleton*.
%
%      H = RESPONSE_PSD_PLUS_MIN_WORKMANSHIP_PSD returns the handle to a new RESPONSE_PSD_PLUS_MIN_WORKMANSHIP_PSD or the handle to
%      the existing singleton*.
%
%      RESPONSE_PSD_PLUS_MIN_WORKMANSHIP_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSE_PSD_PLUS_MIN_WORKMANSHIP_PSD.M with the given input arguments.
%
%      RESPONSE_PSD_PLUS_MIN_WORKMANSHIP_PSD('Property','Value',...) creates a new RESPONSE_PSD_PLUS_MIN_WORKMANSHIP_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before response_PSD_plus_min_workmanship_PSD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to response_PSD_plus_min_workmanship_PSD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help response_PSD_plus_min_workmanship_PSD

% Last Modified by GUIDE v2.5 11-Mar-2019 17:23:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @response_PSD_plus_min_workmanship_PSD_OpeningFcn, ...
                   'gui_OutputFcn',  @response_PSD_plus_min_workmanship_PSD_OutputFcn, ...
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


% --- Executes just before response_PSD_plus_min_workmanship_PSD is made visible.
function response_PSD_plus_min_workmanship_PSD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to response_PSD_plus_min_workmanship_PSD (see VARARGIN)

% Choose default command line output for response_PSD_plus_min_workmanship_PSD
handles.output = hObject;


set(handles.listbox_interpolate,'Value',1);

set(handles.pushbutton_calculate,'Enable','on');


set(handles.text_envelope_PSD,'Visible','on');
set(handles.edit_envelope_psd_name,'Visible','on');
set(handles.pushbutton_save_envelope_psd,'Visible','on');


listbox_ATP_Callback(hObject, eventdata, handles);
set(handles.uipanel_save,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes response_PSD_plus_min_workmanship_PSD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = response_PSD_plus_min_workmanship_PSD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save_ATP.
function pushbutton_save_ATP_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_ATP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'best_psd');
    
output_name=get(handles.edit_ATP_name,'String');
assignin('base', output_name, data);

msgbox('Save Complete'); 


function edit_ATP_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ATP_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ATP_name as text
%        str2double(get(hObject,'String')) returns contents of edit_ATP_name as a double


% --- Executes during object creation, after setting all properties.
function edit_ATP_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ATP_name (see GCBO)
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

clear_results(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','off');

n=get(hObject,'Value');

set(handles.edit_ATP_name,'Enable','off');

set(handles.pushbutton_save_ATP,'Enable','off');

set(handles.edit_input_array_name,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array_name,'Visible','on');

if(n==1)
   set(handles.edit_input_array_name,'enable','on') 
else
   set(handles.edit_input_array_name,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array_name,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
   
   set(handles.pushbutton_calculate,'Enable','on');
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


setappdata(0,'fig_num',1);


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

work=[20           0.0053
150         0.04
800         0.04
2000       0.0064];

try
    FS=strtrim(get(handles.edit_input_array_name,'String'));
    THM=evalin('base',FS); 
catch
    warndlg('Input Array not found');
    return;
end


if(THM(:,1)<1.0e-20)
    THM(1,:)=[];
end

fmin=min([ THM(1,1) work(1,1)  ]);
fmax=max([ THM(end,1) work(end,1)  ]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[s,input_rms] = calculate_PSD_slopes(THM(:,1),THM(:,2));

[sw,input_rms_w] = calculate_PSD_slopes(work(:,1),work(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=THM(:,1);
a=THM(:,2);

ni=get(handles.listbox_interpolate,'Value');

df=0.5;

if(ni==1)
    [fi,ai]=interpolate_PSD(f,a,s,df);
else
    [fi,ai]=linear_interpolation(f,a,df);
end
    
fi=fix_size(fi);
ai=fix_size(ai);

fw=work(:,1);
aw=work(:,2);

[fwi,awi]=interpolate_PSD(fw,aw,sw,df);

setappdata(0,'response_psd_int',[fi,ai]);
setappdata(0,'work_psd_int',[fwi,awi]);

%             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;
%
accel_response_psd=[fi ai];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

leg_a=sprintf('Response %5.3g GRMS',input_rms);
leg_b=sprintf('Workmanship %5.3g GRMS',input_rms_w);   

ppp=accel_response_psd;
qqq=work;

peak=max([ max(ppp(:,2)) max(qqq(:,2)) ]);

y_label=sprintf('Accel (G^2/Hz)');
x_label=sprintf('Frequency (Hz)');

t_string = sprintf('Power Spectral Density');   
%
[fig_num,h]=plot_PSD_two_sdof_ran_f(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b,fmin,fmax); 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freq=fmin;
i=1;

while(1)

    ff(i)=freq;
    aa(i)=0;

    [c1,index1] = min(abs(freq-fi));
    [c2,index2] = min(abs(freq-fwi));
    
    iflag=0;
    jflag=0;
    
    if( abs(fi(index1)-freq)< (df/2))
        iflag=1;
    end
    if( abs(fwi(index2)-freq)< (df/2))
        jflag=1;
    end    

    if(iflag==1 && jflag==0)
        aa(i)=accel_response_psd(index1,2);
    end
    if(iflag==0 && jflag==1)  
        aa(i)=awi(index2);    
    end
    if(iflag==1 && jflag==1)
        va=accel_response_psd(index1,2); 
        vb=awi(index2);
        aa(i)=max([ va  vb  ]);
    end    
    
    
    i=i+1;
    freq=freq+df;
    if(freq>fmax)
        break;
    end

end


md=5;

x_label=sprintf(' Frequency (Hz)');
y_label=sprintf(' Accel (G^2/Hz)');

ff=fix_size(ff);
aa=fix_size(aa);

ppp=[ff aa];


[s,erms] = calculate_PSD_slopes(ff,aa);


ppp(:,3)=0;

for i=2:length(ff)-1
    if( abs(s(i)-s(i-1))<0.001)
        ppp(i,3)=1;
    end
end

for i=(length(ff)-1):-1:1
    if(ppp(i,3)==1)
        ppp(i,:)=[];
    end
end

ppp(:,3)=[];


%%%%%%%%%%%%%

ff=ppp(:,1);
aa=ppp(:,2);

for i=2:length(ff)-1
    ratio=(aa(i)-aa(i-1))/aa(i);
    ratio=abs(ratio);
    ratio;
    if( ratio<0.04)
        qq=max([ aa(i) aa(i-1) ]);
        aa(i)=qq;
        aa(i-1)=qq;
    end
end


ppp=[ff aa];


[s,erms] = calculate_PSD_slopes(ff,aa);


ppp(:,3)=0;

for i=2:length(ff)-1
    if( abs(s(i)-s(i-1))<0.001)
        ppp(i,3)=1;
    end
end

for i=(length(ff)-1):-1:1
    if(ppp(i,3)==1)
        ppp(i,:)=[];
    end
end

ppp(:,3)=[];

%%%%%


t_string=sprintf('Envelope PSD  %5.3g GRMS',erms);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


assignin('base', 'env',ppp);

setappdata(0,'fig_num',fig_num);
setappdata(0,'ppp',ppp);
setappdata(0,'work',work);
setappdata(0,'fmin',fmin);
setappdata(0,'fmax',fmax);
setappdata(0,'erms',erms);
setappdata(0,'peak',peak);

set(handles.uipanel_save,'Visible','on');


natp=get(handles.listbox_ATP,'Value');

if(natp==1)
    ATP_envelope(hObject, eventdata, handles);
end


function ATP_envelope(hObject, eventdata, handles)

fig_num=getappdata(0,'fig_num');
ppp=getappdata(0,'ppp');
work=getappdata(0,'work');

fmin=getappdata(0,'fmin');
fmax=getappdata(0,'fmax');
fn_iso=getappdata(0,'fn');
peak=getappdata(0,'peak');



response_psd_int=getappdata(0,'response_psd_int');
    work_psd_int=getappdata(0,'work_psd_int');

       fi=response_psd_int(:,1);
       ai=response_psd_int(:,2);      
       fwi=work_psd_int(:,1);
       awi=work_psd_int(:,2);  

Q=str2num(get(handles.edit_Q,'String'));

damp=1/(2*Q);

%%%

THM=ppp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initial=2;
final=2;

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

n=length(THM(:,1));

if(THM(:,1)<1.0e-20)
    THM(1,:)=[];
end


sminf=get(handles.edit_fmin,'String');
smaxf=get(handles.edit_fmax,'String');

if isempty(sminf)
    string=sprintf('%8.4g',THM(1,1));
    set(handles.edit_fmin,'String',string);
end

if isempty(smaxf)
    string=sprintf('%8.4g',THM(n,1));    
    set(handles.edit_fmax,'String',string);
end

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

f1=fmin;
f2=fmax;


%%%%%%%%%%

Q=str2num(get(handles.edit_Q,'String'));

dam=1/(2*Q);
%
MAX=20000;
MAX2=100000;

% nbreak   number of breakpoints
% ntrials  number of trails
% ntrials2
% n_ref    number of reference coordinates
%
record = 1.0e+90;
grmslow=1.0e+50;
vrmslow=1.0e+50;
drmslow=1.0e+50;
%
% f_ref[MAX]    reference natural frequency
% a_ref[MAX]    reference vrs(GRMS)
%
% fin[MAX]      input frequency
% psdin[MAX]    input PSD
% inslope[MAX]  input slope
%
% interp_psdin[MAX] interpolated input PSD
%
% f_sam[MAX]    frequency of sample breakpoint
% apsd_sam[MAX] acceleration PSD amplitude of sample breakpoint
% slope[MAX]
%
% f_samfine[MAX]    frequency of sample breakpoint, interpolated
% apsd_samfine[MAX] acceleration PSD of sample breakpoint, interpolated  
%

goal=3;  % Minimize: acceleration, velocty, displacement

ntrials = floor(str2num(get(handles.edit_ntrials,'String')));

if(ntrials > MAX2)
		disp(' The maximum number of trials is 100,000 ');
		ntrials=MAX2;
end

%%%%  nbreak=4;  % number of breakpoints

f_ref=zeros(nbreak,1);
a_ref=zeros(nbreak,1);   
f_sam=zeros(nbreak,1);
apsd_sam=zeros(nbreak,1);
slope=zeros(nbreak,1);
f_samfine=zeros(nbreak,1);
apsd_samfine=zeros(nbreak,1);
vrs_samfine=zeros(nbreak,1);
xf=zeros(nbreak,1);
xapsd=zeros(nbreak,1);

ic=1;  % constrain slope

slopec = 12.;  % 12 db/octave

slopec=abs(slopec);
slopec=(slopec/10.)/log10(2.);


%
ocn=1./48.;
%
%
octave=-1.+(2.^ocn);
%
%
 ffmin=f1;
 ffmax=f2;
 %
 if(ffmax<=1000)
     ffmax=1000;
 end
  if(ffmax>1000 && ffmax<=2000)
     ffmax=2000;
  end
% 
%
  fin=THM(:,1);
psdin=THM(:,2);
%
ierror=0;
%
if( min(psdin) <= 0. )
               disp(' Input error:  each PSD amplitude must be > 0.');
               ierror = 999;
end               
%
if( min(fin) < 0. )
               disp(' Input error:  each frequency must be > 0.');
               ierror = 999;
end               
%
if(fin(1)<1.0e-04)
    fin(1)=1.0e-04;
end
%
clear length;
nin = length(fin);
%
inslope=zeros((nin-1),1);
%
for i=2:nin
    inslope(i-1)= log(psdin(i)/psdin(i-1))/log(fin(i)/fin(i-1));
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[s,grms_input]= calculate_PSD_slopes(fin,psdin);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('\n Number of input coordinates = %ld ',nin);
disp(out1);
%
% Interpolate Input PSD
%
if( f1 < fin(1) ) 
        f1 = fin(1); 
end
%
%% if( f2 > fin(nin) )
%%         f2 = fin(nin); 
%% end
%
f_ref=zeros(MAX,1);
%
f_ref(1)=f1;
%
for i=2:MAX
%   
    f_ref(i)=f_ref(i-1)*(2.^ocn);
%
    if(  f_ref(i) >= f2 )
        f_ref(i)=f2;
        n_ref=i;
        break;
    end    
%   
end
%
fn=f_ref;
%
clear temp;
temp=f_ref(1:n_ref);
clear f_ref;
f_ref=temp;
clear temp;
%
out1=sprintf(' n_ref=%ld \n',n_ref);
disp(out1);
%
interp_psdin(1)=psdin(1);
%
    for i=2:n_ref
        for j=1:nin-1
%            
           if( f_ref(i) >= fin(j) && f_ref(i) <= fin(j+1) )   
                 interp_psdin(i)= psdin(j)*((f_ref(i)/fin(j))^inslope(j));
           end
%           
        end
    end
%
szf=size(f_ref);
if(szf(2)>szf(1))
    f_ref=f_ref';
end
%
szp=size(interp_psdin);
if(szp(2)>szp(1))
    interp_psdin=interp_psdin';
end
%
clear length;
n_ref=min([length(f_ref) length(interp_psdin)]);
%
clear temp;
temp=f_ref;
clear f_ref;
f_ref=temp(1:n_ref);
%
clear temp;
temp=interp_psdin;
clear interp_psdin;
interp_psdin=temp(1:n_ref);
clear temp;
%
interpolated_PSD=[f_ref interp_psdin];
%
% Convert the input PSD to a VRS
%
    [a_ref]=env_make_input_vrs(interp_psdin,n_ref,f_ref,octave,dam);
%
    sz=size(a_ref);
    if(sz(2)>sz(1))
        a_ref=a_ref';
    end
    input_vrs=[f_ref a_ref];
%
    progressbar;

    for ik=1:ntrials
        
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
       
       if(npb==5 || npb==8) 
            if(rand()>0.9 && ik>50)
                apsd_sam(end-1)=work(end-1,2);
                apsd_sam(end)=work(end,2);
                f_sam(end-1)=work(end-1,1);
                f_sam(end)=work(end,1);                
            end
       end
       
       
%%
%
%      Interpolate the sample psd
       [f_samfine,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,f_ref);
%      
       if(npb==5 || npb==8)
           
           while(1)
               
 
               %      Interpolate the sample psd
                [f_samfine,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,f_ref);
 %      Calculate the vrs of the sample psd
                [vrs_samfine]=env_vrs_sample(n_ref,f_ref,octave,dam,apsd_samfine);
              
               %      Compare the sample vrs with the reference vrs
                [scale]=env_compare_rms(n_ref,a_ref,vrs_samfine);
%
%      scale the psd
                scale=(scale^2.);
                apsd_sam=apsd_sam*scale;
       
                [c,index] = min(abs(f_sam-work(1,1)));
       
                if(apsd_sam(index)<work(1,2))
                    apsd_sam(index)=work(1,2);
                end
       
                [c,index] = min(abs(f_sam-work(end,1)));

                
                if(apsd_sam(end)<work(end,2))
                    apsd_sam(end)=work(end,2);
                end
                
                if(scale>0.995 && scale<1.005)
                    break;
                end
        
           end
           
       else    

%      Calculate the vrs of the sample psd
            [vrs_samfine]=env_vrs_sample(n_ref,f_ref,octave,dam,apsd_samfine);
%    
%      Compare the sample vrs with the reference vrs
            [scale]=env_compare_rms(n_ref,a_ref,vrs_samfine);
%
%      scale the psd
            scale=(scale^2.);
            apsd_sam=apsd_sam*scale;
       
            [c,index] = min(abs(f_sam-work(1,1)));
       
            if(apsd_sam(index)<work(1,2))
                apsd_sam(index)=work(1,2);
            end
       
            [c,index] = min(abs(f_sam-work(end,1)));
       
            if(apsd_sam(index)<work(end,2))
                apsd_sam(index)=work(end,2);
            end
       
       end
      
%%%
%
%   scale interpolated PSD
%
       ss=1; 
       df=0.5;  
       [fi,ai]=interpolate_PSD(f_sam,apsd_sam,ss,df);

       
       L1=length(fwi);
       L2=length(fi);
       
       L=min([L1 L2]);
       
       sc=zeros(L,1);
          
       for i=1:L
           [~,j] = min(abs(fwi-fi(i)));
           sc(i)=ai(i)/awi(j);
       end 
       
       scale=min(sc);
       if(scale<1)
           apsd_sam=apsd_sam/scale;
       end
      

%%%
       
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
           ikbest=ik;
%          
           nnn=ntrials;
%
           xf=f_sam;
           xapsd=apsd_sam;             
%
           xslope=slope;
%       
% Interpolate the best psd
%
          sz=size(f_ref);
          if(sz(2)>sz(1))
             f_ref=f_ref';
          end 
%         
          [xapsdfine]=env_interp_best(nbreak,n_ref,xf,xapsd,f_ref);
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
          best_psd=[xf xapsd];
%
% Calculate the vrs of the best vrs
%
          [xvrs]=env_vrs_best(n_ref,dam,octave,xapsdfine,f_ref);          
%
          sz=size(xvrs);
          if(sz(2)>sz(1))
             xvrs=xvrs';
          end
%
          best_vrs=[f_ref xvrs];
%
              f_sam=xf;
           apsd_sam=xapsd;
                     
          out2=sprintf('  %d: drms=%10.4g  vrms=%10.4g  grms=%10.4g ',ik,drmsp,vrmsp,grmsp);
          disp(out2);
%           
       end      
%     
%%         out1=sprintf('   Trial: drms=%10.4g  vrms=%10.4g  grms=%10.4g ',drms,vrms,grms); 
%%         out2=sprintf('  Record: drms=%10.4g  vrms=%10.4g  grms=%10.4g \n',drmsp,vrmsp,grmsp); 
%%         disp(out1);
%%         disp(out2);
%
    end
    
    disp(' ');
    
    progressbar(1);
    
%
    nnn=0;
%
    disp('________________________________________________________________________');
%
    f_sam=xf;
    apsd_sam=xapsd;    
%
    disp('Optimum Case');
    disp(' ');
%
    out1=sprintf(' drms=%10.4g  vrms=%10.4g  grms=%10.4g ',drmsp,vrmsp,grmsp);
    disp(out1); 
%   
    disp('________________________________________________________________________');
%
%%    disp(' ');
%%    disp('         Input VRS written to file:  input_vrs ');
%%    disp('       Optimum PSD written to file:  best_psd ');
%%    disp('       Optimum VRS written to file:  best_vrs ');
 %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %
 setappdata(0,'PSD',best_psd);
 %
 fig_num=1;
 md=6;
 x_label='Frequency(Hz)';
 y_label='Accel (G^2/Hz)';
 
ppp1=[fin psdin];
ppp2=best_psd;
t_string='Power Spectral Density';
leg1=sprintf('Input, %6.3g GRMS',grms_input);
leg2=sprintf('Envelope, %6.3g GRMS',grmsp);
 
[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
 
 %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % 
 ppp1=input_vrs;
 ppp2=best_vrs;
 
 t_string=sprintf('Vibration Response Spectra  Q=%g',Q); 
 x_label='Natural Frequency(Hz)';
 y_label='Accel (GRMS)';
 %

  
[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
 
 
%%%%%%%%%%

disp(' ');
disp(' Best PSD ');
disp(' ');
disp(' Freq(Hz)  Accel(G^2/Hz) ')
for i=1:nbreak
    out1=sprintf(' %8.4g  %8.4g ',best_psd(i,1),best_psd(i,2));
    disp(out1);
end

setappdata(0,'best_psd',best_psd);

set(handles.uipanel_save,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(response_PSD_plus_min_workmanship_PSD);


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
   set(handles.pushbutton_calculate,'Enable','on');
   clear_results(hObject, eventdata, handles);


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
clear_results(hObject, eventdata, handles);

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



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double
clear_results(hObject, eventdata, handles);

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


% --- Executes on button press in edit_Q.
function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of edit_Q
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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

function clear_results(hObject, eventdata, handles)
%
set(handles.uipanel_save,'Visible','off');


function edit_dur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur as text
%        str2double(get(hObject,'String')) returns contents of edit_dur as a double
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_interpolate.
function listbox_interpolate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_interpolate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_interpolate
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_interpolate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_dur and none of its controls.
function edit_dur_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_fmin and none of its controls.
function edit_fmin_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_fmax and none of its controls.
function edit_fmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_fatigue.
function pushbutton_fatigue_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fatigue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=response_PSD_relative_damage;

set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_save_type.
function listbox_save_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save_type


% --- Executes during object creation, after setting all properties.
function listbox_save_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Steinberg.
function pushbutton_Steinberg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Steinberg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on selection change in listbox_workmanship.
function listbox_workmanship_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_workmanship (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_workmanship contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_workmanship


% --- Executes during object creation, after setting all properties.
function listbox_workmanship_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_workmanship (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ATP.
function listbox_ATP_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ATP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ATP contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ATP

n=get(handles.listbox_ATP,'Value');

set(handles.text_ATP,'Visible','off');
set(handles.edit_ATP_name,'Visible','off');
set(handles.pushbutton_save_ATP,'Visible','off');

set(handles.text_Q,'Visible','off');
set(handles.edit_Q,'Visible','off');
set(handles.text_ntrials,'Visible','off');
set(handles.edit_ntrials,'Visible','off');

set(handles.listbox_nbreak,'Visible','off');
set(handles.text_nbreak,'Visible','off');

set(handles.text_fmin,'Visible','off');
set(handles.edit_fmin,'Visible','off');
set(handles.text_fmax,'Visible','off');
set(handles.edit_fmax,'Visible','off');
    

if(n==1)

    set(handles.listbox_nbreak,'Visible','on');
    set(handles.text_nbreak,'Visible','on');
    
    set(handles.text_ATP,'Visible','on');
    set(handles.edit_ATP_name,'Visible','on');
    set(handles.pushbutton_save_ATP,'Visible','on');    
    
    set(handles.text_Q,'Visible','on');
    set(handles.edit_Q,'Visible','on');
    set(handles.text_ntrials,'Visible','on');
    set(handles.edit_ntrials,'Visible','on');    
    
    set(handles.text_fmin,'Visible','on');
    set(handles.edit_fmin,'Visible','on');
    set(handles.text_fmax,'Visible','on');
    set(handles.edit_fmax,'Visible','on'); 
    
end



% --- Executes during object creation, after setting all properties.
function listbox_ATP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ATP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_envelope_psd_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_envelope_psd_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_envelope_psd_name as text
%        str2double(get(hObject,'String')) returns contents of edit_envelope_psd_name as a double


% --- Executes during object creation, after setting all properties.
function edit_envelope_psd_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_envelope_psd_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_envelope_psd.
function pushbutton_save_envelope_psd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_envelope_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'ppp');
    
output_name=get(handles.edit_envelope_psd_name,'String');
assignin('base', output_name, data);

msgbox('Save Complete'); 


function edit_power_trans_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_power_trans_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_power_trans_name as text
%        str2double(get(hObject,'String')) returns contents of edit_power_trans_name as a double


% --- Executes during object creation, after setting all properties.
function edit_power_trans_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_power_trans_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_power_trans.
function pushbutton_save_power_trans_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_power_trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'accel_power_trans');
    
output_name=get(handles.edit_power_trans_name,'String');
assignin('base', output_name, data);

msgbox('Save Complete'); 


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


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
