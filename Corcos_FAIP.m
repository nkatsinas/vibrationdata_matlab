%
%  Corcos_FAIP.m  ver 1.0  by Tom Irvine
%
%  Totaro, Robert, Guyader, Frequency Averaged Injected Power under
%  Boundary Layer Excitation: An Experimental Validation, 2008
%
%
%  Uc=convection velocity
%  ax=Corcos coefficient longitudinal
%  az=Corcos coefficent transverse
%  M =mass per area
%  D =bending stiffness
%  A =surface area
%  a =length
%  b =width

function[power_psd_scale]=Corcos_FAIP(freq,Uc,ax,az,M,D,A,a,b)

TPI=2*pi;

omega=TPI*freq;
omegac=Uc^2*sqrt(M/D);

[PSIC]=PSIC_function(Uc,omega,omegac,ax,az,a,b);


num=Uc^2*(A/2);
den=(ax*az*pi*sqrt(M*D)*omega^2);

power_psd_scale=(num/den)*PSIC;


%% [PSICD]=PSICD_function(Uc,omega,omegac,ax,az,a,b);
%% power_psd_scale_alt=(num/den)*PSICD


%%%%%

function[PSIC]=PSIC_function(Uc,omega,omegac,ax,az,a,b)

N=1002;

omr=omegac/omega;

q1=Uc*pi/(omega*b);
q2=sqrt(omr-(Uc*pi/(omega*a))^2);

dx=(q2-q1)/(N-1);

y=zeros(N,1);

for i=1:N
    
    x=(i-1)*dx+q1;
    
    sqq=sqrt(omr-x^2);
    
    arg1=(omega*b/Uc)*(-az+1i*x);
    arg2=(omega*a/Uc)*(-ax+1i*(sqq-1));
    arg3=(omega*a/Uc)*(-ax+1i*(sqq+1));
    
    [F1A]=F1_function(arg1,x,Uc,omega,b);
    [F2A]=F2_function(arg2,x,Uc,omega,omr,a);    
    [F2B]=F2_function(arg3,x,Uc,omega,omr,a);      
    
    y(i)=(1/sqrt(omr-x^2))*F1A*(F2A+F2B);
    
end

y(end)=[];

[term]=Simpsons_rule(y,dx);

PSIC=(omega*a/Uc)*(omega*b/Uc)*ax*az*abs(term);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

function[PSICD]=PSICD_function(Uc,omega,omegac,ax,az,a,b) 

N=1002;

omr=omegac/omega;

q1=0;
q2=sqrt(omr);

dx=(q2-q1)/(N-1);

y=zeros(N,1);

for i=1:N
    
    x=(i-1)*dx+q1;
    
    sqq=sqrt(omr-x^2);
    
    A=1/(sqq*(1+(x/az)^2));
    
    B=1/( 1+(1/ax^2)*(1-sqq)^2 );
    
    C=1/( 1+(1/ax^2)*(1+sqq)^2 );    
    
    y(i)=A*(B+C);
    
end

y(end)=[];

[term]=Simpsons_rule(y,dx);

PSICD=term;

%%%



function[F1]=F1_function(arg,x,Uc,omega,b)

z=arg;
[A,B,N]=ABN(z);

D=(omega*b/Uc)*x*abs(z)^2;

F1=-A+B+(N/D);


function[F2]=F2_function(arg,x,Uc,omega,omr,a)    
    
z=arg;
[A,B,N]=ABN(z);

term=sqrt(omr-x^2);

D=(omega*a/Uc)*term*abs(z)^2;

F2=-A+B+(N/D);


function[A,B,N]=ABN(z)
%
A=real(z)/abs(z)^2;
B=real(conj(z)^2*(exp(z)-1))/abs(z)^4;
N=imag(conj(z)*exp(z-1));


