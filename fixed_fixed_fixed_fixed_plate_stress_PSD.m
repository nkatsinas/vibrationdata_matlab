
%   fixed_fixed_fixed_fixed_plate_stress_PSD.m  ver 1.0  by Tom Irvine


function[SXX,SYY,SXY]=fixed_fixed_fixed_fixed_plate_stress_PSD(E,h,mu,nf,dxx,dyy,dxy,H,fpsd,x,y,jrs2)
    
        EZ1=-E*(h/2)/(1-mu^2);
        EZ2=-E*(h/2)/(1+mu); 
    

    SXX=zeros(nf,1);
    SYY=zeros(nf,1);
    SXY=zeros(nf,1);


    for k=1:nf
                 
        term2=H(k,1,1)*conj(H(k,1,1));
                  
        dx1=dxx(x,y);
        dx2=dxx(x,y); 
        
        dy1=dyy(x,y);
        dy2=dyy(x,y);
        
        dxy1=dxy(x,y);
        dxy2=dxy(x,y);        
        
        SXX(k)=SXX(k)+(dx1 + mu*dy1)*(dx2 + mu*dy2)*jrs2*term2;
        SYY(k)=SYY(k)+(dy1 + mu*dx1)*(dy2 + mu*dx2)*jrs2*term2;
        SXY(k)=SXY(k)+dxy1*dxy2*jrs2*term2; 
                        
     
        SXX(k)=SXX(k)*fpsd(k)*EZ1^2;  
        SYY(k)=SYY(k)*fpsd(k)*EZ1^2;  
        SXY(k)=SXY(k)*fpsd(k)*EZ2^2;          
    end
    
