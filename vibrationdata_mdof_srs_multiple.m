function varargout = vibrationdata_mdof_srs_multiple(varargin)
% VIBRATIONDATA_MDOF_SRS_MULTIPLE MATLAB code for vibrationdata_mdof_srs_multiple.fig
%      VIBRATIONDATA_MDOF_SRS_MULTIPLE, by itself, creates a new VIBRATIONDATA_MDOF_SRS_MULTIPLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_MDOF_SRS_MULTIPLE returns the handle to a new VIBRATIONDATA_MDOF_SRS_MULTIPLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_MDOF_SRS_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_MDOF_SRS_MULTIPLE.M with the given input arguments.
%
%      VIBRATIONDATA_MDOF_SRS_MULTIPLE('Property','Value',...) creates a new VIBRATIONDATA_MDOF_SRS_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_mdof_srs_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_mdof_srs_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_mdof_srs_multiple

% Last Modified by GUIDE v2.5 28-Jan-2018 15:46:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_mdof_srs_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_mdof_srs_multiple_OutputFcn, ...
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


% --- Executes just before vibrationdata_mdof_srs_multiple is made visible.
function vibrationdata_mdof_srs_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_mdof_srs_multiple (see VARARGIN)

% Choose default command line output for vibrationdata_mdof_srs_multiple
handles.output = hObject;

listbox_num_srs_Callback(hObject, eventdata, handles);
listbox_num_modes_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_mdof_srs_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_mdof_srs_multiple_OutputFcn(hObject, eventdata, handles) 
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

disp('  ');
disp(' * * * * ');
disp('  ');

N=get(handles.listbox_num_srs,'Value');


B=get(handles.uitable_1,'Data');

A=char(B);

Q=zeros(N,1);

FS=A(1:N,:);

j=1;
for i=(N+1):(2*N)
    Q(j)=str2num(A(i,:));
    j=j+1;
end

for i=1:N-1
   if(Q(i)>Q(i+1))
       warndlg('The SRS specs must be in order of ascending Q');
       return;
   end
end

%%%%%

M=get(handles.listbox_num_modes,'Value');
BB=get(handles.uitable_2,'Data');

AA=char(BB);

fn=zeros(N,1);
QQ=zeros(N,1);
pf=zeros(N,1);
ev=zeros(N,1);

j=1;
for i=1:M
    fn(j)=str2num(AA(i,:));
    j=j+1;
end

j=1;
for i=(M+1):(2*M)
    QQ(j)=str2num(AA(i,:));
    j=j+1;
end

j=1;
for i=(2*M+1):(3*M)
    pf(j)=str2num(AA(i,:));
    j=j+1;
end

j=1;
for i=(3*M+1):(4*M)
    ev(j)=str2num(AA(i,:));
    j=j+1;
end

a=zeros(M,1);
a2=zeros(M,1);
accel=zeros(M,1);

srs_aa=zeros(M,N);

for j=1:N   % SRS spec 
    
    try
        spec=evalin('base',FS(j,:)); 
    catch
        out1=sprintf('%s  not found',spec);
        warndlg(out1);
        return;
    end
            
    sz=size(spec);
    P=sz(1);
    
    out1=sprintf('\n SRS Q=%g ',Q(j));
    disp(out1);
    disp('  fn(Hz)   Accel(G) ');
            
    for ii=1:P
        out1=sprintf(' %8.1f  %8.1f',spec(ii,1),spec(ii,2));
        disp(out1);
    end     
    

    for i=1:M  % mode
        
        if(fn(i)<spec(1,1))
                srs_aa(i,j)=spec(1,2);
        end
        
        for k=1:(P-1)
            
            f1=spec(k,1);
            f2=spec(k+1,1);
            a1=spec(k,2);
            a2=spec(k+1,2);
            
            if(fn(i)>=f1 && fn(i)<=f2);
                
                slope=log( a2/a1 )/log( f2/f1 );
                
                anew=a1*(fn(i)/f1)^slope;
                
%%                out1=sprintf('\nfn=%8.4g  f1=%8.4g f2=%8.4g a1=%8.4g a2=%8.4g n=%8.4g an=%8.4g',fn(i),f1,f2,a1,a2,slope,anew);
%%                disp(out1);
                
                srs_aa(i,j)=anew;
                break;
            end
        end
        
        if(fn(i)>spec(P,1))
                srs_aa(i,j)=spec(P,2);
        end
        
    end    
        
end

%%

disp(' ');

if(N==1)

    out1=sprintf('   fn            Q=%g  ',Q(1));
    disp(out1);     
            disp('   (Hz)         SRS(G)  ');

    for i=1:M
        out1=sprintf('% 8.4g \t %8.4g',fn(i),srs_aa(i,1));
        disp(out1);
    end
end
if(N==2)
    
    out1=sprintf('   fn            Q=%g        Q=%g  ',Q(1),Q(2));
    disp(out1);    
            disp('   (Hz)         SRS(G)      SRS(G)');    
    
    for i=1:M
        out1=sprintf('% 8.4g \t %8.4g \t %8.4g',fn(i),srs_aa(i,1),srs_aa(i,2));
        disp(out1);
    end    
end
if(N==3)
    
    out1=sprintf('   fn            Q=%g        Q=%g       Q=%g',Q(1),Q(2),Q(3));
    disp(out1);    
            disp('   (Hz)         SRS(G)      SRS(G)     SRS(G)');   
            
    for i=1:M
        out1=sprintf('% 8.4g \t %8.4g \t %8.4g \t %8.4g',fn(i),srs_aa(i,1),srs_aa(i,2),srs_aa(i,3));
        disp(out1);
    end        
end
if(N==4)
    
    out1=sprintf('   fn            Q=%g        Q=%g       Q=%g       Q=%g',Q(1),Q(2),Q(3),Q(4));
    disp(out1);    
            disp('   (Hz)         SRS(G)      SRS(G)     SRS(G)     SRS(G)');       
    
    for i=1:M
        out1=sprintf('% 8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g',fn(i),srs_aa(i,1),srs_aa(i,2),srs_aa(i,3),srs_aa(i,4));
        disp(out1);
    end     
end

%%

for i=1:M
    
    if(QQ(i)<Q(1))
        accel(i)=srs_aa(i,1);
    end
    
    if(N==1)
        
        accel(i)=srs_aa(i,1);
        
    else    
    
        for j=1:N-1
        
            if(QQ(i)>=Q(j) && QQ(i)<=Q(j+1))
            
                L=Q(j+1)-Q(j);
            
                x=QQ(i)-Q(j);
            
                c2=x/L;
                c1=1-c2;           
            
                accel(i)=c1*srs_aa(i,j)+  c2*srs_aa(i,j+1);
            
                break;
            
            end
        
        end
    
        if(QQ(i)>Q(N))
            accel(i)=srs_aa(i,N);
        end    
    
    end   
        
end    

disp(' ');
disp('    fn        Part          Eigen       SRS       Modal Response   ');
disp('   (Hz)       Factor        vector      Accel(G)     Accel(G)        ');

for i=1:M
   a(i)=abs(pf(i)*ev(i)*accel(i));
   a2(i)=a(i)^2;
   out1=sprintf('%8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g',fn(i),pf(i),ev(i),accel(i),a(i)); 
   disp(out1); 
end


out1=sprintf('\n ABSSUM=%8.4g G   SRSS=%8.4g G   \n',sum(a),sqrt(sum(a2)));
disp(out1);

msgbox('Results written to command window');




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_mdof_srs_multiple);


% --- Executes on selection change in listbox_num_srs.
function listbox_num_srs_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_srs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_srs

m=get(handles.listbox_num_srs,'Value');

for i = 1:m
   for j=1:2
      data_s{i,j} = '';     
   end 
end
set(handles.uitable_1,'Data',data_s);



% --- Executes during object creation, after setting all properties.
function listbox_num_srs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_modes.
function listbox_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_modes

m=get(handles.listbox_num_modes,'Value');

for i = 1:m
   for j=1:4
      data_s{i,j} = '';     
   end 
end



set(handles.uitable_2,'Data',data_s);



% --- Executes during object creation, after setting all properties.
function listbox_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
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
    B=get(handles.uitable_1,'Data');
    SRS_multiple.B=B;
catch    
end

try
    BB=get(handles.uitable_2,'Data');
    SRS_multiple.BB=BB;
catch    
end  

N=get(handles.listbox_num_srs,'Value');
SRS_multiple.N=N;

M=get(handles.listbox_num_modes,'Value');
SRS_multiple.M=M;

 
% % %
 
structnames = fieldnames(SRS_multiple, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'SRS_multiple'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
 
 
% Construct a questdlg with two options
choice = questdlg('Save Complete.  Reset Workspace?', ...
    'Options', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        disp([choice ' Reseting'])
        pushbutton_reset_Callback(hObject, eventdata, handles)
end  
 

function pushbutton_reset_Callback(hObject, eventdata, handles)

m=get(handles.listbox_num_srs,'Value');

for i = 1:m
   for j=1:2
      data_s{i,j} = '';     
   end 
end
set(handles.uitable_1,'Data',data_s);

m=get(handles.listbox_num_modes,'Value');

for i = 1:m
   for j=1:4
      data_s{i,j} = '';     
   end 
end
set(handles.uitable_2,'Data',data_s);



% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat');
 
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
 
   SRS_multiple=evalin('base','SRS_multiple');
 
catch
   warndlg(' evalin failed ');
   return;
end


try
    N=SRS_multiple.N;
    set(handles.listbox_num_srs,'Value',N);
catch
    warndlg(' N unsuccessful');
end    

try
    M=SRS_multiple.M;
    set(handles.listbox_num_modes,'Value',M);
catch
    warndlg(' M unsuccessful');    
end  

try
    B=SRS_multiple.B;
    set(handles.uitable_1,'Data',B);        
catch    
end

try
    BB=SRS_multiple.BB;
    set(handles.uitable_2,'Data',BB);    
catch    
end
