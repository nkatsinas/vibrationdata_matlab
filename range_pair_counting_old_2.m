function varargout = range_pair_counting_old_2(varargin)
% RANGE_PAIR_COUNTING_OLD_2 MATLAB code for range_pair_counting_old_2.fig
%      RANGE_PAIR_COUNTING_OLD_2, by itself, creates a new RANGE_PAIR_COUNTING_OLD_2 or raises the existing
%      singleton*.
%
%      H = RANGE_PAIR_COUNTING_OLD_2 returns the handle to a new RANGE_PAIR_COUNTING_OLD_2 or the handle to
%      the existing singleton*.
%
%      RANGE_PAIR_COUNTING_OLD_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RANGE_PAIR_COUNTING_OLD_2.M with the given input arguments.
%
%      RANGE_PAIR_COUNTING_OLD_2('Property','Value',...) creates a new RANGE_PAIR_COUNTING_OLD_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before range_pair_counting_old_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to range_pair_counting_old_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help range_pair_counting_old_2

% Last Modified by GUIDE v2.5 28-Aug-2015 10:07:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @range_pair_counting_old_2_OpeningFcn, ...
                   'gui_OutputFcn',  @range_pair_counting_old_2_OutputFcn, ...
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


% --- Executes just before range_pair_counting_old_2 is made visible.
function range_pair_counting_old_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to range_pair_counting_old_2 (see VARARGIN)

% Choose default command line output for range_pair_counting_old_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes range_pair_counting_old_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = range_pair_counting_old_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


b=str2num(get(handles.edit_b,'String'));

FS=get(handles.edit_input_array_name,'String');
THM=evalin('base',FS);

try
    FS=get(handles.edit_input_array_name,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found');
    return; 
end
    
THM=fix_size(THM);


sz=size(THM);

dur=0.;

if(sz(2)==1)
    y=THM(:,1);
    m=length(y)-1;
else    
    y=THM(:,2);
    m=length(y)-1;
    dur=THM(m,1)-THM(1,1);
end


%
out1=sprintf(' total input points =%d ',m);
disp(out1)

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exponent=b;
dchoice=1.;

    [L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak,D,ac1,ac2,cL]...
                                         =range_pair_counting_mex(y,dchoice,exponent);

                                     
%
sz=size(ac1);
if(sz(2)>sz(1))
     ac1=ac1';
     ac2=ac2';
end
%
ncL=int64(cL);
%
amp_cycles=[ ac1(1:ncL) ac2(1:ncL) ];                                     
                                     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

tc=ncL;

out1=sprintf(' Fatigue Exponent = %g \n',b);
disp(out1);

out1=sprintf(' Total Cycles = %d ',tc);
disp(out1);

out1=sprintf(' Damage      = %8.4g ',D);
disp(out1);

if(dur>1.0e-20)
    out2=sprintf(' Damage rate = %8.4g ',D/dur);
    disp(out2);
    out3=sprintf('%8.4g ',D/dur);
    clipboard('copy', out3)
end
    


clipboard('copy', out3)

msgbox('Results written to Command Window');



function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(range_pair_counting);
