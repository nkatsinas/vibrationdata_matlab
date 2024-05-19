function varargout = digitized_onethird_to_true_onethird(varargin)
% DIGITIZED_ONETHIRD_TO_TRUE_ONETHIRD MATLAB code for digitized_onethird_to_true_onethird.fig
%      DIGITIZED_ONETHIRD_TO_TRUE_ONETHIRD, by itself, creates a new DIGITIZED_ONETHIRD_TO_TRUE_ONETHIRD or raises the existing
%      singleton*.
%
%      H = DIGITIZED_ONETHIRD_TO_TRUE_ONETHIRD returns the handle to a new DIGITIZED_ONETHIRD_TO_TRUE_ONETHIRD or the handle to
%      the existing singleton*.
%
%      DIGITIZED_ONETHIRD_TO_TRUE_ONETHIRD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIGITIZED_ONETHIRD_TO_TRUE_ONETHIRD.M with the given input arguments.
%
%      DIGITIZED_ONETHIRD_TO_TRUE_ONETHIRD('Property','Value',...) creates a new DIGITIZED_ONETHIRD_TO_TRUE_ONETHIRD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before digitized_onethird_to_true_onethird_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to digitized_onethird_to_true_onethird_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help digitized_onethird_to_true_onethird

% Last Modified by GUIDE v2.5 21-Jun-2019 09:58:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @digitized_onethird_to_true_onethird_OpeningFcn, ...
                   'gui_OutputFcn',  @digitized_onethird_to_true_onethird_OutputFcn, ...
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


% --- Executes just before digitized_onethird_to_true_onethird is made visible.
function digitized_onethird_to_true_onethird_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to digitized_onethird_to_true_onethird (see VARARGIN)

% Choose default command line output for digitized_onethird_to_true_onethird
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

listbox_scale_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes digitized_onethird_to_true_onethird wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = digitized_onethird_to_true_onethird_OutputFcn(hObject, eventdata, handles) 
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

delete(digitized_onethird_to_true_onethird);


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
  B=evalin('base',FS);   
catch
  warndlg('Input array not found');
  return;
end    



[fl,fc,fu,imax]=one_third_octave_frequencies();

clear ref;
ref =1;
%
clear f;
clear aspl;
clear summ;
summ=0.;
%
f=B(:,1);
aspl=B(:,2);
%
disp(' ');
disp(' Convert to one-third octave format');
disp(' ');
%

%
num=max(size(f));
k=1;

for i=1:imax
%
    for j=1:(num-1)
%
			if(fc(i)>f(j) && fc(i) < f(j+1) )
%
				x1=f(j);
				x2=f(j+1);
%                
				x=fc(i);
%
				y1=aspl(j);
				y2=aspl(j+1);
%
				LXL=log10(x2)-log10(x1);
%
				if(LXL <=1.0e-20)
					disp(' LXL error ');
                end
%
				c2=(log10(x)-log10(x1))/LXL;
				c1=1-c2;
%
				bspl(k)=c1*y1+c2*y2;
%
				db=bspl(k);
                freq(k)=fc(i);
                k=k+1;             
				ms = ref*10^(db/20);
				summ=summ+(ms^2);
%
				break;
            end
			if(fc(i)==f(j))
				bspl(k)=aspl(j);
				db=bspl(k);
                freq(k)=fc(i);
                k=k+1;
				ms = ref*10.^(db/20);
				summ=summ+(ms^2);
				break;
            end
     		if(fc(i)==f(j+1))
				bspl(k)=aspl(j+1);
				db=bspl(k);
                freq(k)=fc(i);
                k=k+1;
				ms = ref*10.^(db/20);
				summ=summ+(ms^2);
				break;
            end       
    end
end

%
	summ=sqrt(summ);
%
	rms=20.*log10(summ/ref);
%


    n=get(handles.listbox_scale,'Value');

    if(n==1)
        OASPL=str2num(get(handles.edit_OASPL,'String'));
        delta=OASPL-rms;
        bspl=bspl+delta;
        [rms]=oaspl_function(bspl);
    end
 

	out1=sprintf('\n\n  Overall Level = %8.4g dB\n',rms);
    disp(out1);
%
    freq=fix_size(freq);
    bspl=fix_size(bspl);

    spl_out=[freq bspl];


n_type=1;

f1=f;
dB1=aspl;
f2=freq;
dB2=bspl;

string_1='Digitized';
string_2='True';
    
[fig_num]=spl_plot_two_alt(fig_num,n_type,f1,dB1,f2,dB2,string_1,string_2);    
    
[fig_num]=spl_plot(fig_num,n_type,f2,dB2);

set(handles.uipanel_save,'Visible','on');

setappdata(0,'spl_out',spl_out);
    
    
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

data=getappdata(0,'spl_out');

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


% --- Executes on selection change in listbox_scale.
function listbox_scale_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scale contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scale

n=get(handles.listbox_scale,'Value');

if(n==1)
    set(handles.text_OASPL,'Visible','on');
    set(handles.edit_OASPL,'Visible','on');
else
    set(handles.text_OASPL,'Visible','off');
    set(handles.edit_OASPL,'Visible','off');    
end


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



function edit_OASPL_Callback(hObject, eventdata, handles)
% hObject    handle to edit_OASPL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_OASPL as text
%        str2double(get(hObject,'String')) returns contents of edit_OASPL as a double


% --- Executes during object creation, after setting all properties.
function edit_OASPL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_OASPL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
