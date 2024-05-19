function varargout = vibrationdata_SPL(varargin)
% VIBRATIONDATA_SPL MATLAB code for vibrationdata_SPL.fig
%      VIBRATIONDATA_SPL, by itself, creates a new VIBRATIONDATA_SPL or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SPL returns the handle to a new VIBRATIONDATA_SPL or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SPL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SPL.M with the given input arguments.
%
%      VIBRATIONDATA_SPL('Property','Value',...) creates a new VIBRATIONDATA_SPL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_SPL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_SPL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_SPL

% Last Modified by GUIDE v2.5 19-Oct-2021 15:48:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_SPL_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_SPL_OutputFcn, ...
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


% --- Executes just before vibrationdata_SPL is made visible.
function vibrationdata_SPL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_SPL (see VARARGIN)

% Choose default command line output for vibrationdata_SPL
handles.output = hObject;

setappdata(0,'numsegments',0);

listbox_time_Callback(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','on');



set(handles.listbox_method,'Value',1);

set(handles.listbox_weighting,'Value',1);
set(handles.listbox_pressure_unit,'Value',1);

set(handles.pushbutton_epnl,'Visible','off'); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_SPL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_SPL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

set(handles.pushbutton_calculate,'Enable','on');



n=get(hObject,'Value');



set(handles.edit_output_array,'Enable','off');


set(handles.pushbutton_save,'Enable','off');

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end



% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


set(handles.pushbutton_epnl,'Visible','off'); 

fig_num=2;

m=get(handles.listbox_pressure_unit,'Value');

if(m==1)
    p_unit=sprintf('psi');
    ref = 2.9e-09;
end
if(m==2)
    p_unit=sprintf('Pa'); 
    ref = 20.e-06;
end
if(m==3)
    p_unit=sprintf('micro Pa');
    ref = 20.;
end

%%%%%%%%

k=get(handles.listbox_method,'Value');

try

    if(k==1)
        FS=get(handles.edit_input_array,'String');
        THM=evalin('base',FS);  
        setappdata(0,'THM',THM);
    else
        THM=getappdata(0,'THM');
    end

catch
    warndlg('Enter Input Array Name');
    return;
end


ntime=get(handles.listbox_time,'Value');

if(ntime==1)
    t1=THM(1,1);
    t2=THM(end,1);
else    
    t1=str2num(get(handles.edit_start_time,'String'));
    t2=str2num(get(handles.edit_end_time,'String'));         
end

mr=1;
window=2;

[spl,oaspl]=spl_function_alt(mr,window,t1,t2,THM,ref);

pf=spl(:,1);
pspl=spl(:,2);

imax=length(pf);
%
%%%%%%%%

iwn=get(handles.listbox_weighting,'Value');

if(iwn>=2)
   [pf,pspl,oaspl,scale_label]=acoustic_weighting_function(pf,pspl,imax,ref,iwn);
end 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
    fprintf('\n OASPL = %8.4g dB  ref 20 micro Pa \n\n',oaspl);
%
    if(iwn==1)
        p_rms = ref*(10^(oaspl/20.));
        fprintf('  pressure in air = %8.4g %s rms  \n\n',p_rms,p_unit);
    end
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(pf,pspl);
    ylabel('SPL (dB)');
    xlabel('Center Frequency (Hz)');
%
    if(iwn==1)
        out7=sprintf('One-Third Octave SPL   OASPL=%7.4g dB  Ref= 20 micro Pa',oaspl);
    else
        out7=sprintf('One-Third Octave SPL %s-scale  OASPL=%7.4g dB  Ref= 20 micro Pa',scale_label,oaspl);        
    end
%    
    title(out7);
%
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
    
    fmin=str2num(get(handles.edit_fmin,'String'));
    fmax=str2num(get(handles.edit_fmax,'String'));
    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);
        xlim([fmin,fmax]);    
    end   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%
  pf=fix_size(pf);
  pspl=fix_size(pspl);
  SPL=[pf pspl];
%
%%
    a(1)=1;
    a(2)=2;
    a(3)=4;
    a(4)=8; 
    a(5)=16;
    a(6)=31.5;
    a(7)=63;
    a(8)=125;
    a(9)=250;
    a(10)=500;
    a(11)=1000;
    a(12)=2000;
    a(13)=4000;
    a(14)=8000;
    a(15)=16000;
%
    clear f;
%
    bn=zeros(length(pspl),1);
    
    for i=1:length(pspl)
        bn(i)=i;
        f{i}=' ';
        
        for j=1:15
                
            if( (abs(pf(i)-a(j))/a(j)) < 0.05 )
                                
                if(j==11)
                    f{i}='1K';
                    break;
                end
                if(j==12)
                    f{i}='2K';
                    break;
                end
                if(j==13)
                    f{i}='4K';
                    break;
                end
                if(j==14)
                    f{i}='8K';
                    break;
                end
                if(j==15)
                    f{i}='16K';
                    break;
                end               
                f{i}=sprintf('%g',a(j));
                break;
            end    
  
        end    
           
    end
%
    f=fix_size(f);
%
    cpf(1)=pf(1);
    oct=2^(1/3);
    for i=2:length(pf)
        cpf(i)=cpf(i-1)*oct;
    end
%
    figure(fig_num);
    fig_num=fig_num+1;
    xx=log10(cpf);
    width=0.7;
    bar(xx,pspl,width);
    ylabel('SPL (dB)');
    xlabel('Center Frequency (Hz)');
%    
    title(out7);
%
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','lin');
    set(gca,'Xtick',xx)
    set(gca,'XTickLabel',f)
%
    minp=min(pspl);
    maxp=max(pspl);
%
    for i=0:20
        b=i*10;
        if(b>minp)
            ymin=b-10;
            break;
        end    
    end
%
    for i=0:20
        b=i*10;
        if(b>maxp)
            ymax=b;
            break;
        end    
    end
%
    fmin=log10(min(pf)/1.2599);
    fmax=log10(max(pf)*1.2599);
%
    xlim([fmin,fmax]);
    try
        ylim([ymin,ymax]);
    catch
    end
%
%%
   setappdata(0,'SPL',SPL);

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_epnl,'Visible','off');

data=getappdata(0,'SPL');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

set(handles.pushbutton_epnl,'Visible','on');

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


% --- Executes on button press in pushbutton_view_options.
function pushbutton_view_options_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_calculate,'Enable','on');
set(handles.uitable_advise,'Visible','on');
set(handles.listbox_numrows,'Visible','on');
set(handles.text_select_option,'Visible','on');

set(handles.listbox_numrows,'String',' ');

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);  
  setappdata(0,'THM',THM);
else
  THM=getappdata(0,'THM');
end


ntime=get(handles.listbox_time,'Value');

if(ntime==2)
    tstart=str2num(get(handles.edit_start_time,'String'));
      tend=str2num(get(handles.edit_end_time,'String'));   
      
     [~,istart]=min(abs(tstart-THM(:,1)));      
       [~,iend]=min(abs(tend-THM(:,1)));      
       
    THM=THM(istart:iend,:);      
       
end



setappdata(0,'THM',THM);

t=THM(:,1);
y=double(THM(:,2));

n=length(t);

dur=t(n)-t(1);
dt=dur/(n-1);

%%%%%%%%%%%%

m=get(handles.listbox_pressure_unit,'Value');

figure(1);
plot(THM(:,1),THM(:,2));
title('Input Time History');
xlabel(' Time(sec) ');
if(m==1)
    ylabel('Pressure (psi)');
end
if(m==2)
    ylabel('Pressure (Pa)');
end
if(m==3)
    ylabel('Pressure (micro Pa)');
end
grid on;

%%%%%%%%%%%%

NC=18;
%
ss=zeros(NC,1);
seg=zeros(NC,1);
i_seg=zeros(NC,1);
%
for i=4:NC
    ss(i) = 2^i;
    seg(i) =n/ss(i);
    i_seg(i) = fix(seg(i));
end
%
disp(' ');
out4 = sprintf(' Number of   Samples per   Time per    df');
out5 = sprintf('  Segments     Segment      Segment      ');
%
disp(out4)
disp(out5)
%
clear str;
clear data;
%
k=1;
for i=4:NC
    if( i_seg(i)>0)
        str(k) = (i_seg(i));
        tseg=dt*ss(i);
        ddf=1/tseg;
        out4 = sprintf(' \t  %d  \t  %d  \t   %6.3f  \t  %6.3f',str(k),ss(i),tseg,ddf);
        disp(out4)
        data(k,:)=[str(k),ss(i),tseg,ddf];
        k=k+1;
    end
end
%

cn={'No. of Segments ','Samples/Segments','Time/Segment (sec)','df (Hz)'};

set(handles.uitable_advise,'Data',data,'ColumnWidth','auto','ColumnName',cn);

%%%%%%%%%

for i=1:length(str)
    handles.number(i)=i;
end

set(handles.listbox_numrows,'String',handles.number);
set(handles.listbox_numrows,'Value',1);
set(handles.listbox_numrows,'Enable','on');

%%%%%%%%%

setappdata(0,'numsegments',str);
setappdata(0,'dt',dt);



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


% --- Executes on selection change in listbox_pressure_unit.
function listbox_pressure_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pressure_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pressure_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pressure_unit


% --- Executes during object creation, after setting all properties.
function listbox_pressure_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pressure_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_weighting.
function listbox_weighting_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_weighting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_weighting contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_weighting


% --- Executes during object creation, after setting all properties.
function listbox_weighting_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_weighting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_epnl.
function pushbutton_epnl_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_epnl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= pnl;
set(handles.s,'Visible','on'); 


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton_epnl.
function pushbutton_epnl_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_epnl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_start_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_time as text
%        str2double(get(hObject,'String')) returns contents of edit_start_time as a double


% --- Executes during object creation, after setting all properties.
function edit_start_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_time as text
%        str2double(get(hObject,'String')) returns contents of edit_end_time as a double


% --- Executes during object creation, after setting all properties.
function edit_end_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_time.
function listbox_time_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_time contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_time



n=get(handles.listbox_time,'Value');

if(n==1)
    set(handles.edit_start_time,'Visible','off');
    set(handles.edit_end_time,'Visible','off');    
    set(handles.text_start_time,'Visible','off');
    set(handles.text_end_time,'Visible','off');       
else
    set(handles.edit_start_time,'Visible','on');
    set(handles.edit_end_time,'Visible','on');    
    set(handles.text_start_time,'Visible','on');
    set(handles.text_end_time,'Visible','on');           
end


% --- Executes during object creation, after setting all properties.
function listbox_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
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
