%
function [CB,rr,iflag]=bending_joint_atten(f,B1,B2,mp,e,HL,L,h,CL)
%
    tpi=2*pi;

    iflag=0;

    omega=tpi*f;
     
    CB=( (B1/mp)^(1/4))*sqrt(omega);
    
    kn=omega/CB;
    
    lambda=tpi/kn;
    
    beta=h*f/CL;
    
    if(beta>0.05)
        
        out1=sprintf(' f=%8.4g  lambda=%8.4g  HL=%8.4g  CB=%8.4g',f,lambda,HL,CB);
        disp(out1);        
        
        iflag=1;
    end

    v=abs((tpi/lambda)*L*(B1/B2));

    e2v3=e^2*v^3;
    
    j= 1i;
    
    B=[1; -j; -1; j];
    
    A=[ -1  1  1 -1; -j 1 -j  1;  1   1  -(1+j*e2v3)  -(1-e2v3) ; j 1 (j-v) (1+v)];
    
    x=pinv(A)*B;
    
    rr=sqrt( 1-abs(x(1))^2 );
  
    if(rr>1)
        rr=1;
    end
        
    out1=sprintf(' f=%8.4g  rr=%8.4g  lambda=%8.4g CB=%8.4g v=%8.4g',f,lambda,rr,CB,v);
    disp(out1);     
    

    