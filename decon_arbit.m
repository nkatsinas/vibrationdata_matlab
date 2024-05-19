disp(' ')
disp(' decon_arbit.m   ver 1.0   March 28, 2012')
disp(' by Tom Irvine   Email: tomirvine@aol.com')
disp(' ')
disp(' This program calculates the response of a single-degree-of-freedom')
disp(' system to an arbitrary base input time history. ')
disp(' ')
disp(' The input time history must have two columns: time(sec) & accel(G)')
disp(' ')
%
close all;
%
clear omega;
clear omegad;
clear dt;
clear sr;
clear damp;
clear a1;
clear a2;
clear b1;
clear b2;
clear c1;
clear c2;
clear sum;
clear t;
clear tt;
clear y;
clear yy;
clear THM;
clear x_pos;
clear x_neg;
clear a_base
clear forward;
clear back;
clear rd_forward;
clear rd_back;
clear length;
%
fig_num=1;
%
[t,y,dt,sr,tmx,tmi,n,ncontinue]=enter_time_history();
%
if(ncontinue==1)
%
    disp(' ')
    fn=input(' Enter the natural frequency (Hz)  ');
    omegan=2*pi*fn;
%
    disp(' ')
    idamp=input(' Enter damping format:  1= damping ratio   2= Q  ');	
%
    disp(' ')
    if(idamp==1)
        damp=input(' Enter damping ratio (typically 0.05) ');
    else
        Q=input(' Enter the amplification factor (typically Q=10) ');
        damp=1./(2.*Q);
    end
%%%
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(t,y);
    ylabel('Accel (G)');
    xlabel('Time (sec)');
    Q=1./(2.*damp);
    out5 = sprintf(' SDOF Acceleration Response   fn=%g Hz   Q=%g ',fn,Q);
    title(out5);
    grid;
    zoom on;
%
%%%
%
%  Initialize coefficients
%
    Tom=dt*omegan;
%
    den=(4*damp + Tom);
%
    Tom_den=Tom*den;
%
    a1=2*Tom/den;
    a2=(-4*damp + Tom)/den;
%
    c0=    (4 +4*damp*Tom +Tom^2)/Tom_den;
    c1=            2*(-4  +Tom^2)/Tom_den;
    c2=   (4 -4*damp*Tom  +Tom^2)/Tom_den;
%
%  SRS engine
%
    disp(' ')
    disp(' Calculating acceleration');
%%
%
    forward=[ c0,  c1,  c2 ];
    back   =[  1, a1, a2 ];
%    
    a_base=filter(forward,back,y);
%
%%%%%    clear length;
%%%%%    n=length(y);
%%%%%    x=y;
%%%%%    yb=0;
%%%%%    ybb=0;
%%%%%    xb=0;
%%%%%    xbb=0;
%
%%%%%    for i=1:n
%%%%%        a_base(i)=-a1*yb -a2*ybb +c0*x(i) +c1*xb +c2*xbb;
%%%%%        ybb=yb;
%%%%%        yb=a_base(i);
%%%%%        xbb=xb;
%%%%%        xb=x(i);
%%%%%    end
%
    x_pos= max(a_base);
    x_neg= min(a_base);
%%
%
    disp(' ')
    disp(' ')
    disp(' Acceleration Base Input ')
    mu=mean(a_base);
    sd=std(a_base);
    arms=sqrt(sd^2+mu^2);
    peak=max(abs(a_base));
    if(abs(x_neg)>peak)
        peak=abs(x_neg);
    end
%
%
    out10=sprintf('\n      maximum = %10.2f G',x_pos);
    out11=sprintf('      minimum = %10.2f G',x_neg); 
%
    disp(out10)
    disp(out11)
%
    figure(fig_num);
    fig_num=fig_num+1;
    disp(' Plotting output..... ')
    plot(t,a_base);
    ylabel('Accel (G)');
    xlabel('Time (sec)');
    Q=1./(2.*damp);
    out5 = sprintf(' Acceleration Base Input ');
    title(out5);
    grid;
    zoom on;
end