    
%  fds_sdof_response_rainflow_damage.m  ver 1.0  by Tom Irvine
%

% Fatigue Damage Spectrum
%
% SDOF acceleration response to base input acceleration time history 
% via David O. Smallwood digital recursive filtering relationship
%
% The base input time history must have a constant time step
%
%          fn = natural frequency (Hz)
%           Q = amplification factor
%           b = fatigue exponent
%
%           Q & b are both 1-d arrays that may have multiple values
%
%           A typical pairing is:   
%
%              Q=[10 30];
%              b=[4 8];
%
% accel_input = base input acceleration time history amplitude 
%          dt = acceleration input time step
%
%     fstart = starting frequency (Hz)
%       fend = ending frequency (Hz)
%
%   The ending frequency is limited to the sample rate divided by 5
%
%   The sample rate is the inverse of the time step
%
%   fds has multiple columns:
%       natural frequency (Hz) 
%       and relative damage (accel unit)^b for each Q & b combination 
%                


function[fds]=fds_sdof_response_rainflow_damage_Q_b_combinations(fstart,fend,Q,b,accel_input,dt)


NQ=length(Q);
Nb=length(b);


    damp=1/(2*Q);
    
    sr=1/dt;
    
    fmax=sr/5;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    num=1;
    fn(1)=fstart;

    oct=2^(1/24);

    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)*oct;
  
        if(fn(num)>fmax)
            break;
        end
    
    end

    [~,i1]=min(abs(fn-fstart));

    if(fend<fmax)
        [~,i2]=min(abs(fn-fend));    
    else
        [~,i2]=min(abs(fn-fmax));            
    end
    
    fn=fn(i1:i2);  
 
    num=length(fn);

    sz=size(fn);
    if(sz(2)>sz(1))
        fn=transpose(fn);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    fds=zeros(num,1);
 
    for i=1:num    
    
        omega=2*pi*fn(i);
        omegad=omega*sqrt(1-damp^2);

        E=(exp(-damp*omega*dt));
        K=(omegad*dt);
        C=(E*cos(K));
        S=(E*sin(K));

        Sp=S/K;

        a1=(2*C);
        a2=(-(E^2));

        b1=(1.-Sp);
        b2=(2.*(Sp-C));
        b3=((E^2)-Sp);

        forward=[ b1,  b2,  b3 ];    
        back   =[  1, -a1, -a2 ];    

%  accel_resp = sdof response time history to base input
    
        accel_resp=filter(forward,back,accel_input);
    
        c=rainflow(accel_resp);

% The output array c has five columns:   Count, Range, Mean, Start, and End
% Only the first two columns are needed for the damage calculation  
% The relative damage can then be calculated for a fatigue exponent b  
% The amplitude is one-half of range.

        cycles=c(:,1);
        amp=c(:,2)/2;
        fds(i)=sum( cycles.*amp.^b );

    end
    
    sz=size(fn);
    if(sz(2)>sz(1))
        fn=transpose(fn);
    end
    
    fds=[fn fds];
    
    
    generate_fds_plot(fds,Q,b);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
function[]=generate_fds_plot(fds,Q,bex)
 
    fig_num=1;
    
    t_string=sprintf('Acceleration Fatigue Damage Spectrum Q=%g b=%g',Q,bex);

    fn=fds(:,1);
    damage=fds(:,2);
    
    fmin=fn(1);
    fmax=fn(end);

    multiple_fds_plot_1x1_alt(fig_num,bex,fn,damage,t_string,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    

%  multiple_fds_plot_1x1_alt.m  ver 1.0  by Tom Irvine

function[fig_num]=multiple_fds_plot_1x1_alt(fig_num,bex,fn,fds,t_string,fmin,fmax)

%

[xtt,xTT,iflag]=xtick_label_f(fmin,fmax);


hp=figure(fig_num);
fig_num=fig_num+1;
%        
ff=fds(:,1);

y_label=sprintf('Damage log10(G^%g)',bex);

plot(fn,log10(ff));
title(t_string);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax])


ymax=max(log10(ff));
ymin=min(log10(ff));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
%  ytick_linear_alt.m  ver 1.1  by Tom Irvine

function[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin)

if((ymax-ymin)<=18)

    for i=-100:2:100
        if(ymax<i)
            ymax=i;
            break;
        end
    end    
    
    for i=-100:2:100
        if(ymin<i)
            ymin=i-2;
            break;
        end
    end
    
    k=1;    
    
    if((ymax-ymin)<=8)
        iq=1;
    else
        iq=2;
    end
    
    for i=ymin:iq:ymax
        ytt(k)=i;
        yTT{k}=sprintf('%d',i);
        k=k+1;
    end    
    
else    
    
    for i=-100:5:100
        if(ymax<i)
            ymax=i;
            break;
        end
    end    

    for i=-100:5:100
        if(ymin<i)
            ymin=i-5;
            break;
        end
    end

    k=1;
    for i=ymin:5:ymax
        ytt(k)=i;
        yTT{k}=sprintf('%d',i);
        k=k+1;
    end    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
%
%   xtick_label_f.m  ver 2.9  by Tom Irvine
%
function[xtt,xTT,iflag]=xtick_label_f(fmin,fmax)


try

xtt=[];
xTT={};
iflag=0;



%
%  start 0.001
%
if(fmin>=0.001 && fmin<0.005)

    if(fmax<=0.2)
        xtt=[0.001 0.01 0.02 ];
        xTT={'0.001';'0.01';'0.02'};
        iflag=1; 
        return;
    end
    if(fmax<=0.1)
        xtt=[0.001 0.01 0.1 ];
        xTT={'0.001';'0.01';'0.1'};
        iflag=1; 
        return;
    end
    if(fmax<=0.2)
        xtt=[0.001 0.01 0.1 0.2];
        xTT={'0.001';'0.01';'0.1';'0.2'};
        iflag=1; 
        return;
    end
    if(fmax<=0.5)
        xtt=[0.001 0.01 0.1 0.5];
        xTT={'0.001';'0.01';'0.1';'0.5'};
        iflag=1; 
        return;
    end
    if(fmax<=1)
        xtt=[0.001 0.01 0.1 1];
        xTT={'0.001';'0.01';'0.1';'1'};
        iflag=1; 
        return;
    end
    if(fmax<=5)
        xtt=[0.001 0.01 0.1 1 5];
        xTT={'0.001';'0.01';'0.1';'1';'5'};
        iflag=1; 
        return;
    end    
end


%
%  start 0.01
%
if(fmin>=0.01 && fmin<0.03)

    if(fmax<=0.2)
        xtt=[0.01 0.1 0.2 ];
        xTT={'0.01';'0.1';'0.2'};
        iflag=1; 
        return;
    end
    if(fmax<=1)
        xtt=[0.01 0.1 1 ];
        xTT={'0.01';'0.1';'1'};
        iflag=1; 
        return;
    end
    if(fmax<=2)
        xtt=[0.01 0.1 1 2];
        xTT={'0.01';'0.1';'1';'2'};
        iflag=1; 
        return;
    end
    if(fmax<=5)
        xtt=[0.01 0.1 1 5];
        xTT={'0.01';'0.1';'1';'5'};
        iflag=1; 
        return;
    end

end


%
%  start 0.1
%
if(fmin>=0.1 && fmin<0.3)

    if(fmax<=2)
        xtt=[0.1 1 2 ];
        xTT={'0.1';'1';'2'};
        iflag=1; 
        return;
    end
    if(fmax<=10)
        xtt=[0.1 1 10 ];
        xTT={'0.1';'1';'10'};
        iflag=1; 
        return;
    end
    if(fmax<=20)
        xtt=[0.1 1 10 20];
        xTT={'0.1';'1';'10';'20'};
        iflag=1; 
        return;
    end
    if(fmax<=50)
        xtt=[0.1 1 10 50];
        xTT={'0.1';'1';'10';'50'};
        iflag=1; 
        return;
    end

end

%
%
%  start 0.3
%
if(fmin>=0.3 && fmin<1)

    if(fmax<=20)
        xtt=[0.3 1 10 20];
        iflag=1; 
        return;
    end
    if(fmax<=50)
        xtt=[0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20 30 40 50];
        xTT={'0.3';'';'';'';'';'';'';'1';'';'';'';'';'';'';'';'';'10';'';'';'';'50'};
        iflag=1; 
        return;
    end
    if(fmax<=100)
        xtt=[0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100];
        xTT={'0.3';'';'';'';'';'';'';'1';'';'';'';'';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100'};
        iflag=1; 
        return;
    end
end

%
%
%  start 1
%

if(fmin>=1 && fmin<2)

    if(fmax<=20)
        xtt=[1 10 20];
        xTT={'1';'10';'20'};
        iflag=1; 
        return;
    end
    if(fmax<=50)
        xtt=[1 10 20 30 40 50];
        xTT={'1';'10';'20';'30';'40';'50'};
        iflag=1; 
        return;
    end  
    if(fmax<=100)
        xtt=[1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100];
        xTT={'1';'';'';'';'';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100'};
        iflag=1; 
        return;
    end  

end

%
%  start 2
%


if(fmin>=2 && fmin<5)

    if(fmax<=80)
        xtt=[2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80];
        xTT={'2';'';'';'';'';'';'';'';'10';'';'';'';'';'';'';'80'};
        iflag=1; 
        return;
    end
end


%
%  start 5
%

if(fmin>=5 && fmin<10)

    if(fmax<51)
        xtt=[5 6 7 8 9 10 20 30 40 50];
        xTT={'5';'';'';'';'';'10';'';'';'';'50'};
        iflag=1; 
        return;
    end
    if(fmax<101)
        xtt=[5 6 7 8 9 10 20 30 40 50 60 70 80 90 100];
        xTT={'5';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100'};
        iflag=1; 
        return;
    end
    if(fmax<510)
        xtt=[5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500];
        xTT={'5';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100';'';'';'';'500'};
        iflag=1; 
        return;
    end
    if(fmax<1010)
        xtt=[5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000];
        xTT={'5';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100';'';'';'';'500';'';'';'';'';'1000'};
        iflag=1; 
        return;
    end
    if(fmax<=2050)
        xtt=[5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000];
        xTT={'5';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100';'';'';'';'500';'';'';'';'';'1000';'2000'};
        iflag=1; 
        return;
    end

end


%
%  start 10
%

if(fmin>=10 && fmin<20)

    if(fmax<51)
        xtt=[10 20 30 40 50];
        xTT={'10';'20';'30';'40';'50'};
        iflag=1; 
        return;
    end
    if(fmax<=105)
        xtt=[10 20 30 40 50 60 70 80 90 100];
        xTT={'10';'';'';'';'';'';'';'';'';'100'};
        iflag=1; 
        return;    
    end
    if(fmax<=205)
        xtt=[10 20 30 40 50 60 70 80 90 100 200];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'200'};
        iflag=1; 
        return;    
    end
    if(fmax<=505)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'500'};
        iflag=1; 
        return;
    end
    if(fmax<=1020)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000'};
        iflag=1; 
        return;
    end
    if(fmax<=2050)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000'};
        iflag=1; 
        return;
    end
    if(fmax<=3050)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'3000'};
        iflag=1; 
        return;
    end
    if(fmax<=4050)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'4000'};
        iflag=1; 
        return;
    end
    if(fmax<=5100)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'5000'};
        iflag=1; 
        return;
    end
%
    if(fmax<=10010)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K'};
        iflag=1; 
        return;
    end
%
    if(fmax<=20010)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K';'20K'};
        iflag=1; 
        return;
    end

end


%
%  start 20
%

if(fmin>=20 && fmin<50)

    if(fmax<=1010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000'};
        iflag=1; 
        return;
    end    
    if(fmax<=2010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000'};
        iflag=1; 
        return;
    end
    if(fmax<=3000)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1K';'2K';'3K'};
        iflag=1; 
        return;
    end
    if(fmax<=4000)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'4000'};
        iflag=1; 
        return;
    end
    if(fmax<=5010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'5000'};
        iflag=1; 
        return;
    end
    if(fmax<=10010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K'};
        iflag=1; 
        return;
    end
    if(fmax<=15010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 15000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K';'15K'};
        iflag=1; 
        return;
    end
    if(fmax<=20010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K';'20K'};
        iflag=1; 
        return;
    end

end


%
%  start 50
%

if(fmin>=50 && fmin<100)

    if(fmax<=2010)
        xtt=[50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000];
        xTT={'50';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1K';'2K'};
        iflag=1; 
        return;
    end    
    if(fmax<=3010)
        xtt=[50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000];
        xTT={'50';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1K';'2K';'3K'};
        iflag=1; 
        return;
    end
    if(fmax<=4010)
        xtt=[50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000];
        xTT={'50';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1K';'2K';'3K','4K'};
        iflag=1; 
        return;
    end

end

%
%  start 100
%

if(fmin>=100 && fmin<200)

    if(fmax<=2010)
        xtt=[100 200 300 400 500 600 700 800 900 1000 2000];
        xTT={'100';'';'';'';'';'';'';'';'';'1000';'2000'};
        iflag=1; 
        return;
    end

    if(fmax<=3010)
        xtt=[100 200 300 400 500 600 700 800 900 1000 2000 3000];
        xTT={'100';'200';'';'';'500';'';'';'';'';'1000';'2000';'3000'};
        iflag=1; 
        return;
    end

    if(fmax<=4010)
        xtt=[100 200 300 400 500 600 700 800 900 1000 2000 3000 4000];
        xTT={'100';'';'';'';'';'';'';'';'';'1000';'2000';'3000';'4000'};
        iflag=1; 
        return;
    end

    if(fmax<=5010)
        xtt=[100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000];
        xTT={'100';'';'';'';'';'';'';'';'';'1000';'2000';'3000';'4000';'5000'};
        iflag=1; 
        return;
    end

    if(fmax<=10010)
        xtt=[100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
        xTT={'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K'};
        iflag=1; 
        return;
    end

end

%
%  start 200
%

if(fmin>=200 && fmin<=2000)

    if(fmax<=2010)
        xtt=[200 300 400 500 600 700 800 900 1000 2000];
        xTT={'200';'';'';'';'';'';'';'';'1000';'2000'};
        iflag=1; 
        return;
    end
    if(fmax<=3010)
        xtt=[200 300 400 500 600 700 800 900 1000 2000 3000];
        xTT={'200';'';'';'';'';'';'';'';'1000';'2000';'3000'};
        iflag=1; 
        return;
    end   
    if(fmax<=10010)
        xtt=[200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
        xTT={'200';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K'};
        iflag=1; 
        return;
    end     
    
end


%
%

catch
   
   out1=sprintf(' fmin=%9.5g  fmax=%9.5g  ',fmin,fmax);
   disp(out1);
   
   warndlg('xtick_label error ');
   return;
end  
    