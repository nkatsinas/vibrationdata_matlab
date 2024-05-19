function varargout = spl_full_to_onethird(varargin)
% SPL_FULL_TO_ONETHIRD MATLAB code for spl_full_to_onethird.fig
%      SPL_FULL_TO_ONETHIRD, by itself, creates a new SPL_FULL_TO_ONETHIRD or raises the existing
%      singleton*.
%
%      H = SPL_FULL_TO_ONETHIRD returns the handle to a new SPL_FULL_TO_ONETHIRD or the handle to
%      the existing singleton*.
%
%      SPL_FULL_TO_ONETHIRD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPL_FULL_TO_ONETHIRD.M with the given input arguments.
%
%      SPL_FULL_TO_ONETHIRD('Property','Value',...) creates a new SPL_FULL_TO_ONETHIRD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spl_full_to_onethird_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spl_full_to_onethird_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spl_full_to_onethird

% Last Modified by GUIDE v2.5 21-Feb-2014 09:52:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spl_full_to_onethird_OpeningFcn, ...
                   'gui_OutputFcn',  @spl_full_to_onethird_OutputFcn, ...
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


% --- Executes just before spl_full_to_onethird is made visible.
function spl_full_to_onethird_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spl_full_to_onethird (see VARARGIN)

% Choose default command line output for spl_full_to_onethird
handles.output = hObject;

set(handles.listbox_method,'Value',1);

set(handles.pushbutton_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes spl_full_to_onethird wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spl_full_to_onethird_OutputFcn(hObject, eventdata, handles) 
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

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

dB=THM(:,2);
%
[oadB]=oaspl_function(dB);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear f;
clear fc;
clear aspl;
clear summ;
summ=0.;
%
f=THM(:,1);
aspl=THM(:,2);
%
disp(' ');
disp(' Convert to one-third octave format');
disp(' ');
%
	fc(1)=10.;
	fc(2)=12.5; 
	fc(3)=16.;
	fc(4)=20.;
	fc(5)=25.;
	fc(6)=31.5;
	fc(7)=40.;
	fc(8)=50.;
    fc(9)=63.;
	fc(10)=80.;
	fc(11)=100.;
	fc(12)=125.;
	fc(13)=160.;
	fc(14)=200.;
	fc(15)=250.;
	fc(16)=315.;
    fc(17)=400.;
	fc(18)=500.;
	fc(19)=630.;
	fc(20)=800.;
	fc(21)=1000.;
	fc(22)=1250.;
	fc(23)=1600.;
	fc(24)=2000.;
    fc(25)=2500.;
	fc(26)=3150.;
	fc(27)=4000.;
	fc(28)=5000.;
	fc(29)=6300.;
	fc(30)=8000.;
	fc(31)=10000.;
	fc(32)=12500.;
	fc(33)=16000.;
	fc(34)=20000.;
	fc(35)=25000.;
	fc(36)=31500.;
%
    num=max(size(THM(:,1)));
    k=1;
    
    ref=1;
    
	for i=1:length(fc)
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
				dB=bspl(k);
                freq(k)=fc(i);
                k=k+1;             
				ms = ref*10^(dB/20);
				summ=summ+(ms^2);
%
				break;
            end
			if(fc(i)==f(j))
				bspl(k)=aspl(j);
				dB=bspl(k);
                freq(k)=fc(i);
                k=k+1;
				ms = ref*10.^(dB/20);
				summ=summ+(ms^2);
				break;
            end
     		if(fc(i)==f(j+1))
				bspl(k)=aspl(j+1);
				dB=bspl(k);
                freq(k)=fc(i);
                k=k+1;
				ms = ref*10.^(dB/20);
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
bspl=bspl-(rms-oadB);
%
    spl_out=[freq' bspl'];
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('\n  Overall Level = %8.4g dB \n',oadB);
disp(out1)
figure(1);
plot(spl_out(:,1),spl_out(:,2));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;
out1=sprintf(' One-Third Octave Sound Pressure Level  OASPL = %8.4g dB ',oadB);
title(out1)
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');

%
set(handles.pushbutton_save,'Enable','on');

setappdata(0,'one_third_spl',spl_out);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(spl_full_to_onethird);



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



data=getappdata(0,'one_third_spl');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 
