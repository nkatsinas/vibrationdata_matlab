function varargout = plot_sine_on_random(varargin)
% PLOT_SINE_ON_RANDOM MATLAB code for plot_sine_on_random.fig
%      PLOT_SINE_ON_RANDOM, by itself, creates a new PLOT_SINE_ON_RANDOM or raises the existing
%      singleton*.
%
%      H = PLOT_SINE_ON_RANDOM returns the handle to a new PLOT_SINE_ON_RANDOM or the handle to
%      the existing singleton*.
%
%      PLOT_SINE_ON_RANDOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_SINE_ON_RANDOM.M with the given input arguments.
%
%      PLOT_SINE_ON_RANDOM('Property','Value',...) creates a new PLOT_SINE_ON_RANDOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_sine_on_random_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_sine_on_random_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_sine_on_random

% Last Modified by GUIDE v2.5 13-Jun-2020 16:15:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_sine_on_random_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_sine_on_random_OutputFcn, ...
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


% --- Executes just before plot_sine_on_random is made visible.
function plot_sine_on_random_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_sine_on_random (see VARARGIN)

% Choose default command line output for plot_sine_on_random
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

listbox_xplotlimits_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plot_sine_on_random wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function table_set(hObject, eventdata, handles) 

cn={'Array Name','Y-axis Label'};

%%%%
 
Nrows=2;
Ncolumns=2;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=2;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    


if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    

    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end
 
set(handles.uitable_data,'Data',data_s,'ColumnName',cn);




% --- Outputs from this function are returned to the command line.
function varargout = plot_sine_on_random_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(plot_sine_on_random);

% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
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



try
    FS=get(handles.edit_psd,'String');
    THML=evalin('base',FS);       
catch
    warndlg(' data get error');
    return;
end


N=get(handles.listbox_num,'Value');
    
A=char(get(handles.uitable_data,'Data'));
    

k=1;

freq=zeros(N,1);
accel=zeros(N,1);

for i=1:N
        freq(i)=str2double(A(k,:)); k=k+1;
end

for i=1:N
        accel(i)=str2double(A(k,:)); k=k+1;
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


XL=get(handles.edit_XL,'String');

tstring=get(handles.edit_tstring,'String');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);

yyaxis left
plot(THML(:,1),THML(:,2));
ylabel('Accel (G^2/Hz)');

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');

ymin=min(THML(:,2));
ymax=max(THML(:,2));


ymin=10^floor(log10(ymin));
ymax=10^ceil(log10(ymax));
 
ymax=ymax*10;

ylim([ymin ymax]);
nd=round(log10(ymax/ymin));
                 
                 
%%%                 
                 
yyaxis right

ms=0;
for i=1:N
    x=[freq(i) freq(i)];
    y=[accel(i)/1000 accel(i)];
    line(x,y);
    ms=ms+(accel(i)/sqrt(2))^2;
end    

sine_rms=sqrt(ms);
[~,grms] = calculate_PSD_slopes(THML(:,1),THML(:,2));
psd_rms=grms;

ymax=10^ceil(1.02*log10(max(accel)));
ymin=ymax/10^nd;

ylim([ymin ymax]);
ylabel('Accel (G)');

rms=sqrt(sine_rms^2+psd_rms^2);

tstring=sprintf('%s  %7.3g GRMS overall',tstring,rms );

title(tstring);
xlabel(XL);
grid on;

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off'); 


xmin=min([ THML(1,1)  freq(1)  ]);
xmax=max([ THML(end,1) freq(end)  ]);
        
[xtt,xTT,iflag]=xtick_label(xmin,xmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    
    xlim([fmin fmax]);
end    



function edit_XL_Callback(hObject, eventdata, handles)
% hObject    handle to edit_XL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_XL as text
%        str2double(get(hObject,'String')) returns contents of edit_XL as a double


% --- Executes during object creation, after setting all properties.
function edit_XL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_XL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tstring_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tstring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tstring as text
%        str2double(get(hObject,'String')) returns contents of edit_tstring as a double


% --- Executes during object creation, after setting all properties.
function edit_tstring_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tstring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_xplotlimits.
function listbox_xplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xplotlimits


n=get(handles.listbox_xplotlimits,'Value');

if(n==1)
    set(handles.edit_xmin,'Enable','off');
    set(handles.edit_xmax,'Enable','off'); 
else
    set(handles.edit_xmin,'Enable','on');
    set(handles.edit_xmax,'Enable','on');  
end


% --- Executes during object creation, after setting all properties.
function listbox_xplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmin as text
%        str2double(get(hObject,'String')) returns contents of edit_xmin as a double


% --- Executes during object creation, after setting all properties.
function edit_xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax as a double


% --- Executes during object creation, after setting all properties.
function edit_xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_plot_file.
function pushbutton_save_plot_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_plot_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    num=get(handles.listbox_num,'Value');
    DoubleYPlot.num=num;
catch
end

try
    psd=get(handles.edit_psd,'String');
    DoubleYPlot.psd=psd;
catch
end


try
    nx=get(handles.listbox_xplotlimits,'Value');
    DoubleYPlot.nx=nx;
catch
end

try
    xmin=get(handles.edit_xmin,'String');
    DoubleYPlot.xmin=xmin;
catch
end

try
    xmax=get(handles.edit_xmax,'String');
    DoubleYPlot.xmax=xmax;
catch
end



try
    data=get(handles.uitable_data,'Data');
    DoubleYPlot.data=data;
catch
end

try
    tstring=get(handles.edit_tstring,'String');
    DoubleYPlot.tstring=tstring;
catch
end
    
try
    XL=get(handles.edit_XL,'String');
    DoubleYPlot.XL=XL;
catch
end

 DoubleYPlot
 
% % %

structnames = fieldnames(DoubleYPlot, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'DoubleYPlot'); 
 
    catch
        warndlg('Save error');
        return;
    end
 


% --- Executes on button press in pushbutton_load_plot_file.
function pushbutton_load_plot_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_plot_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat', 'Select plot save file');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
k=length(structnames);
 
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
% struct
 
try
 
   DoubleYPlot=evalin('base','DoubleYPlot');
 
catch
   warndlg(' evalin failed ');
   return;
end

% % % %

%%%

try
    data=DoubleYPlot.data; 
    set(handles.uitable_data,'Data',data);
catch
end

try
    tstring=DoubleYPlot.tstring; 
    set(handles.edit_tstring,'String',tstring);
catch
end
    
try
    XL=DoubleYPlot.XL; 
    set(handles.edit_XL,'String',XL);
catch
end

try
    nx=DoubleYPlot.nx;    
    set(handles.listbox_xplotlimits,'Value',nx);
catch
end



try
    xmin=DoubleYPlot.xmin; 
    set(handles.edit_xmin,'String',xmin);
catch
end

try
    xmax=DoubleYPlot.xmax; 
    set(handles.edit_xmax,'String',xmax);
catch
end


try
    num=DoubleYPlot.num;    
    set(handles.listbox_num,'Value',num);
catch
end

try
    psd=DoubleYPlot.psd;    
    set(handles.edit_psd,'String',psd);
catch
end

listbox_num_Callback(hObject, eventdata, handles);
listbox_xplotlimits_Callback(hObject, eventdata, handles);


% --- Executes on selection change in listbox_xtype.
function listbox_xtype_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xtype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xtype


% --- Executes during object creation, after setting all properties.
function listbox_xtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ytype.
function listbox_ytype_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ytype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ytype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ytype


% --- Executes during object creation, after setting all properties.
function listbox_ytype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ytype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_psd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_psd as text
%        str2double(get(hObject,'String')) returns contents of edit_psd as a double


% --- Executes during object creation, after setting all properties.
function edit_psd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num

n=get(handles.listbox_num,'Value');

cn={'Freq (Hz)','Accel (G)'};


for i = 1:n
   for j=1:2
      data_s{i,j} = '';     
   end  
end
set(handles.uitable_data,'Data',data_s,'ColumnName',cn,'ColumnWidth', {90,90})     


% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
