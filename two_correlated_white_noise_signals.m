function varargout = two_correlated_white_noise_signals(varargin)
% TWO_CORRELATED_WHITE_NOISE_SIGNALS MATLAB code for two_correlated_white_noise_signals.fig
%      TWO_CORRELATED_WHITE_NOISE_SIGNALS, by itself, creates a new TWO_CORRELATED_WHITE_NOISE_SIGNALS or raises the existing
%      singleton*.
%
%      H = TWO_CORRELATED_WHITE_NOISE_SIGNALS returns the handle to a new TWO_CORRELATED_WHITE_NOISE_SIGNALS or the handle to
%      the existing singleton*.
%
%      TWO_CORRELATED_WHITE_NOISE_SIGNALS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_CORRELATED_WHITE_NOISE_SIGNALS.M with the given input arguments.
%
%      TWO_CORRELATED_WHITE_NOISE_SIGNALS('Property','Value',...) creates a new TWO_CORRELATED_WHITE_NOISE_SIGNALS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_correlated_white_noise_signals_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_correlated_white_noise_signals_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_correlated_white_noise_signals

% Last Modified by GUIDE v2.5 28-Sep-2020 16:45:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_correlated_white_noise_signals_OpeningFcn, ...
                   'gui_OutputFcn',  @two_correlated_white_noise_signals_OutputFcn, ...
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


% --- Executes just before two_correlated_white_noise_signals is made visible.
function two_correlated_white_noise_signals_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_correlated_white_noise_signals (see VARARGIN)

% Choose default command line output for two_correlated_white_noise_signals
handles.output = hObject;

listbox_1_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_correlated_white_noise_signals wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_correlated_white_noise_signals_OutputFcn(hObject, eventdata, handles) 
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

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    




    disp(' ');
    disp(' * * * * * * * * ');
    disp(' ');

    fig_num=1;


    m=get(handles.listbox_1,'Value');
     
    tmax=str2num(get(handles.edit_duration,'String'));    
    sigma1=str2num(get(handles.edit_std_1,'String'));   
    sigma2=str2num(get(handles.edit_std_2,'String'));   
    sr=str2num(get(handles.edit_SR,'String'));
     
    dt=1./sr;   
    np=ceil(tmax/dt);
    TT=linspace(0,(np-1)*dt,np); 
  
%%%    [a] = normrnd_function(sigma,np);

    clear length;
    np=length(TT);
    
    a=randn(np,1);
    a=fix_size(a);
    a=a-mean(a);
    a=a*sigma1/std(a);
    
    b=randn(np,1);
    b=fix_size(b);
    b=b-mean(b);
    b=b*sigma2/std(b);    
    
%
    if(m==1)
%
%    iband:   1=lowpass  2=highpass  3=bandpass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering
%
      iband=1;
      fl=str2num(get(handles.edit8,'String'));
      if(fl>sr/2.)
          fl=0.49*sr;
          msgbox('Note: lowpass filter frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fl);
          set(handles.edit8,'String',out1);         
      end
      fh=0;
%
    end
%      
    if(m==2)
        
      iband=3;
      fh=str2num(get(handles.edit8,'String'));
      if(fh>sr/2.)
          fh=0.49*sr;
          msgbox('Note: lower frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fh);
          set(handles.edit8,'String',out1);         
      end

      fl=str2num(get(handles.edit9,'String'));
      if(fl>sr/2.)
          fl=0.49*sr;
          msgbox('Note: upper frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fl);
          set(handles.edit9,'String',out1);         
      end     
      
      
    end
    
    if(m<=2)
        
      tstring='Band-limited White Noise';
      
      iphase=2;     
      
      [a,~,~,~]=Butterworth_filter_function_alt(a,dt,iband,fl,fh,iphase);      
      ave=mean(a);
      stddev=std(a);
      sss=sigma1/stddev;
      a=(a-ave)*sss;        
        
      [b,~,~,~]=Butterworth_filter_function_alt(b,dt,iband,fl,fh,iphase);      
      ave=mean(b);
      stddev=std(b);
      sss=sigma2/stddev;
      b=(b-ave)*sss;       
      
    end    
    
%    

    rho=str2num(get(handles.edit_rho,'String'));
    c=rho*a+sqrt(1-rho^2)*b;
    
    clear b;
    
    YS=get(handles.edit_ylabel,'String');
    
    figure(fig_num);
    fig_num=fig_num+1;
    plot(TT,a,TT,c);
    title('White Noise');
    legend('First','Second');
    grid on;
    xlabel('Time (sec)');
    ylabel(YS);
    
%%%

    num=np;
    [xc,xmax,tmax]=cross_correlation_function(a,c,num,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
    [rho]=Pearson_coefficient(a,c);
%

    disp(' ');
    disp(' Covariance Matrix ');
    disp(' ');
    
    cvm = cov(a,c)

%

    figure(fig_num);
    fig_num=fig_num+1;
    plot(a,c,'bo','MarkerSize',3);
    grid on;
    xlabel('First Signal Amplitude');
    ylabel('Second Signal Amplitude');
    out2=sprintf('Scatter Plot, Pearson Coefficient= %6.3g',rho);
    title(out2);
    axis square
    aa=max(abs(a));
    cc=max(abs(c));
    qmax=max([aa cc]);
    [ymax,yTT,ytt,iflag]=ytick_linear_double_sided(qmax);
    if(iflag==1)
        qmax=ymax;
    end
    xlim([-qmax qmax]);
    ylim([-qmax qmax]); 
   
%
    disp(' ');
%

    figure(fig_num);
    fig_num=fig_num+1;
    plot(xc(:,1),xc(:,2));
    xlabel(' Delay(sec) ');
    ylabel('Rxy');
    out1=sprintf(' Cross-correlation  Max Abs = %8.4g at %8.4g sec',xmax,tmax);
    title(out1);
    disp(out1);      
    grid on;
 
    
    xlabel2='Time (sec)';
    ylabel1=YS;
    ylabel2=YS;
    
    TT=fix_size(TT);
    a=fix_size(a);
    c=fix_size(c);
    
    data1=[TT a];
    data2=[TT c];
    data3=[TT a c];
    t_string1='First Signal';
    t_string2='Second Signal';
    
nbars=31;                                      
                                      
[fig_num]=plot_two_time_histories_histograms_alt(fig_num,xlabel2,...
                    ylabel1,ylabel2,data1,data2,t_string1,t_string2,nbars);    
        
    out1=sprintf(' Pearson product-moment correlation coefficient = %8.4g ',rho);
    disp(out1);    

    
    prefix=get(handles.edit_prefix,'String');    
    
    s1=sprintf('%s_1',prefix);
    s2=sprintf('%s_2',prefix);    
    s3=sprintf('%s_1_2',prefix);    

assignin('base', s1,data1);   
assignin('base', s2,data2);  
assignin('base', s3,data3); 
    
out2=sprintf('\n  Output arrays: \n  %s \n  %s \n  %s \n',s1,s2,s3); 
disp(out2);

out1=sprintf(' Calculation Complete. Output arrays: \n  %s \n  %s \n  %s',s1,s2,s3);    
msgbox(out1);

    
    

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(two_correlated_white_noise_signals);


% --- Executes on selection change in listbox_1.
function listbox_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_1

n=get(handles.listbox_1,'Value');


set(handles.text_s8,'Visible','off');
set(handles.edit8,'Visible','off'); 
set(handles.text_s9,'Visible','off');
set(handles.edit9,'Visible','off'); 


if(n<=2)
    set(handles.text_s8,'Visible','on');
    set(handles.edit8,'Visible','on');  
end


if(n==1)
   sss='Low Pass Frequency (Hz)'; 
   set(handles.text_s8,'String',sss);
end
if(n==2)
   sss1='Lower Frequency (Hz)'; 
   sss2='Upper Frequency (Hz)'; 
   set(handles.text_s8,'String',sss1); 
   set(handles.text_s9,'String',sss2);
   set(handles.text_s9,'Visible','on');
   set(handles.edit9,'Visible','on');       
end





% --- Executes during object creation, after setting all properties.
function listbox_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_SR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SR as text
%        str2double(get(hObject,'String')) returns contents of edit_SR as a double


% --- Executes during object creation, after setting all properties.
function edit_SR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_std_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_std_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_std_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_std_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_std_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_std_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho as text
%        str2double(get(hObject,'String')) returns contents of edit_rho as a double


% --- Executes during object creation, after setting all properties.
function edit_rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_prefix_Callback(hObject, eventdata, handles)
% hObject    handle to edit_prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_prefix as text
%        str2double(get(hObject,'String')) returns contents of edit_prefix as a double


% --- Executes during object creation, after setting all properties.
function edit_prefix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_std_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_std_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_std_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_std_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_std_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_std_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
