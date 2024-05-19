function varargout = subplot_1x2_two_curves_each_side(varargin)
% SUBPLOT_1X2_TWO_CURVES_EACH_SIDE MATLAB code for subplot_1x2_two_curves_each_side.fig
%      SUBPLOT_1X2_TWO_CURVES_EACH_SIDE, by itself, creates a new SUBPLOT_1X2_TWO_CURVES_EACH_SIDE or raises the existing
%      singleton*.
%
%      H = SUBPLOT_1X2_TWO_CURVES_EACH_SIDE returns the handle to a new SUBPLOT_1X2_TWO_CURVES_EACH_SIDE or the handle to
%      the existing singleton*.
%
%      SUBPLOT_1X2_TWO_CURVES_EACH_SIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUBPLOT_1X2_TWO_CURVES_EACH_SIDE.M with the given input arguments.
%
%      SUBPLOT_1X2_TWO_CURVES_EACH_SIDE('Property','Value',...) creates a new SUBPLOT_1X2_TWO_CURVES_EACH_SIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before subplot_1x2_two_curves_each_side_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to subplot_1x2_two_curves_each_side_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help subplot_1x2_two_curves_each_side

% Last Modified by GUIDE v2.5 17-Jan-2020 13:46:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @subplot_1x2_two_curves_each_side_OpeningFcn, ...
                   'gui_OutputFcn',  @subplot_1x2_two_curves_each_side_OutputFcn, ...
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


% --- Executes just before subplot_1x2_two_curves_each_side is made visible.
function subplot_1x2_two_curves_each_side_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to subplot_1x2_two_curves_each_side (see VARARGIN)

% Choose default command line output for subplot_1x2_two_curves_each_side
handles.output = hObject;

table_set(hObject, eventdata, handles); 

listbox_xplotlimits1_Callback(hObject, eventdata, handles);
listbox_xplotlimits2_Callback(hObject, eventdata, handles);

listbox_yplotlimits1_Callback(hObject, eventdata, handles);
listbox_yplotlimits2_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes subplot_1x2_two_curves_each_side wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function table_set(hObject, eventdata, handles) 

cn={'Array Name','Legend'};

%%%%
 
Nrows=2;
Ncolumns=2;
 
A=get(handles.uitable_data1,'Data');

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
 
set(handles.uitable_data1,'Data',data_s,'ColumnName',cn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B=get(handles.uitable_data2,'Data');

sz=size(B);
Arows=2;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    


if(~isempty(B))
    
    M=min([ Arows Nrows ]);
    

    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=B{i,j};
        end    
    end   
 
end
 
set(handles.uitable_data2,'Data',data_s,'ColumnName',cn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cn={'Title','X-axis Label','Y-axis Label'};

%%%%
 
Nrows=2;
Ncolumns=3;
 
C=get(handles.uitable_title,'Data');
 
sz=size(C);
Arows=2;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    


if(~isempty(C))
    
    M=min([ Arows Nrows ]);
    

    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=C{i,j};
        end    
    end   
 
end
 
set(handles.uitable_title,'Data',data_s,'ColumnName',cn);


% --- Outputs from this function are returned to the command line.
function varargout = subplot_1x2_two_curves_each_side_OutputFcn(hObject, eventdata, handles) 
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

delete(subplot_1x2_two_curves_each_side);

% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    data1=get(handles.uitable_data1,'Data');
    A=char(data1);
    setappdata(0,'data1',data1);
    N=2;
catch
    warndlg(' data 11 get error');
    return;
end


try

    k=1;

    for i=1:N
        array_name1{i}=A(k,:); k=k+1;
        array_name1{i} = strtrim(array_name1{i});
    end 
    for i=1:N
        leg1{i}=A(k,:); k=k+1;
        leg1{i} = strtrim(leg1{i});
    end 
    
catch
    warndlg('Input Arrays read failed 11');
    return;
end
   


try
    THML1=evalin('base',array_name1{1});
catch
    warndlg('array 11 not found');
    return;
end
    
try    
    THMR1=evalin('base',array_name1{2});
catch
    warndlg('array 12 not found');
    return;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    data2=get(handles.uitable_data2,'Data');
    A=char(data2);
    setappdata(0,'data2',data2);
    N=2;
catch
    warndlg(' data 21 get error');
    return;
end


try

    k=1;

    for i=1:N
        array_name2{i}=A(k,:); k=k+1;
        array_name2{i} = strtrim(array_name2{i});
    end 
    for i=1:N
        leg2{i}=A(k,:); k=k+1;
        leg2{i} = strtrim(leg2{i});
    end 
    
catch
    warndlg('Input Arrays read failed 21');
    return;
end
   

try
    THML2=evalin('base',array_name2{1});
catch
    warndlg('array 21 not found');
    return;
end
    
try    
    THMR2=evalin('base',array_name2{2});
catch
    warndlg('array 22 not found');
    return;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    ttt=get(handles.uitable_title,'Data');
    ttt=char(ttt);
catch
    warndlg(' data title get error');
    return;
end

%%

try

    k=1;

    for i=1:N
        tstring{i}=ttt(k,:); k=k+1;
        tstring{i} = strtrim(tstring{i});
    end 
    
catch
    warndlg('Input Arrays read failed 31');
    return;
end
   
tstring1=tstring{1};
tstring2=tstring{2};


try
    
    for i=1:N
        XL{i}=ttt(k,:); k=k+1;
        XL{i} = strtrim(XL{i});
    end 
    
    for i=1:N
        YL{i}=ttt(k,:); k=k+1;
        YL{i} = strtrim(YL{i});
    end 
    
catch
    warndlg('Input Arrays read failed 32');
    return;
end

XL1=XL{1};
XL2=XL{2};

YL1=YL{1};
YL2=YL{2};

%%

L=get(handles.listbox_layout,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nx1=get(handles.listbox_xplotlimits1,'Value');
nx2=get(handles.listbox_xplotlimits2,'Value');

ny1=get(handles.listbox_yplotlimits1,'Value');
ny2=get(handles.listbox_yplotlimits2,'Value');

hp=figure(1);

    if(L==1)
        subplot(1,2,1);
    else
        subplot(2,1,1);        
    end
        
    plot(THML1(:,1),THML1(:,2),THMR1(:,1),THMR1(:,2));
    legend(leg1{1},leg1{2});
    title(tstring1);
    xlabel(XL1);
    ylabel(YL1);
     
    grid on;
    set(gca,'Fontsize',14); 
    
    if(nx1==2)
    
        xsa1=get(handles.edit_xmin1,'String');
        if isempty(xsa1)
            warndlg('Enter xmin','Warning');
            return;
        else
            xmin1=str2num(xsa1);
        end
     
        xsb1=get(handles.edit_xmax1,'String');
        if isempty(xsb1)
            warndlg('Enter xmax','Warning');
            return;
        else
            xmax1=str2num(xsb1);
        end
     
        xlim([xmin1,xmax1]);
     
    end     
    
    if(ny1==2)
    
        ysa1=get(handles.edit_ymin1,'String');
        if isempty(ysa1)
            warndlg('Enter ymin','Warning');
            return;
        else
            ymin1=str2num(ysa1);
        end
     
        ysb1=get(handles.edit_ymax1,'String');
        if isempty(ysb1)
            warndlg('Enter ymax','Warning');
            return;
        else
            ymax1=str2num(ysb1);
        end
     
        ylim([ymin1,ymax1]);
     
    end         
    
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin','YScale','lin');
    set(gca,'Fontsize',14);         
     
    if(L==1)
        subplot(1,2,2);   
    else
        subplot(2,1,2);         
    end
        
    plot(THML2(:,1),THML2(:,2),THMR2(:,1),THMR2(:,2));
    legend(leg2{1},leg2{2});
    title(tstring2);
    xlabel(XL2);
    ylabel(YL2);    
    grid on;  
    
     if(nx2==2)
    
        xsa2=get(handles.edit_xmin2,'String');
        if isempty(xsa2)
            warndlg('Enter xmin','Warning');
            return;
        else
            xmin2=str2num(xsa2);
        end
     
        xsb2=get(handles.edit_xmax2,'String');
        if isempty(xsb2)
            warndlg('Enter xmax','Warning');
            return;
        else
            xmax2=str2num(xsb2);
        end
     
        xlim([xmin2,xmax2]);
     
     end     
     
     if(ny2==2)
    
        ysa2=get(handles.edit_ymin2,'String');
        if isempty(ysa2)
            warndlg('Enter ymin','Warning');
            return;
        else
            ymin2=str2num(ysa2);
        end
     
        ysb2=get(handles.edit_ymax2,'String');
        if isempty(ysb2)
            warndlg('Enter ymax','Warning');
            return;
        else
            ymax2=str2num(ysb2);
        end
     
        ylim([ymin2,ymax2]);
     
    end         
     
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin','YScale','lin');
    set(gca,'Fontsize',14);          
           
% set(hp, 'Position', [0 0 1600 600]);
             
                 
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


% --- Executes on selection change in listbox_xplotlimits1.
function listbox_xplotlimits1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xplotlimits1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xplotlimits1


n=get(handles.listbox_xplotlimits1,'Value');

if(n==1)
    set(handles.edit_xmin1,'Enable','off');
    set(handles.edit_xmax1,'Enable','off'); 
else
    set(handles.edit_xmin1,'Enable','on');
    set(handles.edit_xmax1,'Enable','on');  
end


% --- Executes during object creation, after setting all properties.
function listbox_xplotlimits1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmin1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmin1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmin1 as text
%        str2double(get(hObject,'String')) returns contents of edit_xmin1 as a double


% --- Executes during object creation, after setting all properties.
function edit_xmin1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmin1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax1 as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax1 as a double


% --- Executes during object creation, after setting all properties.
function edit_xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax1 (see GCBO)
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
    nx1=get(handles.listbox_xplotlimits1,'Value');
    DoubleYPlot.nx1=nx1;
catch
end

try
    xmin1=get(handles.edit_xmin1,'String');
    DoubleYPlot.xmin1=xmin1;
catch
end

try
    xmax1=get(handles.edit_xmax1,'String');
    DoubleYPlot.xmax1=xmax1;
catch
end



try
    data1=get(handles.uitable_data1,'Data');
    DoubleYPlot.data1=data1;
catch
end

%%%

try
    nx2=get(handles.listbox_xplotlimits2,'Value');
    DoubleYPlot.nx2=nx2;
catch
end

try
    xmin2=get(handles.edit_xmin2,'String');
    DoubleYPlot.xmin2=xmin2;
catch
end

try
    xmax2=get(handles.edit_xmax2,'String');
    DoubleYPlot.xmax2=xmax2;
catch
end



try
    data2=get(handles.uitable_data2,'Data');
    DoubleYPlot.data2=data2;
catch
end

%%%

try
    layout=get(handles.listbox_layout,'Value');
    DoubleYPlot.layout=layout;
catch
end

try
    title=get(handles.uitable_title,'data');
    DoubleYPlot.title=title;
catch
end

%%%


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
    data1=DoubleYPlot.data1; 
    set(handles.uitable_data1,'Data',data1);
catch
end

try
    nx1=DoubleYPlot.nx1;    
    set(handles.listbox_xplotlimits1,'Value',nx1);
catch
end



try
    xmin1=DoubleYPlot.xmin1; 
    set(handles.edit_xmin1,'String',xmin1);
catch
end

try
    xmax1=DoubleYPlot.xmax1; 
    set(handles.edit_xmax1,'String',xmax1);
catch
end

%%%


try
    data2=DoubleYPlot.data2; 
    set(handles.uitable_data2,'Data',data2);
catch
end

try
    nx2=DoubleYPlot.nx2;    
    set(handles.listbox_xplotlimits2,'Value',nx2);
catch
end



try
    xmin2=DoubleYPlot.xmin2; 
    set(handles.edit_xmin2,'String',xmin2);
catch
end

try
    xmax2=DoubleYPlot.xmax2; 
    set(handles.edit_xmax2,'String',xmax2);
catch
end

%%%

try
    layout=DoubleYPlot.layout; 
    set(handles.listbox_layout,'Value',layout);
catch
end

try
    title=DoubleYPlot.title;    
    set(handles.uitable_title,'data',title);
catch
end


%%%

listbox_xplotlimits1_Callback(hObject, eventdata, handles);
listbox_xplotlimits2_Callback(hObject, eventdata, handles);



% --- Executes on selection change in listbox_layout.
function listbox_layout_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_layout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_layout contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_layout


% --- Executes during object creation, after setting all properties.
function listbox_layout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_layout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_xplotlimits2.
function listbox_xplotlimits2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xplotlimits2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xplotlimits2

n=get(handles.listbox_xplotlimits2,'Value');

if(n==1)
    set(handles.edit_xmin2,'Enable','off');
    set(handles.edit_xmax2,'Enable','off'); 
else
    set(handles.edit_xmin2,'Enable','on');
    set(handles.edit_xmax2,'Enable','on');  
end



% --- Executes during object creation, after setting all properties.
function listbox_xplotlimits2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmin2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmin2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmin2 as text
%        str2double(get(hObject,'String')) returns contents of edit_xmin2 as a double


% --- Executes during object creation, after setting all properties.
function edit_xmin2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmin2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmax1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax1 as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax1 as a double


% --- Executes during object creation, after setting all properties.
function edit_xmax1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmax2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax2 as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax2 as a double


% --- Executes during object creation, after setting all properties.
function edit_xmax2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin2 as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin2 as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax2 as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax2 as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits2.
function listbox_yplotlimits2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits2

n=get(handles.listbox_yplotlimits2,'Value');

if(n==1)
    set(handles.edit_ymin2,'Enable','off');
    set(handles.edit_ymax2,'Enable','off'); 
else
    set(handles.edit_ymin2,'Enable','on');
    set(handles.edit_ymax2,'Enable','on');  
end



% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin1 as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin1 as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax1 as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax1 as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits1.
function listbox_yplotlimits1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits1

n=get(handles.listbox_yplotlimits1,'Value');

if(n==1)
    set(handles.edit_ymin1,'Enable','off');
    set(handles.edit_ymax1,'Enable','off'); 
else
    set(handles.edit_ymin1,'Enable','on');
    set(handles.edit_ymax1,'Enable','on');  
end



% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable_data1.
function uitable_data1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_data1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
