function varargout = plot_two_curves(varargin)
% PLOT_TWO_CURVES MATLAB code for plot_two_curves.fig
%      PLOT_TWO_CURVES, by itself, creates a new PLOT_TWO_CURVES or raises the existing
%      singleton*.
%
%      H = PLOT_TWO_CURVES returns the handle to a new PLOT_TWO_CURVES or the handle to
%      the existing singleton*.
%
%      PLOT_TWO_CURVES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_TWO_CURVES.M with the given input arguments.
%
%      PLOT_TWO_CURVES('Property','Value',...) creates a new PLOT_TWO_CURVES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_two_curves_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_two_curves_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_two_curves

% Last Modified by GUIDE v2.5 11-Apr-2014 11:39:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_two_curves_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_two_curves_OutputFcn, ...
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


% --- Executes just before plot_two_curves is made visible.
function plot_two_curves_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_two_curves (see VARARGIN)

% Choose default command line output for plot_two_curves
handles.output = hObject;

set(handles.edit_xmin,'Enable','off');
set(handles.edit_xmax,'Enable','off');

set(handles.edit_ymin,'Enable','off');
set(handles.edit_ymax,'Enable','off');

set(handles.listbox_xplotlimits,'Value',1);
set(handles.listbox_yplotlimits,'Value',1);
set(handles.listbox_xaxis,'Value',1);
set(handles.listbox_yaxis,'Value',1);
set(handles.listbox_legend,'Value',1);
set(handles.listbox_grid,'Value',1);

clear figure(1);
clear figure(2);
clear figure(3);
clear figure(4);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plot_two_curves wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_two_curves_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_figure_number.
function listbox_figure_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_figure_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_figure_number


% --- Executes during object creation, after setting all properties.
function listbox_figure_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_pc12.
function pushbutton_pc12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_pc12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%
try
    FS1=strtrim(get(handles.edit_c1_array_name,'String'));
    THM1=evalin('base',FS1);
catch
    warndlg('Array does not exist','Warning');
    return;
end
%
try
    FS2=strtrim(get(handles.edit_c2_array_name,'String'));
    THM2=evalin('base',FS2);
catch
    warndlg('Array does not exist','Warning');
    return;
end
%
nx_type=get(handles.listbox_xaxis,'Value');
ny_type=get(handles.listbox_yaxis,'Value');
ng=get(handles.listbox_grid,'Value');
nx_limits=get(handles.listbox_xplotlimits,'Value');
ny_limits=get(handles.listbox_yplotlimits,'Value');
%
n=get(handles.listbox_figure_number,'Value');
%
ncolor1=get(handles.listbox_c1_color,'Value');
ncolor2=get(handles.listbox_c2_color,'Value');
%
nlegend=get(handles.listbox_legend,'Value');
%
stitle=get(handles.edit_title,'String');
sxlabel=get(handles.edit_xlabel,'String');
sylabel=get(handles.edit_ylabel,'String');
%
if(nx_limits==2)

     xs1=get(handles.edit_xmin,'String');
     if isempty(xs1)
        warndlg('Enter xmin','Warning');
        return;
     else
        xmin=str2num(xs1);
     end
     
     xs2=get(handles.edit_xmax,'String');
     if isempty(xs2)
        warndlg('Enter xmax','Warning');
        return;
     else
        xmax=str2num(xs2);
     end 
end
%
if(ny_limits==2)
     
     ys1=get(handles.edit_ymin,'String');
 
     if isempty(ys1)
        warndlg('Enter ymin','Warning');
        return;
     else
        ymin=str2num(ys1);
     end
     
     ys2=get(handles.edit_ymax,'String');
     if isempty(ys2)
        warndlg('Enter ymax','Warning');
        return;
     else
        ymax=str2num(ys2);
     end 
end
%
clear figure(n);
figure(n);
%
cs1='black';
cs2='black';
%
if(ncolor1==2)
    cs1='blue';
end
if(ncolor1==3)
    cs1='red';
end
%
if(ncolor2==2)
    cs2='blue';
end
if(ncolor2==3)
    cs2='red';
end
%
a1max=max(abs(THM1(:,2)));
a2max=max(abs(THM2(:,2)));
%
hold on;
%
if(nx_type==2)
    if(THM1(1,1)<1.0e-20)
        THM1(1,:)=[];
    end
    if(THM2(1,1)<1.0e-20)
        THM2(1,:)=[];
    end      
end
%
if(ncolor1==4)
    h1=plot(THM1(:,1),THM1(:,2),'color',[0 0.5 0]);    
else
    h2=plot(THM1(:,1),THM1(:,2),cs1); 
end
%
if(ncolor2==4)
    h1=plot(THM2(:,1),THM2(:,2),'color',[0 0.5 0]);    
else
    h2=plot(THM2(:,1),THM2(:,2),cs2); 
end
%
hold off;   
%
title(stitle);
xlabel(sxlabel);
ylabel(sylabel);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(nlegend==1)
    slegend1=get(handles.edit_c1_legend,'String');
    slegend2=get(handles.edit_c2_legend,'String');
%    
    legend(slegend1,slegend2);
end
%
grid off;
if(ng==1)
    grid on;   
end
%
if(nx_type==1 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type==1)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end
%
if(nx_limits==2)  
         
     xlim([xmin,xmax]);
     
     if(xmin==20 && xmax==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
     end
     if(xmin==10 && xmax==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
     end     
     
     xlim([xmin,xmax]);
end
if(ny_limits==2)
     ylim([ymin,ymax]);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


% --- Executes on button press in pushbutton_pc2.
function pushbutton_pc2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_pc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_c2_array_name,'String');
    THM=evalin('base',FS);
catch
    warndlg('Array does not exist','Warning');
    return;
end
%
nx_type=get(handles.listbox_xaxis,'Value');
ny_type=get(handles.listbox_yaxis,'Value');
ng=get(handles.listbox_grid,'Value');
nx_limits=get(handles.listbox_xplotlimits,'Value');
ny_limits=get(handles.listbox_yplotlimits,'Value');
%
n=get(handles.listbox_figure_number,'Value');
ncolor=get(handles.listbox_c2_color,'Value');
nlegend=get(handles.listbox_legend,'Value');
stitle=get(handles.edit_title,'String');
sxlabel=get(handles.edit_xlabel,'String');
sylabel=get(handles.edit_ylabel,'String');
%
if(nx_limits==2)
     xs1=get(handles.edit_xmin,'String');
     if isempty(xs1)
        warndlg('Enter xmin','Warning');
        return;
     else
        xmin=str2num(xs1);
     end
     
     xs2=get(handles.edit_xmax,'String');
     if isempty(xs2)
        warndlg('Enter xmax','Warning');
        return;
     else
        xmax=str2num(xs2);
     end     
end
if(ny_limits==2)
     
     ys1=get(handles.edit_ymin,'String');

     if isempty(ys1)
        warndlg('Enter ymin','Warning');
        return;
     else
        ymin=str2num(ys1);
     end
     
     ys2=get(handles.edit_ymax,'String');
     if isempty(ys2)
        warndlg('Enter ymax','Warning');
        return;
     else
        ymax=str2num(ys2);
     end 
end
%
clear figure(n);
figure(n);
%
if(nx_type==2)
    if(THM(1,1)<1.0e-20)
        THM(1,:)=[];
    end  
end
%
%
if(ncolor==1)
    plot(THM(:,1),THM(:,2),'black');
end
if(ncolor==2)
    plot(THM(:,1),THM(:,2),'blue');
end
if(ncolor==3)
    plot(THM(:,1),THM(:,2),'red');
end
if(ncolor==4)
    plot(THM(:,1),THM(:,2),'color',[0 .5 0]);
end
%
if(nlegend==1)
    slegend=get(handles.edit_c2_legend,'String');
    legend(slegend,1);
end
%
title(stitle);
xlabel(sxlabel);
ylabel(sylabel);
%
grid off;
if(ng==1)
    grid on;
end
%
if(nx_type==1 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type==1)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end
%
if(nx_limits==2)
     xlim([xmin,xmax]);
     
     if(xmin==20 && xmax==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
     end
     if(xmin==10 && xmax==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
     end      
end
if(ny_limits==2)
     ylim([ymin,ymax]);
end

% --- Executes on button press in pushbutton_pc1.
function pushbutton_pc1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_pc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_c1_array_name,'String');
    THM=evalin('base',FS);
catch
    warndlg('Array does not exist','Warning');
    return;
end
%
%
nx_type=get(handles.listbox_xaxis,'Value');
ny_type=get(handles.listbox_yaxis,'Value');
ng=get(handles.listbox_grid,'Value');
nx_limits=get(handles.listbox_xplotlimits,'Value');
ny_limits=get(handles.listbox_yplotlimits,'Value');
%
n=get(handles.listbox_figure_number,'Value');
ncolor=get(handles.listbox_c1_color,'Value');
nlegend=get(handles.listbox_legend,'Value');
stitle=get(handles.edit_title,'String');
sxlabel=get(handles.edit_xlabel,'String');
sylabel=get(handles.edit_ylabel,'String');
%
if(nx_limits==2)
     xs1=get(handles.edit_xmin,'String');
     if isempty(xs1)
        warndlg('Enter xmin','Warning');
     else
        xmin=str2num(xs1);
     end
     
     xs2=get(handles.edit_xmax,'String');
     if isempty(xs2)
        warndlg('Enter xmax','Warning');
     else
        xmax=str2num(xs2);
     end     

end
if(ny_limits==2)
     
     ys1=get(handles.edit_ymin,'String');

     if isempty(ys1)
        warndlg('Enter ymin','Warning');
     else
        ymin=str2num(ys1);
     end
     
     ys2=get(handles.edit_ymax,'String');
     if isempty(ys2)
        warndlg('Enter ymax','Warning');
     else
        ymax=str2num(ys2);
     end 

end
%
if(nx_type==2)
    if(THM(1,1)<1.0e-20)
        THM(1,:)=[];
    end  
end
%
clear figure(n);
figure(n);
%
if(ncolor==1)
    plot(THM(:,1),THM(:,2),'black');
end
if(ncolor==2)
    plot(THM(:,1),THM(:,2),'blue');
end
if(ncolor==3)
    plot(THM(:,1),THM(:,2),'red');
end
if(ncolor==4)
    plot(THM(:,1),THM(:,2),'color',[0 .5 0]);
end
%
if(nlegend==1)
    slegend=get(handles.edit_c1_legend,'String');
    legend(slegend);
end
%
title(stitle);
xlabel(sxlabel);
ylabel(sylabel);
%
grid off;
if(ng==1)
    grid on;
end
%
if(nx_type==1 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type==1)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end
%
if(nx_limits==2)
     xlim([xmin,xmax]);

     if(xmin==20 && xmax==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
     end
     if(xmin==10 && xmax==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
     end 
end
if(ny_limits==2)
     ylim([ymin,ymax]);
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


% --- Executes on selection change in listbox_yaxis.
function listbox_yaxis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yaxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yaxis


% --- Executes during object creation, after setting all properties.
function listbox_yaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis (see GCBO)
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


% --- Executes on selection change in listbox_xaxis.
function listbox_xaxis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xaxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xaxis


% --- Executes during object creation, after setting all properties.
function listbox_xaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xlabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xlabel as text
%        str2double(get(hObject,'String')) returns contents of edit_xlabel as a double


% --- Executes during object creation, after setting all properties.
function edit_xlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c2_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c2_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c2_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_c2_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_c2_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c2_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c2_legend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c2_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c2_legend as text
%        str2double(get(hObject,'String')) returns contents of edit_c2_legend as a double


% --- Executes during object creation, after setting all properties.
function edit_c2_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c2_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c1_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c1_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c1_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_c1_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_c1_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c1_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c1_legend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c1_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c1_legend as text
%        str2double(get(hObject,'String')) returns contents of edit_c1_legend as a double


% --- Executes during object creation, after setting all properties.
function edit_c1_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c1_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_c1_color.
function listbox_c1_color_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_c1_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_c1_color contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_c1_color


% --- Executes during object creation, after setting all properties.
function listbox_c1_color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_c1_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_c2_color.
function listbox_c2_color_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_c2_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_c2_color contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_c2_color


% --- Executes during object creation, after setting all properties.
function listbox_c2_color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_c2_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% --- Executes on selection change in listbox_grid.
function listbox_grid_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_grid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_grid


% --- Executes during object creation, after setting all properties.
function listbox_grid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_xplotlimits.
function listbox_xplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xplotlimits

n=get(hObject,'Value');

if(n==1)
    set(handles.edit_xmin,'Enable','off');
    set(handles.edit_xmax,'Enable','off'); 
else
    set(handles.edit_xmin,'Enable','on');
    set(handles.edit_xmax,'Enable','on');  
end




% --- Executes during object creation, after setting all properties.
function listbox_xplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmin as text
%        str2double(get(hObject,'String')) returns contents of edit_xmin as a double


% --- Executes during object creation, after setting all properties.
function edit_xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax as a double


% --- Executes during object creation, after setting all properties.
function edit_xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits.
function listbox_yplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits

n=get(hObject,'Value');

if(n==1)
    set(handles.edit_ymin,'Enable','off');
    set(handles.edit_ymax,'Enable','off');   
else
    set(handles.edit_ymin,'Enable','on');
    set(handles.edit_ymax,'Enable','on');  
end


% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
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
