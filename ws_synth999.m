
% ws_synth3b.m  ver 1.2  by Tom Irvine


function[amp,td,nhs,stype]=ws_synth999(amp_start,dur,onep5_period,inn,f,nspec,store_amp,store_NHS,store_td,iwin)   
%
  stype='synth999';
%
  nflag=0; 
    
    while(nflag==0)
%
        nflag=1;
%
        for i=1:nspec
            amp(inn,i)= store_amp(iwin,i);
            td(inn,i)=  store_td(iwin,i)*(0.995+0.01*rand());
        end
%
        for i=1:nspec
            
            nhs(inn,i)=store_NHS(iwin,i);
  
            
            if( nhs(inn,i) < 3 )
                nhs(inn,i)=3;
            end
 %           
            while(1)
                if( ((nhs(inn,i))/(2.*f(i)))+td(inn,i) >= dur )
                    if(rand()<0.3)
                       nhs(inn,i)=nhs(inn,i)-2;
                    else
                        td(inn,i)=td(inn,i)*rand();
                    end
                else
                    break;
                end
            end
        end
%
        for i=1:nspec
            if( (nhs(inn,i)) < 3 )           
                nhs(inn,i)=3;
                 td(inn,i)=0;
            end
        end
    end    