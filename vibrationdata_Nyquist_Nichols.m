function varargout = vibrationdata_Nyquist_Nichols(varargin)
% VIBRATIONDATA_NYQUIST_NICHOLS MATLAB code for vibrationdata_Nyquist_Nichols.fig
%      VIBRATIONDATA_NYQUIST_NICHOLS, by itself, creates a new VIBRATIONDATA_NYQUIST_NICHOLS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_NYQUIST_NICHOLS returns the handle to a new VIBRATIONDATA_NYQUIST_NICHOLS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_NYQUIST_NICHOLS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_NYQUIST_NICHOLS.M with the given input arguments.
%
%      VIBRATIONDATA_NYQUIST_NICHOLS('Property','Value',...) creates a new VIBRATIONDATA_NYQUIST_NICHOLS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_Nyquist_Nichols_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_Nyquist_Nichols_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_Nyquist_Nichols

% Last Modified by GUIDE v2.5 27-Mar-2014 13:43:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_Nyquist_Nichols_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_Nyquist_Nichols_OutputFcn, ...
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


% --- Executes just before vibrationdata_Nyquist_Nichols is made visible.
function vibrationdata_Nyquist_Nichols_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_Nyquist_Nichols (see VARARGIN)

% Choose default command line output for vibrationdata_Nyquist_Nichols
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_Nyquist_Nichols wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_Nyquist_Nichols_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_Nyquist_Nichols);


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    FS=get(handles.edit_array,'String');
    A=evalin('base',FS); 

catch

   warndlg('Warning: enter valid array name '); 
   return; 

end

ntype=get(handles.listbox_input,'Value');

sz=size(A);

n=sz(1);

freq=zeros(n,1);
mag=zeros(n,1);
phase=zeros(n,1);
camp=zeros(n,1);

freq=A(:,1);

if(ntype==1) % complex input
    
    camp=A(:,2);
    
    for i=1:n
        mag(i)=abs(A(i,2));
        phase(i)=(180/pi)*angle(A(i,2));
    end    
    
else     % magnitude & phase input
    
    mag=A(:,2);
    phase=(180/pi)*A(:,3);
    
    for i=1:n
        a=A(i,2)*cos(A(i,3));
        b=A(i,2)*sin(A(i,3));
        camp(i)=a+(1i)*b;
    end  
    
        
end

figure(1);
plot(real(camp),imag(camp));
title('Nyquist Plot');
xlabel('Real');
ylabel('Imag');
grid on;

figure(2);
plot(phase,mag);
title('Nichols Plot');
xlabel('Phase (deg)');
ylabel('Magnitude');
grid on;

frf_p=phase;


iflag=0;

if(max(frf_p)<=1.0e-04)
%
iflag=2;
xlim([-180,0])
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','xtick',[-180,-90,0]);
end  
%
if(min(frf_p)>=-90. && max(frf_p)<90.)
%
iflag=3;
xlim([-90,90]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','xtick',[-90,0,90]);
end 
%
if(min(frf_p)>=0.)
%
iflag=4;
xlim([0,180]); 
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','xtick',[0,90,180]);
end 

if(iflag==0)
xlim([-180,180]); 
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','xtick',[-180,-90,0,90,180]);    
end

                
                
% --- Executes on selection change in listbox_input.
function listbox_input_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input


% --- Executes during object creation, after setting all properties.
function listbox_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array as text
%        str2double(get(hObject,'String')) returns contents of edit_array as a double


% --- Executes during object creation, after setting all properties.
function edit_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
