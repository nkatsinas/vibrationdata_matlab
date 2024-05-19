function varargout = Vibrationdata_export_to_Nastran(varargin)
% VIBRATIONDATA_EXPORT_TO_NASTRAN MATLAB code for Vibrationdata_export_to_Nastran.fig
%      VIBRATIONDATA_EXPORT_TO_NASTRAN, by itself, creates a new VIBRATIONDATA_EXPORT_TO_NASTRAN or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_EXPORT_TO_NASTRAN returns the handle to a new VIBRATIONDATA_EXPORT_TO_NASTRAN or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_EXPORT_TO_NASTRAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_EXPORT_TO_NASTRAN.M with the given input arguments.
%
%      VIBRATIONDATA_EXPORT_TO_NASTRAN('Property','Value',...) creates a new VIBRATIONDATA_EXPORT_TO_NASTRAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_export_to_Nastran_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_export_to_Nastran_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_export_to_Nastran

% Last Modified by GUIDE v2.5 06-Mar-2014 16:15:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_export_to_Nastran_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_export_to_Nastran_OutputFcn, ...
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


% --- Executes just before Vibrationdata_export_to_Nastran is made visible.
function Vibrationdata_export_to_Nastran_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_export_to_Nastran (see VARARGIN)

% Choose default command line output for Vibrationdata_export_to_Nastran
handles.output = hObject;

set(handles.listbox_scale_factor,'Value',1);

listbox_scale_factor_Callback(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_export_to_Nastran wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_export_to_Nastran_OutputFcn(hObject, eventdata, handles) 
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
delete(Vibrationdata_export_to_Nastran);


% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_scale_factor,'Value');

if(n==2)
  scale=str2num(get(handles.edit_scale_factor,'String'));
end


signal=evalin('base','export_signal_nastran');

[writefname, writepname] = uiputfile('*','Save data as');
writepfname = fullfile(writepname, writefname);
fid = fopen(writepfname,'w');

t=signal(:,1);
a=signal(:,2);

sz=size(signal);
n=sz(1);

for i=1:n
    if(abs(a(i))<0.00001 )  
	      a(i)=0.;
    end
end

if(n==2)
    a=a*scale;
end    
%
k = floor( double(n)/4.);
%
fprintf(fid,'ID  \n');
fprintf(fid,'SOL SEMTRAN \n');
fprintf(fid,'TIME 10000 \n');
fprintf(fid,'CEND \n');
fprintf(fid,' TITLE = Transient \n');
fprintf(fid,'BEGIN BULK \n');
fprintf(fid,'TABLED2        9      0.                                                +    \n');
%
for i=1:4:(n-3)
%
	   x=t(i);
       [iflag,ss]=datafix(x);
	   s1=ss;
%
	   x=a(i);
       [iflag,ss]=datafix(x);
	   s2=ss;
%
	   x=t(i+1);
       [iflag,ss]=datafix(x);
	   s3=ss;
%
	   x=a(i+1);
       [iflag,ss]=datafix(x);
       s4=ss;
%
       if( t(i)==0 && t(i+1)==0 )
		   printf('\n double zero error \n');
       end
%
	   x=t(i+2);
       [iflag,ss]=datafix(x);
       s5=ss;
%
	   x=a(i+2);
       [iflag,ss]=datafix(x);
       s6=ss;
%
	   x=t(i+3);
       [iflag,ss]=datafix(x);
       s7=ss;
%
	   x=a(i+3);
       [iflag,ss]=datafix(x);
       s8=ss;
%
       if(    str2double(s1) < str2double(s3) ...
		   && str2double(s3) < str2double(s5) ...
		   && str2double(s5) < str2double(s7) )
%       
			fprintf(fid,'+       %s%s%s%s%s%s%s%s+\n',s1,s2,s3,s4,s5,s6,s7,s8);
       end

       if(    str2double(s1) < str2double(s3) ...
		   && str2double(s3) < str2double(s5) ...
		   && str2double(s5) >= str2double(s7) )
%	   
		   fprintf(fid,'+       %s%s%s%s%s%s',s1,s2,s3,s4,s5,s6);
		   iflag=2;
%
		   break;
       end
%
       if(    str2double(s1) < str2double(s3) && str2double(s3) >= str2double(s5) )
%	   
		   fprintf(fid,'+       %s%s%s%s',s1,s2,s3,s4);
%
		   iflag=2;
		   break;
       end
       if(    str2double(s1) >= str2double(s3) )
%	   
		   fprintf(fid,'+       %s%s',s1,s2);
%
		   iflag=2;
%
		   break;
       end
%
end
%
if(iflag==1)
    fprintf(fid,'+,ENDT\n');
	fprintf(fid,'ENDDATA');
end
if(iflag==2)
	fprintf(fid,'ENDT\n');
	fprintf(fid,'ENDDATA');
end
%
fclose(fid);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
h = msgbox('Export File Complete');



function edit_scale_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_scale_factor as a double


% --- Executes during object creation, after setting all properties.
function edit_scale_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_scale_factor.
function listbox_scale_factor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scale_factor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scale_factor

n=get(handles.listbox_scale_factor,'Value');

if(n==1)
  set(handles.edit_scale_factor,'Visible','off');
  set(handles.text_enter_scale,'Visible','off');
else
  set(handles.edit_scale_factor,'Visible','on');
  set(handles.text_enter_scale,'Visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_scale_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
