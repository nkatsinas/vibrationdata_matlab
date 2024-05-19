function varargout = vibrationdata_psd_fatigue_severity(varargin)
% VIBRATIONDATA_PSD_FATIGUE_SEVERITY MATLAB code for vibrationdata_psd_fatigue_severity.fig
%      VIBRATIONDATA_PSD_FATIGUE_SEVERITY, by itself, creates a new VIBRATIONDATA_PSD_FATIGUE_SEVERITY or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PSD_FATIGUE_SEVERITY returns the handle to a new VIBRATIONDATA_PSD_FATIGUE_SEVERITY or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PSD_FATIGUE_SEVERITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PSD_FATIGUE_SEVERITY.M with the given input arguments.
%
%      VIBRATIONDATA_PSD_FATIGUE_SEVERITY('Property','Value',...) creates a new VIBRATIONDATA_PSD_FATIGUE_SEVERITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_psd_fatigue_severity_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_psd_fatigue_severity_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_psd_fatigue_severity

% Last Modified by GUIDE v2.5 10-Jun-2021 13:02:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_psd_fatigue_severity_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_psd_fatigue_severity_OutputFcn, ...
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


% --- Executes just before vibrationdata_psd_fatigue_severity is made visible.
function vibrationdata_psd_fatigue_severity_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_psd_fatigue_severity (see VARARGIN)

% Choose default command line output for vibrationdata_psd_fatigue_severity
handles.output = hObject;

listbox_material_Callback(hObject, eventdata, handles);

listbox_fn_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_psd_fatigue_severity wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_psd_fatigue_severity_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_psd_fatigue_severity);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end  

disp(' ');
disp(' * * * * * * * * * * * ');
disp(' ');

fig_num=1;

try
    FS=strtrim(get(handles.edit_input_array,'String'));
    THM=evalin('base',FS);   
catch
    warndlg('Input Filename Error');
    return;
    
end

if(THM(:,1)<1.0e-20)
    THM(1,:)=[];
end

fmin=THM(1,1);
fmax=THM(end,1);

sdur=get(handles.edit_dur,'String');

if isempty(sdur)
    set(handles.edit_dur,'String','60');    
end    

T=str2num(get(handles.edit_dur,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q=str2double(get(handles.edit_Q,'String'));
b=str2double(get(handles.edit_bex,'String'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=THM(:,1);
a=THM(:,2);

[s,rms]=calculate_PSD_slopes(f,a);

base_input_grms=rms;

df=0.5;
%
[fi,ai]=interpolate_PSD(f,a,s,df);

fi=fix_size(fi);
ai=fix_size(ai);

base_input_psd_int=[fi,ai];
%

nchoice=get(handles.listbox_fn,'Value');

[fn,~]=octaves(5);  % 1/24

if(nchoice==1)
    fn=str2double(get(handles.edit_fn,'String'));
end
if(nchoice==2)
    ffmin=str2double(get(handles.edit_lower_fn,'String'));     
    ffmax=str2double(get(handles.edit_upper_fn,'String'));  
    [~,i1]=min(abs(fn-ffmin));
    [~,i2]=min(abs(fn-ffmax));
    fn=fn(i1:i2);
end
if(nchoice>=2)
    [~,i1]=min(abs(fn-fmin));
    [~,i2]=min(abs(fn-fmax));
    fn=fn(i1:i2);
end


nf=length(fn);

fn=fix_size(fn);



velox=zeros(nf,1);
pv_vrs=zeros(nf,1);
pv_vrs_peak=zeros(nf,1);

progressbar;

R=str2num(get(handles.edit_R,'String'));

vref=100;  % reference velocity

disp(' * * * ');

for i=1:nf

    progressbar(i/nf);
    
    A=vref^b;
    
    [~,pv_psd,~]=sdof_psd_response_base_alt(fn(i),Q,base_input_psd_int);
    
    [damage,~,~]=Dirlik_response_psd_alt(pv_psd,A,b,T);
    
    A=A*damage/R;
    
    velox(i)=A^(1/b);
    
%   A=v^b    (do not delete)
%   [damage,~,~]=Dirlik_response_psd_alt(pv_psd,A,b,T);
%   damage
    
    [~,rms] = calculate_PSD_slopes_alt(pv_psd);
    pv_vrs(i)=rms;
    
    ax=0.5;
    [ms]=risk_overshoot(fn(i),T,ax);
    pv_vrs_peak(i)=ms*rms;

end

progressbar(1);
pause(0.2);

[C,I]=max(velox);

threshold=C;

disp(' The material velocity limit must be above the lower limit to pass the test in terms of fatigue,');
disp(' as a rough estimate.');
disp(' ');

out1=sprintf(' Cumulative Damage Index threshold = %g',R);
disp(out1);

out1=sprintf(' Material velocity lower limit = %7.3g in/sec  at %8.4g Hz',threshold',fn(I));
disp(out1);

n=get(handles.listbox_material,'Value');

if(n==1)
    while(1)
        if(threshold<=100)
            disp(' PSD status:  Low risk ');
            break;
        end
        if(threshold<=150)
            disp(' PSD status:  Moderately low risk ');
            break;        
        end
        if(threshold<=200)
            disp(' PSD status:  Moderate risk ');
            break;        
        end    
        if(threshold<=250)
            disp(' PSD status  Moderately high risk ');
            break;        
        end      
        disp(' PSD status:  High risk ');
        break;        
    end
end

if(n==2)
    fprintf('\n Aluminum  6061-T6 Velocity Limits for Yield Stress\n');   
    ys=35;
    E=10e+06;
    rho=0.1;
end
if(n==3)
    fprintf('\n Aluminum  7075-T6   Velocity Limits for Yield Stress\n');  
    ys=66;
    E=10e+06;
    rho=0.1;
end
if(n==4)
    fprintf('\n Magnesium  AZ80A-T5 Velocity Limits for Yield Stress\n');
    ys=38;
    E=6.5e+06;
    rho=0.065;
end
if(n==5)
    fprintf('\n  CRES 303 Stainless Steel Velocity Limits for Yield Stress\n');
    ys=60;
    E=28e+06;
    rho=0.289;
end
if(n==6)
    fprintf('\n A286 Stainless Steel  Velocity Limits for Yield Stress\n'); 
    ys1=40;
    ys2=130;
    E=29e+06;
    rho=0.286;
end
if(n==7)
    fprintf('\n Inconel 625 Velocity Limits for Yield Stress\n');
    ys=40;
    E=30e+06;
    rho=0.305;
end
if(n==8)
    fprintf('\n Inconel 718 Velocity Limits for Yield Stress\n');
    ys=100;
    E=30e+06;
    rho=0.296;
end
if(n==9)
    fprintf('\n Monel K500 Velocity Limits for Yield Stress\n');
    ys=40;
    E=26e+06;
    rho=0.305;
end
if(n==10)
    fprintf('\n Monel 400 Velocity Limits for Yield Stress\n');   
    ys=25;
    E=26e+06;
    rho=0.318;    
end
if(n==11)
    fprintf('\n Nickel Iron Alloy 49 Velocity Limits for Yield Stress\n');   
    ys1=22;
    ys2=80;
    E=24e+06;
    rho=0.295;       
end
if(n==12)
    E=str2num(get(handles.edit_E,'String'));
    rho=str2num(get(handles.edit_rho,'String'));
    ys=str2num(get(handles.edit_ys,'String'));
end

if(n>=2)
    rho=rho/386;
    c=sqrt(E/rho);
    rhoc=rho*c;
end

if(n>=2 && n<=12 && n~=6 && n~=11)

    ys=ys*1000;
    
    vbar=ys/rhoc;
    vbeam=vbar/sqrt(3);
    vpipe=vbar/sqrt(2);
    vplate=vbar/2;
    vcyl=vplate;
    
    if(vbar>threshold)
        fprintf('\n  bar, longitudinal: %8.4g ips  status: pass \n',vbar);
    else
        fprintf('\n  bar, longitudinal: %8.4g ips  status: fail  \n',vbar);
    end
    if(vpipe>threshold)
        fprintf('\n  pipe, thin-walled, bending: %8.4g ips  status: pass \n',vpipe);
    else
        fprintf('\n  pipe, thin-walled, bending: %8.4g ips  status: fail  \n',vpipe);
    end     
    if(vbeam>threshold)
        fprintf('\n  beam, rectangular cross-section, bending: %8.4g ips  status: pass \n',vbeam);
    else
        fprintf('\n  beam, rectangular cross-section, bending: %8.4g ips  status: fail  \n',vbeam);
    end
    if(vcyl>threshold)
        fprintf('\n  beam, solid cylinder, bending: %8.4g ips  status: pass \n',vcyl);
    else
        fprintf('\n  beam, solid cylinder, bending: %8.4g ips  status: fail  \n',vcyl);
    end    
    if(vplate>threshold)
        fprintf('\n  plate, bending: %8.4g ips  status: pass \n',vplate);
    else
        fprintf('\n  plate, bending: %8.4g ips  status: fail  \n',vplate);
    end    
   
end

if(n==6 || n==11)
    
    ys1=ys1*1000;
    ys2=ys2*1000;
    
    vbar1=ys1/rhoc;
    vpipe1=vbar1/sqrt(2);
    vbeam1=vbar1/sqrt(3);
    vplate1=vbar1/2;
    vcyl1=vplate1;
    
    vbar2=ys2/rhoc;
    vpipe2=vbar2/sqrt(2);    
    vbeam2=vbar2/sqrt(3);
    vplate2=vbar2/2;    
    vcyl2=vplate2;    
    
    fprintf(' heat treatment dependent\n');
    
    fprintf('\n  bar, longitudinal: %8.4g to %8.4g ips \n',vbar1,vbar2);
    fprintf('\n  pipe, thin-walled, bending: %8.4g to %8.4g ips \n',vpipe1,vpipe2);
    fprintf('\n  beam, rectangular cross-section, bending: %8.4g to %8.4g ips \n',vbeam1,vbeam2);
    fprintf('\n  beam, solid cylinder, bending: %8.4g to %8.4g ips \n',vcyl1,vcyl2);    
    fprintf('\n  plate, bending: %8.4g to %8.4g ips \n',vplate1,vplate2);     
end    



ylab='Accel (G^2/Hz)';
xlab='Frequency (Hz)';
t_string=sprintf('Base Input PSD  %7.3g GRMS overall',base_input_grms);
[fig_num,~]=plot_PSD_function(fig_num,xlab,ylab,t_string,THM,fmin,fmax);
    
if(nf>=3)
    
    md=4;
    
    leg1='peak';
    leg2='3-sigma';
    leg3='1-sigma';
    
    ppp1=[fn pv_vrs_peak];
    ppp2=[fn 3*pv_vrs];
    ppp3=[fn pv_vrs];
    
    ylab='PV (in/sec)';
    y_label=ylab;
    x_label='Natural Frequency (Hz)';
    t_string = sprintf(' Pseudo Velocity Vibration Response Spectrum Q=%g ',Q);

    [fig_num]=plot_loglog_function_md_three(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
           
    t_string=sprintf('Pseudo Velocity Fatigue Threshold Spectrum \n (Yield Stress Equivalent Velocity) \nQ=%g b=%g   Normalized to R=1',Q,b);
    y_label=sprintf(' PV (ips)');
    ppp=[fn velox];
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);       
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

%%% set(handles.pushbutton_calculate,'Enable','off');

n=get(handles.listbox_method,'Value');


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


% --- Executes on selection change in listbox_sigma.
function listbox_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_sigma contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_sigma


% --- Executes during object creation, after setting all properties.
function listbox_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_amp.
function listbox_output_amp_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_amp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_amp


% --- Executes during object creation, after setting all properties.
function listbox_output_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_VRS.
function pushbutton_VRS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_VRS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_calculate.
function listbox_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_calculate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_calculate


set(handles.edit_output_array_fds,'enable','off')
set(handles.pushbutton_save_FDS,'enable','off')

n=get(handles.listbox_calculate,'value');

if(n==1)
    set(handles.text_fatigue_exponent,'visible','off');
    set(handles.edit_fatigue_exponent,'visible','off');
    set(handles.text_fatigue_type,'visible','off');
    set(handles.listbox_FDS_type,'visible','off');    
    set(handles.uipanel_FDS,'visible','off');
else
    set(handles.text_fatigue_exponent,'visible','on');
    set(handles.edit_fatigue_exponent,'visible','on');  
    set(handles.text_fatigue_type,'visible','on');
    set(handles.listbox_FDS_type,'visible','on');     
    set(handles.uipanel_FDS,'visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fatigue_exponent_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fatigue_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fatigue_exponent as text
%        str2double(get(hObject,'String')) returns contents of edit_fatigue_exponent as a double


% --- Executes during object creation, after setting all properties.
function edit_fatigue_exponent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fatigue_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_FDS_type.
function listbox_FDS_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_FDS_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_FDS_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_FDS_type


% --- Executes during object creation, after setting all properties.
function listbox_FDS_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_FDS_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_FDS.
function pushbutton_save_FDS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_FDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'fds');
output_name=strtrim(get(handles.edit_output_array_fds,'String'));
assignin('base', output_name, data);
 
h = msgbox('Save Complete'); 


function edit_output_array_fds_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_fds as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_fds as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_fds_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_velox_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velox as text
%        str2double(get(hObject,'String')) returns contents of edit_velox as a double


% --- Executes during object creation, after setting all properties.
function edit_velox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bex_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bex as text
%        str2double(get(hObject,'String')) returns contents of edit_bex as a double


% --- Executes during object creation, after setting all properties.
function edit_bex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_fn.
function listbox_fn_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fn contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fn

n=get(handles.listbox_fn,'Value');

set(handles.text_fn,'Visible','off');
set(handles.edit_fn,'Visible','off');

set(handles.text_lower_fn,'Visible','off');
set(handles.edit_lower_fn,'Visible','off');

set(handles.text_upper_fn,'Visible','off');
set(handles.edit_upper_fn,'Visible','off');

if(n==1)
    set(handles.text_fn,'Visible','on');
    set(handles.edit_fn,'Visible','on');   
end
if(n==2)
    set(handles.text_lower_fn,'Visible','on');
    set(handles.edit_lower_fn,'Visible','on');

    set(handles.text_upper_fn,'Visible','on');
    set(handles.edit_upper_fn,'Visible','on');  
end


% --- Executes during object creation, after setting all properties.
function listbox_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fn (see GCBO)
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



function edit_lower_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lower_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lower_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_lower_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_lower_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lower_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_upper_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_upper_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_upper_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_upper_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_upper_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_upper_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_R_Callback(hObject, eventdata, handles)
% hObject    handle to edit_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_R as text
%        str2double(get(hObject,'String')) returns contents of edit_R as a double


% --- Executes during object creation, after setting all properties.
function edit_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

n=get(handles.listbox_material,'Value');

set(handles.edit_ys,'Visible','off');
set(handles.edit_E,'Visible','off');
set(handles.edit_rho,'Visible','off');
set(handles.text_ys,'Visible','off');
set(handles.text_E,'Visible','off');
set(handles.text_rho,'Visible','off');


if(n==12)
    set(handles.edit_ys,'Visible','on');    
    set(handles.edit_E,'Visible','on');
    set(handles.edit_rho,'Visible','on');
    set(handles.text_ys,'Visible','on');       
    set(handles.text_E,'Visible','on');
    set(handles.text_rho,'Visible','on'); 
end


% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_E_Callback(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_E as text
%        str2double(get(hObject,'String')) returns contents of edit_E as a double


% --- Executes during object creation, after setting all properties.
function edit_E_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho as text
%        str2double(get(hObject,'String')) returns contents of edit_rho as a double


% --- Executes during object creation, after setting all properties.
function edit_rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ys_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ys (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ys as text
%        str2double(get(hObject,'String')) returns contents of edit_ys as a double


% --- Executes during object creation, after setting all properties.
function edit_ys_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ys (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
