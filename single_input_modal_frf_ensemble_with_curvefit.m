function varargout = single_input_modal_frf_ensemble_with_curvefit(varargin)
% SINGLE_INPUT_MODAL_FRF_ENSEMBLE_WITH_CURVEFIT MATLAB code for single_input_modal_frf_ensemble_with_curvefit.fig
%      SINGLE_INPUT_MODAL_FRF_ENSEMBLE_WITH_CURVEFIT, by itself, creates a new SINGLE_INPUT_MODAL_FRF_ENSEMBLE_WITH_CURVEFIT or raises the existing
%      singleton*.
%
%      H = SINGLE_INPUT_MODAL_FRF_ENSEMBLE_WITH_CURVEFIT returns the handle to a new SINGLE_INPUT_MODAL_FRF_ENSEMBLE_WITH_CURVEFIT or the handle to
%      the existing singleton*.
%
%      SINGLE_INPUT_MODAL_FRF_ENSEMBLE_WITH_CURVEFIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINGLE_INPUT_MODAL_FRF_ENSEMBLE_WITH_CURVEFIT.M with the given input arguments.
%
%      SINGLE_INPUT_MODAL_FRF_ENSEMBLE_WITH_CURVEFIT('Property','Value',...) creates a new SINGLE_INPUT_MODAL_FRF_ENSEMBLE_WITH_CURVEFIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before single_input_modal_frf_ensemble_with_curvefit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to single_input_modal_frf_ensemble_with_curvefit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help single_input_modal_frf_ensemble_with_curvefit

% Last Modified by GUIDE v2.5 21-Sep-2020 15:18:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @single_input_modal_frf_ensemble_with_curvefit_OpeningFcn, ...
                   'gui_OutputFcn',  @single_input_modal_frf_ensemble_with_curvefit_OutputFcn, ...
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


% --- Executes just before single_input_modal_frf_ensemble_with_curvefit is made visible.
function single_input_modal_frf_ensemble_with_curvefit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to single_input_modal_frf_ensemble_with_curvefit (see VARARGIN)

% Choose default command line output for single_input_modal_frf_ensemble_with_curvefit
handles.output = hObject;

listbox_format_Callback(hObject, eventdata, handles);

set(handles.listbox_save,'Value',1);
set(handles.listbox_type,'Value',1);

set(handles.edit_ylabel_input,'String','G');

set(handles.pushbutton_calculate,'Enable','off');

set(handles.listbox_numrows,'Enable','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_option,'Visible','off');

set(handles.uitable_advise,'Visible','off');

set(handles.pushbutton_save,'Enable','off');

set(handles.pushbutton_curve_fit,'Enable','off');

set(handles.pushbutton_view_options,'Enable','on');

listbox_channels_Callback(hObject, eventdata, handles);

impulse_response_case(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes single_input_modal_frf_ensemble_with_curvefit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = single_input_modal_frf_ensemble_with_curvefit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function impulse_response_case(hObject, eventdata, handles)

imp=get(handles.listbox_impulse,'Value');

set(handles.listbox_save,'String','');

ss{1}='H1: Frequency & Magnitude';
ss{2}='H1: Frequency & Magnitude & Phase';
ss{3}='H1: Frequency & Complex';
ss{4}='H2: Frequency & Magnitude';
ss{5}='H2: Frequency & Magnitude & Phase';
ss{6}='H2: Frequency & Complex';
ss{7}='Coherence';

if(imp==1)
    ss{8}='h1: Impulse Response Function';   
else
    set(handles.listbox_save,'Value',1);
end

set(handles.listbox_save,'String',ss);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
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
disp(' * * * * ');
disp(' ');

fig_num=1;


THM=getappdata(0,'THM_C');

sz=size(THM);

nresponse=sz(2)-2;

if(nresponse<1)
    warndlg('Error: number of responses < 1');
    return;
end

t=THM(:,1);
a=THM(:,2);
b=THM(:,3:sz(2));

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

setappdata(0,'y_label',y_label);

YU=get(handles.edit_ylabel_input,'String');

YR2=sprintf(' (%s)',YU);

YR=strcat(YR1,YR2);


t_string1='Force Signal';
t_string2='Response Signal';
ylabel1=YF;
ylabel2=YR;
data1=[t a];
data2=[t b];
xlabel2='Time (sec)';

pp=1;

if(pp==1)
    a=a-mean(a);
    for i=1:nresponse
        b(:,i)=b(:,i)-mean(b(:,i));
    end    
end    



if(nresponse==1)
    [fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);
end
if(nresponse==2)
%%    [fig_num]=subplots_three_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);
end


num=length(t);
dt=(t(num)-t(1))/(num-1);
sr=1/dt;

setappdata(0,'sr',sr);

n=num;

%%
YS=get(handles.edit_ylabel_input,'String');
ntype=get(handles.listbox_type,'Value');

k = strfind(YS,'/');

out2=sprintf('%s/Force (%s/%s)',YR1,YU,FU);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

advise_data=getappdata(0,'advise_data');

q=get(handles.listbox_numrows,'Value');

NW=advise_data(q,1);  % Number of Segments

mmm = 2^fix(log(n/NW)/log(2));
%
df=1./(mmm*dt);

winlen=mmm;

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

h_choice =get(handles.listbox_window,'Value');

NC=get(handles.listbox_channels,'Value');

sz=size(b)+1;

if(NC~=sz(2))
    warndlg('Number of channels does not agree with input array');
    return;
end
 

try
    AC=get(handles.uitable_channels,'Data');
   
    for i=1:NC-1
        cname{i}=char(AC(i+1,:));
        cname{i} = strtrim(cname{i});
    end         
catch
end


setappdata(0,'channels',cname);
getappdata(0,'channels')

setappdata(0,'num_channels',NC-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1 && ntype==1)
    b=b*386;
end

imp=get(handles.listbox_impulse,'Value');


fper=2/100;
%
n=winlen;
%
na=round(fper*n);
nb=n-na;
delta=n-nb;
%

progressbar;

for i=1:nresponse
    
    progressbar(i/nresponse);

    if(h_choice==1)
        [H1(:,i),f,coh(:,i)] = modalfrf(a,b(:,i),sr,winlen,0.5*winlen,'Sensor',yys);   
        [H2(:,i)] = modalfrf(a,b(:,i),sr,winlen,0.5*winlen,'Estimator','H2','Sensor',yys);        
    else
        [H1(:,i),f,coh(:,i)] = modalfrf(a,b(:,i),sr,hann(winlen),0.5*winlen,'Sensor',yys);   
        [H2(:,i)] = modalfrf(a,b(:,i),sr,hann(winlen),0.5*winlen,'Estimator','H2','Sensor',yys);   
    end

    if(imp==1)
        if(h_choice==1)
            txy(:,i)=tfestimate(a,b(:,i),winlen,0.5*winlen,'twosided');        
        else
            txy(:,i)=tfestimate(a,b(:,i),hann(winlen),0.5*winlen,'twosided');   
        end    
        
        impulse_response(:,i)=ifft(txy(:,i),'Symmetric');
            
        for ijk=nb:n
            arg=pi*( (ijk-nb)/delta );
            impulse_response(ijk,i)=impulse_response(ijk,i)*(1+cos(arg))*0.5;
        end
        
 
    end        
    
end

progressbar(1);

if(imp==1)
    setappdata(0,'impulse_response',[t(1:winlen) impulse_response]);
else
    setappdata(0,'impulse_response',[]);    
end

if(iu==1)
    y_label='Magnitude (in/lbf)';
else
    y_label='Magnitude (m/N)';
end    

setappdata(0,'y_label',y_label);

md=6;

if(nresponse==2)
        t_string1=sprintf('Admittance  %s',cname{1});
        t_string2=sprintf('Admittance  %s',cname{2});        
        [fig_num]=plot_frf_md_H1_H2_two_titles(fig_num,f,H1,H2,fmin,fmax,t_string1,t_string2,y_label,md);
else    
    for i=1:nresponse
        t_string=sprintf('Admittance  %s',cname{i});
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
    
    ppp=[f coh];
    
    ccname{1}=cname{1};
    ccname{2}=cname{2};
    
    [fig_num,h2]=...
    plot_loglin_function_h2_ymax_coherence_two_cname(fig_num,x_label,t_string,ppp,fmin,fmax,ymin,ymax,ccname);
    
else    

    for i=1:nresponse
    
        ppp=[f coh(:,i)];

        t_string=sprintf('Coherence  %s',cname{i+1});

        [fig_num,h2]=...
        plot_loglin_function_h2_ymax_coherence(fig_num,x_label,t_string,ppp,fmin,fmax,ymin,ymax);
        
    end

end



for i=1:nresponse
    H1_m(:,i)=abs(H1(:,i));
    H1_p(:,i)=angle(H1(:,i));    
end

ff=f;

COH=coh;

%%

setappdata(0,'H1_m_store',[f H1_m]);
setappdata(0,'H1_mp_store',[f H1_m H1_p]);
setappdata(0,'H1_complex_store',[f H1]);


[~,ii]=min(abs(f-fmin));
[~,jj]=min(abs(f-fmax));

setappdata(0,'H1',[f(ii:jj) H1(ii:jj,:)]);
setappdata(0,'H2',[f(ii:jj) H2(ii:jj,:)]);
setappdata(0,'sr',sr);

%%%

COH_store=[ff COH];
setappdata(0,'COH_store',COH_store);

setappdata(0,'fmin',fmin);
setappdata(0,'fmax',fmax);


set(handles.pushbutton_save,'Enable','on');
set(handles.pushbutton_curve_fit,'Enable','on');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(single_input_modal_frf_ensemble_with_curvefit);

% --- Executes on button press in pushbutton_view_options.
function pushbutton_view_options_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_curve_fit,'Enable','off');
set(handles.listbox_numrows,'Visible','on');
set(handles.listbox_numrows,'Enable','on');
set(handles.text_select_option,'Visible','on');

set(handles.uitable_advise,'Visible','on');
set(handles.uitable_advise,'Enable','on');


nf=1;

FS1=get(handles.edit_input_array_1,'String');

try
    THM=evalin('base',FS1);
catch
    warndlg('Input array not found');
    return;
end

setappdata(0,'THM_C',THM);

%%%%%
    
t=THM(:,1);

num=length(t);
dt=(t(num)-t(1))/(num-1);

dur=num*dt;

n=num;

%%%%%%%%

NC=0;
for i=1:1000
%    
    nmp = 2^(i-1);
%   
    if(nmp <= n )
        ss(i) = 2^(i-1);
        seg(i) =n/ss(i);
        i_seg(i) = fix(seg(i));
        NC=NC+1;
    else
        break;
    end
end

disp(' ')
out4 = sprintf(' Number of   Samples per   Time per        df               ');
out5 = sprintf(' Segments     Segment      Segment(sec)   (Hz)     dof     ');
%
disp(out4)
disp(out5)
%
k=1;
for i=1:NC
    j=NC+1-i;
    if j>0
        if( i_seg(j)>0 )
%           str = int2str(i_seg(j));
            tseg=dt*ss(j);
            ddf=1./tseg;
            out4 = sprintf(' %8d  %8d    %11.5f    %9.4f   %d',i_seg(j),ss(j),tseg,ddf,2*i_seg(j));
            disp(out4)
            data(k,:)=[i_seg(j),ss(j),tseg,ddf,2*i_seg(j)];
            k=k+1;
        end
    end
    if(i==12)
        break;
    end
end
%

max_num_rows=k-1;

for i=1:max_num_rows
    handles.number(i)=i;
end

set(handles.listbox_numrows,'String',handles.number);

cn={'No. of Segments ','Samples/Segments','Time/Segment (sec)','df (Hz)','dof'};

set(handles.uitable_advise,'Data',data,'ColumnWidth','auto','ColumnName',cn);

setappdata(0,'advise_data',data);

set(handles.pushbutton_calculate,'Enable','on');

%%%%%%%%


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
if(n==8)
    data=getappdata(0,'impulse_response');
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete');

% --- Executes on selection change in listbox_numrows.
function listbox_numrows_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numrows contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numrows


% --- Executes during object creation, after setting all properties.
function listbox_numrows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_mean_removal.
function listbox_mean_removal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean_removal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean_removal


% --- Executes during object creation, after setting all properties.
function listbox_mean_removal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_window.
function listbox_window_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_window contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_window
set(handles.pushbutton_curve_fit,'Enable','off');

% --- Executes during object creation, after setting all properties.
function listbox_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
set(handles.pushbutton_curve_fit,'Enable','off');

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
set(handles.pushbutton_curve_fit,'Enable','off');

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


function mn_common(hObject, eventdata, handles)


set(handles.text_IAN_1,'Visible','off');

set(handles.edit_input_array_1,'Visible','off');

set(handles.edit_input_array_1,'String','');



n=1;
m=1;

if(n==1 && m==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.text_IAN_1,'String','Input Common Array Name');
end
if(n==2 && m==1)
    set(handles.text_IAN_1,'Visible','on');

    set(handles.edit_input_array_1,'Visible','on');

    set(handles.text_IAN_1,'String','Input Force Array Name');
  
end


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format
mn_common(hObject, eventdata, handles);
set(handles.pushbutton_curve_fit,'Enable','off');

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



function edit_input_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_1 as a double
set(handles.pushbutton_calculate,'Enable','off');

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



function edit_input_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_curve_fit.
function pushbutton_curve_fit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_curve_fit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=modal_curve_fit;
set(handles.s,'Visible','on');


% --- Executes on key press with focus on edit_input_array_1 and none of its controls.
function edit_input_array_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_curve_fit,'Enable','off');
set(handles.pushbutton_calculate,'Enable','off');


% --- Executes on key press with focus on edit_input_array_2 and none of its controls.
function edit_input_array_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_curve_fit,'Enable','off');


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


% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



[filename, pathname] = uigetfile('*.mat', 'Select model save file');

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

   ModalFRF=evalin('base','ModalFRF');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%


try
    unit=ModalFRF.unit;    
    set(handles.listbox_force_unit,'Value',unit);
catch
end
try
    window=ModalFRF.window;     
    set(handles.listbox_window,'Value',window);   
catch
end    
try
    num_chan=ModalFRF.num_chan;    
    set(handles.listbox_channels,'Value',num_chan);
    listbox_channels_Callback(hObject, eventdata, handles);
catch
end
try    
    type=ModalFRF.type;    
    set(handles.listbox_type,'Value',type);
catch
end
try
    input_array=ModalFRF.input_array;    
    set(handles.edit_input_array_1,'String',input_array);
catch
end
try
    ylabel=ModalFRF.ylabel;    
    set(handles.edit_ylabel_input,'String',ylabel);
catch
end
try
    fmin=ModalFRF.fmin;    
    set(handles.edit_fmin,'String',fmin);
catch
end
try
    fmax=ModalFRF.fmax;    
    set(handles.edit_fmax,'String',fmax);
catch
end

try
    channels=ModalFRF.channels;    
    set(handles.uitable_channels,'Data',channels);
catch
end    





% --- Executes on button press in pushbutton_save_model_x.
function pushbutton_save_model_x_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    unit=get(handles.listbox_force_unit,'Value');
    ModalFRF.unit=unit;
catch
end
try
    window=get(handles.listbox_window,'Value');
    ModalFRF.window=window;    
catch
end    
try
    num_chan=get(handles.listbox_channels,'Value');
    ModalFRF.num_chan=num_chan;
    
catch
end
try    
    type=get(handles.listbox_type,'Value');
    ModalFRF.type=type;
catch
end
try
    input_array=get(handles.edit_input_array_1,'String');
    ModalFRF.input_array=input_array;
catch
end
try
    ylabel=get(handles.edit_ylabel_input,'String');
    ModalFRF.ylabel=ylabel;
catch
end
try
    fmin=get(handles.edit_fmin,'String');
    ModalFRF.fmin=fmin;
catch
end
try
    fmax=get(handles.edit_fmax,'String');
    ModalFRF.fmax=fmax;
catch
end

try
    channels=get(handles.uitable_channels,'Data');
    ModalFRF.channels=channels;
catch
end    



% % %
 
structnames = fieldnames(ModalFRF, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
        save(elk, 'ModalFRF'); 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');


% --- Executes on selection change in listbox_impulse.
function listbox_impulse_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_impulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_impulse contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_impulse

impulse_response_case(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_impulse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_impulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
