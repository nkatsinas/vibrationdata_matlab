
%  sdof_transmissibility_base.m  ver 1.0  by Tom Irvine

%    SDOF system acceleration transmissibility for base excitation
%
%   fstart = starting excitation frequency (Hz)
%     fend = ending excitation frequency (Hz)
%
%    itype = 1 for linear interpolation at 0.5 Hz
%          = 2 for logarthmic interpolation at 1/96th octave  
%
%       fn = natural frequency (Hz)
%        Q = amplification factor (typically Q=10)
%
%   accel_trans_mag has two columns:  
%       excitation frequency (Hz) & acceleration transmissibility (G/G)
%
%   supporting & plotting functions are included
%

function[accel_trans_mag]=sdof_transmissibility_base(fstart,fend,itype,fn,Q)
%
    tpi=2*pi;
    
    damp=1/(2*Q);
 
    if(itype==1)
        df=0.5;
        num=1+round(fend-fstart)/df;
        freq=linspace(fstart,fend,num);
    else
        num=96*log(fend/fstart)/log(2);
        freq=logspace(log10(fstart),log10(fend),num);
    end
        
        
    omega=tpi*freq;
    omegan=tpi*fn;
    
    om2=omega.^2;   
    omn2=omegan.^2;
    
    den= (omn2-om2) + (1i)*(2*damp*omegan*omega);    
    num=omn2+(1i)*2*damp*omega*omegan;
%
    accel_complex=num./den;

    freq=fix_size(freq);
    accel_complex=fix_size(accel_complex);
    
    accel_trans_mag=[freq abs(accel_complex)];
    
    generate_plot(fstart,fend,accel_trans_mag,fn,Q);

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%  fix_size.m  ver 1.2  by Tom Irvine
%
function[a]=fix_size(a)
sz=size(a);
if(sz(2)>sz(1))
    a=transpose(a);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%   Generate Plot
%
function[]=generate_plot(fstart,fend,accel_trans_mag,fn,Q)

    figure(1);
    plot(accel_trans_mag(:,1),accel_trans_mag(:,2));
    grid on;
    xlabel('Frequency (Hz)');
    ylabel('Trans (G/G)');
    out1=sprintf('SDOF Transmissibility, fn=%g Hz, Q=%g',fn,Q);
    title(out1);
    
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
    
    ymax= 10^ceil(log10(max(accel_trans_mag(:,2))*1.2));
    ymin= 10^floor(log10(min(accel_trans_mag(:,2))*0.999));
    ylim([ymin,ymax]);              
    
    [xtt,xTT,iflag]=xtick_label_f(fstart,fend);
    
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        xlim([min(xtt),max(xtt)]);
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

    