function varargout = srs_spec_convert_Q(varargin)
% SRS_SPEC_CONVERT_Q MATLAB code for srs_spec_convert_Q.fig
%      SRS_SPEC_CONVERT_Q, by itself, creates a new SRS_SPEC_CONVERT_Q or raises the existing
%      singleton*.
%
%      H = SRS_SPEC_CONVERT_Q returns the handle to a new SRS_SPEC_CONVERT_Q or the handle to
%      the existing singleton*.
%
%      SRS_SPEC_CONVERT_Q('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRS_SPEC_CONVERT_Q.M with the given input arguments.
%
%      SRS_SPEC_CONVERT_Q('Property','Value',...) creates a new SRS_SPEC_CONVERT_Q or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before srs_spec_convert_Q_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to srs_spec_convert_Q_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help srs_spec_convert_Q

% Last Modified by GUIDE v2.5 25-Jan-2018 11:24:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @srs_spec_convert_Q_OpeningFcn, ...
                   'gui_OutputFcn',  @srs_spec_convert_Q_OutputFcn, ...
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


% --- Executes just before srs_spec_convert_Q is made visible.
function srs_spec_convert_Q_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to srs_spec_convert_Q (see VARARGIN)

% Choose default command line output for srs_spec_convert_Q
handles.output = hObject;

setappdata(0,'nastran_srs',0);

set(handles.listbox_units,'Value',1);
set(handles.listbox_method,'Value',1);
set(handles.edit_Q,'String','10');



set(handles.edit_Q,'String','10');

listbox_num_Q_Callback(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','on');
set(handles.pushbutton_export,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes srs_spec_convert_Q wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = srs_spec_convert_Q_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tic;

clear_all_figures(srs_spec_convert_Q);


%%  h = msgbox('Intermediate Results are written in Command Window');

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  srs_spec_input=evalin('base',FS);   
else
  srs_spec_input=getappdata(0,'srs_spec_input');
end

nQ=get(handles.listbox_num_Q,'Value');

Q=str2num(get(handles.edit_Q,'String'));
    

damp = (1/(2*Q));

new_Q=zeros(nQ,1);
new_damp=zeros(nQ,1);

for i=1:nQ
    
    if(i==1)
        new_Q(i)=str2num(get(handles.edit_new_Q1,'String'));
    else
        new_Q(i)=str2num(get(handles.edit_new_Q2,'String'));
    end
    
    if(isempty(new_Q(i)))
        warndlg(' Enter New Q ');
        return;
    end 
    
    new_damp(i) = (1/(2*new_Q(i)));
    
end


ntrials=str2num(get(handles.edit_trials,'String'));

fstart=srs_spec_input(1,1);
flast=max(srs_spec_input(:,1));

sr=10*flast;
dt=1/sr;

dur=3.0/fstart;

nt=round(dur/dt); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

tpi=2.*pi;


FMAX=400;

octave=(2^(1/12));
%
errlit=1.0e+90;
syn_error = 1.0e+91;  
%

%% disp(' Select units ');
%% disp('  1=English: accel(G), vel(in/sec),  disp(in)  ');
%% disp('  2=metric : accel(G), vel(m/sec),  disp(mm)  '); 
%
iunit=get(handles.listbox_units,'Value');

sz=size(srs_spec_input(:,1));

n=sz(1);

f=srs_spec_input(:,1);
a=srs_spec_input(:,2);

srs_spec=[f a];


last_f=f(n);
last_a=a(n);
%
%

slope=zeros(n-1,1);

%
for i=1:(n-1)
    slope(i)=log(a(i+1)/a(i))/log(f(i+1)/f(i));
end

first=0;

ns=nt;

iamax=ntrials;

ntt=80;  % number of iterations for inner loop

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('  Interpolating reference. ');
%
rf=zeros(FMAX,1);
ra=zeros(FMAX,1);
%
rf(1)=f(1);
ra(1)=a(1);
%
for i=2:FMAX
%
    rf(i)=rf(i-1)*octave;
%
    if( rf(i) == max(f) )
    break;
    end
    if( rf(i) > max(f) )
        rf(i)=max(f);
        break;
    end
end
last=i;
%
out1=sprintf(' \n last = %ld   flast = %12.4g\n',last,rf(last));
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
for i=1:last
%
    for j=1:n
%
        if( rf(i) > f(j) && rf(i) <f(j+1))
            ra(i)=a(j)*( (rf(i)/f(j))^slope(j) );
            break;
        end
%
        if( rf(i)==f(j))
            ra(i)=a(j);
            break;
        end
%
        if( rf(i)==f(j+1))   
            ra(i)=a(j+1);
            break;
        end
    end
end
%
rf(last)=last_f;
ra(last)=last_a;
%
out1=sprintf(' \n last=%ld ',last);
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

jkj=1;
%
best_amp=zeros(last,1);
best_phase=zeros(last,1);
best_delay=zeros(last,1);
best_dampt=zeros(last,1);
%
freq=rf;
clear omega;
omega=tpi*rf;
%
progressbar;
for ia=1:iamax
    progressbar(ia/iamax);
    iflag=0;
%
% disp('  Calculating damped sine parameters.');
    [amp,phase,delay,dampt,sss,first]=...
    DSS_sintime(ns,dt,dur,tpi,ia,iamax,ra,omega,last,syn_error,...
                          best_amp,best_phase,best_delay,best_dampt,first);
%
%disp('  Synthesizing initial time history. ');
    [sum,sym]=DSS_th_syn(ns,amp,sss,last);
%
    [xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,sum);
%
    for ijk=1:ntt
%
        for i=1:last
            xx = (xmax(i) + abs(xmin(i)))/2.; 
            if(xx <1.0e-90)
                iflag=1;
            end
            amp(i)=amp(i)*((ra(i)/xx)^0.25);
        end
 %   
        if(iflag==1)
            disp(' ref 1 ');
            break;
        end
%
        [sym,sum]=DSS_scale_th(ns,last,sum,amp,sss);
%
        nk=round(0.9*ns);
        LLL=ns-nk;
        for i=nk:ns
            x=(i-nk);
            sum(i)=sum(i)*(1-(x/LLL));
        end
%
        fper=3;
        fper=fper/100;
%
%        n=length(y);
        n=ns;
%
        na=round(fper*n);
%
        for i=1:na
            arg=pi*(( (i-1)/(na-1) )+1); 
            sum(i)=sum(i)*0.5*(1+(cos(arg)));
        end
%
        [xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,sum);
%
        [syn_error,iflag]=DSS_srs_error(last,xmax,xmin,ra,iflag);
%
        if(iflag==1)
            disp(' ref 2 ');
            break;
        end
%
        sym= 20*log10(abs(max(sum)/min(sum)));
        sym=abs(sym);
        if( (syn_error < errlit) && (sym < 2.5) || ia==1)
%
            iacase =ia;
            icase = ijk;
%
            errlit = syn_error;
%
            out1=sprintf(' \n %ld %ld  best= %12.4g  sym= %12.4g',ia,...
                                                        ijk,syn_error,sym);
            disp(out1)
            for k=1:last
                best_amp(k)=amp(k);
                best_phase(k)=phase(k);
                best_dampt(k)= dampt(k);
                best_delay(k)=delay(k);
            end
            store=sum;
%
        end
%
        out1=sprintf(' %ld %ld  error= %12.4g   best= %12.4g  ',ia,ijk,...
                                                         syn_error,errlit);
        disp(out1);
%
        if(ijk>8 && syn_error > error_before)  
            break;
        end
        if(ijk>8 && sym>3.0)  
            break;
        end   
        if(ijk>1 && syn_error > 1.0e+90)
            break;
        end
%
        error_before=syn_error;
    end
    disp(' ');
%
    if(jkj==1)
        jkj=2;
    else
        jkj=1;
    end
    
    if(errlit<1.5)
        break;
    end
    
end
pause(0.4);
progressbar(1); 
%
out1=sprintf(' \n\n Best case is %ld %ld ',iacase,icase);
disp(out1);
%
%
[xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,store);
%
freq=fix_size(freq);
xmin=fix_size(xmin);
xmax=fix_size(xmax);
%
sz=size(xmax);
nnn=sz(1);

ff=freq(1:nnn);
clear freq;
freq=ff;
%
srs_syn=[freq xmin xmax];
%
clear tr;
clear store_recon;
%
%
[acceleration]=add_pre_shock(store,dur,dt);
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[fig_num]=plot_a_srs_damped_sine(acceleration,srs_syn,srs_spec,damp,fig_num,iunit);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

f=freq;
yy=acceleration(:,2);
  
if(iunit<=2)
    y_lab='Accel(G)';
else
    y_lab='Accel(m/sec^2)';    
end  


fn=f;
fmin=fn(1);
fmax=max(fn);

disp(' ');
disp(' ');

NT=4000;

md=6;

x_label='Natural Frequency (Hz)';
y_label=y_lab;


srs_type=get(handles.listbox_type,'Value');
format=get(handles.listbox_format,'Value');

NL=length(f);


for ijk=1:nQ

    [new_srs_pn]=srs_function(yy,dt,new_damp(ijk),f);

    fn=freq;
    a_pos=new_srs_pn(:,2);
    a_neg=new_srs_pn(:,3);

    a_abs=zeros(NL,1);
    a_abs(:,1)=f;

    for i=1:NL
        a_abs(i)=max([ a_pos(i) a_neg(i)]); 
    end      
    
    if(srs_type==1)
        [rec_new_spec]=srs_average_envelope(fn,a_abs,NT,format);
    else
        [rec_new_spec]=srs_maximum_envelope(fn,a_abs,NT,format);
    end
    
   
    if(ijk==1)
        rec_new_spec_1=rec_new_spec;
    else
        rec_new_spec_2=rec_new_spec;
    end

 % t_string = sprintf(' Shock Response Spectrum Q=%g ',new_Q1);  

% [fig_num]=srs_plot_function(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax);   
    
    fn=fix_size(fn);
    a_pos=fix_size(a_pos);
    a_neg=fix_size(a_neg);
    
    ppp1=rec_new_spec;
    ppp2=[ fn a_pos ];
    ppp3=[ fn a_neg ];

    leg1='New Spec';
    leg2='Synth Positive';
    leg3='Synth Negative';
    
        
    t_string=sprintf('Shock Response Spectra  Q=%g',new_Q(ijk));

    [fig_num]=plot_loglog_function_md_three(fig_num,x_label,...
                y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);

end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%  format = 1:  ramp & plateau
%           2:  three coordinates arbitrary
%           3:  four coordinates arbitrary

if(format<=2)
    nsrs=3;
else
    nsrs=4;
end

setappdata(0,'acceleration',acceleration); 
setappdata(0,'shock_response_spectrum',srs_syn); 

output_S1='synthesized_acceleration';
output_S2='synthesized_srs_old_Q';

sss=sprintf('%g',new_Q(1));
sss = strrep(sss,'.','p');
output_S3=sprintf('srs_spec_new_Q%s',sss);

assignin('base', output_S1, acceleration);    
assignin('base', output_S2, srs_syn);  
assignin('base', output_S3, rec_new_spec_1); 

if(nQ==2)
    sss=sprintf('%g',new_Q(2));
    sss = strrep(sss,'.','p');    
    output_S4=sprintf('srs_spec_new_Q%s',sss);
    assignin('base', output_S4, rec_new_spec_2); 
end 


disp(' ');
disp('Output arrays: ');
disp(' ');

disp(output_S1);
disp(output_S2);
disp(output_S3);

if(nQ==2)
    disp(output_S4);
end    
    
out1=sprintf('\n New SRS Specification Q=%g ',new_Q(1));
disp(out1);
disp('     fn(Hz)   Accel(G)');
disp(' ');

for i=1:nsrs
    out1=sprintf(' %9.5g  %9.5g',rec_new_spec_1(i,1),rec_new_spec_1(i,2));
    disp(out1);  
end    

if(nQ==2)
    
    out1=sprintf('\n New SRS Specification Q=%g ',new_Q(2));
    disp(out1);
    disp('     fn(Hz)   Accel(G)');
    disp(' ');

    for i=1:nsrs
        out1=sprintf(' %9.5g  %9.5g',rec_new_spec_2(i,1),rec_new_spec_2(i,2));
        disp(out1);  
    end        
    
end    

disp(' ');


t_string='Shock Response Spectra';

if(nQ==1)
    
    leg1=sprintf('New Spec Q=%g',new_Q(ijk));
    leg2=sprintf('Old Spec Q=%g',Q);

    ppp1=rec_new_spec_1;
    ppp2=srs_spec_input;    
    
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md); 
else
    
    iflag=0;
    
    if(new_Q(2)>new_Q(1) && new_Q(1)>Q)
    
        leg1=sprintf('New Spec Q=%g',new_Q(2));        
        leg2=sprintf('New Spec Q=%g',new_Q(1));
        leg3=sprintf('Old Spec Q=%g',Q);

        ppp1=rec_new_spec_2;
        ppp2=rec_new_spec_1;
        ppp3=srs_spec_input;
    
        iflag=1;
        
    end
    if(new_Q(1)>new_Q(2) && new_Q(2)>Q)
        
        leg1=sprintf('New Spec Q=%g',new_Q(1));        
        leg2=sprintf('New Spec Q=%g',new_Q(2));        
        leg3=sprintf('Old Spec Q=%g',Q);

        ppp1=rec_new_spec_1;        
        ppp2=rec_new_spec_2;
        ppp3=srs_spec_input;
        
        iflag=1;
        
    end
    if(iflag==0)
        leg3=sprintf('New Spec Q=%g',new_Q(1));        
        leg2=sprintf('New Spec Q=%g',new_Q(2));        
        leg1=sprintf('Old Spec Q=%g',Q);

        ppp3=rec_new_spec_1;        
        ppp2=rec_new_spec_2;
        ppp1=srs_spec_input;        
    end
    
    
    [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);     
end



set(handles.pushbutton_export,'Enable','on');


toc


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(srs_spec_convert_Q);


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

set(handles.text_input_array_name,'Enable','on');
set(handles.edit_input_array,'Enable','on');

n=get(hObject,'Value');

if(n==1)
   set(handles.pushbutton_read_data,'Enable','off');     
    
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.pushbutton_read_data,'Enable','off');
   
   set(handles.edit_input_array,'enable','off')
   
   set(handles.text_input_array_name,'Enable','off');
   set(handles.edit_input_array,'Enable','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   srs_spec_input = fscanf(fid,'%g %g',[2 inf]);
   srs_spec_input=srs_spec_input';
    
   setappdata(0,'srs_spec_input',srs_spec_input);
   
   
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


% --- Executes on button press in pushbutton_read_data.
function pushbutton_read_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



activate_sample_rate(hObject, eventdata, handles);




function activate_sample_rate(hObject, eventdata, handles)
%
















function edit_trials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trials as text
%        str2double(get(hObject,'String')) returns contents of edit_trials as a double


% --- Executes during object creation, after setting all properties.
function edit_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sample_rate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sample_rate as text
%        str2double(get(hObject,'String')) returns contents of edit_sample_rate as a double


% --- Executes during object creation, after setting all properties.
function edit_sample_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_condition_Callback(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_condition as text
%        str2double(get(hObject,'String')) returns contents of edit_condition as a double


% --- Executes during object creation, after setting all properties.
function edit_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
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

n=get(handles.listbox_output_array,'value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
end
if(n==4)
    data=getappdata(0,'shock_response_spectrum');
end
if(n==5)
    data=getappdata(0,'wavelet_table');
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 





% --- Executes on selection change in listbox_output_array.
function listbox_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_array


% --- Executes during object creation, after setting all properties.
function listbox_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_array (see GCBO)
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



function edit_trials_per_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trials_per_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trials_per_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_trials_per_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_trials_per_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials_per_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_number_of_frequencies_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number_of_frequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number_of_frequencies as text
%        str2double(get(hObject,'String')) returns contents of edit_number_of_frequencies as a double


% --- Executes during object creation, after setting all properties.
function edit_number_of_frequencies_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_of_frequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_condition and none of its controls.
function edit_condition_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'nastran_srs',1);

handles.s=export_junction;
set(handles.s,'Enable','on');




function edit_new_Q1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_Q1 as text
%        str2double(get(hObject,'String')) returns contents of edit_new_Q1 as a double


% --- Executes during object creation, after setting all properties.
function edit_new_Q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type
set(handles.pushbutton_export,'Enable','off');

% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format
set(handles.pushbutton_export,'Enable','off');

% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_Q2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_Q2 as text
%        str2double(get(hObject,'String')) returns contents of edit_new_Q2 as a double


% --- Executes during object creation, after setting all properties.
function edit_new_Q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_Q.
function listbox_num_Q_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_Q contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_Q

set(handles.pushbutton_export,'Enable','off');

n=get(handles.listbox_num_Q,'Value');

if(n==1)
    set(handles.text_new_Q1,'String','New Q');
    set(handles.text_new_Q2,'Enable','off');    
    set(handles.edit_new_Q2,'Enable','off'); 
else
    set(handles.text_new_Q1,'String','1st New Q');    
    set(handles.text_new_Q2,'Enable','on');    
    set(handles.edit_new_Q2,'Enable','on');     
end


% --- Executes during object creation, after setting all properties.
function listbox_num_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_format.
function listbox8_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format


% --- Executes during object creation, after setting all properties.
function listbox8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_trials and none of its controls.
function edit_trials_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_export,'Enable','off');
