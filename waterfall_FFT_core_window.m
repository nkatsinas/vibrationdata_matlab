%
%  waterfall_FFT_core_window.m  ver 1.2   by Tom Irvine
%
function[store,store_p,freq_p,max_a,max_f]=...
               waterfall_FFT_core_window(NW,mmm,mk,freq,amp,minf,io,window,imag,reference)
%
    store=zeros(NW,mk);
    max_a=zeros(NW,1);
    max_f=zeros(NW,1);
    sa=zeros(mmm,1);

%
%    progressbar;
    jk=1;
    for ij=1:NW
%
%        progressbar(ij/NW);
%
        clear sa;
%
        max_a(ij)=0.;
        max_f(ij)=0.;
        if(io==1)   
            for k=1:mmm
                sa(k)=amp(jk);
                jk=jk+1;
            end
        else
            for k=1:mmm
                sa(k)=amp(jk);
                jk=jk+1;
            end
            jk=floor(jk-mmm/2);
        end
%
        clear Y;
        
        if(window>=2)
            mr_choice=2;
            hw_choice=window;
            [sa]=mean_removal_Hanning(sa,mr_choice,hw_choice);
        end

        Y= fft(sa,mmm);
        
        store(ij,1) = abs(Y(1))/mmm; 
%

%   
        j=1;
        for k=1:mk 
           
            store(ij,k) =2.*abs(Y(k))/mmm; 
                    
            if(freq(k)>=minf)
                
                store_p(ij,j)=store(ij,k);
        
                freq_p(j)=freq(k);
                
                if(store_p(ij,j)>max_a(ij))
                    max_a(ij)=store_p(ij,j);
                    max_f(ij)=freq_p(j);
                end
                j=j+1;
            end
        end    
    end
    %
    
    if(imag==2)
        store_p=log10(store_p);
    end
    if(imag==3)
        store_p=20*log10(store_p/reference);        
    end
  
 % pause(0.4);  
 % progressbar(1);