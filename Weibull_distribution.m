function varargout = Weibull_distribution(varargin)
% WEIBULL_DISTRIBUTION MATLAB code for Weibull_distribution.fig
%      WEIBULL_DISTRIBUTION, by itself, creates a new WEIBULL_DISTRIBUTION or raises the existing
%      singleton*.
%
%      H = WEIBULL_DISTRIBUTION returns the handle to a new WEIBULL_DISTRIBUTION or the handle to
%      the existing singleton*.
%
%      WEIBULL_DISTRIBUTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEIBULL_DISTRIBUTION.M with the given input arguments.
%
%      WEIBULL_DISTRIBUTION('Property','Value',...) creates a new WEIBULL_DISTRIBUTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Weibull_distribution_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Weibull_distribution_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Weibull_distribution

% Last Modified by GUIDE v2.5 06-Jul-2017 17:14:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Weibull_distribution_OpeningFcn, ...
                   'gui_OutputFcn',  @Weibull_distribution_OutputFcn, ...
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


% --- Executes just before Weibull_distribution is made visible.
function Weibull_distribution_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Weibull_distribution (see VARARGIN)

% Choose default command line output for Weibull_distribution
handles.output = hObject;

set(handles.listbox_analysis,'Value',1);

listbox_analysis_Callback(hObject, eventdata, handles);

set(handles.edit_results_box,'Visible','off');
set(handles.edit_results_box,'String',' ');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Weibull_distribution wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles)
%




% --- Outputs from this function are returned to the command line.
function varargout = Weibull_distribution_OutputFcn(hObject, eventdata, handles) 
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
delete(Weibull_distribution);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

alpha=str2num(get(handles.edit_alpha,'String'));

beta=str2num(get(handles.edit_beta,'String'));


if(alpha<=0)
   
    warndlg(' alpha must be > 0 ');
    return;
end
if(beta<=0)
   
    warndlg(' beta must be > 0 ');
    return;
end


X1=str2num(get(handles.edit_X1,'String'));

if(isempty(X1))
    warndlg('Enter X1');
    return;
end

if(n==1)
%   
   q=exp(-(X1/beta)^alpha);
%   
else
    
   X2=str2num(get(handles.edit_X2,'String')); 
%
   q=abs( exp(-(X1/beta)^alpha) - exp(-(X2/beta)^alpha) );
%
end

w=1-q;

set(handles.edit_results_box,'Visible','on');

if(n==1)
    
    s1=sprintf('Exceedance Probability = %12.8g \n\n 1-Probability = %12.8g ',q,w);

else
    
    s1=sprintf('Probability = %12.8g \n\n 1-Probability = %12.8g ',q,w);
    
end

%
set(handles.edit_results_box,'MAX',5);
set(handles.edit_results_box,'Enable','on');
set(handles.edit_results_box,'String',s1);



function edit_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alpha as text
%        str2double(get(hObject,'String')) returns contents of edit_alpha as a double


% --- Executes during object creation, after setting all properties.
function edit_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis

set(handles.edit_results_box,'Visible','off');
set(handles.edit_results_box,'String',' ');

n=get(handles.listbox_analysis,'Value');

set(handles.edit_X1,'Visible','on');
set(handles.edit_X2,'Visible','off'); 
set(handles.text_X2,'String',' ');

if(n==1)
    set(handles.text_X1,'String','X');
else    
    set(handles.text_X1,'String','X1');
    set(handles.text_X2,'String','X2');
    
    set(handles.edit_X2,'Visible','on'); 
end    



% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_box as text
%        str2double(get(hObject,'String')) returns contents of edit_results_box as a double


% --- Executes during object creation, after setting all properties.
function edit_results_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_X1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_X1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_X1 as text
%        str2double(get(hObject,'String')) returns contents of edit_X1 as a double


% --- Executes during object creation, after setting all properties.
function edit_X1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_X1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_X2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_X2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_X2 as text
%        str2double(get(hObject,'String')) returns contents of edit_X2 as a double


% --- Executes during object creation, after setting all properties.
function edit_X2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_X2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_alpha and none of its controls.

% hObject    handle to edit_alpha (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on edit_X1 and none of its controls.
function edit_X1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_X1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results_box,'Visible','off');
set(handles.edit_results_box,'String',' ');


% --- Executes on key press with focus on edit_X2 and none of its controls.
function edit_X2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_X2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results_box,'Visible','off');
set(handles.edit_results_box,'String',' ');


% --- Executes on key press with focus on edit_alpha and none of its controls.
function edit_alpha_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results_box,'Visible','off');
set(handles.edit_results_box,'String',' ');



function edit_beta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beta as text
%        str2double(get(hObject,'String')) returns contents of edit_beta as a double


% --- Executes during object creation, after setting all properties.
function edit_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    
A = imread('Weibull.jpg');
figure(998)     
imshow(A,'border','tight','InitialMagnification',100);


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

alpha=str2num(get(handles.edit_alpha,'String'));

beta=str2num(get(handles.edit_beta,'String'));


if(alpha<=0)
   
    warndlg(' alpha must be > 0 ');
    return;
end
if(beta<=0)
   
    warndlg(' beta must be > 0 ');
    return;
end



xmax= 1.3*beta*(-log(0.01))^(1/alpha);

n=1000;

dx=xmax/n;

xx=zeros(n,1);
yy=zeros(n,1);

KL=alpha/beta;

for i=1:n
    
    x=(i-1)*dx;
    xx(i)=x;
    
    xL=x/beta;
    
    yy(i)=KL*xL^(alpha-1)*exp(-(xL^alpha));
    
end    


sss=sprintf('Weibull Probability Density Function \n alpha=%g  beta=%g ',alpha,beta);

figure(1);
plot(xx,yy);
title(sss);
grid on;
xlabel('x');
ylabel('f(x;k,beta)');
