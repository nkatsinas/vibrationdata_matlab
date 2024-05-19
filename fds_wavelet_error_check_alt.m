function[err]=fds_wavelet_error_check_alt(Lfn,yy,fds)


    dd=zeros(Lfn,1);
    
    for i=1:Lfn
        
        
        d(1)=yy(i,1)/fds(i,1);
        d(2)=yy(i,2)/fds(i,2);
        d(3)=yy(i,3)/fds(i,3);
        d(4)=yy(i,4)/fds(i,4);      
        
        dd(i)=sum(abs(log10(d)));
        
    end

    
    err=max(dd)*sum(dd);
    

