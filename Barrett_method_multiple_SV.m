function varargout = Barrett_method_multiple_SV(varargin)
% BARRETT_METHOD_MULTIPLE_SV MATLAB code for Barrett_method_multiple_SV.fig
%      BARRETT_METHOD_MULTIPLE_SV, by itself, creates a new BARRETT_METHOD_MULTIPLE_SV or raises the existing
%      singleton*.
%
%      H = BARRETT_METHOD_MULTIPLE_SV returns the handle to a new BARRETT_METHOD_MULTIPLE_SV or the handle to
%      the existing singleton*.
%
%      BARRETT_METHOD_MULTIPLE_SV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BARRETT_METHOD_MULTIPLE_SV.M with the given input arguments.
%
%      BARRETT_METHOD_MULTIPLE_SV('Property','Value',...) creates a new BARRETT_METHOD_MULTIPLE_SV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Barrett_method_multiple_SV_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Barrett_method_multiple_SV_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Barrett_method_multiple_SV

% Last Modified by GUIDE v2.5 25-Jun-2019 09:36:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Barrett_method_multiple_SV_OpeningFcn, ...
                   'gui_OutputFcn',  @Barrett_method_multiple_SV_OutputFcn, ...
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


% --- Executes just before Barrett_method_multiple_SV is made visible.
function Barrett_method_multiple_SV_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Barrett_method_multiple_SV (see VARARGIN)

% Choose default command line output for Barrett_method_multiple_SV
handles.output = hObject;


[num,txt,raw]  = xlsread('Book_S.csv');

sz=size(raw);

for i=1:sz(2)
        
    if(raw{2,i}~=47)
        aaa=strrep(raw{4,i},'/','-');
        aaa=strrep(aaa,'2002','2');
        a=sprintf('PSD  Fig %d  %s  Zone %s  %s  %s %s %s ',raw{2,i},raw{3,i},aaa,raw{5,i},raw{6,i},raw{7,i},raw{8,i});
        b=sprintf('PSD  Fig %d  %s  Zone %s  %s  \n%s %s %s ',raw{2,i},raw{3,i},aaa,raw{5,i},raw{6,i},raw{7,i},raw{8,i});
    else
        aaa=7;
        a=sprintf('PSD  Fig %d  %s  Zone %d  %s  %s %s %s ',raw{2,i},raw{3,i},aaa,raw{5,i},raw{6,i},raw{7,i},raw{8,i});
        b=sprintf('PSD  Fig %d  %s  Zone %d  %s  \n%s %s %s ',raw{2,i},raw{3,i},aaa,raw{5,i},raw{6,i},raw{7,i},raw{8,i});
    end
 
    
    b=strrep(b,'LONG','Long');
    b=strrep(b,'TANGENT','Tangent');
    b=strrep(b,'RADIAL','Radial'); 
    b=strrep(b,'NORMAL','Normal'); 
    
    b=strrep(b,'LIFTOFF','Liftoff'); 
    b=strrep(b,'MACH','Mach');     
    b=strrep(b,'MAX','Max');   
    b=strrep(b,'STATIC','Static');     
         
    title{i}=a;
    title2{i}=b;

end


str0={'psd_f12';'psd_f14';'psd_f16';'psd_f18';'psd_f20';'psd_f21';'psd_f22';...
      'psd_f23';'psd_f24';'psd_f25';'psd_f26';'psd_f27';'psd_f30';'psd_f32';...   
      'psd_f34';'psd_f35';'psd_f40';'psd_f41';'psd_f42';'psd_f44';'psd_f47';...	 
      'psd_f51';'psd_f53';'psd_f56';'psd_f58';'psd_f60';'psd_f62';'psd_f64';...
      'psd_f65';'psd_f66';'psd_f67';'psd_f71';'psd_f73';'psd_f75';'psd_f77';...
      'psd_f78';'psd_f79';'psd_f81';'psd_f83';'psd_f85';'psd_f87';'psd_f89';...
      'psd_f91';'psd_f93';'psd_f94';'psd_f95';'psd_f96';'psd_f97';'psd_f98';...
      'psd_f104';'psd_f106';'psd_f108';'psd_f110';'psd_f112';'psd_f113'};


str1={ 'spl_f13_int';'spl_f15_int';'spl_f17_int';'spl_f19_int';'spl_f31_int';...
       'spl_f33_int';'spl_f36_int';'spl_f43_int';'spl_f45_int';'spl_f48_int';...
       'spl_f52_int';'spl_f54_int';'spl_f57_int';'spl_f59_int';'spl_f61_int';...
       'spl_f63_int';'spl_f72_int';'spl_f74_int';'spl_f76_int';'spl_f80_int';...
       'spl_f84_int';'spl_f86_int';'spl_f88_int';'spl_f90_int';'spl_f92_int';...
       'spl_f105_int';'spl_f107_int';'spl_f109_int';'spl_f111_int';'spl_f114_int'};


n=60;


for i=1:n
    myData{i,1}='';
    myData{i,2}='choose';
    myData{i,3}='choose';
    myData{i,4}='';    
end
      
      
 set(handles.uitable_data,'ColumnFormat',({[] str0' str1' []}),... 
            'ColumnEditable', true,...
            'Data', myData);


listbox_num_Callback(hObject, eventdata, handles);

setappdata(0,'str0',str0);
setappdata(0,'title',title);
setappdata(0,'title2',title2);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Barrett_method_multiple_SV wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Barrett_method_multiple_SV_OutputFcn(hObject, eventdata, handles) 
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

disp(' ');
disp(' * * * * * * * * * * * * * * * * * * * * * * ');
disp(' ');

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

title=getappdata(0,'title');
title2=getappdata(0,'title2');


try
    FS1=strtrim(get(handles.edit_ref_spl,'String'));
    SPL_ref=evalin('base',FS1);  
catch
    warndlg('Reference SPL array not found ');
    return; 
end

szr=size(SPL_ref);

if(szr(2)~=2)
    warndlg('Input Reference SPL array must have two columns');
    return;
end

get_table_data(hObject, eventdata, handles);

t_string=getappdata(0,'t_string');
 Ref_PSD=getappdata(0,'Ref_PSD');
 New_SPL=getappdata(0,'New_SPL');
 New_PSD=getappdata(0,'New_PSD');

%%%

ref_spl=SPL_ref;
sz=size(ref_spl);
nf_ref_spl=sz(1);
 
num=get(handles.listbox_num,'Value');

%

x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';


disp(' ');
disp(' Output Arrays ');
disp(' ');

for i=1:num  
    
    try
        FS1=strtrim(Ref_PSD{i});
        ref_psd=evalin('base',FS1);  
    catch
        out1=sprintf('Ref PSD array not found: %s',Ref_PSD{i});
        warndlg(out1);
        return; 
    end
    
    try
        FS2=strtrim(New_SPL{i});
        new_spl=evalin('base',FS2);  
    catch
        out1=sprintf('New SPL array not found: %s',New_SPL{i});
        warndlg(out1);
        return; 
    end   

%%
    
    sz=size(ref_psd);
    nf_ref_psd=sz(1);

    sz=size(new_spl);
    nf_new_spl=sz(1);
    
    if(nf_ref_spl~=nf_ref_psd)
        warndlg('nf_ref_spl~=nf_ref_psd');
        return;
    end
    
    if(nf_new_spl~=nf_ref_spl)
        warndlg('nf_new_spl~=nf_ref_spl');
        return;
    end
    
    new_psd=zeros(nf_ref_psd,2);
    
    for j=1:nf_ref_psd
        
        delta_dB=new_spl(j,2)-ref_spl(j,2);
        
        scale=10^(delta_dB/10);
        
        new_psd(j,2)=ref_psd(j,2)*scale;
        
    end

    new_psd(:,1)=ref_psd(:,1);
    
    try
        assignin('base', New_PSD{i}, new_psd);       
    catch
        warndlg('assignin error')
        return;
    end   
   
    out1=sprintf('  %s',New_PSD{i});
    disp(out1);
    
    x_label='Frequency (Hz)';
    y_label='Accel (G^2/Hz)';   
    
    t_string=title2{i};
    ppp=new_psd;
    
    fmin=new_psd(1,1);
    fmax=new_psd(end,1);
    
    n=length(new_psd(:,1));
    
    df=(fmax-fmin)/(n-1);
    
    grms=sqrt(sum(new_psd(:,2))*df);
    
    t_string=sprintf('%s  Overall %7.3g GRMS',t_string,grms);
    
    [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
    
    pname=sprintf('scaled_%s',FS1);
    
    print(h2,pname,'-dmeta','-r300');
    out1=sprintf('  %s.emf',pname');
    disp(out1);
    
    
%% 
    
end



%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function get_table_data(hObject, eventdata, handles)

try
    
    A=char(get(handles.uitable_data,'Data'));

    N=get(handles.listbox_num,'Value');


    k=1;

    for i=1:N
        t_string{i}=A(k,:); k=k+1;
        t_string{i} = strtrim(t_string{i});
    end

    for i=1:N
        Ref_PSD{i}=A(k,:); k=k+1;
        Ref_PSD{i} = strtrim(Ref_PSD{i});
    end

    for i=1:N
        New_SPL{i}=A(k,:); k=k+1;
        New_SPL{i} = strtrim(New_SPL{i});
    end

    for i=1:N
        New_PSD{i}=A(k,:); k=k+1;
        New_PSD{i} = strtrim(New_PSD{i});
    end    
    
    setappdata(0,'t_string',t_string);
    setappdata(0,'Ref_PSD',Ref_PSD);
    setappdata(0,'New_SPL',New_SPL);
    setappdata(0,'New_PSD',New_PSD);    
    
catch
    warndlg('get table failed');
    return;
end




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(Barrett_method_multiple_SV);


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


num=get(handles.listbox_num,'Value');
Barrett_multiple_SV.num=num;

try
    data=get(handles.uitable_data,'Data');
    Barrett_multiple_SV.data=data;    
catch
end


try
    ref_spl=get(handles.edit_ref_spl,'String');
    Barrett_multiple_SV.ref_spl=ref_spl;    
catch
end




% % %
 
structnames = fieldnames(Barrett_multiple_SV, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'Barrett_multiple_SV'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%

% Construct a questdlg with four options
choice = questdlg('Save Complete.  Reset Workspace?', ...
    'Options', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
%%        disp([choice ' Reseting'])
%%        pushbutton_reset_Callback(hObject, eventdata, handles)
        appdata = get(0,'ApplicationData');
        fnsx = fieldnames(appdata);
        for ii = 1:numel(fnsx)
            rmappdata(0,fnsx{ii});
        end
end  





% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
    Barrett_multiple_SV=evalin('base','Barrett_multiple_SV');
catch
    warndlg(' evalin failed ');
    return;
end
 
Barrett_multiple_SV

try
    data=Barrett_multiple_SV.data;    
    set(handles.uitable_data,'Data',data);
catch
end

try
    num=Barrett_multiple_SV.num;    
    set(handles.listbox_num,'Value',num);
catch
end

try
    ref_spl=Barrett_multiple_SV.data;        
    set(handles.edit_ref_spl,'String',ref_spl);
catch
end




% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num

Ncolumns=4;

Nrows=get(handles.listbox_num,'Value');
 
A=get(handles.uitable_data,'Data');

for i=1:Nrows
    data_s{i,1}='';
    data_s{i,2}='choose';
    data_s{i,3}='choose';        
    data_s{i,4}='';
end


if(~isempty(A))
    
    sz=size(A);
    Arows=sz(1);    
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end

sz=size(data_s);

if(sz(1)>Nrows)
    data_s=data_s{1:Nrows,:};
end

set(handles.uitable_data,'Data',data_s);


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



function edit_ref_spl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_spl as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_spl as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_spl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_load_data.
function pushbutton_load_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%  [filename, pathname] = uigetfile('*.mat');
%  NAME = [pathname,filename];

NAME='saturn_v_spl.mat';

struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
msgbox('Load complete');


% --- Executes when selected cell(s) is changed in uitable_data.
function uitable_data_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

%% disp('uitable_data_CellSelectionCallback');


% --------------------------------------------------------------------
function uitable_data_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% disp('uitable_data_ButtonDownFcn');






% --- Executes when entered data in editable cell(s) in uitable_data.
function uitable_data_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

%% disp('uitable_data_CellEditCallback');


Nrows=get(handles.listbox_num,'Value');
 
A=get(handles.uitable_data,'Data');

str0=getappdata(0,'str0');

title=getappdata(0,'title');


if(~isempty(A))
    
    sz=size(A);
    nrows=sz(1);    
    
    for i=1:nrows
        
        k = strfind(A{i,2},'choose');
       
        if(isempty(k))
            try
                n = find(contains(str0,A{i,2} ));
                A{i,1}=title{n};
                
                ss=sprintf('scaled_%s',A{i,2});
                A{i,4}=ss;
            catch
            end
        end
    end
    
end

set(handles.uitable_data,'Data',A);


% --- Executes on button press in pushbutton_load_all_ref_PSD.
function pushbutton_load_all_ref_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_all_ref_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str0=getappdata(0,'str0');
  
Nrows=length(str0);  
  
Ncolumns=4;

set(handles.listbox_num,'Value',Nrows);
 
A=get(handles.uitable_data,'Data');

for i=1:Nrows
    data_s{i,1}='';
    data_s{i,2}=str0{i};
    data_s{i,3}='choose';        
    data_s{i,4}='';
end

out1=sprintf('ref 1   %s  %s',str0{1},data_s{i,2});
disp(out1);


set(handles.uitable_data,'Data',data_s); 


uitable_data_CellEditCallback(hObject, eventdata, handles);
