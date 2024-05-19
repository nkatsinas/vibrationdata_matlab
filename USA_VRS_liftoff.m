function varargout = USA_VRS_liftoff(varargin)
% USA_VRS_liftoff MATLAB code for USA_VRS_liftoff.fig
%      USA_VRS_liftoff, by itself, creates a new USA_VRS_liftoff or raises the existing
%      singleton*.
%
%      H = USA_VRS_liftoff returns the handle to a new USA_VRS_liftoff or the handle to
%      the existing singleton*.
%
%      USA_VRS_liftoff('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USA_VRS_liftoff.M with the given input arguments.
%
%      USA_VRS_liftoff('Property','Value',...) creates a new USA_VRS_liftoff or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before USA_VRS_liftoff_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to USA_VRS_liftoff_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help USA_VRS_liftoff

% Last Modified by GUIDE v2.5 26-Sep-2017 13:49:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @USA_VRS_liftoff_OpeningFcn, ...
                   'gui_OutputFcn',  @USA_VRS_liftoff_OutputFcn, ...
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


% --- Executes just before USA_VRS_liftoff is made visible.
function USA_VRS_liftoff_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to USA_VRS_liftoff (see VARARGIN)

% Choose default command line output for USA_VRS_liftoff
handles.output = hObject;

clear_results(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes USA_VRS_liftoff wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function clear_results(hObject, eventdata, handles)

set(handles.uipanel_results,'Visible','off');



% --- Outputs from this function are returned to the command line.
function varargout = USA_VRS_liftoff_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_zone.
function listbox_zone_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_zone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_zone contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_zone

clear_results(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_zone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_zone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_axis.
function listbox_axis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_axis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_axis
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_axis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_weight.
function listbox_weight_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_weight contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_weight
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_weight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_weight (see GCBO)
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


function Input_PSD(hObject, eventdata, handles)




function Interpolate_PSD(hObject, eventdata, handles)
%
psd_in=[20 0.5 ; 200 5 ; 500 5 ; 2000 0.3];

f=psd_in(:,1);
a=psd_in(:,2);

df=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MAX = 12000;
%
ra=0.;
grms=0.;
iflag=0;
%
s=zeros(1,MAX);
%
if(f(1) < .0001)
    f(1)=[];
    a(1)=[];
end
%
nn=length(f)-1;
%
for  i=1:nn
%
    if(  f(i) <=0 )
        disp(' frequency error ')
        out=sprintf(' f(%d) = %6.2f ',i,f(i));
        disp(out)
        iflag=1;
    end
    if(  a(i) <=0 )
        disp(' amplitude error ')
        out=sprintf(' a(%d) = %6.2f ',i,a(i));
        disp(out)
        iflag=1;
    end  
    if(  f(i+1) < f(i) )
        disp(' frequency error ')
        iflag=1;
    end  
    if(  iflag==1)
        break;
    end
%    
    s(i)=log10( a(i+1)/ a(i) )/log10( f(i+1)/f(i) );
%   
 end
 %
 %disp(' RMS calculation ');
 %
 if( iflag==0)
    for i=1:nn
        if(s(i) < -1.0001 ||  s(i) > -0.9999 )
            ra = ra + ( a(i+1) * f(i+1)- a(i)*f(i))/( s(i)+1.);
        else
            ra = ra + a(i)*f(i)*log( f(i+1)/f(i));
        end
    end
    grms_input=sqrt(ra);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    if(f(1) < .0001)
        f(1)=[];
        a(1)=[];
    end
%
    m=length(f);
%
%   recalculate slope
%
    for i=1:m-1
        s(i)=log(  a(i+1) / a(i)  )/log( f(i+1) / f(i) );
    end    
%
	fi(1)=f(1);
	ai(1)=a(1);
%
    MAX = 100000;
%   
    for  i=2:MAX 
%       
		fi(i)=fi(i-1)+df; 
%
        if( fi(i) > f(m) )
            fi(i)=[];
            break;
        end 
%
        for j=1:(m-1)
%
			if( ( fi(i) >= f(j) ) && ( fi(i) <= f(j+1) )  )
				ai(i)=a(j)*( ( fi(i) / f(j) )^ s(j) );
				break;
            end
        end
%               
    end
    nn=length(fi);
    ai(nn)=a(m);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[fi,ai]=interpolate_PSD(f,a,s,df);

psd_interp=[fi' ai'];

setappdata(0,'psd_interp',psd_interp);
setappdata(0,'df',df);
setappdata(0,'grms_input',grms_input);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



fn=str2num(get(handles.edit_fn,'String'));


if(isempty(fn))
    warndlg('Enter Natural Frequency ');
    return;
end

if(fn<1.0e-10)
    warndlg('fn must be > 0 ');
    return;    
end
if(fn>2000)
    warndlg('fn must be <= 2000 ');
    return;    
end


Q=str2num(get(handles.edit_Q,'String'));

if(isempty(Q))
    warndlg('Enter Q ');
    return;
end

damp=1/(2*Q);

dur=str2num(get(handles.edit_duration,'String'));


C=sqrt(2*log(fn*dur));
ms=C + (0.5772/C);

%%%%
%
%  identify input PSD
%

Input_PSD(hObject, eventdata, handles);

Interpolate_PSD(hObject, eventdata, handles);

psd_interp=getappdata(0,'psd_interp');

try
    fi=psd_interp(:,1);
    ai=psd_interp(:,2);
catch
    warndlg('Data error');
    return;
end

%%%%

df=getappdata(0,'df');

last=length(fi);

sum=0.; 
%
b=zeros(last,1);

for j=1:last 
%
		    rho = fi(j)/fn;
			tdr=2.*damp*rho;
%
            c1= tdr^ 2.;
			c2= (1.- (rho^2.))^ 2.;
%
			t= (1.+ c1 ) / ( c2 + c1 );
            sum = sum + t*ai(j)*df;
            
            b(j)=t*ai(j);
%       
end
%        
a1=sqrt(sum);
a2=3*a1;
a3=ms*a1;

set(handles.uipanel_results,'Visible','on');
sss=sprintf('Overall = %8.4g GRMS \n\n 3-sigma = %8.4g G\n\n Peak Estimate = %8.4g G',a1,a2,a3);
set(handles.edit_output,'String',sss);


np=get(handles.listbox_plot,'Value');

if(np==1)
    grms_input=getappdata(0,'grms_input');
    t_string=sprintf('PSD    fn=%g Hz   Q=%g ',fn,Q);
%
    figure(1);
    plot(fi,ai,fi,b)
    out1=sprintf('Input %7.3g GRMS',grms_input);
    out2=sprintf('Response %7.3g GRMS',a1);
    legend(out1,out2);
    ylabel('Accel (G^2/Hz)');   
    xlabel('Frequency (Hz)');
    
    title(t_string);
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');
  
    xlim([20 2000]);
    xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000];
    xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000'};    
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);   
    
    md=6;
    
    aa=[ai;b];
    
    ymax= 10^ceil(log10(max(1.2*aa)));
%
    ymin= 10^floor(log10(min(aa)));

    if(ymin<ymax/10^md)
        ymin=ymax/10^md;
    end

    if(ymin==ymax)
        ymin=ymin/10;
        ymax=ymax*10;
    end     
    
    ylim([ymin ymax]);
    
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


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_output_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output as text
%        str2double(get(hObject,'String')) returns contents of edit_output as a double


% --- Executes during object creation, after setting all properties.
function edit_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_plot.
function listbox_plot_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plot


% --- Executes during object creation, after setting all properties.
function listbox_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
