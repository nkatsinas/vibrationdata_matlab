function varargout = vibrationdata_export_data(varargin)
% VIBRATIONDATA_EXPORT_DATA MATLAB code for vibrationdata_export_data.fig
%      VIBRATIONDATA_EXPORT_DATA, by itself, creates a new VIBRATIONDATA_EXPORT_DATA or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_EXPORT_DATA returns the handle to a new VIBRATIONDATA_EXPORT_DATA or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_EXPORT_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_EXPORT_DATA.M with the given input arguments.
%
%      VIBRATIONDATA_EXPORT_DATA('Property','Value',...) creates a new VIBRATIONDATA_EXPORT_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_export_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_export_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_export_data

% Last Modified by GUIDE v2.5 12-Mar-2014 13:30:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_export_data_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_export_data_OutputFcn, ...
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


% --- Executes just before vibrationdata_export_data is made visible.
function vibrationdata_export_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_export_data (see VARARGIN)

% Choose default command line output for vibrationdata_export_data
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_export_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_export_data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_matlab_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_matlab_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_matlab_name as text
%        str2double(get(hObject,'String')) returns contents of edit_matlab_name as a double


% --- Executes during object creation, after setting all properties.
function edit_matlab_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_matlab_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ASCII.
function pushbutton_ASCII_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ASCII (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[writefname, writepname] = uiputfile('*','Save data as');
writepfname = fullfile(writepname, writefname);
fid = fopen(writepfname,'w');

FS=get(handles.edit_matlab_name,'String');
av=evalin('base',FS);

sz=size(av);

nrow=sz(1);
ncol=sz(2);

if(ncol==1)
    for i=1:nrow
	  fprintf(fid,' %g \n',av(i));        
    end    
end
if(ncol==2)
    for i=1:nrow
 	  fprintf(fid,' %g \t %g \n',av(i,1),av(i,2));       
    end  
end
if(ncol==3)
    for i=1:nrow
 	  fprintf(fid,' %g \t %g \t %g \n',av(i,1),av(i,2),av(i,3));         
    end  
end

fclose(fid);


h = msgbox('Export Complete'); 


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_export_data);


% --- Executes on button press in pushbutton_Excel.
function pushbutton_Excel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Excel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


FS=get(handles.edit_matlab_name,'String');
av=evalin('base',FS);

sz=size(av);

nrow=sz(1);
ncol=sz(2);
    
[writefname, writepname] = uiputfile('*.xls','Save model as Excel file');
writepfname = fullfile(writepname, writefname);
    
c=[num2cell(av)]; % 1 element/cell
xlswrite(writepfname,c);

h = msgbox('Export Complete.  Press Return. '); 
    
