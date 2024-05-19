%
%   generic_bar_alt.m  ver 1.7  by Tom Irvine
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     fig_num = figure number
%
%     f = frequency (Hz)
%     a = amplitude
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
%     xtick_label.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fig_num]=generic_bar_alt(fig_num,pf,pspl,t_string,ylab,md)

    figure(fig_num);
    fig_num=fig_num+1;   
    
    pf(end)
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%
  pf=fix_size(pf);
  pspl=fix_size(pspl);
  
  ijk=0;
  
  sz=size(pf);
  for i=1:sz(1)
      if(pspl(i)>0)
          ijk=i;
          break;
      end
  end
  
  for i=(ijk-1):-1:1
      pf(i)=[];
      pspl(i)=[];
  end
  
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
    
    if(pf(1)>16)
        disp('ref 1')
        for i=4:-1:1
            a(i)=[];
        end    
    end 
%
    clear f;
%
    bn=zeros(length(pspl),1);
    
    for i=1:length(pspl)
        bn(i)=i;
        f{i}=' ';
        
        for j=1:length(a)
                
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
    ylabel(ylab);
    xlabel('Center Frequency (Hz)');
%    
    title(t_string);
%
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
    set(gca,'Xtick',xx)
    set(gca,'XTickLabel',f)
%
    minp=min(pspl);
    maxp=max(pspl);
%
    fmin=log10(min(pf)/1.2599);
    fmax=log10(max(pf)*1.2599);
%
    xlim([fmin,fmax]);
    
ymax= 10^ceil(0.01+log10(maxp));
%
ymin= 10^floor(log10(minp));


if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    

ylim([ymin,ymax]);
