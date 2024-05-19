%
%   spl_power_bar_alt.m  ver 1.7  by Tom Irvine
%
%   One-Third Octave Sound Power Level Plot
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     fig_num = figure number
%
%     f = frequency (Hz)
%    dB = dB level
%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables
%
%     fig_num = figure number plus 1
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
%
%     oaspl_function.m
%     dB_ylimits.m
%     xtick_label.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fig_num]=spl_power_bar_alt(fig_num,f,dB)

    figure(fig_num);
    fig_num=fig_num+1;

oaspl=10*log10(sum(10.^(dB/10)));

fprintf('\n Overall Sound Power Level = %8.4g dB \n',oaspl);

disp('  ');
disp(' zero dB Reference = 1 pico W ');
disp('  ');
%

pf=f;
pspl=dB;
clear f;


%%%

%  figure(fig_num);
%    fig_num=fig_num+1;
%    plot(pf,pspl);
%    ylabel('SPL (dB)');
%    xlabel('Center Frequency (Hz)');
%

    out7=sprintf('One-Third Octave Sound Power Level \n Overall Level =  %7.4g dB  Ref= 1 pico W',oaspl);

%    
%    title(out7);
%
%    grid on;
%    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
    
    fmin=pf(1);
    fmax=pf(end);
    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);
        xlim([fmin,fmax]);    
    end   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%
  pf=fix_size(pf);
  pspl=fix_size(pspl);
%
%%
    a(1)=1;
    a(2)=2;
    a(3)=4;
    a(4)=8; 
    a(5)=16;
    a(6)=31.5;
    a(7)=63;
    a(8)=125;
    a(9)=250;
    a(10)=500;
    a(11)=1000;
    a(12)=2000;
    a(13)=4000;
    a(14)=8000;
    a(15)=16000;
%
    clear f;
%
    bn=zeros(length(pspl),1);
    
    for i=1:length(pspl)
        bn(i)=i;
        f{i}=' ';
        
        for j=1:15
                
            if( (abs(pf(i)-a(j))/a(j)) < 0.05 )
                                
                if(j==11)
                    f{i}='1K';
                    break;
                end
                if(j==12)
                    f{i}='2K';
                    break;
                end
                if(j==13)
                    f{i}='4K';
                    break;
                end
                if(j==14)
                    f{i}='8K';
                    break;
                end
                if(j==15)
                    f{i}='16K';
                    break;
                end               
                f{i}=sprintf('%g',a(j));
                break;
            end    
  
        end    
           
    end
%
    f=fix_size(f);
%
    cpf=zeros(length(pf),1);
    cpf(1)=pf(1);
    oct=2^(1/3);
    for i=2:length(pf)
        cpf(i)=cpf(i-1)*oct;
    end
%
    xx=log10(cpf);
    width=0.7;
    bar(xx,pspl,width);
    ylabel('Power (dB)');
    xlabel('Center Frequency (Hz)');
%    
    title(out7);
%
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','lin');
    set(gca,'Xtick',xx)
    set(gca,'XTickLabel',f)
%
    minp=min(pspl);
    maxp=max(pspl);
%
    for i=0:20
        b=i*10;
        if(b>minp)
            ymin=b-10;
            break;
        end    
    end
%
    for i=0:20
        b=i*10;
        if(b>maxp)
            ymax=b;
            break;
        end    
    end
%
    fmin=log10(min(pf)/1.2599);
    fmax=log10(max(pf)*1.2599);
%
    axis([fmin,fmax,ymin,ymax]);

