function varargout = convert_fn_modal_density(varargin)
% CONVERT_FN_MODAL_DENSITY MATLAB code for convert_fn_modal_density.fig
%      CONVERT_FN_MODAL_DENSITY, by itself, creates a new CONVERT_FN_MODAL_DENSITY or raises the existing
%      singleton*.
%
%      H = CONVERT_FN_MODAL_DENSITY returns the handle to a new CONVERT_FN_MODAL_DENSITY or the handle to
%      the existing singleton*.
%
%      CONVERT_FN_MODAL_DENSITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVERT_FN_MODAL_DENSITY.M with the given input arguments.
%
%      CONVERT_FN_MODAL_DENSITY('Property','Value',...) creates a new CONVERT_FN_MODAL_DENSITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before convert_fn_modal_density_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to convert_fn_modal_density_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help convert_fn_modal_density

% Last Modified by GUIDE v2.5 19-Sep-2017 15:54:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @convert_fn_modal_density_OpeningFcn, ...
                   'gui_OutputFcn',  @convert_fn_modal_density_OutputFcn, ...
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


% --- Executes just before convert_fn_modal_density is made visible.
function convert_fn_modal_density_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to convert_fn_modal_density (see VARARGIN)

% Choose default command line output for convert_fn_modal_density
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes convert_fn_modal_density wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = convert_fn_modal_density_OutputFcn(hObject, eventdata, handles) 
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

delete(convert_fn_modal_density);



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


% --- Executes on button press in pushbutton_convert.
function pushbutton_convert_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_convert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

freq=THM(:,2);


[fl,fc,fu,imax]=one_third_octave_frequencies();

n=length(freq);

mdens=zeros(imax,1);
nmodes=zeros(imax,1);

for i=1:n
    
    for j=1:imax
        
        if(freq(i)>=fl(j) && freq(i)<=fu(j))
        
            nmodes(j)=nmodes(j)+1;
            
            break;
        
        end
        
    end
    
end    


for j=imax:-1:1
    if(nmodes(j)==0 || fc(j)<10.)
        fl(j)=[];
        fc(j)=[];
        fu(j)=[];
        mdens(j)=[];
        nmodes(j)=[];
    else
        bw=fc(j)-fl(j);
        mdens(j)=nmodes(j)/bw;
    end
end

fig_num=1;

fc=fix_size(fc);
mdens=fix_size(mdens);

ppp=[fc,mdens];
md=3;
x_label='Center Frequency (Hz)';
y_label='n (modes/Hz)';
t_string='Modal Density';
fmin=20;
fmax=10000;

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

disp('  ');
disp('   fc     Modal Density ');
disp('  (Hz)     (modes/Hz)   ');
for j=1:length(fc)
    out1=sprintf(' %8.1f  %8.4f  ',fc(j),mdens(j));
    disp(out1);
end    

disp('  ');
output_name='modal_density';
out1=sprintf('  modal density array saved as: %s',output_name);
assignin('base', output_name, ppp);
disp(out1);
disp('  ');
