%
%   quake_srs_synth_phase_1.m  ver 1.8  by Tom Irvine
%
function[ramp,error_i,wavelet_low,wavelet_up,alpha,beta,t]=...
    quake_srs_synth_phase_1(f,dt,damp,amp,NHS,td,last_wavelet,iter,...
                            fn,srs_spec,dlimit,error_limit,iu,uewf,dur)
                                         
    
tpi=2*pi;                        
                        
%%

% Need to do this here.  Input data may have different dt than output

nt=round(dur/dt);

t=linspace(0,nt*dt,nt+1); 


% alpha=zeros(last_wavelet,1);
% wavelet_low=zeros(last_wavelet,1);
% wavelet_up =zeros(last_wavelet,1);

 
beta=tpi*f;
 
alpha = beta ./ double(NHS);
ud = NHS ./ (2*f);

wavelet_low = max(1, floor(td/dt));
wavelet_up = min(nt, wavelet_low + floor(ud/dt));

%%
                                         
                                         
ic=0;
                                     
ramp=amp;

nfn=length(fn);

ih=round(iter/3);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Initialize coefficients
%
[a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(fn,damp,dt);    

drec=1.0e+90;    

error_max=1.0e+90;                               
         

for i=1:length(f)
    if(f(i)>max(fn))
        amp(i)=0;
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

progressbar;
%
for i=1:iter
    progressbar(i/iter);
%
    [accel]=generate_time_history_wavelet_table_q(f,amp,NHS,td,t,...
                                         wavelet_low,wavelet_up,alpha,beta);
    
  
    xmax = zeros(nfn, 1);
    xmin = zeros(nfn, 1);
    xave = zeros(nfn, 1);
    
    for j = 1:nfn
        resp = filter([b1(j), b2(j), b3(j)], [1, -a1(j), -a2(j)], accel);
        xmax(j) = max(resp);
        xmin(j) = abs(min(resp));
        xave(j) = mean( [xmax(j) xmin(j)]);
    end

    error=0;
    error_i=0;
    
    e2=0;
    
    fmin=0.;
    
    for j=1:length(srs_spec)
        if(srs_spec(j)>0)
            errora=abs(20*log10(srs_spec(j)/xmin(j)));
            errorb=abs(20*log10(srs_spec(j)/xmax(j)));
            
            if(xmin(j)>srs_spec(j))
                errora=uewf*errora;
            end
            if(xmax(j)>srs_spec(j))
                errorb=uewf*errorb;
            end           
            
            
            if(errora>error)
                error=errora;
                fmax=fn(j);
            end
            if(errorb>error)
                error=errorb;
                fmin=fn(j);
            end
            
            error_i=error;
            
            e2=e2+errora+errorb;
        end    
    end 
    
    error=error*e2;


    [v]=integrate_function(accel,dt);
    [d]=integrate_function(v,dt);

    
    dmin=abs(min(d));
    dmax=abs(max(d));
    
      
    dratio=max([dmax dmin]);
    
    if(iu==1)
        dratio=dratio*386;
    else
        dratio=dratio*9.81*1000;
    end   
    
    if(i>100)
        % fprintf('%d  %8.4g   \n',i,error);
        % uuu=input(' ')
    end

    if(error<error_max && (dratio<dlimit || dratio <drec))
        
        if(dratio<drec)
            drec=dratio;
        end
        
        error_max=error;
        ramp=amp;
        ramp_srs=xave;
        % raccel=accel;
        % rxmax=xmax;
        % rxmin=xmin;
        
        fprintf('%d  %8.4g  %8.4g  %8.4g %d \n',i,error,error_i,dratio,ic);

        if(error_i<(error_limit+1))
            progressbar(1);
            break;
        end
    end
    
%
    
    if(i<iter)
        if(i> round(iter*0.03) || i>50)

            jk=1+floor(last_wavelet*rand());

                        
    
                            [~,ii]=min(abs(fn-f(jk)));
                            sc=srs_spec(ii)/ramp_srs(ii);
                            sc=sc^(1/24);
                            % sc=0.99+0.02*rand();
                            amp(jk)=ramp(jk)*sc;


        else
            scale=0.5+1.0*rand();
            amp=ramp*scale;
        end    
    end
%
end

pause(0.1);