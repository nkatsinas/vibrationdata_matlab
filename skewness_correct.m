clear a;
clear corrected;

L=length(AC_9841_th_hpf(:,1));
L
rscale=1;

rec=1.0e+90;

for j=1:100
    
    a=AC_9841_th_hpf;

    if(j<=10 || rand()<0.5)
        scale=1+rand();
    else
        scale=rscale*(0.98+0.04*rand());
    end

    for i=1:L
        if(a(i,2)>0)
            a(i,2)=a(i,2)*scale;
        end
    end
    
    [mu,sd,rms,sk,kt]=kurtosis_stats(a(:,2));
    
    if(abs(sk)<rec)
        rec=abs(sk);
        rscale=scale;
        corrected=a;
        fprintf(" %d  %7.3g  %7.4g  \n",j,rec,rscale);
    end

end



figure(1);
plot(a(:,1),a(:,2));
grid on;
xlabel='Time (sec)';

