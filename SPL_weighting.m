function varargout = SPL_weighting(varargin)
% SPL_WEIGHTING MATLAB code for SPL_weighting.fig
%      SPL_WEIGHTING, by itself, creates a new SPL_WEIGHTING or raises the existing
%      singleton*.
%
%      H = SPL_WEIGHTING returns the handle to a new SPL_WEIGHTING or the handle to
%      the existing singleton*.
%
%      SPL_WEIGHTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPL_WEIGHTING.M with the given input arguments.
%
%      SPL_WEIGHTING('Property','Value',...) creates a new SPL_WEIGHTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SPL_weighting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SPL_weighting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SPL_weighting

% Last Modified by GUIDE v2.5 31-Jul-2019 09:17:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SPL_weighting_OpeningFcn, ...
                   'gui_OutputFcn',  @SPL_weighting_OutputFcn, ...
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


% --- Executes just before SPL_weighting is made visible.
function SPL_weighting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SPL_weighting (see VARARGIN)

% Choose default command line output for SPL_weighting
handles.output = hObject;

set(handles.pushbutton_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SPL_weighting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SPL_weighting_OutputFcn(hObject, eventdata, handles) 
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

delete(SPL_weighting);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * * ');
disp(' ');

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

fig_num=1;

%

[fw,aw,bw,cw]=SPL_weights();

ns=get(handles.listbox_scale,'Value');

if(ns==1)
    ss=aw;
    leg2='A-scale';    
end
if(ns==2)
    ss=bw;
    leg2='B-scale';        
end
if(ns==3)
    ss=cw;
    leg2='C-scale';        
end

try
    FS=get(handles.edit_input_array_name,'String');
    FS=strtrim(FS);
    THM=evalin('base',FS);
catch
    warndlg('Input array not found ');
    return;                 
end


f1=THM(:,1);
dB1=THM(:,2);


sz=size(THM);
num=sz(1);

f=THM(:,1);


for i=1:num
    [~,idx]=min(abs(f(i)-fw));
    THM(i,2)=THM(i,2)+ss(idx);
end


set(handles.pushbutton_save,'Enable','on');

setappdata(0,'THM',THM);

%%

n_type=1;

f2=THM(:,1);
dB2=THM(:,2);

leg1='Input';

tstring='';


[fig_num]=spl_plot_two_title(fig_num,n_type,f1,dB1,f2,dB2,leg1,leg2,tstring);


f=f2;
dB=dB2;
tstring=leg2;
[fig_num]=spl_plot_title_weight(fig_num,n_type,f,dB,tstring,ns);

%%




% --- Executes on selection change in listbox_scale.
function listbox_scale_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scale contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scale


% --- Executes during object creation, after setting all properties.
function listbox_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
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

data=getappdata(0,'THM');

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

msgbox('Save Complete'); 



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
