
%  Dirlik_response_psd.m  ver 1.1  by Tom Irvine

%    Dirlik relative damage for response psd
%
%    response_psd = response psd with two columns:
%       frequency (Hz) & psd (unit^2/Hz)
%
%         b = fatigue exponent (typically: 4 <= b <= 8 )
%         T = duration (sec) 
%    damage = relative damage, dimension: (response amplitude unit)^b
%
%        EP = expected peak rate (Hz)
%        mo = zeroth spectral moment, equal to the variance
%

function[damage,EP,m0]=Dirlik_response_psd(response_psd,b,T)
%
 
  fstart=response_psd(1,1);
    fend=response_psd(end,1);
 

num=5000;

df=(fend-fstart)/(num-1);

new_freq=linspace(fstart,fend,num);
    
  
[fi,ai] = interpolate_PSD_arbitrary_frequency_f(response_psd(:,1),response_psd(:,2),new_freq);

%%

m0=0;
m1=0;
m2=0;
m4=0;
%
num=length(ai);
%
for i=1:num
%    
    ddf=df;
    
    if(i==1 || i==num)
        ddf=df/2.;
    end

    m0=m0+ai(i)*ddf;
    m1=m1+ai(i)*fi(i)*ddf;
    m2=m2+ai(i)*fi(i)^2*ddf;
    m4=m4+ai(i)*fi(i)^4*ddf;
%    
end
%
EP=sqrt(m4/m2);

%%

A=1;
m=b;

[damage]=sf_Dirlik(m,A,T,m0,m1,m2,m4);


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

    amin=1.0e-50;
    
    for i=1:m
        if(a(i)<amin)
            a(i)=amin;
        end
    end
    
    
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
    