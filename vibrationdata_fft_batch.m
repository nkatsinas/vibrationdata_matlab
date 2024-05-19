function varargout = vibrationdata_fft_batch(varargin)
% VIBRATIONDATA_FFT_BATCH MATLAB code for vibrationdata_fft_batch.fig
%      VIBRATIONDATA_FFT_BATCH, by itself, creates a new VIBRATIONDATA_FFT_BATCH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FFT_BATCH returns the handle to a new VIBRATIONDATA_FFT_BATCH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FFT_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FFT_BATCH.M with the given input arguments.
%
%      VIBRATIONDATA_FFT_BATCH('Property','Value',...) creates a new VIBRATIONDATA_FFT_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_fft_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_fft_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_fft_batch

% Last Modified by GUIDE v2.5 29-Aug-2016 15:32:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_fft_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_fft_batch_OutputFcn, ...
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


% --- Executes just before vibrationdata_fft_batch is made visible.
function vibrationdata_fft_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_fft_batch (see VARARGIN)

% Choose default command line output for vibrationdata_fft_batch
handles.output = hObject;



set(handles.listbox_output,'Value',1);
set(handles.listbox_mean_removal,'Value',1);
set(handles.listbox_window,'Value',1);

listbox_destination_Callback(hObject, eventdata, handles);
listbox_plots_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_fft_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_fft_batch_OutputFcn(hObject, eventdata, handles) 
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
    data=getappdata(0,'magnitude_FFT');
end  
if(n==2)
    data=getappdata(0,'magnitude_phase_FFT');
end 
if(n==3)
    if(mdest==1)  % Matlab workspace
        data=getappdata(0,'complex_FFT_2c');
    else          % Excel
        data=getappdata(0,'complex_FFT_3c');        
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

try
    FS=get(handles.edit_input_array,'String');
    sarray=evalin('base',FS);
catch
    warndlg('Input string array not found.');
    return; 
end    

if(iscell(sarray)==0)
    warndlg('Input must be array of strings (class=cell)');  
    return;
end

yname=get(handles.edit_ylabel_input,'String');
 
kv=length(sarray);

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

for i=1:kv
    
    THM=evalin('base',char(sarray(i,:)));
    
    output_array{i}=strcat(char(sarray(i,:)),ext);
    
    amp=double(THM(:,2));

    n=length(amp);
    dur=THM(n,1)-THM(1,1);
    dt=dur/(n-1);
    sr=1/dt;

    N=n;

    [freq,full,phase,complex_FFT]=full_FFT_core_b(m_choice,h_choice,amp,N,dt);    
%    
    magnitude_FFT=[freq full];
%
    magnitude_phase_FFT=[freq full phase];
%    

    complex_FFT_2c=[ complex_FFT(:,1)  (complex_FFT(:,2)+(1i)*complex_FFT(:,3))];

    if(nout==1)
        data=magnitude_FFT;
    end
    if(nout==2)
        data=magnitude_phase_FFT;
    end
    if(nout==3)
        data=complex_FFT_2c;
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
    
    [~,fmaxp]=find_max_fmax(magnitude_FFT,max_freq);    


    sz=size(max_freq);

    if(sz(1)==0)
        max_freq=nyquist;
        smf=sprintf('%8.4g',max_freq);
        set(handles.edit_max_freq,'String',smf);    
    end

    zz=full;
    ff=freq;

    if(np==1)
        
        [newStr]=plot_title_fix_alt(output_array{i});

        fmin=0;
        fmax=max_freq;
        
        h2=figure(i);        

        if(nout==1)
        
            plot(ff,zz);
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
            plot(freq,real(complex_FFT_2c));
            out1=sprintf('%s Fourier Transform',newStr);
            title(out1);
            xlim([fmin fmax])
            grid on;
            xlabel('Frequency(Hz)');
            ylabel('real');
            set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
            'YScale','lin');
        
            subplot(2,1,2);
            plot(freq,imag(complex_FFT_2c));
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

output_name='fft_array';
    
assignin('base', output_name, ss);

disp(' ');
disp('Output array names stored in string array:');
disp(' fft_array');

msgbox('Calculation complete.  See Command Window');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_fft_batch);

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
