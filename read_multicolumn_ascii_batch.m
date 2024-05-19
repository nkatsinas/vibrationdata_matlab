function varargout = read_multicolumn_ascii_batch(varargin)
% READ_MULTICOLUMN_ASCII_BATCH MATLAB code for read_multicolumn_ascii_batch.fig
%      READ_MULTICOLUMN_ASCII_BATCH, by itself, creates a new READ_MULTICOLUMN_ASCII_BATCH or raises the existing
%      singleton*.
%
%      H = READ_MULTICOLUMN_ASCII_BATCH returns the handle to a new READ_MULTICOLUMN_ASCII_BATCH or the handle to
%      the existing singleton*.
%
%      READ_MULTICOLUMN_ASCII_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in READ_MULTICOLUMN_ASCII_BATCH.M with the given input arguments.
%
%      READ_MULTICOLUMN_ASCII_BATCH('Property','Value',...) creates a new READ_MULTICOLUMN_ASCII_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before read_multicolumn_ascii_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to read_multicolumn_ascii_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help read_multicolumn_ascii_batch

% Last Modified by GUIDE v2.5 25-Apr-2018 16:26:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @read_multicolumn_ascii_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @read_multicolumn_ascii_batch_OutputFcn, ...
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


% --- Executes just before read_multicolumn_ascii_batch is made visible.
function read_multicolumn_ascii_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to read_multicolumn_ascii_batch (see VARARGIN)

% Choose default command line output for read_multicolumn_ascii_batch
handles.output = hObject;


listbox_write_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes read_multicolumn_ascii_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = read_multicolumn_ascii_batch_OutputFcn(hObject, eventdata, handles) 
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

delete(read_multicolumn_ascii_batch)


% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


   disp('  ');
   disp(' * * * * *');
   disp('  ');

   ne=get(handles.listbox_ext,'Value');
   
   if(ne==1)
       sxe='dat';
   else
       sxe='txt';
   end
   
   nw=get(handles.listbox_write,'Value');
   
   nh=str2num(get(handles.edit_nh,'String'));
   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
 
   setappdata(0,'pathname',pathname);
   
   try
      fid = fopen(filename,'r');
   catch
      warndlg('File not opened'); 
      return; 
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
   
   disp('  ');   
 
   file_array = textscan(fid,'%s','Delimiter','\n');
   fclose(fid);
    
  
   kv=cellfun(@length,file_array);
 
   out1=sprintf(' %d number of lines',kv);
   disp(out1);    
    
   setappdata(0,'file_array',file_array);
   setappdata(0,'kv',kv);
    
   for i=1:kv
       
        filename=file_array{1}{i};
 
        try
            fff = fullfile(pathname, filename);
            disp(' ');
            disp(filename);
            disp(' ');            
        catch
            warndlg('File not opened'); 
            return; 
        end 
        
        THM=importdata(fff);
        
        sz=size(THM);
        m=sz(2);
        
        if(nh>0)
            
            for iv=nh:-1:1
                THM(iv,:)=[];
            end
            
        end
        
        FS=filename;
        
        FS=strrep(FS,'.dat','');
        FS=strrep(FS,'.txt','');  
        FS=strrep(FS,'.','_');          

        disp(' ');
        disp(' Matlab Workspace Output arrays ');        

        for j=2:m
        
            q=[THM(:,1) THM(:,j)];
            
            nnn=j-1;
            
            new_name=sprintf('%s_%d',FS,nnn);
    
            out1=sprintf('  %s',new_name);
            disp(out1);
    
            assignin('base', new_name, q);           
            
        end           
        
        if(nw==2)
            
            disp(' ');
            disp(' External ASCII Output arrays ');  
            
            for j=2:m
        
                q=[THM(:,1) THM(:,j)];
                
                nnn=j-1;
            
                new_name_asc=sprintf('%s_%d.%s',FS,nnn,sxe);
                
                filename = fullfile(pathname,new_name_asc);
                
                save(filename,'q','-ASCII')    
              
                out1=sprintf('  %s',new_name_asc);
                disp(out1);
            
            end
            
        end
        
   end


   msgbox('Calculation complete');
   
% --- Executes on selection change in listbox_ext.
function listbox_ext_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ext contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ext


% --- Executes during object creation, after setting all properties.
function listbox_ext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_header.
function listbox_header_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_header (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_header contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_header


% --- Executes during object creation, after setting all properties.
function listbox_header_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_header (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_write.
function listbox_write_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_write contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_write

n=get(handles.listbox_write,'Value');

if(n==1)
    set(handles.text_ext,'Visible','off');
    set(handles.listbox_ext,'Visible','off');
else
    set(handles.text_ext,'Visible','on');
    set(handles.listbox_ext,'Visible','on');     
end



% --- Executes during object creation, after setting all properties.
function listbox_write_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nh_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nh as text
%        str2double(get(hObject,'String')) returns contents of edit_nh as a double


% --- Executes during object creation, after setting all properties.
function edit_nh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
