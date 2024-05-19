%
%  inverse_fourier_transform.m
%
%  ver 1.2   June 16, 2015
%
function[t_real,t_imag]=inverse_fourier_transform(frf,k)
%
tpi=2*pi;
%

disp(' ');
progressbar % Create figure and set starting time
%
t_real=zeros(k,1);
t_imag=zeros(k,1);
%
N=k;

Nm1=N-1;
Nm2=N-2;

for  i=0:Nm1
    progressbar(i/N) % Update figure    
%
    clear sum_c;
    clear sum_s;
    clear ccc;
    clear sss;
%
    t_real(i+1)=0.;
    t_imag(i+1)=0.;  
%  
%%%    arg = linspace(0,tpi*n*(k-1)/k,k); 

   
    sum_r=0;
    sum_i=0;
     
    
    arg=zeros(Nm1,1);
    
    for k=0:Nm1
       arg(k+1)=k; 
    end
    
    
    xx=frf.*exp(tpi*i*arg*1i/N);
    
%
    t_real(i+1)=t_real(i+1)+sum(real(xx));
    t_imag(i+1)=t_imag(i+1)+sum(imag(xx));
% 
end
progressbar(1);

