
%  sdof_psd_response_base.m  ver 1.0  by Tom Irvine

%    SDOF system psd response for base excitation
%
%    base_psd = base input psd with two columns:
%       frequency (Hz) & acceleration input (G^2/Hz)
%
%    base_psd is interpolated inside the function to 1/96th octave
%
%       fn = natural frequency (Hz)
%        Q = amplification factor (typically Q=10)
%
%   response_psd has two columns:  
%       frequency (Hz) & acceleration response (G^2/Hz)
%
%   supporting & plotting functions are included
%

function[response_psd]=sdof_psd_response_base_nofig(fn,Q,base_psd)
%
    tpi=2*pi;
    
    damp=1/(2*Q);
    
    fstart=base_psd(1,1);
      fend=base_psd(end,1);
 
    num=96*log(fend/fstart)/log(2);
    new_freq=logspace(log10(fstart),log10(fend),num);
  
    [freq,base_psd_int] = interpolate_PSD_arbitrary_frequency_f(base_psd(:,1),base_psd(:,2),new_freq);
    
            
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
    
    power_trans=(abs(accel_complex)).^2;

    response_psd=power_trans.*base_psd_int;
    
    response_psd=[freq response_psd];
    
  %  generate_plot_psd_response(base_psd,response_psd,fn,Q);

    
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

%   interpolate_PSD_arbitrary_frequency_f.m  ver 1.0   by Tom Irvine
%
function[fi,ai] = interpolate_PSD_arbitrary_frequency_f(f,a,new_freq)
%
    if(f(1) < .0001)
        f(1)=[];
        a(1)=[];
    end
%
    m=length(f);
%
%   calculate slopes
%
    s=zeros(m-1,1);

    for i=1:m-1
        s(i)=log(  a(i+1) / a(i)  )/log( f(i+1) / f(i) );
    end    
%
    np = length(new_freq);
%
    ai=zeros(np,1);
%
	fi=new_freq; 
    
    for  i=1:np 
%       
        for j=1:(m-1)
%
            if(fi(i)==f(j))
                ai(i)=a(j);
                break;
            end
            if(fi(i)==f(end))
                ai(i)=a(end);
                break;
            end            
%
			if( ( fi(i) >= f(j) ) && ( fi(i) <= f(j+1) )  )
				ai(i)=a(j)*( ( fi(i) / f(j) )^ s(j) );
				break;
            end
        end
%               
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   
%    calculate_PSD_slopes_f.m  ver 1.7  by Tom Irvine
%
function [s,grms] = calculate_PSD_slopes_f(f,a)
%
%
MAX = 12000;
%
ra=0.;
grms=0.;
iflag=0;
%
s=zeros(1,MAX);
%
if(f(1) < .0001)
    f(1)=[];
    a(1)=[];
end

np=length(f);

for i=np:-1:1
    if(a(i)==0)
        a(i)=[];
        f(i)=[];
    end
end
   

%
nn=length(f)-1;
%
for  i=1:nn
%
    if(  f(i) <=0 )
        disp(' frequency error ')
        out=sprintf(' f(%d) = %6.2f ',i,f(i));
        disp(out)
        iflag=1;
    end
    if(  a(i) <=0 )
        disp(' amplitude error ')
        out=sprintf(' a(%d) = %6.2f ',i,a(i));
        disp(out)
        iflag=1;
    end  
    if(  f(i+1) < f(i) )
        disp(' frequency error ')
        iflag=1;
    end  
    if(  iflag==1)
        break;
    end
%    
    if(f(i+1)~=f(i))
        s(i)=log10( a(i+1)/ a(i) )/log10( f(i+1)/f(i) );
    else
        s(i)=NaN;
    end
%   
 end
 %
 % disp(' RMS calculation ');
 %
 if( iflag==0)
    for i=1:nn
        if(abs(s(i))<1000)
            if(s(i) < -1.0001 ||  s(i) > -0.9999 )
                ra = ra + ( a(i+1) * f(i+1)- a(i)*f(i))/( s(i)+1.);
            else
                ra = ra + a(i)*f(i)*log( f(i+1)/f(i));
            end
        end
    end
    grms=sqrt(ra);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%   Generate Plot   
%
function[]=generate_plot_psd_response(base_psd,response_psd,fn,Q)

    figure(1);
    plot(base_psd(:,1),base_psd(:,2),response_psd(:,1),response_psd(:,2));
    
    
    [~,grms1] = calculate_PSD_slopes_f(base_psd(:,1),base_psd(:,2));
    [~,grms2] = calculate_PSD_slopes_f(response_psd(:,1),response_psd(:,2));
    
    out1=sprintf('Input  %6.3g GRMS',grms1);
    out2=sprintf('Response  %6.3g GRMS',grms2);
    
    legend(out1,out2);
    
    
    grid on;
    xlabel('Frequency (Hz)');
    ylabel('Accel (G^2/Hz)');
    out1=sprintf('PSD  SDOF Response, fn=%g Hz, Q=%g',fn,Q);
    title(out1);
    
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
    
    ymax= 10^ceil(log10(max(response_psd(:,2))*1.2));
    ymin= 10^floor(log10(min(response_psd(:,2))*0.999));
    
    z=ymax/1.0e+06;
    
    if(ymin<z)
        ymin=z;
    end
    
    ylim([ymin,ymax]);              
    
    
    fstart=base_psd(1,1);
      fend=base_psd(end,1);
    
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

    