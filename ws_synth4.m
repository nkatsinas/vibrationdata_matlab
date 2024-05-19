
% ws_synth4.m  ver 1.3  by Tom Irvine

function[amp,td,nhs,stype]=ws_synth4(amp_start,dur,period_offset,ntrials,inn,f,nspec)  %% forward
%
    stype='synth4';
%
    nflag=0;
 
    
%
    while(nflag==0)
%
        nflag=1;
 
        
        ccc=0.1*rand();
        
        for i=1:nspec 
            period_offset(i)=(ccc/f(i));
        end        
  
        
        alpha=rand();
 
          beta=rand();
         gamma=rand();
         
%%         alpha=0.2126;
%%         beta=0.8087;
%%         gamma=0.585;
 
        
        nlimit = (2*fix(150.*beta))-1;
%%        out1=sprintf(' nlimit=%d ',nlimit);
%%        disp(out1);
%
        if(nlimit<3)
            nlimit=3;
        end 
  
        for i=1:nspec
%       
            nhs(inn,i)=nlimit;
            amp(inn,i)= amp_start(i);
%
            if(gamma<0.8)
                pol=((-1)^(i-1));
                amp(inn,i)=amp(inn,i)*pol;
            end
%
            tv=(nhs(inn,i))/(2.*f(i));
            td(inn,i)=(dur-tv)-alpha/f(i);     
            
            
            for ijk=1:200
                if( td(inn,i)< 0 )
                       nhs(inn,i)=nhs(inn,i)-2;
                       tv=(nhs(inn,i))/(2.*f(i));
                       td(inn,i)=(dur-tv);  
                else
                    break;
                end
            end  
            
            
%
        end 
%

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