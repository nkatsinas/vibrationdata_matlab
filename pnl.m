function varargout = pnl(varargin)
% PNL MATLAB code for pnl.fig
%      PNL, by itself, creates a new PNL or raises the existing
%      singleton*.
%
%      H = PNL returns the handle to a new PNL or the handle to
%      the existing singleton*.
%
%      PNL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PNL.M with the given input arguments.
%
%      PNL('Property','Value',...) creates a new PNL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pnl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pnl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pnl

% Last Modified by GUIDE v2.5 03-Aug-2016 15:23:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pnl_OpeningFcn, ...
                   'gui_OutputFcn',  @pnl_OutputFcn, ...
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


% --- Executes just before pnl is made visible.
function pnl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pnl (see VARARGIN)

% Choose default command line output for pnl
handles.output = hObject;

set(handles.listbox_method,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pnl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles)
%




% --- Outputs from this function are returned to the command line.
function varargout = pnl_OutputFcn(hObject, eventdata, handles) 
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

fc=THM(:,1);
SPL=THM(:,2);
%
[oadb]=oaspl_function(SPL);
%
out1=sprintf('\n  Input SPL Overall Level = %8.4g dB  re 20 micro Pa',oadb);
disp(out1); 
disp('  ');
%
[nfc,noys]=noys_table();

NL=length(nfc);

nv=zeros(NL,1);

[~,i1] = min(abs(fc-50));
[~,i2] = min(abs(fc-10000));

ffc=fc(i1:i2);  % keep this command
ddB=SPL(i1:i2);

for i=1:NL
    
    w=nfc(i);  % keep this command

    [~,index] = min(abs(ffc-w));
   
       
    nspl=round(ddB(index));
    
    if(nspl>150)
        nspl=150;
    end
        
    nv(i)=noys(nspl,index);
        
end

nvsum=sum(nv);
 nmax=max(nv);

  N = 0.85*nmax + 0.15*nvsum;
PNL = 40 + 10*log(N)/log(2);

[PNLT]=PNL_tone_correction(NL,SPL,PNL,nfc);
%
%%%%%%%%%%%%%%%%%%%%


out1=sprintf('                   Total Noisiness Index N = %7.4g ',N);
disp(out1);

disp(' ');
out1=sprintf('                 Perceived Noise Level PNL = %7.4g PNdB',PNL);
disp(out1);
 
out1=sprintf(' Tone Corrected Perceived Noise Level PNLT = %7.4g TPNdB',PNLT);
disp(out1);

%
figure(1);
%
plot(THM(:,1),THM(:,2));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;
out1=sprintf(' One-Third Octave Sound Pressure Level \n OASPL = %8.4g dB  Ref: 20 micro Pa ',oadb);
title(out1)
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');

msgbox(' Results written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(pnl);


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
