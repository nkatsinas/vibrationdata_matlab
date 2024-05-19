function varargout = maximum_envelope_alt(varargin)
% MAXIMUM_ENVELOPE_ALT MATLAB code for maximum_envelope_alt.fig
%      MAXIMUM_ENVELOPE_ALT, by itself, creates a new MAXIMUM_ENVELOPE_ALT or raises the existing
%      singleton*.
%
%      H = MAXIMUM_ENVELOPE_ALT returns the handle to a new MAXIMUM_ENVELOPE_ALT or the handle to
%      the existing singleton*.
%
%      MAXIMUM_ENVELOPE_ALT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAXIMUM_ENVELOPE_ALT.M with the given input arguments.
%
%      MAXIMUM_ENVELOPE_ALT('Property','Value',...) creates a new MAXIMUM_ENVELOPE_ALT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before maximum_envelope_alt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to maximum_envelope_alt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help maximum_envelope_alt

% Last Modified by GUIDE v2.5 21-Jul-2020 20:16:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maximum_envelope_alt_OpeningFcn, ...
                   'gui_OutputFcn',  @maximum_envelope_alt_OutputFcn, ...
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


% --- Executes just before maximum_envelope_alt is made visible.
function maximum_envelope_alt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to maximum_envelope_alt (see VARARGIN)

% Choose default command line output for maximum_envelope_alt
handles.output = hObject;


set(handles.pushbutton_save,'Enable','off');

listbox_type_Callback(hObject, eventdata, handles);

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes maximum_envelope_alt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = maximum_envelope_alt_OutputFcn(hObject, eventdata, handles) 
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

delete(maximum_envelope_alt);

% --- Executes on button press in pushbutton_calculation.
function pushbutton_calculation_Callback(hObject, eventdata, handles)
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

disp(' ');


fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

get_table_data(hObject, eventdata, handles);

THM=getappdata(0,'THM');
num=getappdata(0,'num');

nlegend=get(handles.listbox_legend,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tt=get(handles.edit_title,'String');
xx=get(handles.edit_xlab,'String');
yy=get(handles.edit_ylab,'String');


ntype=get(handles.listbox_type,'Value');


sz=size(THM);

n=sz(1);
m=sz(2);

fmin=str2double(get(handles.edit_fmin,'String'));
fmax=str2double(get(handles.edit_fmax,'String'));

ff=THM(:,1);
[~,ii]=min(abs(ff-fmin));
[~,jj]=min(abs(ff-fmax));

if(ntype==1)
    if(ff(ii)>fmin && ii>=2)
        
        x1=THM(ii-1,1);
        x2=THM(ii,1);
           
        for i=2:m
           y1=THM(ii-1,i);
           y2=THM(ii,i);
           xn=fmin;
           [yn,~]=log_interpolation_function(x1,y1,x2,y2,xn);
           THM(ii-1,i)=yn;
        end  
        THM(ii-1,1)=fmin;
        
    end
    if(ff(ii)<fmin && ii>=2)
        
        x1=THM(ii,1);
        x2=THM(ii+1,1);        
        
        for i=2:m
           y1=THM(ii,i);
           y2=THM(ii+1,i);
           xn=fmin;
           [yn,~]=log_interpolation_function(x1,y1,x2,y2,xn);
           THM(ii,i)=yn;
        end  
        THM(ii,1)=fmin;
        
    end
%
    if(ff(jj)>fmax && jj>=2)
        
        x1=THM(jj-1,1);
        x2=THM(jj,1);
           
        for i=2:m
           y1=THM(jj-1,i);
           y2=THM(jj,i);
           xn=fmax;
           [yn,~]=log_interpolation_function(x1,y1,x2,y2,xn);
           THM(jj-1,i)=yn;
        end  
        THM(jj-1,1)=fmax;
        
    end
    if(ff(jj)<fmax && jj>=2 && jj<(n-1))
        
        x1=THM(jj,1);
        x2=THM(jj+1,1);
           
        for i=2:m
           y1=THM(jj,i);
           y2=THM(jj+1,i);
           xn=fmax;
           [yn,~]=log_interpolation_function(x1,y1,x2,y2,xn);
           THM(jj,i)=yn;
        end  
        THM(jj,1)=fmax;
        
    end    
%
end


ff=THM(:,1);
[~,ii]=min(abs(ff-fmin));
[~,jj]=min(abs(ff-fmax));

if(ff(ii)<fmin)
    ii=ii+1;
end
if(ff(jj)>fmax)
    jj=jj-1;
end

temp=THM(ii:jj,:);
clear THM;
THM=temp;


sz=size(THM);

n=sz(1);
m=sz(2);

maxa=zeros(n,1);
maxi=zeros(n,1);

    for i=1:n
        a=THM(i,2:m);
        [C,I]=max(a);
        maxa(i)=C;
        maxi(i)=I;
    end
    
    maxa=[THM(:,1) maxa];
    
    [p9550,p9550_lognormal]=p9550_function(THM(:,2:m));
    
    tt=strrep(tt,'_',' ');
    
    x_label=xx;
    y_label=yy;
    t_string=tt;
    ppp=maxa;
    fmin=THM(1,1);
    fmax=THM(n,1);

    if(ntype==2)
        f=maxa(:,1);
        dB=maxa(:,2);
        n_type=1;
        [fig_num]=spl_plot(fig_num,n_type,f,dB);
    end
    if(ntype==1 || ntype==3)    
        [fig_num]=plot_loglog_function_leg(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,'Maximum');       
    
        md=15;
 
        ppp1=[THM(:,1) p9550_lognormal];
        ppp2=[THM(:,1) p9550];       
        ppp3=maxa;

        leg1='P95/50 lognormal';
        leg2='P95/50';
        leg3='Maximum';        
        
        [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md); 
           
    end
    if(ntype==4)    
        [fig_num]=plot_loglog_function_leg_fds(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,'Maximum');       
    
        md=15;
 
        ppp1=[THM(:,1) p9550_lognormal];
        ppp2=[THM(:,1) p9550];       
        ppp3=maxa;

        leg1='P95/50 lognormal';
        leg2='P95/50';
        leg3='Maximum';        
        
        [fig_num,h2]=plot_loglog_function_md_three_fds_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
           
           
    end    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp=[maxa(:,1) p9550_lognormal p9550  maxa(:,2)   THM(:,2:m)];

array_name=getappdata(0,'array_name');
aleg=getappdata(0,'aleg');


leg{1}='P95/50 log';
leg{2}='P95/50';
leg{3}='Maximum';

for i=1:num
    str=aleg{i};
    str=strrep(str,'_',' ');
    leg{i+3}=str;
end

if(ntype==4)
    [fig_num]=plot_loglog_multiple_function_none_fds(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);
else
    nlegend=2;
    [fig_num]=plot_loglog_multiple_function_none_nlegend(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax,nlegend);
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp=[maxa(:,1)  p9550  maxa(:,2)   THM(:,2:m)];

array_name=getappdata(0,'array_name');
aleg=getappdata(0,'aleg');
leg{1}='P95/50';
leg{2}='Maximum';



for i=1:num
    str=aleg{i};
    str=strrep(str,'_',' ');
    leg{i+2}=str;
end

if(ntype==4)
    [fig_num]=plot_loglog_multiple_function_none_fds(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);
else    
    nlegend=2;
    [fig_num]=plot_loglog_multiple_function_none_nlegend3(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax,nlegend);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp=[maxa(:,1) maxa(:,2)   THM(:,2:m)];

array_name=getappdata(0,'array_name');


leg{1}='Maximum';

for i=1:num
    str=aleg{i};
    str=strrep(str,'_',' ');
    leg{i+1}=str;
end

if(ntype==4)
    [fig_num]=plot_loglog_multiple_function_none_fds(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);
else    
    nlegend=2;
    [fig_num]=plot_loglog_multiple_function_none_nlegend2(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax,nlegend);
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp=[maxa(:,1) p9550   THM(:,2:m)];

array_name=getappdata(0,'array_name');
aleg=getappdata(0,'aleg');

leg{1}='P95/50';

for i=1:num
    str=aleg{i};
    str=strrep(str,'_',' ');
    leg{i+1}=str;
end

if(ntype==4)
    [fig_num]=plot_loglog_multiple_function_none_fds(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);
else    
    [fig_num]=plot_loglog_multiple_function_none_nlegend2(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax,nlegend);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'maxa',maxa);
setappdata(0,'p9550',[THM(:,1) p9550]);
setappdata(0,'p9550_lognormal',[THM(:,1) p9550_lognormal]);

set(handles.pushbutton_save,'Enable','on');

disp('Calculation complete');

try
    msgbox('Calculation complete');
catch
end

disp(' ');

for i=1:length(maxi)
    out1=sprintf('%8.4g %s',maxa(i,1),array_name{maxi(i)});
    disp(out1);
end


try
    pushbutton_save_Callback(hObject, eventdata, handles);
catch
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

change(hObject, eventdata, handles);
set(handles.pushbutton_save,'Enable','off');

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


m=get(handles.listbox_type,'Value');


set(handles.text_title,'Visible','off');
set(handles.edit_title,'Visible','off');
set(handles.text_xlab,'Visible','off');
set(handles.edit_xlab,'Visible','off');
set(handles.text_ylab,'Visible','off');
set(handles.edit_ylab,'Visible','off');

    if(m~=2)
        set(handles.text_title,'Visible','on');
        set(handles.edit_title,'Visible','on');
        set(handles.text_xlab,'Visible','on');
        set(handles.edit_xlab,'Visible','on');
        set(handles.text_ylab,'Visible','on');
        set(handles.edit_ylab,'Visible','on');        
    end

%%%%%%%%%%

if(m==1)
    sss='Frequency (Hz)';
end
if(m==2)
    sss='Center Frequency (Hz)';
end
if(m==3)
    sss='Natural Frequency (Hz)';
end
if(m==4)
    sss='Natural Frequency (Hz)';
end

set(handles.edit_xlab,'String',sss);

%%%

set(handles.listbox_save,'String',' ')

if(m==1 || m==3)
    string_th{1}=sprintf('Maximum'); 
    string_th{2}=sprintf('Maximum +3 dB'); 
    string_th{3}=sprintf('P95/50');   
    string_th{4}=sprintf('P95/50 Lognormal');     
else
    string_th{1}=sprintf('Maximum');  
    string_th{2}=sprintf('P95/50');   
    string_th{3}=sprintf('P95/50 Lognormal');    
end

set(handles.listbox_save,'String',string_th);







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

m=get(handles.listbox_type,'Value');

n=get(handles.listbox_save,'Value');

if(m==1 || m==3)  % psd or srs
    if(n==1)
        data=getappdata(0,'maxa');
    end
    if(n==3)
        data=getappdata(0,'p9550');
    end
    if(n==4)
        data=getappdata(0,'p9550_lognormal');
    end
    
    if(n==2)
        data=getappdata(0,'maxa');
    
        if(m==1) % psd
            data(:,2)=data(:,2)*2;
        end
        if(m==3) % srs
            data(:,2)=data(:,2)*sqrt(2);        
        end
    end
    
else
    
    if(n==1)
        data=getappdata(0,'maxa');
    end
    if(n==2)
        data=getappdata(0,'p9550');
    end
    if(n==3)
        data=getappdata(0,'p9550_lognormal');
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

num=get(handles.listbox_type,'Value');

if(num==1)
    sss='PSD';
end
if(num==2)
    sss='SPL';
end
if(num==3)
    sss='SRS';
end
if(num==4)
    sss='FDS';
end

cn={sss,'Legend'};



Ncolumns=2;


%%%%
 
Nrows=get(handles.listbox_num,'Value');
 
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

try
    save2=get(handles.listbox_save,'Value');
    MaxAlt.save=save2;
catch
end


try
    name2=get(handles.edit_output_array_name2,'String');
    MaxAlt.name2=name2;
catch
end


try 
    num=get(handles.listbox_num,'Value');
    MaxAlt.num=num;
catch
end  

try
    type=get(handles.listbox_type,'Value');
    MaxAlt.type=type;
catch
end

try
    title=get(handles.edit_title,'String');
    MaxAlt.title=title;    
catch
end

try
    xlab=get(handles.edit_xlab,'String');
    MaxAlt.xlab=xlab;   
catch
end

try
    ylab=get(handles.edit_ylab,'String');
    MaxAlt.ylab=ylab;   
catch
end

try
    get_table_data(hObject, eventdata, handles);

    THM=getappdata(0,'THM');
    MaxAlt.THM=THM;   
    
catch
end

try
    data=get(handles.uitable_data,'Data'); 
    MaxAlt.data=data;      
catch
end


try
    array_name=getappdata(0,'array_name'); 
    MaxAlt.array_name=array_name;      
catch
end

% % %
 
structnames = fieldnames(MaxAlt, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'MaxAlt'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');

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

   MaxAlt=evalin('base','MaxAlt');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%

try
    save=MaxAlt.save;
    set(handles.listbox_save,'Value',save);
catch
end

try
    name2=MaxAlt.name2;    
    set(handles.edit_output_array_name2,'String',name2);
catch
end


try 
    num=MaxAlt.num;
    set(handles.listbox_num,'Value',num);
    listbox_num_Callback(hObject, eventdata, handles);
catch
end    
   
try
    type=MaxAlt.type;    
    set(handles.listbox_type,'Value',type);
    change(hObject, eventdata, handles);
catch
end
    
%%%

try
    title=MaxAlt.title; 
    set(handles.edit_title,'String',title);
catch
end

try
    xlab=MaxAlt.xlab;      
    set(handles.edit_xlab,'String',xlab);
catch
end

try
    ylab=MaxAlt.ylab;     
    set(handles.edit_ylab,'String',ylab);
catch
end
    
%%%
%%%
 
try
    data=MaxAlt.data;  
    set(handles.uitable_data,'Data',data);
catch
end

try
    array_name=MaxAlt.array_name;  
catch
end

try
    THM=MaxAlt.THM;   
catch
end


try
    
    for i=1:num
    
        try
            temp=evalin('base',array_name{i});
        catch
        end
            
        try 
            assignin('base',array_name{i},[THM(:,1) THM(:,i+1)]); 
        catch
        end      
   
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function get_table_data(hObject, eventdata, handles)

try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    
    N=get(handles.listbox_num,'Value');

    k=1;

    
    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        data_s{i,1}=array_name{i};
    end 
    
    for i=1:N
        aleg{i}=A(k,:); k=k+1;
        aleg{i} = strtrim(aleg{i});
        data_s{i,2}=aleg{i};       
    end 
    
    try
        set(handles.uitable_data,'Data',data_s);
    catch
        warndlg('Put back failed');
    end
    
catch
    warndlg('Input Arrays read failed');
    return;
end

try
    
    num=get(handles.listbox_num,'Value');

    for i=1:num

        try
            FS=array_name{i};
            aq=evalin('base',FS);  
        catch
            warndlg('Input array not found ');
            return; 
        end
        
        if(contains(FS,'FDS') || contains(FS,'fds') )
            set(handles.listbox_type,'Value',4);
            listbox_type_Callback(hObject, eventdata, handles);
        end
    
        if(i==1)
            fn=aq(:,1);
            n_ref=length(fn);
            THM=zeros(n_ref,num+1);
            THM(:,1)=fn;
        end
    
        if(length(aq(:,1))~=n_ref)
            warndlg('Array length error');
            return;
        end
    
        try
            THM(:,i+1)=aq(:,2);
        catch
            warndlg('FDS array error');
            return;         
        end
        
    end

catch
    warndlg('get table failed');
    return;
end

setappdata(0,'num',num);
setappdata(0,'n_ref',n_ref);
setappdata(0,'THM',THM);
setappdata(0,'array_name',array_name); 
setappdata(0,'aleg',aleg);



% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off');


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


num=get(handles.listbox_type,'Value');

if(num==1)
    sss='PSD';
end
if(num==2)
    sss='SPL';
end
if(num==3)
    sss='SRS';
end
if(num==4)
    sss='FDS';
end

cn={sss,'Legend'};




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


% --- Executes on button press in pushbutton_change_Qb.
function pushbutton_change_Qb_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_change_Qb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_change_Qb,'Value');

if(n==1)
    Q=10;
    b=4;
end
if(n==2)
    Q=10;
    b=8;    
end
if(n==3)
    Q=30;
    b=8;    
end
if(n==4)
    Q=30;
    b=4;    
end

get_table_data(hObject, eventdata, handles);
array_name=getappdata(0,'array_name');
aleg=getappdata(0,'aleg');

N=get(handles.listbox_num,'Value');

    
for i=1:N
    if(Q==10)
        array_name{i} = strrep(array_name{i},'Q30','Q10');
    else
        array_name{i} = strrep(array_name{i},'Q10','Q30');        
    end
    if(b==4)
        array_name{i} = strrep(array_name{i},'b8','b4');
    else
        array_name{i} = strrep(array_name{i},'b4','b8');        
    end    
end

for i=1:N
    data_s{i,1}=array_name{i};
    data_s{i,2}=aleg{i};       
end 
    
set(handles.uitable_data,'Data',data_s);


ss=get(handles.edit_output_array_name2,'String');

if(Q==10)
        ss = strrep(ss,'Q30','Q10');
else
        ss = strrep(ss,'Q10','Q30');        
end
if(b==4)
        ss = strrep(ss,'b8','b4');
else
        ss = strrep(ss,'b4','b8');        
end 

set(handles.edit_output_array_name2,'String',ss);


% --- Executes on selection change in listbox_change_Qb.
function listbox_change_Qb_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_change_Qb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_change_Qb contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_change_Qb
pushbutton_change_Qb_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox_change_Qb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_change_Qb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_change_ev.
function listbox_change_ev_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_change_ev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_change_ev contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_change_ev
pushbutton_ev_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox_change_ev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_change_ev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ev.
function pushbutton_ev_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_change_ev,'Value');

if(n==1)
    ev=1;
end
if(n==2)
    ev=2;   
end
if(n==3)
    ev=3;    
end
if(n==4)
    ev=4;    
end

get_table_data(hObject, eventdata, handles);
array_name=getappdata(0,'array_name');
aleg=getappdata(0,'aleg');


N=get(handles.listbox_num,'Value');

    
for i=1:N
    if(ev==1)
        array_name{i} = strrep(array_name{i},'ev2','ev1');
        array_name{i} = strrep(array_name{i},'ev3','ev1');  
        array_name{i} = strrep(array_name{i},'ev4','ev1');            
    end
    if(ev==2)
        array_name{i} = strrep(array_name{i},'ev1','ev2');
        array_name{i} = strrep(array_name{i},'ev3','ev2');  
        array_name{i} = strrep(array_name{i},'ev4','ev2');            
    end
    if(ev==3)
        array_name{i} = strrep(array_name{i},'ev1','ev3');
        array_name{i} = strrep(array_name{i},'ev2','ev3');  
        array_name{i} = strrep(array_name{i},'ev4','ev3');            
    end
    if(ev==4)
        array_name{i} = strrep(array_name{i},'ev1','ev4');
        array_name{i} = strrep(array_name{i},'ev2','ev4');  
        array_name{i} = strrep(array_name{i},'ev3','ev4');            
    end
end

for i=1:N
    data_s{i,1}=array_name{i};
    data_s{i,2}=aleg{i};       
end

set(handles.uitable_data,'Data',data_s);


ss=get(handles.edit_output_array_name2,'String');

    if(ev==1)
        ss = strrep(ss,'ev2','ev1');
        ss = strrep(ss,'ev3','ev1');  
        ss = strrep(ss,'ev4','ev1');            
    end
    if(ev==2)
        ss = strrep(ss,'ev1','ev2');
        ss = strrep(ss,'ev3','ev2');  
        ss = strrep(ss,'ev4','ev2');            
    end
    if(ev==3)
        ss = strrep(ss,'ev1','ev3');
        ss = strrep(ss,'ev2','ev3');  
        ss = strrep(ss,'ev4','ev3');            
    end
    if(ev==4)
        ss = strrep(ss,'ev1','ev4');
        ss = strrep(ss,'ev2','ev4');  
        ss = strrep(ss,'ev3','ev4');            
    end

set(handles.edit_output_array_name2,'String',ss);


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


% --- Executes on button press in pushbutton_ch.
function pushbutton_ch_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

get_table_data(hObject, eventdata, handles);
array_name=getappdata(0,'array_name');
aleg=getappdata(0,'aleg');


b=get(handles.edit_new,'String');
a=get(handles.edit_old,'String');

N=get(handles.listbox_num,'Value');



for i=1:N
    array_name{i} = strrep(array_name{i},a,b);
    data_s{i,1}=array_name{i};
    data_s{i,2}=aleg{i};
end



set(handles.uitable_data,'Data',data_s);

ss=get(handles.edit_output_array_name2,'String');

ss = strrep(ss,a,b);

set(handles.edit_output_array_name2,'String',ss);





function edit_old_Callback(hObject, eventdata, handles)
% hObject    handle to edit_old (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_old as text
%        str2double(get(hObject,'String')) returns contents of edit_old as a double


% --- Executes during object creation, after setting all properties.
function edit_old_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_old (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new as text
%        str2double(get(hObject,'String')) returns contents of edit_new as a double


% --- Executes during object creation, after setting all properties.
function edit_new_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
