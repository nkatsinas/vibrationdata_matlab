
%  sdof_psd_response_base_alt.m  ver 1.0  by Tom Irvine

%    SDOF system psd response for base excitation
%
%    base_psd = base input psd with two columns:
%       frequency (Hz) & acceleration input (G^2/Hz)
%
%    base_psd is interpolated inside the function to 1/96th octave
%
%       fn = natural frequency (Hz)
%        Q = amplification factor (typically Q=10)
%
%   response_psd has two columns:  
%       frequency (Hz) & acceleration response (G^2/Hz)
%
%   supporting & plotting functions are included
%

function[accel_psd,pv_psd,rd_psd]=sdof_psd_response_base_alt(fn,Q,base_psd)
%
    tpi=2*pi;
    
    damp=1/(2*Q);
    
    fstart=base_psd(1,1);
      fend=base_psd(end,1);
 
    num=96*log(fend/fstart)/log(2);
    new_freq=logspace(log10(fstart),log10(fend),num);
  
    [freq,base_psd_int] = interpolate_PSD_arbitrary_frequency_f(base_psd(:,1),base_psd(:,2),new_freq);
    
            
    omega=tpi*freq;
    omegan=tpi*fn;
    
    om2=omega.^2;   
    omn2=omegan.^2;
    
    den= (omn2-om2) + (1i)*(2*damp*omegan*omega);    
    num=omn2+(1i)*2*damp*omega*omegan;
%
    accel_complex=num./den;

    num=1;
    rd_complex=386*num./den;
    
    pv_complex=rd_complex.*omega;
    
    
    freq=fix_size(freq);
    
    accel_complex=fix_size(accel_complex);
      pv_complex=fix_size(pv_complex);
      rd_complex=fix_size(rd_complex);    
    
    accel_power_trans=(abs(accel_complex)).^2;
       pv_power_trans=(abs(pv_complex)).^2;
       rd_power_trans=(abs(rd_complex)).^2;
       
    accel_psd=accel_power_trans.*base_psd_int;
    accel_psd=[freq accel_psd];
    
    pv_psd=pv_power_trans.*base_psd_int;
    pv_psd=[freq pv_psd];     
    
    rd_psd=rd_power_trans.*base_psd_int;
    rd_psd=[freq rd_psd]; 
    
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

%   
%    calculate_PSD_slopes_f.m  ver 1.7  by Tom Irvine
%
function [s,grms] = calculate_PSD_slopes_f(f,a)
%
%
MAX = 12000;
%
ra=0.;
grms=0.;
iflag=0;
%
s=zeros(1,MAX);
%
if(f(1) < .0001)
    f(1)=[];
    a(1)=[];
end

np=length(f);

for i=np:-1:1
    if(a(i)==0)
        a(i)=[];
        f(i)=[];
    end
end
   

%
nn=length(f)-1;
%
for  i=1:nn
%
    if(  f(i) <=0 )
        disp(' frequency error ')
        out=sprintf(' f(%d) = %6.2f ',i,f(i));
        disp(out)
        iflag=1;
    end
    if(  a(i) <=0 )
        disp(' amplitude error ')
        out=sprintf(' a(%d) = %6.2f ',i,a(i));
        disp(out)
        iflag=1;
    end  
    if(  f(i+1) < f(i) )
        disp(' frequency error ')
        iflag=1;
    end  
    if(  iflag==1)
        break;
    end
%    
    if(f(i+1)~=f(i))
        s(i)=log10( a(i+1)/ a(i) )/log10( f(i+1)/f(i) );
    else
        s(i)=NaN;
    end
%   
 end
 %
 % disp(' RMS calculation ');
 %
 if( iflag==0)
    for i=1:nn
        if(abs(s(i))<1000)
            if(s(i) < -1.0001 ||  s(i) > -0.9999 )
                ra = ra + ( a(i+1) * f(i+1)- a(i)*f(i))/( s(i)+1.);
            else
                ra = ra + a(i)*f(i)*log( f(i+1)/f(i));
            end
        end
    end
    grms=sqrt(ra);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

