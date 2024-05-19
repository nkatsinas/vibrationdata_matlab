function varargout = modal_curve_fit(varargin)
% MODAL_CURVE_FIT MATLAB code for modal_curve_fit.fig
%      MODAL_CURVE_FIT, by itself, creates a new MODAL_CURVE_FIT or raises the existing
%      singleton*.
%
%      H = MODAL_CURVE_FIT returns the handle to a new MODAL_CURVE_FIT or the handle to
%      the existing singleton*.
%
%      MODAL_CURVE_FIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODAL_CURVE_FIT.M with the given input arguments.
%
%      MODAL_CURVE_FIT('Property','Value',...) creates a new MODAL_CURVE_FIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modal_curve_fit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modal_curve_fit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modal_curve_fit

% Last Modified by GUIDE v2.5 05-Nov-2020 05:32:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modal_curve_fit_OpeningFcn, ...
                   'gui_OutputFcn',  @modal_curve_fit_OutputFcn, ...
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


% --- Executes just before modal_curve_fit is made visible.
function modal_curve_fit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modal_curve_fit (see VARARGIN)

% Choose default command line output for modal_curve_fit
handles.output = hObject;
set(handles.uipanel_export,'Visible','off');

fmin=getappdata(0,'fmin');
fmax=getappdata(0,'fmax');

f1=sprintf('%g',fmin);
f2=sprintf('%g',fmax);

set(handles.edit_fmin,'String',f1);
set(handles.edit_fmax,'String',f2);

try
    H1=getappdata(0,'H1');
    set(handles.edit_H1,'String','H1'); 
    sz=size(H1);
    nrows=round(sz(2)-1);
    if(nrows>=1 && nrows<=50)
        assignin('base','H1',H1);
        set(handles.listbox_num_dof,'Value',nrows);
    else
        set(handles.listbox_num_dof,'Value',1);        
    end
catch
    warndlg('H1 not found');
    return;
end

try
    H2=getappdata(0,'H2');
    set(handles.edit_H2,'String','H2');
    if(nrows>=1 && nrows<=50)
        assignin('base','H2',H2);
    end    
catch
end

try
    fs=getappdata(0,'sr');
    sss=sprintf('%g',fs);
    set(handles.edit_sr,'String',sss);
catch
end

cn={'Channel Name','Include'};
ncolumns=2;

try
    AC=getappdata(0,'channels'); 
    NC=getappdata(0,'num_channels');
    
    if(isempty(NC==1))
        NC=1;
    end
catch
end

sz=size(AC);

columnformat={[],'logical'};
set(handles.uitable_data,'ColumnName',cn,'ColumnFormat',columnformat,'Data',cell(nrows,ncolumns));

A=get(handles.uitable_data,'Data');

try
    for i=1:NC
        A{i,1}=char(AC(i));
    end
    set(handles.uitable_data,'Data',A);
catch
    try
        for i=1:sz(2)
            A{i,1}=char(AC(i));
        end 
        set(handles.uitable_data,'Data',A);
    end
end

listbox_num_dof_Callback(hObject, eventdata, handles);    

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modal_curve_fit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modal_curve_fit_OutputFcn(hObject, eventdata, handles) 
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

delete(modal_curve_fit);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * ');
disp(' * * * * * * * ');
disp(' ');


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

fig_num=1;

fmin=str2double(get(handles.edit_fmin,'String'));
fmax=str2double(get(handles.edit_fmax,'String'));

try
    FS1=get(handles.edit_H1,'String');
    H1=evalin('base',FS1);   
catch
    warndlg('Enter H1 FRF input array name');
    return;    
end
try
    FS2=get(handles.edit_H2,'String');
    H2=evalin('base',FS2);   
catch
end
try
    FS3=get(handles.edit_sr,'String');
    fs=evalin('base',FS3); 
catch
    warndlg('Enter Sample Rate');
    return;
end


sz=size(H1);
NC=sz(2)-1;

try
    AC=get(handles.uitable_data,'Data');
catch
end

for i=1:NC
    cname{i}=AC{i,1};
end    

try
    for i=1:NC
        channel{i}=AC{i,2};
    end      
catch
end


mnum=get(handles.listbox_num_modes,'Value');

m=get(handles.listbox_H,'Value');

f=H1(:,1);

if(m==1)
    frf=H1(:,2:end);
    disp(' H1 ');
    tts=sprintf('H1  Admittance');
else
    frf=H2(:,2:end);
    disp(' H2 ');
    tts=sprintf('H2  Admittance');    
end


sz=size(frf);

iflag=0;
k=1;
for i=sz(2):-1:1
    if(channel{i}==1 )
        rchan(k)=i;
        iflag=1;
        k=k+1;
    else   
        frf(:,i)=[];
    end
end
if(iflag==0)
    warndlg('At least one dof must be included');
    return;
end

rchan=sort(rchan);



if(k==1)
    warndlg('Select dof');
    return;
end



sz=size(frf);
nresponse=sz(2);


if(fmin>fmax)
    T=fmin;
    fmin=fmax;
    fmax=T;
end


[~,ii]=min(abs(f-fmin));
[~,jj]=min(abs(f-fmax));

original_frf=frf;
original_f=f;

frf=frf(ii:jj,:);
f=f(ii:jj);

num=get(handles.listbox_method,'Value');


if(num==2 || num==3)
    figure(fig_num);
    fig_num=fig_num+1;
end

if(num==1)
    [fn,dr,ms,ofrf] = modalfit(frf,f,fs,mnum,'FreqRange',[f(1) f(end)],'FitMethod','pp');
    disp(' Peak-Picking Method');
end
if(num==2)
    disp(' Least-Squares Rational Function Estimation ');
    disp(' Stability Diagram Results'); 
    [fn,dr,ms,ofrf] = modalfit(frf,f,fs,mnum,'FreqRange',[f(1) f(end)],'FitMethod','lsrf');    
    fnx=modalsd(frf,f,fs,'MaxModes',mnum,'FreqRange',[f(1) f(end)],'FitMethod','lsrf');
    fnx
end
if(num==3)
    disp(' Least-Squares Complex Exponential Method ');
    disp(' Stability Diagram Results'); 
    [fn,dr,ms,ofrf] = modalfit(original_frf,original_f,fs,mnum,'FitMethod','lsce','FreqRange',[f(1) f(end)]);     

    [~,ii]=min(abs(original_f-fmin));
    [~,jj]=min(abs(original_f-fmax));
    ofrf=ofrf(ii:jj,:);

    fnx=modalsd(original_frf,original_f,fs,'MaxModes',mnum,'FreqRange',[f(1) f(end)]);
    fnx 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(fn);

numfn=sz(1);

nms=1;

if(nms==1)

%    least squares

       unMS=zeros(nresponse,numfn);
       
       for i=1:numfn
                   
            Y=imag(ms(:,i));
            X(:,1)=real(ms(:,i));
            X(:,2)=1;
     
            try
      
                A=pinv(X'*X)*(X'*Y);

                theta1=atan(A(1));
                theta2=-atan(A(1));

                t1=ms(:,i)*exp(1i*theta1);
                t2=ms(:,i)*exp(1i*theta2);
            
                t1=t1/norm(t1);
                t2=t2/norm(t2);
            
                tt=t1;
                theta=theta1;
                if(max(abs(imag(t2)))<max(abs(imag(t1))))
                    tt=t2;
                    theta=theta2;
                end    
                unMS(:,i)=tt;
            catch
                unMS(:,i)=ms(:,i);                
            end
       end
   
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

big=[0 0 0];

kv=1;

sz=size(fn);


for ijk=1:sz(2)
    
    if(nresponse>=2 && numfn>=2 && num==1) 
        fprintf('\n  %s \n',cname{rchan(ijk)});
    else
        disp(' ');
    end
    out1=sprintf(' Mode \t  fn \t damping \t Q ');
    out2=sprintf('      \t (Hz)\t ratio ');    
    disp(out1);
    disp(out2);   

    for i=1:sz(1)
        fprintf(' %d \t %7.4g \t %7.3f \t %4.1f \n',i,fn(i,ijk),dr(i,ijk),1/(2*dr(i,ijk)));
        big(kv,1)=fn(i,ijk);
        big(kv,2)=dr(i,ijk);
        big(kv,3)=1/(2*dr(i,ijk));
        kv=kv+1;
    end

end

sz=size(ms);
numfn=sz(2);

for i=1:numfn
    normt=norm(ms(:,i));
    ms(:,i)=ms(:,i)/normt;
end    

    
if(sz(2)<=4)
    disp(' ');
    disp(' Normalized Mode Shapes (Complex due to viscous damping)');
    disp(' Rows=dof, Columns=mode number');
    disp(' ');
    disp(' Complex Format');
    for i=1:sz(1)
        for j=1:numfn
            if(imag(ms(i,j))>=0)
                fprintf('  %6.3g +%5.3gi ,\t',real(ms(i,j)),imag(ms(i,j)));
            else
                fprintf('  %6.3g -%5.3gi ,\t',real(ms(i,j)),abs(imag(ms(i,j))));                
            end
        end   
        disp(' ');
    end
    
    disp(' ');
    disp(' Magnitude & Phase')
    for i=1:sz(1)
        for j=1:numfn
            fprintf('  %6.3g at %5.3g deg,\t',abs(ms(i,j)),(180/pi)*angle(ms(i,j)));
        end   
        disp(' ');
    end

    try
    if(nms==1)
        sz=size(unMS);
        disp(' ');
        disp(' Undamped Real Mode Shapes, Least Squares Approximation')
        for i=1:sz(2)
            if(unMS(1,i)<0)
                unMS(:,i)=-unMS(:,i);
            end
        end
        for i=1:sz(1)
            for j=1:sz(2)
                if(imag(unMS(i,j))>=0)
                    fprintf('  %6.3g +%5.3gi ,\t',real(unMS(i,j)),imag(unMS(i,j)));
                else
                    fprintf('  %6.3g -%5.3gi ,\t',real(unMS(i,j)),abs(imag(unMS(i,j))));                
                end
            end   
            disp(' ');
        end
        setappdata(0,'unMS',unMS);        
    end
    catch
    end
    
end
disp(' ');

setappdata(0,'big',big);
setappdata(0,'ms',ms);
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_label=getappdata(0,'y_label');
md=getappdata(0,'md');
    

if(nresponse==1)
    t_string=sprintf('%s  %s',tts,cname{rchan(1)});
    [fig_num]=plot_frf_md_two(fig_num,f,frf,ofrf,fmin,fmax,t_string,y_label,md);
end

if(nresponse==2)
    tts1=sprintf('%s  %s',tts,cname{rchan(1)});
    tts2=sprintf('%s  %s',tts,cname{rchan(2)});
    t_string1=tts1;
    t_string2=tts2;    
end

try
    y_label=getappdata(0,'y_label');
catch
end

if(nresponse>=2)
    
    if(num==1) % peak picking
       
        if(nresponse==2)
            [fig_num]=plot_frf_md_two_two_titles(fig_num,f,frf,ofrf,fmin,fmax,t_string1,t_string2,y_label,md);
        else
            for i=1:nresponse
                tstring=sprintf('%s  %s',tts,rchan(i));
                [fig_num]=plot_frf_md_two(fig_num,f,frf(:,i),ofrf(:,ijk),fmin,fmax,tstring,y_label,md);
            end
        end
        
    end
    if(num==2 || num==3) % least squares   
        
        if(nresponse==2)
            [fig_num]=plot_frf_md_two_two_titles(fig_num,f,frf,ofrf,fmin,fmax,t_string1,t_string2,y_label,md);
        else
            for i=1:nresponse
                tstring=sprintf('%s  %s',tts,cname{rchan(i)});
                [fig_num]=plot_frf_md_two(fig_num,f,frf(:,i),ofrf(:,i),fmin,fmax,tstring,y_label,md);
            end
        end        
    
    end
end    

set(handles.uipanel_export,'Visible','on');
set(handles.pushbutton_check,'Visible','off');    

try
    msgbox('Results written to Command Window');
catch
end

% --- Executes on selection change in listbox_num_dof.
function listbox_num_dof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_dof


Nrows=get(handles.listbox_num_dof,'Value');

%%%%

Ncolumns=2;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
Nrows;

for i=1:Nrows
    data_s{i,1}='';
    data_s{i,2}='FALSE';        
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
    data_s;
    set(handles.uitable_data,'Data',data_s);
catch
end


% --- Executes during object creation, after setting all properties.
function listbox_num_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_H.
function listbox_H_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_H contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_H


% --- Executes during object creation, after setting all properties.
function listbox_H_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'big');
end
if(n==2)
    data=getappdata(0,'ms');
end
if(n==3)
    data=getappdata(0,'unMS');
end

name=get(handles.edit_output_array,'String');

assignin('base', name, data);

set(handles.pushbutton_check,'Visible','on'); 

h = msgbox('Save Complete'); 




% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_reset_names.
function pushbutton_reset_names_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset_names (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


data_s{1,1}='';
data_s{1,2}='FALSE';        

set(handles.uitable_data,'Data',data_s);


% --- Executes on selection change in listbox_num_modes.
function listbox_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_modes


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


% --- Executes on selection change in listbox_real_mode_shapes.
function listbox_real_mode_shapes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_real_mode_shapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_real_mode_shapes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_real_mode_shapes


% --- Executes during object creation, after setting all properties.
function listbox_real_mode_shapes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_real_mode_shapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_check.
function pushbutton_check_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=mode_shape_orthogonality_check;
set(handles.s,'Visible','on');



function edit_H1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_H1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_H1 as text
%        str2double(get(hObject,'String')) returns contents of edit_H1 as a double


% --- Executes during object creation, after setting all properties.
function edit_H1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_H1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_H2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_H2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_H2 as text
%        str2double(get(hObject,'String')) returns contents of edit_H2 as a double


% --- Executes during object creation, after setting all properties.
function edit_H2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_H2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    num_modes=get(handles.listbox_num_modes,'Value');
    ModalCurveFit.nchan=num_modes;     
catch
end
try
    num_dof=get(handles.listbox_num_dof,'Value');
    ModalCurveFit.num_dof=num_dof;     
catch
end
try
    H=get(handles.listbox_H,'Value');
    ModalCurveFit.H=H;     
catch
end
try
    method=get(handles.listbox_method,'Value');
    ModalCurveFit.method=method;     
catch
end
try
    sr=strtrim(get(handles.edit_sr,'String'));
    ModalCurveFit.sr=sr;     
catch
end
try
    fmin=get(handles.edit_fmin,'String');
    ModalCurveFit.fmin=fmin;     
catch
end
try
    fmax=get(handles.edit_fmax,'String');
    ModalCurveFit.fmax=fmax;     
catch
end
try
    data=get(handles.uitable_data,'Data');
    ModalCurveFit.data=data;     
catch
end


try
    FS1=strtrim(get(handles.edit_H1,'String'));    
    H1=evalin('base',FS1);
    ModalCurveFit.H1=H1;   
    ModalCurveFit.FS1=FS1;  
catch
end

try
    FS2=strtrim(get(handles.edit_H2,'String'));    
    H2=evalin('base',FS2);
    ModalCurveFit.H2=H2;   
    ModalCurveFit.FS2=FS2;  
catch
end


% % %
 
structnames = fieldnames(ModalCurveFit, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'ModalCurveFit'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
try 
    msgbox('Save Complete');
catch
end



% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat', 'Select plot save file');

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

   ModalCurveFit=evalin('base','ModalCurveFit');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%



try
    num_modes=ModalCurveFit.nchan;  
    set(handles.listbox_num_modes,'Value',num_modes);
catch
end
try
    num_dof=ModalCurveFit.num_dof;    
    set(handles.listbox_num_dof,'Value',num_dof);     
catch
end
try
    H=ModalCurveFit.H;       
    set(handles.listbox_H,'Value',H);  
catch
end
try
    method=ModalCurveFit.method;       
    set(handles.listbox_method,'Value',method);  
catch
end
try
    sr=ModalCurveFit.sr;     
    set(handles.edit_sr,'String',sr);    
catch
end
try
    fmin=ModalCurveFit.fmin;       
    set(handles.edit_fmin,'String',fmin);  
catch
end
try
    fmax=ModalCurveFit.fmax;      
    set(handles.edit_fmax,'String',fmax);   
catch
end
try
    data=ModalCurveFit.data;      
    set(handles.uitable_data,'Data',data);   
catch
end


try
    H1=ModalCurveFit.H1;   
    FS1=ModalCurveFit.FS1;      
    set(handles.edit_H1,'String',FS1);
    assignin('base','H1',H1);    
catch
end

try
    H2=ModalCurveFit.H2;   
    FS2=ModalCurveFit.FS2;      
    set(handles.edit_H2,'String',FS2);
    assignin('base','H2',H2);    
catch
end
