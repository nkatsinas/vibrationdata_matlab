
% ws_synth3.m  ver 1.3  by Tom Irvine

function[amp,td,nhs,stype]=ws_synth3(amp_start,dur,~,ntrials,inn,f,nspec)  %% reverse
%
    stype='synth3';
%
    nflag=0;
        
%
    while(nflag==0)
%
        nflag=1;
 
        ccc=1.0+0.8*rand();
        
        period_offset = ccc ./ f(1:nspec);
 
        if(rand()<0.6)
            alpha=(0.1*1.2*rand());
        else
            alpha=(0.1*10*rand());
        end   
 
          beta=rand();
         gamma=rand();
 
        nlimit = (2*fix(150.*beta))-1;
%%        out1=sprintf(' nlimit=%d ',nlimit);
%%        disp(out1);
%
        if(nlimit<5)
            nlimit=5;
        end    
%
        if(inn< round(0.10*ntrials))
            alpha=(2/3);
        end    
%
        td(inn,nspec)=0.;
        nhs(inn,nspec)= nlimit;
        amp(inn,nspec)= amp_start(nspec-1);
%
        for i=(nspec-1):-1:1
%       
            amp(inn,i)= amp_start(i);
%
            if(gamma<0.8)
                pol=((-1)^(i-1));
                amp(inn,i)=amp(inn,i)*pol;
            end
%
            td(inn,i)=td(inn,i+1)+alpha*period_offset(i);
%
            while( (period_offset(i))+td(inn,i) >= dur )
                td(inn,i)=(rand()*(dur - period_offset(i)));
            end     
%
        end 
%
        for i=1:nspec
%
            nhs(inn,i)= nlimit;
%
            while(1)
                if( ((nhs(inn,i))/(2.*f(i)))+td(inn,i) >= dur )
                    if(rand()<0.5)
                       nhs(inn,i)=nhs(inn,i)-2;
                    else
                        td(inn,i)=td(inn,i)*rand();
                    end
                else
                    break;
                end
            end
%%           out1=sprintf('inn=%d f=%8.4g  amp=%8.4g td=%8.4g  nhs=%8.4g ',inn,f(i),amp(inn,i),td(inn,i),nhs(inn,i));
%%           disp(out1);
%
        end
%
        for i=1:nspec
%
            if( (nhs(inn,i)) < 3 )
%
                nflag=0;
                nhs(inn,i) = 3;
                 td(inn,i)=0;
% 
            end
        end
    end