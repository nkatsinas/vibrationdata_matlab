function varargout = oaspl(varargin)
% OASPL MATLAB code for oaspl.fig
%      OASPL, by itself, creates a new OASPL or raises the existing
%      singleton*.
%
%      H = OASPL returns the handle to a new OASPL or the handle to
%      the existing singleton*.
%
%      OASPL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OASPL.M with the given input arguments.
%
%      OASPL('Property','Value',...) creates a new OASPL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before oaspl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to oaspl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help oaspl

% Last Modified by GUIDE v2.5 20-Aug-2019 15:34:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @oaspl_OpeningFcn, ...
                   'gui_OutputFcn',  @oaspl_OutputFcn, ...
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


% --- Executes just before oaspl is made visible.
function oaspl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to oaspl (see VARARGIN)

% Choose default command line output for oaspl
handles.output = hObject;

set(handles.listbox_octave,'Value',1);

set(handles.listbox_method,'Value',1);
clear_results(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes oaspl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles)
%
set(handles.uipanel_results,'Visible','off');
set(handles.text_oaspl,'Visible','off');
set(handles.edit_oaspl,'Visible','off');



% --- Outputs from this function are returned to the command line.
function varargout = oaspl_OutputFcn(hObject, eventdata, handles) 
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

fig_num=1;

set(handles.uipanel_results,'Visible','on');
set(handles.text_oaspl,'Visible','on');
set(handles.edit_oaspl,'Visible','on');


ng=get(handles.listbox_grid,'Value');

n_type=get(handles.listbox_octave,'Value');

pt=get(handles.listbox_plot_type,'Value');


k=get(handles.listbox_method,'Value');

if(k==1)
  FS=strtrim(get(handles.edit_input_array,'String'));
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end
%

db=THM(:,2);
%
[oadb]=oaspl_function(db);

s1=sprintf('%8.4g',oadb);
set(handles.edit_oaspl,'String',s1);

%

nf=get(handles.listbox_function,'Value');

ttt=get(handles.edit_tstring,'String');


out1=sprintf('\n  Overall Level = %8.4g dB',oadb);
disp(out1)
disp('  ');
disp(' zero dB Reference = 20 micro Pascal ');
disp('  ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nf==1)
    if(n_type==1)
        t_string=sprintf(' One-Third Octave Sound Pressure Level, %s\n OASPL = %8.4g dB  Ref: 20 micro Pa ',ttt,oadb);
    else
        t_string=sprintf(' Full Octave Sound Pressure Level, %s \n OASPL = %8.4g dB  Ref: 20 micro Pa ',ttt,oadb);    
    end    
else
    if(n_type==1)
        t_string=sprintf(' One-Third Octave FPL, %s \n OAFPL = %8.4g dB  Ref: 20 micro Pa ',ttt,oadb);
    else
        t_string=sprintf(' Full Octave FPL, %s \n OAFPL = %8.4g dB  Ref: 20 micro Pa ',ttt,oadb);    
    end      
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fmin=THM(1,1);
fmax=THM(end,1);

%

if(pt==1)
    
    figure(fig_num);
    
    plot(THM(:,1),THM(:,2));
    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);
    
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);
        xlim([fmin,fmax]);     
    end
    
    dB=THM(:,2);

    [ymin,ymax]=dB_ylimits(dB);
    
    ylim([ymin,ymax]);    
    
    title(t_string)
    xlabel('Center Frequency (Hz)');
    if(nf==1)
        ylabel('SPL (dB)');
    else
        ylabel('FPL (dB)');        
    end
        
    if(ng==1)
        grid on;
        set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
    end    
    if(ng==2)
        grid on;
        set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','log','YScale','lin');
    end
    if(ng==3)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','log','YScale','lin');
    end

else
   
    data=THM;
    
    xlab='Center Frequency (Hz)';
    
    if(nf==1)
        ylab='SPL (dB)';
    else
        ylab='FPL (dB)';        
    end    
        
    if(n_type==1)
        [fig_num]=plot_one_onethird_bar_ng(fig_num,xlab,ylab,data,t_string,ng);
    else
        [fig_num]=plot_one_one_bar_ng(fig_num,xlab,ylab,data,t_string,ng);       
    end    

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(oaspl);


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


% --- Executes on selection change in listbox_plot_type.
function listbox_plot_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plot_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plot_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plot_type


% --- Executes during object creation, after setting all properties.
function listbox_plot_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plot_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_grid.
function listbox_grid_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_grid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_grid


% --- Executes during object creation, after setting all properties.
function listbox_grid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_function.
function listbox_function_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_function contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_function


% --- Executes during object creation, after setting all properties.
function listbox_function_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
