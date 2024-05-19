function varargout = triple_y_subplot_1x3(varargin)
% TRIPLE_Y_SUBPLOT_1X3 MATLAB code for triple_y_subplot_1x3.fig
%      TRIPLE_Y_SUBPLOT_1X3, by itself, creates a new TRIPLE_Y_SUBPLOT_1X3 or raises the existing
%      singleton*.
%
%      H = TRIPLE_Y_SUBPLOT_1X3 returns the handle to a new TRIPLE_Y_SUBPLOT_1X3 or the handle to
%      the existing singleton*.
%
%      TRIPLE_Y_SUBPLOT_1X3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRIPLE_Y_SUBPLOT_1X3.M with the given input arguments.
%
%      TRIPLE_Y_SUBPLOT_1X3('Property','Value',...) creates a new TRIPLE_Y_SUBPLOT_1X3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before triple_y_subplot_1x3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to triple_y_subplot_1x3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help triple_y_subplot_1x3

% Last Modified by GUIDE v2.5 28-Oct-2019 09:08:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @triple_y_subplot_1x3_OpeningFcn, ...
                   'gui_OutputFcn',  @triple_y_subplot_1x3_OutputFcn, ...
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


% --- Executes just before triple_y_subplot_1x3 is made visible.
function triple_y_subplot_1x3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to triple_y_subplot_1x3 (see VARARGIN)

% Choose default command line output for triple_y_subplot_1x3
handles.output = hObject;

table_set(hObject, eventdata, handles); 

listbox_xplotlimits1_Callback(hObject, eventdata, handles);
listbox_xplotlimits2_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes triple_y_subplot_1x3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function table_set(hObject, eventdata, handles) 

cn={'Array Name','Y-axis Label'};

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

C=get(handles.uitable_data3,'Data');
 
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
 
set(handles.uitable_data3,'Data',data_s,'ColumnName',cn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cn={'Title','X-axis Label'};

%%%%
 
Ncolumns=2;
 
D=get(handles.uitable_title,'Data');

sz=size(D);

M=size(1);

if(M>3)
    M=3;
end
 
for i=1:3
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    


if(~isempty(D))

    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=D{i,j};
        end    
    end   
 
end
 
set(handles.uitable_title,'Data',data_s,'ColumnName',cn);


% --- Outputs from this function are returned to the command line.
function varargout = triple_y_subplot_1x3_OutputFcn(hObject, eventdata, handles) 
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

delete(triple_y_subplot_1x3);

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
    
catch
    warndlg('Input Arrays read failed 11');
    return;
end
   
try
    
    for i=1:N
        YL1{i}=A(k,:); k=k+1;
        YL1{i} = strtrim(YL1{i});
    end 
    
catch
    warndlg('Input Arrays read failed 12');
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
    
catch
    warndlg('Input Arrays read failed 21');
    return;
end
   
try
    
    for i=1:N
        YL2{i}=A(k,:); k=k+1;
        YL2{i} = strtrim(YL2{i});
    end 
    
catch
    warndlg('Input Arrays read failed 22');
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
    data3=get(handles.uitable_data3,'Data');
    A=char(data3);
    setappdata(0,'data3',data3);
    N=2;
catch
    warndlg(' data 31 get error');
    return;
end


try

    k=1;

    for i=1:N
        array_name3{i}=A(k,:); k=k+1;
        array_name3{i} = strtrim(array_name3{i});
    end 
    
catch
    warndlg('Input Arrays read failed 31');
    return;
end
   
try
    
    for i=1:N
        YL3{i}=A(k,:); k=k+1;
        YL3{i} = strtrim(YL3{i});
    end 
    
catch
    warndlg('Input Arrays read failed 32');
    return;
end

try
    THML3=evalin('base',array_name3{1});
catch
    warndlg('array 31 not found');
    return;
end
    
try    
    THMR3=evalin('base',array_name3{2});
catch
    warndlg('array 32 not found');
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

    for i=1:3
        tstring{i}=ttt(k,:); k=k+1;
        tstring{i} = strtrim(tstring{i});
    end 
    
catch
    warndlg('Input Arrays read failed.  Ref 1');
    return;
end
   
tstring1=tstring{1};
tstring2=tstring{2};
tstring3=tstring{3};

try
    
    for i=1:3
        XL{i}=ttt(k,:); k=k+1;
        XL{i} = strtrim(XL{i});
    end 
    
catch
    warndlg('Input Arrays read failed.  Ref 2');
    return;
end

XL1=XL{1};
XL2=XL{2};
XL3=XL{3};

%%

L=get(handles.listbox_layout,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nx1=get(handles.listbox_xplotlimits1,'Value');
nx2=get(handles.listbox_xplotlimits2,'Value');
nx3=get(handles.listbox_xplotlimits3,'Value');

hp=figure(1);

if(L==1)
    
    subplot(1,3,1);
    
    yyaxis left
    plot(THML1(:,1),THML1(:,2));
    ylabel(YL1{1});

    yyaxis right
    plot(THMR1(:,1),THMR1(:,2));
    ylabel(YL1{2});

    title(tstring1);
    xlabel(XL1);
    grid on;
    

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

    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin','YScale','lin');
    set(gca,'Fontsize',14);   
    
%
    subplot(1,3,2);   
    
    yyaxis left
    plot(THML2(:,1),THML2(:,2));
    ylabel(YL2{1});

    yyaxis right
    plot(THMR2(:,1),THMR2(:,2));
    ylabel(YL2{2});

    title(tstring2);
    xlabel(XL2);
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
    
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin','YScale','lin');
    set(gca,'Fontsize',14);   
    
%
    subplot(1,3,3);   
    
    yyaxis left
    plot(THML3(:,1),THML3(:,2));
    ylabel(YL3{1});

    yyaxis right
    plot(THMR3(:,1),THMR3(:,2));
    ylabel(YL3{2});

    title(tstring3);
    xlabel(XL3);
    grid on;    

    if(nx3==2)
    
        xsa3=get(handles.edit_xmin3,'String');
        if isempty(xsa3)
            warndlg('Enter xmin','Warning');
            return;
        else
            xmin3=str2num(xsa3);
        end
     
        xsb3=get(handles.edit_xmax3,'String');
        if isempty(xsb3)
            warndlg('Enter xmax','Warning');
            return;
        else
            xmax3=str2num(xsb3);
        end
     
        xlim([xmin3,xmax3]);
     
    end
%  

    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin','YScale','lin');
    set(gca,'Fontsize',14);       

    set(hp, 'Position', [0 0 2000 600])


else
    
    subplot(3,1,1);
    
    yyaxis left
    plot(THML1(:,1),THML1(:,2));
    ylabel(YL1{1});

    yyaxis right
    plot(THMR1(:,1),THMR1(:,2));
    ylabel(YL1{2});

    title(tstring1);
    xlabel(XL1);
    grid on;

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
                 
 %
 
    subplot(3,1,2);   
    
    yyaxis left
    plot(THML2(:,1),THML2(:,2));
    ylabel(YL2{1});

    yyaxis right
    plot(THMR2(:,1),THMR2(:,2));
    ylabel(YL2{2});

    title(tstring2);
    xlabel(XL2);
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

%    
    subplot(3,1,3);   
    
    yyaxis left
    plot(THML3(:,1),THML3(:,2));
    ylabel(YL3{1});

    yyaxis right
    plot(THMR3(:,1),THMR3(:,2));
    ylabel(YL3{2});

    title(tstring3);
    xlabel(XL3);
    grid on;    

    if(nx3==2)
    
        xsa3=get(handles.edit_xmin3,'String');
        if isempty(xsa3)
            warndlg('Enter xmin','Warning');
            return;
        else
            xmin3=str2num(xsa3);
        end
     
        xsb3=get(handles.edit_xmax3,'String');
        if isempty(xsb3)
            warndlg('Enter xmax','Warning');
            return;
        else
            xmax3=str2num(xsb3);
        end
     
        xlim([xmin3,xmax3]);
     
    end
    
%

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
    nx3=get(handles.listbox_xplotlimits3,'Value');
    DoubleYPlot.nx3=nx3;
catch
end

try
    xmin3=get(handles.edit_xmin3,'String');
    DoubleYPlot.xmin3=xmin3;
catch
end

try
    xmax3=get(handles.edit_xmax3,'String');
    DoubleYPlot.xmax3=xmax3;
catch
end



try
    data3=get(handles.uitable_data3,'Data');
    DoubleYPlot.data3=data3;
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
    data3=DoubleYPlot.data3; 
    set(handles.uitable_data3,'Data',data3);
catch
end

try
    nx3=DoubleYPlot.nx3;    
    set(handles.listbox_xplotlimits3,'Value',nx3);
catch
end



try
    xmin3=DoubleYPlot.xmin3; 
    set(handles.edit_xmin3,'String',xmin3);
catch
end

try
    xmax3=DoubleYPlot.xmax3; 
    set(handles.edit_xmax3,'String',xmax3);
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
listbox_xplotlimits3_Callback(hObject, eventdata, handles);

% table_set(hObject, eventdata, handles);



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


% --- Executes on selection change in listbox_xplotlimits3.
function listbox_xplotlimits3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xplotlimits3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xplotlimits3

n=get(handles.listbox_xplotlimits3,'Value');

if(n==1)
    set(handles.edit_xmin3,'Enable','off');
    set(handles.edit_xmax3,'Enable','off'); 
else
    set(handles.edit_xmin3,'Enable','on');
    set(handles.edit_xmax3,'Enable','on');  
end


% --- Executes during object creation, after setting all properties.
function listbox_xplotlimits3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmin3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmin3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmin3 as text
%        str2double(get(hObject,'String')) returns contents of edit_xmin3 as a double


% --- Executes during object creation, after setting all properties.
function edit_xmin3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmin3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmax3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax3 as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax3 as a double


% --- Executes during object creation, after setting all properties.
function edit_xmax3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
