%
%  ODE_force_input.m  ver 1.2  March 22, 2012
%
function[FFI,force_dof,nff]=ODE_force_input(iu,ndof,NT,t,file_choice)
%
if(iu==1)
    disp(' Each force file must have two columns: time(sec) & force(lbf) ');
else
    disp(' Each force file must two columns: time(sec) & force(N) ');
end
%
disp(' ');
disp(' Enter the number of force files ');
%
nff=input(' ');
%
MAX=10000000;
%
tt=zeros(MAX,nff);
ff=zeros(MAX,nff);
%
force_dof=zeros(ndof,1);
%
for(i=1:ndof)
    force_dof(i)=-999;
end    
%    
disp(' ');
disp(' Note: the first dof is 1 ');
%
for(i=1:nff)
    disp(' ');
    out1=sprintf(' Enter force file %d ',i);
    disp(out1);
% 
    if(file_choice==1)
        FS = input(' Enter the matrix name:  ','s');
        F=evalin('caller',FS);
    end
    if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        F = xlsread(xfile);
%         
    end
%    
    a=F(:,1);
    b=F(:,2);
%    
    L=length(a);
%    
    if(L>MAX)
        L=MAX;
    end
%    
    tt(1:L,i)=a(1:L);
    ff(1:L,i)=b(1:L);
%    
    disp(' ');
    disp(' Enter the number of dofs at which this force is applied ');   
%   
    nfa=input(' '); 
%   
    for(j=1:nfa)
        disp(' ');
%
        if(j==1 && nfa==1)
            disp(' Enter the dof number for this force ');
        end    
        if(j==1 && nfa>1)        
            disp(' Enter the first dof number for this force ');
        end
        if(j>1 && nfa>1)        
            disp(' Enter the next dof number for this force ');        
        end
        nn=input(' ');
        force_dof(nn)=i;
    end
end 
%
% interpolate force
%
disp(' begin interpolation ');
%
FFI=zeros(NT,nff);
%
for(i=1:nff)
%
    clear tint;
    clear fint;
%
    tstart=tt(1,i);
    tt(:,i)=tt(:,i)-tstart;   
%
    last=MAX;
%    
    for(j=2:MAX)
        if(tt(j,i)<=tt(j-1,i))
            last=j-1;
            break
        end
    end      
%
    tint=tt(1:last,i);
    fint=ff(1:last,i);
%
    t=t';
    FFI(:,i) = interp1(tint,fint,t);
%
    for(j=1:NT)
        if(abs(FFI(j,i))>=0 && abs(FFI(j,i))<1.0e+50)
        else
            FFI(j,i)=0;
        end
    end
%
end 
%
disp(' end interpolation ');
%