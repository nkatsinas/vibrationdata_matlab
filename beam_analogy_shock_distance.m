function varargout = beam_analogy_shock_distance(varargin)
% BEAM_ANALOGY_SHOCK_DISTANCE MATLAB code for beam_analogy_shock_distance.fig
%      BEAM_ANALOGY_SHOCK_DISTANCE, by itself, creates a new BEAM_ANALOGY_SHOCK_DISTANCE or raises the existing
%      singleton*.
%
%      H = BEAM_ANALOGY_SHOCK_DISTANCE returns the handle to a new BEAM_ANALOGY_SHOCK_DISTANCE or the handle to
%      the existing singleton*.
%
%      BEAM_ANALOGY_SHOCK_DISTANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_ANALOGY_SHOCK_DISTANCE.M with the given input arguments.
%
%      BEAM_ANALOGY_SHOCK_DISTANCE('Property','Value',...) creates a new BEAM_ANALOGY_SHOCK_DISTANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_analogy_shock_distance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_analogy_shock_distance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_analogy_shock_distance

% Last Modified by GUIDE v2.5 24-Nov-2015 17:32:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_analogy_shock_distance_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_analogy_shock_distance_OutputFcn, ...
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


% --- Executes just before beam_analogy_shock_distance is made visible.
function beam_analogy_shock_distance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_analogy_shock_distance (see VARARGIN)

% Choose default command line output for beam_analogy_shock_distance
handles.output = hObject;

set(handles.listbox_material,'Value',1);

change(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_analogy_shock_distance wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)

set(handles.uipanel_save,'Visible','off');

nstr=9;
iu=get(handles.listbox_units,'Value');
nmat=get(handles.listbox_material,'Value');


if(iu==1)  % English
    if(nmat==1) % aluminum
        handles.elastic_modulus=1e+007;
        handles.mass_density=0.1;  
    end  
    if(nmat==2)  % steel
        handles.elastic_modulus=3e+007;
        handles.mass_density= 0.28;         
    end
    if(nmat==3)  % copper
        handles.elastic_modulus=1.6e+007;
        handles.mass_density=  0.322;
    end
    if(nmat==4)  % G10
        handles.elastic_modulus=2.7e+006;
        handles.mass_density=  0.065;
    end
    if(nmat==5)  % PVC
        handles.elastic_modulus=3.5e+005;
        handles.mass_density=  0.052;
    end
else                 % metric
    if(nmat==1)  % aluminum
        handles.elastic_modulus=70;
        handles.mass_density=  2700;
    end
    if(nmat==2)  % steel
        handles.elastic_modulus=205;
        handles.mass_density=  7700;        
    end
    if(nmat==3)   % copper
        handles.elastic_modulus=110;
        handles.mass_density=  8900;
    end
    if(nmat==4)  % G10
        handles.elastic_modulus=18.6;
        handles.mass_density=  1800;
    end
    if(nmat==5)  % PVC
        handles.elastic_modulus=24.1;
        handles.mass_density=  1440;
    end
end
 
if(nmat<6)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density);
 
    set(handles.edit_elastic_modulus,'String',ss1);
    set(handles.edit_mass_density,'String',ss2);    
end




if(iu==1)
    set(handles.text_distance_unit,'String','in');
    set(handles.text_elastic_modulus,'String','lbf/in^2');
    set(handles.text_mass_density,'String','lbm/in^3');
    
    set(handles.text_width_unit,'String','in'); 
    set(handles.text_thickness_unit,'String','in');     
    
else
    set(handles.text_distance_unit,'String','cm'); 
    set(handles.text_elastic_modulus,'String','GPa');
    set(handles.text_mass_density,'String','kg/m^3');  
    
    set(handles.text_width_unit,'String','mm'); 
    set(handles.text_thickness_unit,'String','mm');     
end

set(handles.text_elastic_modulus,'Visible','off');
set(handles.text_mass_density,'Visible','off');
set(handles.listbox_material,'Visible','off');
set(handles.text_material,'Visible','off');
set(handles.text_em,'Visible','off');
set(handles.text_md,'Visible','off'); 
set(handles.edit_mass_density,'Visible','off'); 
set(handles.edit_elastic_modulus,'Visible','off'); 

set(handles.text_width,'Visible','off'); 
set(handles.edit_width,'Visible','off'); 
set(handles.text_thickness,'Visible','off'); 
set(handles.edit_thickness,'Visible','off'); 
set(handles.text_width_unit,'Visible','off'); 
set(handles.text_thickness_unit,'Visible','off'); 
set(handles.text_damping,'Visible','off'); 
set(handles.edit_damping,'Visible','off'); 

set(handles.text_w1,'Visible','off'); 
set(handles.text_w2,'Visible','off'); 
set(handles.text_w3,'Visible','off'); 
set(handles.edit_wt,'Visible','off'); 


if(nstr==9)
    set(handles.text_elastic_modulus,'Visible','on');
    set(handles.text_mass_density,'Visible','on');
    set(handles.listbox_material,'Visible','on');
    set(handles.text_material,'Visible','on');
    set(handles.text_em,'Visible','on');
    set(handles.text_md,'Visible','on'); 
    set(handles.edit_mass_density,'Visible','on'); 
    set(handles.edit_elastic_modulus,'Visible','on'); 
    
    set(handles.text_width,'Visible','on'); 
    set(handles.edit_width,'Visible','on'); 
    set(handles.text_thickness,'Visible','on'); 
    set(handles.edit_thickness,'Visible','on'); 
    set(handles.text_width_unit,'Visible','on'); 
    set(handles.text_thickness_unit,'Visible','on'); 
    set(handles.text_damping,'Visible','on'); 
    set(handles.edit_damping,'Visible','on');     
    
    set(handles.text_w1,'Visible','on'); 
    set(handles.text_w2,'Visible','on'); 
    set(handles.text_w3,'Visible','on'); 
    set(handles.edit_wt,'Visible','on');     
end




% --- Outputs from this function are returned to the command line.
function varargout = beam_analogy_shock_distance_OutputFcn(hObject, eventdata, handles) 
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

delete(shock_distance);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


iu=get(handles.listbox_units,'Value');

x=str2num(get(handles.edit_x,'String'));

disp(' ');
disp(' * * * * ');
disp(' ');
disp(' Distance from Source ');

if(iu==1)
    out1=sprintf(' x=%8.4g in ',x);
else    
    out1=sprintf(' x=%8.4g cm ',x);    
    x=x/2.54;
end
disp(out1);



disp(' ');



    damp=str2num(get(handles.edit_damping,'String'));
    E=str2num(get(handles.edit_elastic_modulus,'String'));
    rho=str2num(get(handles.edit_mass_density,'String'));
    thick=str2num(get(handles.edit_thickness,'String'));
    width=str2num(get(handles.edit_width,'String'));    
    L=str2num(get(handles.edit_x,'String'));
    
    if(iu==1)
       rho=rho/386; 
    else
       [E]=GPa_to_Pa(E);
       width=width/1000;
       thick=thick/1000;
       L=L/100;
    end
    
    [area,MOI,~]=beam_rectangular_geometry(width,thick); 
    
    mp=rho*area;
    
    lf=2*damp/100;
    
    B=E*MOI;
    x=L;

%%

% amp   freq   nhs  delay

    try
        FS=get(handles.edit_wt,'String');
        wt=evalin('base',FS);
    catch
        warndlg('Input array not found');
        return; 
    end
    

      f=wt(:,2);
    amp=wt(:,3);
    nhs=wt(:,4);
     td=wt(:,5);

    sr=50*max(f);
    dt=1/sr;

    dur=0.5;
    nt=round(dur/dt);

    
    tt=zeros(nt,1);
    Ain=zeros(nt,1);
    Atr=zeros(nt,1);
    
    clear length;
    nwaves=length(f);

    
    tstart=zeros(nwaves,1);
    tend=zeros(nwaves,1);
    
    tin_end=zeros(nwaves,1);
    
    tdx=zeros(nwaves,1);
    ratio=zeros(nwaves,1);
    
    new_amp=zeros(nwaves,1);
  
    beta=zeros(nt,1);
    alpha=zeros(nt,1);
  
    new_wavelet_table=zeros(nwaves,5); 

%%

    disp(' Scaling wavelets...');
    
    for i=1:nwaves
        
        omega=2*pi*f(i);

        beta(i)=2*pi*f(i);
        alpha(i)=beta(i)/nhs(i);
        
        CB=( (B/mp)^(1/4))*sqrt(omega);
    
        Cg=2*CB;

        Dp=27.2*f(i)*lf/Cg;
    
        delta=-Dp*x;
        ratio(i)=10^(delta/20); 
        
        tdx(i)=x/Cg;

        tstart(i)=(td(i)+tdx(i));
        
        NF=nhs(i)/(2*f(i));
        
        tend(i)=tstart(i)+NF;
    
        tin_end(i)=td(i)+NF;
        
        new_amp(i)=amp(i)*ratio(i);
        
        new_wavelet_table(i,:)=[ i f(i) new_amp(i) nhs(i)  tstart(i) ];           
             
    end
    
    setappdata(0,'new_wavelet_table',new_wavelet_table);
   
    
    f=fix_size(f);
    ratio=fix_size(ratio);
    
    fff=[f ratio];
    fff=sortrows(fff,1);
    
%%
    clear CB;
    clear Cg;

    oct=2^(1/6);
    ff(1)=10;
    k=1;
    while(1)
        
        omega=2*pi*ff(k);
 
        CB(k)=( (B/mp)^(1/4))*sqrt(omega);
    
        Cg(k)=2*CB(k);

        Dp=27.2*ff(k)*lf/Cg(k);
    
        delta=-Dp*x;
        rr(k)=10^(delta/20);
        
        if(ff(k)>12000)
            break;
        end
        
        k=k+1;
        ff(k)=ff(k-1)*oct;
    end    
%%

    fig_num=100;
    figure(fig_num);
    fig_num=fig_num+1;
    plot(ff,Cg,ff,CB);
    legend('Group','Phase','location','northwest');
    xlabel('Frequency (Hz)');
    if(iu==1)
            out1=sprintf('Bending Wave Speed  x=%6.3g in, damp=%6.3g%%',x,100*lf/2);
            ylabel('Speed (in/sec)');
    else
            out1=sprintf('Bending Wave Speed  x=%6.3g cm, damp=%6.3g%%',x,100*lf/2);  
            ylabel('Speed (m/sec)');        
    end  
    title(out1);   
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log'); 
    grid on;
    xlim([10 10000]);   
    
    figure(fig_num);
    fig_num=fig_num+1;
  
    plot(ff,rr);
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
    xlabel('Frequency (Hz)');
    ylabel('Ratio');
    xlim([10 10000]);
    if(iu==1)
            out1=sprintf('Remaining Ratio  x=%6.3g in, damp=%6.3g%%',x,100*lf/2);
    else
            out1=sprintf('Remaining Ratio  x=%6.3g cm, damp=%6.3g%%',x,100*lf/2);            
    end  
    title(out1);
    
    
%%    

    for i=1:nt
    
        tt(i)=(i-1)*dt; 
        t=tt(i);    
%
%  Source
%
        for j=1:nwaves 

            
            if(t>=td(j) && t<=tin_end(j))
               tq=t-td(j); 
               Ain(i)=Ain(i)+amp(j)*sin(alpha(j)*tq)*sin(beta(j)*tq);
            end 
            
        end    
% 
%  Transmitted
%
        for j=1:nwaves 
        
            if(t>=tstart(j) && t<= tend(j))
                tq=t-tstart(j);
                Atr(i)=Atr(i)+new_amp(j)*sin(alpha(j)*tq)*sin(beta(j)*tq);
            end
    
        end
%

    end
    
    disp(' ');
    disp(' Calculating shock response spectra... ');
    
    clear f;

    f(1)=10;

    damp=0.05;

    k=1;
    
    oct=2^(1/12);
    
    while(1)
   
        fnn=f(k)*oct;
    
        if(fnn>23000)
            break;
        else
            k=k+1;
            f(k)=fnn;
        end
    
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    clear srs;
    
    figure(fig_num);
    fig_num=fig_num+1;
    plot(tt,Atr);
    grid on;
    xlabel('Time (sec)');
    ylabel('Accel (G)');
        
    if(iu==1)
            out1=sprintf('Transmitted  x=%6.3g in, damp=%6.3g%%',x,100*lf/2);
    else
            out1=sprintf('Transmitted  x=%6.3g cm, damp=%6.3g%%',x,100*lf/2);            
    end    
    title(out1);     
    
%%
    tt=fix_size(tt);
    Ain=fix_size(Ain);
    Atr=fix_size(Atr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlabel2='Time (sec)';
ylabel1='Accel (G)';
ylabel2=ylabel1;
data1=[tt Ain];
data2=[tt Atr];

t_string1='Source';

if(iu==1)
    t_string2=sprintf('Transmitted  x=%6.3g in, damp=%6.3g%%',x,100*lf/2);
else
    t_string2=sprintf('Transmitted  x=%6.3g cm, damp=%6.3g%%',x,100*lf/2);            
end

[fig_num]=...
    subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    setappdata(0,'Ain',[tt Ain]);
    setappdata(0,'Atr',[tt Atr]);    
    
    [~,srs_in]=srs_function_abs(Ain,dt,damp,f);
    [~,srs_tr]=srs_function_abs(Atr,dt,damp,f);    
    
    setappdata(0,'srs_in',srs_in);
    setappdata(0,'srs_tr',srs_tr);    
    
%%%    
    Q=1/(2*damp);
    if(damp==0.05)
        Q=10;
    end
    
    t_string = sprintf(' Shock Response Spectrum Q=%g ',Q);

    md=5;
    x_label='Natural Frequency (Hz)';
    y_label='Peak Accel (G)';
    fmin=srs_in(1,1);
    fmax=srs_in(end,1);
    if(fmax>10000)
        fmax=10000;
    end
    ppp1=srs_in;
    ppp2=srs_tr;
    leg1='Source';
    leg2='Transmitted';
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    set(handles.uipanel_save,'Visible','on');

    scale=max(abs(Atr))/max(abs(Ain));
    fprintf('\n Overall Remaining Ratio Time Domain Peaks = %8.4g \n',scale); 
 



% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type



change(hObject, eventdata, handles);







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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change(hObject, eventdata, handles)





% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x as text
%        str2double(get(hObject,'String')) returns contents of edit_x as a double


% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_elastic_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_elastic_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_width as text
%        str2double(get(hObject,'String')) returns contents of edit_width as a double


% --- Executes during object creation, after setting all properties.
function edit_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_damping_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damping as text
%        str2double(get(hObject,'String')) returns contents of edit_damping as a double


% --- Executes during object creation, after setting all properties.
function edit_damping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_wt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wt as text
%        str2double(get(hObject,'String')) returns contents of edit_wt as a double


% --- Executes during object creation, after setting all properties.
function edit_wt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
   data=getappdata(0,'Ain');
end
if(n==2)
   data=getappdata(0,'srs_in');
end
if(n==3)
   data=getappdata(0,'Atr'); 
end
if(n==4)
   data=getappdata(0,'srs_tr'); 
end
if(n==5)
   data=getappdata(0,'new_wavelet_table');  
end

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


% --- Executes on key press with focus on edit_damping and none of its controls.
function edit_damping_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_x and none of its controls.
function edit_x_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_mass_density and none of its controls.
function edit_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_wt and none of its controls.
function edit_wt_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_wt (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');
