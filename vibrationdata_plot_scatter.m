function varargout = vibrationdata_plot_scatter(varargin)
% VIBRATIONDATA_PLOT_SCATTER MATLAB code for vibrationdata_plot_scatter.fig
%      VIBRATIONDATA_PLOT_SCATTER, by itself, creates a new VIBRATIONDATA_PLOT_SCATTER or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PLOT_SCATTER returns the handle to a new VIBRATIONDATA_PLOT_SCATTER or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PLOT_SCATTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PLOT_SCATTER.M with the given input arguments.
%
%      VIBRATIONDATA_PLOT_SCATTER('Property','Value',...) creates a new VIBRATIONDATA_PLOT_SCATTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_plot_scatter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_plot_scatter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_plot_scatter

% Last Modified by GUIDE v2.5 11-May-2017 12:31:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_plot_scatter_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_plot_scatter_OutputFcn, ...
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


% --- Executes just before vibrationdata_plot_scatter is made visible.
function vibrationdata_plot_scatter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_plot_scatter (see VARARGIN)

% Choose default command line output for vibrationdata_plot_scatter
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

% UIWAIT makes vibrationdata_plot_scatter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_plot_scatter_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_plot_scatter);



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


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%
 
Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
 
if(NFigures>5)
    NFigures=5;
end
 
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end
 
 %%%%%%%%%%%


n=get(handles.listbox_format,'Value');
m=get(handles.listbox_method,'Value');

xxx=get(handles.edit_xlab,'String');

if(m==1)
%
   FS=get(handles.edit_input_array_1,'String');
   THM_1=evalin('base',FS); 
%
   if(n==1)
       t1=THM_1(:,1);
       t2=t1;      
       a=THM_1(:,2);
       b=THM_1(:,3);
   end
   if(n==2)
       a=THM_1(:,1);
       b=THM_1(:,2);       
   end
   if(n==3)
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
     t2=t1;
     a=THM_1(:,2);
     b=THM_1(:,3);
   end
   if(n==2)
     a=THM_1(:,1);
     b=THM_1(:,2);       
   end
   if(n==3)
%
     THM_2=getappdata(0,'THM_2');
%
       t1=THM_1(:,1);
        a=THM_1(:,2);
       t2=THM_2(:,1);
        b=THM_2(:,2);    
   end
end


YS1=get(handles.edit_YS1,'String');
YS2=get(handles.edit_YS2,'String');

fig_num=1;

if(n~=2)

    figure(fig_num);
    fig_num=fig_num+1;
    plot(t1,a);
    grid on;
    xlabel(xxx);
    ylabel(YS1);
    title('First Signal');

    figure(fig_num);
    fig_num=fig_num+1;
    plot(t2,b);
    grid on;
    xlabel(xxx);
    ylabel(YS2);
    title('Second Signal');


     xlabel2=xxx;
     
     ylabel1=YS1;
     ylabel2=YS2;
     
     data1=[t1 a];
     data2=[t1 b];

     t_string1='First Signal';
     t_string2='Second Signal';

    [fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);

    
    
   
    
    clear length;

    an=length(a);
    bn=length(b);

    if(an>bn)
        a=a(1:bn);
        warndlg('Signal lengths are different');
    end
    if(an<bn)
        b=b(1:an);
        warndlg('Signal lengths are different');    
    end

end

[rho]=Pearson_coefficient(a,b);
out2=sprintf('Scatter Plot, Pearson Coefficient= %6.3g',rho);


figure(fig_num);
fig_num=fig_num+1;
plot(a,b,'bo','MarkerSize',3);
grid on;
xlabel(YS1);
ylabel(YS2);
title(out2);

figure(fig_num);
fig_num=fig_num+1;
plot(a,b,'bo','MarkerSize',3);
grid on;
xlabel(YS1);
ylabel(YS2);
out2=sprintf('Scatter Plot, Pearson Coefficient= %6.3g',rho);
title(out2)

[xx]=get(gca,'xlim');
[yy]=get(gca,'ylim');

Qmax=max([ abs(xx) abs(yy)  ]);

[Qmax]=ytick_linear_scale(Qmax);

xlim([-Qmax,Qmax]);
ylim([-Qmax,Qmax]);

axis square;



%%%



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


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format

mn_common(hObject, eventdata, handles);


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


function mn_common(hObject, eventdata, handles)

set(handles.text_IAN_1,'Visible','off');
set(handles.text_IAN_2,'Visible','off');
set(handles.edit_input_array_1,'Visible','off');
set(handles.edit_input_array_2,'Visible','off');
set(handles.edit_input_array_1,'String','');
set(handles.edit_input_array_2,'String','');


n=get(handles.listbox_format,'Value');
m=get(handles.listbox_method,'Value');

if(n<=2 && m==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.text_IAN_1,'String','Input Array Name');
end
if(n==3 && m==1)
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
   end   
%   
   if(n==2)
%
      [filename, pathname] = uigetfile('*.*','Select the time history file.');
      filename = fullfile(pathname, filename);
      fid = fopen(filename,'r');
%
      THM_1 = fscanf(fid,'%g %g',[2 inf]);
      THM_1=THM_1';
      setappdata(0,'THM_1',THM_1);   
      sz=size(THM_1);
      if(sz(2)~=2)
         errordlg('Input array does not have two columns.','File Error');      
      end
   end      
   if(n==3)
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



function edit_YS1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_YS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_YS1 as text
%        str2double(get(hObject,'String')) returns contents of edit_YS1 as a double


% --- Executes during object creation, after setting all properties.
function edit_YS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_YS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_YS2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_YS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_YS2 as text
%        str2double(get(hObject,'String')) returns contents of edit_YS2 as a double


% --- Executes during object creation, after setting all properties.
function edit_YS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_YS2 (see GCBO)
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
