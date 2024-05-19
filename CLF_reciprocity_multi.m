function varargout = CLF_reciprocity_multi(varargin)
% CLF_RECIPROCITY_MULTI MATLAB code for CLF_reciprocity_multi.fig
%      CLF_RECIPROCITY_MULTI, by itself, creates a new CLF_RECIPROCITY_MULTI or raises the existing
%      singleton*.
%
%      H = CLF_RECIPROCITY_MULTI returns the handle to a new CLF_RECIPROCITY_MULTI or the handle to
%      the existing singleton*.
%
%      CLF_RECIPROCITY_MULTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLF_RECIPROCITY_MULTI.M with the given input arguments.
%
%      CLF_RECIPROCITY_MULTI('Property','Value',...) creates a new CLF_RECIPROCITY_MULTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CLF_reciprocity_multi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CLF_reciprocity_multi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CLF_reciprocity_multi

% Last Modified by GUIDE v2.5 30-Dec-2015 13:24:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CLF_reciprocity_multi_OpeningFcn, ...
                   'gui_OutputFcn',  @CLF_reciprocity_multi_OutputFcn, ...
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


% --- Executes just before CLF_reciprocity_multi is made visible.
function CLF_reciprocity_multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CLF_reciprocity_multi (see VARARGIN)

% Choose default command line output for CLF_reciprocity_multi
handles.output = hObject;

data_s{1,1} = 'Center Freq (Hz)';  
data_s{2,1} = 'Coupling Loss Factor 12'; 
data_s{3,1} = 'Modal Density Subsystem 1'; 
data_s{4,1} = 'Modal Density Subsystem 2';


set(handles.uitable_variables,'Data',data_s)


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CLF_reciprocity_multi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CLF_reciprocity_multi_OutputFcn(hObject, eventdata, handles) 
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

delete(CLF_reciprocity_multi);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

sz=size(THM);

if(sz(2)~=4)
   warndlg('Input array must have 4 columns');  
   return; 
end

f=THM(:,1);
clf_12=THM(:,2);
n1=THM(:,3);
n2=THM(:,4);

NL=length(f);

clf_21=zeros(NL,1);

for i=1:NL
  clf_21(i)=clf_12(i)*(n1(i)/n2(i));
end



    f=fix_size(f);
        
   
    x_label='Frequency (Hz)';
   
    
    fmin=min(f);
    fmax=max(f);
    
    clf_12=[f clf_12];
    clf_21=[f clf_21];        
    
    fig_num=1;
    md=3;
       
   
     t_string='Modal Density';
     y_label='Modal Density (modes/Hz)';
     leg1='subsystem 1';
     leg2='subsystem 2';
     ppp1=[f n1];
     ppp2=[f n2];
    
   [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);    
    
    
    t_string='Coupling Loss Factors';
    y_label='Coupling Loss Factor';
    ppp1=clf_12;
    ppp2=clf_21;
    
    leg1='clf 12';
    leg2='clf 21';
    
   [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
    
    
                    
    disp('  ');
    disp('  Freq(Hz)   clf_12    clf_21   ');
    disp('                                ');
                 
    for i=1:NL
        out1=sprintf(' %6.0f    %8.4g  %8.4g ',f(i),clf_12(i,2),clf_21(i,2));
        disp(out1);
    end
         
    disp(' ');
    disp(' Coupling Loss Factor Arrays: clf_12, clf_21');
    
    
    assignin('base','clf_12',clf_12); 
    assignin('base','clf_21',clf_21);       
    
msgbox('Results written to Command Window');


function edit_clf_12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf_12 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf_12 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md1 as text
%        str2double(get(hObject,'String')) returns contents of edit_md1 as a double


% --- Executes during object creation, after setting all properties.
function edit_md1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md2 as text
%        str2double(get(hObject,'String')) returns contents of edit_md2 as a double


% --- Executes during object creation, after setting all properties.
function edit_md2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clf_21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf_21 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf_21 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_clf_12 and none of its controls.
function edit_clf_12_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_md1 and none of its controls.
function edit_md1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_md2 and none of its controls.
function edit_md2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('CLF_reciprocity.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100)



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
