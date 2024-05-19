function varargout = half_sine_shock_test_shaker(varargin)
% HALF_SINE_SHOCK_TEST_SHAKER MATLAB code for half_sine_shock_test_shaker.fig
%      HALF_SINE_SHOCK_TEST_SHAKER, by itself, creates a new HALF_SINE_SHOCK_TEST_SHAKER or raises the existing
%      singleton*.
%
%      H = HALF_SINE_SHOCK_TEST_SHAKER returns the handle to a new HALF_SINE_SHOCK_TEST_SHAKER or the handle to
%      the existing singleton*.
%
%      HALF_SINE_SHOCK_TEST_SHAKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HALF_SINE_SHOCK_TEST_SHAKER.M with the given input arguments.
%
%      HALF_SINE_SHOCK_TEST_SHAKER('Property','Value',...) creates a new HALF_SINE_SHOCK_TEST_SHAKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before half_sine_shock_test_shaker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to half_sine_shock_test_shaker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help half_sine_shock_test_shaker

% Last Modified by GUIDE v2.5 23-Oct-2018 17:15:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @half_sine_shock_test_shaker_OpeningFcn, ...
                   'gui_OutputFcn',  @half_sine_shock_test_shaker_OutputFcn, ...
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


% --- Executes just before half_sine_shock_test_shaker is made visible.
function half_sine_shock_test_shaker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to half_sine_shock_test_shaker (see VARARGIN)

% Choose default command line output for half_sine_shock_test_shaker
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes half_sine_shock_test_shaker wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = half_sine_shock_test_shaker_OutputFcn(hObject, eventdata, handles) 
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

delete(c_shock_test_shaker);


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

iu=get(handles.listbox_unit,'Value');

amp=str2num(get(handles.edit_amp,'String'));
hsd=str2num(get(handles.edit_dur,'String'));

peak=amp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
dt=hsd/20;
%
[sr,dt]=set_sr(dt);
%
pad=8*hsd;
total_dur=hsd + 2*pad;

%
nys=round(total_dur/dt);
%
tt0=0;
tt1=pad+tt0;
tt2= hsd+tt1;

t=zeros(nys,1);
y=zeros(nys,1);

for i=1:nys
    t(i)=dt*(i-1);
    if(t(i) >=tt1 && t(i)<=tt2 )
       y(i)=amp*sin(pi*( t(i)-tt1)/hsd);    
    end   
end

AL=0.20*amp;

amp=y;
amp_original=y;

%%%%%%%%%%%%%%%%%%%%%%

ffmin=1./(total_dur/2);
ffmax=sr/10;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%
sume=1.0e+10;
drecord=1.0e+10;
error_all=1.0e+10;
%
%     	

nt=str2num(get(handles.edit_nt,'String'));
nfr=get(handles.listbox_nfr,'Value');
kjv_num=str2num(get(handles.edit_kjv_num,'String'));


x1r=zeros(nfr,1);	
x2r=zeros(nfr,1);	
x3r=zeros(nfr,1);	
x4r=zeros(nfr,1);

%
num2=max(size(y));
%
clear y;
		
duration=t(num2)-t(1);
%
%
out1=sprintf(' sample rate = %10.4g \n',sr);
disp(out1);
%
fl=3./duration;
fu=sr/5.;
%
clear y;
%
progressbar;

for kjv=1:kjv_num
%
    progressbar(kjv/kjv_num);

    residual=amp_original;
    rsum=residual-residual;
%
    for ie=1:nfr
%
        [error_max,x1r,x2r,x3r,x4r]=...
              wgen_hs(num2,t,residual,duration,sr,x1r,x2r,x3r,x4r,fl,fu,nt,ie,ffmin,ffmax,tt1,tt2,AL,rsum,amp_original);
%
        if(x2r(ie)<ffmin*tp)
            x2r(ie)=ffmin*tp;
            x1r(ie)=1.0e-20;
            x3r(ie)=3;
            x4r(ie)=0;
        end
%
        for(i=1:num2)
%			
	    tt=t(i);
%
		t1=x4r(ie) + t(1);
		t2=t1 + tp*x3r(ie)/(2.*x2r(ie));
%
		y=0.;
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
    ave=mean(residual); 
    sd=std(residual);
%
%%    out1=sprintf(' ave=%12.4g  sd=%12.4g \n\n',ave,sd);
%%    disp(out1);       
%			 
%			 
    end    
%
    [wavelet_table]=hs_syn_wavelet_table(nfr,ffmin,tp,x1r,x2r,x3r,x4r);
%
    [aaa,vvv,ddd,amp]=hs_syn_wavelet_reconstruction(num2,t,x1r,x2r,x3r,x4r,tp,nfr,amp);
  
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

    if( sumed<sume && error_max < 1.3*error_all && dmax < 1.3*drecord) 
        error_all=error_max;
        drecord=dmax;
        sume=sumed;
        out1=sprintf('** %g  %g \n',error_all,drecord);
        disp(out1);
        aaa_r=aaa;
        vvv_r=vvv;
        ddd_r=ddd;
    end
    disp(' ');
end
%%

progressbar(1);

% error=[t,amp];

accel=[t,aaa_r];
velox=[t,vvv_r];
dispx=[t,ddd_r];
wavelet_table_r=wavelet_table;
%

%
%%%%%%%%%%%%%%
%

xlabel3='Time (sec)';

ylabel1='Accel (G)';

if(iu==1)
    ylabel2='Vel (in/sec)';
    ylabel3='Disp (in)';
    velox(:,2)=velox(:,2)*386;
    dispx(:,2)=dispx(:,2)*386;
else
    ylabel2='Vel (cm/sec)';
    ylabel3='Disp (mm)';
    velox(:,2)=velox(:,2)*9.81/100;
    dispx(:,2)=dispx(:,2)*9.81/1000;
end

data1=accel;
data2=velox;
data3=dispx;

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
setappdata(0,'accel',accel)
setappdata(0,'velox',velox)
setappdata(0,'dispx',dispx)
setappdata(0,'wavelet_table',wavelet_table_r)
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
