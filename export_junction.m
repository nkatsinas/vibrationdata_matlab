function varargout = export_junction(varargin)
% EXPORT_JUNCTION MATLAB code for export_junction.fig
%      EXPORT_JUNCTION, by itself, creates a new EXPORT_JUNCTION or raises the existing
%      singleton*.
%
%      H = EXPORT_JUNCTION returns the handle to a new EXPORT_JUNCTION or the handle to
%      the existing singleton*.
%
%      EXPORT_JUNCTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPORT_JUNCTION.M with the given input arguments.
%
%      EXPORT_JUNCTION('Property','Value',...) creates a new EXPORT_JUNCTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before export_junction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to export_junction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help export_junction

% Last Modified by GUIDE v2.5 19-Apr-2018 17:36:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @export_junction_OpeningFcn, ...
                   'gui_OutputFcn',  @export_junction_OutputFcn, ...
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


% --- Executes just before export_junction is made visible.
function export_junction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to export_junction (see VARARGIN)

% Choose default command line output for export_junction
handles.output = hObject;

set(handles.listbox_format,'Value',1);

try
    n=getappdata(0,'nastran_srs');
    if(n==1)
        set(handles.listbox_format,'Value',4);
    end    
catch
end

listbox_format_Callback(hObject, eventdata, handles);
listbox_scale_Callback(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes export_junction wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = export_junction_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format

n=get(handles.listbox_format,'Value');

if(n==3 || n==4 || n==5)
    set(handles.uipanel_scale,'Visible','on');       
else
    set(handles.uipanel_scale,'Visible','off');    
end

if(n==3)
    set(handles.text_step,'Visible','off');
    set(handles.edit_step,'Visible','off');    
else
    set(handles.text_step,'Visible','on');
    set(handles.edit_step,'Visible','on');     
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


% --- Executes on button press in pushbutton_perform.
function pushbutton_perform_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_perform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp('  ');
disp(' * * * * * * ');
disp('  ');

n=get(handles.listbox_format,'Value');

try
    FS=get(handles.edit_matlab_name,'String');
    av=evalin('base',FS);
catch
    warndlg('Matlab array does not exist');
    return 
end


vname=@(x) inputname(1);
sname=vname(av);


if(n==1) % ascii
    
    [writefname, writepname] = uiputfile('*','Save data as');
    writepfname = fullfile(writepname, writefname);
    fid = fopen(writepfname,'w');

    sz=size(av);

    nrow=sz(1);
    ncol=sz(2);

    progressbar;  
    if(ncol==1)
        for i=1:nrow
            progressbar(i/nrow);
            fprintf(fid,' %14.7e \n',av(i));        
        end    
    end
    if(ncol==2)
        for i=1:nrow
            progressbar(i/nrow);            
            fprintf(fid,' %14.7e \t %g \n',av(i,1),av(i,2));       
        end  
    end
    if(ncol==3)
        for i=1:nrow
            progressbar(i/nrow);            
            fprintf(fid,' %14.7e \t %g \t %g \n',av(i,1),av(i,2),av(i,3));         
        end  
    end
    if(ncol==4)
        for i=1:nrow
            progressbar(i/nrow);            
            fprintf(fid,' %14.7e \t %g \t %g \t %g \n',av(i,1),av(i,2),av(i,3),av(i,4));         
        end  
    end  
    if(ncol==5)
        for i=1:nrow
            progressbar(i/nrow);            
            fprintf(fid,' %14.7e \t %g \t %g \t %g \t %g \n',av(i,1),av(i,2),av(i,3),av(i,4),av(i,5));         
        end  
    end     

    pause(0.3);
    progressbar(1);
    
    fclose(fid);
  
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(n==2)  % excel
    sz=size(av);

    nrow=sz(1);
    ncol=sz(2);
    
    [writefname, writepname] = uiputfile('*.xls','Save model as Excel file');
    writepfname = fullfile(writepname, writefname);
    
    c=[num2cell(av)]; % 1 element/cell
    xlswrite(writepfname,c);
 
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%
if(n==3 || n==4 || n==5) % nastran time history
    
    np=get(handles.listbox_precision,'Value');

    [writefname, writepname] = uiputfile('*','Save data as');
    writepfname = fullfile(writepname, writefname);
    fid = fopen(writepfname,'w');
    
    nscale=get(handles.listbox_scale,'Value');
    
    if(nscale==1)
        try
            scale=str2num(get(handles.edit_scale,'String'));
        catch
            warndlg(' Enter scale factor ');
            return; 
        end
    end    

    function_num=get(handles.listbox_function_num,'Value');
    
end

if(n==3) % nastran time history
    
    t=av(:,1);
    a=av(:,2);
   
    if(nscale==1)
        a=a*scale;
    end
    
    sz=size(av);
    n=sz(1);

    for i=1:n
        if(abs(a(i))<=0.0001 )  
            a(i)=0.;
        end
    end
    
    dt=(t(n)-t(1))/(n-1);
%    
    for i=1:n
        t(i)=dt*(i-1);
    end    
%
%  type=1  SOL SEMTRAN 
%      =2  SOL SEMODES
%

    type=1;
    
    num=get(handles.listbox_function_num,'Value');

    if(np==1)
        [~]=sp_nastran_export_num(n,t,a,fid,num,type);    
    else
        [~]=dp_nastran_export_num(n,t,a,fid,num,type);        
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%

if(n==4 || n==5) % nastran response spectrum or PSD

    df=str2num(get(handles.edit_step,'String'));
    
    if(isempty(df))
        warndlg(' Enter frequency step');
        return;
    end    
    
    f=av(:,1);
    a=av(:,2);
   
    if(nscale==1)
        if(n==4)
            a=a*scale;
        else
            a=a*scale^2;
        end
    end
    
    sz=size(av);
    num=sz(1);
      
%%  

%    m=floor((f(n)-f(1))/df);    
    
%    out1=sprintf('n=%d m=%d',n,m);
%    disp(out1);
    

%    for i=1:m

    i=0;

    while(1)
        
         i=i+1;
        
         new_freq=f(1)+df*(i-1);
        
         if(new_freq>f(num)) 
            break;
         end

         fff(i)=new_freq;

         
         
         for j=1:(num-1)
             if(fff(i)==f(j))
                 aaa(i)=a(j);
                 break;
             end
             if(fff(i)>f(j) && fff(i)<f(j+1))
                 slope=log(a(j+1)/a(j))/log(f(j+1)/f(j));
                 term=fff(i)/f(j);
                 aaa(i)=a(j)*term^slope;
                 break;
             end
             if( fff(i)==f(j+1))
                 aaa(i)=a(j+1); 
                 break;
             end             
         end
        
    end
    
    m=length(fff);
   
    if(fff(m)<f(num))
         fff(m)=f(num);
         aaa(m)=a(num);
    end    
    
%%

    clear a;
    a=aaa;
    clear f;
    f=fff;
    num=length(fff);

    for i=1:num
        if(abs(a(i))<=0.0001 )  
            a(i)=0.;
        end
    end

    type=2; 
    
    length(a)
    length(f)
%

    if(type==1)
        if(np==1)
            [~]=sp_nastran_export(num,t,a,fid);    
        else
            [~]=dp_nastran_export(num,t,a,fid);        
        end
    end
    if(type==2)
        if(np==1)
            [~]=sp_nastran_export_num(num,f,a,fid,function_num,type);    
        else
            [~]=dp_nastran_export_num(num,f,a,fid,function_num,type);        
        end
    end
%



    fff=fix_size(fff);
    aaa=fix_size(aaa);
          
    if(n==4)
        
        assignin('base', 'interpolated_srs',[fff aaa]);
        
        disp(' ');
        disp(' output array:  interpolated_srs ');
        disp(' ');        
        
    else     
        
        assignin('base', 'interpolated_psd',[fff aaa]);
        
        disp(' ');
        disp(' output array:  interpolated_psd ');
        disp(' ');
        
    end

end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
if(n==6) % mat
    
    [writefname, writepname] = uiputfile('*.mat','Save data as');
    writepfname = fullfile(writepname, writefname);
    
    
    pattern = '.mat';
    replacement = '';
    sname=regexprep(writefname,pattern,replacement);
    ss=sprintf('%s',sname);
    ss1=sprintf('%s',sname);
      

    FS2=strtrim(get(handles.edit_matlab_name,'String'))        
    FS2=evalin('base',FS2);
    
    size(FS2);
    
    out1=sprintf('%s=FS2;',ss);
    
    clear ss;
    
    eval(out1);
    
    elk=sprintf('%s%s',writepname,writefname);
    
    save(elk,ss1); 
 
end
%
%
%%%%%
%
h = msgbox('Export Complete.  Press Return. ');   



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(export_junction);



function edit_matlab_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_matlab_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_matlab_name as text
%        str2double(get(hObject,'String')) returns contents of edit_matlab_name as a double


% --- Executes during object creation, after setting all properties.
function edit_matlab_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_matlab_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_scale.
function listbox_scale_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scale contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scale

n=get(handles.listbox_scale,'Value');

if(n==1)
    set(handles.text_scale,'Visible','on');
    set(handles.edit_scale,'Visible','on');
else
    set(handles.text_scale,'Visible','off');
    set(handles.edit_scale,'Visible','off');    
end

% --- Executes during object creation, after setting all properties.
function listbox_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale as text
%        str2double(get(hObject,'String')) returns contents of edit_scale as a double


% --- Executes during object creation, after setting all properties.
function edit_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_precision.
function listbox_precision_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_precision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_precision contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_precision


% --- Executes during object creation, after setting all properties.
function listbox_precision_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_precision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_function_num.
function listbox_function_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_function_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_function_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_function_num


% --- Executes during object creation, after setting all properties.
function listbox_function_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_function_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_step as text
%        str2double(get(hObject,'String')) returns contents of edit_step as a double


% --- Executes during object creation, after setting all properties.
function edit_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
