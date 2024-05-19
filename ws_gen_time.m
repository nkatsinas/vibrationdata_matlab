%
%    ws_gen_time.m  ver 2.3  by Tom Irvine
%
function[wavelet,th] = ws_gen_time(nhs,amp,omegaf,upper,nt,dt,td,igen,nv,wavelet,nspec)  
%        
        % for(i=1:nspec)
        %    if( (nhs(igen,i)) < 3 )
        %          nhs(igen,i)=3;
        %    end
        % end

        nhs(igen, nhs(igen,:) < 3) = 3;

%
        for i=1:nspec
            if(  omegaf(i) <= 0 || omegaf(i) > 1.0e+20 )    
                fprintf(' gt error: i=%ld  omegaf= %9.4g \n\n',i,omegaf(i));
            end
        end
%
        for i=1:nspec
            if(  abs(upper(i))<1.0e-20 )
%         
                fprintf(' error: i=%ld  upper= %9.4g \n\n ',i,upper(i));
                input(' ctrl-C ');
%
            end
        end
%
        if(nv==1)
%
            for j=1:nt 
%  
                t=dt*(j-1);
%
                for i=1:nspec
%
                    if(  omegaf(i) <= 0)    
                        fprintf(' ref 1: omegaf error \n\n ');
                    end
 
                    wavelet(i,j)=0.;
                    tt=t-td(igen,i);
                    ta= omegaf(i)*tt;
  
                    if( t>=td(igen,i) && tt <= upper(i) )
%
                        wavelet(i,j)=(sin(ta/(nhs(igen,i)) )*sin(ta));
%
                        if(  omegaf(i) <= 0)
                            fprintf( ' ref 2: omegaf error \n');
                        end
%                  
                        if( abs(wavelet(i,j)) > 1.0e+10)
%                        
                            fprintf(' wavelet error: i=%ld  j=%ld %9.4g\n\n',i,j,wavelet(i,j));
%
                        end 
                    end 
                end   
            end
        end
%
%
      www=zeros(nspec,nt);
      for k=1:nspec
          www(k,:)=amp(igen,k)*wavelet(k,:);
      end

      th=sum(www);
%
       if(std(th)<1.0e-20)
           fprintf('\n std(th) error \n\n');
           aaa=input(' control-C ');
       end
  end