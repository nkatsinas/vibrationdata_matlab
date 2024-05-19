function varargout = vibrationdata_SPL_plot_two(varargin)
% VIBRATIONDATA_SPL_PLOT_TWO MATLAB code for vibrationdata_SPL_plot_two.fig
%      VIBRATIONDATA_SPL_PLOT_TWO, by itself, creates a new VIBRATIONDATA_SPL_PLOT_TWO or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SPL_PLOT_TWO returns the handle to a new VIBRATIONDATA_SPL_PLOT_TWO or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SPL_PLOT_TWO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SPL_PLOT_TWO.M with the given input arguments.
%
%      VIBRATIONDATA_SPL_PLOT_TWO('Property','Value',...) creates a new VIBRATIONDATA_SPL_PLOT_TWO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_SPL_plot_two_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_SPL_plot_two_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_SPL_plot_two

% Last Modified by GUIDE v2.5 24-Jul-2019 16:22:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_SPL_plot_two_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_SPL_plot_two_OutputFcn, ...
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


% --- Executes just before vibrationdata_SPL_plot_two is made visible.
function vibrationdata_SPL_plot_two_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_SPL_plot_two (see VARARGIN)

% Choose default command line output for vibrationdata_SPL_plot_two
handles.output = hObject;

Nrows=2;
Ncolumns=2;

%%

A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
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
 
set(handles.uitable_data,'Data',data_s);

%%


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_SPL_plot_two wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_SPL_plot_two_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_SPL_plot_two);


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

N=2;

n_type=get(handles.listbox_ntype,'Value');

tstring=get(handles.edit_title,'String');

try    
    A=char(get(handles.uitable_data,'Data'));
    sz=size(A);
catch
    warndlg(' Read from table failed: ref 1');
    return;       
end
   
%%%%
   
try

   k=1;

    for i=1:N
        th_name=A(k,:); k=k+1;
        th_name = strtrim(th_name);

        th_name
        
        if(i==1)
            s1=evalin('base',th_name);              
        else
            s2=evalin('base',th_name);            
        end
        
    end
    
catch
    warndlg(' Read from table failed: ref 2');
    return;    
end

try
    
    for i=1:N

        th_name=A(k,:); k=k+1;
        th_name=strrep(th_name,'_',' ');
        th_name = strtrim(th_name);
        
        if(i==1)
            leg1=th_name;              
        else
            leg2=th_name;            
        end
        
    end
     
 
catch
    warndlg(' Read from table failed: ref 3');
    return;
end

%

 f1=s1(:,1);
dB1=s1(:,2);

%

 f2=s2(:,1);
dB2=s2(:,2);

n=get(handles.listbox_aux,'Value');


if(n==1)
    spl_plot_two_title_alt(fig_num,n_type,f1,dB1,f2,dB2,leg1,leg2,tstring);
end
if(n==2)
    spl_plot_two_title(fig_num,n_type,f1,dB1,f2,dB2,leg1,leg2,tstring);    
end

if(n==3)
    fpl_plot_two_title_alt(fig_num,n_type,f1,dB1,f2,dB2,leg1,leg2,tstring);    
end


% --- Executes on selection change in listbox_ntype.
function listbox_ntype_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ntype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ntype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ntype


% --- Executes during object creation, after setting all properties.
function listbox_ntype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ntype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    title=get(handles.edit_title,'String'); 
    PlotTwoSPL.title=title;      
catch
end

try
    ntype=get(handles.listbox_ntype,'Value'); 
    PlotTwoSPL.ntype=ntype;      
catch
end

try
    A=get(handles.uitable_data,'Data');
    PlotTwoSPL.A=A;      
catch
end

% % %
 
structnames = fieldnames(PlotTwoSPL, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
        save(elk, 'PlotTwoSPL'); 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');




% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%

disp(' ref 1');
 
[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
disp(' ref 2');
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
disp(' ref 3');
 
structnames
 
 
% struct
 
try
    PlotTwoSPL=evalin('base','PlotTwoSPL');
catch
    warndlg(' evalin failed ');
    return;
end
 
PlotTwoSPL

%%%%

try
    title=PlotTwoSPL.title;      
    set(handles.edit_title,'String',title); 
catch
end

try
    ntype=PlotTwoSPL.ntype;       
    set(handles.listbox_ntype,'Value',ntype);    
catch
end

try
    A=PlotTwoSPL.A;     
    set(handles.uitable_data,'Data',A);     
catch
end


% --- Executes on selection change in listbox_aux.
function listbox_aux_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_aux contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_aux


% --- Executes during object creation, after setting all properties.
function listbox_aux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
