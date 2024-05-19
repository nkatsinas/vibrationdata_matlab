function varargout = Vibrationdata_Export_Model(varargin)
% VIBRATIONDATA_EXPORT_MODEL MATLAB code for Vibrationdata_Export_Model.fig
%      VIBRATIONDATA_EXPORT_MODEL, by itself, creates a new VIBRATIONDATA_EXPORT_MODEL or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_EXPORT_MODEL returns the handle to a new VIBRATIONDATA_EXPORT_MODEL or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_EXPORT_MODEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_EXPORT_MODEL.M with the given input arguments.
%
%      VIBRATIONDATA_EXPORT_MODEL('Property','Value',...) creates a new VIBRATIONDATA_EXPORT_MODEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_Export_Model_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_Export_Model_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_Export_Model

% Last Modified by GUIDE v2.5 11-Mar-2014 15:19:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_Export_Model_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_Export_Model_OutputFcn, ...
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


% --- Executes just before Vibrationdata_Export_Model is made visible.
function Vibrationdata_Export_Model_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_Export_Model (see VARARGIN)

% Choose default command line output for Vibrationdata_Export_Model
handles.output = hObject;

listbox_export_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_Export_Model wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_Export_Model_OutputFcn(hObject, eventdata, handles) 
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

delete(Vibrationdata_Export_Model);


% --- Executes on selection change in listbox_export.
function listbox_export_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_export contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_export

n=get(handles.listbox_export,'Value');

set(handles.uipanel_output_filename,'Visible','off');
set(handles.edit_filename,'Visible','off');

if(n==1)
	set(handles.uipanel_output_filename,'Visible','on');
	set(handles.edit_filename,'Visible','on');
end


% --- Executes during object creation, after setting all properties.
function listbox_export_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_filename as a double


% --- Executes during object creation, after setting all properties.
function edit_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%    ncoor=evalin('base','ncoor');
%%%%    assignin('base','ncoor',ncoor);

n_ncoor=0;
n_pm=0;
n_dof_spring_property=0;
n_dof_spring_element=0;   
n_rigid_link=0;

n_damping_type=0;
n_uniform_dratio=0;
n_table_dratio=0;
n_table_Q=0;
n_uniform_Q=0;

n_material=0;


%%%%

n=get(handles.listbox_export,'Value');

FS=get(handles.edit_filename,'String');

try
    ncoor=getappdata(0,'ncoor');
    ncoor = sortrows(ncoor,1);       
catch
    warndlg('No nodes defined');
    return;
    ncoor=[];
end    

sz_ncoor=size(ncoor); 
n_ncoor=sz_ncoor(1);    

try
    point_mass=getappdata(0,'point_mass');
    point_mass = sortrows(point_mass,1);
    sz_pm=size(point_mass);
    n_pm=sz_pm(1);    
catch
    point_mass=[];
end



try
    dof_spring_property=getappdata(0,'dof_spring_property');
    dof_spring_property = sortrows(dof_spring_property,1);
    sz_dof_spring_property=size(dof_spring_property);   
    n_dof_spring_property=sz_dof_spring_property(1);    
catch
    dof_spring_property=[];
end

 

try
    dof_spring_element=getappdata(0,'dof_spring_element');
    dof_spring_element = sortrows(dof_spring_element,1);      
    sz_dof_spring_element=size(dof_spring_element); 
    n_dof_spring_element=sz_dof_spring_element(1);
catch
    warndlg(' no dof_spring_element ');    
    dof_spring_element=[];
end


try
    rigid_link=getappdata(0,'rigid_link');
    rigid_link = sortrows(rigid_link,1);      
    sz_rigid_link=size(rigid_link);
    n_rigid_link=sz_rigid_link(1);
catch
    rigid_link=[];    
end

%%%

try
    damping_type=getappdata(0,'damping_type');    
    sz_damping_type=size(damping_type);
    n_damping_type=sz_damping_type(1);
catch
    damping_type=[];    
end

try
    uniform_dratio=getappdata(0,'uniform_dratio');     
    n_uniform_dratio=1;
catch
    uniform_dratio=[];    
end

try
    table_dratio=getappdata(0,'table_dratio');
    table_dratio = sortrows(table_dratio,1);      
    sz_table_dratio=size(table_dratio);
    n_table_dratio=sz_table_dratio(1);
catch
    table_dratio=[];    
end

try
    table_Q=getappdata(0,'table_Q');
    table_Q = sortrows(table_Q,1);      
    sz_table_Q=size(table_Q);
    n_table_Q=sz_table_Q(1);
catch
    table_Q=[];    
end

try
    uniform_Q=getappdata(0,'uniform_Q');    
    n_uniform_Q=1;
catch
    uniform_Q=[];    
end

try
    material=getappdata(0,'material');
    material = sortrows(material,1);
    sz_material=size(material);   
    n_material=sz_material(1);    
catch
    material=[];
end


%%%

out1=sprintf(' %d ncoor   ',n_ncoor);
out2=sprintf(' %d n_pm  ',n_pm);
out3=sprintf(' %d n_dof_spring_property   ',n_dof_spring_property);
out4=sprintf(' %d n_dof_spring_element   ',n_dof_spring_element);
out5=sprintf(' %d n_rigid_link  ',n_rigid_link);

out6=sprintf(' %d damping_type   ',n_damping_type);
out7=sprintf(' %d uniform_dratio   ',n_uniform_dratio);
out8=sprintf(' %d table_dratio   ',n_table_dratio);
out9=sprintf(' %d table_Q   ',n_table_Q);
out10=sprintf(' %d uniform_Q   ',n_uniform_Q);

out11=sprintf(' %d material   ',n_material);

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);
disp(out7);
disp(out8);
disp(out9);
disp(out10);
disp(out11);



if(n==1)  % Matlab
    
    j=1;
    try
    for i=1:sz_ncoor(1)
        string_th{j}=sprintf('node %d %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g',...
               ncoor(i,1),ncoor(i,2),ncoor(i,3),ncoor(i,4),ncoor(i,5),...
               ncoor(i,6),ncoor(i,7),ncoor(i,8),ncoor(i,9),ncoor(i,10));        
        j=j+1;
    end
    catch
        warndlg('No nodes defined');
        return;
    end
    
    try
    for i=1:sz_pm(1)
        string_th{j}=sprintf('point_mass %d %8.4g %8.4g %8.4g %8.4g',...
            point_mass(i,1),point_mass(i,2),point_mass(i,3),point_mass(i,4),point_mass(i,5)); 
        j=j+1;       
    end
    end
    
    try
    for i=1:sz_dof_spring_property(1)
        string_th{j}=sprintf('dof_spring_property %d %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g',...
            dof_spring_property(i,1),dof_spring_property(i,2),dof_spring_property(i,3),...
            dof_spring_property(i,4),dof_spring_property(i,5),dof_spring_property(i,6),...
            dof_spring_property(i,7)); 
        j=j+1;       
    end
    end
    
    try
    for i=1:sz_dof_spring_element(1)
        string_th{j}=sprintf('dof_spring_element %d %d %d',...
            dof_spring_element(i,1),dof_spring_element(i,2),dof_spring_element(i,3));        
        j=j+1;        
    end
    end
    
    try
    for i=1:sz_rigid_link(1)
        string_th{j}=sprintf('rigid_link %d %d %d %d %d %d %d %d',...
            rigid_link(i,1),rigid_link(i,2),rigid_link(i,3),...
            rigid_link(i,4),rigid_link(i,5),rigid_link(i,6),...
            rigid_link(i,7),rigid_link(i,8)); 
        j=j+1;       
    end
    end
    
    try
    if(n_damping_type>=1)
          
          string_th{j}=sprintf('damping_type %d %d ',damping_type(1),damping_type(2));
          j=j+1;
          
          if(damping_type(1)==1 && damping_type(2)==1)

            string_th{j}=sprintf('uniform_Q %g ',uniform_Q);
            j=j+1;
                    
          end            
          if(damping_type(1)==1 && damping_type(2)==2)

            string_th{j}=sprintf('uniform_Q %g ',uniform_dratio);
            j=j+1;
                      
          end
          if(damping_type(1)==2 && damping_type(2)==1)
              
            for i=1:n_table_Q
                string_th{j}=sprintf('table_Q %g %g ',table_Q(i,1),table_Q(i,2));                
                j=j+1;    
            end
          end
          if(damping_type(1)==2 && damping_type(2)==2)
              
                for i=1:n_table_dratio
                    string_th{j}=sprintf('table_dratio %g %g',table_dratio(i,1),table_dratio(i,2)); 
                    j=j+1;
                end
          end
    
          for i=1:sz_material(1)
               string_th{j}=sprintf('material %d %8.4g %8.4g %g',...
               material(i,1),material(i,2),material(i,3),material(i,4));        
               j=j+1;        
          end           
          
    end
    end

    try
        char(string_th);
        assignin('base',FS,char(string_th));
    catch
        warndlg('Enter output filename');
        return;
    end
end    
if(n==2)  % ASCII

    [writefname, writepname] = uiputfile('*','Save model as');
    writepfname = fullfile(writepname, writefname);
    fid = fopen(writepfname,'w');
    
    try
    for i=1:sz_ncoor(1)
        fprintf(fid,'node \t %d \t %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g \n',...
            ncoor(i,1),ncoor(i,2),ncoor(i,3),ncoor(i,4),ncoor(i,5),...
            ncoor(i,6),ncoor(i,7),ncoor(i,8),ncoor(i,9),ncoor(i,10));        
    end
    end
    
    try
    for i=1:sz_pm(1)
        fprintf(fid,'point_mass \t %d \t %8.4g \t %8.4g \t %8.4g \t %8.4g \n',...
            point_mass(i,1),point_mass(i,2),point_mass(i,3),point_mass(i,4),point_mass(i,5));        
    end
    end
    
    try
    for i=1:sz_dof_spring_property(1)
        fprintf(fid,'dof_spring_property \t %d \t %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g \n',...
            dof_spring_property(i,1),dof_spring_property(i,2),dof_spring_property(i,3),...
            dof_spring_property(i,4),dof_spring_property(i,5),dof_spring_property(i,6),...
            dof_spring_property(i,7));        
    end
    end
    
 
    try
    for i=1:sz_dof_spring_element(1)
        fprintf(fid,'dof_spring_element \t %d \t %d \t %d \n',...
            dof_spring_element(i,1),dof_spring_element(i,2),dof_spring_element(i,3));   
    end
    end
    
    try
    for i=1:sz_rigid_link(1)
        fprintf(fid,'rigid_link \t %d \t %d \t %d \t %d \t %d \t %d \t %d \t %d \n',...
            rigid_link(i,1),rigid_link(i,2),rigid_link(i,3),...
            rigid_link(i,4),rigid_link(i,5),rigid_link(i,6),...
            rigid_link(i,7),rigid_link(i,8));        
    end
    end
    
    try
    if(n_damping_type>=1)
        
          fprintf(fid,'damping_type \t %d \t %d \n',damping_type(1),damping_type(2));
          
          if(damping_type(1)==1 && damping_type(2)==1)

            fprintf(fid,'uniform_Q \t %g \n',uniform_Q);
            
          end            
          if(damping_type(1)==1 && damping_type(2)==2)

            fprintf(fid,'uniform_dratio \t %g \n',uniform_dratio);
            
          end
          if(damping_type(1)==2 && damping_type(2)==1)
              
            for i=1:n_table_Q
               
                fprintf(fid,'table_Q \t %g \t %g \n',table_Q(i,1),table_Q(i,2));                
                
            end
          end
          if(damping_type(1)==2 && damping_type(2)==2)
              
                for i=1:n_table_dratio

                    fprintf(fid,'table_dratio \t %g \t %g \n',table_dratio(i,1),table_dratio(i,2)); 
            
                end
          end
    end
    end
       
    try
    for i=1:sz_material(1)
        fprintf(fid,'material \t %d \t %8.4g \t %8.4g \t %g \n',...
            material(i,1),material(i,2),material(i,3),material(i,4));   
    end
    end
    fclose(fid);

end
if(n==3)  % Excel   
       
    [writefname, writepname] = uiputfile('*.xls','Save model as');
    writepfname = fullfile(writepname, writefname);
    
    
    
      c=[cellstr(repmat('node',n_ncoor,1))    num2cell(ncoor)];
                                              
      N=8;                                  
%%%%

      progressbar;

      output_cell=c;
      
      last_write_loc=1; 
      
      size_output_cell = size(output_cell);
         xlswrite(writepfname,output_cell,...
         xlsrange([last_write_loc,1],size_output_cell));

      last_write_loc = last_write_loc + size_output_cell(1);
      
      progressbar(1/N);
                                              
%%%%      
      
      if(n_pm>=1)

         d=[cellstr(repmat('point_mass',n_pm,1))    num2cell(point_mass)];       
          
         output_cell=d; 
          
         size_output_cell = size(output_cell);
            xlswrite(writepfname,output_cell,...
            xlsrange([last_write_loc,1],size_output_cell));

         last_write_loc = last_write_loc + size_output_cell(1);      

      end
      
      progressbar(2/N);
      
%%%%           
      
      if(n_dof_spring_property>=1)

         e=[cellstr(repmat('dof_spring_property',n_dof_spring_property,1)) ...
                                            num2cell(dof_spring_property)];            
          
         output_cell=e;          
          
         size_output_cell = size(output_cell);
            xlswrite(writepfname,output_cell,...
            xlsrange([last_write_loc,1],size_output_cell));

         last_write_loc = last_write_loc + size_output_cell(1);       
      
      end
      
      progressbar(3/N);
%%%%     
      
      if(n_dof_spring_element>=1)

         f=[cellstr(repmat('dof_spring_element',n_dof_spring_element,1)) ...
                                            num2cell(dof_spring_element)];
                                                                         
         output_cell=f;          
          
         size_output_cell = size(output_cell);
            xlswrite(writepfname,output_cell,...
            xlsrange([last_write_loc,1],size_output_cell));

         last_write_loc = last_write_loc + size_output_cell(1);
      
      end

      progressbar(4/N);
%%%%           
    
      if(n_rigid_link>=1)

         g=[cellstr(repmat('rigid_link',n_rigid_link,1)) ...
                                            num2cell(rigid_link)];           
                    
         output_cell=g;          
          
         size_output_cell = size(output_cell);
            xlswrite(writepfname,output_cell,...
            xlsrange([last_write_loc,1],size_output_cell));

         last_write_loc = last_write_loc + size_output_cell(1); 

      end
      
      progressbar(5/N);
      
%%%%

      if(n_damping_type>=1)
          

         h=[cellstr(repmat('damping_type',n_damping_type,1)) ...
                                            num2cell(damping_type)];           
                    
         output_cell=h;          
          
         size_output_cell = size(output_cell);
            xlswrite(writepfname,output_cell,...
            xlsrange([last_write_loc,1],size_output_cell));

         last_write_loc = last_write_loc + size_output_cell(1); 
         
          
          
          if(damping_type(1)==1 && damping_type(2)==2)
              
            i=[cellstr(repmat('uniform_dratio',n_uniform_dratio,1)) ...
                                            num2cell(uniform_dratio)];                 
          end
          if(damping_type(1)==2 && damping_type(2)==2)
              
            i=[cellstr(repmat('table_dratio',n_table_dratio,1)) ...
                                            num2cell(table_dratio)];            
          
          end
          if(damping_type(1)==2 && damping_type(2)==1)
          
            i=[cellstr(repmat('table_Q',n_table_Q,1)) ...
                                            num2cell(table_Q)];            
              
          end
          if(damping_type(1)==1 && damping_type(2)==1)
          
            i=[cellstr(repmat('uniform_Q',n_uniform_Q,1)) ...
                                            num2cell(uniform_Q)];                
          
          end          
         
         output_cell=i;          
          
         size_output_cell = size(output_cell);
            xlswrite(writepfname,output_cell,...
            xlsrange([last_write_loc,1],size_output_cell));

         last_write_loc = last_write_loc + size_output_cell(1);           
      
         progressbar(6/N);         
         
      end

      if(n_material>=1)
 
         j=[cellstr(repmat('material',n_material,1)) ...
                                            num2cell(material)];            
          
         output_cell=j;          
          
         size_output_cell = size(output_cell);
            xlswrite(writepfname,output_cell,...
            xlsrange([last_write_loc,1],size_output_cell));
 
         last_write_loc = last_write_loc + size_output_cell(1);       
      
      end      
      
%%%%
      
      pause(0.1);
      progressbar(1);
%%%%
      
end

h = msgbox('Export Complete');
