function varargout = vibrationdata_bandsplit(varargin)
% VIBRATIONDATA_BANDSPLIT MATLAB code for vibrationdata_bandsplit.fig
%      VIBRATIONDATA_BANDSPLIT, by itself, creates a new VIBRATIONDATA_BANDSPLIT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_BANDSPLIT returns the handle to a new VIBRATIONDATA_BANDSPLIT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_BANDSPLIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_BANDSPLIT.M with the given input arguments.
%
%      VIBRATIONDATA_BANDSPLIT('Property','Value',...) creates a new VIBRATIONDATA_BANDSPLIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_bandsplit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_bandsplit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_bandsplit

% Last Modified by GUIDE v2.5 27-Jun-2020 08:56:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_bandsplit_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_bandsplit_OutputFcn, ...
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


% --- Executes just before vibrationdata_bandsplit is made visible.
function vibrationdata_bandsplit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_bandsplit (see VARARGIN)

% Choose default command line output for vibrationdata_bandsplit
handles.output = hObject;

set(handles.uibuttongroup1,'Visible','off');

set(handles.listbox_bands,'Value',1);

listbox_bands_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_bandsplit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_bandsplit_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    


disp(' ');
disp(' * * * * * ');
disp(' ');

try
    FS=get(handles.edit_input_array_name,'String');
    A=evalin('base',FS);     
catch
    warndlg('Input PSD does not exist.');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

fmin=min(A(:,1));
fmax=max(A(:,1));

xlab='Frequency (Hz)';
ylab='Accel (G^2/Hz)';

[~,input_rms] = calculate_PSD_slopes(A(:,1),A(:,2));

t_string=sprintf('Reference PSD  %6.3g GRMS',input_rms);    
[fig_num,h]=plot_PSD_function(fig_num,xlab,ylab,t_string,A,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nb=1+get(handles.listbox_bands,'Value');

f=A(:,1);
a=A(:,2);


tpi=2*pi;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  intlog method for numerical stability
%
df=0.5;
%
xi=min(f):df:max(f); 
%
xL=log10(f);
yL=log10(a);
xiL=log10(xi);
%
yiL = interp1(xL,yL,xiL);
%
ni=length(xi);
%
fi=zeros(ni,1);
ai=zeros(ni,1);
%
for i=1:ni
    fi(i)=10^xiL(i);
    ai(i)=10^yiL(i);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
n=length(f);
%

nstrategy=get(handles.listbox_strategy,'Value');


if(nstrategy==1)
    [bpsd,numb]=bandsplit_cases(f,a,fi,ai,n,ni,df,nb);
end
if(nstrategy==2)
    [bpsd,numb]=bandsplit_cases_velox(f,a,fi,ai,n,ni,df,nb);  
end
if(nstrategy==3)
    [bpsd,numb]=bandsplit_cases_frequency(f,a,fi,ai,n,ni,df,nb);  
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
for j=1:nb
%
    clear ff;
    clear aa;
%
    mm=numb(j);
    ff=bpsd(j,1:mm,1);
    aa=bpsd(j,1:mm,2);
%
    ff=fix_size(ff);
    aa=fix_size(aa);
%
    [~,grms]=calculate_PSD_slopes(ff,aa);
    
    nn=length(ff);
    
    vv=zeros(nn,1);
    
    for ij=1:nn
        vv(ij)=386^2*aa(ij)/(tpi*ff(ij))^2;
    end
    
    [~,vrms]=calculate_PSD_slopes(ff,vv);    
    
    disp(' ');
    out1=sprintf(' PSD %d  %7.3g GRMS, %7.3g (in/sec) RMS',j,grms,vrms);
    disp(out1);
    disp(' ');
    disp(' Freq(Hz)  Accel(G^2/Hz) ');
%
    for i=1:mm
        out1=sprintf(' %8.4g  %8.4g ',ff(i),aa(i));
        disp(out1);
    end
%
    varname1=sprintf('band%d',j);
    eval([varname1 ' =[ff aa];']);
%

    AB=[ff aa]; 

    t_string=sprintf('Band %d PSD  %6.3g GRMS',j,grms);    
    [fig_num]=plot_PSD_function(fig_num,xlab,ylab,t_string,AB,fmin,fmax);
%
end



%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

setappdata(0,'band1',band1);
setappdata(0,'band2',band2);

if(nb>=3)
    setappdata(0,'band3',band3);
end
if(nb==4)
    setappdata(0,'band4',band4);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(nb==4)
    z=[band1; band2; band3; band4];
    zz=[ band1(1,:); band1(end,:); band2(end,:); band3(end,:); band4(end,:)];
    t_stringz=sprintf('PSD with Bandsplit Markers  %6.3g GRMS',input_rms);    
    [fig_num]=plot_PSD_function_markers(fig_num,xlab,ylab,t_stringz,z,zz,fmin,fmax);    
end


set(handles.uibuttongroup1,'Visible','on');



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


% --- Executes on selection change in listbox_bands.
function listbox_bands_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bands (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bands contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bands

set(handles.uibuttongroup1,'Visible','off');

set(handles.text_psd3,'Visible','off');
set(handles.edit_band3,'Visible','off');

set(handles.text_psd4,'Visible','off');
set(handles.edit_band4,'Visible','off');


n=get(handles.listbox_bands,'Value');

if(n>=2)
    set(handles.text_psd3,'Visible','on');
    set(handles.edit_band3,'Visible','on');    
end
if(n==3)
    set(handles.text_psd4,'Visible','on');
    set(handles.edit_band4,'Visible','on');     
end




% --- Executes during object creation, after setting all properties.
function listbox_bands_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bands (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=1+get(handles.listbox_bands,'Value');


data1=getappdata(0,'band1');
data2=getappdata(0,'band2');

output_name1=get(handles.edit_band1,'String');
output_name2=get(handles.edit_band2,'String');

assignin('base', output_name1, data1);
assignin('base', output_name2, data2);

if(n>=3)
    data3=getappdata(0,'band3');
    output_name3=get(handles.edit_band3,'String');
    
    assignin('base', output_name3, data3);    
end

if(n==4)
    data4=getappdata(0,'band4');
    output_name4=get(handles.edit_band4,'String');    
    
    assignin('base', output_name4, data4);       
end
 


h = msgbox('Save Complete'); 



function edit_band1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_band1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_band1 as text
%        str2double(get(hObject,'String')) returns contents of edit_band1 as a double


% --- Executes during object creation, after setting all properties.
function edit_band1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_band1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_band2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_band2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_band2 as text
%        str2double(get(hObject,'String')) returns contents of edit_band2 as a double


% --- Executes during object creation, after setting all properties.
function edit_band2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_band2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_band3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_band3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_band3 as text
%        str2double(get(hObject,'String')) returns contents of edit_band3 as a double


% --- Executes during object creation, after setting all properties.
function edit_band3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_band3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_band4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_band4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_band4 as text
%        str2double(get(hObject,'String')) returns contents of edit_band4 as a double


% --- Executes during object creation, after setting all properties.
function edit_band4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_band4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_strategy.
function listbox_strategy_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_strategy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_strategy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_strategy


% --- Executes during object creation, after setting all properties.
function listbox_strategy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_strategy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
