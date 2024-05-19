function varargout = FDS_envelope_Qb(varargin)
% FDS_ENVELOPE_QB MATLAB code for FDS_envelope_Qb.fig
%      FDS_ENVELOPE_QB, by itself, creates a new FDS_ENVELOPE_QB or raises the existing
%      singleton*.
%
%      H = FDS_ENVELOPE_QB returns the handle to a new FDS_ENVELOPE_QB or the handle to
%      the existing singleton*.
%
%      FDS_ENVELOPE_QB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FDS_ENVELOPE_QB.M with the given input arguments.
%
%      FDS_ENVELOPE_QB('Property','Value',...) creates a new FDS_ENVELOPE_QB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FDS_envelope_Qb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FDS_envelope_Qb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FDS_envelope_Qb

% Last Modified by GUIDE v2.5 19-Jul-2019 15:49:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FDS_envelope_Qb_OpeningFcn, ...
                   'gui_OutputFcn',  @FDS_envelope_Qb_OutputFcn, ...
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


% --- Executes just before FDS_envelope_Qb is made visible.
function FDS_envelope_Qb_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FDS_envelope_Qb (see VARARGIN)

% Choose default command line output for FDS_envelope_Qb
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

% UIWAIT makes FDS_envelope_Qb wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FDS_envelope_Qb_OutputFcn(hObject, eventdata, handles) 
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

fig_num=1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    N=get(handles.listbox_num,'Value');    
    
    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
    end
    
    sensor=array_name;

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
                FS=sprintf('%s_Q%s_b%s',array_name{k},sQ,sb);
                aq=evalin('base',FS);
            catch
                FS
                warndlg('Input array not found ');
                return;                 
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

        
        sz=size(THM);
        num=n_ref;

        maxa=zeros(num,1); 

        for ijk=1:num
            maxa(ijk)=max(THM(ijk,:));
        end    
  
        
        
        [p9550,p9550_lognormal]=p9550_function(THM);
  
        outname=get(handles.edit_outname,'String');
        
        if(isempty(outname))
            warndlg('Enter output name prefix');
            return;
        end
                      
        name1=sprintf('%s_Q%s_b%s_max',outname,sQ,sb);
        name2=sprintf('%s_Q%s_b%s_p9550',outname,sQ,sb);          
        name3=sprintf('%s_Q%s_b%s_p9550_log',outname,sQ,sb);            
           
        assignin('base',name1,[fn maxa]);
        assignin('base',name2,[fn p9550]);
        assignin('base',name3,[fn p9550_lognormal]);           
              
        out1=sprintf('%s',name1);
        out2=sprintf('%s',name2);
        out3=sprintf('%s',name3);           
        disp(out1);
        disp(out2);
        disp(out3);
        disp(' ');
          
        fn=fix_size(fn);
        
        ppp=[fn p9550_lognormal p9550  maxa   THM ];
        
        leg{1}='P95/50 log';
        leg{2}='P95/50';
        leg{3}='Maximum';
        
        for iv=1:N
            str=sensor{iv};
            str=strrep(str,'_',' ');
            str=strrep(str,'fds','');
            str=strrep(str,'10Hz','');
            str=strrep(str,'bessel','');
            str=strrep(str,'th','');
            leg{iv+3}=str;
        end

        t_string=sprintf('FDS Q=%g b=%g  %s',Q(i),bex(j),outname);
        t_string=strrep(t_string,'_',' ');
                
        y_label=sprintf('Damage log10(G^%g)',bex(j));
        x_label='Natural Frequency (Hz)';
  
        fmin=fn(1);
        fmax=fn(end);

        [fig_num]=plot_loglog_multiple_function_none_fds(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);
        
    end
    
end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(FDS_envelope_Qb)



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


cn={'FDS Base Name'};

%%%%
 
Nrows=get(handles.listbox_num,'Value');
Ncolumns=1;
 
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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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



function edit_outname_Callback(hObject, eventdata, handles)
% hObject    handle to edit_outname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_outname as text
%        str2double(get(hObject,'String')) returns contents of edit_outname as a double


% --- Executes during object creation, after setting all properties.
function edit_outname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_outname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
