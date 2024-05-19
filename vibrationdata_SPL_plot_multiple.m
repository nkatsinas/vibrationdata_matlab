function varargout = vibrationdata_SPL_plot_multiple(varargin)
% VIBRATIONDATA_SPL_PLOT_MULTIPLE MATLAB code for vibrationdata_SPL_plot_multiple.fig
%      VIBRATIONDATA_SPL_PLOT_MULTIPLE, by itself, creates a new VIBRATIONDATA_SPL_PLOT_MULTIPLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SPL_PLOT_MULTIPLE returns the handle to a new VIBRATIONDATA_SPL_PLOT_MULTIPLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SPL_PLOT_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SPL_PLOT_MULTIPLE.M with the given input arguments.
%
%      VIBRATIONDATA_SPL_PLOT_MULTIPLE('Property','Value',...) creates a new VIBRATIONDATA_SPL_PLOT_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_SPL_plot_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_SPL_plot_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_SPL_plot_multiple

% Last Modified by GUIDE v2.5 28-Oct-2019 16:53:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_SPL_plot_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_SPL_plot_multiple_OutputFcn, ...
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


% --- Executes just before vibrationdata_SPL_plot_multiple is made visible.
function vibrationdata_SPL_plot_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_SPL_plot_multiple (see VARARGIN)

% Choose default command line output for vibrationdata_SPL_plot_multiple
handles.output = hObject;

setappdata(0,'pflag',0);

listbox_xplotlimits_Callback(hObject, eventdata, handles);

listbox_num_Callback(hObject, eventdata, handles);


%%


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_SPL_plot_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_SPL_plot_multiple_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_SPL_plot_multiple);


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



fig_num=1;



n_type=get(handles.listbox_ntype,'Value');

tstring=get(handles.edit_title,'String');

%%%%
   

try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    N=get(handles.listbox_num,'Value');

    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
    end 
    for i=1:N
        leg{i}=A(k,:); k=k+1;
        leg{i} = strtrim(leg{i});
    end 

catch
    warndlg('Input Arrays read failed');
    return;
end

setappdata(0,'array_name',array_name);

%

num=N;

if(num>=1)
    try        
        FS1=array_name{1};
        THM1=evalin('base',FS1);
    catch
        warndlg('Array 1 does not exist','Warning');
        return;
    end
end    

if(num>=2)
    try        
        FS2=array_name{2};
        THM2=evalin('base',FS2);
    catch
        warndlg('Array 2 does not exist','Warning');
        return;
    end
end  
if(num>=3)
    try        
        FS3=array_name{3};
        THM3=evalin('base',FS3);
    catch
        warndlg('Array 3 does not exist','Warning');
        return;
    end
end  

if(num>=4)
    try        
        FS4=array_name{4};
        THM4=evalin('base',FS4);
    catch
        warndlg('Array 4 does not exist','Warning');
        return;
    end
end  

%

n=get(handles.listbox_aux,'Value');

%%%

 f1=THM1(:,1);
dB1=THM1(:,2);
leg1=leg{1};

if(N>=2)
     f2=THM2(:,1);
    dB2=THM2(:,2);
    leg2=leg{2};
end
if(N>=3)
     f3=THM3(:,1);
    dB3=THM3(:,2);
    leg3=leg{3};
end
if(N>=4)
     f4=THM4(:,1);
    dB4=THM4(:,2);
    leg4=leg{4};
end

%%%

nx_limits=get(handles.listbox_xplotlimits,'Value');

if(nx_limits==1)

     fmin=THM1(1,1);
     fmax=THM1(end,1);
    
else
    
     xs1=get(handles.edit_xmin,'String');
     if isempty(xs1)
        warndlg('Enter xmin','Warning');
        return;
     else
        fmin=str2num(xs1);
     end
     
     xs2=get(handles.edit_xmax,'String');
     if isempty(xs2)
        warndlg('Enter xmax','Warning');
        return;
     else
        fmax=str2num(xs2);
     end
end

%%%

stype=n;

if(N==1)
    warndlg('Case to be added in next revision');
    return;
end
if(N==2)
    [fig_num,hp]=spl_plot_two_title_alt(fig_num,n_type,f1,dB1,f2,dB2,leg1,leg2,tstring,stype);
end
if(N==3)
    [fig_num,hp]=spl_plot_three_title_alt(fig_num,n_type,f1,dB1,f2,dB2,f3,dB3,leg1,leg2,leg3,tstring,stype);
end
if(N==4)
    [fig_num,hp]=spl_plot_four_title_alt(fig_num,n_type,f1,dB1,f2,dB2,f3,dB3,f4,dB4,leg1,leg2,leg3,leg4,tstring,stype);
end

if(nx_limits==2 ) % manual 
    
    xlim([fmin,fmax]);
    
    try
        [xtt,xTT,iflag]=xtick_label(fmin,fmax);
            
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end
        
    catch    
    end
  
end

setappdata(0,'pflag',1);

pname='a.emf';
print(hp,pname,'-dmeta','-r300');        
      

pushbutton_save_Callback(hObject, eventdata, handles);


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
   name=get(handles.edit_save_name,'String');     
   PlotMultiSPL.name=strtrim(name);     
catch
end

try
    N=get(handles.listbox_num,'Value');
    PlotMultiSPL.N=N;  
catch
end

try
    title=get(handles.edit_title,'String'); 
    PlotMultiSPL.title=title;      
catch
end

try
    ntype=get(handles.listbox_ntype,'Value'); 
    PlotMultiSPL.ntype=ntype;      
catch
end

try
    A=get(handles.uitable_data,'Data');
    PlotMultiSPL.A=A;      
catch
end


try
    
    num=get(handles.listbox_num,'Value');
    
    array_name=getappdata(0,'array_name');
    
    if(num>=1)
        THM1=evalin('base',array_name{1});
        PlotMultiSPL.THM1=THM1;
        PlotMultiSPL.FS1=array_name{1};
    end
    if(num>=2)
        THM2=evalin('base',array_name{2});
        PlotMultiSPL.THM2=THM2;
        PlotMultiSPL.FS2=array_name{2};        
    end
    if(num>=3)
        THM3=evalin('base',array_name{3});
        PlotMultiSPL.THM3=THM3;
        PlotMultiSPL.FS3=array_name{3};           
    end  
    if(num>=4)
        THM4=evalin('base',array_name{4});
        PlotMultiSPL.THM4=THM4;
        PlotMultiSPL.FS4=array_name{4};           
    end   
    if(num>=5)
        THM5=evalin('base',array_name{5});
        PlotMultiSPL.THM5=THM5;
        PlotMultiSPL.FS5=array_name{5};           
    end     
    if(num>=6)
        THM6=evalin('base',array_name{6});
        PlotMultiSPL.THM6=THM6;
        PlotMultiSPL.FS6=array_name{6};           
    end  
    if(num>=7)
        THM7=evalin('base',array_name{7});
        PlotMultiSPL.THM7=THM7;
        PlotMultiSPL.FS7=array_name{7};           
    end        
catch
    warndlg('Save error');
    return;
end 





% % %
 
structnames = fieldnames(PlotMultiSPL, '-full'); % fields in the struct
  
% % %
 
%   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
%    elk=sprintf('%s%s',writepname,writefname);

    
try
   name=get(handles.edit_save_name,'String');
   name=strrep(name,' ','');
   set(handles.edit_save_name,'String',name);
   PlotMultiSPL.name=name;  
catch
   warndlg('Enter plot output name');
   return;
end

if(isempty(name))
   warndlg('Enter plot output name');
   return;    
end

    name=strtrim(name);
    name=strrep(name,'.mat','');
    name=strrep(name,'_plot','');
    name2=sprintf('%s_plot',name);
    name=sprintf('%s_plot.mat',name);
    

%%%

   iflag=0;
    
    try
        fid = fopen(name,'r');
        iflag=1;
        
        if(fid>0)
            out1=sprintf('%s   already exists.  Replace? ',name);
            choice = questdlg(out1,'Options','Yes','No','No');
        
% Handle response
 
            switch choice
                case 'Yes'                        
                    iflag=0; 
            end 
        end
        
    catch
    end
    
    if(fid==-1)
        iflag=0;
    end

    
%%%
    
    if(iflag==0)
        try
            save(name, 'PlotMultiSPL'); 
        catch
            warndlg('Save error');
            return;
        end
    end


%%%
    
    
    
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
%%%@@@@@

    disp('**ref b1**');  
    
    try
        filename = 'vibrationdata_SPL_plot_multiple_load_list.txt';
        THM=importdata(filename);
        sz=size(THM);
        nrows=sz(1);
        
        out1=sprintf('nrows=%d',nrows);
        disp(out1);
                
 %        THM
        

    catch
         THM=[];
         disp('no read 1');       
    end
    
    try
        fileID = fopen('backup_vibrationdata_SPL_plot_multiple_load_list.txt','w');
        for row = 1:nrows
            fprintf(fileID,'%s\n',char(THM{row,:}));
            char(THM{row,:})
        end
        fclose(fileID);
        
     
        fileID = fopen('backup2_vibrationdata_SPL_plot_multiple_load_list.txt','w');
        for row = 1:nrows
            fprintf(fileID,'%s\n',THM{row,:});
            char(THM{row,:})
        end
        fclose(fileID);       
    catch
        disp(' backup failed');
    end
    
%    disp('**ref b2**');
    
   [THM,nrows]=THM_save(THM,name2);
    
%    NTHM
   
%     disp('**ref cx**');
        

    sz=size(THM);
    nrows=sz(1);
    
    fileID = fopen(filename,'w');

    for row = 1:nrows
        fprintf(fileID,'%s\n',char(THM{row,:}));
        char(THM{row,:})
    end
    fclose(fileID);
    
    
%%%@@@@@
    

    if(iflag==0)
        out1=sprintf(' Save Complete: %s \n Plot file saved as: a.emf ',name); 
    else
        out1=sprintf(' Plot file saved as: a.emf ');        
    end   


msgbox(out1);

%%%%%%%%%%%%%%%%%%%%




% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat');

setappdata(0,'filename',filename);
setappdata(0,'pathname',pathname);
 
load_core(hObject, eventdata, handles)


function load_core(hObject, eventdata, handles)

disp('*** ref 1 ***');

setappdata(0,'pflag',0);

filename=strtrim(getappdata(0,'filename'))
% pathname=getappdata(0,'pathname')

try
%    NAME = [pathname,filename];
    NAME=filename;
    struct=load(NAME);
catch    
    NAME
    warndlg('load failed');
    return;
end

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
    PlotMultiSPL=evalin('base','PlotMultiSPL');
catch
    warndlg(' evalin failed ');
    return;
end
 
PlotMultiSPL

%%%%

try
    title=PlotMultiSPL.title;      
    set(handles.edit_title,'String',title); 
catch
end

try
    ntype=PlotMultiSPL.ntype;       
    set(handles.listbox_ntype,'Value',ntype);    
catch
end

try
    A=PlotMultiSPL.A;     
    set(handles.uitable_data,'Data',A);     
catch
end

try
    N=PlotMultiSPL.N;  
    set(handles.listbox_num,'Value',N);
catch
end

try
   name=PlotMultiSPL.name;     
   name=strrep(name,' ','');
   set(handles.edit_save_name,'String',name);      
catch
end

listbox_num_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(PlotMultiSPL.FS1);
 
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
            THM1=PlotMultiSPL.THM1;
            assignin('base',FS1,THM1); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS2=strtrim(PlotMultiSPL.FS2);
 
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
            THM2=PlotMultiSPL.THM2;
            assignin('base',FS2,THM2); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    FS3=strtrim(PlotMultiSPL.FS3);
 
    iflag=0;
    
    try
        temp=evalin('base',FS3);
        ss=sprintf('Replace %s with Previously Saved Array',FS3);
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
            THM3=PlotMultiSPL.THM3;
            assignin('base',FS3,THM3); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS4=strtrim(PlotMultiSPL.FS4);
 
    iflag=0;
    
    try
        temp=evalin('base',FS4);
        ss=sprintf('Replace %s with Previously Saved Array',FS4);
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
            THM4=PlotMultiSPL.THM4;
            assignin('base',FS4,THM4); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS5=strtrim(PlotMultiSPL.FS5);
 
    iflag=0;
    
    try
        temp=evalin('base',FS5);
        ss=sprintf('Replace %s with Previously Saved Array',FS5);
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
            THM5=PlotMultiSPL.THM5;
            assignin('base',FS5,THM5); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS6=strtrim(PlotMultiSPL.FS6);
 
    iflag=0;
    
    try
        temp=evalin('base',FS6);
        ss=sprintf('Replace %s with Previously Saved Array',FS6);
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
            THM6=PlotMultiSPL.THM6;
            assignin('base',FS6,THM6); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS7=strtrim(PlotMultiSPL.FS7);
 
    iflag=0;
    
    try
        temp=evalin('base',FS7);
        ss=sprintf('Replace %s with Previously Saved Array',FS7);
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
            THM7=PlotMultiSPL.THM7;
            assignin('base',FS7,THM7); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%



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


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num


Nrows=get(handles.listbox_num,'Value');

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


% --- Executes on button press in pushbutton_load_model_list.
function pushbutton_load_model_list_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vibrationdata_SPL_plot_multiple_load;


uiwait()

uiresume(vibrationdata_SPL_plot_multiple_load)

delete(vibrationdata_SPL_plot_multiple_load);
    
Lflag=getappdata(0,'Lflag');


if(Lflag==0)
    
    load_core(hObject, eventdata, handles);

    delete(vibrationdata_SPL_plot_multiple_load);

else
    delete(vibrationdata_SPL_plot_multiple_load);    
end


function edit_save_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_name as text
%        str2double(get(hObject,'String')) returns contents of edit_save_name as a double


% --- Executes during object creation, after setting all properties.
function edit_save_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_name (see GCBO)
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


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pushbutton_save_Callback(hObject, eventdata, handles);
