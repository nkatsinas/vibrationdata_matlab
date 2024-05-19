
clear xrms;
clear svrs;
clear fn;

fi=input(' Enter frequency (Hz)   ');
y=0.5;

y=y*(2*pi*fi);
y=y/386;

Q=10;
damp = 1/(2*Q);


f1=10;
f2=2000;

c=2^(1/48);

fn(1)=5;

for i=2:1000
    fn(i)=fn(i-1)*c;
    if(fn(i)>f2)
        break;
    end
end    

num=length(fn);

svrs=zeros(num,2);

for j=1:num
    
    rho = fi/fn(j);
    tdr=2*damp*rho;

    c1=tdr^2;
    c2=(1-rho^2)^2;

    t= sqrt( (1 + c1 ) / ( c2 + c1 )  );
    xrms=t*y/sqrt(2);

    svrs(j,1)=fn(j);
    svrs(j,2)=xrms;  

    fprintf(' y=%8.4g  fn=%8.4g  xrms=%8.4g \n',y,fn(j),xrms);

end

md=6;
fig_num=1;
x_label='Frequency (Hz)';
y_label='Accel (GRMS)';
ppp=svrs;
fmin=5;
fmax=2000;
t_string=sprintf('VRS Q=10  fi=%7.3g Hz',fi);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

