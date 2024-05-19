function varargout = vibrationdata_SRS_plot_multiple_old(varargin)
% VIBRATIONDATA_SRS_PLOT_MULTIPLE_OLD MATLAB code for vibrationdata_SRS_plot_multiple_old.fig
%      VIBRATIONDATA_SRS_PLOT_MULTIPLE_OLD, by itself, creates a new VIBRATIONDATA_SRS_PLOT_MULTIPLE_OLD or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SRS_PLOT_MULTIPLE_OLD returns the handle to a new VIBRATIONDATA_SRS_PLOT_MULTIPLE_OLD or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SRS_PLOT_MULTIPLE_OLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SRS_PLOT_MULTIPLE_OLD.M with the given input arguments.
%
%      VIBRATIONDATA_SRS_PLOT_MULTIPLE_OLD('Property','Value',...) creates a new VIBRATIONDATA_SRS_PLOT_MULTIPLE_OLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_SRS_plot_multiple_old_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_SRS_plot_multiple_old_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_SRS_plot_multiple_old

% Last Modified by GUIDE v2.5 02-May-2019 12:23:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_SRS_plot_multiple_old_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_SRS_plot_multiple_old_OutputFcn, ...
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


% --- Executes just before vibrationdata_SRS_plot_multiple_old is made visible.
function vibrationdata_SRS_plot_multiple_old_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_SRS_plot_multiple_old (see VARARGIN)

% Choose default command line output for vibrationdata_SRS_plot_multiple_old
handles.output = hObject;


set(handles.listbox_frequency_limits,'Value',1);
set(handles.listbox_input_type,'Value',1);

listbox_frequency_limits_Callback(hObject, eventdata, handles);
listbox_amplitude_limits_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_SRS_plot_multiple_old wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_SRS_plot_multiple_old_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_SRS_plot_multiple);


%8 --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%% evalin('base', 'close all')
setappdata(0,'fig_num',1);


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%%%%%%%%%


psave=get(handles.listbox_psave,'Value');

fig_num=1;


try
    FS=strtrim(get(handles.edit_input_array_1,'String'));
    THM1=evalin('base',FS);   
catch
    FS
    warndlg(' Input array 1 not found ');
    return;
end
try
    FS=strtrim(get(handles.edit_input_array_2,'String'));
    THM2=evalin('base',FS);   
catch
    FS
    warndlg(' Input array 2 not found ');
    return;
end

%%%

Q=str2num(get(handles.edit_Q,'String'));

xaxis_label=get(handles.edit_xaxis_label,'String');
yaxis_label=get(handles.edit_yaxis_label,'String');


p=get(handles.listbox_input_type,'Value');


m=get(handles.listbox_frequency_limits,'Value');

if(m==1) % automatic
    
    fmin=min([ THM1(1,1)      THM2(1,1) ]); 
    fmax=max([ max(THM1(:,1)) max(THM2(:,1))]);
   
else     % manual
    
    fmin=str2num(get(handles.edit_start_frequency,'String'));
    fmax=str2num(get(handles.edit_end_frequency,'String'));
end

md=4;



x_label=xaxis_label;
y_label=yaxis_label;

leg1=get(handles.edit_leg1,'String');
leg2=get(handles.edit_leg2,'String');

try
    if(leg1==leg2)
        warndlg('Legends are the same');
    end
catch
end

skv=get(handles.edit_title,'String');

  i50=get(handles.listbox_50,'Value');
iwork=get(handles.listbox_work,'Value');

ny=get(handles.listbox_amplitude_limits,'value');

if(ny==2)
    ymin=str2num(get(handles.edit_ymin','String'));
    ymax=str2num(get(handles.edit_ymax','String'));    
end

if(p==1)  % natural frequency & peak absolute
    
    t_string=sprintf('SRS Q=%g  %s',Q,skv);
    
    ppp1=THM1;
    ppp2=THM2;
    
    ppp50=[fmin 0.8*fmin; fmax 0.8*fmax ];
    leg50='50 ips';
    
    pppw=[10 8; 80 64; 500 64];
    legw='Min Level';
     
    if(iwork==1)
        if(fmin>10)
            fmin=10;
        end
        if(fmax<500)
            fmax=500;
        end
    end
    
    if(i50==2 && iwork==2)
    
        [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
    end
    if(i50==1 && iwork==2)        
        [fig_num,h2]=plot_loglog_function_md_three_h2_third_dash(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp50,leg1,leg2,leg50,fmin,fmax,md)
    end    
    if(i50==2 && iwork==1)        
        [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,pppw,leg1,leg2,legw,fmin,fmax,md)
    end     
    if(i50==1 && iwork==1)        
        [fig_num,h2]=plot_loglog_function_md_four_h2_third_dash(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp50,pppw,leg1,leg2,leg50,legw,fmin,fmax,md); 
    end      
    
    if(ny==2)
       ylim([ymin,ymax]);
    end
    
    
else  % natural frequency & peak positive & peak negative

%%%

    sz1=size(THM1);          
    m11=sz1(1);
    m12=sz1(2);
    
    sz2=size(THM2);          
    m21=sz2(1);
    m22=sz2(2);    
    
    if(m12~=3)
        warndlg(' Input Array 1 must have three columns');
        return;
    end
    if(m22~=3)
        warndlg(' Input Array 2 must have three columns');
        return;
    end    
    
%%%    

    
    THM1a(:,1)=THM1(:,1);
    
    for i=1:m11
        THM1a(i,2)=max([ THM1(i,2)  THM1(i,3) ]);
    end
%%%    

    
    THM2a(:,1)=THM2(:,1);
    
    for i=1:m21
        THM2a(i,2)=max([ THM2(i,2)  THM2(i,3) ]);
    end    
%%%    

    t_string=sprintf('SRS Q=%g  %s\n Absolute',Q,skv);    
        
    ppp1=THM1a;
    ppp2=THM2a;
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
%%% 
    t_string=sprintf('srs Q=%g  %s\n Positive',Q,skv);
    
    ppp1=[THM1(:,1) THM1(:,2) ];
    ppp2=[THM2(:,1) THM2(:,2) ];
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
%%% 
    t_string=sprintf('SRS Q=%g  %s\n Negative',Q,skv);
    
    ppp1=[THM1(:,1) THM1(:,3) ];
    ppp2=[THM2(:,1) THM2(:,3) ];
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);               
               
%%% 

    t_string=sprintf('SRS Q=%g  %s',Q,qskv); 

    ppp1=[THM1(:,1) THM1(:,2) ];
    ppp2=[THM1(:,1) THM1(:,3) ];
    ppp3=[THM2(:,1) THM2(:,2) ];
    ppp4=[THM2(:,1) THM2(:,3) ];

    legg1=sprintf('%s pos',leg1);
    legg2=sprintf('%s neg',leg1); 
    legg3=sprintf('%s pos',leg2);
    legg4=sprintf('%s neg',leg2);      
    
    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,legg1,legg2,legg3,legg4,fmin,fmax,md);    
    
end    
    
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



function edit_input_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
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


% --- Executes during object creation, after setting all properties.
function pushbutton_return_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_input_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_leg1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_leg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_leg1 as text
%        str2double(get(hObject,'String')) returns contents of edit_leg1 as a double


% --- Executes during object creation, after setting all properties.
function edit_leg1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_leg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_leg2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_leg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_leg2 as text
%        str2double(get(hObject,'String')) returns contents of edit_leg2 as a double


% --- Executes during object creation, after setting all properties.
function edit_leg2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_leg2 (see GCBO)
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

try
   ny=get(handles.listbox_amplitude_limits,'value'); 
   PlotSaveMultipleSRS.ny=ny;   
end    

try
    ymin=get(handles.edit_ymin','String');
    PlotSaveMultipleSRS.ymin=ymin;    
end
try
    ymax=get(handles.edit_ymax','String');
    PlotSaveMultipleSRS.ymax=ymax; 
end


try
    listbox_input_type=get(handles.listbox_input_type,'Value');
    PlotSaveMultipleSRS.listbox_input_type=listbox_input_type;
end
try
    listbox_frequency_limits=get(handles.listbox_frequency_limits,'Value');
    PlotSaveMultipleSRS.listbox_frequency_limits=listbox_frequency_limits;
end
try
    listbox_50=get(handles.listbox_50,'Value');
    PlotSaveMultipleSRS.listbox_50=listbox_50;
end
try
    listbox_psave=get(handles.listbox_psave,'Value');
    PlotSaveMultipleSRS.listbox_psave=listbox_psave;
end
try
    listbox_listbox_work=get(handles.listbox_work,'Value');
    PlotSaveMultipleSRS.listbox_work=listbox_work;
end

%%%%%%%%%%%%%%%%

try
    title=get(handles.edit_title,'String');
    PlotSaveMultipleSRS.title=title;
end
try
    Q=get(handles.edit_Q,'String');
    PlotSaveMultipleSRS.Q=Q;
end
try
    yaxis_label=get(handles.edit_yaxis_label,'String');
    PlotSaveMultipleSRS.yaxis_label=yaxis_label;
end
try
    xaxis_label=get(handles.edit_xaxis_label,'String');
    PlotSaveMultipleSRS.xaxis_label=xaxis_label;
end
try
    start_frequency=get(handles.edit_start_frequency,'String');
    PlotSaveMultipleSRS.start_frequency=start_frequency;
end
try
    end_frequency=get(handles.edit_end_frequency,'String');
    PlotSaveMultipleSRS.end_frequency=end_frequency;
end
try
    leg1=get(handles.edit_leg1,'String');
    PlotSaveMultipleSRS.leg1=leg1;
end
try
    leg2=get(handles.edit_leg2,'String');
    PlotSaveMultipleSRS.leg2=leg2;
end


%%%%%

try
    FS1=strtrim(get(handles.edit_input_array_1,'String'));
    PlotSaveMultipleSRS.FS1=FS1; 
    
    try
        THM1=evalin('base',FS1);
        PlotSaveMultipleSRS.THM1=THM1;
    catch
    end
catch    
end

try
    FS2=strtrim(get(handles.edit_input_array_2,'String'));
    PlotSaveMultipleSRS.FS2=FS2;  
    
    try
        THM2=evalin('base',FS2);
        PlotSaveMultipleSRS.THM2=THM2;
    catch
    end
catch    
end



% % %
 
structnames = fieldnames(PlotSaveMultipleSRS, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
        save(elk, 'PlotSaveMultipleSRS');  
    catch
        warndlg('Save error');
        return;
    end
 
msgbox('Save Complete');


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
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
 
   PlotSaveMultipleSRS=evalin('base','PlotSaveMultipleSRS');
 
catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



try
   ny=PlotSaveMultipleSRS.ny    
   set(handles.listbox_amplitude_limits,'value',ny); 
end    

try
    ymin=PlotSaveMultipleSRS.ymin;    
    set(handles.edit_ymin,'String',ymin);    
end
try
    ymax=PlotSaveMultipleSRS.ymax;    
    set(handles.edit_ymax,'String',ymax);  
end




try
    listbox_input_type=PlotSaveMultipleSRS.listbox_input_type;    
    set(handles.listbox_input_type,'Value',listbox_input_type);
end
try
    listbox_frequency_limits=PlotSaveMultipleSRS.listbox_frequency_limits;    
    set(handles.listbox_frequency_limits,'Value',listbox_frequency_limits);
end
try
    listbox_50=PlotSaveMultipleSRS.listbox_50;    
    set(handles.listbox_50,'Value',listbox_50);
end
try
    listbox_psave=PlotSaveMultipleSRS.listbox_psave;    
    set(handles.listbox_psave,'Value',listbox_psave);
end
try
    listbox_work=PlotSaveMultipleSRS.listbox_work;    
    set(handles.listbox_work,'Value',listbox_work);
end

%%%%%%%%%%%%%%%%

try
    title=PlotSaveMultipleSRS.title;    
    set(handles.edit_title,'String',title);
end
try
    Q=PlotSaveMultipleSRS.Q;    
    set(handles.edit_Q,'String',Q);
end
try
    yaxis_label=PlotSaveMultipleSRS.yaxis_label;    
    set(handles.edit_yaxis_label,'String',yaxis_label);
end
try
    xaxis_label=PlotSaveMultipleSRS.xaxis_label;    
    set(handles.edit_xaxis_label,'String',xaxis_label);
end
try
    start_frequency=PlotSaveMultipleSRS.start_frequency;    
    set(handles.edit_start_frequency,'String',start_frequency);
end
try
    end_frequency=PlotSaveMultipleSRS.end_frequency;    
    set(handles.edit_end_frequency,'String',end_frequency);
end
try
    leg1=PlotSaveMultipleSRS.leg1;    
    set(handles.edit_leg1,'String',leg1);
end
try
    leg2=PlotSaveMultipleSRS.leg2;    
    set(handles.edit_leg2,'String',leg2);
end

%%%

try
    FS1=PlotSaveMultipleSRS.FS1;
    set(handles.edit_input_array_1,'String',FS1);
 
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
            THM1=PlotSaveMultipleSRS.THM1;
            assignin('base',FS1,THM1); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS2=PlotSaveMultipleSRS.FS2;
    set(handles.edit_input_array_2,'String',FS2);
 
    iflag=0;
    
    try
        temp=evalin('base',FS2);
        ss=sprintf('Replace %s with Previously Saved Array',FS2);
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
            THM2=PlotSaveMultipleSRS.THM2;
            assignin('base',FS2,THM2); 
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


% --- Executes on selection change in listbox_amplitude_limits.
function listbox_amplitude_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amplitude_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amplitude_limits

n=get(handles.listbox_amplitude_limits,'value');

if(n==1)
   set(handles.text_ymin,'visible','off');
   set(handles.text_ymax,'visible','off'); 
   set(handles.edit_ymin,'visible','off'); 
   set(handles.edit_ymax,'visible','off');    
else
   set(handles.text_ymin,'visible','on');
   set(handles.text_ymax,'visible','on'); 
   set(handles.edit_ymin,'visible','on'); 
   set(handles.edit_ymax,'visible','on');    
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
