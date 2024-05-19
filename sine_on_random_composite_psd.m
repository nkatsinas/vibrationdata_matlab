function varargout = sine_on_random_composite_psd(varargin)
% SINE_ON_RANDOM_COMPOSITE_PSD MATLAB code for sine_on_random_composite_psd.fig
%      SINE_ON_RANDOM_COMPOSITE_PSD, by itself, creates a new SINE_ON_RANDOM_COMPOSITE_PSD or raises the existing
%      singleton*.
%
%      H = SINE_ON_RANDOM_COMPOSITE_PSD returns the handle to a new SINE_ON_RANDOM_COMPOSITE_PSD or the handle to
%      the existing singleton*.
%
%      SINE_ON_RANDOM_COMPOSITE_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINE_ON_RANDOM_COMPOSITE_PSD.M with the given input arguments.
%
%      SINE_ON_RANDOM_COMPOSITE_PSD('Property','Value',...) creates a new SINE_ON_RANDOM_COMPOSITE_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sine_on_random_composite_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sine_on_random_composite_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sine_on_random_composite_psd

% Last Modified by GUIDE v2.5 15-Jan-2015 13:56:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sine_on_random_composite_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @sine_on_random_composite_psd_OutputFcn, ...
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


% --- Executes just before sine_on_random_composite_psd is made visible.
function sine_on_random_composite_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sine_on_random_composite_psd (see VARARGIN)

% Choose default command line output for sine_on_random_composite_psd
handles.output = hObject;

set(handles.listbox_bw,'Value');

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_sine_number,'Value',1);
listbox_sine_number_Callback(hObject, eventdata, handles);


set(handles.pushbutton_synthesize,'Visible','off');
set(handles.pushbutton_vrs_fds,'Visible','off');

listbox_bw_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sine_on_random_composite_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sine_on_random_composite_psd_OutputFcn(hObject, eventdata, handles) 
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

delete(sine_on_random_composite_psd);



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


% --- Executes on selection change in listbox_sine_number.
function listbox_sine_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_sine_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_sine_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_sine_number

set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_sine_number,'Value');

% set(handles.uitable_data,'Data',data_s,'ColumnWidth', {75,75,0});      
% set(handles.uitable_bands,'Data',data_s,'ColumnWidth', {75,75,0}); 

Nrows=n;
Ncolumns=2;

set(handles.uitable_data,'Data',cell(Nrows,Ncolumns));
set(handles.uitable_bands,'Data',cell(Nrows,Ncolumns));

% --- Executes during object creation, after setting all properties.
function listbox_sine_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_sine_number (see GCBO)
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



function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
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


% --- Executes on key press with focus on edit_b and none of its controls.
function edit_b_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');




% --- Executes during object creation, after setting all properties.
function edit_dB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end










% --- Executes during object creation, after setting all properties.
function listbox_bw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




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

% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'cpsd');

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

set(handles.pushbutton_synthesize,'Visible','on');
set(handles.pushbutton_vrs_fds,'Visible','on');


% Hints: get(hObject,'String') returns contents of edit_dB as text
%        str2double(get(hObject,'String')) returns contents of edit_dB as a double



% --- Executes on selection change in listbox_bw.
function listbox_bw_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bw contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bw

n=get(handles.listbox_bw,'Value');

set(handles.uitable_bands,'Visible','off');
set(handles.text_BLF,'Visible','off');

if(n==4)
    set(handles.uitable_bands,'Visible','on');
    set(handles.text_BLF,'Visible','on');    
end    


% --- Executes on button press in pushbutton_synthesize.
function pushbutton_synthesize_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_synthesize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_PSD_accel_synth;  
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_vrs_fds.
function pushbutton_vrs_fds_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_vrs_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_vrs_base;  
set(handles.s,'Visible','on'); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.pushbutton_synthesize,'Visible','off');
set(handles.pushbutton_vrs_fds,'Visible','off');

try
   FS=get(handles.edit_input_array_name,'String');
   THM=evalin('base',FS);   
catch
   warndlg('Input Filename Error');    
   return; 
end

num=length(THM(:,1));
        
[s,input_rms] = calculate_PSD_slopes(THM(:,1),THM(:,2));

fp=THM(:,1);
ap=THM(:,2);

minf=min(fp);
maxf=max(fp);

nband=get(handles.listbox_bw,'value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Q=str2num(get(handles.edit_Q,'String'));

b=str2num(get(handles.edit_b,'String'));

N=get(handles.listbox_sine_number,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A=char(get(handles.uitable_data,'Data'));
B=str2num(A);

freq=B(1:N);
amp=B((N+1):(2*N));

freq=fix_size(freq);
amp=fix_size(amp);

fa=[freq amp];

if(nband<=4)
    fa=sortrows(fa,1);  
end

fff=fa(:,1);
aaa=fa(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nband==4)

    C=char(get(handles.uitable_bands,'Data'));
    D=str2num(C);

    fb1=D(1:N);
    fb2=D((N+1):(2*N));
    
    fb1=fix_size(fb1);
    fb2=fix_size(fb2);

    fuser=[fa fb1 fb2];
    fuser=sort(fuser,1); 
    fa=fuser(:,1:2);
    fb1=fuser(:,3);
    fb2=fuser(:,4);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ccc=zeros(N,1);  % composite
ccc_ll=zeros(N,1);  % composite ll
ccc_uu=zeros(N,1);  % composite uu

fl=zeros(N,1);
fu=zeros(N,1);
cpsd=zeros(N,1);

fll=zeros(N,1);
fuu=zeros(N,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:N
   fc=fff(i);
   if(fc<minf || fc>maxf)
        out1=disp(' minf=%g Hz  fc=%g Hz  maxf=%g Hz',minf,fc,maxf);
        disp(out1);
        warndlg('Sine frequency is outside of psd frequency limits.');    
        return;
   end     
end

T=1;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nband==1)  % 1/6
    oct=2^(1/24);
    w=2^(1/12);
end
if(nband==2)  % 1/12
    oct=2^(1/48);
    w=2^(1/24); 
end   
if(nband==3)  % 1/24
    oct=2^(1/96);
    w=2^(1/48); 
end  
if(nband==4)  % user defined
    oct=2^(1/48);
    w=2^(1/24);  
end  


for i=1:N
   fc=fff(i);   
    A=aaa(i);
%
   if(nband<=3)   
 
      f1=fc/w;
      f2=fc*w;   
   
   else
       
      f1=fb1(i);
      f2=fb2(i);
       
   end
%
    [nb_psd_amp]=vibrationdata_sine_narrowband_composite(fc,f1,f2,T,A,b,Q); 
%
    fl(i)=f1;
    fu(i)=f2;
    
    fll(i)=f1/oct;
    fuu(i)=f2*oct;
    
    cpsd(i)=nb_psd_amp;
%
end
 


 
for i=1:(N-1)
   if( fuu(i)>=fll(i+1))
        warndlg('Narrowbands overlap');    
        return;
   end   
end
 
for i=1:N
   if(fll(i)<minf || fuu(i)>maxf)
        warndlg('Narrowband frequency is outside of psd frequency limits.');    
        return;
   end     
end
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
for i=1:N
    for j=1:(num-1)
        if( fff(i)>=fp(j) && fff(i)<=fp(j+1))
            
            ppp=ap(j)*( ( fff(i) / fp(j) )^ s(j) );  
            ccc(i)=ppp+cpsd(i);
            
            break;
        end
    end
end
 
for i=1:N
    for j=1:(num-1)
        if( fll(i)>=fp(j) && fll(i)<=fp(j+1))
            
            ppp=ap(j)*( (fll(i) / fp(j) )^ s(j) );  
            ccc_ll(i)=ppp;
            
            break;
        end
    end
end
 
for i=1:N
    for j=1:(num-1)
        if( fuu(i)>=fp(j) && fuu(i)<=fp(j+1))
            
            ppp=ap(j)*( (fuu(i) / fp(j) )^ s(j) );  
            ccc_uu(i)=ppp;
            
            break;
        end
    end
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
j=1;

fsor=zeros(N,1);
psor=zeros(N,1);

for i=1:N
    fsor(j)=fll(i);
    psor(j)=ccc_ll(i);
    j=j+1;
%    
    fsor(j)=fl(i);
    psor(j)=ccc(i);
    j=j+1;
%    
    fsor(j)=fu(i);
    psor(j)=ccc(i);    
    j=j+1;
%    
    fsor(j)=fuu(i);
    psor(j)=ccc_uu(i);    
    j=j+1;    
%    
end    
 

%

iflag=0;

for i=1:length(fp)
    for j=1:N
        if(fp(i)>=fll(j) && fp(i)<=fuu(j))
            fp(i)=[];
            ap(i)=[];
            iflag=1;
            break;
        end    
    end
    if(iflag==1)
        break;
    end
end
%
 
 
fcomp=fsor;
acomp=psor;
 
m=length(fcomp);
 
num=length(fp);
 
for i=1:num
    fcomp(m+i)=fp(i);
    acomp(m+i)=ap(i);
end
 
clear cpsd; % used before
 
fcomp=fix_size(fcomp);
acomp=fix_size(acomp);
 
 
dB=str2num(get(handles.edit_dB,'String'));
 
scale=(10^(dB/20));
 
acomp=acomp*scale^2;
 
tpsd=[fcomp acomp];
 
cpsd=sortrows(tpsd,1);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
M=length(cpsd(:,1));
 
[~,crms] = calculate_PSD_slopes(cpsd(:,1),cpsd(:,2));
 
disp(' Freq(Hz)  Accel(G^2/Hz) ');
 
for i=1:M
    out1=sprintf('%8.4g  %8.4g',cpsd(i,1),cpsd(i,2));
    disp(out1);
end
 
out2=sprintf('\n overall level = %8.4g GRMS \n',crms);
disp(out2);
 
setappdata(0,'cpsd',cpsd);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
fig_num=1;
 
xlab='Frequency (Hz)';
ylab='Accel (G^2/Hz)';
t_string=sprintf('Power Spectral Density  %7.3g GRMS Overall',crms);
 
fmin=cpsd(1,1);
fmax=cpsd(M,1);
 
[fig_num,h]=plot_PSD_function(fig_num,xlab,ylab,t_string,cpsd,fmin,fmax);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
set(handles.uipanel_save,'Visible','on');
 
