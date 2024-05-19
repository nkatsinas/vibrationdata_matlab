%
%  ws_synth1.m  ver 1.1 by Tom Irvine
%
function[amp,td,nhs,stype]=ws_synth1(amp_start,dur,onep5_period,inn,f,nspec)  %% random
%
    stype='synth1';
%
    nflag=0; 
    
    while(nflag==0)
%
        nflag=1;
%
        for i=1:nspec
            amp(inn,i)= amp_start(i);
%
            if( rand() < 0.5 )
                amp(inn,i)=-amp(inn,i);
            end
%
            td(inn,i)=(rand()*(dur - onep5_period(i)));
        end
%
        for i=1:nspec
            nhs(inn,i)= -1 + 2*round(150.*rand());
 
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
                nflag=0;
            end
        end
    end