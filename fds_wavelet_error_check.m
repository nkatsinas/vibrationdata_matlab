function[err_max,ampr,fdsr,accelr]=fds_wavelet_error_check(err_max,ampr,fdsr,accelr,Lfn,yy,fds,amp,accel_input,ijk,xi)


    dd=zeros(Lfn,1);
    
    for i=1:Lfn
        
        
        d(1)=yy(i,1)/fds(i,1);
        d(2)=yy(i,2)/fds(i,2);
        d(3)=yy(i,3)/fds(i,3);
        d(4)=yy(i,4)/fds(i,4);      
        
        dd(i)=sum(abs(log10(d)));
        
    end

    
    err=max(dd)*sum(dd);
    
%    fprintf('%d %8.5g %8.5g  %d\n',ijk,err_max,err,xi);
    
    if(err<err_max)
        err_max=err;
        ampr=amp;
        fdsr=fds;
        accelr=accel_input;
        fprintf(' %d %8.5g %d\n',ijk,err_max,xi);
    end