function varargout = impulse_hammer_segment_selection_old(varargin)
% IMPULSE_HAMMER_SEGMENT_SELECTION_OLD MATLAB code for impulse_hammer_segment_selection_old.fig
%      IMPULSE_HAMMER_SEGMENT_SELECTION_OLD, by itself, creates a new IMPULSE_HAMMER_SEGMENT_SELECTION_OLD or raises the existing
%      singleton*.
%
%      H = IMPULSE_HAMMER_SEGMENT_SELECTION_OLD returns the handle to a new IMPULSE_HAMMER_SEGMENT_SELECTION_OLD or the handle to
%      the existing singleton*.
%
%      IMPULSE_HAMMER_SEGMENT_SELECTION_OLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPULSE_HAMMER_SEGMENT_SELECTION_OLD.M with the given input arguments.
%
%      IMPULSE_HAMMER_SEGMENT_SELECTION_OLD('Property','Value',...) creates a new IMPULSE_HAMMER_SEGMENT_SELECTION_OLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before impulse_hammer_segment_selection_old_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to impulse_hammer_segment_selection_old_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help impulse_hammer_segment_selection_old

% Last Modified by GUIDE v2.5 01-May-2021 08:59:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @impulse_hammer_segment_selection_old_OpeningFcn, ...
                   'gui_OutputFcn',  @impulse_hammer_segment_selection_old_OutputFcn, ...
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


% --- Executes just before impulse_hammer_segment_selection_old is made visible.
function impulse_hammer_segment_selection_old_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to impulse_hammer_segment_selection_old (see VARARGIN)

% Choose default command line output for impulse_hammer_segment_selection_old
handles.output = hObject;

%qqq set(handles.uipanel_export,'Visible','off');

%qqq set(handles.text_channel,'Visible','off');
%qqq set(handles.listbox_channel,'Visible','off');
%qqq set(handles.pushbutton_modal_test,'Enable','off');


%qqq listbox_segments_Callback(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes impulse_hammer_segment_selection_old wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = impulse_hammer_segment_selection_old_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
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

disp(' ');
disp(' * * * * * * * * * * * ');
disp(' ');
listbox_segments_Callback(hObject, eventdata, handles);

FS=get(handles.edit_input_array,'String');
 
try
    THM=evalin('base',FS);    
catch
    warndlg('Input array read failed');
    return;
end

setappdata(0,'THM',THM);

set(handles.listbox_channel,'String','');

sz=size(THM);

n=sz(2)-2;

for i=1:n
    sss{i}=i;
end

try
    set(handles.listbox_channel,'String',sss);
catch
    warndlg('Input array error');
    return;
end

set(handles.text_channel,'Visible','on');
set(handles.listbox_channel,'Visible','on');

try
    make_plots(hObject, eventdata, handles);
catch
end
    
function make_plots(hObject, eventdata, handles)


cmap(1,:)=[0.8 0 0];        % red
cmap(end+1,:)=[0 0 0];          % black
cmap(end+1,:)=[0.6 0.3 0];      % brown
cmap(end+1,:)=[0 0.5 0.5];      % teal
cmap(end+1,:)=[1 0.5 0];        % orange
cmap(end+1,:)=[0.5 0.5 0];      % olive
cmap(end+1,:)=[0.13 0.55 0.13]; % forest green  
cmap(end+1,:)=[0.5 0 0];        % maroon
cmap(end+1,:)=[0.5 0.5 0.5 ];  % grey
cmap(end+1,:)=[1. 0.4 0.4];    % pink-orange
cmap(end+1,:)=[0.5 0.5 1];     % lavender
cmap(end+1,:)=[0.05 0.7 1.];   % light blue
cmap(end+1,:)=[0  0.8 0.4 ];   % green
cmap(end+1,:)=[1 0.84 0];      % gold
cmap(end+1,:)=[0 0.8 0.8];     % turquoise   
cmap(end+1,:)=[0 0 0.8];        % dark blue


%%% msgbox('Select start and end limits using cursor, one point at a time.  Press space bar after each entry');
%%% waitforbuttonpress;

data=get(handles.uitable_data,'Data');

nsegments=get(handles.listbox_segments,'Value');
n=get(handles.listbox_channel,'Value');

ts=zeros(nsegments,1);
te=zeros(nsegments,1);

THM=getappdata(0,'THM');

yf=THM(:,2);
yLimitsf=max(abs(yf*1.1));
[yhf]=yaxis_limits_linear(yLimitsf,yf);


ty=[-1000 1000];
nvk=0;

while(1)
    
    nvk=nvk+1;
    
    if(nvk>nsegments)
        break;
    end     
    
    
    h=figure(1);
    ax1=subplot(2,1,1);


    plot(THM(:,1),THM(:,2),'Color','b');
    ylim([-yhf,yhf]);
    zoom on;
    ZoomHandle = zoom(h);
    set(ZoomHandle,'Motion','horizontal'); 

    if(nvk>=2)
            hold on;
            for iq=1:nvk-1
                tx=[ts(iq) ts(iq)];
                plot(tx,ty,'--','Color',cmap(iq,:));
                tx=[te(iq) te(iq)];
                plot(tx,ty,'--','Color',cmap(iq,:)); 
            end
            hold off;
    end
    ylim([-yhf,yhf]);

    title('Use Zoom to select segment time limits.  Press spacebar to continue');
    grid on;
    ylabel('Force');
    ylim([-yhf,yhf]);
  

    ax2=subplot(2,1,2);    
    plot(THM(:,1),THM(:,n+2),'Color','b');
    y=abs(THM(:,n+2));
    yLimits=max(y*1.1);
    [yh]=yaxis_limits_linear(yLimits,y);
    ylim([-yh,yh]);      
    
    if(nvk>=2)
            hold on;
            for iq=1:nvk-1
                tx=[ts(iq) ts(iq)];
                plot(tx,ty,'--','Color',cmap(iq,:));
                tx=[te(iq) te(iq)];
                plot(tx,ty,'--','Color',cmap(iq,:)); 
            end
            hold off;
    end    
    
    grid on;
    xlabel('Time (sec)');
    ylabel('Accel');      
    zoom on;
    ZoomHandle = zoom(h);
%%    set(ZoomHandle,'Motion','horizontal');        
              
    linkaxes([ax1, ax2], 'x')        
    
    set(h, 'Position', [0 0 1200 500]);    

    
%%%%%%%
    
    iflag=4;
    
    
    k=0;
    while ~k
        try
            k=waitforbuttonpress;
        catch
            break;
        end
        try
            if ~strcmp(get(h,'currentcharacter'),' ')
                k=0;
            end
        catch
        end
    end
    
    xl = xlim;
    
    ts(nvk)=xl(1);
    te(nvk)=xl(2);
    
    jkflag=1;
    
    try
        answer = questdlg('Choice:','Check Segment','Accept','Redo','Exit','Accept');
 
        switch answer
            case 'Accept'
                iflag=0;
                jkflag=0;
            case 'Redo'
                iflag=1;
                jkflag=0;
            case 'Exit'
                iflag=1;
                
        end    
    catch 
    end 
    
    if(jkflag==1)
        break;
    end
    
    if(iflag==0)
        for i=1:nvk
            data{i,1}=sprintf('%9.5g',ts(i));
            data{i,2}=sprintf('%9.5g',te(i));
        end 
    end  
    if(iflag==1)
        nvk=nvk-1;
    end    
    if(iflag==2)
        break;
    end
    
    set(handles.uitable_data,'Data',data);
        
end    

if(jkflag==1)
    return;
end

try

    h=figure(100);
    subplot(2,1,1);

    plot(THM(:,1),THM(:,2));

    hold on
    for ijk=1:length(ts)
        tx=[ts(ijk) ts(ijk)];
        plot(tx,ty,'--','Color',cmap(ijk,:));
        tx=[te(ijk) te(ijk)];
        plot(tx,ty,'--','Color',cmap(ijk,:));        
    end    
    hold off

    grid on;
    ylabel('Force');
    y=THM(:,2);
    yLimits=max(y);
    [yh]=yaxis_limits_linear(yLimits,y);
    ylim([-yh,yh]);

%%%%%%%

    subplot(2,1,2);
    plot(THM(:,1),THM(:,n+2));
    hold on
    for ijk=1:length(ts)
        tx=[ts(ijk) ts(ijk)];
        plot(tx,ty,'--','Color',cmap(ijk,:));
        tx=[te(ijk) te(ijk)];
        plot(tx,ty,'--','Color',cmap(ijk,:)); 
    end    
    hold off
    grid on;
    xlabel('Time (sec)');
    ylabel('Accel');
    y=abs(THM(:,n+2));
    yLimits=max(y);
    [yh]=yaxis_limits_linear(yLimits,y);
    ylim([-yh,yh]);

    set(h, 'Position', [0 0 1000 500]);
catch
    warndlg(' end plot failed');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.pushbutton_modal_test,'Enable','on'); 
pushbutton_save_Callback(hObject, eventdata, handles);


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h=getappdata(0,'h');

CP = get(h, 'CurrentPoint');
x  = CP(1)
y  = CP(2)


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(impulse_hammer_segment_selection);



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_modal_test,'Enable','on'); 

try
    num=get(handles.listbox_segments,'Value'); 
    ImpulseHammer.num=num;  
    setappdata(0,'num',num);
catch
    warndlg('error: listbox_segments');
end


try
    data=get(handles.uitable_data,'Data'); 
    setappdata(0,'data_times',data);
catch
    warndlg('data failed');
end

try
    A=char(data);
catch
    warndlg('char failed');
end

try
    k=1;

    try
  
        for i=1:num
            tss{i}=A(k,:); k=k+1;
            tss{i} = strtrim(tss{i});
             ts(i)=str2double(tss{i});
        end 
    
        for i=1:num
            tee{i}=A(k,:); k=k+1;
            tee{i} = strtrim(tee{i});
             te(i)=str2double(tee{i});        
        end     
    
    catch
            warndlg('error:  tss tee ');
    end
    
    nnn=num;  
    
    for i=num:-1:1
        fprintf('%d  %g %g  \n',i,ts(i),te(i));
        if(isempty(te(i))==1 || isempty(ts(i))==1 || isnan(te(i))==1 || isnan(ts(i))==1)
            ts(i)=[];
            te(i)=[];
            nnn=nnn-1;
            ImpulseHammer.num=nnn; 
        end    
    end
    
    clear data;

    num=nnn;
    
    try
  
        for i=1:num
            data{i,1}=sprintf('%9.5g',ts(i));
            data{i,2}=sprintf('%9.5g',te(i));            
        end 
    
        ImpulseHammer.data=data;      
    catch
    end
end

try
    array=get(handles.edit_input_array,'String'); 
    ImpulseHammer.array=array;      
catch
        warndlg('error: ImpulseHammer.array');
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%


% % %
 
structnames = fieldnames(ImpulseHammer, '-full'); % fields in the struct
  
% % %

try
   name_out=get(handles.edit_output_array,'String');  
catch
   warndlg('Enter output name');
   return;
end

if(isempty(name_out))
   warndlg('Enter output name');
   return;    
end
   

name_out=strrep(name_out,'.mat','');    
name_out=sprintf('%s.mat',name_out);

try
        save(name_out, 'ImpulseHammer'); 
catch
        disp(name_out); 
        warndlg('Save error');
        return;
end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%

out1=sprintf('Export Complete: %s',name_out);
disp(' ');
disp(out1);

msgbox(out1);






% --- Executes on button press in pushbutton_modal_test.
function pushbutton_modal_test_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_modal_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    name=get(handles.edit_input_array,'String');
    setappdata(0,'name',name);
catch
end

try
    num=get(handles.listbox_segments,'Value'); 
    setappdata(0,'num',num);
catch
end


try
    data=get(handles.uitable_data,'Data'); 
    setappdata(0,'data_times',data);
catch
    warndlg('data failed');
end



handles.s=impulse_hammer_modal_test;

set(handles.s,'Visible','on'); 

delete(impulse_hammer_segment_selection);


% --- Executes on selection change in listbox_channel.
function listbox_channel_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_channel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_channel

make_plots(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_segments.
function listbox_segments_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_segments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_segments contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_segments


cn={'Start Time','End Time'};

Nrows=get(handles.listbox_segments,'Value');

Ncolumns=2;
 
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
 
set(handles.uitable_data,'Data',data_s,'ColumnName',cn);



%%%%%%%%





% --- Executes during object creation, after setting all properties.
function listbox_segments_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_segments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_segments,'Value');
 
Ncolumns=2;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s);

listbox_segments_Callback(hObject, eventdata, handles);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDA

% sss='impulse_hammer_segment_selection_instructions.txt';

% system(['open -a TextEdit ' fullfile(pwd,sss)])


winopen('impulse_hammer_segment_selection_instructions.pdf')


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Nrows=get(handles.listbox_segments,'Value');
 
Ncolumns=2;
 
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
            data_s{i,j}='';
            try
                data_s{i,j}=A{i,j};
            catch
            end
            
        end    
    end   
 
end
 
nd=get(handles.listbox_delete_array,'Value');
 
if(nd<=Nrows)
    
    temp=data_s;
    clear data_s;
    
    
    
    for i=1:(nd-1)
        for j=1:Ncolumns
            try
                data_s{i,j}=temp{i,j};
            catch
            end
            
        end    
    end  
    
    for i=(nd+1):Nrows
        for j=1:Ncolumns
            try
                data_s{i-1,j}=temp{i,j};
            catch
            end
            
        end    
    end      
    
    Nrows=Nrows-1;
    set(handles.listbox_segments,'Value',Nrows);    
end
 
set(handles.uitable_data,'Data',data_s);
 
pushbutton_save_Callback(hObject, eventdata, handles);




% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton_save_Callback(hObject, eventdata, handles);
