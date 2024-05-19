function varargout = digitized_narrowband_to_onethird_SPL(varargin)
% DIGITIZED_NARROWBAND_TO_ONETHIRD_SPL MATLAB code for digitized_narrowband_to_onethird_SPL.fig
%      DIGITIZED_NARROWBAND_TO_ONETHIRD_SPL, by itself, creates a new DIGITIZED_NARROWBAND_TO_ONETHIRD_SPL or raises the existing
%      singleton*.
%
%      H = DIGITIZED_NARROWBAND_TO_ONETHIRD_SPL returns the handle to a new DIGITIZED_NARROWBAND_TO_ONETHIRD_SPL or the handle to
%      the existing singleton*.
%
%      DIGITIZED_NARROWBAND_TO_ONETHIRD_SPL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIGITIZED_NARROWBAND_TO_ONETHIRD_SPL.M with the given input arguments.
%
%      DIGITIZED_NARROWBAND_TO_ONETHIRD_SPL('Property','Value',...) creates a new DIGITIZED_NARROWBAND_TO_ONETHIRD_SPL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before digitized_narrowband_to_onethird_SPL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to digitized_narrowband_to_onethird_SPL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help digitized_narrowband_to_onethird_SPL

% Last Modified by GUIDE v2.5 11-Jul-2019 09:19:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @digitized_narrowband_to_onethird_SPL_OpeningFcn, ...
                   'gui_OutputFcn',  @narrowband_to_onethird_splbputFcn, ...
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


% --- Executes just before digitized_narrowband_to_onethird_SPL is made visible.
function digitized_narrowband_to_onethird_SPL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to digitized_narrowband_to_onethird_SPL (see VARARGIN)

% Choose default command line output for digitized_narrowband_to_onethird_SPL
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes digitized_narrowband_to_onethird_SPL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = narrowband_to_onethird_splbputFcn(hObject, eventdata, handles) 
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

delete(digitized_narrowband_to_onethird_SPL);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * ');
disp('  ');

fig_num=1;


try
  FS=get(handles.edit_input_array,'String');
  A=evalin('base',FS);   
catch
  warndlg('Input array not found');
  return;
end    



[fl,fc,fu,imax]=one_third_octave_frequencies();

num_band=zeros(imax,1);
ms_band=zeros(imax,1);

ref=1;

%
fa=A(:,1);
spla=A(:,2);
%
disp(' ');
disp(' Convert to one-third octave format');
disp(' ');
%

%%%

num=max(size(fa));

for i=1:num

    for j=1:imax
        
        if(fa(i)>=fl(j) && fa(i)<=fu(j))
            
            num_band(j)=num_band(j)+1;
            ms_band(j)=ms_band(j)+ref*10^(spla(i)/10);
            
        end
        
    end
    
end

%%%

fb=fc;
splb=zeros(imax,1);

for j=1:imax
        
    if(num_band(j)>=1)
            
        ms=ms_band(j)/num_band(j);
        splb(j)=10*log10(ms/ref);
            
    end
        
end

%%%

iflag=0;

jn=0;

for j=imax:-1:1
   
    if(num_band(j)>0)
        iflag=1;
    end
    
    if(num_band(j)==0)
        
        fb(j)=[];
        splb(j)=[];
        
        if(iflag==1)
            jn=j;
            break;
        end
        
    end
    
end
    
for j=jn:-1:1
    
    fb(j)=[];
    splb(j)=[];    

end

%%%

fa=fix_size(fa);
fb=fix_size(fb);
spla=fix_size(spla);
splb=fix_size(splb);


ppp1=[fa spla];
ppp2=[fb splb];

[oadb]=oaspl_function(splb);


fmin=fa(1);
fmax=fa(num);


x_label='Center Frequency (Hz)';
y_label='SPL (dB)';

leg1='Narrowband';
leg2='One-third Octave';

t_string=sprintf(' Sound Pressure Levels \n One-third Octave %7.4g dB overall  ref 20 micro Pa',oadb);


[fig_num,h2]=plot_loglin_function_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax);
%

sz=size(ppp2);

set(handles.uipanel_save,'Visible','on');

try
    setappdata(0,'splb',ppp2);
catch
    warndlg('Error:  setappdata');
    return;
end

disp(' ');
disp(' Format:  %9.5g '); 
disp(' ');

disp('   fc(Hz)    SPL(dB) ');

for i=1:sz(1)
    out1=sprintf(' %9.5g \t %9.5g ',ppp2(i,1),ppp2(i,2));
    disp(out1); 
end


    
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



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
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

try
    data=getappdata(0,'splb');
catch
    warndlg('getappdata failed');
    return;
end
    
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


set(handles.uipanel_save,'Visible','off');
