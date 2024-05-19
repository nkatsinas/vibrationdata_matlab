function varargout = vibrationdata_Fourier_multiple(varargin)
% VIBRATIONDATA_FOURIER_MULTIPLE MATLAB code for vibrationdata_Fourier_multiple.fig
%      VIBRATIONDATA_FOURIER_MULTIPLE, by itself, creates a new VIBRATIONDATA_FOURIER_MULTIPLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FOURIER_MULTIPLE returns the handle to a new VIBRATIONDATA_FOURIER_MULTIPLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FOURIER_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FOURIER_MULTIPLE.M with the given input arguments.
%
%      VIBRATIONDATA_FOURIER_MULTIPLE('Property','Value',...) creates a new VIBRATIONDATA_FOURIER_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_Fourier_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_Fourier_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_Fourier_multiple

% Last Modified by GUIDE v2.5 17-Apr-2020 18:11:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_Fourier_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_Fourier_multiple_OutputFcn, ...
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


% --- Executes just before vibrationdata_Fourier_multiple is made visible.
function vibrationdata_Fourier_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_Fourier_multiple (see VARARGIN)

% Choose default command line output for vibrationdata_Fourier_multiple
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

set(handles.listbox_output,'Value',1);
set(handles.listbox_mean_removal,'Value',1);
set(handles.listbox_window,'Value',1);

listbox_destination_Callback(hObject, eventdata, handles);
listbox_plots_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_Fourier_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_Fourier_multiple_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


mdest=get(handles.listbox_destination,'Value');

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'magnitude_FT');
end  
if(n==2)
    data=getappdata(0,'magnitude_phase_FT');
end 
if(n==3)
    if(mdest==1)  % Matlab workspace
        data=getappdata(0,'complex_FT_2c');
    else          % Excel
        data=getappdata(0,'complex_FT_3c');        
    end
end 


if(mdest==1)
    output_name=get(handles.edit_output_filename,'String');
    assignin('base', output_name,data);
end
if(mdest==2)
    
    [writefname, writepname] = uiputfile('*.xls','Save model as Excel file');
    writepfname = fullfile(writepname, writefname);
    
    c=[num2cell(data)]; % 1 element/cell
    xlswrite(writepfname,c);

end
    
h = msgbox('Export Complete.  Press Return. '); 


function edit_output_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_output_filename as a double


% --- Executes during object creation, after setting all properties.
function edit_output_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%

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

kv=N;




%%%

yname=get(handles.edit_ylabel_input,'String');
 
np=get(handles.listbox_plots,'Value');

if(np==1)

    psave=get(handles.listbox_psave,'Value');  
    nfont=str2num(get(handles.edit_font_size,'String'));
    
end    

ext=get(handles.edit_extension,'String');

m_choice=get(handles.listbox_mean_removal,'Value');
h_choice=get(handles.listbox_window,'Value');

if(h_choice==2)
    m_choice=1;
end

nout=get(handles.listbox_output,'Value');

disp('  ');
disp(' * * * * * ');
disp('  ');

if(np==1)
    if(psave>1)
        disp(' External Plot Names ');
        disp(' ');
    end
end

ijk=1;

for i=1:kv
    
    THM=evalin('base',array_name{i});
    
    output_array{i}=strcat(array_name{i},ext);

    
    amp=double(THM(:,2));

    n=length(amp);
    dur=THM(n,1)-THM(1,1);
    dt=dur/(n-1);
    sr=1/dt;

    df=1/(n*dt);
    nhalf=floor(n/2);
 
    [z,zz,f_real,f_imag,ms,freq,ff]=fourier_core(n,nhalf,df,amp);
    
%    
    z=fix_size(z);
    zz=fix_size(zz);
    freq=fix_size(freq);
    ff=fix_size(ff);
    f_imag=fix_size(f_imag);
    f_real=fix_size(f_real);
 
    phase=atan2(f_imag,f_real);

 
    phase=fix_size(phase);
 
    phase = phase*180/pi;
 
    magnitude_FT=[ff zz];
    magnitude_phase_FT=[ff zz phase(1:length(ff))];
    complex_FT_2c=[freq (f_real+(1i)*f_imag)];

    if(nout==1)
        data=magnitude_FT;
    end
    if(nout==2)
        data=magnitude_phase_FT;
    end
    if(nout==3)
        data=complex_FT_2c;
    end
    
   
    assignin('base', output_array{i}, data); 
    
    out2=sprintf('%s',output_array{i});
    ss{i}=out2;   
    
    stt=get(handles.edit_max_freq,'String');

    nyquist=sr/2;
 
    if  isempty(stt)
        max_freq=nyquist;
        smf=sprintf('%8.4g',max_freq);
        set(handles.edit_max_freq,'String',smf);
    else
        max_freq=str2num(stt);    
    end
    
    try
        [~,fmaxp]=find_max_fmax(magnitude_FT,max_freq);    
    catch
        fmaxp=0;
    end

    sz=size(max_freq);

    if(sz(1)==0)
        max_freq=nyquist;
        smf=sprintf('%8.4g',max_freq);
        set(handles.edit_max_freq,'String',smf);    
    end
    
%    
    newStr=strrep(leg{i},'_',' ');
    ttt=sprintf('%s Time History ',newStr);
%        

    if(np==2)
        figure(ijk);
        ijk=ijk+1;
        plot(THM(:,1),THM(:,2));
        title(ttt);
        ylabel(yname);       
        xlabel('Time (sec)');
        grid on;
    end    
    if(np==1)
 
        fmin=0;
        fmax=max_freq;
        
        h2=figure(ijk);
        ijk=ijk+1;

        if(nout==1)
        
            plot(magnitude_FT(:,1),magnitude_FT(:,2));
            out1=sprintf('%s Fourier Transform Magnitude \n Max Peak at %8.4g Hz',newStr,fmaxp);
            title(out1);
            ylabel(yname);
            xlabel('Frequency (Hz)');
            xlim([0 max_freq]);
            grid on;
        end
%        
        if(nout==2)
%
            subplot(3,1,1);
            plot(freq,phase);
            out1=sprintf('%s Fourier Transform Magnitude & Phase \n Max Peak at %8.4g Hz',newStr,fmaxp);
            title(out1);
            FRF_p=phase;
            grid on;
            ylabel('Phase (deg)');
            axis([fmin,fmax,-180,180]);
            set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[-180,-90,0,90,180]);
%
            if(max(FRF_p)<=0.)
%
                axis([fmin,fmax,-180,0]);
                set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[-180,-90,0]);
            end  
%
            if(min(FRF_p)>=-90. && max(FRF_p)<90.)
%
                axis([fmin,fmax,-90,90]);
                set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[-90,0,90]);
            end 
%
            if(min(FRF_p)>=0.)
%
                axis([fmin,fmax,0,180]);
                set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[0,90,180]);
            end 
%
            subplot(3,1,[2 3]);
            plot(freq,zz);
            xlim([fmin fmax])
            grid on;
            xlabel('Frequency(Hz)');
            ylabel('Magnitude');
            set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
            'YScale','lin');
        end
        if(nout==3)
%
            subplot(2,1,1);
            plot(freq,real(complex_FT_2c));
            out1=sprintf('%s Fourier Transform',newStr);
            title(out1);
            xlim([fmin fmax])
            grid on;
            xlabel('Frequency(Hz)');
            ylabel('real');
            set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
            'YScale','lin');
        
            subplot(2,1,2);
            plot(freq,imag(complex_FT_2c));
            xlim([fmin fmax])
            grid on;
            xlabel('Frequency(Hz)');
            ylabel('real');
            set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
            'YScale','lin');        
%        
        end
        
        if(psave>1)
            
            pname=output_array{i};
        
            set(gca,'Fontsize',nfont);
            
            if(psave==2)
                print(h2,pname,'-dmeta','-r300');
                out1=sprintf('%s.emf',pname');
                disp(out1);
            end  
            if(psave==3)
                print(h2,pname,'-dpng','-r300');
                out1=sprintf('%s.png',pname');
                disp(out1);                
            end            
          
        end     
        
    end
end

disp('  ');
disp('  Output Arrays ');
disp('  ');

for i=1:kv
   out1=sprintf(' %s',output_array{i});
   disp(out1);
end


ss=ss';
length(ss);

output_name='ft_array';
    
assignin('base', output_name, ss);

disp(' ');
disp('Output array names stored in string array:');
disp(' ft_array');

msgbox('Calculation complete.  See Command Window');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_Fourier_multiple);

% --- Executes on selection change in listbox_mean_removal.
function listbox_mean_removal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean_removal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean_removal


% --- Executes during object creation, after setting all properties.
function listbox_mean_removal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_window.
function listbox_window_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_window contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_window


% --- Executes during object creation, after setting all properties.
function listbox_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_input as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_input as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_max_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_max_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_max_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_destination.
function listbox_destination_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_destination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_destination contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_destination




% --- Executes during object creation, after setting all properties.
function listbox_destination_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_destination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_plots.
function listbox_plots_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plots contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plots

n=get(handles.listbox_plots,'Value');

if(n==1)
    set(handles.listbox_psave,'Visible','on');
    set(handles.text_psd_export,'Visible','on');    
    
    set(handles.text_font_size,'Visible','on');
    set(handles.edit_font_size,'Visible','on');
else
    set(handles.listbox_psave,'Visible','off');
    set(handles.text_psd_export,'Visible','off');    
    
    set(handles.text_font_size,'Visible','off');
    set(handles.edit_font_size,'Visible','off');    
end    
    
% --- Executes during object creation, after setting all properties.
function listbox_plots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_extension_Callback(hObject, eventdata, handles)
% hObject    handle to edit_extension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_extension as text
%        str2double(get(hObject,'String')) returns contents of edit_extension as a double


% --- Executes during object creation, after setting all properties.
function edit_extension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_extension (see GCBO)
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



function edit_font_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_font_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_font_size as text
%        str2double(get(hObject,'String')) returns contents of edit_font_size as a double


% --- Executes during object creation, after setting all properties.
function edit_font_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_font_size (see GCBO)
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
cn={'Input Array Name','Legend'};

disp('ref 1');

%%%%
 
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
 
set(handles.uitable_data,'Data',data_s,'ColumnName',cn);



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


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
data_s=get(handles.uitable_data,'Data');

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
 
set(handles.listbox_num,'Value',Nrows);



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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
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


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    data=get(handles.uitable_data,'Data'); 
    FourierMult.data=data;      
catch
end

try
    num=get(handles.listbox_num,'Value'); 
    FourierMult.num=num;      
catch
end

%%%

try
    mean_removal=get(handles.listbox_mean_removal,'Value'); 
    FourierMult.mean_removal=mean_removal;      
catch
end

try
    output=get(handles.listbox_output,'Value'); 
    FourierMult.output=output;      
catch
end

try
    window=get(handles.listbox_window,'Value'); 
    FourierMult.tend=window;      
catch
end


try
    max_freq=get(handles.edit_max_freq,'String'); 
    FourierMult.max_freq=max_freq;      
catch
end

%%%

try
    ext=get(handles.edit_extension,'String'); 
    FourierMult.ext=ext;      
catch
end

try
    ylab=get(handles.edit_ylabel_input,'String'); 
    FourierMult.ylab=ylab;      
catch
end

try
    font=get(handles.edit_font_size,'String'); 
    FourierMult.font=font;      
catch
end

try
    plots=get(handles.listbox_plots,'Value'); 
    FourierMult.plots=plots;      
catch
end

try
    psave=get(handles.listbox_psave,'Value'); 
    FourierMult.psave=psave;      
catch
end



% % %
 
structnames = fieldnames(FourierMult, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'FourierMult'); 
 
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

   FourierMult=evalin('base','FourierMult');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%

try
    data=FourierMult.data;
    set(handles.uitable_data,'Data',data); 
catch
end

try
    num=FourierMult.num;      
    set(handles.listbox_num,'Value',num);    
catch
end


%%%

try
    mean_removal=FourierMult.mean_removal;     
    set(handles.listbox_mean_removal,'Value',mean_removal);      
catch
end

try
    output=FourierMult.output;     
    set(handles.listbox_output,'Value',output);      
catch
end

try
    window=FourierMult.tend;     
    set(handles.listbox_window,'Value',window);      
catch
end

try
    max_freq=FourierMult.max_freq;     
    set(handles.edit_max_freq,'String',max_freq);      
catch
end

%%%

try
    ext=FourierMult.ext;    
    set(handles.edit_extension,'String',ext); 
catch
end

try
    ylab=FourierMult.ylab;     
    set(handles.edit_ylabel_input,'String',ylab); 
catch
end

try
    font=FourierMult.font;         
    set(handles.edit_font_size,'String',font); 
catch
end

try
    plots=FourierMult;          
    set(handles.listbox_plots,'Value',plots); 
catch
end

try
    psave=FourierMult.psave;    
    set(handles.listbox_psave,'Value',psave);       
catch
end
