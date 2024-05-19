function varargout = vibrationdata_SRS_plot(varargin)
% VIBRATIONDATA_SRS_PLOT MATLAB code for vibrationdata_SRS_plot.fig
%      VIBRATIONDATA_SRS_PLOT, by itself, creates a new VIBRATIONDATA_SRS_PLOT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SRS_PLOT returns the handle to a new VIBRATIONDATA_SRS_PLOT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SRS_PLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SRS_PLOT.M with the given input arguments.
%
%      VIBRATIONDATA_SRS_PLOT('Property','Value',...) creates a new VIBRATIONDATA_SRS_PLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_SRS_plot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_SRS_plot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_SRS_plot

% Last Modified by GUIDE v2.5 22-Mar-2019 17:11:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_SRS_plot_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_SRS_plot_OutputFcn, ...
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


% --- Executes just before vibrationdata_SRS_plot is made visible.
function vibrationdata_SRS_plot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_SRS_plot (see VARARGIN)

% Choose default command line output for vibrationdata_SRS_plot
handles.output = hObject;

set(handles.listbox_method,'Value',1);
set(handles.listbox_frequency_limits,'Value',1);
set(handles.listbox_input_type,'Value',1);

listbox_frequency_limits_Callback(hObject, eventdata, handles);
listbox_amplitude_limits_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_SRS_plot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_SRS_plot_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_SRS_plot);


%8 --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%

fig_num=get(handles.listbox_figure_number,'Value');
 
 
Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
 
if(NFigures>fig_num)
    NFigures=fig_num;
end
 
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end
 
  
%%%%%%%%%%%

leg=get(handles.edit_leg,'String');

psave=get(handles.listbox_psave,'Value');

k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=strtrim(get(handles.edit_input_array,'String'));
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end


m=get(handles.listbox_frequency_limits,'Value');

if(m==1) % automatic
    
    fmin=THM(1,1);
    fmax=max(THM(:,1));
    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);

    if(iflag==1)
        fmin=min(xtt);
        fmax=max(xtt);    
    end       
    
else     % manual
    
    fmin=str2num(get(handles.edit_start_frequency,'String'));
    fmax=str2num(get(handles.edit_end_frequency,'String'));
end



  i50=get(handles.listbox_50,'Value');
iwork=get(handles.listbox_work,'Value');

    ppp50=[fmin 0.8*fmin; fmax 0.8*fmax ];
    leg50='50 ips';
    
    pppw=[10 8; 80 64; 500 64];
    legw='Min Level';

Q=str2num(get(handles.edit_Q,'String'));


title_label=get(handles.edit_title,'String');


xaxis_label=get(handles.edit_xaxis_label,'String');
yaxis_label=get(handles.edit_yaxis_label,'String');


h=figure(fig_num);

p=get(handles.listbox_input_type,'Value');

if(p==1)
    
    if(i50==2 && iwork==2)
        plot(THM(:,1),THM(:,2));
    end
    if(i50==1 && iwork==2)
        plot(THM(:,1),THM(:,2),'b',ppp50(:,1),ppp50(:,2),'--k');
        legend(leg,'50 ips');       
    end
    if(i50==2 && iwork==1)
        plot(THM(:,1),THM(:,2),'b',pppw(:,1),pppw(:,2),'r');
        legend(leg,'Min Level');
    end
    if(i50==1 && iwork==1)
        plot(THM(:,1),THM(:,2),'b',pppw(:,1),pppw(:,2),'r',ppp50(:,1),ppp50(:,2),'--k');
        legend(leg,'Min Level','50 ips');
    end    

else
    if(i50==1)
        plot(THM(:,1),THM(:,2),'b',THM(:,1),THM(:,3),'r',ppp50(:,1),ppp50(:,2),'--k');
        legend ('positive','negative','50 ips');         
    end    
    if(i50==2)
        plot(THM(:,1),THM(:,2),THM(:,1),THM(:,3));
        legend ('positive','negative'); 
    end    
end    

title(title_label );
xlabel(xaxis_label);
ylabel(yaxis_label);
grid on;

if(m==1) % automatic
    
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end       

end

xlim([fmin,fmax]); 

%%%%%%%%%%%%%%%%%%%%%

ma=get(handles.listbox_amplitude_limits,'Value');

if(ma==1)
    ymax= 10^ceil(log10(max(THM(:,2))*1.2));
    ymin= 10^floor(log10(min(THM(:,2))*0.999));
    
    z=ymax/1.0e+06;
    
    if(ymin<z)
        ymin=z;
    end
    
    ylim([ymin,ymax]); 
else    
    ymin=str2num(get(handles.edit_ymin,'String'));
    ymax=str2num(get(handles.edit_ymax,'String'));
    ylim([ymin,ymax]);    
    
end

%%%%%%%%%%%%%%%%%%%%%

 set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
                             
%
if(psave==1)
        
        disp(' ');
        disp(' Plot file:');
        disp(' ');
    
        pname='srs_plot';
        
        out1=sprintf('   %s.png',pname);
        disp(out1);
    
        set(gca,'Fontsize',12);
        print(h,pname,'-dpng','-r300');
    
end      


function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_yaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_yaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_xaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_xaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xaxis_label (see GCBO)
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
n=get(hObject,'Value');

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

m=get(handles.listbox_input_type,'Value');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   
   if(m==1)
    THM = fscanf(fid,'%g %g',[2 inf]);
   else
    THM = fscanf(fid,'%g %g %g',[3 inf]);       
   end
   
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



function edit_end_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_end_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_end_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_start_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_start_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_start_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency_limits.
function listbox_frequency_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_limits
n=get(handles.listbox_frequency_limits,'Value');
 
if(n==1) % auto
    set(handles.text_start_frequency,'Visible','off');
    set(handles.text_end_frequency,'Visible','off');
    set(handles.edit_start_frequency,'Visible','off');
    set(handles.edit_end_frequency,'Visible','off');    
else % manual
    set(handles.text_start_frequency,'Visible','on');
    set(handles.text_end_frequency,'Visible','on');
    set(handles.edit_start_frequency,'Visible','on');
    set(handles.edit_end_frequency,'Visible','on');      
end


% --- Executes during object creation, after setting all properties.
function listbox_frequency_limits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_input_type.
function listbox_input_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_type


% --- Executes during object creation, after setting all properties.
function listbox_input_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_figure_number.
function listbox_figure_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_figure_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_figure_number


% --- Executes during object creation, after setting all properties.
function listbox_figure_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_amplitude_limits.
function listbox_amplitude_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amplitude_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amplitude_limits

n=get(handles.listbox_amplitude_limits,'Value');
 
if(n==1) % auto
    set(handles.text_ymin,'Visible','off');
    set(handles.text_ymax,'Visible','off');
    set(handles.edit_ymin,'Visible','off');
    set(handles.edit_ymax,'Visible','off');    
else % manual
    set(handles.text_ymin,'Visible','on');
    set(handles.text_ymax,'Visible','on');
    set(handles.edit_ymin,'Visible','on');
    set(handles.edit_ymax,'Visible','on');      
end



% --- Executes during object creation, after setting all properties.
function listbox_amplitude_limits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_50.
function listbox_50_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_50 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_50


% --- Executes during object creation, after setting all properties.
function listbox_50_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_work.
function listbox_work_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_work (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_work contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_work


% --- Executes during object creation, after setting all properties.
function listbox_work_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_work (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_plot.
function pushbutton_save_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    listbox_input_type=get(handles.listbox_input_type,'Value');
    PlotSaveSRS.listbox_input_type=listbox_input_type;
end

%%%%%%%%%%%%%%%

try
    listbox_frequency_limits=get(handles.listbox_frequency_limits,'Value');
    PlotSaveSRS.listbox_frequency_limits=listbox_frequency_limits;
end
try
    listbox_amplitude_limits=get(handles.listbox_amplitude_limits,'Value');
    PlotSaveSRS.listbox_amplitude_limits=listbox_amplitude_limits;
end
try
    listbox_figure_number=get(handles.listbox_figure_number,'Value');
    PlotSaveSRS.listbox_figure_number=listbox_figure_number;
end

%%%%%%%%%%%%%%%%

try
    listbox_50=get(handles.listbox_50,'Value');
    PlotSaveSRS.listbox_50=listbox_50;
end
try
    listbox_psave=get(handles.listbox_psave,'Value');
    PlotSaveSRS.listbox_psave=listbox_psave;
end
try
    listbox_work=get(handles.listbox_work,'Value');
    PlotSaveSRS.listbox_work=listbox_work;
end

%%%%%%%%%%%%%%%%

try
    leg=get(handles.edit_leg,'String');
    PlotSaveSRS.leg=leg;
end
try
    title=get(handles.edit_title,'String');
    PlotSaveSRS.title=title;
end
try
    Q=get(handles.edit_Q,'String');
    PlotSaveSRS.Q=Q;
end
try
    yaxis_label=get(handles.edit_yaxis_label,'String');
    PlotSaveSRS.yaxis_label=yaxis_label;
end
try
    xaxis_label=get(handles.edit_xaxis_label,'String');
    PlotSaveSRS.xaxis_label=xaxis_label;
end
try
    ymin=get(handles.edit_ymin,'String');
    PlotSaveSRS.ymin=ymin;
end
try
    ymax=get(handles.edit_ymax,'String');
    PlotSaveSRS.ymax=ymax;
end
try
    start_frequency=get(handles.edit_start_frequency,'String');
    PlotSaveSRS.start_frequency=start_frequency;
end
try
    end_frequency=get(handles.edit_end_frequency,'String');
    PlotSaveSRS.end_frequency=end_frequency;
end


%%%%%

try
    FS1=strtrim(get(handles.edit_input_array,'String'));
    PlotSaveSRS.FS1=FS1; 
    
    try
        THM1=evalin('base',FS1);
        PlotSaveSRS.THM1=THM1;
    catch
    end
catch    
end


% % %
 
structnames = fieldnames(PlotSaveSRS, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
        save(elk, 'PlotSaveSRS');  
    catch
        warndlg('Save error');
        return;
    end
 
msgbox('Save Complete');


% --- Executes on button press in pushbutton_load_plot.
function pushbutton_load_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_plot (see GCBO)
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
 
   PlotSaveSRS=evalin('base','PlotSaveSRS');
 
catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    leg=PlotSaveSRS.leg; 
    set(handles.edit_leg,'String',leg);
end

try
    listbox_figure_number=PlotSaveSRS.listbox_figure_number;    
    set(handles.listbox_figure_number,'Value',listbox_figure_number);
end


try
    listbox_input_type=PlotSaveSRS.listbox_input_type;    
    set(handles.listbox_input_type,'Value',listbox_input_type);
end
try
    listbox_amplitude_limits=PlotSaveSRS.listbox_amplitude_limits;    
    set(handles.listbox_amplitude_limits,'Value',listbox_amplitude_limits);
end
try
    listbox_frequency_limits=PlotSaveSRS.listbox_frequency_limits;    
    set(handles.listbox_frequency_limits,'Value',listbox_frequency_limits);
end
try
    listbox_50=PlotSaveSRS.listbox_50;    
    set(handles.listbox_50,'Value',listbox_50);
end
try
    listbox_psave=PlotSaveSRS.listbox_psave;    
    set(handles.listbox_psave,'Value',listbox_psave);
end
try
    listbox_work=PlotSaveSRS.listbox_work;    
    set(handles.listbox_work,'Value',listbox_work);
end

%%%%%%%%%%%%%%%%

try
    title=PlotSaveSRS.title;    
    set(handles.edit_title,'String',title);
end
try
    Q=PlotSaveSRS.Q;    
    set(handles.edit_Q,'String',Q);
end
try
    yaxis_label=PlotSaveSRS.yaxis_label;    
    set(handles.edit_yaxis_label,'String',yaxis_label);
end
try
    xaxis_label=PlotSaveSRS.xaxis_label;    
    set(handles.edit_xaxis_label,'String',xaxis_label);
end
try
    start_frequency=PlotSaveSRS.start_frequency;    
    set(handles.edit_start_frequency,'String',start_frequency);
end
try
    end_frequency=PlotSaveSRS.end_frequency;    
    set(handles.edit_end_frequency,'String',end_frequency);
end
try
    leg1=PlotSaveSRS.leg1;    
    set(handles.edit_leg1,'String',leg1);
end
try
    leg2=PlotSaveSRS.leg2;    
    set(handles.edit_leg2,'String',leg2);
end

try
    ymin=PlotSaveSRS.ymin;    
    set(handles.edit_ymin,'String',ymin);
end
try
    ymax=PlotSaveSRS.ymax;    
    set(handles.edit_ymax,'String',ymax);
end

%%%

try
    FS1=strtrim(PlotSaveSRS.FS1);
    set(handles.edit_input_array,'String',FS1);
 
    iflag=0;
    
    try
        temp=evalin('base',FS1);
        ss=sprintf('Replace %s with Previously Saved Array',FS1);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');

        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM1=PlotSaveSRS.THM1;
            assignin('base',FS1,THM1); 
        catch
        end
    end
    
catch    
end

%%%

listbox_frequency_limits_Callback(hObject, eventdata, handles);
listbox_amplitude_limits_Callback(hObject, eventdata, handles);

msgbox('Load Complete');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_leg_Callback(hObject, eventdata, handles)
% hObject    handle to edit_leg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_leg as text
%        str2double(get(hObject,'String')) returns contents of edit_leg as a double


% --- Executes during object creation, after setting all properties.
function edit_leg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_leg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
