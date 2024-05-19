
%  fds_sdof_response_Dirlik_damage.m   ver 1.1  by Tom Irvine

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
%
%    fix_size
%    ytick_linear_min_max_alt
%    xtick_label_f
%    multiple_fds_plot_1x1_alt
%    multiple_fds_plot_2x2_f
%    multiple_fds_plot_1x2_f
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[fds]=fds_sdof_response_Dirlik_damage(base_psd,Q,b,T,ispace)
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
    
    generate_fds_plot(fds,Q,b);  


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

    fig_num=1;
    
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
