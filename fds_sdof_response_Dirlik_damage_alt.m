


%  fds_sdof_response_Dirlik_damage_alt.m   ver 1.0  by Tom Irvine

%    Dirlik relative damage for sdof response to base input psd
%
%    base_psd = base input psd with two columns:
%       frequency (Hz) & psd (G^2/Hz)
%
% The base input time history must have a constant time step
%
%          fn = natural frequency (Hz)
%           Q = amplification factor (typically 10 <= Q <=30)
%           b = fatigue exponent (typically 4 <= b <= 8 )
%
%     Both Q & b may be 1-dimensional arrays with multiple values, such as
%
%           Q = [10 30]
%           b = [4 8]
%
%          T = duration (sec) 
%
%    ispace is frequency spacing index
%
%    ispace=1 for 1/6 octave
%          =2 for 1/12 octave
%          =3 for 1/24 octave
%
%
%   fds has multiple columns:
%       natural frequency (Hz)
%       and relative damage (accel unit)^b for each Q and b combination 
%                

function[fds]=fds_sdof_response_Dirlik_damage_alt(base_psd,Q,b,T,ispace,plots)
%

  close all;

  tpi=2*pi;

  fstart=base_psd(1,1);
    fend=base_psd(end,1);

num=5000;

df=(fend-fstart)/(num-1);

new_freq=linspace(fstart,fend,num);
    
[fi,base_psd_int] = interpolate_PSD_arbitrary_frequency_f(base_psd(:,1),base_psd(:,2),new_freq);

%%

if(ispace~=1 && ispace~=2 && ispace~=3)
    warndlg('ispace must be equal to 1, 2 or 3');
    return;
end
    
if(ispace==1)
    oct=2^(1/6);
end   
if(ispace==2)
    oct=2^(1/12);
end    
if(ispace==3)
    oct=2^(1/24);
end    
  
fn(1)=fi(1);

fmax=fi(end);

fstart=base_psd(1,1);
  fend=base_psd(end,1);

num=1;

while(1)    
    num=num+1;
  
    fn(num)=fn(num-1)*oct;
  
    if(fn(num)==fend)
        break;
    end
    if(fn(num)>fend)
        fn(num)=fend;
        break;
    end
    
end


[fn]=fix_size(fn);
    
numfn=length(fn);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
NQ=length(Q);
Nb=length(b);

fds=zeros(numfn,(NQ*Nb+1));
fds(:,1)=fn;
    
nc=zeros(NQ,Nb);
    
ijk=1;
    
for iq=1:NQ
    for ib=1:Nb  
        nc(iq,ib)=ijk;
        ijk=ijk+1;
    end
end    

omega=tpi*fi;
om2=omega.^2; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

for iq=1:NQ

    damp=1/(2*Q(iq));


    for i=1:numfn 
         
        omegan=tpi*fn(i);          
        omn2=omegan.^2;
    
        den= (omn2-om2) + (1i)*(2*damp*omegan*omega);    
        num=omn2+(1i)*2*damp*omega*omegan;
%
        accel_complex=num./den;

        accel_complex=fix_size(accel_complex);
    
        power_trans=(abs(accel_complex)).^2;

        response_psd=power_trans.*base_psd_int;
%%
        m0=0;
        m1=0;
        m2=0;
        m4=0;
%
        numfi=length(fi);
%
        for ijk=1:numfi
%    
            ddf=df;
    
            if(ijk==1 || ijk==numfi)
                ddf=df/2.;
            end

            m0=m0+response_psd(ijk)*ddf;
            m1=m1+response_psd(ijk)*fi(ijk)*ddf;
            m2=m2+response_psd(ijk)*fi(ijk)^2*ddf;
            m4=m4+response_psd(ijk)*fi(ijk)^4*ddf;
%    
        end
%
%%

        for ib=1:Nb   
            A=1;
            m=b(ib);
            [damage]=sf_Dirlik(m,A,T,m0,m1,m2,m4);
            fds(i,(nc(iq,ib)+1))=damage;

        end

    end
end

    if(plots==1)
        generate_fds_plot(fds,Q,b);        
    end    

    disp(' ');
    disp(' * * * * * * * * * * * * * * ');
    disp(' ');
    disp(' Output array fds has the following columns:');
    disp('  Col 1:  natural frequency (Hz)');
    
    for iq=1:NQ
        for ib=1:Nb  
            out1=sprintf('  Col %d:  fds damage (G^%g)   Q=%g  b=%g',(1+nc(iq,ib)),b(ib),Q(iq),b(ib));
            disp(out1);
        end
    end      
    disp(' ');    
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%  fix_size.m  ver 1.2  by Tom Irvine
%
function[a]=fix_size(a)
sz=size(a);
if(sz(2)>sz(1))
    a=transpose(a);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%  sf_Dirlik_function.m  ver 1.1  by Tom Irvine
%
%  Dirlik rainflow cycle counting from a PSD
%

function[DDK]=sf_Dirlik(m,A,T,m0,m1,m2,m4)

%
EP=sqrt(m4/m2);
%
x=(m1/m0)*sqrt(m2/m4);
gamm=m2/(sqrt(m0*m4));
%
D1=2*(x-gamm^2)/(1+gamm^2);
R=(gamm-x-D1^2)/(1-gamm-D1+D1^2);
D2=(1-gamm-D1+D1^2)/(1-R);
D3=1-D1-D2;
%
Q=1.25*(gamm-D3-D2*R)/D1;
%
%%%%%%%%%
%



arg=m+1;
gf1=gamma(arg);

arg=0.5*m+1;
gf2=gamma(arg);

t1=D1*(Q^m)*gf1;

t2=(sqrt(2)^m)*gf2*( D2*(abs(R))^m  + D3 );

mh=m/2;

DDK=(EP*T/A)*(m0^mh)*( t1 + t2 );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   interpolate_PSD_arbitrary_frequency_f.m  ver 1.0   by Tom Irvine
%
function[fi,ai] = interpolate_PSD_arbitrary_frequency_f(f,a,new_freq)
%
    if(f(1) < .0001)
        f(1)=[];
        a(1)=[];
    end
%
    m=length(f);
%
%   calculate slopes
%
    s=zeros(m-1,1);

    for i=1:m-1
        s(i)=log(  a(i+1) / a(i)  )/log( f(i+1) / f(i) );
    end    
%
    np = length(new_freq);
%
    ai=zeros(np,1);
%
	fi=new_freq; 
    
    for  i=1:np 
%       
        for j=1:(m-1)
%
            if(fi(i)==f(j))
                ai(i)=a(j);
                break;
            end
            if(fi(i)==f(end))
                ai(i)=a(end);
                break;
            end            
%
			if( ( fi(i) >= f(j) ) && ( fi(i) <= f(j+1) )  )
				ai(i)=a(j)*( ( fi(i) / f(j) )^ s(j) );
				break;
            end
        end
%               
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
function[]=generate_fds_plot(fds,Q,bex)
 
    NQ=length(Q);
    Nb=length(bex);

    fig_num=10;
    
    fn=fds(:,1);
    damage=fds(:,2:end);
    fmin=fn(1);
    fmax=fn(end);
    
    size(damage)
    
    if(NQ==1 && Nb==1)
    
        t_string=sprintf('FDS Acceleration Q=%g b=%g',Q,bex);
    
        damage=fds(:,2);
        multiple_fds_plot_1x1_alt(fig_num,bex,fn,damage,t_string,fmin,fmax);

    end
    
    if(NQ*Nb==2)
        multiple_fds_plot_1x2_f(fig_num,Q,bex,fn,damage);
    end    
    

    if(NQ==2 && Nb==2)    
        multiple_fds_plot_2x2_f(fig_num,Q,bex,fn,damage);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

%  multiple_fds_plot_1x1_alt.m  ver 1.0  by Tom Irvine

function[fig_num]=multiple_fds_plot_1x1_alt(fig_num,bex,fn,fds,t_string,fmin,fmax)
%

[xtt,xTT,iflag]=xtick_label_f(fmin,fmax);


hp=figure(fig_num);
fig_num=fig_num+1;
%        
ff=fds(:,1);

y_label=sprintf('Damage log10(G^%g)',bex);

plot(fn,log10(ff));
title(t_string);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax])


ymax=max(log10(ff));
ymin=min(log10(ff));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
%  ytick_linear_alt.m  ver 1.1  by Tom Irvine

function[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin)

if((ymax-ymin)<=18)

    for i=-100:2:100
        if(ymax<i)
            ymax=i;
            break;
        end
    end    
    
    for i=-100:2:100
        if(ymin<i)
            ymin=i-2;
            break;
        end
    end
    
    k=1;    
    
    if((ymax-ymin)<=8)
        iq=1;
    else
        iq=2;
    end
    
    for i=ymin:iq:ymax
        ytt(k)=i;
        yTT{k}=sprintf('%d',i);
        k=k+1;
    end    
    
else    
    
    for i=-100:5:100
        if(ymax<i)
            ymax=i;
            break;
        end
    end    

    for i=-100:5:100
        if(ymin<i)
            ymin=i-5;
            break;
        end
    end

    k=1;
    for i=ymin:5:ymax
        ytt(k)=i;
        yTT{k}=sprintf('%d',i);
        k=k+1;
    end    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
%
%   xtick_label_f.m  ver 2.9  by Tom Irvine
%
function[xtt,xTT,iflag]=xtick_label_f(fmin,fmax)


try

xtt=[];
xTT={};
iflag=0;



%
%  start 0.001
%
if(fmin>=0.001 && fmin<0.005)

    if(fmax<=0.2)
        xtt=[0.001 0.01 0.02 ];
        xTT={'0.001';'0.01';'0.02'};
        iflag=1; 
        return;
    end
    if(fmax<=0.1)
        xtt=[0.001 0.01 0.1 ];
        xTT={'0.001';'0.01';'0.1'};
        iflag=1; 
        return;
    end
    if(fmax<=0.2)
        xtt=[0.001 0.01 0.1 0.2];
        xTT={'0.001';'0.01';'0.1';'0.2'};
        iflag=1; 
        return;
    end
    if(fmax<=0.5)
        xtt=[0.001 0.01 0.1 0.5];
        xTT={'0.001';'0.01';'0.1';'0.5'};
        iflag=1; 
        return;
    end
    if(fmax<=1)
        xtt=[0.001 0.01 0.1 1];
        xTT={'0.001';'0.01';'0.1';'1'};
        iflag=1; 
        return;
    end
    if(fmax<=5)
        xtt=[0.001 0.01 0.1 1 5];
        xTT={'0.001';'0.01';'0.1';'1';'5'};
        iflag=1; 
        return;
    end    
end


%
%  start 0.01
%
if(fmin>=0.01 && fmin<0.03)

    if(fmax<=0.2)
        xtt=[0.01 0.1 0.2 ];
        xTT={'0.01';'0.1';'0.2'};
        iflag=1; 
        return;
    end
    if(fmax<=1)
        xtt=[0.01 0.1 1 ];
        xTT={'0.01';'0.1';'1'};
        iflag=1; 
        return;
    end
    if(fmax<=2)
        xtt=[0.01 0.1 1 2];
        xTT={'0.01';'0.1';'1';'2'};
        iflag=1; 
        return;
    end
    if(fmax<=5)
        xtt=[0.01 0.1 1 5];
        xTT={'0.01';'0.1';'1';'5'};
        iflag=1; 
        return;
    end

end


%
%  start 0.1
%
if(fmin>=0.1 && fmin<0.3)

    if(fmax<=2)
        xtt=[0.1 1 2 ];
        xTT={'0.1';'1';'2'};
        iflag=1; 
        return;
    end
    if(fmax<=10)
        xtt=[0.1 1 10 ];
        xTT={'0.1';'1';'10'};
        iflag=1; 
        return;
    end
    if(fmax<=20)
        xtt=[0.1 1 10 20];
        xTT={'0.1';'1';'10';'20'};
        iflag=1; 
        return;
    end
    if(fmax<=50)
        xtt=[0.1 1 10 50];
        xTT={'0.1';'1';'10';'50'};
        iflag=1; 
        return;
    end

end

%
%
%  start 0.3
%
if(fmin>=0.3 && fmin<1)

    if(fmax<=20)
        xtt=[0.3 1 10 20];
        iflag=1; 
        return;
    end
    if(fmax<=50)
        xtt=[0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20 30 40 50];
        xTT={'0.3';'';'';'';'';'';'';'1';'';'';'';'';'';'';'';'';'10';'';'';'';'50'};
        iflag=1; 
        return;
    end
    if(fmax<=100)
        xtt=[0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100];
        xTT={'0.3';'';'';'';'';'';'';'1';'';'';'';'';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100'};
        iflag=1; 
        return;
    end
end

%
%
%  start 1
%

if(fmin>=1 && fmin<2)

    if(fmax<=20)
        xtt=[1 10 20];
        xTT={'1';'10';'20'};
        iflag=1; 
        return;
    end
    if(fmax<=50)
        xtt=[1 10 20 30 40 50];
        xTT={'1';'10';'20';'30';'40';'50'};
        iflag=1; 
        return;
    end  
    if(fmax<=100)
        xtt=[1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100];
        xTT={'1';'';'';'';'';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100'};
        iflag=1; 
        return;
    end  

end

%
%  start 2
%


if(fmin>=2 && fmin<5)

    if(fmax<=80)
        xtt=[2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80];
        xTT={'2';'';'';'';'';'';'';'';'10';'';'';'';'';'';'';'80'};
        iflag=1; 
        return;
    end
end


%
%  start 5
%

if(fmin>=5 && fmin<10)

    if(fmax<51)
        xtt=[5 6 7 8 9 10 20 30 40 50];
        xTT={'5';'';'';'';'';'10';'';'';'';'50'};
        iflag=1; 
        return;
    end
    if(fmax<101)
        xtt=[5 6 7 8 9 10 20 30 40 50 60 70 80 90 100];
        xTT={'5';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100'};
        iflag=1; 
        return;
    end
    if(fmax<510)
        xtt=[5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500];
        xTT={'5';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100';'';'';'';'500'};
        iflag=1; 
        return;
    end
    if(fmax<1010)
        xtt=[5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000];
        xTT={'5';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100';'';'';'';'500';'';'';'';'';'1000'};
        iflag=1; 
        return;
    end
    if(fmax<=2050)
        xtt=[5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000];
        xTT={'5';'';'';'';'';'10';'';'';'';'';'';'';'';'';'100';'';'';'';'500';'';'';'';'';'1000';'2000'};
        iflag=1; 
        return;
    end

end


%
%  start 10
%

if(fmin>=10 && fmin<20)

    if(fmax<51)
        xtt=[10 20 30 40 50];
        xTT={'10';'20';'30';'40';'50'};
        iflag=1; 
        return;
    end
    if(fmax<=105)
        xtt=[10 20 30 40 50 60 70 80 90 100];
        xTT={'10';'';'';'';'';'';'';'';'';'100'};
        iflag=1; 
        return;    
    end
    if(fmax<=205)
        xtt=[10 20 30 40 50 60 70 80 90 100 200];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'200'};
        iflag=1; 
        return;    
    end
    if(fmax<=505)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'500'};
        iflag=1; 
        return;
    end
    if(fmax<=1020)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000'};
        iflag=1; 
        return;
    end
    if(fmax<=2050)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000'};
        iflag=1; 
        return;
    end
    if(fmax<=3050)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'3000'};
        iflag=1; 
        return;
    end
    if(fmax<=4050)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'4000'};
        iflag=1; 
        return;
    end
    if(fmax<=5100)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'5000'};
        iflag=1; 
        return;
    end
%
    if(fmax<=10010)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K'};
        iflag=1; 
        return;
    end
%
    if(fmax<=20010)
        xtt=[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000];
        xTT={'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K';'20K'};
        iflag=1; 
        return;
    end

end


%
%  start 20
%

if(fmin>=20 && fmin<50)

    if(fmax<=1010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000'};
        iflag=1; 
        return;
    end    
    if(fmax<=2010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000'};
        iflag=1; 
        return;
    end
    if(fmax<=3000)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1K';'2K';'3K'};
        iflag=1; 
        return;
    end
    if(fmax<=4000)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'4000'};
        iflag=1; 
        return;
    end
    if(fmax<=5010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'5000'};
        iflag=1; 
        return;
    end
    if(fmax<=10010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K'};
        iflag=1; 
        return;
    end
    if(fmax<=15010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 15000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K';'15K'};
        iflag=1; 
        return;
    end
    if(fmax<=20010)
        xtt=[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000];
        xTT={'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K';'20K'};
        iflag=1; 
        return;
    end

end


%
%  start 50
%

if(fmin>=50 && fmin<100)

    if(fmax<=2010)
        xtt=[50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000];
        xTT={'50';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1K';'2K'};
        iflag=1; 
        return;
    end    
    if(fmax<=3010)
        xtt=[50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000];
        xTT={'50';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1K';'2K';'3K'};
        iflag=1; 
        return;
    end
    if(fmax<=4010)
        xtt=[50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000 3000 4000];
        xTT={'50';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1K';'2K';'3K','4K'};
        iflag=1; 
        return;
    end

end

%
%  start 100
%

if(fmin>=100 && fmin<200)

    if(fmax<=2010)
        xtt=[100 200 300 400 500 600 700 800 900 1000 2000];
        xTT={'100';'';'';'';'';'';'';'';'';'1000';'2000'};
        iflag=1; 
        return;
    end

    if(fmax<=3010)
        xtt=[100 200 300 400 500 600 700 800 900 1000 2000 3000];
        xTT={'100';'200';'';'';'500';'';'';'';'';'1000';'2000';'3000'};
        iflag=1; 
        return;
    end

    if(fmax<=4010)
        xtt=[100 200 300 400 500 600 700 800 900 1000 2000 3000 4000];
        xTT={'100';'';'';'';'';'';'';'';'';'1000';'2000';'3000';'4000'};
        iflag=1; 
        return;
    end

    if(fmax<=5010)
        xtt=[100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000];
        xTT={'100';'';'';'';'';'';'';'';'';'1000';'2000';'3000';'4000';'5000'};
        iflag=1; 
        return;
    end

    if(fmax<=10010)
        xtt=[100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
        xTT={'100';'';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K'};
        iflag=1; 
        return;
    end

end

%
%  start 200
%

if(fmin>=200 && fmin<=2000)

    if(fmax<=2010)
        xtt=[200 300 400 500 600 700 800 900 1000 2000];
        xTT={'200';'';'';'';'';'';'';'';'1000';'2000'};
        iflag=1; 
        return;
    end
    if(fmax<=3010)
        xtt=[200 300 400 500 600 700 800 900 1000 2000 3000];
        xTT={'200';'';'';'';'';'';'';'';'1000';'2000';'3000'};
        iflag=1; 
        return;
    end   
    if(fmax<=10010)
        xtt=[200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
        xTT={'200';'';'';'';'';'';'';'';'1000';'';'';'';'';'';'';'';'';'10K'};
        iflag=1; 
        return;
    end     
    
end


%
%

catch
   
   out1=sprintf(' fmin=%9.5g  fmax=%9.5g  ',fmin,fmax);
   disp(out1);
   
   warndlg('xtick_label error ');
   return;
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  multiple_fds_plot_2x2_f.m  ver 1.2  by Tom Irvine

function[fig_num]=multiple_fds_plot_2x2_f(fig_num,Q,bex,fn,damage)

%
fmin=min(fn);
fmax=max(fn);

[xtt,xTT,iflag]=xtick_label_f(fmin,fmax);



hp=figure(fig_num);
fig_num=fig_num+1;
subplot(2,2,1);
%        
ff=damage(:,1);
m=1;
n=1;
y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Acceleration Q=%g b=%g',Q(m),bex(n));
plot(fn,log10(ff));
title(t_string);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax])


ymax=max(log10(ff));
ymin=min(log10(ff));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,2);
%        
ff=damage(:,2);
m=1;
n=2;
y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Acceleration  Q=%g b=%g',Q(m),bex(n));
plot(fn,log10(ff));
title(t_string);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax]);    
 

ymax=max(log10(ff));
ymin=min(log10(ff));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,3);
%        
ff=damage(:,3);
m=2;
n=1;
y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Acceleration  Q=%g b=%g',Q(m),bex(n));
plot(fn,log10(ff));
title(t_string)
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%
%


set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax]); 


ymax=max(log10(ff));
ymin=min(log10(ff));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);



%%% out1=sprintf(' jflag=%d  ymin=%8.4g  ymax=%8.4g ',jflag,ymin,ymax);
%%% disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,4);
%        
ff=damage(:,4);
m=2;
n=2;
y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Acceleration  Q=%g b=%g',Q(m),bex(n));
plot(fn,log10(ff));
title(t_string)

grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax]); 


ymax=max(log10(ff));
ymin=min(log10(ff));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);



%
set(hp, 'Position', [0 0 950 650]);
%    
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  multiple_fds_plot_1x2_f.m  ver 1.2  by Tom Irvine

function[fig_num]=multiple_fds_plot_1x2_f(fig_num,Q,bex,fn,fds)

    
NQ=length(Q);
Nb=length(bex);


%
fmin=min(fn);
fmax=max(fn);

[xtt,xTT,iflag]=xtick_label_f(fmin,fmax);



hp=figure(fig_num);
fig_num=fig_num+1;
subplot(1,2,1);
%        
ff=fds(:,1);
y_label=sprintf('Damage log10(G^%g)',bex(1));
t_string=sprintf('FDS Acceleration Q=%g b=%g',Q(1),bex(1));
plot(fn,log10(ff));
title(t_string);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax])


ymax=max(log10(ff));
ymin=min(log10(ff));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(1,2,2);
%        
ff=fds(:,2);

if(NQ<Nb)
    m=1;
    n=2;
else
    m=2;
    n=1;    
end

y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Acceleration  Q=%g b=%g',Q(m),bex(n));
plot(fn,log10(ff));
title(t_string);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax]);    
 

ymax=max(log10(ff));
ymin=min(log10(ff));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

%

%
set(hp, 'Position', [0 0 950 350]);
%        