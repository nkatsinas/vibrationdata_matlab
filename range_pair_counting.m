function varargout = range_pair_counting(varargin)
% RANGE_PAIR_COUNTING MATLAB code for range_pair_counting.fig
%      RANGE_PAIR_COUNTING, by itself, creates a new RANGE_PAIR_COUNTING or raises the existing
%      singleton*.
%
%      H = RANGE_PAIR_COUNTING returns the handle to a new RANGE_PAIR_COUNTING or the handle to
%      the existing singleton*.
%
%      RANGE_PAIR_COUNTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RANGE_PAIR_COUNTING.M with the given input arguments.
%
%      RANGE_PAIR_COUNTING('Property','Value',...) creates a new RANGE_PAIR_COUNTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before range_pair_counting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to range_pair_counting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help range_pair_counting

% Last Modified by GUIDE v2.5 28-Aug-2015 10:08:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @range_pair_counting_OpeningFcn, ...
                   'gui_OutputFcn',  @range_pair_counting_OutputFcn, ...
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


% --- Executes just before range_pair_counting is made visible.
function range_pair_counting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to range_pair_counting (see VARARGIN)

% Choose default command line output for range_pair_counting
handles.output = hObject;

clear(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes range_pair_counting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = range_pair_counting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double
clear(hObject, eventdata, handles);

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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% b=str2num(get(handles.edit_b,'String'));

ndt=get(handles.listbox_display_table,'Value');

ndf=get(handles.listbox_display_figures,'Value');


YS=get(handles.edit_ylabel,'String');

try
    FS=get(handles.edit_input_array_name,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found');
    return; 
end
    
THM=fix_size(THM);
THM_hold=THM;

sz=size(THM);

dur=0.;

if(sz(2)==1)
    y=THM(:,1);
    m=length(y)-1;
else    
    y=THM(:,2);
    m=length(y)-1;
    dur=THM(m,1)-THM(1,1);
end

dchoice=1.;
exponent=1;


[L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak,D,ac1,ac2,amean,cL]...
                                               =range_pair_mex(y,dchoice,exponent);
                                 
%
sz=size(ac1);
if(sz(2)>sz(1))
     ac1=ac1';
     ac2=ac2';
end
%
ncL=int64(cL);
%
     amp_cycles=[ ac1(1:ncL) ac2(1:ncL)   ]; 
amp_mean_cycles=[ ac1(1:ncL) amean(1:ncL) ac2(1:ncL) ];  
   range_cycles=[ 2*ac1(1:ncL) ac2(1:ncL) ]; 

aamax=max(amp_cycles(1,:));

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
  rv=2;
%
  N=max(size(C));
  BIG=zeros(N,10);
  disp(' ');
  disp('  Amplitude = (peak-valley)/2 ');
  disp(' ');
  disp('        Range Limits         Cycle      Average     Max      Min     Average   Max   Min     Max ');
  disp('          (units)            Counts      Amp        Amp      Mean     Mean     Mean  Valley  Peak');
%
  MaxAmp=MaxAmp/2;
  AverageAmp=AverageAmp/2;
%
  for i=1:N
      j=N+1-i;
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
      if(rv==2)
          out1=sprintf('\t %7.4g to %7.4g \t %g \t %6.3g \t %6.3g \t %6.3g\t %6.3g\t %6.3g\t %6.3g\t %6.3g',L(j),L(j+1),C(j),AverageAmp(j),MaxAmp(j),MinMean(j),AverageMean(j),MaxMean(j),MinValley(j),MaxPeak(j));
      else
          out1=sprintf('\t %7.4g to %7.4g \t %g \t %6.3g \t %6.3g \t %6.3g\t %6.3g\t %6.3g\t %6.3g\t %6.3g',L(j),L(j+1),round(C(j)),round(AverageAmp(j)),round(MaxAmp(j)),round(MinMean(j)),round(AverageMean(j)),round(MaxMean(j)),round(MinValley(j)),round(MaxPeak(j)));
      end
      disp(out1);
      BIG(i,1)=L(j);
      BIG(i,2)=L(j+1);
      BIG(i,3)=C(j);
      BIG(i,4)=AverageAmp(j);
      BIG(i,5)=MaxAmp(j);
      BIG(i,6)=MinMean(j);      
      BIG(i,7)=AverageMean(j);
      BIG(i,8)=MaxMean(j);   
      BIG(i,9)=MinValley(j); 
      BIG(i,10)=MaxPeak(j);   
  end  
%
out1=sprintf('\n  Max Range=%6.3g ',aamax);
disp(out1);
%
TC=sum(C);
if(rv==2)
   out1=sprintf('\n Total Cycles =%g \n',TC);
else
   out1=sprintf('\n Total Cycles =%g \n',round(TC));   
end
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


if(ndf==1)
    
    sz=size(THM_hold);
    
    figure(1);
%
    if(sz(2)==2)
        plot(THM_hold(:,1),THM_hold(:,2));
        xlabel('Time (sec)');
    else
        plot(THM_hold(:,1));    
    end
%
    grid on;

    ylabel(YS);
    title('Input Time History');
%
    figure(2);
    h=bar(C);
    grid on;
    title('Rainflow');
    ylabel('Cycle Counts');
    xlabel('Range');
%
end  
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

if(ndt==1)
%
    set(handles.uibuttongroup_table,'Visible','on'); 
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

assignin('base', 'range_cycles', range_cycles);

sz=size(range_cycles);

if(sz(1)<=14)
    
   range_cycles=sortrows(range_cycles,1);
   range_cycles=flipud(range_cycles);

   disp(' ');
   disp('     Range  Cycles ');
    
   for i=1:sz(1) 
        out1=sprintf(' %8.4g   %g',range_cycles(i,1),range_cycles(i,2));
        disp(out1);
   end
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'amp_cycles',amp_cycles); 
setappdata(0,'amp_mean_cycles',amp_mean_cycles); 
setappdata(0,'range_cycles',range_cycles);  
setappdata(0,'BIG',BIG); 


set(handles.uibuttongroup_save,'Visible','on');
set(handles.uipanel_relative_damage,'Visible','on');    



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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(range_pair_counting);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'amp_cycles'); 
end
if(n==2)
    data=getappdata(0,'amp_mean_cycles');     
end
if(n==3)
    data=getappdata(0,'range_cycles');  
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

set(handles.uipanel_miners,'Visible','on');

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


function clear(hObject, eventdata, handles)

set(handles.uibuttongroup_save,'Visible','off');
set(handles.uipanel_relative_damage,'Visible','off'); 
set(handles.uibuttongroup_table,'Visible','off'); 
set(handles.uipanel_miners,'Visible','off');

set(handles.edit_damage_result,'String','');


% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear(hObject, eventdata, handles);

% --- Executes on selection change in listbox_display_figures.
function listbox_display_figures_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_display_figures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_display_figures contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_display_figures


% --- Executes during object creation, after setting all properties.
function listbox_display_figures_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_display_figures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_display_table.
function listbox_display_table_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_display_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_display_table contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_display_table


% --- Executes during object creation, after setting all properties.
function listbox_display_table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_display_table (see GCBO)
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



function edit_exponent_Callback(hObject, eventdata, handles)
% hObject    handle to edit_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_exponent as text
%        str2double(get(hObject,'String')) returns contents of edit_exponent as a double


% --- Executes during object creation, after setting all properties.
function edit_exponent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate_damage.
function pushbutton_calculate_damage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate_damage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

b=str2num(get(handles.edit_exponent,'String'));

range_cycles=getappdata(0,'range_cycles');  

D=0;

sz=size(range_cycles);

for i=1:sz(1)
    D=D+range_cycles(i,2)*( 0.5*range_cycles(i,1) )^b;
end    

string=sprintf('%8.4g',D);

set(handles.edit_damage_result,'String',string);


function edit_damage_result_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damage_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damage_result as text
%        str2double(get(hObject,'String')) returns contents of edit_damage_result as a double


% --- Executes during object creation, after setting all properties.
function edit_damage_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damage_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on button press in pushbutton_miners.
function pushbutton_miners_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_miners (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_miners;    
 
set(handles.s,'Visible','on'); 


% --- Executes on key press with focus on edit_ylabel and none of its controls.
function edit_ylabel_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function uibuttongroup_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
