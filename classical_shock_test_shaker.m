function varargout = classical_shock_test_shaker(varargin)
% CLASSICAL_SHOCK_TEST_SHAKER MATLAB code for classical_shock_test_shaker.fig
%      CLASSICAL_SHOCK_TEST_SHAKER, by itself, creates a new CLASSICAL_SHOCK_TEST_SHAKER or raises the existing
%      singleton*.
%
%      H = CLASSICAL_SHOCK_TEST_SHAKER returns the handle to a new CLASSICAL_SHOCK_TEST_SHAKER or the handle to
%      the existing singleton*.
%
%      CLASSICAL_SHOCK_TEST_SHAKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLASSICAL_SHOCK_TEST_SHAKER.M with the given input arguments.
%
%      CLASSICAL_SHOCK_TEST_SHAKER('Property','Value',...) creates a new CLASSICAL_SHOCK_TEST_SHAKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before classical_shock_test_shaker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to classical_shock_test_shaker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help classical_shock_test_shaker

% Last Modified by GUIDE v2.5 26-Oct-2018 08:31:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @classical_shock_test_shaker_OpeningFcn, ...
                   'gui_OutputFcn',  @classical_shock_test_shaker_OutputFcn, ...
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


% --- Executes just before classical_shock_test_shaker is made visible.
function classical_shock_test_shaker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to classical_shock_test_shaker (see VARARGIN)

% Choose default command line output for classical_shock_test_shaker
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');
listbox_method_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes classical_shock_test_shaker wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = classical_shock_test_shaker_OutputFcn(hObject, eventdata, handles) 
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

delete(classical_shock_test_shaker);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('   ');
disp(' * * * * * * ');
disp('   ');


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );

if(NFigures>5)
    NFigures=5;
end

for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


fig_num=1;

tpi=2*pi;
tp=tpi;


nmethod=get(handles.listbox_method,'Value');
ntype=get(handles.listbox_type,'Value');
iu=get(handles.listbox_unit,'Value');

amp=str2num(get(handles.edit_amp,'String'));
hsd=str2num(get(handles.edit_dur,'String'));

peak=amp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%

sr=str2num(get(handles.edit_sr,'String'));
dt=1/sr;

%


pad=8*hsd;


total_dur=hsd + 2*pad;

%
nys=round(total_dur/dt);
%
tt0=0;
tt1=pad+tt0;
tt2= hsd+tt1;


if(ntype==1)

    t=zeros(nys,1);
    y=zeros(nys,1);

    for i=1:nys
        t(i)=dt*(i-1);
        if(t(i) >=tt1 && t(i)<=tt2 )
            y(i)=sin(pi*( t(i)-tt1)/hsd);
        end
    end
else
    [tsaw_model,yts]=tsaw_model_function(sr,hsd);
    t=tsaw_model(:,1);
    y=tsaw_model(:,2);
    y=y/max(y);
    yts=yts/max(yts);
end

%%%%%%%%%%%%%%%

y=y*amp;


AL=0.20*amp;



if(ntype==1)
    amp_original=y;
else
    amp_original=yts*amp;
end
amp_original=y;

amp=y;

num2=max(size(y));
duration=t(num2)-t(1);
ffmin=1./(total_dur/2);
ffmax=sr/12;

if(nmethod==2)
%

%
    sume=1.0e+10;
    drecord=1.0e+10;
    error_all=1.0e+10;
%
    nt=str2num(get(handles.edit_nt,'String'));
    nfr=get(handles.listbox_nfr,'Value');
    kjv_num=str2num(get(handles.edit_kjv_num,'String'));

    x1r=zeros(nfr,1);	
    x2r=zeros(nfr,1);	
    x3r=zeros(nfr,1);	
    x4r=zeros(nfr,1);
%
    clear y;		
%
    out1=sprintf(' sample rate = %10.4g \n',sr);
    disp(out1);
%
    fl=3./duration;
    fu=sr/5.;
%
    clear y;

    progressbar;

    for kjv=1:kjv_num
%
        progressbar(kjv/kjv_num);

        residual=amp_original;
        rsum=residual-residual;
%
        for ie=1:nfr
%
            if(ntype==1)
                [error_max,x1r,x2r,x3r,x4r]=...
                  wgen_hs(num2,t,residual,duration,sr,x1r,x2r,x3r,x4r,fl,fu,nt,ie,ffmin,ffmax,tt1,tt2,AL,rsum,amp_original);
            else
                [error_max,x1r,x2r,x3r,x4r]=...
                  wgen_ts(num2,t,residual,duration,sr,x1r,x2r,x3r,x4r,fl,fu,nt,ie,ffmin,ffmax,tt1,tt2,AL,rsum,amp_original);            
            end
%
            if(x2r(ie)<ffmin*tp)
                x2r(ie)=ffmin*tp;
                x1r(ie)=1.0e-20;
                x3r(ie)=3;
                x4r(ie)=0;
            end
%
            for i=1:num2
%			
                tt=t(i);
%
                t1=x4r(ie) + t(1);
                t2=t1 + tp*x3r(ie)/(2.*x2r(ie));
%
                if( tt>= t1 && tt <= t2)
%				
                    arg=x2r(ie)*(tt-t1);  
                    y=x1r(ie)*sin(arg/double(x3r(ie)))*sin(arg);
                    rsum(i)=rsum(i)+y;
%
                    residual(i)=residual(i)-y;
                end
            end       
%			 
        end    
%
        [wavelet_table]=hs_syn_wavelet_table(nfr,ffmin,tp,x1r,x2r,x3r,x4r);
%
        [aaa,vvv,ddd,amp]=hs_syn_wavelet_reconstruction(num2,t,x1r,x2r,x3r,x4r,tp,nfr,amp,ffmin);
  
        scale=peak/max(aaa);
        aaa=aaa*scale;
        vvv=vvv*scale;
        ddd=ddd*scale;
        wavelet_table(:,3)=wavelet_table(:,3)*scale;
        x1r=x1r*scale;
%
        dmax=max(abs(ddd));
        sumed=dmax*error_max;
        if(iu==1)
            ddmax=dmax*386;
        else
            ddmax=dmax*9.81*1000;
        end

        out1=sprintf(' %d  error_max=%g  dmax=%g %g \n',kjv,error_max,ddmax,sumed);
        disp(out1);

        if( sumed<sume && error_max < 1.5*error_all && dmax < 1.5*drecord) 

            if(error_all>error_max)
                error_all=error_max;
            end

            if(drecord>dmax)
                drecord=dmax;
            end

            sume=sumed;
            out1=sprintf('** %g  %g \n',error_all,drecord);
            disp(out1);
            aaa_r=aaa;
            vvv_r=vvv;
            ddd_r=ddd;
            wavelet_table_r=wavelet_table;
        end
        disp(' ');
    end
%%
    progressbar(1);

% error=[t,amp];


else
%%%%%%%%%%%%%%%%%%%%%%%%%%%




    if(ntype==1)
          x1r=[ 14.1537   -35.8463  ];
          x2r=[ 17.174  52.474 ];
          x3r=[ 5   3  ];
          x4r=[ 0.0206 0.0791 ];
          tscale=(0.011/hsd);
    else
          load('tsaw_wavelet_table.mat','tsaw_wavelet_table');
          x1r=tsaw_wavelet_table(:,3);
          x2r=tsaw_wavelet_table(:,2);
          x3r=tsaw_wavelet_table(:,4);
          x4r=tsaw_wavelet_table(:,5);
          tscale=(0.030/hsd);

          nfr=length(x1r);
 
          for i=nfr:-1:1
                if(x2r(i)>sr/8)
                    tsaw_wavelet_table(i,:)=[];
                end
          end
          x1r=tsaw_wavelet_table(:,3);
          x2r=tsaw_wavelet_table(:,2);
          x3r=tsaw_wavelet_table(:,4);
          x4r=tsaw_wavelet_table(:,5);
    end

    
    x2r=x2r*tpi*tscale; 
    x4r=x4r/tscale;


    nfr=length(x1r);
    [aaa,vvv,ddd,~]=hs_syn_wavelet_reconstruction(num2,t,x1r,x2r,x3r,x4r,tp,nfr,amp,ffmin);

%%%
    
    [~,Ia]=max(amp_original);
    [~,Ib]=max(aaa);

    Id=Ia-Ib;

    if(Id>=1)

        N=length(aaa);

        aaa_n=zeros(N,1);
        aaa_n(Id:N)=aaa(1:(N-Id+1));

        clear aaa;
        aaa=aaa_n;

        vvv_n=zeros(N,1);
        vvv_n(Id:N)=vvv(1:(N-Id+1));

        clear vvv;
        vvv=vvv_n;

        ddd_n=zeros(N,1);
        ddd_n(Id:N)=ddd(1:(N-Id+1));

        clear ddd;
        ddd=ddd_n;
    end 

%%%


    wavelet_table=zeros(nfr,5);

    for i=1:nfr
        wavelet_table(i,:)=[ i x1r(i) x2r(i) x3r(i) x4r(i)];
    end
 
    scale=peak/max(aaa);
    aaa_r=aaa*scale;
    vvv_r=vvv*scale;
    ddd_r=ddd*scale;
    wavelet_table(:,3)=wavelet_table(:,3)*scale;
  
    wavelet_table_r=wavelet_table;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    aaa_r=fix_size(aaa_r);
    vvv_r=fix_size(vvv_r);
    ddd_r=fix_size(ddd_r);

    accel_r=[t aaa_r];
    velox_r=[t vvv_r];
    dispx_r=[t ddd_r];
%
    disp(' ');
    disp('  Best case ');
    disp(' ');

    for i=1:nfr

        out1=sprintf(' amp=%10.4f   freq=%10.3f Hz   nhs=%d   delay=%10.4f ',...
          wavelet_table_r(i,3),wavelet_table_r(i,2),wavelet_table_r(i,4),wavelet_table_r(i,5));
        disp(out1);

    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlabel3='Time (sec)';
ylabel1='Accel (G)';

if(iu==1)
    ylabel2='Vel (in/sec)';
    ylabel3='Disp (in)';
    velox_r(:,2)=velox_r(:,2)*386;
    dispx_r(:,2)=dispx_r(:,2)*386;
else
    ylabel2='Vel (cm/sec)';
    ylabel3='Disp (mm)';
    velox_r(:,2)=velox_r(:,2)*9.81/100;
    dispx_r(:,2)=dispx_r(:,2)*9.81/1000;
end


setappdata(0,'accel',accel_r);
setappdata(0,'velox',velox_r);
setappdata(0,'dispx',dispx_r);
setappdata(0,'wavelet',wavelet_table_r);

data1=accel_r;
data2=velox_r;
data3=dispx_r;

t_string1='Acceleration';
t_string2='Velocity';
t_string3='Displacement';

[fig_num]=subplots_three_linlin_three_titles(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);

figure(fig_num);
plot(t,amp_original,t,aaa_r);
legend ('specification','synthesis');         
title(' Acceleration Time History ');
xlabel(' Time(sec)');
ylabel(' Accel(G)');
grid on;
%
%%%%%%%%%%%%%%
%
setappdata(0,'wavelet_table',wavelet_table_r);
%

set(handles.uipanel_save,'Visible','on');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function edit_amp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amp as text
%        str2double(get(hObject,'String')) returns contents of edit_amp as a double


% --- Executes during object creation, after setting all properties.
function edit_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
set(handles.uipanel_save,'Visible','off');

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


% --- Executes on selection change in listbox_nfr.
function listbox_nfr_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nfr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nfr contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nfr
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_nfr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nfr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kjv_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kjv_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kjv_num as text
%        str2double(get(hObject,'String')) returns contents of edit_kjv_num as a double


% --- Executes during object creation, after setting all properties.
function edit_kjv_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kjv_num (see GCBO)
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

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'accel');
end
if(n==2)
    data=getappdata(0,'velox');
end
if(n==3)
    data=getappdata(0,'disp');
end
if(n==4)
    data=getappdata(0,'wavelet');
end

output_name=get(handles.edit_output_array_name,'String');

assignin('base', output_name, data);

msgbox('Save complete');


% --- Executes on key press with focus on edit_amp and none of its controls.
function edit_amp_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_dur and none of its controls.
function edit_dur_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_nt and none of its controls.
function edit_nt_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nt (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_kjv_num and none of its controls.
function edit_kjv_num_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_kjv_num (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


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


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


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



function edit_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


n=get(handles.listbox_method,'Value');

if(n==1)
    set(handles.text_trials,'Visible','off');
    set(handles.edit_nt,'Visible','off');
    set(handles.text_cases,'Visible','off');
    set(handles.edit_kjv_num,'Visible','off');
    set(handles.text_nfr,'Visible','off');
    set(handles.listbox_nfr,'Visible','off');
else
    set(handles.text_trials,'Visible','on');
    set(handles.edit_nt,'Visible','on');
    set(handles.text_cases,'Visible','on');
    set(handles.edit_kjv_num,'Visible','on');
    set(handles.text_nfr,'Visible','on');
    set(handles.listbox_nfr,'Visible','on');
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
