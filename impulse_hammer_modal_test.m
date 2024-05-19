function varargout = impulse_hammer_modal_test(varargin)
% IMPULSE_HAMMER_MODAL_TEST MATLAB code for impulse_hammer_modal_test.fig
%      IMPULSE_HAMMER_MODAL_TEST, by itself, creates a new IMPULSE_HAMMER_MODAL_TEST or raises the existing
%      singleton*.
%
%      H = IMPULSE_HAMMER_MODAL_TEST returns the handle to a new IMPULSE_HAMMER_MODAL_TEST or the handle to
%      the existing singleton*.
%
%      IMPULSE_HAMMER_MODAL_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPULSE_HAMMER_MODAL_TEST.M with the given input arguments.
%
%      IMPULSE_HAMMER_MODAL_TEST('Property','Value',...) creates a new IMPULSE_HAMMER_MODAL_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before impulse_hammer_modal_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to impulse_hammer_modal_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help impulse_hammer_modal_test

% Last Modified by GUIDE v2.5 01-Nov-2021 10:09:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @impulse_hammer_modal_test_OpeningFcn, ...
                   'gui_OutputFcn',  @impulse_hammer_modal_test_OutputFcn, ...
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


% --- Executes just before impulse_hammer_modal_test is made visible.
function impulse_hammer_modal_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to impulse_hammer_modal_test (see VARARGIN)

% Choose default command line output for impulse_hammer_modal_test
handles.output = hObject;

set(handles.listbox_num,'Value',1);
listbox_num_Callback(hObject, eventdata, handles);


set(handles.listbox_save,'Value',1);

set(handles.listbox_type,'Value',1);

set(handles.edit_ylabel_input,'String','G');


set(handles.pushbutton_save,'Enable','off');

set(handles.pushbutton_curve_fit,'Enable','off');

try
    name=getappdata(0,'name');    
    set(handles.edit_input_array_1,'String',name);
catch
end


try
    num=getappdata(0,'num');
    if(isempty(num)==1)
        num=1;
        set(handles.listbox_num,'Value',num);
        listbox_num_Callback(hObject, eventdata, handles);
    end    
catch
end


try
    data=getappdata(0,'data_times');
    sz=size(data);
    if(sz(1)>=1)
        set(handles.uitable_data,'Data',data);     
        set(handles.listbox_num,'Value',sz(1));
        listbox_num_Callback(hObject, eventdata, handles);
    end    
catch
end    

listbox_channels_Callback(hObject, eventdata, handles);
 
setappdata(0,'impulse_response',[]);  





% Update handles structure
guidata(hObject, handles);

% UIWAIT makes impulse_hammer_modal_test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = impulse_hammer_modal_test_OutputFcn(hObject, eventdata, handles) 
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

delete(impulse_hammer_modal_test);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'fig_num',1);


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nfont=10;

  

YS_input=get(handles.edit_ylabel_input,'String');


% ts=str2num(get(handles.edit_start,'String'));
% te=str2num(get(handles.edit_end,'String'));



disp('  ');
disp(' * * * * * ');
disp('  ');

FS1=get(handles.edit_input_array_1,'String');

try
    THM=evalin('base',FS1);
catch
    warndlg('Input array not found');
    return;
end


%%%

sz=size(THM);

NC=get(handles.listbox_channels,'Value');

if(NC~=(sz(2)-1))
    warndlg('Number of channels does not agree with input array');
    return;
end
 

try
    AC=get(handles.uitable_channels,'Data');
   
    for i=1:NC
        cname{i}=char(AC(i,:));
        cname{i} = strtrim(cname{i});
    end         
catch
end

for i=1:NC-1
    BC{i}=cname{i+1};
end


setappdata(0,'channels',BC);
setappdata(0,'num_channels',NC-1);

%%%


try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
        
    N=get(handles.listbox_num,'Value');
catch
    warndlg(' data get error');
    return;
end

k=1;

try
  
    for i=1:N
        tss{i}=A(k,:); k=k+1;
        tss{i} = strtrim(tss{i});
         ts(i)=str2double(tss{i});
    end 
    
    for i=1:N
        tee{i}=A(k,:); k=k+1;
        tee{i} = strtrim(tee{i});
         te(i)=str2double(tee{i});        
    end     
    
catch
    warndlg('Time limits read failed ');
    return;
end


fig_num=1;




sz=size(THM);

if(te(end)>THM(:,1))
    warndlg('End time in table is > end time of input array');
    return;
end


nresponse=sz(2)-2;

if(nresponse<1)
    warndlg('Error: number of responses < 1');
    return;
end



iu=get(handles.listbox_force_unit,'Value');

if(iu==1)
  YF='Force (lbf)';
  FU='lbf';
else
  YF='Force (N)';
  FU='N';
end

i=get(handles.listbox_type,'Value');

if(i==1)
  YR1='Acceleration';
  yys='acc';
  t_string='Accelerance';
  if(iu==1)
    y_label='Magnitude (G/lbf)';
  else
    y_label='Magnitude ((m/sec)/lbf)';      
  end  
end
if(i==2)
  YR1='Velocity';
  yys='vel';
  t_string='Mobility';
  if(iu==1)
    y_label='Magnitude ((in/sec)/lbf)';
  else
    y_label='Magnitude ((m/sec)/lbf)';      
  end
end
if(i==3)
  YR1='Displacement';
  yys='dis';
  t_string='Admittance';
  if(iu==1)
    y_label='Magnitude (in/lbf)';
  else
    y_label='Magnitude ((m/sec)/lbf)';      
  end    
end



YU=get(handles.edit_ylabel_input,'String');

YR2=sprintf(' (%s)',YU);

YR=strcat(YR1,YR2);


t_string1='Force Signal';
t_string2='Response Signal';
ylabel1=YF;
ylabel2=YR;
xlabel2='Time (sec)';


t=THM(:,1);
a=THM(:,2);
b=THM(:,3:sz(2));

data1=[t a];
data2=[t b];

num=length(t);


if(num<=10)
    warndlg('num<=10');
    return;
end

dt=(t(end)-t(1))/(num-1);
sr=1/dt;



if(isnan(sr))
    warndlg('sr NaN');
    return;
end

setappdata(0,'sr',sr);


if(nresponse==1)
    [fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);
end
if(nresponse==2)
%%    [fig_num]=subplots_three_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);
end


n=num;

%%
YS=get(handles.edit_ylabel_input,'String');
m=get(handles.listbox_type,'Value');

k = strfind(YS,'/');

out2=sprintf('%s/Force (%s/%s)',YR1,YU,FU);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sfmin=get(handles.edit_fmin,'String');
sfmax=get(handles.edit_fmax,'String');


if isempty(sfmin)
    string=sprintf('%8.4g',df);
    set(handles.edit_fmin,'String',string); 
    sfmin=get(handles.edit_fmin,'String');    
end

if isempty(sfmax)
    sr=1/dt;
    nyf=sr/2;
    string=sprintf('%8.4g',nyf);
    set(handles.edit_fmax,'String',string);
    sfmax=get(handles.edit_fmax,'String');    
end

fmin=str2num(sfmin);
fmax=str2num(sfmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ttt=te-ts;
tmin=min(ttt);
num_min=floor(tmin/dt);


if(isnan(num_min))
    warndlg('num_min NaN');
    return;
end

if(num_min<16)
    warndlg('Min time interval is too short');
    return;
end    


winlen=2^floor(log2(num_min));

if(isnan(winlen))
    warndlg('winlen NaN');
    return;
end

fprintf('\n  winlen = %d  \n',winlen);
fprintf('\n  tmin = %8.4g   dt = %8.4g  \n',tmin,dt);
    
if(iu==1 && contains(YS_input,'G')==1)
    b=b*386;
end

fprintf('\n  num_min=%d   winlen=%d \n',num_min,winlen);



for i=1:N

    [~,jj1]=min(abs(t-ts(i)));
    
    jj2=jj1+winlen-1;
    
%    fprintf('  jj2 = %d  jj1 = %d \n',jj2,jj1);
    
    if(i==1)
        aa=a(jj1:jj2);
        bb=b(jj1:jj2,:);           
    else
        try
            aa=[aa; a(jj1:jj2)];
            bb=[bb; b(jj1:jj2,:)];
        catch
            size(a)
            size(b)
            fprintf(' i=%d  jj1=%d  jj2=%d  \n',i,jj1,jj2);
            warndlg(' Failure:  aa bb ');
            return;
        end
    end
end


progressbar;

for i=1:nresponse
    
    progressbar(i/nresponse);
    
    if(N>=2)
        [H1(:,i),f,coh(:,i)] = modalfrf(aa,bb(:,i),sr,winlen,'Sensor',yys);   
    else
        [H1(:,i),f] = modalfrf(aa,bb(:,i),sr,winlen,'Estimator','H1','Sensor',yys); 
    end
    
    [H2(:,i)] = modalfrf(aa,bb(:,i),sr,winlen,'Estimator','H2','Sensor',yys);
end

progressbar(1);


if(iu==1)
    y_label='Magnitude (in/lbf)';
else
    y_label='Magnitude (m/N)';
end    

setappdata(0,'y_label',y_label);

md=5;

if(nresponse==2)
        t_string1=sprintf('Admittance  %s',cname{2});
        t_string2=sprintf('Admittance  %s',cname{3});        
        [fig_num]=plot_frf_md_H1_H2_two_titles(fig_num,f,H1,H2,fmin,fmax,t_string1,t_string2,y_label,md);
else    
    for i=1:nresponse
        t_string=sprintf('Admittance  %s',cname{i+1});
        [fig_num]=plot_frf_md_H1_H2(fig_num,f,H1(:,i),H2(:,i),fmin,fmax,t_string,y_label,md);
    end
end
    
ymin=0;
ymax=1.1;
x_label='Frequency (Hz)';


nf=length(f);

H1_m=zeros(nf,nresponse);
H1_p=zeros(nf,nresponse);

  

if(nresponse==2)
    
    try
        ppp=[f coh];
    
        ccname{1}=cname{2};
        ccname{2}=cname{3};
    
        [fig_num,h2]=...
        plot_loglin_function_h2_ymax_coherence_two_cname(fig_num,x_label,t_string,ppp,fmin,fmax,ymin,ymax,ccname);
    catch
    end
    
else

    if(N>=2)
    
        for i=1:nresponse
    
            ppp=[f coh(:,i)];

            t_string=sprintf('Coherence  %s',cname{i+1});

            [fig_num,h2]=...
            plot_loglin_function_h2_ymax_coherence(fig_num,x_label,t_string,ppp,fmin,fmax,ymin,ymax);
        
        end
    else
        msgbox('No coherence for single hit');
    end

end


for i=1:nresponse
    H1_m(:,i)=abs(H1(:,i));
    H1_p(:,i)=angle(H1(:,i));    
end

ff=f;

try
    COH=coh;
catch
end
    
%%

setappdata(0,'H1_m_store',[f H1_m]);
setappdata(0,'H1_mp_store',[f H1_m H1_p]);
setappdata(0,'H1_complex_store',[f H1]);


[~,ii]=min(abs(f-fmin));
[~,jj]=min(abs(f-fmax));

setappdata(0,'H1',[f(ii:jj) H1(ii:jj,:)]);
setappdata(0,'H2',[f(ii:jj) H2(ii:jj,:)]);

try
    setappdata(0,'coh',[f(ii:jj) COH(ii:jj,:)]);
catch
end

setappdata(0,'sr',sr);

H1=getappdata(0,'H1');
H2=getappdata(0,'H2');

try
    coh=getappdata(0,'coh');
catch
end
    
assignin('base', 'H1', H1);
assignin('base', 'H2', H2);

try
    assignin('base', 'coh', coh);
catch
end

%%%

try
    COH_store=[ff COH];
    setappdata(0,'COH_store',COH_store);
catch
end
    
setappdata(0,'fmin',fmin);
setappdata(0,'fmax',fmax);


set(handles.pushbutton_save,'Enable','on');
set(handles.pushbutton_curve_fit,'Enable','on');

try
    msgbox('Calculation complete');
catch
end





function edit_input_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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



function edit_ylabel_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_input as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_input as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_force_unit.
function listbox_force_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_unit


% --- Executes during object creation, after setting all properties.
function listbox_force_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
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


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num

cn={'Start Time (sec)','End Time (sec)'};

Nrows=get(handles.listbox_num,'Value');


%%%%

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



if( sz(1)==0 && sz(2)==0)
     set(handles.listbox_num,'Value',1);
     data_s{1,1}='';
     data_s{1,2}='';     
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


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
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


% --- Executes on button press in pushbutton_curve_fit.
function pushbutton_curve_fit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_curve_fit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=modal_curve_fit;
set(handles.s,'Visible','on');

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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'H1_m_store');
end
if(n==2)
    data=getappdata(0,'H1_mp_store');
end    
if(n==3)
    data=getappdata(0,'H1_complex_store');
end
if(n==4)
    data=getappdata(0,'H2_m_store');
end
if(n==5)
    data=getappdata(0,'H2_mp_store');
end
if(n==6)
    data=getappdata(0,'H2_complex_store');
end
if(n==7)
    data=getappdata(0,'COH_store');
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete');


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


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    nchan=get(handles.listbox_channels,'Value');
    ImpulseHammer.nchan=nchan;     
catch
end

try
    channels=get(handles.uitable_channels,'Data');
    ImpulseHammer.channels=channels;
catch    
end

try
    data=get(handles.uitable_data,'Data'); 
    ImpulseHammer.data=data;      
catch
end

try
    num=get(handles.listbox_num,'Value'); 
    ImpulseHammer.num=num;      
catch
end
try
    array=get(handles.edit_input_array_1,'String'); 
    ImpulseHammer.array=array;      
catch
end
try
    type=get(handles.listbox_type,'Value'); 
    ImpulseHammer.type=type;      
catch
end
try
    ylabel=get(handles.edit_ylabel_input,'String'); 
    ImpulseHammer.ylabel=ylabel;      
catch
end
try
    force_unit=get(handles.listbox_force_unit,'Value'); 
    ImpulseHammer.force_unit=force_unit;      
catch
end
try
    fmin=get(handles.edit_fmin,'String'); 
    ImpulseHammer.fmin=fmin;      
catch
end
try
    fmax=get(handles.edit_fmax,'String'); 
    ImpulseHammer.fmax=fmax;      
catch
end
try
    FS=strtrim(get(handles.edit_input_array_1,'String'));    
    THM=evalin('base',FS);
    ImpulseHammer.THM=THM;   
    ImpulseHammer.FS=FS;  
catch
end



% % %
 
structnames = fieldnames(ImpulseHammer, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'ImpulseHammer'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
try 
    msgbox('Save Complete');
catch
end


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

   ImpulseHammer=evalin('base','ImpulseHammer');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%

try
    nchan=ImpulseHammer.nchan;     
    set(handles.listbox_channels,'Value',nchan);   
    listbox_channels_Callback(hObject, eventdata, handles);    
catch
end

try
    channels=ImpulseHammer.channels;    
    set(handles.uitable_channels,'Data',channels);
catch    
end

try
    num=ImpulseHammer.num;     
    set(handles.listbox_num,'Value',num); 
    listbox_num_Callback(hObject, eventdata, handles);
catch
end


try
    data=ImpulseHammer.data;     
    set(handles.uitable_data,'Data',data); 
catch
end


try
    array=ImpulseHammer.array;       
    set(handles.edit_input_array_1,'String',array);    
catch
end
try
    type=ImpulseHammer.type;     
    set(handles.listbox_type,'Value',type);      
catch
end
try
    ylabel=ImpulseHammer.ylabel;      
    set(handles.edit_ylabel_input,'String',ylabel);     
catch
end
try
    force_unit=ImpulseHammer.force_unit;      
    set(handles.listbox_force_unit,'Value',force_unit);     
catch
end
try
    fmin=ImpulseHammer.fmin;     
    set(handles.edit_fmin,'String',fmin);      
catch
end
try
    fmax=ImpulseHammer.fmax;     
    set(handles.edit_fmax,'String',fmax);      
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(ImpulseHammer.FS);
 
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
            THM1=ImpulseHammer.THM;
            assignin('base',FS1,THM1); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





% --- Executes on selection change in listbox_channels.
function listbox_channels_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_channels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_channels contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_channels

cn={'Channel Name'};
Nrows=get(handles.listbox_channels,'Value');


%%%%

Ncolumns=1;
 
A=get(handles.uitable_channels,'Data');
 
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
 
set(handles.uitable_channels,'Data',data_s,'ColumnName',cn);


% --- Executes during object creation, after setting all properties.
function listbox_channels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_channels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on listbox_num and none of its controls.
function listbox_num_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)