function varargout = FDS_envelope_multiple_sensors(varargin)
% FDS_ENVELOPE_MULTIPLE_SENSORS MATLAB code for FDS_envelope_multiple_sensors.fig
%      FDS_ENVELOPE_MULTIPLE_SENSORS, by itself, creates a new FDS_ENVELOPE_MULTIPLE_SENSORS or raises the existing
%      singleton*.
%
%      H = FDS_ENVELOPE_MULTIPLE_SENSORS returns the handle to a new FDS_ENVELOPE_MULTIPLE_SENSORS or the handle to
%      the existing singleton*.
%
%      FDS_ENVELOPE_MULTIPLE_SENSORS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FDS_ENVELOPE_MULTIPLE_SENSORS.M with the given input arguments.
%
%      FDS_ENVELOPE_MULTIPLE_SENSORS('Property','Value',...) creates a new FDS_ENVELOPE_MULTIPLE_SENSORS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FDS_envelope_multiple_sensors_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FDS_envelope_multiple_sensors_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FDS_envelope_multiple_sensors

% Last Modified by GUIDE v2.5 01-Aug-2019 16:08:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FDS_envelope_multiple_sensors_OpeningFcn, ...
                   'gui_OutputFcn',  @FDS_envelope_multiple_sensors_OutputFcn, ...
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


% --- Executes just before FDS_envelope_multiple_sensors is made visible.
function FDS_envelope_multiple_sensors_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FDS_envelope_multiple_sensors (see VARARGIN)

% Choose default command line output for FDS_envelope_multiple_sensors
handles.output = hObject;



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


listbox_num_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FDS_envelope_multiple_sensors wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FDS_envelope_multiple_sensors_OutputFcn(hObject, eventdata, handles) 
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%% evalin('base', 'close all')
setappdata(0,'fig_num',1);


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' * * * * * * * ');
disp(' ');

fig_num=1;


ntype=get(handles.listbox_type,'Value');

if(ntype==1)
    sx='_max';
end
if(ntype==2)
    sx='_p9550';
end
if(ntype==3)
    sx='_p9550_log';
end
if(ntype==4)
    sx='';
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    N=get(handles.listbox_num,'Value');    
    
    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        out1=sprintf('%s',array_name{i});
        disp(out1);
    end
    for i=1:N
        aaa=A(k,:); k=k+1;
        
        if(isempty(aaa))
            aaa=array_name{i};
        end
        
        aaa( isspace(aaa) ) = [];
        aaa=strrep(aaa,'-',' ');
        aaa=strrep(aaa,'_',' ');
        
        if(i==1)
            output_prefix=aaa;
        else
            aaa=strrep(aaa,'A','');
            aaa=strrep(aaa,'M','');
            aaa=strrep(aaa,'C','');            
            output_prefix=sprintf('%s_%s',output_prefix,aaa);
        end
        
    end    



output_prefix = output_prefix(~isspace(output_prefix));
    
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
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Output Arrays');
disp(' ');


for i=1:nQ
   
    sQ=sprintf('%g',Q(i));
    sQ=strrep(sQ,'.','p');
               
    for j=1:nb
        
        sb=sprintf('%g',bex(j));
        sb=strrep(sb,'.','p');         
        
        clear THM;
        
        for k=1:N
           
                    
            try
                FS=sprintf('%s_Q%s_b%s%s',array_name{k},sQ,sb,sx);
                FS=strtrim(FS);
                aq=evalin('base',FS);
            catch
               
                try
                    ssx=strrep(sx,'p','');
                    FS=sprintf('%s_Q%s_b%s%s',array_name{k},sQ,sb,ssx);
                    FS=strtrim(FS);
                    aq=evalin('base',FS);                   
                catch 
                    FS
                    warndlg('Ref 1:  Input array not found ');
                    return;
                end    
            end
            

    
            if(k==1)
                fn=aq(:,1);
                n_ref=length(fn);
                THM=zeros(n_ref,N);
            end
    
            if(length(aq(:,1))~=n_ref)
                warndlg('Array length error');
                return;
            end
    
            try
                THM(:,k)=aq(:,2);
            catch
                warndlg('FDS array error');
                return;         
            end
                        
        end

        

        num=n_ref;

        maxa=zeros(num,1); 

        for ijk=1:num
            maxa(ijk)=max(THM(ijk,:));
        end    
  
        
        output_prefix='FDS';
        


        name1=sprintf('%s_Q%s_b%s_%s_max',output_prefix,sQ,sb,sx); 
        name1=strrep(name1,'__','_');
        
        
        out1=sprintf(' %s',name1);
        disp(out1);
        
        aavv=[fn maxa];
  
        
        try
            assignin('base',name1,aavv);
        catch
            warndlg('assignin fail');
        end
        

       

        fn=fix_size(fn);
        
        ppp=[fn  maxa   THM ];
       

        leg{1}='Maximum';
        
        for iv=1:N
            str=sprintf('%s',array_name{iv});
            str=strrep(str,'_',' ');
            str=strrep(str,'th bessel 10Hz fds','');
            leg{iv+1}=str;
        end

        ssx=strrep(sx,'p','P');
        ssx=strrep(ssx,'55','5/5');
        ssx=strrep(ssx,'_',' ');
        
        if(isempty(ssx))
            t_string=sprintf('FDS  Q=%g b=%g',Q(i),bex(j));            
        else    
            t_string=sprintf('FDS  Q=%g b=%g  Max of %s',Q(i),bex(j),ssx);
        end
        
        y_label=sprintf('Damage log10(G^%g)',bex(j));
        x_label='Natural Frequency (Hz)';
  
        fmin=fn(1);
        fmax=fn(end);
        
        [fig_num]=plot_loglog_multiple_function_none_fds(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);        
          

    end
    
end
    
disp(' ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(FDS_envelope_multiple_sensors)



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


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num


cn={'FDS Base Name','Sensor'};

%%%%
 
Nrows=get(handles.listbox_num,'Value');
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


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    nQ=get(handles.listbox_Q,'Value'); 
    FDSenv.nQ=nQ;      
catch
end

try
    nb=get(handles.listbox_b,'Value');
    FDSenv.nb=nb;      
catch
end

try
    N=get(handles.listbox_num,'Value');  
    FDSenv.N=N;      
catch
end


try
    ntype=get(handles.listbox_type,'Value');  
    FDSenv.ntype=ntype;      
catch
end



try
    Q=get(handles.uitable_Q,'data');     
    FDSenv.Q=Q;      
catch
end

try
    bex=get(handles.uitable_b,'data');    
    FDSenv.bex=bex;      
catch
end

try
    data=get(handles.uitable_data,'Data');    
    FDSenv.data=data;      
catch
end

% % %
 
structnames = fieldnames(FDSenv, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'FDSenv'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');


% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
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

   FDSenv=evalin('base','FDSenv');

catch
   warndlg(' evalin failed ');
   return;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    nQ=FDSenv.nQ;   
    Set(handles.listbox_Q,'Value',nQ); 
catch
end

try
    nb=FDSenv.nb;     
    set(handles.listbox_b,'Value',nb);
catch
end

try
    N=FDSenv.N;     
    set(handles.listbox_num,'Value',N);       
catch
end

listbox_num_Callback(hObject, eventdata, handles);
listbox_Q_Callback(hObject, eventdata, handles);
listbox_b_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%%%%

try
    Q=FDSenv.Q;    
    set(handles.uitable_Q,'data',Q);           
catch
end

try
    bex=FDSenv.bex;     
    set(handles.uitable_b,'data',bex);         
catch
end

try
    data=FDSenv.data;    
    set(handles.uitable_data,'Data',data);          
catch
end


try
    ntype=FDSenv.ntype;       
    set(handles.listbox_type,'Value',ntype);     
catch
end





% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 
Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s);


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


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


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
data_s=get(handles.uitable_data,'Data');

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
 
set(handles.listbox_num,'Value',Nrows);



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
