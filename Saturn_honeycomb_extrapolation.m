function varargout = Saturn_honeycomb_extrapolation(varargin)
% SATURN_HONEYCOMB_EXTRAPOLATION MATLAB code for Saturn_honeycomb_extrapolation.fig
%      SATURN_HONEYCOMB_EXTRAPOLATION, by itself, creates a new SATURN_HONEYCOMB_EXTRAPOLATION or raises the existing
%      singleton*.
%
%      H = SATURN_HONEYCOMB_EXTRAPOLATION returns the handle to a new SATURN_HONEYCOMB_EXTRAPOLATION or the handle to
%      the existing singleton*.
%
%      SATURN_HONEYCOMB_EXTRAPOLATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SATURN_HONEYCOMB_EXTRAPOLATION.M with the given input arguments.
%
%      SATURN_HONEYCOMB_EXTRAPOLATION('Property','Value',...) creates a new SATURN_HONEYCOMB_EXTRAPOLATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Saturn_honeycomb_extrapolation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Saturn_honeycomb_extrapolation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Saturn_honeycomb_extrapolation

% Last Modified by GUIDE v2.5 17-Nov-2017 12:25:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Saturn_honeycomb_extrapolation_OpeningFcn, ...
                   'gui_OutputFcn',  @Saturn_honeycomb_extrapolation_OutputFcn, ...
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


% --- Executes just before Saturn_honeycomb_extrapolation is made visible.
function Saturn_honeycomb_extrapolation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Saturn_honeycomb_extrapolation (see VARARGIN)

% Choose default command line output for Saturn_honeycomb_extrapolation
handles.output = hObject;

listbox_units_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Saturn_honeycomb_extrapolation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Saturn_honeycomb_extrapolation_OutputFcn(hObject, eventdata, handles) 
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

delete(Saturn_honeycomb_extrapolation);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp(' ');

fig_num=1;

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

f=THM(:,1);
a=THM(:,2);

iu=get(handles.listbox_units,'Value');

md=str2num(get(handles.edit_md,'String'));

diam=str2num(get(handles.edit_diam,'String'));

if(iu==2)
   md=md*0.20485;    % convert kg/m^2 to lbm/ft^2
   diam=diam*3.2808; % convert m to ft
end



spl_ref=[20	136.0
25	138.1
31.5	140.1
40	141.6
50	142.8
63	144.0
80	145.4
100	146.5
125	146.6
160	146.1
200	145.4
250	144.6
315	143.8
400	142.9
500	142.2
630	141.5
800	140.6
1000	139.8
1250	138.6
1600	137.0
2000	135.7];


psd_ref=[20	0.3932
25	0.574
31.5	1.2423
40	2.1222
50	3.4913
63	6.7626
80	7.021
100	4.128
125	6.2074
160	5.9277
200	10.0299
250	6.5851
315	6.0243
400	4.0677
500	1.782
630	2.2665
800	2.2456
1000	1.116
1250	0.8885
1600	1.0535
2000	1
];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mscale=(1.1/md);

out1=sprintf('\n  mass density scale factor = %8.4g  \n',mscale);
disp(out1);


dscale=(22/diam);

out1=sprintf('\n  diameter scale factor = %8.4g  \n',dscale);
disp(out1);

% disp('  Freq    Ref PSD    New PSD ');
% disp('  (Hz)    (G^2/Hz)   (G^2/Hz)');

num=length(f);

psd_ext=zeros(num,1);

nf=zeros(num,1);

for i=1:num
   
   [~,index] = min(abs(spl_ref(:,1)-f(i)));
   
   delta_dB=a(i)-spl_ref(index,2);

   ratio=10^( delta_dB/10  );

   psd_ext(i)=ratio*psd_ref(index,2);
   
   psd_ext(i)=psd_ext(i)*mscale;  % mass/area scaling
   
   nf(i)=f(i)*dscale;
   
%   out1=sprintf('%7.4g   %7.3g  %7.3g ',f(i),psd_ref(index,2),psd_ext(i));
%   disp(out1);
    
end

for i=num:-1:1
    if(nf(i)<20)
        nf(i)=[];
        psd_ext(i)=[];
    end
end


psd_ext=[nf psd_ext]; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_type=1;

f1=f;
dB1=a;

f2=spl_ref(:,1);
dB2=spl_ref(:,2);

string_1='New ';
string_2='Saturn V';

[fig_num]=spl_plot_two(fig_num,n_type,f1,dB1,f2,dB2,string_1,string_2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

md=5;

x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';

t_string='PSD  Honeycomb Sandwich Cylinder';

fmin=min([20 min(nf)]);
fmax=max([2000 max(nf)]);

ppp1=psd_ext;
ppp2=psd_ref;

[s,grms1] = calculate_PSD_slopes(ppp1(:,1),ppp1(:,2));
[s,grms2] = calculate_PSD_slopes(ppp2(:,1),ppp2(:,2));


leg1=sprintf('New PSD %7.3g GRMS',grms1);
leg2=sprintf('Saturn V PSD %7.3g GRMS',grms2);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
           
           
          

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.uipanel_save,'Visible','on');

setappdata(0,'psd_ext',psd_ext);


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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

iu=get(handles.listbox_units,'Value');

if(iu==1)
    sss='lbm/ft^2';
    ttt='ft';    
else
    sss='kg/m^2'; 
    ttt='m';        
end

set(handles.text_md_unit,'String',sss);
set(handles.text_diam_unit,'String',ttt);    



set(handles.uipanel_save,'Visible','off');


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



function edit_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md as text
%        str2double(get(hObject,'String')) returns contents of edit_md as a double


% --- Executes during object creation, after setting all properties.
function edit_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
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

data=getappdata(0,'psd_ext');

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 



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


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_md and none of its controls.
function edit_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');



function edit_diam_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diam as text
%        str2double(get(hObject,'String')) returns contents of edit_diam as a double


% --- Executes during object creation, after setting all properties.
function edit_diam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_mat.
function listbox_mat_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mat


% --- Executes during object creation, after setting all properties.
function listbox_mat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
