function varargout = vibrationdata_cross_correlation(varargin)
% VIBRATIONDATA_CROSS_CORRELATION MATLAB code for vibrationdata_cross_correlation.fig
%      VIBRATIONDATA_CROSS_CORRELATION, by itself, creates a new VIBRATIONDATA_CROSS_CORRELATION or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_CROSS_CORRELATION returns the handle to a new VIBRATIONDATA_CROSS_CORRELATION or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_CROSS_CORRELATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_CROSS_CORRELATION.M with the given input arguments.
%
%      VIBRATIONDATA_CROSS_CORRELATION('Property','Value',...) creates a new VIBRATIONDATA_CROSS_CORRELATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_cross_correlation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_cross_correlation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_cross_correlation

% Last Modified by GUIDE v2.5 28-Jun-2013 11:27:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_cross_correlation_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_cross_correlation_OutputFcn, ...
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


% --- Executes just before vibrationdata_cross_correlation is made visible.
function vibrationdata_cross_correlation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_cross_correlation (see VARARGIN)

% Choose default command line output for vibrationdata_cross_correlation
handles.output = hObject;

set(handles.listbox_format,'Value',1);
set(handles.listbox_method,'Value',1);


set(handles.text_IAN_2,'Visible','off');
set(handles.edit_input_array_2,'Visible','off');
set(handles.edit_input_array_2,'String','');

set(handles.text_IAN_1,'Visible','on');
set(handles.edit_input_array_1,'Visible','on');
set(handles.text_IAN_1,'String','Input Array Name');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_cross_correlation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_cross_correlation_OutputFcn(hObject, eventdata, handles) 
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
disp(' * * * * ');
disp(' ');

YS=get(handles.edit_ylabel,'String');

n=get(handles.listbox_format,'Value');
m=get(handles.listbox_method,'Value');

if(m==1)
%
   FS=get(handles.edit_input_array_1,'String');
   THM_1=evalin('base',FS);    
%
   if(n==1)
      t1=THM_1(:,1);
      a=THM_1(:,2);
      b=THM_1(:,3);        
   else
%     
       FS=get(handles.edit_input_array_2,'String');
       THM_2=evalin('base',FS);
%     
       t1=THM_1(:,1);
       t2=THM_2(:,1);
       a=THM_1(:,2);
       b=THM_2(:,2);       
   end
end

if(m==2)
%     
   THM_1=getappdata(0,'THM_1');
%   
   if(n==1)     
       t1=THM_1(:,1);
       a=THM_1(:,2);
       b=THM_1(:,3);      
   else
%
     THM_2=getappdata(0,'THM_2');
%
       t1=THM_1(:,1);
        a=THM_1(:,2);
       t2=THM_2(:,1);
        b=THM_2(:,2);    
   end
end

fig_num=1;

if(n==1)
    sz=size(THM_1);
    num=sz(2)-1;
    data1=[ t1 THM_1(:,2) ];
    data2=[ t1 THM_1(:,3) ];    
    if(num>=3)
       data3=[ t1 THM_1(:,4) ]; 
    end
    if(num>=4)
       data4=[ t1 THM_1(:,5) ]; 
    end    
else 
    num=2;
    data1=[ t1 a ];
    data2=[ t2 b ];
end

xlabelx='Time(sec)';

if(num==2)
    ylabel1=YS;
    ylabel2=YS;
    t_string1='Channel 1';
    t_string2='Channel 2';
    [fig_num]=subplots_two_linlin_titles(fig_num,xlabelx,ylabel1,ylabel2,data1,data2,t_string1,t_string2);
end
if(num==3)
    ylabel1=YS;
    ylabel2=YS;
    ylabel3=YS;
    t_string1='Channel 1';
    t_string2='Channel 2';
    t_string3='Channel 3';    
    [fig_num]=subplots_three_linlin_titles(fig_num,xlabelx,...
                              ylabel1,ylabel2,ylabel3,data1,data2,data3,...
                                            t_string1,t_string2,t_string3);
end
if(num==4)
    ylabel1=YS;
    ylabel2=YS;
    ylabel3=YS;
    ylabel4=YS;
    t_string1='Channel 1';
    t_string2='Channel 2';
    t_string3='Channel 3';  
    t_string4='Channel 4';     
    [fig_num]=subplots_four_linlin_titles(fig_num,xlabelx,...
                                        ylabel1,ylabel2,ylabel3,ylabel4,...
                                        data1,data2,data3,data4,...
                                        t_string1,t_string2,t_string3,t_string4);
end

%%%

if(m==1)
   dt=mean(diff(t1));
else
   num1=length(t1);
   dt1=mean(diff(t1));
%   
   num2=length(t2);
   dt2=mean(diff(t2));  
%
%  Truncate if necessary
%
    if(num1<num2)
        num2=num1;
    end
    if(num2<num1)
        num1=num2;
    end
    num=num1;
%
    pe=abs((dt1-dt2)/dt1);
%
    dt=(dt1+dt2)/2;
%
    if(pe>0.01)
        out1=sprintf('Warning: dt1=%8.4g  dt2=%8.4g ',dt1,dt2);
        warndlg('time steps differ');
    end 
%
end

n
m
num

np=length(data1(:,1));

k=1;

for i=1:(num-1)
    for j=(i+1):num

        if(num==2)
            a=data1(:,2);
            b=data2(:,2);
        else
            a=THM_1(:,i+1);
            b=THM_1(:,j+1);
        end
        
        [xc,xmax(k),tmax(k)]=cross_correlation_function(a,b,np,dt);
        
        [rho(k)]=Pearson_coefficient(a,b);       
        
        figure(fig_num);
        fig_num=fig_num+1;
        plot(a,b,'bo','MarkerSize',3);
        grid on;
        xL=sprintf('Channel %d Amplitude',i);        
        yL=sprintf('Channel %d Amplitude',j);
        xlabel(xL);
        ylabel(yL);
        out2=sprintf('Scatter Plot, Pearson Coefficient= %6.3g',rho(k));
        title(out2);

        figure(fig_num);
        fig_num=fig_num+1;
        plot(xc(:,1),xc(:,2));
        xlabel('Delay(sec)');
        ylabel('Rxy');
        out1=sprintf(' Cross-correlation Channels %d & %d \n Max Abs = %8.4g at %8.4g sec',i,j,xmax(k),tmax(k));
        title(out1);
%        disp(out);      
        grid on;
    
%        out1=sprintf(' Pearson product-moment correlation coefficient = %8.4g ',rho);
%        disp(out1);    

        if(num==2)
            disp(' ');
            disp(' Covariance Matrix: ');
            disp(' ');
            cvm = cov(a,b)
        end
        k=k+1;
    end
end

k=1;
disp(' ');
disp(' Channels   Cross-Correlation ');
for i=1:(num-1)
    for j=(i+1):num
        fprintf('   %d & %d    Max Abs = %8.4g at %8.4g sec \n',i,j,xmax(k),tmax(k));
        k=k+1;
    end
end

k=1;
disp(' ');
disp(' Channels   Pearson Coefficient ');
for i=1:(num-1)
    for j=(i+1):num
        fprintf('   %d & %d    rho=%6.3g \n',i,j,rho(k));
        k=k+1;
    end
end

msgbox('Calculation Complete.  Results written to Command Window.');

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_cross_correlation);

% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

mn_common(hObject, eventdata, handles);



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


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format

mn_common(hObject, eventdata, handles);



function mn_common(hObject, eventdata, handles)

set(handles.text_IAN_1,'Visible','off');
set(handles.text_IAN_2,'Visible','off');
set(handles.edit_input_array_1,'Visible','off');
set(handles.edit_input_array_2,'Visible','off');
set(handles.edit_input_array_1,'String','');
set(handles.edit_input_array_2,'String','');


n=get(handles.listbox_format,'Value');
m=get(handles.listbox_method,'Value');

if(n==1 && m==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.text_IAN_1,'String','Input Array Name');
end
if(n==2 && m==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.text_IAN_2,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.edit_input_array_2,'Visible','on');
    set(handles.text_IAN_1,'String','Input First Array Name');
    set(handles.text_IAN_2,'String','Input Second Array Name');    
end
if(m==2)
%
   if(n==1)
%
      [filename, pathname] = uigetfile('*.*','Select the time history file.');
      filename = fullfile(pathname, filename);
      fid = fopen(filename,'r');
%
      THM_1 = fscanf(fid,'%g %g %g',[3 inf]);
      THM_1=THM_1';
      setappdata(0,'THM_1',THM_1);   
      sz=size(THM_1);
      if(sz(2)~=3)
         errordlg('Input array does not have three columns.','File Error');      
      end
   else
%
      [filename, pathname] = uigetfile('*.*','Select the first time history file.');
      filename = fullfile(pathname, filename);
      fid_1 = fopen(filename,'r');
%
      THM_1 = fscanf(fid_1,'%g %g',[2 inf]);
      THM_1=THM_1';
      setappdata(0,'THM_1',THM_1);
      sz=size(THM_1);
      if(sz(2)~=2)
         errordlg('Input array does not have two columns.','File Error');          
      end      
 %
      [filename, pathname] = uigetfile('*.*','Select the second time history file.');
      filename = fullfile(pathname, filename);
      fid_2 = fopen(filename,'r');
%
      THM_2 = fscanf(fid_2,'%g %g',[2 inf]);
      THM_2=THM_2';
      setappdata(0,'THM_2',THM_2);
      sz=size(THM_2);
      if(sz(2)~=2)
         errordlg('Input array does not have two columns.','File Error');          
      end   
 %
   end
%
end


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
