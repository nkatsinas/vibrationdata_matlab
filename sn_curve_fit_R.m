%
%  sn_curve_fit_R.m  ver 1.0  by Tom Irvine
%

clear S;
clear SS;
clear N;
clear NN;

close all hidden;

disp(' This script calculates the NASFORM parameters for a set of SN Curves ');
disp(' via trial-and-error curve-fitting ');
%
disp(' ');
disp(' Each input SN curve must have two columns:  Stress & Cycles ');
%
disp(' ');
disp(' The SN curve should contain any coordinates below the endurace limit.');
%
disp(' ');
disp(' Note that R = Smin/Smax');
%
disp(' Enter the number of SN curves (max=5)');
nc=input(' ');
%
if(nc>5)
    nc=5;
end

num=zeros(nc,1);

disp(' ');
disp(' Enter the input array name for curve 1 ');

try
    SN1=input(' ');
    R(1)=input(' Enter the R value ');
    num(1)=length(SN1(:,1));
catch
    disp(' Input array does not exist ');
    return;
end
    
if(nc>=2)
 
    disp(' ');
    disp(' Enter the input array name for curve 2 ');

    try
        SN2=input(' ');
        R(2)=input(' Enter the R value ');
        num(2)=length(SN2(:,1));        
    catch
        disp(' Input array does not exist ');
        return;
    end        
        
end
    
if(nc>=3)
 
    disp(' ');
    disp(' Enter the input array name for curve 3 ');

    try
        SN3=input(' ');
        R(3)=input(' Enter the R value ');            
        num(3)=length(SN3(:,1));        
    catch
        disp(' Input array does not exist ');
        return;
    end        
        
end

if(nc>=4)
 
    disp(' ');
    disp(' Enter the input array name for curve 4 ');

    try
        SN4=input(' ');
        R(4)=input(' Enter the R value '); 
        num(4)=length(SN4(:,1));         
    catch
        disp(' Input array does not exist ');
        return;
    end        
        
end 

if(nc==5)
 
    disp(' ');
    disp(' Enter the input array name for curve 5 ');

    try
        SN5=input(' ');
        R(5)=input(' Enter the R value ');
        num(5)=length(SN5(:,1));         
    catch
        disp(' Input array does not exist ');
        return;
    end        
        
end 
    
   
%
%
%% disp(' Enter the number of trials');
%% ntrials=input(' ');
    ntrials=100000;
%

error_max=1.0e+50;

disp('  ');
disp(' i  error   P     A     B    C  ');

for i=1:ntrials
    
    error=0;

    P=1*rand;
    B=10*rand;
    A=50*rand;
    C=100*rand;    
    
    if(i> round(0.1*ntrials))
        if(rand>0.5)
            P=Pr*(0.98+0.04*rand);
        end
        if(rand>0.5)
            B=Br*(0.98+0.04*rand);            
        end
        if(rand>0.5)
            A=Ar*(0.98+0.04*rand);             
        end
        if(rand>0.5)
            C=Cr*(0.98+0.04*rand);               
        end        
        
        if(rand>0.9)
            P=Pr*(0.98+0.04*rand);  
            B=Br*(0.98+0.04*rand);  
            A=Ar*(0.98+0.04*rand);  
            C=Cr*(0.98+0.04*rand);            
        end
    end    
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


    [error]=sn_curve_fit_error(num(1),SN1,error,R(1),P,A,B,C);
    
    if(nc>=2)
        [error]=sn_curve_fit_error(num(2),SN2,error,R(2),P,A,B,C);
    end    
    if(nc>=3)
        [error]=sn_curve_fit_error(num(3),SN3,error,R(3),P,A,B,C);
    end        
    if(nc>=4)
        [error]=sn_curve_fit_error(num(4),SN4,error,R(4),P,A,B,C);
    end    
    if(nc>=5)
        [error]=sn_curve_fit_error(num(5),SN5,error,R(5),P,A,B,C);
    end        
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    if(error<error_max)
        
        Pr=P;
        Br=B;
        Ar=A;
        Cr=C;     
        out1=sprintf(' %d %8.4g %8.4g %8.4g %8.4g %8.4g',i,error,Pr,Ar,Br,Cr);
        disp(out1);
        
        error_max=error;
    end
    
end    
    
disp(' ');
disp(' Best case ');

out1=sprintf(' P=%8.4g ',Pr);
out2=sprintf(' A=%8.4g ',Ar);
out3=sprintf(' B=%8.4g ',Br);
out4=sprintf(' C=%8.4g ',Cr);

disp(out1);
disp(out2);
disp(out3);
disp(out4);

hold on;

clear legendInfo

figure(1);

[NN1,SS1]=sn_curve_fit_plot(num(1),SN1,R(1),Pr,Ar,Br,Cr);
plot(SN1(:,1),SN1(:,2),'d');
legendInfo{1} = ['R = ' num2str(R(1))];
plot(NN1,SS1);
legendInfo{2} = ['R = ' num2str(R(1))];

if(nc>=2)
    [NN2,SS2]=sn_curve_fit_plot(num(2),SN2,R(2),Pr,Ar,Br,Cr);
    plot(SN2(:,1),SN2(:,2),'o');
    legendInfo{3} = ['R = ' num2str(R(2))];
    plot(NN2,SS2);
    legendInfo{4} = ['R = ' num2str(R(2))];    
end    

if(nc>=3)
    [NN3,SS3]=sn_curve_fit_plot(num(3),SN3,R(3),Pr,Ar,Br,Cr);
    plot(SN3(:,1),SN3(:,2),'*');  
    legendInfo{5} = ['R = ' num2str(R(3))];    
    plot(NN3,SS3);  
    legendInfo{6} = ['R = ' num2str(R(3))];    
end   

if(nc>=4)
    [NN4,SS4]=sn_curve_fit_plot(num(4),SN4,R(4),Pr,Ar,Br,Cr);
    plot(SN4(:,1),SN4(:,2),'x');    
    legendInfo{7} = ['R = ' num2str(R(4))];   
    plot(NN4,SS4);    
    legendInfo{8} = ['R = ' num2str(R(4))];      
end   

if(nc>=5)
    [NN5,SS5]=sn_curve_fit_plot(num(5),SN5,R(5),Pr,Ar,Br,Cr);
    plot(SN5(:,1),SN5(:,2),'v');  
    legendInfo{9} = ['R = ' num2str(R(5))];  
    plot(NN5,SS5);  
    legendInfo{10} = ['R = ' num2str(R(5))];     
end   

grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin'); 
xlabel('Cycles');
ylabel('Stress');
title('SN Curve-fit');

legend(legendInfo);

hold off;

