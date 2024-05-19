function varargout = gnuplot_preprocessor(varargin)
% GNUPLOT_PREPROCESSOR MATLAB code for gnuplot_preprocessor.fig
%      GNUPLOT_PREPROCESSOR, by itself, creates a new GNUPLOT_PREPROCESSOR or raises the existing
%      singleton*.
%
%      H = GNUPLOT_PREPROCESSOR returns the handle to a new GNUPLOT_PREPROCESSOR or the handle to
%      the existing singleton*.
%
%      GNUPLOT_PREPROCESSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GNUPLOT_PREPROCESSOR.M with the given input arguments.
%
%      GNUPLOT_PREPROCESSOR('Property','Value',...) creates a new GNUPLOT_PREPROCESSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gnuplot_preprocessor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gnuplot_preprocessor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gnuplot_preprocessor

% Last Modified by GUIDE v2.5 15-May-2020 09:59:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gnuplot_preprocessor_OpeningFcn, ...
                   'gui_OutputFcn',  @gnuplot_preprocessor_OutputFcn, ...
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


% --- Executes just before gnuplot_preprocessor is made visible.
function gnuplot_preprocessor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gnuplot_preprocessor (see VARARGIN)

% Choose default command line output for gnuplot_preprocessor
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

listbox_xplotlimits_Callback(hObject, eventdata, handles);
listbox_yplotlimits_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gnuplot_preprocessor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gnuplot_preprocessor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_generate.
function pushbutton_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * ');
disp(' ');

nleg=get(handles.listbox_legend,'Value');
 
N=get(handles.listbox_num,'Value');
 
A=get(handles.uitable_data,'Data');
 
k=1;
 
for i=1:N
    array{i}=A{k}; k=k+1;
end
for i=1:N
    leg{i}=A{k}; k=k+1;
end
for i=1:N
    pp{i}=A{k}; k=k+1;
end
 
if(N<=2)
    try
        THM1=evalin('base',array{1});
                
        ns1=sprintf('gnuplot_%s.csv',array{1});
    
        writematrix(THM1,ns1); 
    catch
       warndlg('Array 1 not found');
       return; 
    end 
end
if(N==2)
    try
        THM2=evalin('base',array{2});
                
        ns2=sprintf('gnuplot_%s.csv',array{2});
    
        writematrix(THM2,ns2); 
    catch
       warndlg('Array 2 not found');
       return; 
    end 
end


name=get(handles.edit_output_name,'string');
sss=sprintf('%s.plt',name);

nfont=get(handles.listbox_font,'Value');
nfont=nfont+9;

ttt=get(handles.edit_title,'String');
xlab=get(handles.edit_xlabel,'String');
ylab=get(handles.edit_ylabel,'String');

ng=get(handles.listbox_grid,'Value');

sx=str2num(get(handles.edit_sx,'String'));
sy=str2num(get(handles.edit_sy,'String'));


xtype=get(handles.listbox_xtype,'Value');
ytype=get(handles.listbox_ytype,'Value');

nxr=get(handles.listbox_xplotlimits,'Value');
nyr=get(handles.listbox_xplotlimits,'Value');


[writefname, writepname] = uiputfile(sss,'Save data as');
writepfname = fullfile(writepname, writefname);
fid = fopen(writepfname,'w');

% fprintf(fid,'+       %s%s%s%s%s%s',s1,s2,s3,s4,s5,s6);


fprintf(fid,'reset\n');

sss=sprintf('set terminal wxt size %g,%g enhanced font "Verdana,%d" persist\n',sx,sy,nfont);

fprintf(fid,sss);

if(nleg==1)
    fprintf(fid,'set key left top box 7\n');
end
if(nleg==2)
    fprintf(fid,'set key right top box 7\n');
end
if(nleg==3)
    fprintf(fid,'set key outside right top box 7\n');
end
if(nleg==4)
    fprintf(fid,'set key above box 7\n');
end
if(nleg==5)
    fprintf(fid,'unset key\n');
end

% set ylabel "Crest Factor"
% set xlabel "Crossing Rate (Hz)"
% set title "Crest Factor vs. Positive Zero Crossing Rate "
% set grid

% plot "QWWW.txt" with points pointtype 6 pointsize 0.4 lt rgb "blue"

fprintf(fid,'set title "%s" \n',ttt);
fprintf(fid,'set xlabel "%s" \n',xlab);
fprintf(fid,'set ylabel "%s" \n',ylab);
fprintf(fid,'set datafile separator "," \n');

if(ng==1)
    fprintf(fid,'set grid \n');
end

% fprintf(fid,'plot "drop.txt" with points pointtype 6 pointsize 0.4 lt rgb "blue" \n');

if(xtype==1 && ytype==2)
    fprintf(fid,'set logscale y\n');
end
if(xtype==2 && ytype==1)
    fprintf(fid,'set logscale x\n');
end
if(xtype==2 && ytype==2)
    fprintf(fid,'set logscale xy\n');
end

xmin=THM1(1,1);
xmax=THM1(end,1);

if(nxr==2)
    xmin=str2num(get(handles.edit_xmin,'String'));
    xmax=str2num(get(handles.edit_xmax,'String'));
end
if(nyr==2)
    ymin=str2num(get(handles.edit_ymin,'String'));
    ymax=str2num(get(handles.edit_ymax,'String'));
end


if(xtype==2)

    [xstring,iflag]=xtick_label_gnuplot(xmin,xmax);
    
    if(iflag==1)
        fprintf(fid,xstring);
    end
end

if(nxr==2)
    xLstring=sprintf('set xrange[%g:%g] \n',xmin,xmax);
    fprintf(fid,xLstring);
end
if(nyr==2)
    yLstring=sprintf('set yrange[%g:%g] \n',ymin,ymax);    
    fprintf(fid,yLstring);
end


if((N==1 && pp{1}==1) || (N==2 && pp{1}==1 && pp{2}==0))
    if(nleg<=4)
        sn=sprintf('plot "%s" using 1:2 with lines lt rgb "blue" title "%s" \n',ns1,leg{1});
    else
        sn=sprintf('plot "%s" using 1:2 with lines lt rgb "blue"\n',ns1);        
    end
    fprintf(fid,sn); 
end    
if(N==2 && pp{1}==0 && pp{2}==1)
    if(nleg<=4)
        sn=sprintf('plot "%s" using 1:2 with lines lt rgb "blue" title "%s" \n',ns2,leg{2});
    else
        sn=sprintf('plot "%s" using 1:2 with lines lt rgb "blue"\n',ns2);        
    end
    fprintf(fid,sn); 
end   
if(N==2 && pp{1}==1 && pp{2}==1)
    if(nleg<=4)    
        sn1=sprintf('plot "%s" using 1:2 with lines lt rgb "blue" title "%s", ',ns1,leg{1});
        sn2=sprintf('"%s" using 1:2 with lines lt rgb "red" title "%s"\n',ns2,leg{2});
    else
        sn1=sprintf('plot "%s" using 1:2 with lines lt rgb "blue", ',ns1);
        sn2=sprintf('"%s" using 1:2 with lines lt rgb "red"\n',ns2);        
    end
    fprintf(fid,sn1); 
    fprintf(fid,sn2); 
end 


fprintf(fid,'reset\n');

status =fclose('all')
    

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gnuplot_preprocessor);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    xplotlimits=get(handles.listbox_xplotlimits,'Value');
    gnuplotPRE.xplotlimits=xplotlimits;
catch
end

try
    yplotlimits=get(handles.listbox_yplotlimits,'Value');
    gnuplotPRE.yplotlimits=yplotlimits;
catch
end

try
    xmin=get(handles.edit_xmin,'String');
    gnuplotPRE.xmin=xmin;
catch
end
try
    ymin=get(handles.edit_ymin,'String');
    gnuplotPRE.ymin=ymin;
catch
end

try
    xmax=get(handles.edit_xmax,'String');
    gnuplotPRE.xmax=xmax;
catch
end
try
    ymax=get(handles.edit_ymax,'String');
    gnuplotPRE.ymax=ymax;
catch
end



try
    num=get(handles.listbox_num,'Value');
    gnuplotPRE.num=num;
catch
end

try
    xtype=get(handles.listbox_xtype,'Value');
    gnuplotPRE.xtype=xtype;
catch
end

try
    ytype=get(handles.listbox_ytype,'Value');
    gnuplotPRE.ytype=ytype;
catch
end

try
    grid=get(handles.listbox_grid,'Value');
    gnuplotPRE.grid=grid;
catch
end

try
    font=get(handles.listbox_font,'Value');
    gnuplotPRE.font=font;
catch
end

try
    data=get(handles.uitable_data,'Data');
    gnuplotPRE.data=data;
catch
end

try
    xlabel=get(handles.edit_xlabel,'String');
    gnuplotPRE.xlabel=xlabel;
catch
end

try
    ylabel=get(handles.edit_ylabel,'String');
    gnuplotPRE.ylabel=ylabel;
catch
end

try
    title=get(handles.edit_title,'String');
    gnuplotPRE.title=title;
catch
end

try
    sx=get(handles.edit_sx,'String');
    gnuplotPRE.sx=sx;
catch
end

try
    sy=get(handles.edit_sy,'String');
    gnuplotPRE.sy=sy;
catch
end


try
    output_name=get(handles.edit_output_name,'String');
    gnuplotPRE.output_name=output_name;
catch
end




% % %
 
structnames = fieldnames(gnuplotPRE, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
        save(elk, 'gnuplotPRE');  
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


%%%%%%%%%%%%%%%%%%%%%

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
 
   gnuplotPRE=evalin('base','gnuplotPRE');
 
catch
   warndlg(' evalin failed ');
   return;
end
 
%%%%%%%%%%%%%%%%%%%%%


try
    xplotlimits=gnuplotPRE.xplotlimits;    
    set(handles.listbox_xplotlimits,'Value',xplotlimits);
catch
end

try
    yplotlimits=gnuplotPRE.yplotlimits;    
    set(handles.listbox_yplotlimits,'Value',yplotlimits);
catch
end

try
    xmin=gnuplotPRE.xmin;    
    set(handles.edit_xmin,'String',xmin);
catch
end
try
    ymin=gnuplotPRE.ymin;    
    set(handles.edit_ymin,'String',ymin);
catch
end

try
    xmax=gnuplotPRE.xmax;    
    set(handles.edit_xmax,'String',xmax);
catch
end
try
    ymax=gnuplotPRE.ymax;    
    set(handles.edit_ymax,'String',ymax);
catch
end




try
    num=gnuplotPRE.num; 
    set(handles.listbox_num,'Value',num);
catch
end

try
    xtype=gnuplotPRE.xtype;    
    set(handles.listbox_xtype,'Value',xtype);
catch
end

try
    ytype=gnuplotPRE.ytype;    
    set(handles.listbox_ytype,'Value',ytype);
catch
end

try
    grid=gnuplotPRE.grid;    
    set(handles.listbox_grid,'Value',grid);
catch
end

try
    font=gnuplotPRE.font;    
    set(handles.listbox_font,'Value',font);
catch
end

try
    data=gnuplotPRE.data;    
    set(handles.uitable_data,'Data',data);
catch
end

try
    xlabel=gnuplotPRE.xlabel;    
    set(handles.edit_xlabel,'String',xlabel);
catch
end

try
    ylabel=gnuplotPRE.ylabel;    
    set(handles.edit_ylabel,'String',ylabel);
catch
end

try
    title=gnuplotPRE.title;    
    set(handles.edit_title,'String',title);
catch
end

try
    sx=gnuplotPRE.sx;    
    set(handles.edit_sx,'String',sx);
catch
end

try
    sy=gnuplotPRE.sy;    
    set(handles.edit_sy,'String',sy);
catch
end

try
    output_name=gnuplotPRE.output_name;    
    set(handles.edit_output_name,'String',output_name);
catch
end

listbox_xplotlimits_Callback(hObject, eventdata, handles);
listbox_yplotlimits_Callback(hObject, eventdata, handles);

listbox_num_Callback(hObject, eventdata, handles);


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_legend.
function listbox_legend_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_legend contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_legend


% --- Executes during object creation, after setting all properties.
function listbox_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_font.
function listbox_font_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_font (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_font contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_font


% --- Executes during object creation, after setting all properties.
function listbox_font_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_font (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xlabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xlabel as text
%        str2double(get(hObject,'String')) returns contents of edit_xlabel as a double


% --- Executes during object creation, after setting all properties.
function edit_xlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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



function edit_sx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sx as text
%        str2double(get(hObject,'String')) returns contents of edit_sx as a double


% --- Executes during object creation, after setting all properties.
function edit_sx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sy as text
%        str2double(get(hObject,'String')) returns contents of edit_sy as a double


% --- Executes during object creation, after setting all properties.
function edit_sy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sy (see GCBO)
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


Nrows=get(handles.listbox_num,'Value');
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:(Ncolumns-1)
        data_s{i,j}='';
    end 
    data_s{i,3}=true;
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:(Ncolumns-1)
            data_s{i,j}=A{i,j};
        end   
        data_s{i,3}=true;
    end   
 
end

try
    columnformat={[],[],'logical'};
    set(handles.uitable_data,'Data',data_s,'ColumnFormat',columnformat)
catch
end





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


% --- Executes on selection change in listbox_yplotlimits.
function listbox_yplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits

n=get(handles.listbox_yplotlimits,'Value');

if(n==1)
    set(handles.edit_ymin,'Enable','off');
    set(handles.edit_ymax,'Enable','off'); 
else
    set(handles.edit_ymin,'Enable','on');
    set(handles.edit_ymax,'Enable','on');  
end



% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
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


% --- Executes during object creation, after setting all properties.
function pushbutton_load_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
