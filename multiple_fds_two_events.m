function varargout = multiple_fds_two_events(varargin)
% MULTIPLE_FDS_TWO_EVENTS MATLAB code for multiple_fds_two_events.fig
%      MULTIPLE_FDS_TWO_EVENTS, by itself, creates a new MULTIPLE_FDS_TWO_EVENTS or raises the existing
%      singleton*.
%
%      H = MULTIPLE_FDS_TWO_EVENTS returns the handle to a new MULTIPLE_FDS_TWO_EVENTS or the handle to
%      the existing singleton*.
%
%      MULTIPLE_FDS_TWO_EVENTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIPLE_FDS_TWO_EVENTS.M with the given input arguments.
%
%      MULTIPLE_FDS_TWO_EVENTS('Property','Value',...) creates a new MULTIPLE_FDS_TWO_EVENTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multiple_fds_two_events_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multiple_fds_two_events_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multiple_fds_two_events

% Last Modified by GUIDE v2.5 09-Oct-2019 14:26:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multiple_fds_two_events_OpeningFcn, ...
                   'gui_OutputFcn',  @multiple_fds_two_events_OutputFcn, ...
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


% --- Executes just before multiple_fds_two_events is made visible.
function multiple_fds_two_events_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multiple_fds_two_events (see VARARGIN)

% Choose default command line output for multiple_fds_two_events
handles.output = hObject;

pushbutton_reset_Callback(hObject, eventdata, handles);

set(handles.listbox_oct,'Value',2);



Nrows=2;
Ncolumns=1;

set(handles.listbox_Q,'Value',Nrows);

cn={'Q'};
ssq{1,1}='10';
ssq{2,1}='30';

set(handles.uitable_Q,'Data',cell(Nrows,Ncolumns),'ColumnName',cn);
set(handles.uitable_Q,'Data',ssq,'ColumnName',cn);


set(handles.listbox_b,'Value',Nrows);

cn={'b'};
ssb{1,1}='4';
ssb{2,1}='8';

set(handles.uitable_b,'Data',cell(Nrows,Ncolumns),'ColumnName',cn);
set(handles.uitable_b,'Data',ssb,'ColumnName',cn);




% Update handles structure
guidata(hObject, handles);

% UIWAIT makes multiple_fds_two_events wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = multiple_fds_two_events_OutputFcn(hObject, eventdata, handles) 
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

delete(multiple_fds_two_events);

% --- Executes on button press in pushbutton_calculation.
function pushbutton_calculation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' * * * * * ');
disp(' ');


%%% evalin('base', 'close all')
setappdata(0,'fig_num',1);


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');

fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save_name=strtrim(get(handles.edit_save_name,'String'));

if(isempty(save_name))cn={'FDS Base Name','Sensor'};
    warndlg('Enter Model Save Name');
    return;
end


fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

get_table_data(hObject, eventdata, handles);

na=get(handles.listbox_num,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

array_name=getappdata(0,'array_name');
leg=getappdata(0,'leg');


Q=getappdata(0,'Q');
bex=getappdata(0,'bex');

start_time=getappdata(0,'start_time');
end_time=getappdata(0,'end_time');  

ioct=1+get(handles.listbox_oct,'Value');

[fn,~]=octaves(ioct);

[~,i1]=min(abs(fn-fmin));
[~,i2]=min(abs(fn-fmax));

fn=fn(i1:i2);
nf=length(fn);

nQ=length(Q);
nbex=length(bex);

nc=nQ*nbex;

disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kx=1;

for ij=1:nQ
    for ik=1:nbex
        suffix{kx}=sprintf('fds_Q%g_b%g',Q(ij),bex(ik));
        kx=kx+1;
    end
end

nk=1;

for i=1:na  % array

    disp(' '); 
    fds_th=zeros(length(fn),nc);
    qqq=zeros(nc,1);

%%%%

    FS=array_name{i};
    
    kv=1;
    
    for ij=1:nQ
    
        for ik=1:nbex
            name{i,kv}=sprintf('%s_fds_Q%g_b%g',FS,Q(ij),bex(ik));
            name{i,kv} = strrep(name{i,kv},'.','_');
            
            try
                THM=evalin('base',name{i,kv});
                
                try
                    fds_th(:,kv)=THM(:,2);
                catch
                    fds_th=zeros(length(fn),nc);
                end    
                
                qqq(kv)=1;
                
                if(length(fn)~=length(THM(:,1)))
                    qqq(kv)=0;
                end
                
            catch
                qqq(kv)=0;
            end  

            
            if(qqq(kv)==1)
                
                out1=sprintf('%s   already exists.  Replace? ',name{i,kv});
                choice = questdlg(out1,'Options','Yes','No','No');
% Handle response
                switch choice
                    case 'Yes'                        
                        qqq(kv)=0; 
                end         
            end
            
            nomen{nk}=name{i,kv};
            nk=nk+1;
            kv=kv+1;            
        end   
    end

%%%%

    
    if(min(qqq)==0)
    
        try
            FS=array_name{i};
            THM=evalin('base',FS);
            disp(FS);
        
            amp=double(THM(:,2));
            tim=double(THM(:,1));
            t=tim;
            n = length(amp);
        
            duration=tim(n)-tim(1);
            dt=duration/(n-1);
            difft=diff(t);
            dtmin=min(difft);
            dtmax=max(difft);
%
            out4 = sprintf('\n dtmin  = %8.4g sec  ',dtmin);
            out5 = sprintf(' dt     = %8.4g sec  ',dt);
            out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
        
            disp(out4);
            disp(out5);
            disp(out6);
        
            out7=sprintf('\n n=%d ',n);
            disp(out7);
        
            if(n<1000)
                disp(' Warning: number of points ');
            end
        catch
            warndlg('input array not found');
            return;
        end    
        
         fds_th=zeros(nf,nc);
%        fds_th1=zeros(nf,nc);
%        fds_th2=zeros(nf,nc);
%        fds_th3=zeros(nf,nc);         
%        fds_th4=zeros(nf,nc);
        
        [~, i1] = min(abs(t-start_time(i,1)));    
        [~, i2] = min(abs(t-end_time(i,1)));
        [~, i3] = min(abs(t-start_time(i,2)));    
        [~, i4] = min(abs(t-end_time(i,2)));                
        
        
        disp(' segment 1');
        yy1=amp(i1:i2);
        
        if(max(abs(yy1))<1.0e-20)
            warndlg('Array has zero amplitude');
            return;
        end
        
        [fds_th1]=fds_engine(fds_th,yy1,nf,nQ,Q,nbex,bex,fn,dt);
        clear yy1;
    
        disp(' segment 2');
        yy2=amp(i3:i4);
        [fds_th2]=fds_engine(fds_th,yy2,nf,nQ,Q,nbex,bex,fn,dt);
        clear yy2;
 
    
    end
      
%%%

    disp(' export arrays ');
    disp(' ');
     
    kv=1;
    
    if(min(qqq)==0)
        
        for ij=1:nQ
            for ik=1:nbex
                
                nnn=sprintf('%s_ev21',name{i,kv});
                data=[fn fds_th1(:,kv)];
                assignin('base',nnn,data);
                
                nnn=sprintf('%s_ev22',name{i,kv});                
                data=[fn fds_th2(:,kv)];
                assignin('base',nnn,data);                
                          
                
                kv=kv+1;
            end  
        end

    end
    
    for kv=1:nc
        out1=sprintf('  %s_ev21 ',name{i,kv});
        disp(out1);
        out1=sprintf('  %s_ev22 ',name{i,kv});
        disp(out1);    
    end    
    
    disp(' ');
    
%    AL=leg{i};
%    [fig_num]=multiple_fds_plot(fig_num,Q,bex,fn,fds_th,AL,nc);
    
end

try
    setappdata(0,'name',nomen);
catch
    warndlg('nomen failed');
    return;
end

setappdata(0,'suffix',suffix);

envelopes(hObject, eventdata, handles);

pushbutton_save_file_Callback(hObject, eventdata, handles);




%
function envelopes(hObject, eventdata, handles) 
%
save_name=strtrim(get(handles.edit_save_name,'String'));
sname=strrep(save_name,'.mat','');
sname=strrep(sname,'_model','');    
%

suffix=getappdata(0,'suffix');
sz=size(suffix);
m=max(sz);
%
name=getappdata(0,'name');
sz=size(name);
n=max(sz);

name_org=name;


try
    [flight_names,~,~,~,~]=NS_flight_names();
catch
    warndlg('flight_names failed');
    return;
end

sz=size(flight_names);
nflights=max(sz);


for i=1:n

   a=name{i};
   
   for j=1:nflights
        ssx=strtrim(flight_names{j});
         ax=sprintf('%s_',ssx); 
         a=strrep(a,ax,'');
   end
  
   name{i}=strtrim(a);
   
   name_uq{i} = extractBefore(a,'_th');

end

name_uq=unique(name_uq);
sz=size(name_uq);
nuq=max(sz);
   

ivk1=1;
ivk2=1;
ivk3=1;

disp(' ');
disp(' envelope names ');

% group in terms of Q & b & ev   % fix here

ev{1}='ev21';
ev{2}='ev22';

for jnk=1:2

for ijk=1:nuq
    
    disp(' ');
        
    for j=1:m
    
        clear THM;
        kv=1;
    
        for i=1:n
                
            name{i}=strtrim(name{i});
            suffix{j}=strtrim(suffix{j});
                
            if(contains(name{i},suffix{j}) && contains(name{i},name_uq{ijk}) )
              
                NNN=name{i};

                try
                    nnn=sprintf('%s_%s',name_org{i},ev{jnk});
                    a=evalin('base',nnn);
                catch
                    disp('a evalin error');
                    warndlg('a evalin error');
                    return;
                end
   
                fn=a(:,1);
                THM(:,kv)=a(:,2);
                kv=kv+1;
            end    
        end
    
        try
            sz=size(THM);
        catch
            disp('THM error');
            warndlg('THM error');
            return;
        end

        try

            nf=length(THM(:,1));
            maxa=zeros(nf,1);
    
            for k=1:nf
                maxa(k)=max(THM(k,:));
            end    
        catch
            disp('maxa failed');
            warndlg('maxa failed');
            return;
        end
        
        p9550=[];
        p9550_lognormal=[];
    
        try
            if(sz(2)>=2)
                try
                    [p9550,p9550_lognormal]=p9550_function(THM);
                catch
                    disp('p9550 failed 1');
                    warndlg('p9550 failed 1');
                    return;
                end
            else
            end
        catch
            disp('p9550 failed 2');
            warndlg('p9550 failed 2');
            return;        
        end
    
        try
            name1=sprintf('%s_max',NNN);
            name1=strrep(name1,' ','_');
            nnn=sprintf('%s_%s',name1,ev{jnk});
            assignin('base',nnn,[fn maxa]);
   
            Nmax{ivk1}=nnn;
            ivk1=ivk1+1;

        catch
            disp('name1 failed');
            warndlg('name1 failed');
            return;
        end
    
        if(~isempty(p9550) && ~isempty(p9550_lognormal)) 
            try
                name2=sprintf('%s_9550',NNN);
                name2=strrep(name2,' ','_');
                nnn=sprintf('%s_%s',name2,ev{jnk});
                assignin('base',nnn,[fn p9550]);
        
                Np9550{ivk2}=nnn;   
                ivk2=ivk2+1;                
                
                name3=sprintf('%s_9550_lognormal',NNN);
                name3=strrep(name3,' ','_');
                nnn=sprintf('%s_%s',name3,ev{jnk});
                assignin('base',nnn,[fn p9550_lognormal]);   
        
                Np9550_lognormal{ivk3}=nnn;                   
                ivk3=ivk3+1;               
                
            catch
            end
        end
        
    end

end

for i=1:length(Nmax)
    out1=sprintf('  %s',Nmax{i});
    disp(out1);
end
disp(' ');


try

    for i=1:length(Np9550)
        out1=sprintf('  %s',Np9550{i});
        disp(out1);
    end
    disp(' ');

    for i=1:length(Np9550_lognormal)
        out1=sprintf('  %s',Np9550_lognormal{i});
        disp(out1);
    end
    disp(' ');

catch
end

end


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_one.
function listbox_one_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_one contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_one


change(hObject, eventdata, handles);


function change(hObject, eventdata, handles)
%


% --- Executes during object creation, after setting all properties.
function listbox_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_one (see GCBO)
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



function edit_xlab_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xlab as text
%        str2double(get(hObject,'String')) returns contents of edit_xlab as a double


% --- Executes during object creation, after setting all properties.
function edit_xlab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylab_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylab as text
%        str2double(get(hObject,'String')) returns contents of edit_ylab as a double


% --- Executes during object creation, after setting all properties.
function edit_ylab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes during object creation, after setting all properties.
function pushbutton_calculation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
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


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name2 as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name2 as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name2 (see GCBO)
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
Ncolumns=6;
 
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


% --- Executes on button press in pushbutton_save_file.
function pushbutton_save_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try 
    save_name=strtrim(get(handles.edit_save_name,'String'));
    FDSMultiple.save_name=save_name;
catch
end 

try 
    fmin=get(handles.edit_fmin,'String');
    FDSMultiple.fmin=fmin;
catch
end 
try 
    fmax=get(handles.edit_fmax,'String');
    FDSMultiple.fmax=fmax;
catch
end  


try 
    num=get(handles.listbox_num,'Value');
    FDSMultiple.num=num;
catch
end  



try 
    num=get(handles.listbox_num,'Value');
    FDSMultiple.num=num;
catch
end  

try 
    nQ=get(handles.listbox_Q,'Value');
    FDSMultiple.nQ=nQ;
catch
end  

try 
    nb=get(handles.listbox_b,'Value');
    FDSMultiple.nb=nb;
catch
end  

%%%

try
    get_table_data(hObject, eventdata, handles);

    THM=getappdata(0,'THM');
    FDSMultiple.THM=THM; 
    
catch
end

try
    data=getappdata(0,'data'); 
    FDSMultiple.data=data;      
catch
end


try
    array_name=getappdata(0,'array_name'); 
    FDSMultiple.array_name=array_name;      
catch
end

try
    Qd=get(handles.uitable_Q,'data');
    FDSMultiple.Qd=Qd;       
catch
end

try
    bd=get(handles.uitable_b,'data');
    FDSMultiple.bd=bd;       
catch
end

% % %
 
save_name=strtrim(get(handles.edit_save_name,'String'));

if(isempty(save_name))
    warndlg('Enter Model Save Name');
    return;
end


name=strrep(save_name,'.mat','');
name=strrep(name,'_model','');    
name=sprintf('%s_model.mat',name);


try 
    save(name, 'FDSMultiple'); 
    out1=sprintf('Calculation complete.  Model saved as:  %s',name);
    msgbox(out1);
catch
    warndlg('Save error 2');
    return;
end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 


% --- Executes on button press in pushbutton_load_plot.
function pushbutton_load_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_plot (see GCBO)
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

   FDSMultiple=evalin('base','FDSMultiple');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%

try 
    save_name=FDSMultiple.save_name;    
    set(handles.edit_save_name,'String',save_name);
catch
end 


try 
    fmin=FDSMultiple.fmin;    
    set(handles.edit_fmin,'String',fmin);
catch
end 
try 
    fmax=FDSMultiple.fmax;    
    set(handles.edit_fmax,'String',fmax);
catch
end 


%%%%%%%%%%%%


try 
    num=FDSMultiple.num;
    set(handles.listbox_num,'Value',num);
    listbox_num_Callback(hObject, eventdata, handles);
catch
end    
   
try
    type=FDSMultiple.type;    
    set(handles.listbox_type,'Value',type);
    change(hObject, eventdata, handles);
catch
end
    
    
%%%
%%%
 
try
    data=FDSMultiple.data;  
    set(handles.uitable_data,'Data',data);
catch
end

try
    array_name=FDSMultiple.array_name;  
catch
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try 
    nQ=FDSMultiple.nQ;    
    set(handles.listbox_Q,'Value',nQ);
catch
end  

try 
    nb=FDSMultiple.nb;    
    set(handles.listbox_b,'Value',nb);
catch
end  


listbox_Q_Callback(hObject, eventdata, handles);
listbox_b_Callback(hObject, eventdata, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    Qd=FDSMultiple.Qd;     
    set(handles.uitable_Q,'data',Qd);      
catch
end
 
try
    bd=FDSMultiple.bd;        
    set(handles.uitable_b,'data',bd);   
catch
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function get_table_data(hObject, eventdata, handles)

try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    N=get(handles.listbox_num,'Value');    
    
    start_time=zeros(N,2);
      end_time=zeros(N,2);
    
    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        
%        try
%            xx=evalin('base',array_name{i});
%        catch
%            warndlg('input array not found');
%            return;
%        end    
    
    end
        
    for i=1:N
        leg{i}=A(k,:); k=k+1;
        leg{i} = strtrim(leg{i});
    end
    
    for i=1:N
        a=A(k,:); k=k+1;
        start_time(i,1) = str2double(strtrim(a));
    end    
    
    for i=1:N
        a=A(k,:); k=k+1;
        end_time(i,1) = str2double(strtrim(a));
    end   
    
    for i=1:N
        a=A(k,:); k=k+1;
        start_time(i,2) = str2double(strtrim(a));
    end    
    
    for i=1:N
        a=A(k,:); k=k+1;
        end_time(i,2) = str2double(strtrim(a));
    end       
     
%%%      
    
    setappdata(0,'leg',leg);
    setappdata(0,'start_time',start_time);
    setappdata(0,'end_time',end_time);     
    setappdata(0,'array_name',array_name);
    
catch
    warndlg('Input Arrays read failed');
    return;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


nQ=get(handles.listbox_Q,'Value');
Q=zeros(nQ,1);

try
    k=1;
   
    C=get(handles.uitable_Q,'data');
    C=char(C);
    
    for i=1:nQ
        Q(i)=str2double(strtrim(C(k,:))); k=k+1;
    end
    
catch
    warndlg('Combinations Step 3 failed');
    return;
end



nb=get(handles.listbox_b,'Value');
bex=zeros(nb,1);

try
    k=1;
    
    C=get(handles.uitable_b,'data');
    C=char(C);
    
    for i=1:nb
        bex(i)=str2double(strtrim(C(k,:))); k=k+1;
    end
    
catch
    warndlg('Combinations Step 4 failed');
    return;
end
    
    
try

 
    setappdata(0,'Q',Q);
    setappdata(0,'bex',bex);
    
catch
    warndlg('Combinations failed');
    return;    
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in listbox_Q.
function listbox_Q_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_Q contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_Q

Nrows=get(handles.listbox_Q,'Value');
Ncolumns=1;
cn={'Q'};

set(handles.uitable_Q,'Data',cell(Nrows,Ncolumns),'ColumnName',cn);




% --- Executes during object creation, after setting all properties.
function listbox_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_oct.
function listbox_oct_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_oct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_oct contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_oct


% --- Executes during object creation, after setting all properties.
function listbox_oct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_oct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% --- Executes on selection change in listbox_b.
function listbox_b_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_b contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_b

Nrows=get(handles.listbox_b,'Value');
Ncolumns=1;
cn={'b'};

set(handles.uitable_b,'Data',cell(Nrows,Ncolumns),'ColumnName',cn);



% --- Executes during object creation, after setting all properties.
function listbox_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_b (see GCBO)
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

cn={'Time History','Legend','Start Time 1','End Time 1','Start Time 2','End Time 2'};

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=6;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s,'ColumnName',cn);


% --- Executes on selection change in listbox_delete.
function listbox_delete_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_delete contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_delete


% --- Executes during object creation, after setting all properties.
function listbox_delete_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=6;
 
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
 
nd=get(handles.listbox_delete,'Value');
 
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
    set(handles.listbox_num,'Value',Nrows);    
end
 
set(handles.uitable_data,'Data',data_s);
 
 



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
