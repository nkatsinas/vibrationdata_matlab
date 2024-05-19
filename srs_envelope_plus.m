function varargout = srs_envelope_plus(varargin)
% SRS_ENVELOPE_PLUS MATLAB code for srs_envelope_plus.fig
%      SRS_ENVELOPE_PLUS, by itself, creates a new SRS_ENVELOPE_PLUS or raises the existing
%      singleton*.
%
%      H = SRS_ENVELOPE_PLUS returns the handle to a new SRS_ENVELOPE_PLUS or the handle to
%      the existing singleton*.
%
%      SRS_ENVELOPE_PLUS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRS_ENVELOPE_PLUS.M with the given input arguments.
%
%      SRS_ENVELOPE_PLUS('Property','Value',...) creates a new SRS_ENVELOPE_PLUS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before srs_envelope_plus_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to srs_envelope_plus_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help srs_envelope_plus

% Last Modified by GUIDE v2.5 30-May-2019 12:20:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @srs_envelope_plus_OpeningFcn, ...
                   'gui_OutputFcn',  @srs_envelope_plus_OutputFcn, ...
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


% --- Executes just before srs_envelope_plus is made visible.
function srs_envelope_plus_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to srs_envelope_plus (see VARARGIN)

% Choose default command line output for srs_envelope_plus
handles.output = hObject;

listbox_amplitude_limits_Callback(hObject, eventdata, handles);

set(handles.pushbutton_save,'Enable','off');

listbox_type_Callback(hObject, eventdata, handles);
listbox_num_Callback(hObject, eventdata, handles);

%%

try
    load SRStemp.mat
    
    save_array=SRStemp.save_array;
    leg=SRStemp.leg;
    
    sz=size(save_array);
    n=sz(2);
    
    set(handles.listbox_num,'Value',n);
    listbox_num_Callback(hObject, eventdata, handles);    
    
    for i=1:n
       data{i,1}=save_array{i};
       data{i,2}=leg{i};
    end    
    
    data
    
    set(handles.uitable_data,'Data',data);
    

    
catch
end

%%

    
try    
    set(handles.listbox_type,'Value',2); 
    listbox_type_Callback(hObject, eventdata, handles);
catch
end

%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes srs_envelope_plus wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = srs_envelope_plus_OutputFcn(hObject, eventdata, handles) 
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

delete(srs_envelope_plus);




function simplified_envelope(hObject, eventdata, handles)
%

fig_num=getappdata(0,'fig_num');

num_amp=getappdata(0,'num_amp');   


nb=get(handles.listbox_basis,'Value');
%
if(nb==1)
    THF=getappdata(0,'maxa');
end
if(nb==2)
    THF=getappdata(0,'p9550');
end
if(nb==3)
    THF=getappdata(0,'p9550_lognormal');
end

iform=get(handles.listbox_format,'Value');

if(iform==1)
    num=3;
end
if(iform==2)
    num=4;
end
if(iform==3)
    num=5;
end
if(iform==4)
    num=5;
end
if(iform==5)
    num=6;
end
if(iform==6)
    num=7;
end
if(iform==7)
    num=3;
end
if(iform==8)
    num=4;
end
if(iform==9)
    num=5;
end
if(iform==10)
    num=5;
end
if(iform==11)
    num=6;
end
if(iform==12)
    num=6;
end


dB=str2num(get(handles.edit_margin,'String'));

mscale=10^(dB/20);

THF=sortrows(THF,1);

ntrials=str2num(get(handles.edit_ntrials,'String'));


ioct=6;

fr=THF(:,1);
 r=THF(:,2);

[f,srs_in]=SRS_specification_interpolation_nw(fr,r,ioct);


omegan=2*pi*f;

nf=length(f);


[spec]=srs_envelope_engine(ntrials,nf,f,srs_in,ioct,omegan,num,mscale,iform);


fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));


x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';
t_string='Shock Response Spectrum Q=10';

ppp1=spec;
ppp2=THF;

leg1='Simplified Envelope';

nb=get(handles.listbox_basis,'Value');

if(nb==1)
    leg2='Maximum';
end
if(nb==2)
    leg2='P95/50';
end
if(nb==3)
    leg2='P95/50 Lognormal';
end

    
md=5;

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

if(num_amp==2)
        ylim([ymin,ymax]);
        [ytt,yTT,iflag]=ytick_label(ymin,ymax);
        if(iflag==1)
            set(gca,'ytick',ytt);
            set(gca,'YTickLabel',yTT);
            ylim([min(ytt),max(ytt)]);
        end    
end    
            
           
           
spec           
           
setappdata(0,'new_spec',spec);

set(handles.uipanel_save,'Visible','on');

out1=sprintf('\n mscale = %6.3g \n',mscale);
disp(out1);

disp(' ');
disp('Calculation complete');
disp(' ');



% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

%%% change(hObject, eventdata, handles);
set(handles.pushbutton_save,'Enable','off');

n=get(handles.listbox_type,'Value');


if(n==1)
    set(handles.text_basis,'Visible','off');
    set(handles.listbox_basis,'Visible','off');    
    set(handles.text_format,'Visible','off');
    set(handles.listbox_format,'Visible','off');     
    set(handles.text_margin,'Visible','off');
    set(handles.edit_margin,'Visible','off');
    set(handles.text_ntrials,'Visible','off');
    set(handles.edit_ntrials,'Visible','off');    
else
    set(handles.text_basis,'Visible','on');
    set(handles.listbox_basis,'Visible','on');   
    set(handles.text_format,'Visible','on');
    set(handles.listbox_format,'Visible','on'); 
    set(handles.text_margin,'Visible','on');
    set(handles.edit_margin,'Visible','on');
    set(handles.text_ntrials,'Visible','on');
    set(handles.edit_ntrials,'Visible','on');     
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.listbox_save,'String',' ')

string_th{1}=sprintf('Maximum');
string_th{2}=sprintf('P95/50');
string_th{3}=sprintf('P95/50 Lognormal'); 

if(n==2)
    string_th{4}=sprintf('Simplified'); 
    string_th{5}=sprintf('Simplified +3 dB');     
end

set(handles.listbox_save,'String',string_th);
set(handles.listbox_save,'Value',1);


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

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'maxa');
end
if(n==2)
    data=getappdata(0,'p9550');
end
if(n==3)
    data=getappdata(0,'p9550_lognormal');
end
if(n==4)
    data=getappdata(0,'new_spec');
end
if(n==5)
    data=getappdata(0,'new_spec');
    data(:,2)=data(:,2)*sqrt(2);
    

    for i=1:length(data(:,1))

        if(data(i,2)<10)
            data(i,2)=round(data(i,2),1);
        else
            data(i,2)=ceil(data(i,2));    
        end
    
    end    
    
end

output_array_name=strtrim(get(handles.edit_output_array_name2,'String'));
assignin('base',output_array_name,data);

msgbox('Save Complete');



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
 
cn={'SRS Array Name','Legend'};

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


% --- Executes on button press in pushbutton_save_file.
function pushbutton_save_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%

try
    basis=get(handles.listbox_basis,'Value');
    SRSenvP.basis=basis;
catch
end

try
    format=get(handles.listbox_format,'Value');
    SRSenvP.format=format;
catch
end

try
    fmin=get(handles.edit_fmin,'String');
    SRSenvP.fmin=fmin;
catch
end

try
    fmax=get(handles.edit_fmax,'String');
    SRSenvP.fmax=fmax;
catch
end

try
    ntrials=get(handles.edit_ntrials,'String');
    SRSenvP.ntrials=ntrials;
catch
end

try
    margin=get(handles.edit_margin,'String');
    SRSenvP.margin=margin;
catch
end

try
    num_amp=get(handles.listbox_amplitude_limits,'Value');
    SRSenvP.num_amp=num_amp;
catch
end

%%%%%%%%%%%%%

try
    save2=get(handles.listbox_save,'Value');
    SRSenvP.save=save2;
catch
end


try
    name2=get(handles.edit_output_array_name2,'String');
    SRSenvP.name2=name2;
catch
end


try 
    num=get(handles.listbox_num,'Value');
    SRSenvP.num=num;
catch
end  

try
    type=get(handles.listbox_type,'Value');
    SRSenvP.type=type;
catch
end

try
    title=get(handles.edit_title,'String');
    SRSenvP.title=title;    
catch
end



try
    get_table_data(hObject, eventdata, handles);

    THM=getappdata(0,'THM');
    SRSenvP.THM=THM;   
    
catch
end

try
    data=get(handles.uitable_data,'Data'); 
    SRSenvP.data=data;      
catch
end


try
    array_name=getappdata(0,'array_name'); 
    SRSenvP.array_name=array_name;      
catch
end

try
    save_name=get(handles.edit_save_name,'String');
    SRSenvP.save_name=save_name;          
catch
end
    
try
    array_name=getappdata(0,'array_name');
    
    if(num>=1)
        THM1=evalin('base',array_name{1});
        SRSenvP.THM1=THM1;
        SRSenvP.FS1=array_name{1};
    end
    if(num>=2)
        THM2=evalin('base',array_name{2});
        SRSenvP.THM2=THM2;
        SRSenvP.FS2=array_name{2};        
    end
    if(num>=3)
        THM3=evalin('base',array_name{3});
        SRSenvP.THM3=THM3;
        SRSenvP.FS3=array_name{3};           
    end  
    if(num>=4)
        THM4=evalin('base',array_name{4});
        SRSenvP.THM4=THM4;
        SRSenvP.FS4=array_name{4};
    end
    if(num>=5)
        THM5=evalin('base',array_name{5});
        SRSenvP.THM5=THM5;
        SRSenvP.FS5=array_name{5};        
    end
    if(num>=6)
        THM6=evalin('base',array_name{6});
        SRSenvP.THM6=THM6;
        SRSenvP.FS6=array_name{6};           
    end  
    if(num>=7)
        THM7=evalin('base',array_name{7});
        SRSenvP.THM7=THM7;
        SRSenvP.FS7=array_name{7};           
    end 
    if(num>=8)
        THM8=evalin('base',array_name{8});
        SRSenvP.THM8=THM8;
        SRSenvP.FS8=array_name{8};           
    end       
    if(num>=9)
        THM9=evalin('base',array_name{9});
        SRSenvP.THM9=THM9;
        SRSenvP.FS9=array_name{9};           
    end       
    if(num>=10)
        THM10=evalin('base',array_name{10});
        SRSenvP.THM10=THM10;
        SRSenvP.FS10=array_name{10};           
    end       
    if(num>=11)
        THM11=evalin('base',array_name{11});
        SRSenvP.THM11=THM11;
        SRSenvP.FS11=array_name{11};           
    end      
    if(num>=12)
        THM12=evalin('base',array_name{12});
        SRSenvP.THM12=THM12;
        SRSenvP.FS12=array_name{12};           
    end       

catch
    warndlg('Save error');
    return;
end 



% % %
 
structnames = fieldnames(SRSenvP, '-full'); % fields in the struct
  
% % %
 
%%   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
%%    elk=sprintf('%s%s',writepname,writefname);

    
%%    try
 
%%        save(elk, 'SRSenvP'); 
 
%%    catch
%%       warndlg('Save error');
%%       return;
%%   end
 
%%% SSS=load(elk)
 

try
   name=get(handles.edit_save_name,'String');
   SRSenvP.name=name;   
catch
   warndlg('Enter model output name');
   return;
end

if(isempty(name))
   warndlg('Enter model output name');
   return;    
end

    name=strrep(name,'.mat','');
    name=strrep(name,'_model','');    
    name=sprintf('%s_model.mat',name);


    try
        save(name, 'SRSenvP'); 
    catch
        warndlg('Save error');
        return;
    end
 
try    
    out1=sprintf('Save Complete: %s',name);
    msgbox(out1);
catch
    warndlg('name failed');
end
 
     



% --- Executes on button press in pushbutton_load_plot.
function pushbutton_load_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

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

   SRSenvP=evalin('base','SRSenvP');

catch
   warndlg(' SRSenvP evalin failed ');
   return;
end

%%%%%%%%%%%%

try
    num_amp=SRSenvP.num_amp;    
    set(handles.listbox_amplitude_limits,'Value',num_amp);
catch
end


try
    save_name=SRSenvP.save_name;        
    set(handles.edit_save_name,'String',save_name);
catch
end


try
    basis=SRSenvP.basis;    
    set(handles.listbox_basis,'Value',basis);
catch
end

try
    format=SRSenvP.format;    
    set(handles.listbox_format,'Value',format);
catch
end

try
    fmin=SRSenvP.fmin;    
    set(handles.edit_fmin,'String',fmin);
catch
end

try
    fmax=SRSenvP.fmax;    
    set(handles.edit_fmax,'String',fmax);
catch
end

try
    ntrials=SRSenvP.ntrials;    
    set(handles.edit_ntrials,'String',ntrials);
catch
end

try
    margin=SRSenvP.margin;    
    set(handles.edit_margin,'String',margin);
catch
end


listbox_type_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%
%%%%%%%%%%%%

try
    save=SRSenvP.save;
    set(handles.listbox_save,'Value',save);
catch
end

try
    name2=SRSenvP.name2;    
    set(handles.edit_output_array_name2,'String',name2);
catch
end


try 
    num=SRSenvP.num;
    set(handles.listbox_num,'Value',num);
    listbox_num_Callback(hObject, eventdata, handles);
catch
end    
   
try
    type=SRSenvP.type;    
    set(handles.listbox_type,'Value',type);
    change(hObject, eventdata, handles);
catch
end
    
%%%

try
    title=SRSenvP.title; 
    set(handles.edit_title,'String',title);
catch
end
    
%%%
%%%
 
try
    data=SRSenvP.data;  
    set(handles.uitable_data,'Data',data);
catch
end

try
    array_name=SRSenvP.array_name;  
catch
end

for i=1:num    
    load_aux(SRSenvP,i);
end

listbox_type_Callback(hObject, eventdata, handles);


catch
    warndlg('Load Failed');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function[]=load_aux(SRSenvP,i)


eval(sprintf('FS=strtrim(SRSenvP.FS%d);',i));


try
%    FS=strtrim(SRSenvP.FS);
    eval(sprintf('FS=strtrim(SRSenvP.FS%d);',i));
 
    iflag=0;
    
    try
        temp=evalin('base',FS);
        ss=sprintf('Replace %s with Previously Saved Array',FS);
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
            THM=SRSenvP.THM;
            eval(sprintf('THM=SRSenvP.THM%d;',i));           
            assignin('base',FS,THM);             
        catch
        end
    end
    
catch    
end


function get_table_data(hObject, eventdata, handles)

clear THM;

jflag=0;

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));



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
    jflag=1;
    setappdata(0,'jflag',jflag);
    warndlg('Input Arrays read failed');
    return;
end


num=get(handles.listbox_num,'Value');

try
    
%%%%

    n_ref=0;

    for i=1:num

        try
            FS=array_name{i};
            aq=evalin('base',FS);  
        catch
            jflag=1;
            setappdata(0,'jflag',jflag);
%            warndlg('Input array not found ');
%            return; 
        end
        
        sz=size(aq);
        
        if(sz(1)>n_ref)
            n_ref=sz(1);
            fn=aq(:,1);
        end
        
    end
catch
    jflag=1;
    setappdata(0,'jflag',jflag);
    out1=sprintf(' evalin failed %s ',FS);
    warndlg(out1);
    return;   
end

try
  
%%%%

    for i=1:num

        try
            FS=array_name{i};
            aq=evalin('base',FS);  
        catch
            jflag=1;
            setappdata(0,'jflag',jflag);
            warndlg('Input array not found ');
            return; 
        end
  
        try
        
            [~,i1]=min(abs(aq(:,1)-fmin));
            [~,i2]=min(abs(aq(:,1)-fmax));
        
%            out1=sprintf('i=%d  i1=%d  i2=%d  fmin=%g  fmax=%g  %g  %g',i,i1,i2,fmin,fmax,aq(i1,1),aq(i2,1));
%            disp(out1);
        
        catch
            jflag=1;
            setappdata(0,'jflag',jflag);
            warndlg('i1, i2, aq failed');
            return;               
        end
        
        if(length(aq(:,1))~=n_ref)
%            warndlg('Array length error');
%            return;
        end
        
        if(i==1)
            try
                THM(:,1)=fn(i1:i2);
            catch   
                jflag=1;
                setappdata(0,'jflag',jflag);
                warndlg('fn error');
                return;
            end
        end
        
        try
            THM(:,i+1)=aq(i1:i2,2);
        catch
            jflag=1;
            setappdata(0,'jflag',jflag);
            warndlg('SRS array error');
            return;         
        end
        

        
    end

catch
    jflag=1;
    setappdata(0,'jflag',jflag);
    warndlg('get table failed');
    return;
end





setappdata(0,'num',num);
setappdata(0,'n_ref',n_ref);
setappdata(0,'THM',THM);
setappdata(0,'array_name',array_name); 
setappdata(0,'leg',leg); 
setappdata(0,'jflag',jflag);

% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off');



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


% --- Executes on selection change in listbox_basis.
function listbox_basis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_basis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_basis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_basis


% --- Executes during object creation, after setting all properties.
function listbox_basis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_basis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format


% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ntrials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ntrials as text
%        str2double(get(hObject,'String')) returns contents of edit_ntrials as a double


% --- Executes during object creation, after setting all properties.
function edit_ntrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_margin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_margin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_margin as text
%        str2double(get(hObject,'String')) returns contents of edit_margin as a double


% --- Executes during object creation, after setting all properties.
function edit_margin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_margin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
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


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
 
get_table_data(hObject, eventdata, handles);

jflag=getappdata(0,'jflag');

if(jflag==1)
    return;
end
 




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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton_calculation.

% hObject    handle to pushbutton_calculation (see GCBO)
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


num_amp=get(handles.listbox_amplitude_limits,'value');

ymin=0;
ymax=0;

if(num_amp==2)
   ymin=str2num(get(handles.edit_ymin,'String')); 
   ymax=str2num(get(handles.edit_ymax,'String'));      
end


try
   name=get(handles.edit_save_name,'String');  
catch
   warndlg('Enter model output name');
   return;
end

if(isempty(name))
   warndlg('Enter model output name');
   return;    
end


disp(' ');

fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

get_table_data(hObject, eventdata, handles);

jflag=getappdata(0,'jflag');

if(jflag==1)
    warndlg('jflag==1');
    return;
end

THM=getappdata(0,'THM');
num=getappdata(0,'num');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tt=get(handles.edit_title,'String');

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));


sz=size(THM);

n=sz(1);
m=sz(2);


if(m==0 || n==0)
    out1=sprintf(' m=%d  n=%d  ',m,n);
    disp(out1);
    warndlg('THM error');
    return;
end


maxa=zeros(n,1); 


for i=1:n
    maxa(i)=max(THM(i,2:m));
end    
    
 
size(maxa);
    
maxa=[THM(:,1) maxa];
    
x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';
t_string=tt;
ppp=maxa;

[fig_num]=plot_loglog_function_leg(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,'Maximum');     

if(num_amp==2)
    ylim([ymin,ymax]);
    [ytt,yTT,iflag]=ytick_label(ymin,ymax);
    if(iflag==1)
        set(gca,'ytick',ytt);
        set(gca,'YTickLabel',yTT);
        ylim([min(ytt),max(ytt)]);
    end    
end    

%%%
    
if(m>=3)
    
    try    
        [p9550,p9550_lognormal]=p9550_function(THM(:,2:m));
    catch
        warndlg(' p9550_function failed');
        return; 
    end

    md=15;
 
    ppp1=[THM(:,1) p9550_lognormal];
    ppp2=[THM(:,1) p9550];       
    ppp3=maxa;

    leg1='P95/50 lognormal';
    leg2='P95/50';
    leg3='Maximum';        
        
    [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
    
    if(num_amp==2)
        ylim([ymin,ymax]);
        [ytt,yTT,iflag]=ytick_label(ymin,ymax);
        if(iflag==1)
            set(gca,'ytick',ytt);
            set(gca,'YTickLabel',yTT);
            ylim([min(ytt),max(ytt)]);
        end    
    end         
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ppp=[maxa(:,1)  maxa(:,2)   THM(:,2:m)];

    array_name=getappdata(0,'array_name');
    leg=getappdata(0,'leg');

    pleg{1}='Maximum';

    for i=1:num
        str=array_name{i};
        str=strrep(str,'_',' ');
        leg{i}=strrep(leg{i},'_',' ');
        pleg{i+1}=leg{i};
    end

    [fig_num]=plot_loglog_multiple_function_none(fig_num,x_label,y_label,t_string,ppp,pleg,fmin,fmax);

    if(num_amp==2)
        ylim([ymin,ymax]);
        [ytt,yTT,iflag]=ytick_label(ymin,ymax);
        if(iflag==1)
            set(gca,'ytick',ytt);
            set(gca,'YTickLabel',yTT);
            ylim([min(ytt),max(ytt)]);
        end    
    end    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ppp=[maxa(:,1) p9550_lognormal p9550  maxa(:,2)   THM(:,2:m)];

    array_name=getappdata(0,'array_name');
    leg=getappdata(0,'leg');

    pleg{1}='P95/50 log';
    pleg{2}='P95/50';
    pleg{3}='Maximum';

    for i=1:num
        str=array_name{i};
        str=strrep(str,'_',' ');
        leg{i}=strrep(leg{i},'_',' ');
        pleg{i+3}=leg{i};
    end

    [fig_num]=plot_loglog_multiple_function_none(fig_num,x_label,y_label,t_string,ppp,pleg,fmin,fmax);

    if(num_amp==2)
        ylim([ymin,ymax]);
        [ytt,yTT,iflag]=ytick_label(ymin,ymax);
        if(iflag==1)
            set(gca,'ytick',ytt);
            set(gca,'YTickLabel',yTT);
            ylim([min(ytt),max(ytt)]);
        end    
    end            
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ppp=[maxa(:,1)   THM(:,2:m)];

    array_name=getappdata(0,'array_name');
    leg=getappdata(0,'leg');

    for i=1:num
        str=array_name{i};
        str=strrep(str,'_',' ');
        leg{i}=strrep(leg{i},'_',' ');
        pleg{i}=leg{i};
    end

    [fig_num]=plot_loglog_multiple_function_none(fig_num,x_label,y_label,t_string,ppp,pleg,fmin,fmax);
    
    if(num_amp==2)
        ylim([ymin,ymax]);
        [ytt,yTT,iflag]=ytick_label(ymin,ymax);
        if(iflag==1)
            set(gca,'ytick',ytt);
            set(gca,'YTickLabel',yTT);
            ylim([min(ytt),max(ytt)]);
        end    
    end        
    
    setappdata(0,'p9550',[THM(:,1) p9550]);
    setappdata(0,'p9550_lognormal',[THM(:,1) p9550_lognormal]);    

end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
setappdata(0,'maxa',maxa);
setappdata(0,'fig_num',fig_num);

set(handles.pushbutton_save,'Enable','on');

ntype=get(handles.listbox_type,'Value');

jflag=getappdata(0,'jflag');



if(jflag==1)
    return;
end



if(ntype==1)
    msgbox('Calculation complete');    
else
    setappdata(0,'num_amp',num_amp);  
    setappdata(0,'ymin',ymin);
    setappdata(0,'ymax',ymax);       
    simplified_envelope(hObject, eventdata, handles);
end

pushbutton_save_file_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton_calculation.
function pushbutton_calculation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on selection change in listbox_amplitude_limits.
function listbox_amplitude_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amplitude_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amplitude_limits

n=get(handles.listbox_amplitude_limits,'value');

if(n==1)
   set(handles.text_ymin,'visible','off');
   set(handles.text_ymax,'visible','off'); 
   set(handles.edit_ymin,'visible','off'); 
   set(handles.edit_ymax,'visible','off');    
else
   set(handles.text_ymin,'visible','on');
   set(handles.text_ymax,'visible','on'); 
   set(handles.edit_ymin,'visible','on'); 
   set(handles.edit_ymax,'visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_amplitude_limits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_limits (see GCBO)
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
