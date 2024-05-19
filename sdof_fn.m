function varargout = sdof_fn(varargin)
% SDOF_FN MATLAB code for sdof_fn.fig
%      SDOF_FN, by itself, creates a new SDOF_FN or raises the existing
%      singleton*.
%
%      H = SDOF_FN returns the handle to a new SDOF_FN or the handle to
%      the existing singleton*.
%
%      SDOF_FN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SDOF_FN.M with the given input arguments.
%
%      SDOF_FN('Property','Value',...) creates a new SDOF_FN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sdof_fn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sdof_fn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sdof_fn

% Last Modified by GUIDE v2.5 11-Oct-2016 11:29:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sdof_fn_OpeningFcn, ...
                   'gui_OutputFcn',  @sdof_fn_OutputFcn, ...
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


% --- Executes just before sdof_fn is made visible.
function sdof_fn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sdof_fn (see VARARGIN)

% Choose default command line output for sdof_fn
handles.output = hObject;

% add some additional data as a new field called numberOfErrors

set(handles.Answer,'Enable','off');

%%%%



cmap(1,:)=[0 0.1 0.4];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];      % gold
cmap(16,:)=[0 0.8 0.8];     % turquoise   

clc; 
axes(handles.axes1);
x=[-4 -4 4 4 -4];
y=[4 7 7 4 4]+1;

plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;
x=[-5 5];
y=[ 1 1];
plot(x,y,'Color','k','linewidth',0.75);
y=[0.5 1];
x=[-0.7 0];
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-4.2;
plot(x,y,'Color','k','linewidth',0.75);
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+4.2;
plot(x,y,'Color','k','linewidth',0.75);

text(-0.9,6.5,'m','fontsize',11);
text(-3.5,3,'k','fontsize',11);

nn=2000;

dt=4/(nn-1);

t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=sawtooth(2*pi*t,0.5);
y1=y;

t=3*t/(max(t)-min(t));

plot(y,t+2,'Color',cmap(5,:),'linewidth',0.75);
x=[0 0];
y=[1 1.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);


x=[0 0];
y=[max(t)+2 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-10 10]);
ylim([0 10]);


%%%%



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sdof_fn wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sdof_fn_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function uipanel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in leftlistbox.
function leftlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to leftlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns leftlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from leftlistbox

clear_Answer(hObject, eventdata, handles);

handles.left_index= get(hObject,'value');


guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function leftlistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.leftlistbox = get(hObject,'value');
guidata(hObject, handles);


% --- Executes on selection change in toplistbox.
function toplistbox_Callback(hObject, eventdata, handles,output_index)
% hObject    handle to toplistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns toplistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from toplistbox

calculation=get(handles.toplistbox,'value');

clear_Answer(hObject, eventdata, handles);

set(handles.rightlistbox, 'String', '');
set(handles.leftlistbox, 'String', '');

set(handles.rightlistbox,'Visible','on');
set(handles.leftlistbox,'Visible','on');

if(calculation==1)  % natural frequency
    clear string;
    set(handles.left_text,'String','Mass');
    string{1}='lbm';
    string{2}='lbf sec^2/in';
    string{3}='kg';
    set(handles.leftlistbox,'String',string)
    
    set(handles.right_text,'String','Stiffness');
    clear string;
    string{1}='lbf/in';
    string{2}='lbf/ft';
    string{3}='N/m';
    string{4}='N/mm';
    set(handles.rightlistbox,'String',string)

end
if(calculation==2)  % mass
    set(handles.left_text,'String','Natural Frequency');
    clear string;
    string{1}='Hz';
    string{2}='rad/sec';
    set(handles.leftlistbox,'String',string)  
    
    set(handles.right_text,'String','Stiffness');
    clear string;
    string{1}='lbf/in';
    string{2}='lbf/ft';
    string{3}='N/m';
    string{4}='N/mm';
    set(handles.rightlistbox,'String',string)
end
if(calculation==3)  % stiffness
    set(handles.left_text,'String','Natural Frequency');
    clear string;
    string{1}='Hz';
    string{2}='rad/sec';
    set(handles.leftlistbox,'String',string) 
    
    set(handles.right_text,'String','Mass');
    clear string;
    string{1}='lbm';
    string{2}='lbf sec^2/in';
    string{3}='kg';
    set(handles.rightlistbox,'String',string)
end    



% --- Executes during object creation, after setting all properties.
function toplistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toplistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in rightlistbox.
function rightlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to rightlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rightlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rightlistbox
clear_Answer(hObject, eventdata, handles);

handles.right_index=get(hObject,'value');

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function rightlistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.rightlistbox = get(hObject,'value');
guidata(hObject, handles);


% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Answer,'Enable','on');

tpi=2*pi;
 
Nm_per_lbfin=175.13;
 
kg_per_lbm=0.45351;
kg_per_lbs2pin=175.07;

in_per_meter=39.3701;

mass=0;
stiff=0;
om=0;


na=handles.left_value;
nb=handles.right_value;


AnalysisSelection=get(handles.toplistbox,'value');
LeftSelection=get(handles.leftlistbox,'Value');
RightSelection=get(handles.rightlistbox,'Value');




if(AnalysisSelection==1)  % calculate natural frequency
    
    if(LeftSelection==1)  % convert mass to kg
        na=na*kg_per_lbm;
    end
    if(LeftSelection==2)
        na=na*kg_per_lbs2pin;        
    end    
    
    if(RightSelection==1)  % convert stiffness to N/m
        nb=nb*Nm_per_lbfin;
    end
    if(RightSelection==2)
        nb=nb*Nm_per_lbfin/12;        
    end   
    if(RightSelection==4)
        nb=nb*1000;        
    end   
    
    mass=na;
    stiff=nb;
    
    om=sqrt(stiff/mass);
    fn=om/tpi;
   
    sd=mass*9.81/stiff;           
    sd_s=sprintf('\n\n static deflection at 1 G=\n%8.4g in\n%8.4g mm',...
                   sd*in_per_meter,sd*1000);
    
    fn_s=sprintf('natural frequency=\n%8.4g Hz \n%8.4g rad/sec',fn,om);
    
    fn_s=strcat(fn_s,sd_s);
    
    set(handles.Answer,'String',fn_s);
end
if(AnalysisSelection==2)  % calculate mass
    
    if(LeftSelection==1)  % convert frequency to rad/sec
        na=na*tpi;
    end
    
    if(RightSelection==1)  % convert stiffness to N/m
        nb=nb*Nm_per_lbfin;
    end
    if(RightSelection==2)
        nb=nb*Nm_per_lbfin/12;        
    end   
    if(RightSelection==4)
        nb=nb*1000;        
    end   
    
    om=na;
    stiff=nb;
    
    mass=stiff/om^2;
    
    mass_s=sprintf('mass=\n%8.4g lbm \n%8.4g lbf sec^2/in \n%8.4g kg',...
                               mass/kg_per_lbm,(mass/kg_per_lbm)/386,mass);
                           
    sd=mass*9.81/stiff;           
    sd_s=sprintf('\n\n static deflection at 1 G=\n%8.4g in\n%8.4g mm',...
                   sd*in_per_meter,sd*1000);
    
    mass_s=strcat(mass_s,sd_s);                           
                           
    set(handles.Answer,'String',mass_s);
end
if(AnalysisSelection==3)  % calculate stiffness
    
    
    if(LeftSelection==1)  % convert frequency to rad/sec
        na=na*tpi;
    end
    
    if(RightSelection==1)  % convert mass to kg
        nb=nb*kg_per_lbm;
    end
    if(RightSelection==2)
        nb=nb*kg_per_lbs2pin;        
    end 
    
    
    om=na;
    mass=nb;
    
    stiff=mass*om^2;
    
   
    
    stiff_s=sprintf('stiffness= \n%8.5g lbf/in \n%8.5g lbf/ft \n%8.5g N/m\n%8.5g N/mm',...
                stiff/Nm_per_lbfin,12*stiff/Nm_per_lbfin,stiff,stiff/1000);
    
    sd=mass*9.81/stiff;           
    sd_s=sprintf('\n\n static deflection at 1 G=\n%8.4g in\n%8.4g mm',...
                   sd*in_per_meter,sd*1000);
    
    stiff_s=strcat(stiff_s,sd_s);
            
            
    set(handles.Answer,'String',stiff_s);    
end   
       
    
    
function Answer_Callback(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Answer as text
%        str2double(get(hObject,'String')) returns contents of Answer as a double



% --- Executes during object creation, after setting all properties.
function Answer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function left_input_Callback(hObject, eventdata, handles)
% hObject    handle to left_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of left_input as text
%        str2double(get(hObject,'String')) returns contents of left_input as a double

clear_Answer(hObject, eventdata, handles);

string=get(hObject,'String');
handles.left_value=str2num(string);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function left_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to left_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function clear_Answer(hObject, eventdata, handles)
%
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');
%
guidata(hObject, handles);


function right_input_Callback(hObject, eventdata, handles)
% hObject    handle to right_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of right_input as text
%        str2double(get(hObject,'String')) returns contents of right_input as a double
clear_Answer(hObject, eventdata, handles);

string=get(hObject,'String');
handles.right_value=str2num(string);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function right_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to right_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on left_input and none of its controls.
function left_input_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to left_input (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_Answer(hObject, eventdata, handles);


% --- Executes on key press with focus on right_input and none of its controls.
function right_input_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to right_input (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_Answer(hObject, eventdata, handles);


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

allhandles=findobj(gcf,'style','edit');
for i=1:length(allhandles)
   set(allhandles(i),'string','');
end
handles.left_value=0;
handles.right_value=0;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function Calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
