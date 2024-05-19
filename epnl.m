function varargout = epnl(varargin)
% EPNL MATLAB code for epnl.fig
%      EPNL, by itself, creates a new EPNL or raises the existing
%      singleton*.
%
%      H = EPNL returns the handle to a new EPNL or the handle to
%      the existing singleton*.
%
%      EPNL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EPNL.M with the given input arguments.
%
%      EPNL('Property','Value',...) creates a new EPNL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before epnl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to epnl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help epnl

% Last Modified by GUIDE v2.5 03-Aug-2016 15:58:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @epnl_OpeningFcn, ...
                   'gui_OutputFcn',  @epnl_OutputFcn, ...
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


% --- Executes just before epnl is made visible.
function epnl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to epnl (see VARARGIN)

% Choose default command line output for epnl
handles.output = hObject;

set(handles.listbox_method,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes epnl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles)
%




% --- Outputs from this function are returned to the command line.
function varargout = epnl_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * ');

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end
%

sz=size(THM);
ncols=sz(2)-1;

fc=THM(:,1);
SPL=THM(:,2:(ncols+1));

[nfc,noys]=noys_table();
NL=length(nfc);


[~,i1] = min(abs(fc-50));
[~,i2] = min(abs(fc-10000));

ffc=fc(i1:i2);  % keep this command
ddB=SPL(i1:i2,:);

oaspl=zeros(ncols,1);
N=zeros(ncols,1);
PNL=zeros(ncols,1);
PNLT=zeros(ncols,1);

%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Record  OASPL    PNL      PNLT   ');
disp('         (dB)    (PNdB)   (TPNdB)  ');


%
for ijk=1:ncols

    [oaspl(ijk)]=oaspl_function(SPL(:,ijk));
%
    nv=zeros(NL,1);

    for i=1:NL
        
        w=nfc(i);  % keep this command
        [~,index] = min(abs(ffc-w));        
    
        nspl=round(ddB(index,ijk));
    
        if(nspl>150)
            nspl=150;
        end
        
        nv(i)=noys(nspl,index);
        
    end

    nvsum=sum(nv);
    nmax=max(nv);

    N(ijk) = 0.85*nmax + 0.15*nvsum;
    PNL(ijk) = 40 + 10*log(N(ijk))/log(2);
    
    [PNLT(ijk)]=PNL_tone_correction(NL,SPL(:,ijk),PNL(ijk),nfc);
    
    out1=sprintf('   %d   %7.4g  %7.4g  %7.4g',ijk,oaspl(ijk),PNL(ijk),PNLT(ijk));
    disp(out1); 

end

if(min(oaspl)<(max(oaspl)-10))
   warndlg('Min OASPL < (Max OASPL-10 dB)'); 
end

PNLTM=max(PNLT);

dt=str2num(get(handles.edit_dt,'String'));

t=zeros(ncols,1);

for i=2:ncols
   t(i)=(i-1)*dt; 
end

figure(1);
plot(t,PNLT,t,PNL,t,oaspl);
legend('PNLT','PNL','SPL');
ylabel('Level (dB)');
xlabel('Time (sec)');
title('Overall Level Time Histories');
grid on;




%%%%%%%%%%%%%%% fix here  change to number of record within 10 dB
%%%%%% dsfsadfsadfs afgdsafd afdsdf

dss=0;

for i=1:ncols
    dss=dss+10^( PNLT(i)/10);
end    

D=10*log10(dss)-PNLTM+10*log10(1/ncols);

EPNL=PNLTM+D;


out1=sprintf('\n   PNLTM = %7.4g  PNdB',PNLTM);
disp(out1);
out1=sprintf('    EPNL = %7.4g  EPNdB \n',EPNL);
disp(out1);

%
msgbox('Results written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(epnl);


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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

n=get(hObject,'Value');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end



% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_oaspl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_oaspl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_oaspl as text
%        str2double(get(hObject,'String')) returns contents of edit_oaspl as a double


% --- Executes during object creation, after setting all properties.
function edit_oaspl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_oaspl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_octave.
function listbox_octave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_octave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_octave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_octave


% --- Executes during object creation, after setting all properties.
function listbox_octave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_octave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dt as text
%        str2double(get(hObject,'String')) returns contents of edit_dt as a double


% --- Executes during object creation, after setting all properties.
function edit_dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
