function varargout = vibrationdata_sdof_pressure(varargin)
% VIBRATIONDATA_SDOF_PRESSURE MATLAB code for vibrationdata_sdof_pressure.fig
%      VIBRATIONDATA_SDOF_PRESSURE, by itself, creates a new VIBRATIONDATA_SDOF_PRESSURE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SDOF_PRESSURE returns the handle to a new VIBRATIONDATA_SDOF_PRESSURE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SDOF_PRESSURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SDOF_PRESSURE.M with the given input arguments.
%
%      VIBRATIONDATA_SDOF_PRESSURE('Property','Value',...) creates a new VIBRATIONDATA_SDOF_PRESSURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_sdof_pressure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_sdof_pressure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_sdof_pressure

% Last Modified by GUIDE v2.5 11-Mar-2019 16:35:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_sdof_pressure_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_sdof_pressure_OutputFcn, ...
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


% --- Executes just before vibrationdata_sdof_pressure is made visible.
function vibrationdata_sdof_pressure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_sdof_pressure (see VARARGIN)

% Choose default command line output for vibrationdata_sdof_pressure
handles.output = hObject;


set(handles.edit_results,'Enable','off');

set(handles.listbox_unit,'Value',1);

set(handles.listbox_method,'Value',1);
set(handles.listbox_interpolate,'Value',1);

set(handles.pushbutton_calculate,'Enable','on');

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');
set(handles.listbox_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_sdof_pressure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_sdof_pressure_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_sdof_pressure_force);



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

p=get(handles.listbox_unit,'Value');

k=get(handles.listbox_method,'Value');


set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save,'Enable','on')
set(handles.listbox_save,'Enable','on');

set(handles.edit_results,'Enable','off');

 
try

    if(k==1)
        FS=get(handles.edit_input_array,'String');
        THM=evalin('base',FS);   
    else
        THM=getappdata(0,'THM');
    end

catch
    
    warndlg('Input Filename Error');
    
    return;
    
end

n=length(THM(:,1));

if(THM(:,1)<1.0e-20)
    THM(1,:)=[];
end

area_s=get(handles.edit_area,'String');

if isempty(area_s)
    warndlg('Enter Area');
    return;
else
    area=str2num(area_s);
end

THM(:,2)=THM(:,2)*area^2;


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

%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[s,input_rms] = calculate_PSD_slopes_no(THM(:,1),THM(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q=str2num(get(handles.edit_Q,'String'));


fns=get(handles.edit_fn,'String');

if isempty(fns)
    warndlg('Enter Natural Frequency');
    return;
else
    fn=str2num(fns);    
end
 

durs=get(handles.edit_dur,'String');

if isempty(durs)
    warndlg('Enter Duration');
    return;
else
    dur=str2num(durs);    
end


masss=get(handles.edit_mass,'String');

if isempty(masss)
    warndlg('Enter Mass');
    return;
else
    mass=str2num(masss);    
end

mass_orig=mass;

if(p==1)
    mass=mass/386;
end    



damp=1/(2*Q);

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

if(fn<fmin)
    fmin=fn/2;
end  

if(fn>fmax)
    fmax=2*fn;
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=THM(:,1);
a=THM(:,2);

omegan=2*pi*fn;
omegan2=omegan^2;
stiffness=mass*omegan2;

ni=get(handles.listbox_interpolate,'Value');

if(ni==1)
   df=0.5;
   [fi,ai]=interpolate_PSD(f,a,s,df);
else
    fi=f;
    ai=a;
end

n_ref=length(fi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ax=0.5;
[ms]=risk_overshoot(fn,dur,ax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omega=zeros(n_ref,1);
omega2=zeros(n_ref,1);
%
for j=1:n_ref   
    omega(j)=tpi*fi(j);
    omega2(j)=omega(j)^2;
end
%
dpsd=zeros(n_ref,1);
vpsd=zeros(n_ref,1);
apsd=zeros(n_ref,1);
FT_psd=zeros(n_ref,1);

%
%      Transmitted Force
%
for j=1:n_ref
%
    rho=fi(j)/fn;
    num= 1.+(2*damp*rho)^2;
    den= (1-rho^2)^2 + (2*damp*rho)^2;
    t= num/den;
    FT_psd(j)=( t*ai(j) );
%
end

%
%      Absolute Displacement
%
for j=1:n_ref
%        
	num=( (omegan2/stiffness)^2 );
	den=( (omegan2-omega2(j))^2) + ( (2*damp*omega(j)*omegan)^2);
	t= num/den;
    dpsd(j)=( t*ai(j) );
%
end
%
%      Velocity
%
for j=1:n_ref
%     
    num=( (omega(j)*omegan2/stiffness)^2 );
    den=( (omegan2-omega2(j))^2) + ( (2*damp*omega(j)*omegan)^2);
    t= num/den;
    vpsd(j)=( t*ai(j) );
%
end

%
%      Acceleration
%
for j=1:n_ref
%
    num=( (omega2(j)*omegan2/stiffness)^2 );
    den=( (omegan2-omega2(j))^2) + ( (2*damp*omega(j)*omegan)^2);
    t= num/den;
    apsd(j)=( t*ai(j) );
%
end
if(p==1)
    apsd=apsd/(386^2);
end
if(p==2)
    apsd=apsd/(9.81^2); 
    dpsd=dpsd*(1000^2);       
end
if(p==3)
    dpsd=dpsd*(1000^2);   
end

[FT_m0,FT_rms]=cm0(FT_psd,fi,n_ref);
[m0,drms]=cm0(dpsd,fi,n_ref);
[m0,vrms]=cm0(vpsd,fi,n_ref);
[m0,grms]=cm0(apsd,fi,n_ref);


string_acc=sprintf(' Acceleration ');
string_vel=sprintf('\n\n Velocity ');
string_disp=sprintf('\n\n Displacement ');
string_tf=sprintf('\n\n Transmitted Force ');


string_big=string_acc;
if(p<=2)
    out1=sprintf('\n\n = %8.3g GRMS',grms);
    out2=sprintf('\n = %8.3g G %4.3g-sigma (maximum expected)',ms*grms,ms);    
else
    out1=sprintf('\n\n = %8.3g m/sec^2 RMS',grms);
    out2=sprintf('\n = %8.3g m/sec^2 %4.3g-sigma (maximum expected)',ms*grms,ms);      
end
string_big=strcat(string_big,out1); 
string_big=strcat(string_big,out2); 


string_big=strcat(string_big,string_vel);
if(p==1)
    out1=sprintf('\n\n = %8.3g in/sec RMS',vrms);
    out2=sprintf('\n = %8.3g in/sec %4.3g-sigma (maximum expected)',ms*vrms,ms);  
else
    out1=sprintf('\n\n = %8.3g m/sec RMS',vrms);
    out2=sprintf('\n = %8.3g m/sec %4.3g-sigma (maximum expected)',ms*vrms,ms);  
end
string_big=strcat(string_big,out1); 
string_big=strcat(string_big,out2); 



string_big=strcat(string_big,string_disp);
if(p==1)
    out1=sprintf('\n\n = %8.3g in RMS',drms);
    out2=sprintf('\n = %8.3g in %4.3g-sigma (maximum expected)',ms*drms,ms);  
else
    out1=sprintf('\n\n = %8.3g mm RMS',drms);
    out2=sprintf('\n = %8.3g mm %4.3g-sigma (maximum expected)',ms*drms,ms);   
end
string_big=strcat(string_big,out1); 
string_big=strcat(string_big,out2); 




string_big=strcat(string_big,string_tf);
if(p==1)
    out1=sprintf('\n\n = %8.3g lbf RMS',FT_rms);
    out2=sprintf('\n = %8.3g lbf %4.3g-sigma (maximum expected)',ms*FT_rms,ms);  
else
    out1=sprintf('\n\n = %8.3g N RMS',FT_rms);
    out2=sprintf('\n = %8.3g N %4.3g-sigma (maximum expected)',ms*FT_rms,ms);   
end
string_big=strcat(string_big,out1); 
string_big=strcat(string_big,out2); 


set(handles.edit_results,'String',string_big,'Max',17,'Enable','on');


fi=fix_size(fi);
apsd=fix_size(apsd);
vpsd=fix_size(vpsd);
dpsd=fix_size(dpsd);
FT_psd=fix_size(FT_psd);

accel_psd=[fi apsd];
vel_psd=[fi vpsd];
disp_psd=[fi dpsd];
trans_force_psd=[fi FT_psd];

setappdata(0,'accel_psd',accel_psd);
setappdata(0,'vel_psd',vel_psd);
setappdata(0,'disp_psd',disp_psd);
setappdata(0,'trans_force_psd',trans_force_psd);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w=100000;

fig_num=1;

md=5;
ppp=[fi apsd];

x_label='Frequency (Hz)';

if(p<=2)
    y_label='Accel (G^2/Hz)';
    t_string=sprintf('Accel PSD, mass=%g lbm, fn=%g Hz, Q=%g \n %8.4g GRMS overall',mass_orig,fn,Q,grms);
else
    y_label='Accel (m/sec^2)^2/Hz)';    
    t_string=sprintf('Accel PSD, mass=%g kg, fn=%g Hz, Q=%g \n %8.4g m/sec^2 RMS overall  %8.4g',mass_orig,fn,Qv);
end

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp=[fi vpsd];

if(p==1)
    y_label='Vel ((in/sec)^2/Hz)';
    t_string=sprintf('Vel PSD, mass=%g lbm, fn=%g Hz, Q=%g \n %8.4g in/sec RMS Overall',mass_orig,fn,Q,vrms);    
else
    y_label='Vel ((m/sec)^2/Hz)';  
    t_string=sprintf('Vel PSD, mass=%g kg, fn=%g Hz, Q=%g \n %8.4g m/sec RMS Overall',mass_orig,fn,Q,vrms);    
end

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(p==1)
    y_label='Disp (in^2/Hz)';
    t_string=sprintf('Disp PSD, mass=%g lbm, fn=%g Hz, Q=%g \n %8.4g in RMS Overall',mass_orig,fn,Q,drms);       
else
    y_label='Disp (mm^2/Hz)';
    t_string=sprintf('Disp PSD, mass=%g kg, fn=%g Hz, Q=%g \n %8.4g mm RMS Overall',mass_orig,fn,Q,drms);     
end

ppp=[fi dpsd];

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(p==1)
    y_label='Force (lbf^2/Hz)';
    leg1=sprintf('      Input %8.4g lbf RMS',input_rms);
    leg2=sprintf('Transmitted %8.4g lbf RMS',FT_rms);
    t_string=sprintf('Force PSD, mass=%g lbm, fn=%g Hz, Q=%g',mass_orig,fn,Q);    
else
    y_label='Force (N^2/Hz)'; 
    leg1=sprintf('      Input %8.4g N RMS',input_rms);
    leg2=sprintf('Transmitted %8.4g N RMS',FT_rms);
    t_string=sprintf('Force PSD, mass=%g kg, fn=%g Hz, Q=%g',mass_orig,fn,Q);        
end

ppp1=[fi ai];
ppp2=[fi FT_psd];

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function edit_dur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur as text
%        str2double(get(hObject,'String')) returns contents of edit_dur as a double


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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
clear_results(hObject, eventdata, handles);



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');


if(n==1)
    data=getappdata(0,'accel_psd');
end
if(n==2)
    data=getappdata(0,'vel_psd');  
end
if(n==3)
    data=getappdata(0,'disp_psd');    
end
if(n==4)
    data=getappdata(0,'trans_force_psd');      
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete.'); 


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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
clear_results(hObject, eventdata, handles);

p=get(handles.listbox_unit,'Value');

if(p==1)
    set(handles.text_mass_label,'String','Mass (lbm)');
    set(handles.text_area,'String','Area (in^2)');
else
    set(handles.text_mass_label,'String','Mass (kg)');  
    set(handles.text_area,'String','Area (m^2)');    
end



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


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
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



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_mass and none of its controls.
function edit_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'String','');


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



function edit_area_Callback(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_area as text
%        str2double(get(hObject,'String')) returns contents of edit_area as a double


% --- Executes during object creation, after setting all properties.
function edit_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
