function varargout = multiaxis_rainflow(varargin)
% MULTIAXIS_RAINFLOW MATLAB code for multiaxis_rainflow.fig
%      MULTIAXIS_RAINFLOW, by itself, creates a new MULTIAXIS_RAINFLOW or raises the existing
%      singleton*.
%
%      H = MULTIAXIS_RAINFLOW returns the handle to a new MULTIAXIS_RAINFLOW or the handle to
%      the existing singleton*.
%
%      MULTIAXIS_RAINFLOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIAXIS_RAINFLOW.M with the given input arguments.
%
%      MULTIAXIS_RAINFLOW('Property','Value',...) creates a new MULTIAXIS_RAINFLOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multiaxis_rainflow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multiaxis_rainflow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multiaxis_rainflow

% Last Modified by GUIDE v2.5 09-Mar-2015 16:06:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multiaxis_rainflow_OpeningFcn, ...
                   'gui_OutputFcn',  @multiaxis_rainflow_OutputFcn, ...
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


% --- Executes just before multiaxis_rainflow is made visible.
function multiaxis_rainflow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multiaxis_rainflow (see VARARGIN)

% Choose default command line output for multiaxis_rainflow
handles.output = hObject;

set(handles.uibuttongroup_csv,'Visible','off');
set(handles.uibuttongroup_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes multiaxis_rainflow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = multiaxis_rainflow_OutputFcn(hObject, eventdata, handles) 
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

delete(multiaxis_rainflow);



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


% --- Executes on button press in pushbutton_save_table.
function pushbutton_save_table_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

BIG=getappdata(0,'BIG');
columnname=getappdata(0,'columnname');

FileName = uiputfile;

% csvwrite(FileName,columnname);

fid = fopen(FileName,'wt');
fprintf(fid, '%s,',columnname{:});
fprintf(fid, '\n');
fclose(fid);

dlmwrite (FileName, BIG, '-append');

h = msgbox('Save Complete'); 





% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'amp_cycles_r'); 
end
if(n==2)
    data=getappdata(0,'range_cycles_r');  
end
if(n==3)
    data=getappdata(0,'combined');  
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


% --- Executes on selection change in listbox_output_type.
function listbox_output_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_type


% --- Executes during object creation, after setting all properties.
function listbox_output_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_numerical_engine.
function listbox_numerical_engine_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numerical_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numerical_engine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numerical_engine


% --- Executes during object creation, after setting all properties.
function listbox_numerical_engine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numerical_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rng('default');

thu=get(handles.edit_input_array,'String');

if isempty(thu)
    warndlg('Time history does not exist');
    return;
else
    THM=evalin('base',thu);    
end

t=THM(:,1);

num_eng=get(handles.listbox_numerical_engine,'Value');

b=str2num(get(handles.edit_b,'String'));

YS=get(handles.edit_ylabel,'String');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(THM);

if(sz(2)>sz(1))
    warndlg('Number of columns exceeds rows');
end

num_rows=sz(1);
num_cols=sz(2)-1;

NT=str2num(get(handles.edit_NT,'String'));

drec=0;


disp('  ');
disp('           relative   ');
disp(' trial      damage     c coefficients ');
progressbar;

for i=1:NT
    
    progressbar(i/NT);
    
    if(i< round(NT/10) || rand()>0.3 )
        c=rand(num_cols,1);
        c=c-0.5;
    else
        for k=1:num_cols
            c(k)=cr(k)*(0.98+0.04*rand());
        end        
    end
    
    c=c/norm(c);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    yc=zeros(num_rows,1);

    for j=1:num_rows
        for k=1:num_cols
            yc(j)=yc(j)+c(k)*THM(j,k+1);
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%    

    if(num_eng==1)
        [range_cycles,L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak]=...
                                     vibrationdata_ma_rainflow_function(yc);
        amp_cycles=[range_cycles(:,1)/2 range_cycles(:,2)];
    else
%
        dchoice=-1.; % needs to be double
%
        exponent=1;
% 
        [L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak,D,ac1,ac2,cL]...
                                         =rainflow_mex(yc,dchoice,exponent);
%
        sz=size(ac1);
        if(sz(2)>sz(1))
            ac1=ac1';
            ac2=ac2';
        end
%
        ncL=int64(cL);
%
        amp_cycles=[ ac1(1:ncL) ac2(1:ncL) ];
        range_cycles=[2*amp_cycles(:,1) amp_cycles(:,2)];
%
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
    damage=0;
    
    sz=size(range_cycles);

    for iv=1:sz(1)
        damage=damage+range_cycles(iv,2)*( 0.5*range_cycles(iv,1) )^b;
    end    


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(damage>drec)
       cr=c; 
       ycr=yc; 
       
       amp_cycles_r=amp_cycles;
       range_cycles_r=range_cycles;       
       
       drec=damage;
       
 
       r_L=L;
       r_C=C;
       r_AverageAmp=AverageAmp;
       r_MaxAmp=MaxAmp;
       r_MinMean=MinMean;
       r_AverageMean=AverageMean;
       r_MaxMean=MaxMean;
       r_MinValley=MinValley;
       r_MaxPeak=MaxPeak;

       
       iflag=0;
       
       if(num_cols==1)
            out1=sprintf('    %d    %8.3e   %6.3g ',i,drec,c(1));
            iflag=1;
       end
       if(num_cols==2)
            out1=sprintf('    %d    %8.3e   %6.3g %6.3g ',i,drec,c(1),c(2));
            iflag=1;            
       end
       if(num_cols==3)
            out1=sprintf('    %d    %8.3e   %6.3g %6.3g %6.3g ',i,drec,c(1),c(2),c(3));
            iflag=1;            
       end
       if(num_cols==4)
            out1=sprintf('    %d    %8.3e   %6.3g %6.3g %6.3g %6.3g ',i,drec,c(1),c(2),c(3),c(4));
            iflag=1;            
       end
       if(num_cols==5)
            out1=sprintf('    %d    %8.3e   %6.3g %6.3g %6.3g %6.3g %6.3g ',i,drec,c(1),c(2),c(3),c(4),c(5));
            iflag=1;            
       end
       if(num_cols==6)
            out1=sprintf('    %d    %8.3e   %6.3g %6.3g %6.3g %6.3g %6.3g %6.3g ',i,drec,c(1),c(2),c(3),c(4),c(5),c(6));
            iflag=1;            
       end
       
       if(iflag==0)
            out1=sprintf(' %d  %8.4g ',i,drec);                
       end
       
       disp(out1);
            
    end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
pause(0.5);

disp(' ');
disp(' Optimum Case Coefficients ');
cr

disp(' ');
out1=sprintf(' Norm of Coefficients = %g',norm(cr));
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);
plot(t,yc);
grid on;
ylabel(YS);
xlabel('Time (sec)');
title('Equivalent Uniaxial Time History');


disp(' ');
disp(' Equivalent Uniaxial Time History Statistics ');
disp(' ');
out1=sprintf('  max=%8.4g  min=%8.4g  std dev=%8.4g',max(yc),min(yc),std(yc));
disp(out1);

combined=[t ycr];

setappdata(0,'combined',combined);
setappdata(0,'amp_cycles_r',amp_cycles_r);
setappdata(0,'range_cycles_r',range_cycles_r);



set(handles.uibuttongroup_csv,'Visible','on');
set(handles.uibuttongroup_save,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ndf=1;
    
    L=r_L;
    C=r_C;
    AverageAmp=r_AverageAmp;
    MaxAmp=r_MaxAmp;
    MinMean=r_MinMean;
    AverageMean=r_AverageMean;
    MaxMean=r_MaxMean;
    MinValley=r_MinValley;
    MaxPeak=r_MaxPeak;    
   
    L=flipud(L);
    C=flipud(C);
    AverageAmp=flipud(AverageAmp);
    MaxAmp=flipud(MaxAmp);
    MinMean=flipud(MinMean);    
    AverageMean=flipud(AverageMean);
    MaxMean=flipud(MaxMean);    
    MinValley=flipud(MinValley);
    MaxPeak=flipud(MaxPeak);
%
    clear BIG;
%
    N=max(size(C));
%
    ijk=1;
    for i=1:N-1
      if( abs(L(i))>1.0e-09 && abs(L(i+1))>1.0e-09)
          ijk=ijk+1;
      end
    end
    N=ijk;
%
    BIG=zeros(N,8);
%
%%    MaxAmp=MaxAmp/2;
%%    AverageAmp=AverageAmp/2;
%
    for j=1:N
%
      if(C(j)==0)
         AverageAmp(j)=0.;
         MaxAmp(j)=0.; 
         MinMean(j)=0.;         
         AverageMean(j)=0.;
         MaxMean(j)=0.;         
         MinValley(j)=0.;
         MaxPeak(j)=0.; 
      end
%
      BIG(j,1)=L(j+1);
      BIG(j,2)=L(j);
      BIG(j,3)=C(j);
      BIG(j,4)=AverageAmp(j);
      BIG(j,5)=MaxAmp(j);
      BIG(j,6)=MinMean(j);
      BIG(j,7)=AverageMean(j);      
      BIG(j,8)=MaxMean(j);
      BIG(j,9)=MinValley(j); 
      BIG(j,10)=MaxPeak(j);   
    end      
%
    if(ndf==1)
%        
        ylabel(YS)
        grid on;
%
        figure(2);
        h=bar(C);
        grid on;
        title('Rainflow');
        ylabel('Cycle Counts');
        xlabel('Range');
%
    end


setappdata(0,'BIG',BIG); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ndt=1;

if(ndt==1)
%
    figure(3)
    hFig = figure(3);
    xwidth=900;
    ywidth=400;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{27})

    dat =  BIG(:,1:10);
    columnname =   {'Lower Range','Upper Range','Cycles','Ave Amp',...
       'Max Amp','Min Mean','Ave Mean','Max Mean','Min Valley','Max Peak' };
    columnformat = {'numeric', 'numeric','numeric','numeric','numeric',...
       'numeric','numeric','numeric','numeric','numeric'};
    columneditable = [false false false false false false false false false false];   

    sz=size(BIG);
%
    for i = 1:sz(1)
        for j=1:sz(2)
            if(j==3)
                tempStr = sprintf('%10.1f', dat(i,j));                
            else
                tempStr = sprintf('%7.3g', dat(i,j));
            end    
            data_s{i,j} = tempStr;     
        end  
    end
%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'RowName',[]);
%
    setappdata(0,'columnname',columnname); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
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



function edit_NT_Callback(hObject, eventdata, handles)
% hObject    handle to edit_NT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_NT as text
%        str2double(get(hObject,'String')) returns contents of edit_NT as a double


% --- Executes during object creation, after setting all properties.
function edit_NT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_NT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
