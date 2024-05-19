function varargout = subplots_alt(varargin)
% SUBPLOTS_ALT MATLAB code for subplots_alt.fig
%      SUBPLOTS_ALT, by itself, creates a new SUBPLOTS_ALT or raises the existing
%      singleton*.
%
%      H = SUBPLOTS_ALT returns the handle to a new SUBPLOTS_ALT or the handle to
%      the existing singleton*.
%
%      SUBPLOTS_ALT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUBPLOTS_ALT.M with the given input arguments.
%
%      SUBPLOTS_ALT('Property','Value',...) creates a new SUBPLOTS_ALT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before subplots_alt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to subplots_alt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help subplots_alt

% Last Modified by GUIDE v2.5 25-Jul-2019 18:00:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @subplots_alt_OpeningFcn, ...
                   'gui_OutputFcn',  @subplots_alt_OutputFcn, ...
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


% --- Executes just before subplots_alt is made visible.
function subplots_alt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to subplots_alt (see VARARGIN)

% Choose default command line output for subplots_alt
handles.output = hObject;

change_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes subplots_alt wait for user response (see UIRESUME)
% uiwait(handles.figure1);



function change_Callback(hObject, eventdata, handles)
%

R=get(handles.listbox_rows,'Value');
C=get(handles.listbox_columns,'Value');

num=R*C;

setappdata(0,'R',R);
setappdata(0,'C',C);
setappdata(0,'num',num);

Nrows=num;
Ncolumns=9;

%%%

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

data_s{1,1}='(1,1)'; 

%
if(R==1 && C==2)
    data_s{2,1}='(1,2)';    
end
if(R==2 && C==1)
    data_s{2,1}='(2,1)';    
end
%
if(R==2 && C==2)
    data_s{2,1}='(1,2)';
    data_s{3,1}='(2,1)';
    data_s{4,1}='(2,2)';    
end

if(R==3 && C==1)
    data_s{2,1}='(2,1)'; 
    data_s{3,1}='(3,1)';     
end
if(R==1 && C==3)
    data_s{2,1}='(1,2)'; 
    data_s{3,1}='(1,3)';     
end

if(R==3 && C==2)
    data_s{2,1}='(1,2)'; 
    data_s{3,1}='(2,1)';     
    data_s{4,1}='(2,2)';     
    data_s{5,1}='(3,2)';     
    data_s{6,1}='(3,2)';         
end
if(R==2 && C==3)
    data_s{2,1}='(1,2)'; 
    data_s{3,1}='(1,3)';     
    data_s{4,1}='(2,1)';     
    data_s{5,1}='(2,2)';     
    data_s{6,1}='(2,3)';         
end
if(R==2 && C==4)
    data_s{2,1}='(1,2)'; 
    data_s{3,1}='(1,3)';     
    data_s{4,1}='(1,4)';     
    data_s{5,1}='(2,1)';     
    data_s{6,1}='(2,2)';   
    data_s{7,1}='(2,3)';     
    data_s{8,1}='(2,4)';         
end
if(R==3 && C==3)
    data_s{2,1}='(1,2)'; 
    data_s{3,1}='(1,3)';     
    data_s{4,1}='(2,1)';     
    data_s{5,1}='(2,2)';     
    data_s{6,1}='(2,3)';   
    data_s{7,1}='(3,1)';     
    data_s{8,1}='(3,2)';     
    data_s{9,1}='(3,3)';    
end

set(handles.uitable_data,'Data',data_s);




% --- Outputs from this function are returned to the command line.
function varargout = subplots_alt_OutputFcn(hObject, eventdata, handles) 
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

delete(subplots_alt);


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * * * * * * * * * * * * * * * ');
disp(' ');

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R=getappdata(0,'R');
C=getappdata(0,'C');
num=getappdata(0,'num');
N=num;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
        
    k=1;

    for i=1:N
        position{i}=A(k,:); k=k+1;
        position{i} = strtrim(position{i});
    end 
    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
    end 
    for i=1:N
        tstring{i}=A(k,:); k=k+1;
        tstring{i} = strrep(tstring{i},'_',' ');
        tstring{i} = strtrim(tstring{i});
    end     
    for i=1:N
        xlab{i}=A(k,:); k=k+1;
        xlab{i} = strtrim(xlab{i});
    end  
    for i=1:N
        ylab{i}=A(k,:); k=k+1;
        ylab{i} = strtrim(ylab{i});
    end 
    for i=1:N
        x=A(k,:); k=k+1;
        xmin(i) = str2double(strtrim(x));
    end     
    for i=1:N
        x=A(k,:); k=k+1;
        xmax(i) = str2double(strtrim(x));
    end 
    for i=1:N
        y=A(k,:); k=k+1;
        ymin(i) = str2double(strtrim(y));
    end     
    for i=1:N
        y=A(k,:); k=k+1;
        ymax(i) = str2double(strtrim(y));
    end    
    
catch
    warndlg('Input Arrays read failed');
    return;
end

position
array_name

for i=1:N
    try
        FS=strtrim(array_name{i});
        q=evalin('base',FS);  
    catch
        out1=sprintf(' Array not found: %s',array_name{i});
        warndlg(out1);
        return; 
    end
    
    if(i==1)
        A1=q;
    end
    if(i==2)
        A2=q;
    end    
    if(i==3)
        A3=q;
    end        
    if(i==4)
        A4=q;
    end
    if(i==5)
        A5=q;
    end    
    if(i==6)
        A6=q;
    end    
    if(i==7)
        A7=q;
    end
    if(i==8)
        A8=q;
    end    
    if(i==9)
        A9=q;
    end        
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);

%
if(R==1 && C==1)
    plot(A1(:,1),A1(:,2));
    title(tstring{1});
    xlabel(xlab{1});
    ylabel(ylab{1});    
    axis([xmin(1) xmax(1) ymin(1) ymax(1)]);
    grid on;  
end
%
if(R==1 && C==2)
    subplot(1,2,1);
    plot(A1(:,1),A1(:,2));
    title(tstring{1});
    xlabel(xlab{1});
    ylabel(ylab{1});    
    axis([xmin(1) xmax(1) ymin(1) ymax(1)]);
    grid on;
  
    subplot(1,2,2);
    plot(A2(:,1),A2(:,2)); 
    title(tstring{2}); 
    xlabel(xlab{2});  
    ylabel(ylab{2});        
    axis([xmin(2) xmax(2) ymin(2) ymax(2)]);
    grid on;   
end
%
if(R==2 && C==1)

    subplot(2,1,1);
    plot(A1(:,1),A1(:,2));
    title(tstring{1});
    xlabel(xlab{1});
    ylabel(ylab{1});    
    axis([xmin(1) xmax(1) ymin(1) ymax(1)]);
    grid on;
  
    subplot(2,1,2);
    plot(A2(:,1),A2(:,2)); 
    title(tstring{2}); 
    xlabel(xlab{2});  
    ylabel(ylab{2});        
    axis([xmin(2) xmax(2) ymin(2) ymax(2)]);
    grid on;
    
end
%
if(R==2 && C==2)

    subplot(2,2,1);
    plot(A1(:,1),A1(:,2));
    title(tstring{1});
    xlabel(xlab{1});
    ylabel(ylab{1});    
    axis([xmin(1) xmax(1) ymin(1) ymax(1)]);
    grid on;
  
    subplot(2,2,2);
    plot(A2(:,1),A2(:,2)); 
    title(tstring{2}); 
    xlabel(xlab{2});  
    ylabel(ylab{2});        
    axis([xmin(2) xmax(2) ymin(2) ymax(2)]);
    grid on;  
    
    subplot(2,2,3);
    plot(A3(:,1),A3(:,2)); 
    title(tstring{3}); 
    xlabel(xlab{3});  
    ylabel(ylab{3});        
    axis([xmin(3) xmax(3) ymin(3) ymax(3)]);
    grid on;  
    
    subplot(2,2,4);
    plot(A4(:,1),A4(:,2)); 
    title(tstring{4}); 
    xlabel(xlab{4});  
    ylabel(ylab{4});        
    axis([xmin(4) xmax(4) ymin(4) ymax(4)]);
    grid on;      
end
if(R==1 && C==3)
    subplot(1,3,1);
    plot(A1(:,1),A1(:,2));
    title(tstring{1});
    xlabel(xlab{1});
    ylabel(ylab{1});    
    axis([xmin(1) xmax(1) ymin(1) ymax(1)]);
    grid on;
  
    subplot(1,3,2);
    plot(A2(:,1),A2(:,2)); 
    title(tstring{2}); 
    xlabel(xlab{2});  
    ylabel(ylab{2});        
    axis([xmin(2) xmax(2) ymin(2) ymax(2)]);
    grid on;
    
    subplot(1,3,3);
    plot(A3(:,1),A3(:,2)); 
    title(tstring{3}); 
    xlabel(xlab{3});  
    ylabel(ylab{3});        
    axis([xmin(3) xmax(3) ymin(3) ymax(3)]);
    grid on;      
end
if(R==3 && C==1)
    subplot(3,1,1);
    plot(A1(:,1),A1(:,2));
    title(tstring{1});
    xlabel(xlab{1});
    ylabel(ylab{1});    
    axis([xmin(1) xmax(1) ymin(1) ymax(1)]);
    grid on;
  
    subplot(3,1,2);
    plot(A2(:,1),A2(:,2)); 
    title(tstring{2}); 
    xlabel(xlab{2});  
    ylabel(ylab{2});        
    axis([xmin(2) xmax(2) ymin(2) ymax(2)]);
    grid on;
    
    subplot(3,1,3);
    plot(A3(:,1),A3(:,2)); 
    title(tstring{3}); 
    xlabel(xlab{3});  
    ylabel(ylab{3});        
    axis([xmin(3) xmax(3) ymin(3) ymax(3)]);
    grid on;   
end
if(R==2 && C==3)
    subplot(2,3,1);
    plot(A1(:,1),A1(:,2));
    title(tstring{1});
    xlabel(xlab{1});
    ylabel(ylab{1});    
    axis([xmin(1) xmax(1) ymin(1) ymax(1)]);
    grid on;
  
    subplot(2,3,2);
    plot(A2(:,1),A2(:,2)); 
    title(tstring{2}); 
    xlabel(xlab{2});  
    ylabel(ylab{2});        
    axis([xmin(2) xmax(2) ymin(2) ymax(2)]);
    grid on;  
    
    subplot(2,3,3);
    plot(A3(:,1),A3(:,2)); 
    title(tstring{3}); 
    xlabel(xlab{3});  
    ylabel(ylab{3});        
    axis([xmin(3) xmax(3) ymin(3) ymax(3)]);
    grid on;  
    
    subplot(2,3,4);
    plot(A4(:,1),A4(:,2)); 
    title(tstring{4}); 
    xlabel(xlab{4});  
    ylabel(ylab{4});        
    axis([xmin(4) xmax(4) ymin(4) ymax(4)]);
    grid on; 
    
    subplot(2,3,5);
    plot(A5(:,1),A5(:,2)); 
    title(tstring{5}); 
    xlabel(xlab{5});  
    ylabel(ylab{5});        
    axis([xmin(5) xmax(5) ymin(5) ymax(5)]);
    grid on;    
    
    subplot(2,3,6);
    plot(A6(:,1),A6(:,2)); 
    title(tstring{6}); 
    xlabel(xlab{6});  
    ylabel(ylab{6});        
    axis([xmin(6) xmax(6) ymin(6) ymax(6)]);
    grid on;        
end
if(R==2 && C==4)
   subplot(2,4,1);
    plot(A1(:,1),A1(:,2));
    title(tstring{1});
    xlabel(xlab{1});
    ylabel(ylab{1});    
    axis([xmin(1) xmax(1) ymin(1) ymax(1)]);
    grid on;
  
    subplot(2,4,2);
    plot(A2(:,1),A2(:,2)); 
    title(tstring{2}); 
    xlabel(xlab{2});  
    ylabel(ylab{2});        
    axis([xmin(2) xmax(2) ymin(2) ymax(2)]);
    grid on;  
    
    subplot(2,4,3);
    plot(A3(:,1),A3(:,2)); 
    title(tstring{3}); 
    xlabel(xlab{3});  
    ylabel(ylab{3});        
    axis([xmin(3) xmax(3) ymin(3) ymax(3)]);
    grid on;  
    
    subplot(2,4,4);
    plot(A4(:,1),A4(:,2)); 
    title(tstring{4}); 
    xlabel(xlab{4});  
    ylabel(ylab{4});        
    axis([xmin(4) xmax(4) ymin(4) ymax(4)]);
    grid on; 
    
    subplot(2,4,5);
    plot(A5(:,1),A5(:,2)); 
    title(tstring{5}); 
    xlabel(xlab{5});  
    ylabel(ylab{5});        
    axis([xmin(5) xmax(5) ymin(5) ymax(5)]);
    grid on;    
    
    subplot(2,4,6);
    plot(A6(:,1),A6(:,2)); 
    title(tstring{6}); 
    xlabel(xlab{6});  
    ylabel(ylab{6});        
    axis([xmin(6) xmax(6) ymin(6) ymax(6)]);
    grid on;   
    
    subplot(2,4,7);
    plot(A7(:,1),A7(:,2)); 
    title(tstring{7}); 
    xlabel(xlab{7});  
    ylabel(ylab{7});        
    axis([xmin(7) xmax(7) ymin(7) ymax(7)]);
    grid on;
    
    subplot(2,4,8);
    plot(A8(:,1),A8(:,2)); 
    title(tstring{8}); 
    xlabel(xlab{8});  
    ylabel(ylab{8});        
    axis([xmin(8) xmax(8) ymin(8) ymax(8)]);
    grid on;
    

end
if(R==3 && C==2)
    subplot(3,2,1);
    plot(A1(:,1),A1(:,2));
    title(tstring{1});
    xlabel(xlab{1});
    ylabel(ylab{1});    
    axis([xmin(1) xmax(1) ymin(1) ymax(1)]);
    grid on;
  
    subplot(3,2,2);
    plot(A2(:,1),A2(:,2)); 
    title(tstring{2}); 
    xlabel(xlab{2});  
    ylabel(ylab{2});        
    axis([xmin(2) xmax(2) ymin(2) ymax(2)]);
    grid on;  
    
    subplot(3,2,3);
    plot(A3(:,1),A3(:,2)); 
    title(tstring{3}); 
    xlabel(xlab{3});  
    ylabel(ylab{3});        
    axis([xmin(3) xmax(3) ymin(3) ymax(3)]);
    grid on;  
    
    subplot(3,2,4);
    plot(A4(:,1),A4(:,2)); 
    title(tstring{4}); 
    xlabel(xlab{4});  
    ylabel(ylab{4});        
    axis([xmin(4) xmax(4) ymin(4) ymax(4)]);
    grid on; 
    
    subplot(3,2,5);
    plot(A5(:,1),A5(:,2)); 
    title(tstring{5}); 
    xlabel(xlab{5});  
    ylabel(ylab{5});        
    axis([xmin(5) xmax(5) ymin(5) ymax(5)]);
    grid on;    
    
    subplot(3,2,6);
    plot(A6(:,1),A6(:,2)); 
    title(tstring{6}); 
    xlabel(xlab{6});  
    ylabel(ylab{6});        
    axis([xmin(6) xmax(6) ymin(6) ymax(6)]);
    grid on;   
end
if(R==3 && C==3)
    subplot(3,3,1);
    plot(A1(:,1),A1(:,2));
    title(tstring{1});
    xlabel(xlab{1});
    ylabel(ylab{1});    
    axis([xmin(1) xmax(1) ymin(1) ymax(1)]);
    grid on;
  
    subplot(3,3,2);
    plot(A2(:,1),A2(:,2)); 
    title(tstring{2}); 
    xlabel(xlab{2});  
    ylabel(ylab{2});        
    axis([xmin(2) xmax(2) ymin(2) ymax(2)]);
    grid on;  
    
    subplot(3,3,3);
    plot(A3(:,1),A3(:,2)); 
    title(tstring{3}); 
    xlabel(xlab{3});  
    ylabel(ylab{3});        
    axis([xmin(3) xmax(3) ymin(3) ymax(3)]);
    grid on;  
    
    subplot(3,3,4);
    plot(A4(:,1),A4(:,2)); 
    title(tstring{4}); 
    xlabel(xlab{4});  
    ylabel(ylab{4});        
    axis([xmin(4) xmax(4) ymin(4) ymax(4)]);
    grid on; 
    
    subplot(3,3,5);
    plot(A5(:,1),A5(:,2)); 
    title(tstring{5}); 
    xlabel(xlab{5});  
    ylabel(ylab{5});        
    axis([xmin(5) xmax(5) ymin(5) ymax(5)]);
    grid on;    
    
    subplot(3,3,6);
    plot(A6(:,1),A6(:,2)); 
    title(tstring{6}); 
    xlabel(xlab{6});  
    ylabel(ylab{6});        
    axis([xmin(6) xmax(6) ymin(6) ymax(6)]);
    grid on;   
    
    subplot(3,3,7);
    plot(A7(:,1),A7(:,2)); 
    title(tstring{7}); 
    xlabel(xlab{7});  
    ylabel(ylab{7});        
    axis([xmin(7) xmax(7) ymin(7) ymax(7)]);
    grid on;
    
    subplot(3,3,8);
    plot(A8(:,1),A8(:,2)); 
    title(tstring{8}); 
    xlabel(xlab{8});  
    ylabel(ylab{8});        
    axis([xmin(8) xmax(8) ymin(8) ymax(8)]);
    grid on;
    
    subplot(3,3,9);
    plot(A9(:,1),A9(:,2)); 
    title(tstring{9}); 
    xlabel(xlab{9});  
    ylabel(ylab{9});        
    axis([xmin(9) xmax(9) ymin(9) ymax(9)]);
    grid on;
end



% --- Executes on selection change in listbox_rows.
function listbox_rows_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_rows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_rows contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_rows
change_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_rows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_rows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_columns.
function listbox_columns_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_columns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_columns contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_columns
change_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_columns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_columns (see GCBO)
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

try
    R=get(handles.listbox_rows,'Value'); 
    SubplotsAlt.R=R;      
catch
end
try
    C=get(handles.listbox_columns,'Value'); 
    SubplotsAlt.C=C;      
catch
end

try
    A=get(handles.uitable_data,'Data');
    SubplotsAlt.A=A;      
catch
end

% % %
 
structnames = fieldnames(SubplotsAlt, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
        save(elk, 'SubplotsAlt'); 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');



% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




disp(' ref 1');
 
[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
disp(' ref 2');
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
disp(' ref 3');
 
structnames
 
 
% struct
 
try
    SubplotsAlt=evalin('base','SubplotsAlt');
catch
    warndlg(' evalin failed ');
    return;
end


try
    R=SubplotsAlt.R;      
    set(handles.listbox_rows,'Value',R);     
catch
end
try
    C=SubplotsAlt.C;      
    set(handles.listbox_columns,'Value',C);     
catch
end

try
    A=SubplotsAlt.A;
    set(handles.uitable_data,'Data',A);    
catch
end


num=R*C;

setappdata(0,'R',R);
setappdata(0,'C',C);
setappdata(0,'num',num);
