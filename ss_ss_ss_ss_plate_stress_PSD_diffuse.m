
%   ss_ss_ss_ss_plate_stress_PSD_diffuse.m  ver 1.0  by Tom Irvine


function[SXX,SYY,SXY]=ss_ss_ss_ss_plate_stress_PSD_diffuse(E,h,mu,nf,nm,phi_xx,phi_yy,phi_xy,a,b,Amn,H,field,fpsd,x,y,jrs2)
    
        EZ1=-E*(h/2)/(1-mu^2);
        EZ2=-E*(h/2)/(1+mu); 
    

    SXX=zeros(nf,1);
    SYY=zeros(nf,1);
    SXY=zeros(nf,1);


    for k=1:nf
        for i=1:nm
            for j=1:nm   
                
                [p1,p2,q1,q2]=index(field,i,j,nm);
                    
                for p=p1:p2
                    for q=q1:q2
%                 
                        term2=H(k,i,j)*conj(H(k,p,q));
                    
                        dx1=phi_xx(Amn,x,y,i,j,a,b);
                        dx2=phi_xx(Amn,x,y,p,q,a,b);
                        dy1=phi_yy(Amn,x,y,i,j,a,b);
                        dy2=phi_yy(Amn,x,y,p,q,a,b);
                        dxy1=phi_xy(Amn,x,y,i,j,a,b);
                        dxy2=phi_xy(Amn,x,y,p,q,a,b);
                                                
                        SXX(k)=SXX(k)+(dx1 + mu*dy1)*(dx2 + mu*dy2)*jrs2(k,i,j,p,q)*term2;
                        SYY(k)=SYY(k)+(dy1 + mu*dx1)*(dy2 + mu*dx2)*jrs2(k,i,j,p,q)*term2;
                        SXY(k)=SXY(k)+dxy1*dxy2*jrs2(i,j,p,q)*term2;  
                                         
%                       
                    end
                end
            end
        end      
        
        SXX(k)=SXX(k)*fpsd(k)*EZ1^2;  
        SYY(k)=SYY(k)*fpsd(k)*EZ1^2;  
        SXY(k)=SXY(k)*fpsd(k)*EZ2^2;          
    end
    
    function[p1,p2,q1,q2]=index(field,i,j,nm)

    if(field==1)
        p1=1;
        p2=nm;
        q1=1;
        q2=nm;
    else
        p1=i;
        p2=i;
        q1=j;
        q2=j;
    end