function varargout = vibrationdata_envelope_transmitted_pressure_psd(varargin)
% VIBRATIONDATA_ENVELOPE_TRANSMITTED_PRESSURE_PSD MATLAB code for vibrationdata_envelope_transmitted_pressure_psd.fig
%      VIBRATIONDATA_ENVELOPE_TRANSMITTED_PRESSURE_PSD, by itself, creates a new VIBRATIONDATA_ENVELOPE_TRANSMITTED_PRESSURE_PSD or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ENVELOPE_TRANSMITTED_PRESSURE_PSD returns the handle to a new VIBRATIONDATA_ENVELOPE_TRANSMITTED_PRESSURE_PSD or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ENVELOPE_TRANSMITTED_PRESSURE_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ENVELOPE_TRANSMITTED_PRESSURE_PSD.M with the given input arguments.
%
%      VIBRATIONDATA_ENVELOPE_TRANSMITTED_PRESSURE_PSD('Property','Value',...) creates a new VIBRATIONDATA_ENVELOPE_TRANSMITTED_PRESSURE_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_envelope_transmitted_pressure_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_envelope_transmitted_pressure_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_envelope_transmitted_pressure_psd

% Last Modified by GUIDE v2.5 14-Jul-2021 10:31:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_envelope_transmitted_pressure_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_envelope_transmitted_pressure_psd_OutputFcn, ...
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


% --- Executes just before vibrationdata_envelope_transmitted_pressure_psd is made visible.
function vibrationdata_envelope_transmitted_pressure_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_envelope_transmitted_pressure_psd (see VARARGIN)

% Choose default command line output for vibrationdata_envelope_transmitted_pressure_psd
handles.output = hObject;

set(handles.listbox_method,'Value',1);

set(handles.listbox_nbreak,'Value',1);

listbox_freq_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_envelope_transmitted_pressure_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_envelope_transmitted_pressure_psd_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_envelope_psd);


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

set(handles.pushbutton_calculate,'Enable','off');

n=get(hObject,'Value');

set(handles.edit_output_array,'Enable','off');

set(handles.pushbutton_save,'Enable','off');

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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

initial=2;
final=2;

nfc=get(handles.listbox_freq,'Value');

npb=get(handles.listbox_nbreak,'Value');

[nbreak]=numberb(npb);

FL=zeros(nbreak,1);
FU=zeros(nbreak,1);


if(nfc==1 && nbreak>=3)
    
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    N=nbreak-2;
    
    k=1;

    for i=1:N
        array_name=A(k,:); k=k+1;
        array_name=strtrim(array_name);
        FL(i+1)=str2double(array_name);
    end
    for i=1:N
        array_name=A(k,:); k=k+1;
        array_name=strtrim(array_name);
        FU(i+1)=str2double(array_name);
    end    
    
end



set(handles.pushbutton_save,'Enable','on')

k=get(handles.listbox_method,'Value');
 
if(k==1)
   try  
      FS=get(handles.edit_input_array,'String');
      THM=evalin('base',FS);  
   catch
      warndlg('Input Array does not exist.  Try again.');
      return;
   end  
else
  THM=getappdata(0,'THM');
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

 
[~,ii]=min(abs(THM(:,1)-fmin));
[~,jj]=min(abs(THM(:,1)-fmax));

THM=THM(ii:jj,:);


f1=fmin;
f2=fmax;

FL(1)=fmin;
FU(1)=fmin;
FL(nbreak)=fmax;
FU(nbreak)=fmax;

%%%%%%%%%%

Q=str2num(get(handles.edit_Q,'String'));

dam=1/(2*Q);
%
MAX=20000;


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
% a_ref[MAX]    reference vrs(psi rms)
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

%%%%  nbreak=4;  % number of breakpoints


slope=zeros(nbreak,1);
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
[~,grms_input]= calculate_PSD_slopes(fin,psdin);
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

    nx=ntrials*0.3;
    
    if(nx<4)
        nx=4;
    end

    for ik=1:ntrials
        
        progressbar(ik/ntrials);
%      
       if(rand()>0.7 || ik<nx)
%      
            % Generate the sample psd
            
            qflag=1;
            
            [f_sam,apsd_sam,~,slopec]=...
                env_generate_sample_psd_via_vrs(n_ref,nbreak,npb,f_ref,slopec,initial,final,f1,f2,FL,FU,nfc);
%          
%
        else
%         
            qflag=2;
            
            [f_sam,apsd_sam,~,slopec]=...
                env_generate_sample_psd2_via_vrs(nbreak,npb,xf,xapsd,slopec,f1,f2,FL,FU,nfc);
             
            
 %
       end
%%
%
%      Interpolate the sample psd
       [f_samfine,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,f_ref);
%                         
%      Calculate the vrs of the sample psd
       [vrs_samfine]=env_vrs_sample(n_ref,f_ref,octave,dam,apsd_samfine);
%    
%      Compare the sample vrs with the reference vrs
       [scale]=env_compare_rms(n_ref,a_ref,vrs_samfine);
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
%     
       
        out1=sprintf('   Trial: drms=%10.4g  vrms=%10.4g  grms=%10.4g ',drms,vrms,grms); 
        out2=sprintf('  %d  Record: drms=%10.4g  vrms=%10.4g  grms=%10.4g %d %d',ik,drmsp,vrmsp,grmsp,iflag,qflag); 
 %       disp(out1);
        disp(out2);
        
       end  

%
    end
    
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
 y_label='Pressure (psi^2/Hz)';
 
ppp1=[fin psdin];
ppp2=best_psd;
t_string='Power Spectral Density';
leg1=sprintf('Input, %6.3g psi rms',grms_input);
leg2=sprintf('Envelope, %6.3g psi rms',grmsp);
 
[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
 
 %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % 
 ppp1=input_vrs;
 ppp2=best_vrs;
 
 t_string=sprintf('VRS Transmitted Pressure  Q=%g',Q); 
 x_label='Natural Frequency(Hz)';
 y_label='Pressure (psi rms)';
 %

  
[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
 
 
%%%%%%%%%%

disp(' ');
disp(' Best PSD ');
disp(' ');
disp(' Freq(Hz)  Pressure(G^2/Hz) ')
for i=1:nbreak
    out1=sprintf(' %8.4g \t %8.4g ',best_psd(i,1),best_psd(i,2));
    disp(out1);
end




% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'PSD');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 





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


% --- Executes on selection change in listbox_etype.
function listbox_etype_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_etype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_etype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_etype


% --- Executes during object creation, after setting all properties.
function listbox_etype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_etype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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
listbox_freq_Callback(hObject, eventdata, handles);

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


% --- Executes on selection change in listbox_freq.
function listbox_freq_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_freq contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_freq

set(handles.uitable_data,'Visible','off');
set(handles.text_data,'Visible','off');

nf=get(handles.listbox_freq,'Value');

npb=get(handles.listbox_nbreak,'Value');

[nbreak]=numberb(npb);

num=nbreak-2;


if(nbreak>=3 && nf==1)

    set(handles.uitable_data,'Visible','on');
    set(handles.text_data,'Visible','on');
    
    for i=1:num
        data_s{i,1}='';
        data_s{i,2}='';
    end
    
    set(handles.uitable_data,'Data',data_s);       
    
end



% --- Executes during object creation, after setting all properties.
function listbox_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function[nbreak]=numberb(npb)

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
    nbreak=8;    
end
if(npb==10)
    nbreak=3;    
end
