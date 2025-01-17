function varargout = vibrationdata_SRS_plot_multiplexxx(varargin)
% VIBRATIONDATA_SRS_PLOT_MULTIPLEXXX MATLAB code for vibrationdata_SRS_plot_multiplexxx.fig
%      VIBRATIONDATA_SRS_PLOT_MULTIPLEXXX, by itself, creates a new VIBRATIONDATA_SRS_PLOT_MULTIPLEXXX or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SRS_PLOT_MULTIPLEXXX returns the handle to a new VIBRATIONDATA_SRS_PLOT_MULTIPLEXXX or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SRS_PLOT_MULTIPLEXXX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SRS_PLOT_MULTIPLEXXX.M with the given input arguments.
%
%      VIBRATIONDATA_SRS_PLOT_MULTIPLEXXX('Property','Value',...) creates a new VIBRATIONDATA_SRS_PLOT_MULTIPLEXXX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_SRS_plot_multiplexxx_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_SRS_plot_multiplexxx_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_SRS_plot_multiplexxx

% Last Modified by GUIDE v2.5 04-Feb-2020 15:21:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_SRS_plot_multiplexxx_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_SRS_plot_multiplexxx_OutputFcn, ...
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


% --- Executes just before vibrationdata_SRS_plot_multiplexxx is made visible.
function vibrationdata_SRS_plot_multiplexxx_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_SRS_plot_multiplexxx (see VARARGIN)

% Choose default command line output for vibrationdata_SRS_plot_multiplexxx
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);


set(handles.listbox_frequency_limits,'Value',1);
set(handles.listbox_input_type,'Value',1);

listbox_frequency_limits_Callback(hObject, eventdata, handles);
listbox_amplitude_limits_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_SRS_plot_multiplexxx wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_SRS_plot_multiplexxx_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_SRS_plot_multiple);


%8 --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%% evalin('base', 'close all')
setappdata(0,'fig_num',1);


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%%%%%%%%%


psave=get(handles.listbox_psave,'Value');

fig_num=1;

%%%%%%%%%%%%%%%%%%%%%

num=get(handles.listbox_num,'Value');

%%

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
    warndlg('Input Arrays read failed');
    return;
end

setappdata(0,'array_name',array_name);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nx_type=2;
nlegend=1;

if(num>=1)
    try        
        FS1=array_name{1};
        THM1=evalin('base',FS1);
    catch
        warndlg('Array 1 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM1(1,1)<1.0e-20)
            THM1(1,:)=[];
        end    
    end 
    if(nlegend==1)
        leg1=leg{1};
    end
    
    ppp1=THM1;
   
end    

if(num>=2)
    try        
        FS2=array_name{2};
        THM2=evalin('base',FS2);
    catch
        warndlg('Array 2 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM2(1,1)<1.0e-20)
            THM2(1,:)=[];
        end    
    end 
    if(nlegend==1)
        leg2=leg{2};
    end
    
    ppp2=THM2;

end  

if(num>=3)
    try        
        FS3=array_name{3};
        THM3=evalin('base',FS3);
    catch
        warndlg('Array 3 does not exist','Warning');
        return;
    end
    if(nx_type==3)
        if(THM3(1,1)<1.0e-20)
            THM3(1,:)=[];
        end    
    end 
    if(nlegend==1)
        leg3=leg{3};
    end
    
    ppp3=THM3;
    
end  
if(num>=4)
    try        
        FS4=array_name{4};
        THM4=evalin('base',FS4);
    catch
        warndlg('Array 4 does not exist','Warning');
        return;
    end
    if(nx_type==4)
        if(THM4(1,1)<1.0e-20)
            THM4(1,:)=[];
        end    
    end 
    if(nlegend==1)
        leg4=leg{4};
    end
    
    ppp4=THM4;
    
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q=str2num(get(handles.edit_Q,'String'));

xaxis_label=get(handles.edit_xaxis_label,'String');
yaxis_label=get(handles.edit_yaxis_label,'String');


p=get(handles.listbox_input_type,'Value');


m=get(handles.listbox_frequency_limits,'Value');

if(m==1) % automatic
    
    if(num==1)
        fmin=THM1(1,1); 
        fmax=THM1(end,1);
    end
    if(num==2)
        fmin=min([ THM1(1,1)      THM2(1,1) ]); 
        fmax=max([ max(THM1(:,1)) max(THM2(:,1))]);
    end    
    if(num==3)
        fmin=min([ THM1(1,1)    THM2(1,1)   THM3(1,1)]); 
        fmax=max([ max(THM1(:,1))  max(THM2(:,1))   max(THM3(:,1))]);
    end    
    if(num==4)
        fmin=min([ THM1(1,1)    THM2(1,1)   THM3(1,1)   THM4(1,1)]); 
        fmax=max([ max(THM1(:,1))  max(THM2(:,1))   max(THM3(:,1))  max(THM4(:,1))]);
    end        
   
else     % manual
    
    fmin=str2num(get(handles.edit_start_frequency,'String'));
    fmax=str2num(get(handles.edit_end_frequency,'String'));
end

md=4;



x_label=xaxis_label;
y_label=yaxis_label;


try
    if(leg1==leg2)
        warndlg('Legends are the same');
    end
catch
end

try
    if(leg2==leg3)
        warndlg('Legends are the same');
    end
catch
end



t_string=get(handles.edit_title,'String');

  i50=get(handles.listbox_50,'Value');
iwork=get(handles.listbox_work,'Value');

ny=get(handles.listbox_amplitude_limits,'value');

if(ny==2)
    ymin=str2num(get(handles.edit_ymin','String'));
    ymax=str2num(get(handles.edit_ymax','String'));    
end

if(p==1)  % natural frequency & peak absolute
    
     
    
    ppp50=[fmin 0.8*fmin; fmax 0.8*fmax ];
    leg50='50 ips';
    
    pppw=[10 8; 80 64; 500 64];
    legw='Min Level';
     
    if(iwork==1)
        if(fmin>10)
            fmin=10;
        end
        if(fmax<500)
            fmax=500;
        end
    end
    
%%%%

    if(num==1)
        
         if(i50==2 && iwork==2)
    
            [fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,y_label,...
                t_string,ppp1,fmin,fmax,md);
        end
        if(i50==1 && iwork==2)        
            [fig_num,h2]=plot_loglog_function_md_two_h2_second_dash(fig_num,x_label,...
                  y_label,t_string,ppp1,ppp50,leg1,leg50,fmin,fmax,md);
        end    
        if(i50==2 && iwork==1)        
            [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,pppw,leg1,legw,fmin,fmax,md);
        end     
        if(i50==1 && iwork==1)        
            [fig_num,h2]=plot_loglog_function_md_three_h2_third_dash(fig_num,x_label,...
               y_label,t_string,ppp1,pppw,ppp50,leg1,legw,leg50,fmin,fmax,md); 
        end
        
    end
    
%%%%

    if(num==2)
    
        if(i50==2 && iwork==2)
    
            [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
        end
        if(i50==1 && iwork==2)        
            [fig_num,h2]=plot_loglog_function_md_three_h2_third_dash(fig_num,x_label,...
                  y_label,t_string,ppp1,ppp2,ppp50,leg1,leg2,leg50,fmin,fmax,md);
        end    
        if(i50==2 && iwork==1)        
            [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,pppw,leg1,leg2,legw,fmin,fmax,md);
        end     
        if(i50==1 && iwork==1)        
            [fig_num,h2]=plot_loglog_function_md_four_h2_third_dash(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp50,pppw,leg1,leg2,leg50,legw,fmin,fmax,md); 
        end 
        
    end
    
%%%%

    if(num==3)
        
        if(i50==2 && iwork==2)
    
            [fig_num,h2]=plot_loglog_function_md_three_h2xxx(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
        end
        if(i50==1 && iwork==2)   
            [fig_num,h2]=plot_loglog_function_md_four_h2_four_dash(fig_num,x_label,...
                  y_label,t_string,ppp1,ppp2,ppp3,ppp50,leg1,leg2,leg3,leg50,fmin,fmax,md);
        end    
        if(i50==2 && iwork==1)        
            [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,pppw,leg1,leg2,leg3,legw,fmin,fmax,md);
        end     
        if(i50==1 && iwork==1)        
            [fig_num,h2]=plot_loglog_function_md_five_h2_fourth_dash(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp50,pppw,leg1,leg2,leg3,leg50,legw,fmin,fmax,md);  
        end         
        
    end 
    
%%%%    
    
    if(num==4)
        if(i50==2 && iwork==2)
             msgbox('plot function for this case is pending');  
        end
        if(i50==1 && iwork==2)   
            [fig_num,h2]=plot_loglog_function_md_five_h2_five_dash(fig_num,x_label,...
                  y_label,t_string,ppp1,ppp2,ppp3,ppp4,ppp50,leg1,leg2,leg3,leg4,leg50,fmin,fmax,md);
        end    
        if(i50==2 && iwork==1)        
            msgbox('plot function for this case is pending');
        end     
        if(i50==1 && iwork==1)        
            msgbox('plot function for this case is pending');
        end                 
    end
    
%%%%    

    
    if(ny==2)
       ylim([ymin,ymax]);
    end
    
    
else  % natural frequency & peak positive & peak negative

%%%

    sz1=size(THM1);          
    m11=sz1(1);
    m12=sz1(2);
    
    sz2=size(THM2);          
    m21=sz2(1);
    m22=sz2(2);    
    
    if(m12~=3)
        warndlg(' Input Array 1 must have three columns');
        return;
    end
    if(m22~=3)
        warndlg(' Input Array 2 must have three columns');
        return;
    end    
    
%%%    

    
    THM1a(:,1)=THM1(:,1);
    
    for i=1:m11
        THM1a(i,2)=max([ THM1(i,2)  THM1(i,3) ]);
    end
%%%    

    
    THM2a(:,1)=THM2(:,1);
    
    for i=1:m21
        THM2a(i,2)=max([ THM2(i,2)  THM2(i,3) ]);
    end    
%%%    

    t_string=sprintf('SRS Q=%g  %s\n Absolute',Q,skv);    
        
    ppp1=THM1a;
    ppp2=THM2a;
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
%%% 
    t_string=sprintf('srs Q=%g  %s\n Positive',Q,skv);
    
    ppp1=[THM1(:,1) THM1(:,2) ];
    ppp2=[THM2(:,1) THM2(:,2) ];
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
%%% 
    t_string=sprintf('SRS Q=%g  %s\n Negative',Q,skv);
    
    ppp1=[THM1(:,1) THM1(:,3) ];
    ppp2=[THM2(:,1) THM2(:,3) ];
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);               
               
%%% 

    t_string=sprintf('SRS Q=%g  %s',Q,qskv); 

    ppp1=[THM1(:,1) THM1(:,2) ];
    ppp2=[THM1(:,1) THM1(:,3) ];
    ppp3=[THM2(:,1) THM2(:,2) ];
    ppp4=[THM2(:,1) THM2(:,3) ];

    legg1=sprintf('%s pos',leg1);
    legg2=sprintf('%s neg',leg1); 
    legg3=sprintf('%s pos',leg2);
    legg4=sprintf('%s neg',leg2);      
    
    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,legg1,legg2,legg3,legg4,fmin,fmax,md);    
    
end    
    
%
if(psave==1)
        
        disp(' ');
        disp(' Plot file:');
        disp(' ');
    
        pname='srs_plot';
        
        out1=sprintf('   %s.png',pname);
        disp(out1);
    
        set(gca,'Fontsize',12);
        print(h,pname,'-dpng','-r300');
    
end      

pushbutton_save_Callback(hObject, eventdata, handles);


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



function edit_yaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_yaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_yaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_xaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_xaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xaxis_label (see GCBO)
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



function edit_end_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_end_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_end_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_start_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_start_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_start_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency_limits.
function listbox_frequency_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_limits
n=get(handles.listbox_frequency_limits,'Value');
 
if(n==1) % auto
    set(handles.text_start_frequency,'Visible','off');
    set(handles.text_end_frequency,'Visible','off');
    set(handles.edit_start_frequency,'Visible','off');
    set(handles.edit_end_frequency,'Visible','off');    
else % manual
    set(handles.text_start_frequency,'Visible','on');
    set(handles.text_end_frequency,'Visible','on');
    set(handles.edit_start_frequency,'Visible','on');
    set(handles.edit_end_frequency,'Visible','on');      
end


% --- Executes during object creation, after setting all properties.
function listbox_frequency_limits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_input_type.
function listbox_input_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_type


% --- Executes during object creation, after setting all properties.
function listbox_input_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_return_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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



function edit_leg1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_leg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_leg1 as text
%        str2double(get(hObject,'String')) returns contents of edit_leg1 as a double


% --- Executes during object creation, after setting all properties.
function edit_leg1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_leg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_leg2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_leg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_leg2 as text
%        str2double(get(hObject,'String')) returns contents of edit_leg2 as a double


% --- Executes during object creation, after setting all properties.
function edit_leg2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_leg2 (see GCBO)
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

try
    A=get(handles.uitable_data,'Data');
    PlotSaveMultipleSRS.A=A;   
catch
end
try
    num=get(handles.listbox_num,'Value');
    PlotSaveMultipleSRS.num=num;   
catch
end

try
   ny=get(handles.listbox_amplitude_limits,'value'); 
   PlotSaveMultipleSRS.ny=ny;
catch   
end    

try
    ymin=get(handles.edit_ymin','String');
    PlotSaveMultipleSRS.ymin=ymin;
catch    
end
try
    ymax=get(handles.edit_ymax','String');
    PlotSaveMultipleSRS.ymax=ymax; 
catch    
end


try
    listbox_input_type=get(handles.listbox_input_type,'Value');
    PlotSaveMultipleSRS.listbox_input_type=listbox_input_type;
catch    
end
try
    listbox_frequency_limits=get(handles.listbox_frequency_limits,'Value');
    PlotSaveMultipleSRS.listbox_frequency_limits=listbox_frequency_limits;
catch    
end
try
    listbox_50=get(handles.listbox_50,'Value');
    PlotSaveMultipleSRS.listbox_50=listbox_50;
catch    
end
try
    listbox_psave=get(handles.listbox_psave,'Value');
    PlotSaveMultipleSRS.listbox_psave=listbox_psave;
catch    
end
try
    listbox_work=get(handles.listbox_work,'Value');
    PlotSaveMultipleSRS.listbox_work=listbox_work;
catch    
end

%%%%%%%%%%%%%%%%

try
    title=get(handles.edit_title,'String');
    PlotSaveMultipleSRS.title=title;
catch    
end
try
    Q=get(handles.edit_Q,'String');
    PlotSaveMultipleSRS.Q=Q;
catch    
end
try
    yaxis_label=get(handles.edit_yaxis_label,'String');
    PlotSaveMultipleSRS.yaxis_label=yaxis_label;
catch    
end
try
    xaxis_label=get(handles.edit_xaxis_label,'String');
    PlotSaveMultipleSRS.xaxis_label=xaxis_label;
catch    
end
try
    start_frequency=get(handles.edit_start_frequency,'String');
    PlotSaveMultipleSRS.start_frequency=start_frequency;
catch    
end
try
    end_frequency=get(handles.edit_end_frequency,'String');
    PlotSaveMultipleSRS.end_frequency=end_frequency;
catch    
end


try
    array_name=getappdata(0,'array_name');
    
    if(num>=1)
        THM1=evalin('base',array_name{1});
        PlotSaveMultipleSRS.THM1=THM1;
        PlotSaveMultipleSRS.FS1=array_name{1};
    end
    if(num>=2)
        THM2=evalin('base',array_name{2});
        PlotSaveMultipleSRS.THM2=THM2;
        PlotSaveMultipleSRS.FS2=array_name{2};        
    end
    if(num>=3)
        THM3=evalin('base',array_name{3});
        PlotSaveMultipleSRS.THM3=THM3;
        PlotSaveMultipleSRS.FS3=array_name{3};           
    end    
    if(num>=4)
        THM4=evalin('base',array_name{4});
        PlotSaveMultipleSRS.THM4=THM4;
        PlotSaveMultipleSRS.FS4=array_name{4};           
    end      
catch
    warndlg('Save error');
    return;
end 



% % %
 
structnames = fieldnames(PlotSaveMultipleSRS, '-full'); % fields in the struct
 
% % %

try
   name=get(handles.edit_save_name,'String');
   PlotSaveMultipleSRS.name=name;   
catch
   warndlg('Enter plot output name');
   return;
end

if(isempty(name))
   warndlg('Enter plot output name');
   return;    
end
   
%%%   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
%%%    elk=sprintf('%s%s',writepname,writefname);

    name=strrep(name,'.mat','');
    name=strrep(name,'_plot','');    
    name=sprintf('%s_plot.mat',name);


    try
        save(name, 'PlotSaveMultipleSRS'); 
    catch
        warndlg('Save error');
        return;
    end
 
out1=sprintf('Save Complete: %s',name);
msgbox(out1);


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

[filename, pathname] = uigetfile('*_plot.mat', 'Select plot save file');
 
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
 
   PlotSaveMultipleSRS=evalin('base','PlotSaveMultipleSRS');
 
catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



try
   ny=PlotSaveMultipleSRS.ny;    
   set(handles.listbox_amplitude_limits,'value',ny); 
end    

try
    ymin=PlotSaveMultipleSRS.ymin;    
    set(handles.edit_ymin,'String',ymin);    
end
try
    ymax=PlotSaveMultipleSRS.ymax;    
    set(handles.edit_ymax,'String',ymax);  
end




try
    listbox_input_type=PlotSaveMultipleSRS.listbox_input_type;    
    set(handles.listbox_input_type,'Value',listbox_input_type);
end
try
    listbox_frequency_limits=PlotSaveMultipleSRS.listbox_frequency_limits;    
    set(handles.listbox_frequency_limits,'Value',listbox_frequency_limits);
end
try
    listbox_50=PlotSaveMultipleSRS.listbox_50;    
    set(handles.listbox_50,'Value',listbox_50);
end
try
    listbox_psave=PlotSaveMultipleSRS.listbox_psave;    
    set(handles.listbox_psave,'Value',listbox_psave);
end
try
    listbox_work=PlotSaveMultipleSRS.listbox_work;    
    set(handles.listbox_work,'Value',listbox_work);
end

%%%%%%%%%%%%%%%%

try
    title=PlotSaveMultipleSRS.title;    
    set(handles.edit_title,'String',title);
end
try
    Q=PlotSaveMultipleSRS.Q;    
    set(handles.edit_Q,'String',Q);
end
try
    yaxis_label=PlotSaveMultipleSRS.yaxis_label;    
    set(handles.edit_yaxis_label,'String',yaxis_label);
end
try
    xaxis_label=PlotSaveMultipleSRS.xaxis_label;    
    set(handles.edit_xaxis_label,'String',xaxis_label);
end
try
    start_frequency=PlotSaveMultipleSRS.start_frequency;    
    set(handles.edit_start_frequency,'String',start_frequency);
end
try
    end_frequency=PlotSaveMultipleSRS.end_frequency;    
    set(handles.edit_end_frequency,'String',end_frequency);
end


%%%

try
    A=PlotSaveMultipleSRS.A; 
    set(handles.uitable_data,'Data',A);
catch
end
try
    num=PlotSaveMultipleSRS.num;      
    set(handles.listbox_num,'Value',num); 
catch
end


try
    name=PlotSaveMultipleSRS.name;      
    set(handles.edit_save_name,'String',name); 
catch
end

listbox_num_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(PlotSaveMultipleSRS.FS1);
 
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
            THM1=PlotSaveMultipleSRS.THM1;
            assignin('base',FS1,THM1); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS2=strtrim(PlotSaveMultipleSRS.FS2);
 
    iflag=0;
    
    try
        temp=evalin('base',FS2);
        ss=sprintf('Replace %s with Previously Saved Array',FS2);
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
            THM2=PlotSaveMultipleSRS.THM2;
            assignin('base',FS2,THM2); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    FS3=strtrim(PlotSaveMultipleSRS.FS3);
 
    iflag=0;
    
    try
        temp=evalin('base',FS3);
        ss=sprintf('Replace %s with Previously Saved Array',FS3);
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
            THM3=PlotSaveMultipleSRS.THM3;
            assignin('base',FS3,THM3); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS4=strtrim(PlotSaveMultipleSRS.FS4);
 
    iflag=0;
    
    try
        temp=evalin('base',FS4);
        ss=sprintf('Replace %s with Previously Saved Array',FS4);
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
            THM4=PlotSaveMultipleSRS.THM4;
            assignin('base',FS4,THM4); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

listbox_frequency_limits_Callback(hObject, eventdata, handles);
listbox_amplitude_limits_Callback(hObject, eventdata, handles);


msgbox('Load Complete');

catch
    msgbox('Load Failed');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on selection change in listbox_50.
function listbox_50_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_50 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_50


% --- Executes during object creation, after setting all properties.
function listbox_50_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_work.
function listbox_work_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_work (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_work contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_work


% --- Executes during object creation, after setting all properties.
function listbox_work_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_work (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

try
    set(handles.uitable_data,'Data',data_s);
catch
end


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


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
if(Nrows>1)


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
