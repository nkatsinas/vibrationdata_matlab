%
%  ws_synth_exp.m  ver 1.3 by Tom Irvine
%
function[amp,td,nhs,stype]=ws_synth_exp(amp_start,dur,~,inn,f,nspec)  %% random
%
    stype='synth3';
%
    max_nhs=11;

    nflag=0; 
    
    alpha=2*pi*0.03;

    amp=zeros(inn,nspec);
    td=zeros(inn,nspec);
    nhs=zeros(inn,nspec);
    
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

            rr=0.8+0.4*rand(); 
            td(inn,i)=(0.5*exp(-alpha*f(i)*rr)+0.005)*dur;
            
 %%%%                 td(inn,i)=0.1*dur*rand();
                
        end
%
        for i=1:nspec
            nhs(inn,i)= -1 + 2*round(25.*rand());
 
            
            if( nhs(inn,i) < max_nhs )
                nhs(inn,i)=max_nhs;
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

    end