function varargout = vibrationdata_PSD_plot_multiple(varargin)
% VIBRATIONDATA_PSD_PLOT_MULTIPLE MATLAB code for vibrationdata_PSD_plot_multiple.fig
%      VIBRATIONDATA_PSD_PLOT_MULTIPLE, by itself, creates a new VIBRATIONDATA_PSD_PLOT_MULTIPLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PSD_PLOT_MULTIPLE returns the handle to a new VIBRATIONDATA_PSD_PLOT_MULTIPLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PSD_PLOT_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PSD_PLOT_MULTIPLE.M with the given input arguments.
%
%      VIBRATIONDATA_PSD_PLOT_MULTIPLE('Property','Value',...) creates a new VIBRATIONDATA_PSD_PLOT_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_PSD_plot_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_PSD_plot_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_PSD_plot_multiple

% Last Modified by GUIDE v2.5 23-Jul-2021 16:21:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_PSD_plot_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_PSD_plot_multiple_OutputFcn, ...
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


% --- Executes just before vibrationdata_PSD_plot_multiple is made visible.
function vibrationdata_PSD_plot_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_PSD_plot_multiple (see VARARGIN)

% Choose default command line output for vibrationdata_PSD_plot_multiple
handles.output = hObject;

setappdata(0,'pflag',0);

listbox_num_Callback(hObject, eventdata, handles);
listbox_ylab_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_PSD_plot_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_PSD_plot_multiple_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_PSD_plot_multiple);


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    



num=get(handles.listbox_num,'Value');

%%

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
        leg{i} = strrep(leg{i},'_',' ');
    end 

catch
    warndlg('Input Arrays read failed');
    return;
end


setappdata(0,'array_name',array_name);


%%

%%%



nx_type=get(handles.listbox_xaxis,'Value');
ny_type=get(handles.listbox_yaxis,'Value');
ng=get(handles.listbox_grid,'Value');
nx_limits=get(handles.listbox_xplotlimits,'Value');
ny_limits=get(handles.listbox_yplotlimits,'Value');
nlegend=get(handles.listbox_legend,'Value');
%

ngrms=get(handles.listbox_grms,'Value');

%%%

cmap(1,:)=[0 0 0.8];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];      % gold
cmap(16,:)=[0 0.8 0.8];     % turquoise

ix=get(handles.listbox_ylab,'Value');

if(ix==1)
    su='GRMS';
end
if(ix==2)
    su='lbf rms';
end
if(ix==3)
    su='psi rms';
end
if(ix==4)
    su='psi rms';
end
if(ix==5)
    su='rms';
end

if(nx_limits==1)
     xmin=0;
     xmax=1.0e+90;
else
     xs1=get(handles.edit_xmin,'String');
     if isempty(xs1)
        warndlg('Enter xmin','Warning');
        return;
     else
        xmin=str2num(xs1);
     end
     
     xs2=get(handles.edit_xmax,'String');
     if isempty(xs2)
        warndlg('Enter xmax','Warning');
        return;
     else
        xmax=str2num(xs2);
     end
     
    setappdata(0,'xs1',xs1);
    setappdata(0,'xs2',xs2);  
 
end
fmin=xmin;
fmax=xmax;

if(ny_limits==2)

     ys1=get(handles.edit_ymin,'String');
     if isempty(ys1)
        warndlg('Enter ymin','Warning');
        return;
     else
        ymin=str2num(ys1);
     end
     
     ys2=get(handles.edit_ymax,'String');
     if isempty(ys2)
        warndlg('Enter ymax','Warning');
        return;
     else
        ymax=str2num(ys2);
     end
     
    setappdata(0,'ys1',ys1);
    setappdata(0,'ys2',ys2);  
 
end
%


if(num>=1)
    try        
        FS1=array_name{1};
        THM1=evalin('base',FS1);
    catch
        warndlg('Array 1 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM1(1,1)<1.0e-20)
            THM1(1,:)=[];
        end
        
    end 
    if(nlegend<=2)
        slegend1=leg{1};
        if(ngrms==1)
            
            ff=THM1(:,1);
            aa=THM1(:,2);
            ddd=diff(ff);
            
            [~,grms1] = calculate_PSD_slopes_fmin_fmax(THM1(:,1),THM1(:,2),fmin,fmax);
            slegend1=sprintf('%s  %6.3g %s ',slegend1,grms1,su);
        end
    end    
end    

if(num>=2)
    try        
        FS2=array_name{2};
        THM2=evalin('base',FS2);
    catch
        warndlg('Array 2 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        try
            if(THM2(1,1)<1.0e-20)
                THM2(1,:)=[];
            end
        catch
            size(THM2)
            THM2
            warndlg('THM2 error');
            return;
        end
    end 
    if(nlegend<=2)
        slegend2=leg{2};
        if(ngrms==1)
            [~,grms2] = calculate_PSD_slopes_fmin_fmax(THM2(:,1),THM2(:,2),fmin,fmax);
            slegend2=sprintf('%s  %6.3g %s ',slegend2,grms2,su);
        end        
    end
end  


if(num>=3)
    try        
        FS3=array_name{3};
        THM3=evalin('base',FS3);
    catch
        warndlg('Array 3 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM3(1,1)<1.0e-20)
            THM3(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend3=leg{3};
        if(ngrms==1)
            [~,grms3] = calculate_PSD_slopes_fmin_fmax(THM3(:,1),THM3(:,2),fmin,fmax);
            slegend3=sprintf('%s  %6.3g %s ',slegend3,grms3,su);
        end         
    end
end  

if(num>=4)
    try        
        FS4=array_name{4};
        THM4=evalin('base',FS4);
    catch
        warndlg('Array 4 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM4(1,1)<1.0e-20)
            THM4(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend4=leg{4};
        if(ngrms==1)
            [~,grms4] = calculate_PSD_slopes_fmin_fmax(THM4(:,1),THM4(:,2),fmin,fmax);
            slegend4=sprintf('%s  %6.3g %s ',slegend4,grms4,su);
        end         
    end
end  
if(num>=5)
    try        
        FS5=array_name{5};
        THM5=evalin('base',FS5);
    catch
        warndlg('Array 5 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM5(1,1)<1.0e-20)
            THM5(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend5=leg{5};
        if(ngrms==1)
            [~,grms5] = calculate_PSD_slopes_fmin_fmax(THM5(:,1),THM5(:,2),fmin,fmax);
            slegend5=sprintf('%s  %6.3g %s ',slegend5,grms5,su);
        end          
    end
end  
if(num>=6)
    try        
        FS6=array_name{6};
        THM6=evalin('base',FS6);
    catch
        warndlg('Array 6 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM6(1,1)<1.0e-20)
            THM6(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend6=leg{6};
        if(ngrms==1)
            [~,grms6] = calculate_PSD_slopes_fmin_fmax(THM6(:,1),THM6(:,2),fmin,fmax);
            slegend6=sprintf('%s  %6.3g %s ',slegend6,grms6,su);
        end          
    end
end  

if(num>=7)
    try        
        FS7=array_name{7};
        THM7=evalin('base',FS7);
    catch
        warndlg('Array 7 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM7(1,1)<1.0e-20)
            THM7(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend7=leg{7};
        if(ngrms==1)
            [~,grms7] = calculate_PSD_slopes_fmin_fmax(THM7(:,1),THM7(:,2),fmin,fmax);
            slegend7=sprintf('%s  %6.3g %s ',slegend7,grms7,su);
        end          
    end
end
if(num>=8)
    try        
        FS8=array_name{8};
        THM8=evalin('base',FS8);
    catch
        warndlg('Array 8 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM8(1,1)<1.0e-20)
            THM8(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend8=leg{8};
        if(ngrms==1)
            [~,grms8] = calculate_PSD_slopes_fmin_fmax(THM8(:,1),THM8(:,2),fmin,fmax);
            slegend8=sprintf('%s  %6.3g %s ',slegend8,grms8,su);
        end          
    end
end 

if(num>=9)
    try        
        FS9=array_name{9};
        THM9=evalin('base',FS9);
    catch
        warndlg('Array 9 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM9(1,1)<1.0e-20)
            THM9(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend9=leg{9};
        if(ngrms==1)
            [~,grms9] = calculate_PSD_slopes_fmin_fmax(THM9(:,1),THM9(:,2),fmin,fmax);
            slegend9=sprintf('%s  %6.3g %s ',slegend9,grms9,su);
        end          
    end
end 

if(num>=10)
    try        
        FS10=array_name{10};
        THM10=evalin('base',FS10);
    catch
        warndlg('Array 10 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM10(1,1)<1.0e-20)
            THM10(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend10=leg{10};
        if(ngrms==1)
            [~,grms10] = calculate_PSD_slopes_fmin_fmax(THM10(:,1),THM10(:,2),fmin,fmax);
            slegend10=sprintf('%s  %6.3g %s ',slegend10,grms10,su);
        end          
    end
end 

if(num>=11)
    try        
        FS11=array_name{11};
        THM11=evalin('base',FS11);
    catch
        warndlg('Array 11 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM11(1,1)<1.0e-20)
            THM11(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend11=leg{11};
        if(ngrms==1)
            [~,grms11] = calculate_PSD_slopes_fmin_fmax(THM11(:,1),THM11(:,2),fmin,fmax);
            slegend11=sprintf('%s  %6.3g %s ',slegend11,grms11,su);
        end          
    end
end 

if(num>=12)
    try        
        FS12=array_name{12};
        THM12=evalin('base',FS12);
    catch
        warndlg('Array 12 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM12(1,1)<1.0e-20)
            THM12(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend12=leg{12};
        if(ngrms==1)
            [~,grms12] = calculate_PSD_slopes_fmin_fmax(THM12(:,1),THM12(:,2),fmin,fmax);
            slegend12=sprintf('%s  %6.3g %s ',slegend12,grms12,su);
        end          
    end
end 

if(num>=13)
    try        
        FS13=array_name{13};
        THM13=evalin('base',FS13);
    catch
        warndlg('Array 13 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM13(1,1)<1.0e-20)
            THM13(1,:)=[];
        end    
    end 
    if(nlegend<=2)
        slegend13=leg{13};
        if(ngrms==1)
            [~,grms13] = calculate_PSD_slopes_fmin_fmax(THM13(:,1),THM13(:,2),fmin,fmax);
            slegend13=sprintf('%s  %6.3g %s ',slegend13,grms13,su);
        end          
    end
end 

%%%%

stitle=get(handles.edit_title,'String');
sxlabel=get(handles.edit_xlabel,'String');
sylabel=get(handles.edit_ylabel,'String');

stitle=strrep(stitle,'_',' ');

%

%

xpm1=0;
xpm2=0;
xpm3=0;
xpm4=0;
xpm5=0;
xpm6=0;
xpm7=0;

xmin1=1.e+99;
xmin2=1.e+99;
xmin3=1.e+99;
xmin4=1.e+99;
xmin5=1.e+99;
xmin6=1.e+99;
xmin7=1.e+99;

xmax1=-xmin1;
xmax2=-xmin2;
xmax3=-xmin3;
xmax4=-xmin4;
xmax5=-xmin5;
xmax6=-xmin6;
xmax7=-xmin7;

ymin1=1.e+99;
ymin2=1.e+99;
ymin3=1.e+99;
ymin4=1.e+99;
ymin5=1.e+99;
ymin6=1.e+99;
ymin7=1.e+99;
 
ymax1=-ymin1;
ymax2=-ymin2;
ymax3=-ymin3;
ymax4=-ymin4;
ymax5=-ymin5;
ymax6=-ymin6;
ymax7=-ymin7;




fig_num=get(handles.listbox_figure_number,'Value');

out1=sprintf('\n fig_num=%d',fig_num);
disp(out1);


%
if(num>=1)
    
    
    hp=figure(fig_num);
    hold on;
    
    if(nlegend==3)
        plot(THM1(:,1),THM1(:,2),'Color',cmap(1,:));
    else  
        plot(THM1(:,1),THM1(:,2),'Color',cmap(1,:),'DisplayName',slegend1);
    end
    
    [x1]=get(gca,'xlim');

    xpm1=min(x1);
    
    xmin1=THM1(1,1);
    xmax1=max(x1);
    
    ymin1=min(THM1(:,2));
    ymax1=max(THM1(:,2));    
    
end
if(num>=2)
    if(nlegend==3)
        plot(THM2(:,1),THM2(:,2),'Color',cmap(2,:));
    else  
        plot(THM2(:,1),THM2(:,2),'Color',cmap(2,:),'DisplayName',slegend2);
    end
    
    [x2]=get(gca,'xlim');
    
    xpm2=min(x2);
    
    xmin2=THM2(1,1);
    xmax2=max(x2);

    ymin2=min(THM2(:,2));
    ymax2=max(THM2(:,2));        
    
end
if(num>=3)
    if(nlegend==3)
        plot(THM3(:,1),THM3(:,2),'Color',cmap(3,:));
    else  
        plot(THM3(:,1),THM3(:,2),'Color',cmap(3,:),'DisplayName',slegend3);
    end
    
    [x3]=get(gca,'xlim');
    
    xpm3=min(x3);
    
    xmin3=THM3(1,1);
    xmax3=max(x3);
    
    ymin3=min(THM3(:,2));
    ymax3=max(THM3(:,2));        
    
end
if(num>=4)
    if(nlegend==3)
        plot(THM4(:,1),THM4(:,2),'Color',cmap(4,:));
    else  
        plot(THM4(:,1),THM4(:,2),'Color',cmap(4,:),'DisplayName',slegend4);
    end
    
    [x4]=get(gca,'xlim');
    
    xpm4=min(x4);
    
    xmin4=THM4(1,1);
    xmax4=max(x4);
    
    ymin4=min(THM4(:,2));
    ymax4=max(THM4(:,2));        
    
end
if(num>=5)
    if(nlegend==3)
        plot(THM5(:,1),THM5(:,2),'Color',cmap(5,:));
    else  
        plot(THM5(:,1),THM5(:,2),'Color',cmap(5,:),'DisplayName',slegend5);
    end
    
    [x5]=get(gca,'xlim');
    
    xpm5=min(x5);
    
    xmin5=THM5(1,1);
    xmax5=max(x5);
    
    ymin5=min(THM5(:,2));
    ymax5=max(THM5(:,2));        
    
end
if(num>=6)
    if(nlegend==3)
        plot(THM6(:,1),THM6(:,2),'Color',cmap(6,:));
    else  
        plot(THM6(:,1),THM6(:,2),'Color',cmap(6,:),'DisplayName',slegend6);
    end
    
    [x6]=get(gca,'xlim');
    
    xpm6=min(x6);
    
    xmin6=THM6(1,1);
    xmax6=max(x6);
    
    ymin6=min(THM6(:,2));
    ymax6=max(THM6(:,2));        
    
end
if(num>=7)
    if(nlegend==3)
        plot(THM7(:,1),THM7(:,2),'Color',cmap(7,:));
    else  
        plot(THM7(:,1),THM7(:,2),'Color',cmap(7,:),'DisplayName',slegend7);
    end
    
    [x7]=get(gca,'xlim');
    
    xpm7=min(x7);
    
    xmin7=THM7(1,1);
    xmax7=max(x7);
    
    ymin7=min(THM7(:,2));
    ymax7=max(THM7(:,2));        
    
end

if(num>=8)
    if(nlegend==3)
        plot(THM8(:,1),THM8(:,2),'Color',cmap(8,:));
    else  
        plot(THM8(:,1),THM8(:,2),'Color',cmap(8,:),'DisplayName',slegend8);
    end
    
    [x8]=get(gca,'xlim');
    
    xpm8=min(x8);
    
    xmin8=THM8(1,1);
    xmax8=max(x8);
    
    ymin8=min(THM8(:,2));
    ymax8=max(THM8(:,2));        
    
end

if(num>=9)
    if(nlegend==3)
        plot(THM9(:,1),THM9(:,2),'Color',cmap(9,:));
    else  
        plot(THM9(:,1),THM9(:,2),'Color',cmap(9,:),'DisplayName',slegend9);
    end
    
    [x9]=get(gca,'xlim');
    
    xpm9=min(x9);
    
    xmin9=THM9(1,1);
    xmax9=max(x9);
    
    ymin9=min(THM9(:,2));
    ymax9=max(THM9(:,2));        
    
end

if(num>=10)
    if(nlegend==3)
        plot(THM10(:,1),THM10(:,2),'Color',cmap(10,:));
    else  
        plot(THM10(:,1),THM10(:,2),'Color',cmap(10,:),'DisplayName',slegend10);
    end
    
    [x10]=get(gca,'xlim');
    
    xpm10=min(x10);
    
    xmin10=THM10(1,1);
    xmax10=max(x10);
    
    ymin10=min(THM10(:,2));
    ymax10=max(THM10(:,2));        
    
end

if(num>=11)
    if(nlegend==3)
        plot(THM11(:,1),THM11(:,2),'Color',cmap(11,:));
    else  
        plot(THM11(:,1),THM11(:,2),'Color',cmap(11,:),'DisplayName',slegend11);
    end
    
    [x11]=get(gca,'xlim');
    
    xpm11=min(x11);
    
    xmin11=THM11(1,1);
    xmax11=max(x11);
    
    ymin11=min(THM11(:,2));
    ymax11=max(THM11(:,2));        
    
end

if(num>=12)
    if(nlegend==3)
        plot(THM12(:,1),THM12(:,2),'Color',cmap(12,:));
    else  
        plot(THM12(:,1),THM12(:,2),'Color',cmap(12,:),'DisplayName',slegend12);
    end
    
    [x12]=get(gca,'xlim');
    
    xpm12=min(x12);
    
    xmin12=THM12(1,1);
    xmax12=max(x12);
    
    ymin12=min(THM12(:,2));
    ymax12=max(THM12(:,2));        
    
end

if(num>=13)
    if(nlegend==3)
        plot(THM13(:,1),THM13(:,2),'Color',cmap(13,:));
    else  
        plot(THM13(:,1),THM13(:,2),'Color',cmap(13,:),'DisplayName',slegend13);
    end
    
    [x13]=get(gca,'xlim');
    
    xpm13=min(x13);
    
    xmin13=THM13(1,1);
    xmax13=max(x13);
    
    ymin13=min(THM13(:,2));
    ymax13=max(THM13(:,2));        
    
end


try
    out1=sprintf(' xmin=%8.4g  xmax=%8.4g',xmin,xmax);
    disp(out1);
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
title(stitle);
xlabel(sxlabel);
ylabel(sylabel);

%
grid off;
%

if(ng==1)
    
    grid on;
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
    
 
    if(nx_type==1 && ny_type==2)
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin','YScale','log');
    end
    if(nx_type==2 && ny_type==1)
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
    end
    if(nx_type==2 && ny_type==2)
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','log');
    end    
    
end    

try
    out1=sprintf(' xmin=%8.4g  xmax=%8.4g',xmin,xmax);
    disp(out1);
catch
end

if(ng==2)
    
    grid on;
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
 

    if(nx_type==1 && ny_type==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','lin','YScale','lin');
    end    
    if(nx_type==1 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','lin','YScale','log');
    end
    if(nx_type==2 && ny_type==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','log','YScale','lin');
    end
    if(nx_type==2 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','log','YScale','log');
    end    
    
end



if(ng==3)
 
    if(nx_type==1 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','lin','YScale','log');
    end
    if(nx_type==2 && ny_type==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','log','YScale','lin');
    end
    if(nx_type==2 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','log','YScale','log');
    end    
    
end

%

if(nx_type==1)
    xx1=[xpm1,xpm2,xpm3,xpm4,xpm5,xpm6,xpm7 ];
else
    xx1=[xmin1,xmin2,xmin3,xmin4,xmin5,xmin6,xmin7 ];
end


xx2=[xmax1,xmax2,xmax3,xmax4,xmax5,xmax6,xmax7 ];

yy1=[ymin1,ymin2,ymin3,ymin4,ymin5,ymin6,ymin7 ];
yy2=[ymax1,ymax2,ymax3,ymax4,ymax5,ymax6,ymax7 ];

%

if(nx_limits==1) % automatic
    xmin=min(xx1);
    xmax=max(xx2);
   
    xlim([xmin,xmax]);
        
    [xtt,xTT,iflag]=xtick_label(xmin,xmax);    
   
    if(iflag==1)
        try
            xmin=min(xtt);
            xmax=max(xtt);

            xlim([xmin,xmax]);
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        catch    
        end    
    end    
end



if(nx_limits==2 ) % manual 
    
    xlim([xmin,xmax]);
    
    if(nx_type==2) % manual
        
        try
            [xtt,xTT,iflag]=xtick_label(xmin,xmax);
            
            if(iflag==1)
                set(gca,'xtick',xtt);
                set(gca,'XTickLabel',xTT);
            end
        catch    
        end
    end    
end

 

if(ny_limits==1 && ny_type==2)  % automatic log
    
    yymin=min(yy1);
    yymax=max(yy2);
    
    try
        [ymin,ymax]=ytick_log(yymin,yymax);
        ylim([ymin,ymax]);
    catch    
    end    
end    


if(ny_limits==2)
     
     ys1=get(handles.edit_ymin,'String');
 
     if isempty(ys1)
        warndlg('Enter ymin','Warning');
        return;
     else
        ymin=str2num(ys1);
     end
     
     ys2=get(handles.edit_ymax,'String');
     if isempty(ys2)
        warndlg('Enter ymax','Warning');
        return;
     else
        ymax=str2num(ys2);
     end 
     ylim([ymin,ymax]);
     
     setappdata(0,'ys1',ys1);
     setappdata(0,'ys2',ys2);     
end


if(nlegend<=2)
    legend show;
    if(nlegend==2)
        legend('location','eastoutside')
        set(hp, 'Position', [0 0 1600 900]);
        set(gca,'Fontsize',20);
    end    
end  

hold off;

setappdata(0,'pflag',1);

pname='a.emf';
print(hp,pname,'-dmeta','-r300');        
   
try
   ttt=get(handles.edit_save_name,'String'); 
   ttt=strrep(ttt,'-','_');
   ttt=strrep(ttt,' ','_');
   ttt=strrep(ttt,',','_');
   ttt=sprintf('%s.fig',ttt);
   savefig(ttt);
catch
end    

pushbutton_save_model_Callback(hObject, eventdata, handles);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%



% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    A=get(handles.uitable_data,'Data');
    PSDplot.A=A;   
catch
end


try
    title=get(handles.edit_title,'String');
    PSDplot.title=title;   
catch
end

try
    xlabel=get(handles.edit_xlabel,'String');
    PSDplot.xlabel=xlabel;   
catch
end

try
    ylabel=get(handles.edit_ylabel,'String');
    PSDplot.ylabel=ylabel;   
catch
end

try
    num=get(handles.listbox_num,'Value');
    PSDplot.num=num;   
catch
end


try
    array_name=getappdata(0,'array_name');
catch
    warndlg('array_name error');
    return;
end

try 
    if(num>=1)
        THM1=evalin('base',array_name{1});
        PSDplot.THM1=THM1;
        PSDplot.FS1=array_name{1};
    end
    if(num>=2)
        THM2=evalin('base',array_name{2});
        PSDplot.THM2=THM2;
        PSDplot.FS2=array_name{2};        
    end
    if(num>=3)
        THM3=evalin('base',array_name{3});
        PSDplot.THM3=THM3;
        PSDplot.FS3=array_name{3};           
    end  
    if(num>=4)
        THM4=evalin('base',array_name{4});
        PSDplot.THM4=THM4;
        PSDplot.FS4=array_name{4};           
    end   
    if(num>=5)
        THM5=evalin('base',array_name{5});
        PSDplot.THM5=THM5;
        PSDplot.FS5=array_name{5};           
    end     
    if(num>=6)
        THM6=evalin('base',array_name{6});
        PSDplot.THM6=THM6;
        PSDplot.FS6=array_name{6};           
    end  
    if(num>=7)
        THM7=evalin('base',array_name{7});
        PSDplot.THM7=THM7;
        PSDplot.FS7=array_name{7};           
    end        
catch
    warndlg('Save error 1');
    return;
end 




try
    leg=get(handles.listbox_legend,'Value');
    PSDplot.leg=leg;   
catch
end

try
    grid=get(handles.listbox_grid,'Value');
    PSDplot.grid=grid;   
catch
end


try
    fig_num=get(handles.listbox_figure_num,'Value');
    PSDplot.fig_num=fig_num;   
catch
end

try
    nxaxis=get(handles.listbox_xaxis,'Value');
    PSDplot.nxaxis=nxaxis;  
catch
end

try
    nyaxis=get(handles.listbox_yaxis,'Value');
    PSDplot.nyaxis=nyaxis;  
catch
end

try
    xplotlimits=get(handles.listbox_xplotlimits,'Value');
    PSDplot.xplotlimits=xplotlimits;  
catch
end

try
    yplotlimits=get(handles.listbox_yplotlimits,'Value');
    PSDplot.yplotlimits=yplotlimits;  
catch
end


try
    xmin=get(handles.edit_xmin,'String');
    PSDplot.xmin=xmin;  
catch
end

try
    xmax=get(handles.edit_xmax,'String');
    PSDplot.xmax=xmax;  
catch
end

try
    ymin=get(handles.edit_ymin,'String');
    PSDplot.ymin=ymin;  
catch
end

try
    ymax=get(handles.edit_ymax,'String');
    PSDplot.ymax=ymax;  
catch
end


% % %
 
structnames = fieldnames(PSDplot, '-full'); % fields in the struct
  
% % %
 
 %%%   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
   %%%     elk=sprintf('%s%s',writepname,writefname);
%%%

try
   name=get(handles.edit_save_name,'String');
   name=strrep(name,' ','');
   set(handles.edit_save_name,'String',name);
   PSDplot.name=name;  
   writefname=name;
catch
   warndlg('Enter plot output name');
   return;
end

if(isempty(name))
   warndlg('Enter plot output name');
   return;    
end

    name=strrep(name,'.mat','');
    name=strrep(name,'_plot','');
    name2=sprintf('%s_plot',name);
    name=sprintf('%s_plot.mat',name);
    
    
    kflag=0;
    
    try
        fid = fopen(name,'r');
        kflag=1;
        
        if(fid>0)
            out1=sprintf('%s   already exists.  Replace? ',name);
            choice = questdlg(out1,'Options','Yes','No','No');
        
% Handle response
 
            switch choice
                case 'Yes'                        
                    kflag=0; 
            end 
        end
        
    catch
    end
    
    if(fid==-1)
        kflag=0;
    end

    
%%%
    
    if(kflag==0)
        try
        save(name, 'PSDplot'); 
        catch
            warndlg('Save error 2');
            return;
        end
    end    
    setappdata(0,'kflag',kflag);

    
%%%@@@@@

    disp('**ref b**');
    
  
    
    try
        filename = 'vibrationdata_PSD_plot_multiple_load_list.txt';
        THM=importdata(filename);
        
 %        THM
        

    catch
         THM=[];
         disp('no read 1');       
    end
    
   [THM,nrows]=THM_save(THM,name2);

%    NTHM
        
    disp('**ref c**');
        
 
    fileID = fopen(filename,'w');

    for row = 1:nrows
        fprintf(fileID,'%s\n',char(THM{row,:}));
        char(THM{row,:});
    end
    fclose(fileID);
    
    
%%%@@@@@
    
pflag=getappdata(0,'pflag');   

kflag=getappdata(0,'kflag');



    if(kflag==0)
        out1=sprintf(' Save Complete: %s \n Plot file saved as: a.emf ',name); 
    else
        out1=sprintf(' Plot file saved as: a.emf ');        
    end   

    
msgbox(out1);

%%%%%%%%%%%%%%%%%%%%


function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    
    [filename, pathname] = uigetfile('*.mat');

    setappdata(0,'filename',filename);
    setappdata(0,'pathname',pathname);
 
    load_core(hObject, eventdata, handles)

catch
end
    
    

function load_core(hObject, eventdata, handles)

disp('*** ref 1 ***');

setappdata(0,'pflag',0);

filename=strtrim(getappdata(0,'filename'))
% pathname=getappdata(0,'pathname')

try
%    NAME = [pathname,filename];
    NAME=filename;
    struct=load(NAME);
catch    
    NAME
    warndlg('load failed');
    return;
end


structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try

   PSDplot=evalin('base','PSDplot');

catch
   warndlg(' evalin failed ');
   return;
end


%%%%%%%%%%%%%%%%

try
    num=PSDplot.num;     
    set(handles.listbox_num,'Value',num);  
catch
end


listbox_num_Callback(hObject, eventdata, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(PSDplot.FS1);
 
    iflag=0;
    
    try
        temp=evalin('base',FS1);
        ss=sprintf('Replace %s with Previously Saved Array',FS1);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM1=PSDplot.THM1;
            assignin('base',FS1,THM1); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS2=strtrim(PSDplot.FS2);
 
    iflag=0;
    
    try
        temp=evalin('base',FS2);
        ss=sprintf('Replace %s with Previously Saved Array',FS2);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM2=PSDplot.THM2;
            assignin('base',FS2,THM2); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    FS3=strtrim(PSDplot.FS3);
 
    iflag=0;
    
    try
        temp=evalin('base',FS3);
        ss=sprintf('Replace %s with Previously Saved Array',FS3);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM3=PSDplot.THM3;
            assignin('base',FS3,THM3); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS4=strtrim(PSDplot.FS4);
 
    iflag=0;
    
    try
        temp=evalin('base',FS4);
        ss=sprintf('Replace %s with Previously Saved Array',FS4);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM4=PSDplot.THM4;
            assignin('base',FS4,THM4); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS5=strtrim(PSDplot.FS5);
 
    iflag=0;
    
    try
        temp=evalin('base',FS5);
        ss=sprintf('Replace %s with Previously Saved Array',FS5);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM5=PSDplot.THM5;
            assignin('base',FS5,THM5); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS6=strtrim(PSDplot.FS6);
 
    iflag=0;
    
    try
        temp=evalin('base',FS6);
        ss=sprintf('Replace %s with Previously Saved Array',FS6);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM6=PSDplot.THM6;
            assignin('base',FS6,THM6); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS7=strtrim(PSDplot.FS7);
 
    iflag=0;
    
    try
        temp=evalin('base',FS7);
        ss=sprintf('Replace %s with Previously Saved Array',FS7);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM7=PSDplot.THM7;
            assignin('base',FS7,THM7); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

try
    A=PSDplot.A;       
    set(handles.uitable_data,'Data',A);
catch
end


try
    title=PSDplot.title;       
    set(handles.edit_title,'String',title);
catch
end

try
    xlabel=PSDplot.xlabel;    
    set(handles.edit_xlabel,'String',xlabel);   
catch
end

try
    ylabel=PSDplot.ylabel;       
    set(handles.edit_ylabel,'String',ylabel);
catch
end



try
    leg=PSDplot.leg;    
    set(handles.listbox_legend,'Value',leg);   
catch
end

try
    grid=PSDplot.grid;     
    set(handles.listbox_grid,'Value',grid);  
catch
end


try
    fig_num=PSDplot.fig_num;      
    set(handles.listbox_figure_num,'Value'); 
catch
end

try
    nxaxis=PSDplot.nxaxis;      
    set(handles.listbox_xaxis,'Value',nxaxis);
catch
end

try
    nyaxis=PSDplot.nyaxis;    
    set(handles.listbox_yaxis,'Value',nyaxis);  
catch
end

try
    xplotlimits=PSDplot.xplotlimits;      
    set(handles.listbox_xplotlimits,'Value',xplotlimits);
catch
end
listbox_xplotlimits_Callback(hObject, eventdata, handles);

try
    yplotlimits=PSDplot.yplotlimits;      
    set(handles.listbox_yplotlimits,'Value',yplotlimits);
catch
end
listbox_yplotlimits_Callback(hObject, eventdata, handles);


try
    xmin=PSDplot.xmin;    
    set(handles.edit_xmin,'String',xmin);  
catch
end

try
    xmax=PSDplot.xmax;    
    set(handles.edit_xmax,'String',xmax);  
catch
end

try
    ymin=PSDplot.ymin;     
    set(handles.edit_ymin,'String',ymin); 
catch
end

try
    ymax=PSDplot.ymax;     
    set(handles.edit_ymax,'String',ymax); 
catch
end

try
   name=PSDplot.name;     
   name=strrep(name,' ','');
   set(handles.edit_save_name,'String',name);      
catch
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


% --- Executes on selection change in listbox_yaxis.
function listbox_yaxis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yaxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yaxis


% --- Executes during object creation, after setting all properties.
function listbox_yaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits.
function listbox_yplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits
n=get(handles.listbox_yplotlimits,'Value');

if(n==1)
    set(handles.edit_ymin,'Enable','off');
    set(handles.edit_ymax,'Enable','off');   
else
    set(handles.edit_ymin,'Enable','on');
    set(handles.edit_ymax,'Enable','on');  
end

% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_xaxis.
function listbox_xaxis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xaxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xaxis


% --- Executes during object creation, after setting all properties.
function listbox_xaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xlabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xlabel as text
%        str2double(get(hObject,'String')) returns contents of edit_xlabel as a double


% --- Executes during object creation, after setting all properties.
function edit_xlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_xplotlimits.
function listbox_xplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xplotlimits

n=get(handles.listbox_xplotlimits,'Value');

if(n==1)
    set(handles.edit_xmin,'Enable','off');
    set(handles.edit_xmax,'Enable','off'); 
else
    set(handles.edit_xmin,'Enable','on');
    set(handles.edit_xmax,'Enable','on');  
end



% --- Executes during object creation, after setting all properties.
function listbox_xplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmin as text
%        str2double(get(hObject,'String')) returns contents of edit_xmin as a double


% --- Executes during object creation, after setting all properties.
function edit_xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax as a double


% --- Executes during object creation, after setting all properties.
function edit_xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_legend.
function listbox_legend_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_legend contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_legend


% --- Executes during object creation, after setting all properties.
function listbox_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox6.
function listbox6_Callback(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox6


% --- Executes during object creation, after setting all properties.
function listbox6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

try
    set(handles.uitable_data,'Data',data_s);
catch
end

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


% --- Executes on selection change in listbox_grid.
function listbox_grid_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_grid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_grid


% --- Executes during object creation, after setting all properties.
function listbox_grid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_figure_number.
function listbox_figure_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_figure_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_figure_number


% --- Executes during object creation, after setting all properties.
function listbox_figure_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
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


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
if(Nrows>1)


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
            data_s{i,j}='';
            try
                data_s{i,j}=A{i,j};
            catch
            end
            
        end    
    end   
 
end
 
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
 
end



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


% --- Executes on button press in pushbutton_smc.
function pushbutton_smc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_smc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%

    smc_s_016_atp=[  20   0.0053
                      150   0.04
                      800   0.04
                     2000   0.0064];

    smc_s_016_qtp=[smc_s_016_atp(:,1) smc_s_016_atp(:,2)*4];
        
    assignin('base', 'smc_s_016_atp', smc_s_016_atp);   
    assignin('base', 'smc_s_016_qtp', smc_s_016_qtp);       

%%%%%%%%%%%%%%%%%%%%


%%   [filename, pathname] = uigetfile('*.mat', 'Select plot save file');

%%   NAME = [pathname,filename];

NAME='smc_test_levels_plot';

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

   PSDplot=evalin('base','PSDplot');

catch
   warndlg(' evalin failed ');
   return;
end


%%%%%%%%%%%%%%%%

try
    num=PSDplot.num;     
    set(handles.listbox_num,'Value',num);  
catch
end


listbox_num_Callback(hObject, eventdata, handles);

%

try
    A=PSDplot.A;       
    set(handles.uitable_data,'Data',A);
catch
end


try
    title=PSDplot.title;       
    set(handles.edit_title,'String',title);
catch
end

try
    xlabel=PSDplot.xlabel;    
    set(handles.edit_xlabel,'String',xlabel);   
catch
end

try
    ylabel=PSDplot.ylabel;       
    set(handles.edit_ylabel,'String',ylabel);
catch
end



try
    leg=PSDplot.leg;    
    set(handles.listbox_legend,'Value',leg);   
catch
end

try
    grid=PSDplot.grid;     
    set(handles.listbox_grid,'Value',grid);  
catch
end


try
    fig_num=PSDplot.fig_num;      
    set(handles.listbox_figure_num,'Value'); 
catch
end

try
    nxaxis=PSDplot.nxaxis;      
    set(handles.listbox_xaxis,'Value',nxaxis);
catch
end

try
    nyaxis=PSDplot.nyaxis;    
    set(handles.listbox_yaxis,'Value',nyaxis);  
catch
end

try
    xplotlimits=PSDplot.xplotlimits;      
    set(handles.listbox_xplotlimits,'Value',xplotlimits);
catch
end
listbox_xplotlimits_Callback(hObject, eventdata, handles);

try
    yplotlimits=PSDplot.yplotlimits;      
    set(handles.listbox_yplotlimits,'Value',yplotlimits);
catch
end
listbox_yplotlimits_Callback(hObject, eventdata, handles);


try
    xmin=PSDplot.xmin;    
    set(handles.edit_xmin,'String',xmin);  
catch
end

try
    xmax=PSDplot.xmax;    
    set(handles.edit_xmax,'String',xmax);  
catch
end

try
    ymin=PSDplot.ymin;     
    set(handles.edit_ymin,'String',ymin); 
catch
end

try
    ymax=PSDplot.ymax;     
    set(handles.edit_ymax,'String',ymax); 
catch
end



function edit_save_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_name as text
%        str2double(get(hObject,'String')) returns contents of edit_save_name as a double


% --- Executes during object creation, after setting all properties.
function edit_save_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_switch.
function pushbutton_switch_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_switch (see GCBO)
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

temp=array_name{2};
array_name{2}=array_name{1};
array_name{1}=temp;

temp=leg{2};
leg{2}=leg{1};
leg{1}=temp;

clear data;

for i=1:N
    data{i,1}=array_name{i};
    data{i,2}=leg{i};
end

set(handles.uitable_data,'Data',data);

%%%


% --- Executes on selection change in listbox_grms.
function listbox_grms_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_grms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_grms contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_grms


% --- Executes during object creation, after setting all properties.
function listbox_grms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_grms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_load_model_list.
function pushbutton_load_model_list_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vibrationdata_PSD_plot_multiple_load;

uiwait()

uiresume(vibrationdata_PSD_plot_multiple_load)

delete(vibrationdata_PSD_plot_multiple_load);
    
Lflag=getappdata(0,'Lflag');


if(Lflag==0)
    
    load_core(hObject, eventdata, handles);

    delete(vibrationdata_PSD_plot_multiple_load);

else
    delete(vibrationdata_PSD_plot_multiple_load);    
end


% --- Executes on selection change in listbox_ylab.
function listbox_ylab_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ylab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ylab contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ylab

i=get(handles.listbox_ylab,'Value');

if(i==1)
    sss='Accel (G^2/Hz)';
end
if(i==2)
    sss='Force (lbf^2/Hz)';
end
if(i==3)
    sss='Pressure (psi^2/Hz)';
end
if(i==4)
    sss='Stress (psi^2/Hz)';
end
if(i==5)
    sss=' ';
end

set(handles.edit_ylabel,'String',sss);


% --- Executes during object creation, after setting all properties.
function listbox_ylab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ylab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
