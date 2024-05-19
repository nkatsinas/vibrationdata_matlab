function varargout = beam_bending_PSD(varargin)
% BEAM_BENDING_PSD MATLAB code for beam_bending_PSD.fig
%      BEAM_BENDING_PSD, by itself, creates a new BEAM_BENDING_PSD or raises the existing
%      singleton*.
%
%      H = BEAM_BENDING_PSD returns the handle to a new BEAM_BENDING_PSD or the handle to
%      the existing singleton*.
%
%      BEAM_BENDING_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_BENDING_PSD.M with the given input arguments.
%
%      BEAM_BENDING_PSD('Property','Value',...) creates a new BEAM_BENDING_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_bending_PSD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_bending_PSD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_bending_PSD

% Last Modified by GUIDE v2.5 24-Dec-2020 17:39:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_bending_PSD_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_bending_PSD_OutputFcn, ...
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


% --- Executes just before beam_bending_PSD is made visible.
function beam_bending_PSD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_bending_PSD (see VARARGIN)

% Choose default command line output for beam_bending_PSD
handles.output = hObject;

iu=getappdata(0,'unit');
L=getappdata(0,'length');

if(iu==1)
    set(handles.length_unit_text,'String','inch');
    LS=sprintf('Beam Length = %g inch',L);
else
    set(handles.length_unit_text,'String','meters');
    LS=sprintf('Beam Length = %g meters',L);
end

set(handles.beam_length_text,'String',LS);

set(handles.uipanel_save,'Visible','off');
set(handles.pushbutton_rainflow,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_bending_PSD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_bending_PSD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Calculate_pushbutton.
function Calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp(' ');

number_modes=get(handles.listbox_number_modes,'Value');

fig_num=1;
      damp=getappdata(0,'damp_ratio');
        fn=getappdata(0,'fn');
      iu=getappdata(0,'unit');
      unit=iu;
      
      Q=getappdata(0,'Q');
      part=getappdata(0,'part');
      PF=part;
 
      beta=getappdata(0,'beta');
      
      LBC=getappdata(0,'LBC');
      RBC=getappdata(0,'RBC');
   
      E=getappdata(0,'E');
      I=getappdata(0,'I');    
      
      EI_term=getappdata(0,'EI_term');
   
  
      
      cna=getappdata(0,'cna');  
    
      x=str2num(get(handles.x_edit,'String')); 
      
      sq_mass=getappdata(0,'sq_mass');
      beta=getappdata(0,'beta');
      C=getappdata(0,'C');
      
      fn=fn(1:number_modes);

%
%
try
    FS=get(handles.input_edit,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found');
    return;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    acc_trans
%
   clear f;
   
   fmin=THM(1,1);
   fmax=THM(end,1);

   
   nf=10000;
   n=length(fn);
%
   disp(' ');
%
   f=zeros(nf,1);
   f(1)=0.8*THM(1,1);
   for k=2:nf
        f(k)=f(k-1)*2^(1/48);
        if(f(k)>fmax)
            break;
        end    
   end
   
  [acc_trans,rv_trans,rd_trans,moment_trans,shear_trans]=...
          beam_bending_trans_core_alt(beta,C,sq_mass,x,iu,LBC,RBC,f,part,fn,damp,E,I);
   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
PSD_in=THM;
%
[acc_response_psd]=psd_mult_trans(PSD_in,acc_trans);
[~,accel_rms]=calculate_PSD_slopes( acc_response_psd(:,1),acc_response_psd(:,2)  );

sz=size(acc_response_psd);

fff=acc_response_psd(:,1);

%%%%%%%%%%%%%%

rv_response_psd=zeros(sz(1),sz(2));
rv_response_psd(:,1)=fff;

rd_response_psd=zeros(sz(1),sz(2));
rd_response_psd(:,1)=fff;

moment_response_psd=zeros(sz(1),sz(2));
moment_response_psd(:,1)=fff;

shear_response_psd=zeros(sz(1),sz(2));
shear_response_psd(:,1)=fff;

stress_response_psd=zeros(sz(1),sz(2));
stress_response_psd(:,1)=fff;

%%%%%%%%%%%%%%

disp_rms=0.;
velox_rms=0;
bm_rms=0;
shear_rms=0;
stress_rms=0.;


vflag=0;
if( rv_trans(1,2)>1.0e-12 && max(rv_trans(:,2))>=1.0e-12)
%    
    vflag=1; 
    [rv_response_psd]=psd_mult_trans(PSD_in,rv_trans);
    [~,velox_rms]=calculate_PSD_slopes(  rv_response_psd(:,1),rv_response_psd(:,2)  );
%
end   

rflag=0;
if( rd_trans(1,2)>1.0e-12 && max(rd_trans(:,2))>=1.0e-12)
%    
    rflag=1; 
    [rd_response_psd]=psd_mult_trans(PSD_in,rd_trans);
    [~,disp_rms]=calculate_PSD_slopes(  rd_response_psd(:,1),rd_response_psd(:,2)  );
%
end    
%

shear_flag=0;
if( shear_trans(1,2)>1.0e-12 && max(shear_trans(:,2))>=1.0e-12)
%  
    shear_flag=1; 
    [shear_response_psd]=psd_mult_trans(PSD_in,shear_trans);
    
     [~,shear_rms]=calculate_PSD_slopes(  shear_response_psd(:,1),shear_response_psd(:,2)  );    
%
end


sflag=0;
if( moment_trans(1,2)>1.0e-12 && max(moment_trans(:,2))>=1.0e-12)
%  
    sflag=1; 
    [moment_response_psd]=psd_mult_trans(PSD_in,moment_trans);
    
     [~,bm_rms]=calculate_PSD_slopes(  moment_response_psd(:,1),moment_response_psd(:,2)  );    
   
    
    stress_response_psd(:,1)=        moment_response_psd(:,1);    
    stress_response_psd(:,2)=(cna/I)^2*moment_response_psd(:,2);
    
    [~,stress_rms]=calculate_PSD_slopes(  stress_response_psd(:,1),stress_response_psd(:,2)  ); 
%
end


%    
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==1)
   su='psi';
   sv='in/sec';
   dd='in';
   sb='in-lbf';
   st='psi';
   sh='lbf';
   xu='in';
else
   su='Pa';
   sv='m/sec';
   dd='mm';
   sb='N-m';
   st='Pa';
   sh='N';
   xu='m';
%
   disp_rms=disp_rms*1000;
%
end
%
%
%%
%
disp(' ');
% fprintf(' Response Overall Levels at x=%g %s \n',x,xu);
% disp(' ');
out1=sprintf('  Acceleration = %8.4g GRMS',accel_rms);
disp(out1);
%

out1=sprintf('  Relative Velocity = %8.4g %s RMS',velox_rms,sv);
disp(out1);
%%

%
out1=sprintf('  Relative Displacement = %8.4g %s RMS \n',disp_rms,dd);
disp(out1);

out1=sprintf('  Bending Moment = %8.4g %s RMS',bm_rms,sb);
disp(out1);

out1=sprintf('  Shear Force = %8.4g %s RMS',shear_rms,sh);
disp(out1);

out1=sprintf('  Stress = %8.4g %s RMS',stress_rms,st);
disp(out1);

md=6;
x_label='Frequency (Hz)';

%%
%

ylab_acc=sprintf('Accel (G^2/Hz)');
%
if(unit==1)
    ylab_bm=sprintf('Bending Moment ((in-lbf)^2/Hz)');    
    ylab_stress=sprintf('Stress (psi^2/Hz)');
    ylab_rv=sprintf('Rel Vel ((in/sec^2)^2/Hz)');
    ylab_rd=sprintf('Rel Disp (inch^2/Hz)');
    ylab_sh=sprintf('Shear (lbf^2/Hz)');   
else
    ylab_bm=sprintf('Bending Moment ((N-m)^2/Hz)');     
    ylab_stress=sprintf('Stress (Pa^2/Hz)'); 
    ylab_rv=sprintf('Rel Vel ((m/sec^2)^2/Hz)');    
    ylab_rd=sprintf('Rel Disp (mm^2/Hz)');
    ylab_sh=sprintf('Shear (N^2/Hz)');      
end
%

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[~,input_rms]=calculate_PSD_slopes( THM(:,1),THM(:,2) );
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


ppp1=THM;
ppp2=acc_response_psd;

y_label=ylab_acc;
%
if(iu==1)
    t_string=sprintf('Acceleration Response PSD  x=%g in',x);
else
    t_string=sprintf('Acceleration Response PSD  x=%g m',x);    
end
%
%
leg1=sprintf('Base Input %6.3g GRMS',input_rms);
leg2=sprintf('Mass Response %6.3g GRMS',accel_rms);


[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(vflag==1)

    if(iu==1)
        t_string=sprintf('Relative Velocity Response PSD  x=%g in, %7.3g %s RMS',x,velox_rms,sv);
    else
        t_string=sprintf('Relative Velocity Response PSD  x=%g m, %7.3g %s RMS',x,velox_rms,sv); 
    end

    y_label=ylab_rv;
%
    ppp=rv_response_psd;
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
%
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==2)
    rd_response_psd(:,2)=rd_response_psd(:,2)*1.0e+06;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


if(rflag==1)

    if(iu==1)
        t_string=sprintf('Relative Displacement PSD  x=%g in, %6.3g %s RMS',x,disp_rms,dd);
    else
        t_string=sprintf('Relative Displacement PSD  x=%g m,  %6.3g %s RMS',x,disp_rms,dd);       
    end
    
    y_label=ylab_rd;
%
    ppp=rd_response_psd;
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

if(shear_flag==1)
    
    
    if(iu==1)
        t_string=sprintf('Shear Force PSD  x=%g in,  %7.4g %s RMS',x,shear_rms,sh);
    else
        t_string=sprintf('Shear Force PSD  x=%g m,  %7.4g %s RMS',x,shear_rms,sh);
    end
    
    y_label=ylab_sh;
%
    ppp=shear_response_psd;
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    
    
end    


if(sflag==1)
    
    
    if(iu==1)
        t_string=sprintf('Bending Moment PSD  x=%g in,  %7.4g %s RMS',x,bm_rms,sb);
    else
        t_string=sprintf('Bending Moment PSD  x=%g m,  %7.4g %s RMS',x,bm_rms,sb);
    end
    
    y_label=ylab_bm;
%
    ppp=moment_response_psd;
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    
    

    if(iu==1)
        t_string=sprintf('Stress Response PSD  x=%g in,  %7.4g %s RMS',x,stress_rms,su);
    else
        t_string=sprintf('Stress Response PSD  x=%g m,  %7.4g %s RMS',x,stress_rms,su);
    end
    
    y_label=ylab_stress;
%
    ppp=stress_response_psd;
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m=get(handles.listbox_max,'Value');

if(m==1)

    L=getappdata(0,'length');

    xx=(0:1:20)*L/20;

    num=length(xx);

    amax=0;
    vmax=0;
    rdmax=0;
    smax=0;
    bmmax=0;
    shmax=0;

    progressbar;

    for i=1:num
    
        progressbar((i-1)/num);
    
        x=xx(i);
    
        [acc_trans,rv_trans,rd_trans,moment_trans,shear_trans]=...
          beam_bending_trans_core_alt(beta,C,sq_mass,x,iu,LBC,RBC,f,part,fn,damp,E,I);

	    if( acc_trans(1,2)>1.0e-12 && max(acc_trans(:,2))>=1.0e-12)		  
			try
				[acc_response_psd]=psd_mult_trans(PSD_in,acc_trans);
				[~,accel_rms]=calculate_PSD_slopes( acc_response_psd(:,1),acc_response_psd(:,2)  );
			catch
			end
	    end
      
        if( rv_trans(1,2)>1.0e-12 && max(rv_trans(:,2))>=1.0e-12)
			try
%     
				[rv_response_psd]=psd_mult_trans(PSD_in,rv_trans);
				[~,velox_rms]=calculate_PSD_slopes(  rv_response_psd(:,1),rv_response_psd(:,2)  );
%            
			catch
			end
        end
        if( rd_trans(1,2)>1.0e-12 && max(rd_trans(:,2))>=1.0e-12)
            try
%     
                [rd_response_psd]=psd_mult_trans(PSD_in,rd_trans);
                [~,disp_rms]=calculate_PSD_slopes(  rd_response_psd(:,1),rd_response_psd(:,2)  );
%
            catch
            end
        end            

        if(disp_rms>=rdmax)
            rdmax=disp_rms;
            xrdmax=x;
        end       
        
        if(velox_rms>=vmax)
            vmax=velox_rms;
            xvmax=x;
        end
        
        if(accel_rms>=amax)
            amax=accel_rms;
            xamax=x;
        end
        
        if( shear_trans(1,2)>1.0e-12 && max(shear_trans(:,2))>=1.0e-12)
			try
%  
				[shear_response_psd]=psd_mult_trans(PSD_in,shear_trans);
			  
				[~,sh_rms]=calculate_PSD_slopes(  shear_response_psd(:,1),shear_response_psd(:,2)  );    
  
%
			catch
			end
        end    
        
        if(shear_rms>=shmax)
            shmax=sh_rms;
            xshmax=x;
        end           
        
        if( moment_trans(1,2)>1.0e-12 && max(moment_trans(:,2))>=1.0e-12)
			try
%  
				[moment_response_psd]=psd_mult_trans(PSD_in,moment_trans);
			
    
				[~,bm_rms]=calculate_PSD_slopes(  moment_response_psd(:,1),moment_response_psd(:,2)  );    
   
				stress_response_psd(:,1)=        moment_response_psd(:,1);    
				stress_response_psd(:,2)=(cna/I)^2*moment_response_psd(:,2);
			
    
				[~,stress_rms]=calculate_PSD_slopes(  stress_response_psd(:,1),stress_response_psd(:,2)  ); 
%
			catch
			end
		end
       
        if(stress_rms>=smax)
            smax=stress_rms;
            xsmax=x;
        end       
        if(bm_rms>=bmmax)
            bmmax=bm_rms;
            xbmmax=x;
        end           

    end
    
    if(iu==2)
           disp_rms=disp_rms*1000;
    end

    progressbar(1);

    disp(' ');
    disp(' Maximum Overall Levels Across Entire Length ');
    disp(' ');

    t_string=sprintf('  Acceleration Response PSD  x=%g in, %7.3g GRMS',xamax,amax);
    disp(t_string);    
    
    if(iu==1)
        t_string=sprintf('  Relative Velocity PSD  x=%g in, %7.3g %s RMS',xvmax,vmax,sv);
    else
        t_string=sprintf('  Relative Velocity PSD  x=%g m, %7.3g %s RMS',xvmax,vmax,sv); 
    end

    disp(t_string);
    
    if(iu==1)
        t_string=sprintf('  Relative Displacement PSD  x=%g in, %7.3g %s RMS',xrdmax,rdmax,dd);
    else
        t_string=sprintf('  Relative Displacement PSD  x=%g m, %7.3g %s RMS',xrdmax,rdmax,dd); 
    end

    disp(t_string);   

    if(iu==1)
        t_string=sprintf('\n  Bending Moment PSD  x=%g in,  %7.4g %s RMS',xbmmax,bmmax,sb);
    else
        t_string=sprintf('  Bending Moment PSD  x=%g m,  %7.4g %s RMS',xbmmax,bmmax,sb);
    end    
 
    disp(t_string);  
    
    if(iu==1)
        t_string=sprintf('  Shear Force PSD  x=%g in,  %7.4g %s RMS',xshmax,shmax,sh);
    else
        t_string=sprintf('  Shear Force PSD  x=%g m,  %7.4g %s RMS',xshmax,shmax,sh);
    end    
 
    disp(t_string);      
    
    if(iu==1)
        t_string=sprintf('  Stress Response PSD  x=%g in,  %7.4g %s RMS',xsmax,smax,su);
    else
        t_string=sprintf('  Stress Response PSD  x=%g m,  %7.4g %s RMS',xsmax,smax,su);
    end    
 
    disp(t_string);    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
disp(' ');
msgbox('Calculation complete.  Output written to Matlab Command Window.');      

setappdata(0,'fig_num',fig_num);    
        
setappdata(0,'acceleration',acc_response_psd);
setappdata(0,'relative_velocity',rv_response_psd);
setappdata(0,'relative_displacement',rd_response_psd);
setappdata(0,'shear_force',shear_response_psd);
setappdata(0,'bending_moment',moment_response_psd);
setappdata(0,'bending_stress',stress_response_psd);
set(handles.uipanel_save,'Visible','on');


% --- Executes on button press in Return_pushbutton.
function Return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(beam_bending_PSD);


function input_edit_Callback(hObject, eventdata, handles)
% hObject    handle to input_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_edit as text
%        str2double(get(hObject,'String')) returns contents of input_edit as a double


% --- Executes during object creation, after setting all properties.
function input_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_edit_Callback(hObject, eventdata, handles)
% hObject    handle to x_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_edit as text
%        str2double(get(hObject,'String')) returns contents of x_edit as a double


% --- Executes during object creation, after setting all properties.
function x_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_response.
function listbox_response_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_response contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_response


% --- Executes during object creation, after setting all properties.
function listbox_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
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

n=get(handles.listbox_response,'Value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'relative_velocity');
end
if(n==3)
    data=getappdata(0,'relative_displacement');
end
if(n==4)
    data=getappdata(0,'bending_moment');
end

if(n==5)
    data=getappdata(0,'shear_force');
end

if(n==6)
    data=getappdata(0,'bending_stress');
end


output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 

set(handles.pushbutton_rainflow,'Enable','on');

set(handles.uipanel_save,'Visible','on');


function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_rainflow.
function pushbutton_rainflow_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rainflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s1= fatigue_toolbox;
set(handles.s1,'Visible','on');


% --- Executes on selection change in listbox_number_modes.
function listbox_number_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_number_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_number_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_number_modes


% --- Executes during object creation, after setting all properties.
function listbox_number_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_number_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_max.
function listbox_max_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_max


% --- Executes during object creation, after setting all properties.
function listbox_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
