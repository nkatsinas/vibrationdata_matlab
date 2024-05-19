function varargout = dissipation_loss_factor_sandwich_cylinder(varargin)
% DISSIPATION_LOSS_FACTOR_SANDWICH_CYLINDER MATLAB code for dissipation_loss_factor_sandwich_cylinder.fig
%      DISSIPATION_LOSS_FACTOR_SANDWICH_CYLINDER, by itself, creates a new DISSIPATION_LOSS_FACTOR_SANDWICH_CYLINDER or raises the existing
%      singleton*.
%
%      H = DISSIPATION_LOSS_FACTOR_SANDWICH_CYLINDER returns the handle to a new DISSIPATION_LOSS_FACTOR_SANDWICH_CYLINDER or the handle to
%      the existing singleton*.
%
%      DISSIPATION_LOSS_FACTOR_SANDWICH_CYLINDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISSIPATION_LOSS_FACTOR_SANDWICH_CYLINDER.M with the given input arguments.
%
%      DISSIPATION_LOSS_FACTOR_SANDWICH_CYLINDER('Property','Value',...) creates a new DISSIPATION_LOSS_FACTOR_SANDWICH_CYLINDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dissipation_loss_factor_sandwich_cylinder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dissipation_loss_factor_sandwich_cylinder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dissipation_loss_factor_sandwich_cylinder

% Last Modified by GUIDE v2.5 25-Jan-2016 10:35:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dissipation_loss_factor_sandwich_cylinder_OpeningFcn, ...
                   'gui_OutputFcn',  @dissipation_loss_factor_sandwich_cylinder_OutputFcn, ...
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


% --- Executes just before dissipation_loss_factor_sandwich_cylinder is made visible.
function dissipation_loss_factor_sandwich_cylinder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dissipation_loss_factor_sandwich_cylinder (see VARARGIN)

% Choose default command line output for dissipation_loss_factor_sandwich_cylinder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dissipation_loss_factor_sandwich_cylinder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dissipation_loss_factor_sandwich_cylinder_OutputFcn(hObject, eventdata, handles) 
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

delete(dissipation_loss_factor_sandwich_cylinder);


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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * *');
disp('  ');

n=get(handles.listbox_type,'value');
 
bw=get(handles.listbox_bandwidth,'Value');   
 
if(bw==1)
    [~,fc,~,NL,fmin,fmax]=SEA_one_third_octave_frequencies_max_min();
else
    [~,fc,~,imax]=SEA_full_octave_frequencies();
end

[lf,stitle]=sandwich_cylinder_dlf(fc,imax,n);

disp('   '); 
disp(stitle);
disp('   '); 

f=fc;

disp(' Freq(Hz)  Dissipation Loss Factor ');
disp('   ');    
            
for i=1:length(f)
    out1=sprintf(' %6.0f  %8.4g',f(i),lf(i));
    disp(out1);
end      
    
    
figure(1);
    
plot(f,lf);
        
    ymin=10^(floor(log10(min(lf))));
    ymax=10^(ceil(log10(max(lf))));
    
    title(stitle);
    xlabel('Frequency (Hz)');
    ylabel('Loss Factor');

	fmin=20;
	fmax=20000;
    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);
 
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end    
    
   
    xlim([fmin,fmax]);
    ylim([ ymin,ymax]);
    
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');    
    
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');   
                                      
    f=fix_size(f);
       
    lf=fix_size(lf);
    
    loss_factor=[f lf];
    
    disp(' ');
    disp(' Dissipation Loss Factor array saved to:  loss_factor ');
    assignin('base', 'loss_factor', loss_factor); 
     

msgbox('Results written to Command Window');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('sandwich_cylinder_lf.jpg');
figure(999) 
imshow(A,'border','tight','InitialMagnification',100)


% --- Executes on selection change in listbox_bandwidth.
function listbox_bandwidth_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bandwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bandwidth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bandwidth


% --- Executes during object creation, after setting all properties.
function listbox_bandwidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bandwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
