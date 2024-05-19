function varargout = double_y_plot(varargin)
% DOUBLE_Y_PLOT MATLAB code for double_y_plot.fig
%      DOUBLE_Y_PLOT, by itself, creates a new DOUBLE_Y_PLOT or raises the existing
%      singleton*.
%
%      H = DOUBLE_Y_PLOT returns the handle to a new DOUBLE_Y_PLOT or the handle to
%      the existing singleton*.
%
%      DOUBLE_Y_PLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DOUBLE_Y_PLOT.M with the given input arguments.
%
%      DOUBLE_Y_PLOT('Property','Value',...) creates a new DOUBLE_Y_PLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before double_y_plot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to double_y_plot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help double_y_plot

% Last Modified by GUIDE v2.5 30-Jun-2020 14:18:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @double_y_plot_OpeningFcn, ...
                   'gui_OutputFcn',  @double_y_plot_OutputFcn, ...
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


% --- Executes just before double_y_plot is made visible.
function double_y_plot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to double_y_plot (see VARARGIN)

% Choose default command line output for double_y_plot
handles.output = hObject;

table_set(hObject, eventdata, handles); 

listbox_left_ytype_Callback(hObject, eventdata, handles);
listbox_right_ytype_Callback(hObject, eventdata, handles);


listbox_xplotlimits_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes double_y_plot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function table_set(hObject, eventdata, handles) 

cn={'Array Name','Y-axis Label','Legend'};

%%%%
 
Nrows=2;
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');
 
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
function varargout = double_y_plot_OutputFcn(hObject, eventdata, handles) 
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

delete(double_y_plot);

% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    N=2;
catch
    warndlg(' data get error');
    return;
end


try

    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
    end 
    
catch
    warndlg('Input Arrays read failed 1');
    return;
end
   
try
    
    for i=1:N
        YL{i}=A(k,:); k=k+1;
        YL{i} = strtrim(YL{i});
    end 
    
catch
    warndlg('Input Arrays read failed 2');
    return;
end

try
    
    for i=1:N
        leg{i}=A(k,:); k=k+1;
        leg{i} = strtrim(leg{i});
    end 
    
catch
    warndlg('Input Arrays read failed 2');
    return;
end


try
    THML=evalin('base',array_name{1});
catch
    warndlg('array 1 not found');
    return;
end
    
try    
    THMR=evalin('base',array_name{2});
catch
    warndlg('array 2 not found');
    return;    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xtype=get(handles.listbox_xtype,'Value');
ytype=get(handles.listbox_ytype,'Value');


XL=get(handles.edit_XL,'String');

tstring=get(handles.edit_tstring,'String');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nleft=get(handles.listbox_left_ytype,'Value');
nright=get(handles.listbox_right_ytype,'Value');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fig=figure(1);


cmap(1,:)=[0 0 0.8];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];      % gold
cmap(16,:)=[0 0.8 0.8];     % turquoise   



yyaxis left
plot(THML(:,1),THML(:,2),'Color',cmap(5,:));
ylabel(YL{1});

if(xtype==1 && ytype==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin',...
                     'YScale','lin','XminorTick','on','YminorTick','on');
end                 
if(xtype==1 && ytype==2)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin',...
                     'YScale','log','XminorTick','on','YminorTick','on');
end  
if(xtype==2 && ytype==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','lin','XminorTick','on','YminorTick','on');
end  
if(xtype==2 && ytype==2)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','on','YminorTick','on');
end 

if(nleft==2)
    yleft_min=str2double(get(handles.edit_yleft_min,'String'));
    yleft_max=str2double(get(handles.edit_yleft_max,'String'));    
    ylim([yleft_min yleft_max ]);
end




yyaxis right
plot(THMR(:,1),THMR(:,2),'Color',cmap(6,:));
ylabel(YL{2});

title(tstring);
xlabel(XL);
grid on;

if(xtype==1 && ytype==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin',...
                     'YScale','lin','XminorTick','on','YminorTick','on');
end                 
if(xtype==1 && ytype==2)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin',...
                     'YScale','log','XminorTick','on','YminorTick','on');
end  
if(xtype==2 && ytype==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','lin','XminorTick','on','YminorTick','on');
end  
if(xtype==2 && ytype==2)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','on','YminorTick','on');
end 

if(nright==2)
    yright_min=str2double(get(handles.edit_yright_min,'String'));
    yright_max=str2double(get(handles.edit_yright_max,'String')); 
    ylim([yright_min yright_max ]);
end

                 
nx=get(handles.listbox_xplotlimits,'Value');

if(nx==1)
    
    if(xtype==2)
        
        xmin=min([ THMR(1,1)  THML(1,1)  ]);
        xmax=max([ THMR(end,1)  THML(end,1)  ]);
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);

        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
            fmin=min(xtt);
            fmax=max(xtt);
            xlim([fmin,fmax]);    
        end    
    end    
    
else
    
     xs1=get(handles.edit_xmin,'String');
     if isempty(xs1)
        warndlg('Enter xmin','Warning');
        return;
     else
        xmin=str2num(xs1);
     end
     
     xs2=get(handles.edit_xmax,'String');
     if isempty(xs2)
        warndlg('Enter xmax','Warning');
        return;
     else
        xmax=str2num(xs2);
     end
     
     xlim([xmin,xmax]);

     if(xtype==2)
     
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);

        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
            fmin=min(xtt);
            fmax=max(xtt);
            xlim([fmin,fmax]);    
        end
     end    

end

legend(leg{1},leg{2});

ax = gca;
ax.YAxis(1).Color = cmap(5,:);
ax.YAxis(2).Color = cmap(6,:);


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


% --- Executes on selection change in listbox_left_ytype.
function listbox_left_ytype_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_left_ytype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_left_ytype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_left_ytype

n=get(handles.listbox_left_ytype,'Value');


set(handles.edit_yleft_min,'Visible','off');
set(handles.edit_yleft_max,'Visible','off');
set(handles.text_yleft_min,'Visible','off');
set(handles.text_yleft_max,'Visible','off');
    
    
if(n==2)
    
    set(handles.edit_yleft_min,'Visible','on');
    set(handles.edit_yleft_max,'Visible','on');
    set(handles.text_yleft_min,'Visible','on');
    set(handles.text_yleft_max,'Visible','on');
    
end



% --- Executes during object creation, after setting all properties.
function listbox_left_ytype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_left_ytype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_right_ytype.
function listbox_right_ytype_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_right_ytype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_right_ytype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_right_ytype

n=get(handles.listbox_right_ytype,'Value');


set(handles.edit_yright_min,'Visible','off');
set(handles.edit_yright_max,'Visible','off');
set(handles.text_yright_min,'Visible','off');
set(handles.text_yright_max,'Visible','off');
    
    
if(n==2)
    
    set(handles.edit_yright_min,'Visible','on');
    set(handles.edit_yright_max,'Visible','on');
    set(handles.text_yright_min,'Visible','on');
    set(handles.text_yright_max,'Visible','on');
    
end



% --- Executes during object creation, after setting all properties.
function listbox_right_ytype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_right_ytype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yleft_min_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yleft_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yleft_min as text
%        str2double(get(hObject,'String')) returns contents of edit_yleft_min as a double


% --- Executes during object creation, after setting all properties.
function edit_yleft_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yleft_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yleft_max_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yleft_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yleft_max as text
%        str2double(get(hObject,'String')) returns contents of edit_yleft_max as a double


% --- Executes during object creation, after setting all properties.
function edit_yleft_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yleft_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yright_min_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yright_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yright_min as text
%        str2double(get(hObject,'String')) returns contents of edit_yright_min as a double


% --- Executes during object creation, after setting all properties.
function edit_yright_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yright_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yright_max_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yright_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yright_max as text
%        str2double(get(hObject,'String')) returns contents of edit_yright_max as a double


% --- Executes during object creation, after setting all properties.
function edit_yright_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yright_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
