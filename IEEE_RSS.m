function varargout = IEEE_RSS(varargin)
% IEEE_RSS MATLAB code for IEEE_RSS.fig
%      IEEE_RSS, by itself, creates a new IEEE_RSS or raises the existing
%      singleton*.
%
%      H = IEEE_RSS returns the handle to a new IEEE_RSS or the handle to
%      the existing singleton*.
%
%      IEEE_RSS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IEEE_RSS.M with the given input arguments.
%
%      IEEE_RSS('Property','Value',...) creates a new IEEE_RSS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IEEE_RSS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IEEE_RSS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IEEE_RSS

% Last Modified by GUIDE v2.5 08-Jul-2015 13:48:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IEEE_RSS_OpeningFcn, ...
                   'gui_OutputFcn',  @IEEE_RSS_OutputFcn, ...
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


% --- Executes just before IEEE_RSS is made visible.
function IEEE_RSS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IEEE_RSS (see VARARGIN)

% Choose default command line output for IEEE_RSS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IEEE_RSS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IEEE_RSS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_generate.
function pushbutton_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%

f(1)=0.3;
f(2)=0.4;
f(3)=0.5;
f(4)=0.63;
f(5)=0.8;
f(6)=1.1;
f(7)=8;
f(8)=10.;
f(9)=12.5;
f(10)=16.;
f(11)=20.;
f(12)=25.;
f(13)=33;
f(14)=50;

%%%%%%%%%%%%%%%%%%%%%%%%%%

num=length(f);
a=zeros(num,1);

nlevel=get(handles.listbox_level,'Value');

ndamp=get(handles.listbox_damping,'Value');

if(ndamp==1)
    d=2;
end
if(ndamp==2)
    d=5;
end
if(ndamp==3)
    d=10;
end

beta=(3.21-0.68*log(d))/2.1156;

%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nlevel==1 || nlevel==2) % high PL or high   
%
    for i=1:num;
%
        if(f(i)<=1.1)
            a(i)=1.144*beta*f(i);
        end    
%
        if(f(i)>=1.1 && f(i)<=8)
            a(i)=1.25*beta;
        end
%
        if(f(i)>8 && f(i)<=33)
            a(i)=((13.2*beta-5.28)/f(i)) - (0.4*beta) +0.66;
        end    
%
        if(f(i)>33)
            a(i)=0.5;
        end
%
    end    
%    
    if(nlevel==1)
        a=a*2;
        t_string=sprintf('IEEE 693  RSS High PL  %g%% damp',d);
        aname=sprintf('IEEE_high_PL_RSS_%g_damp_horizontal',d);
        bname=sprintf('IEEE_high_PL_RSS_%g_damp_vertical',d);        
    else
        t_string=sprintf('IEEE 693  RSS High  %g%% damp',d);
        aname=sprintf('IEEE_high_RSS_%g_damp_horizontal',d); 
        bname=sprintf('IEEE_high_RSS_%g_damp_vertical',d);         
    end
%
end
%
if(nlevel==3 || nlevel==4) % moderate PL or moderate   
%
    for i=1:num;
%
        if(f(i)<=1.1)
            a(i)=0.572*beta*f(i);
        end    
%
        if(f(i)>=1.1 && f(i)<=8)
            a(i)=0.625*beta;
        end
%
        if(f(i)>8 && f(i)<=33)
            a(i)=((6.6*beta-2.64)/f(i)) - (0.2*beta) +0.33;
        end    
%
        if(f(i)>33)
            a(i)=0.25;
        end
%
    end    
%
    if(nlevel==3)
        a=a*2;
        t_string=sprintf('IEEE 693  RSS moderate PL  %g%% damp',d);
        aname=sprintf('IEEE_moderate_PL_RSS_%g_damp_horizontal',d);
        bname=sprintf('IEEE_moderate_PL_RSS_%g_damp_vertical',d);        
    else
        t_string=sprintf('IEEE 693  RSS moderate  %g%% damp',d);
        aname=sprintf('IEEE_moderate_RSS_%g_damp_horizontal',d);  
        bname=sprintf('IEEE_moderate_RSS_%g_damp_vertical',d);        
    end
%       
end

ah=a;
av=0.8*a;

%%%%%%%%%%%%%%%%%%%%%%%%%%

f=fix_size(f);
%
IEEE_h=[f ah];
IEEE_v=[f av];
%
fmin=0.1;
fmax=100;
%
fig_num=1000;
figure(fig_num);
plot(f,ah,f,av);
legend ('Horizontal','Vertical'); 
title(t_string);
ymax=10^(ceil(log10(max(ah))));
ymin=10^(floor(log10(min(av))));
%
xlim([fmin fmax]);
ylim([ymin ymax]);
ylabel('Accel (G)');
xlabel('Natural Frequency (Hz)');
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
grid on;
                 
out1=sprintf('Arrays Names: \n\n %s \n %s \n\n units: fn(Hz) & Accel (G)',aname,bname);
msgbox(out1);

assignin('base', aname, IEEE_h);    
assignin('base', bname, IEEE_v);

out1=sprintf('Array Names: \n\n %s \n %s ',aname,bname);
disp(out1);





% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(IEEE_RSS);


% --- Executes on selection change in listbox_level.
function listbox_level_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_level contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_level


% --- Executes during object creation, after setting all properties.
function listbox_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_damping.
function listbox_damping_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_damping contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_damping


% --- Executes during object creation, after setting all properties.
function listbox_damping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
