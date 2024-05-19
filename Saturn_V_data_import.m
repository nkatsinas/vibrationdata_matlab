function varargout = Saturn_V_data_import(varargin)
% SATURN_V_DATA_IMPORT MATLAB code for Saturn_V_data_import.fig
%      SATURN_V_DATA_IMPORT, by itself, creates a new SATURN_V_DATA_IMPORT or raises the existing
%      singleton*.
%
%      H = SATURN_V_DATA_IMPORT returns the handle to a new SATURN_V_DATA_IMPORT or the handle to
%      the existing singleton*.
%
%      SATURN_V_DATA_IMPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SATURN_V_DATA_IMPORT.M with the given input arguments.
%
%      SATURN_V_DATA_IMPORT('Property','Value',...) creates a new SATURN_V_DATA_IMPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Saturn_V_data_import_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Saturn_V_data_import_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Saturn_V_data_import

% Last Modified by GUIDE v2.5 15-Jul-2019 16:29:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Saturn_V_data_import_OpeningFcn, ...
                   'gui_OutputFcn',  @Saturn_V_data_import_OutputFcn, ...
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


% --- Executes just before Saturn_V_data_import is made visible.
function Saturn_V_data_import_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Saturn_V_data_import (see VARARGIN)

% Choose default command line output for Saturn_V_data_import
handles.output = hObject;

setappdata(0,'fig_num',1);

listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Saturn_V_data_import wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Saturn_V_data_import_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_import.
function pushbutton_import_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp(' ');

nt=get(handles.listbox_type,'Value');
if(nt==1)
    Q=getappdata(0,'Q');
end
    
dd2=getappdata(0,'dd2');
dd4=getappdata(0,'dd4');
dd5=getappdata(0,'dd5');
dd6=getappdata(0,'dd6');

data=get(handles.uitable_data,'Data');


ns=length(dd4);

disp('');

iflag=0;



disp(' ');
disp(' Arrays read into workspace ');
disp(' ');

for i=1:ns

    if(data{i,1}==true)
    
        iflag=1;

        if(nt==1)
            psd=[Q(:,1) Q(:,i+1)];
            output_name=sprintf('psd_%s_%s_%s',dd4{i},dd5{i},dd6{i});
            output_name=strrep(output_name,'/','_');
            output_name=strrep(output_name,'-','_');
            output_name=strrep(output_name,' ','_');   
            output_name2=sprintf('psd_f%s',dd2{i});
            assignin('base', output_name, psd);
            assignin('base', output_name2, psd);      
            out1=sprintf(' %s \t %s \t %s ',data{i,2},output_name2,output_name); 
            disp(out1);
        else
            
            
            FS='Saturn_V_data_unscaled';
            disp(FS);
    
            try
                try
                    Saturn_V_data_unscaled=evalin('base',FS); 
                catch
           
                    struct=load(FS);
                    structnames = fieldnames(struct, '-full'); % fields in the struct

                    k=length(structnames);

                    for j=1:k
                        namevar=strcat('struct.',structnames{j});
                        value=eval(namevar);
                        pattern=sprintf('f%s',dd2{i});
                        if(contains(structnames{j},pattern))
                            assignin('base',structnames{j},value);
                            disp('*');
                            structnames{j}
                        end    
                    end      

                end    

            catch
                warndlg('Load Failed: Saturn_V_data_unscaled.mat');
                return;
            end           
            
            FS=sprintf('unscaled_psd_f%s',dd2{i});
            psd=evalin('base',FS); 
        end
        

%%%
        ppp=psd;
        x_label='Frequency (Hz)';
        y_label='Accel (G^2/Hz)';

        fmin=psd(1,1);
        fmax=psd(end,1);

        num=length(psd(:,1));
        df=(fmax-fmin)/(num-1);

        grms=sqrt(df*sum(psd(:,2)));
        
        if(nt==1)
            ttt=sprintf('psd  %s  %s  %s',dd4{i},dd5{i},dd6{i});       
        else
            ttt=sprintf('unscaled psd  %s  %s  %s',dd4{i},dd5{i},dd6{i});                 
        end
        
        ttt=strrep(ttt,'_',' ');
        ttt=strrep(ttt,'psd',' ');

        t_string=sprintf('PSD  %s   %7.3g GRMS',ttt,grms);
        
        fig_num=str2num(dd2{i});
        [~,~]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

    end
    
end
disp(' ');

if(iflag==0)
    warndlg('No channel selected');
    return;
end




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(Saturn_V_data_import);


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num


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




% --- Executes during object creation, after setting all properties.
function pushbutton_import_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_spl.
function pushbutton_spl_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        fig_num=1;

        load('saturn_v_reference_spl.txt');
        output_name='saturn_v_reference_spl';
        assignin('base', output_name, saturn_v_reference_spl );      
 
        n_type=1;
    
        f=saturn_v_reference_spl(:,1);
        dB=saturn_v_reference_spl(:,2);
    
        [~]=spl_plot(fig_num,n_type,f,dB);
        
        disp('  ');
        disp(' Saturn V (NASA/TM—2009–215902) ');
        disp('  ');    
        
        out1='Array Name: saturn_v_reference_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';


% --- Executes on button press in pushbutton_select_all.
function pushbutton_select_all_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


data=get(handles.uitable_data,'Data');

n=max(size(data));

for i=1:n
    data{i,1}=true;
end
    
%%%%%%%

set(handles.uitable_data,'Data',data);


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

disp(' ');

n=get(handles.listbox_type,'Value');

if(n==1)

    FS='Saturn_V_databanks';
    disp(FS);
    
    try
        try
            Saturn_V_databanks=evalin('base',FS); 
        catch
            load(FS);
            assignin('base', 'Saturn_V_data',FS);
        end    
    catch
        warndlg('Load Failed: Saturn_V_databanks.mat');
        return;
    end
    
    setappdata(0,'Q',Saturn_V_databanks);    

else
    

end


%%%%%%%

cn={'Select','Fig','Zone','Channel','Axis','Phase','Structure'};

%%%%%%%

dd2={'12','14','16','18','20','21','22','23','24','25','26',...
           '27','30','32','34','35','40','41','42','44','47','51','53',...
           '56','58','60','62','64','65','66','67','71','73','75','77',...
           '78','79','81','83','85','87','89','91','93','94','95','96',...
                            '97','98','104','106','108','110','112','113'};

%% set(handles.listbox_num,'String',dd1);                        
                        
dd3={'15-2-2','15-2-2','15-2-2','15-2-2','15-2-2','15-2-2','15-2-2',...
    '15-2-2','15-2-2','15-2-2','15-2-2','15-2-2','11-2-2','11-2-2',...
    '11-2-2','11-2-2','11-2-2','11-2-2','11-2-2','11-2-2','7',...
    '9-2-1-1','9-2-1-1','5-2-2','5-2-2','5-2-2','5-2-2','5-2-2',...
    '5-2-2','5-2-2','5-2-2','2-5-4','2-5-4','2-5-4','5-2-2','5-2-2',...
    '5-2-2','5-2-2','11-2-2','11-2-2','11-2-2','11-2-2','11-2-2',...
    '11-2-2','11-2-2','11-2-2','11-2-2','11-2-2','11-2-2','9-3-2',...
    '9-3-2','9-3-2','9-3-2','9-3-2','LEM ADPT'};     

dd4={'7159/A1','7159/A3','7159/A5','7159/A7','7159/A9','7159/A11',...
    '7159/A13','7159/A15','7159/A17','7159/A19','7159/A21','7159/A23',...
    'A25-1','A25-2','7159/A25','7159/A27','7159/A29','7159/A31',...
    '7159/A33','7159/A35','7159/A37','7159/A39','7159/A41','7159/A43',...
    '7159/A45','7159/A47','7159/A49','7159/A51','7159/A53','7159/A55',...
    '7159/A57','7159/A73','7159/A65','7159/A69','7159/A75','7159/A77',...
    '7159/A79','7159/A81','7159/A87','7159/A89','7159/A91','7159/A93',...
    '7159/A95','7159/A97','7159/A99','7159/A101','7159/A103','7159/A105',...
    '7159/A107','7159/A109','7159/A117','7159/A111','7159/A113',...
    '7159/A115','7159/A119'};

dd5={'Long','Long','Long','Long','Tangent','Tangent','Tangent',...
    'Tangent','Radial','Radial','Radial','Radial','Long','Long',...
    'Radial','Radial','Radial','Radial','Radial','Radial','Radial',...
    'Parallel','Normal','Long','Long','Long','Long','Radial','Radial',...
    'Radial','Radial','Long','Long','Long','Radial','Radial','Radial',...
    'Radial','Normal','Long','Long','Long','Long','Tangent','Tangent',...
    'Tangent','Tangent','Radial','Radial','Long','Radial','Radial',...
    'Radial','Radial','Radial'};

   
dd6={'Liftoff','Mach 1','Max Q','Mach 1/Max Q','Liftoff','Mach 1',...
    'Max Q','Mach 1/Max Q','Liftoff','Mach 1','Max Q','Mach 1/Max Q',...
    'Liftoff','Mach 1','Liftoff','Mach 1','Liftoff','Mach 1','Max Q',...
    'Mach 1/Max Q','Static','Static','Static','Liftoff','Mach 1',...
    'Max Q','Mach 1/Max Q','Liftoff','Mach 1','Max Q','Mach 1/Max Q',...
    'Liftoff','Mach 1','Mach 1/Max Q','Liftoff','Mach 1','Max Q',...
    'Mach 1/Max Q','Liftoff','Liftoff','Mach 1','Max Q','Mach 1/Max Q',...
    'Liftoff','Mach 1','Max Q','Mach 1/Max Q','Liftoff','Mach 1',...
    'Static','Static','Mach 1','Max Q','Mach 1/Max Q','Static'};

dd7={'Ring Frame','Ring Frame','Ring Frame','Ring Frame',...
    'Skin Stringer','Skin Stringer','Ring Frame','Ring Frame',...
    'Ring Frame','Ring Frame','Ring Frame','Ring Frame','Ring Frame',...
    'Ring Frame','Ring Frame','Ring Frame','Ring Frame','Ring Frame',...
    'Ring Frame','Ring Frame','Ring Frame','Ring Frame','Ring Frame',...
    'Ring Frame','Ring Frame','Ring Frame','Ring Frame','Ring Frame',...
    'Ring Frame','Ring Frame','Ring Frame','Ring Frame','Ring Frame',...
    'Ring Frame','Ring Frame','Ring Frame','Ring Frame','Ring Frame',...
    'Skin Stringer','Skin Stringer','Skin Stringer','Skin Stringer',...
    'Skin Stringer','Skin Stringer','Skin Stringer','Skin Stringer',...
    'Skin Stringer','Skin Stringer','Skin Stringer','Skin Stringer',...
    'Skin Stringer','Skin Stringer','Skin Stringer','Skin Stringer','Honeycomb'};

for i=1:length(dd2)
    data{i,1}=false;
    data{i,2}=dd2{i};
    data{i,3}=dd3{i};
    data{i,4}=dd4{i};
    data{i,5}=dd5{i};
    data{i,6}=dd6{i};
    data{i,7}=dd7{i};   
end

%%%%%%%

set(handles.uitable_data,'Data',data,'ColumnName',cn);

setappdata(0,'dd2',dd2);
setappdata(0,'dd3',dd3);
setappdata(0,'dd4',dd4);
setappdata(0,'dd5',dd5);
setappdata(0,'dd6',dd6);
setappdata(0,'dd7',dd7);



% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
