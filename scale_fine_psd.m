
%
%   scale_fine_psd.m  ver 1.0  by Tom Irvine
%
%   ---------  Input  ---------     
%
%   The input_psd array must have two columns:  
%      freq(Hz) accel(G^2/Hz)
%
%   The input_fds array must have five columns:  
%      natural freq(Hz) fds_Q10_b4 fds_Q10_b8 fds_Q30_b4 fds_Q30_b8
%
%   
%   Each frequency column must be in some fractional octave format such as:
%    1/3, 1/6, 1/12, 1/24, 1/48
%    
%
%   T is the psd duration (sec)
%   ntrials is the number of iterations, such as 500
%
%   nplot =1  yes plots
%         =2  no plots
%
%
%   ---------  Output  ---------   
%
%   The best_psd array has two columns:  
%      freq(Hz) accel(G^2/Hz)
%
%   The best_fds array has five columns:  
%      natural freq(Hz) fds_Q10_b4 fds_Q10_b8 fds_Q30_b4 fds_Q30_b8
%
function[best_psd,best_fds]=scale_fine_psd(input_psd,input_fds,T,ntrials,nplot)
%

tic

disp(' ');
disp(' * * * * * * * * * * * *');
disp(' ');
disp(' Trial   Error');
disp(' ');

f=input_psd(:,1);
fn=input_fds(:,1);

Lf=length(f);

Q = [10 30];
b = [4 8];

error_max=1.0e+50;

test_psd=zeros(Lf,2);
test_psd(:,1)=f;

for i=1:ntrials
    
    if(i==1)
        test_psd=input_psd;
        
        iflag=0;
    
    else
         
        if( i<=10 || rand()<0.1)
            for j=1:Lf
                test_psd(j,2)=input_psd(j,2)*(0.9+0.2*rand());
            end
        else
            for j=1:Lf
                B=0.1*rand();
                N=1-B;
                C=2*B;
                test_psd(j,2)=best_psd(j,2)*(N+C*rand());
            end            
        end
    
    end
    
    % fds comparison
     
    [test_fds]=fds_sdof_response_Dirlik_damage_fine(test_psd,Q,b,T,fn);

    
    % compare

        [scale]=scale_fine(input_fds,test_fds,b);
    
    % apply scale
    
        test_psd(:,2)=test_psd(:,2)*scale^2;
    
        [test_fds]=fds_sdof_response_Dirlik_damage_fine(test_psd,Q,b,T,fn);   
        
    % error
    
    [error]=error_fine(input_fds,test_fds);
    
   
    
    if(error<error_max)
        error_max=error;
        best_psd=test_psd;
        best_fds=test_fds;

        out1=sprintf(' %d  %8.4g ',i,error_max);
        disp(out1);    
                 
    end
     
end  


if(nplot==1)
    fig_num=1;
    
    md=6;
    
    [~,grms1] = calculate_PSD_slopes(best_psd(:,1),best_psd(:,2));
    leg1=sprintf('Adjusted PSD  %6.3g GRMS ',grms1);
    
    [~,grms2] = calculate_PSD_slopes(input_psd(:,1),input_psd(:,2));
    leg2=sprintf('Input PSD  %6.3g GRMS ',grms2);
    
    x_label='Frequency (Hz)';
    y_label='Accel (G^2/Hz)';    
    t_string='Power Spectral Density';
    
    fmin=test_psd(1,1);
    fmax=test_psd(end,1);
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,best_psd,input_psd,leg1,leg2,fmin,fmax,md);
%
     QQ=[Q(1) Q(1) Q(2) Q(2) ];
    bex=[b(1) b(2) b(1) b(2) ];
    iu=1;
    nmetric=1;
    ff=1;
    xx=1;
    xfds=best_fds;
    fds_ref=input_fds;

    [fig_num,h3]=fds_plot_2x2_alt_leg_h2(fig_num,QQ,bex,fn,ff,xx,xfds(:,2:5),fds_ref(:,2:5),nmetric,iu);
    
 %       
    t_string=sprintf(' %s overall',leg1);
    power_spectral_density=best_psd;
    [fig_num,h4]=psd_fds_plot_2x2_alt_leg_h2(fig_num,QQ,bex,fn,xfds(:,2:5),...
                                         fds_ref(:,2:5),nmetric,iu,t_string,...
                                         power_spectral_density,fmin,fmax);    
 
                      
    
end

toc  

disp(' ');
disp('calculation complete');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  fds_sdof_response_Dirlik_damage_fine.m   ver 1.0  by Tom Irvine

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
%   fds has multiple columns:
%       natural frequency (Hz)
%       and relative damage (accel unit)^b for each Q and b combination 
%                

function[fds]=fds_sdof_response_Dirlik_damage_fine(base_psd,Q,b,T,fn)
%


  tpi=2*pi;

  fstart=base_psd(1,1);
    fend=base_psd(end,1);

num=4000;

df=(fend-fstart)/(num-1);

new_freq=linspace(fstart,fend,num);

    
[fi,base_psd_int] = interpolate_PSD_arbitrary_frequency_f(base_psd(:,1),base_psd(:,2),new_freq);


    
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




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[scale]=scale_fine(input_fds,test_fds,b)

fn=test_fds(:,1);

Lfn=length(fn);

error=zeros(Lfn,4);

assignin('base','xxt',test_fds);
assignin('base','xxf',input_fds);

for i=1:Lfn
    for j=1:4
        error(i,j)=test_fds(i,j+1)/input_fds(i,j+1); 
    end    
end

emin=zeros(4,1);

for i=1:4
    emin(i)=min(error(:,i));
end


emin(1)=emin(1)^(1/b(1));
emin(2)=emin(2)^(1/b(2));
emin(3)=emin(3)^(1/b(1));
emin(4)=emin(4)^(1/b(2));


scale=1/min(emin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[error]=error_fine(input_fds,test_fds)

fn=test_fds(:,1);

Lfn=length(fn);

error=0;

for i=1:Lfn
    for j=2:5
        error=error+abs(log10(input_fds(i,j)/test_fds(i,j))); 
    end    
end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    