%
%   vb_trapezoid_time_calc.m  ver 1.1  by Tom Irvine
%
%
function [acc,rd,TT,yb]=...
            vb_trapezoid_time_calc(rd_initial,rv_initial,domegan,...
            omegad,damp,omega,omegan,omegan2,nt,dt,dur,d1,d2,amp)
        
dur_orig=dur;        

te=dur-d2;        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



TT=zeros(nt+1,1);
ain=zeros(nt+1,1);


for i=0:nt
%		
	t=dt*i;
    TT(i+1)=t;
    
    if(  t< d1 )  % initial ramp
        ain(i+1)=amp*(t/d1);
    end    
    if(  t>= d1 && t<te )  % plateau
        ain(i+1)=amp;
    end    
    if(  t>=te && t<dur )   % end ramp
        
        d3=d2;
        
        t3=t-te;
    
        ain(i+1)=amp*(1-(t3/d3));
    end    
end

yb=ain;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%  end of initial ramp

t=d1;
dur=d1;

[rdd,rvv]=initial_ramp(t,damp,domegan,omegan,omegan2,omegad,dur,amp);
%
rd_initial1=rdd;
rv_initial1=rvv;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% end of plateau
       
zT=rd_initial1;
vT=rv_initial1; 

t2=te-d1;

        
[rda,rva]=plateau(t2,omegad,domegan,omegan,amp);
[rdb,rvb]=free(t2,omegad,domegan,zT,vT);

                
rd_initial2=rda+rdb;
rv_initial2=rva+rvb;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% end of final ramp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
dur=d2;
t3=d2;
    
zT=rd_initial2;
vT=rv_initial2;
        
%%%

[rda,rva]=plateau(t3,omegad,domegan,omegan,amp);
[rdb,rvb]=initial_ramp(t3,damp,domegan,omegan,omegan2,omegad,dur,amp);        
[rdc,rvc]=free(t3,omegad,domegan,zT,vT);
 
rd_initial3=rda-rdb+rdc;
rv_initial3=rva-rvb+rvc;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

TT=zeros(nt+1,1);
rd=zeros(nt+1,1);
rv=zeros(nt+1,1);
acc=zeros(nt+1,1);
%

%%%%%%%%%%%%%%%%%%%%%%%%%

    for i=0:nt
%		
        t=dt*i;
        
        TT(i+1)=t;
    
        iflag=0;
    
        if(  t< d1 )  % initial ramp
            
            dur=d1;
        
            [rdd,rvv]=initial_ramp(t,damp,domegan,omegan,omegan2,omegad,dur,amp);
              
            rd(i+1)=rdd;
            rv(i+1)=rvv;
        
            iflag=1;
        
            jk=1;
        
        end
        if(  t>= d1 && t<te && iflag==0)  % plateau
        
            t2=t-d1;
        
            zT=rd_initial1;
            vT=rv_initial1;
        
            [rda,rva]=plateau(t2,omegad,domegan,omegan,amp);
            [rdb,rvb]=free(t2,omegad,domegan,zT,vT);
        
            rd(i+1)=rda+rdb;
            rv(i+1)=rva+rvb;
                
            iflag=1;
        
            jk=2;
               
        end   
    
    
        if(  t>=te && t<dur_orig && iflag==0)   % end ramp
        
            dur=d2;
        
            t3=t-te;
    
            zT=rd_initial2;
            vT=rv_initial2;
        
%%%
            [rda,rva]=plateau(t3,omegad,domegan,omegan,amp);
            [rdb,rvb]=initial_ramp(t3,damp,domegan,omegan,omegan2,omegad,dur,amp);        
            [rdc,rvc]=free(t3,omegad,domegan,zT,vT);

            rd(i+1)=rda-rdb+rdc;
            rv(i+1)=rva-rvb+rvc;
             
            iflag=1;
        
            jk=3;
%%%%
            
        end     
        if(  t>=dur_orig && iflag==0)   % free
        
            t4=t-dur_orig;
    
            zT=rd_initial3;
            vT=rv_initial3;
   
            [rdd,rvv]=free(t4,omegad,domegan,zT,vT);
        
            rd(i+1)=rdd;
            rv(i+1)=rvv;
        
            jk=4;
        
        end     
    
%
        acc(i+1)= -omegan2*rd(i+1)  - 2.*domegan*rv(i+1);    
    
%%    out1=sprintf(' t=%8.4g rd=%8.4g %d',TT(i+1),rd(i+1),jk);
%%    disp(out1);
    
    
    end
    
%

    [acc_i,rd_i]=free_vibration_function(rd_initial,rv_initial,domegan,omegad,omegan2,TT);
    
    acc=fix_size(acc);
    acc_i=fix_size(acc_i);    
    
    rd=fix_size(rd);
    rd_i=fix_size(rd_i);       
    
    acc=acc+acc_i;
    rd=rd+rd_i;
%


end

function [rdd,rvv]=plateau(t,omegad,domegan,omegan,amp)
%
        omegadt=omegad*t;
        domegant=domegan*t;
%
        ee=exp(-domegant);
        cwdt=cos(omegadt);
        swdt=sin(omegadt);
        
        K1=omegan^2;
        K2=domegan/omegad;        
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               
        rdd=amp*(-1+ee*(cwdt+K2*swdt))/K1;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        rv1= -domegan*ee*(cwdt+K2*swdt)/K1;
        rv2=   omegad*ee*(-swdt+K2*cwdt)/K1;
%               
        rvv=(rv1+rv2)*amp;
%
end

function [rdd,rvv]=free(t,omegad,domegan,zT,vT)

		omegadt=omegad*t;
		domegant=domegan*t;
%
		ee=exp(-domegant);
		cwdt=cos(omegadt);
		swdt=sin(omegadt);
%
		a1=zT;
		a2=(vT+domegan*zT)/omegad;
%
        rdd = ee *(a1*cwdt + a2*swdt);
%
		rvv= -domegan*rdd;
		rvv= rvv + omegad*ee *(-a1*swdt + a2*cwdt); 

end

function [rdd,rvv]=initial_ramp(t,damp,domegan,omegan,omegan2,omegad,dur,amp)

        b1=2*damp/omegan;
        b2=(2*(damp^2)-1)/omegad;        
        
        omegadt=omegad*t;
        ee=exp(-domegan*t);
        cwdt=cos(omegadt);
        swdt=sin(omegadt);
%
        rdd=b1-t-ee*(b1*cwdt + b2*swdt);
        rdd=rdd*amp/(omegan2*dur);
%
        rvv=-1+domegan*ee*(b1*cwdt + b2*swdt);
        rvv=rvv-omegad*ee*(-b1*swdt + b2*cwdt);
        rvv=rvv*amp/(omegan2*dur);
        
end
