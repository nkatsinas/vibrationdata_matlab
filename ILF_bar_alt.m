%
%   ILF_bar_alt.m  ver 1.7  by Tom Irvine
%
%   One-Third Octave Power Level Plot
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     fig_num = figure number
%
%     f = frequency (Hz)
%    LF = loss factor
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
%     xtick_label.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fig_num]=ILF_bar_alt(fig_num,f,LF)

    figure(fig_num);
    fig_num=fig_num+1;

    pf=f;

    out7=sprintf('Internal Loss Factor');
    
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
  LF=fix_size(LF);
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
    bn=zeros(length(LF),1);
    
    for i=1:length(LF)
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
    bar(xx,LF,width);
    ylabel('Loss Factor');
    xlabel('Center Frequency (Hz)');
%    
    title(out7);
%
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
    set(gca,'Xtick',xx)
    set(gca,'XTickLabel',f)
%
    fmin=log10(min(pf)/1.2599);
    fmax=log10(max(pf)*1.2599);
%
    xlim([fmin,fmax]);

