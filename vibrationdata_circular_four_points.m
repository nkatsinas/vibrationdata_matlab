%
%   vibrationdata_circular_four_points.m  ver 1.0  by Tom Irvine
%
function[fn,part,Z_mode,Z_r,Z_theta]=...
        vibrationdata_circular_four_points(De,diameter,total_mass,mu,rho,h)
 
    tpi=2*pi;
    radius=diameter/2;


    n=4;
    n2=n^2;
    pi2=pi^2;
%
    lower=n-1;
    upper=n; 
    
%
    omegan_min=1.0e+20;
    ratio_error=1.0e+20;
    dZdthrec=1.0e+20;
    nde_min=1.0e+20;
%
    nr=50;
    nd=360;
%
    dr=(radius/nr);
    dtheta=(360/nd)*(nd+1);
%
    r=linspace(0,nr*dr,nr);
    
    Z_r=r;
    
    r(1)=r(2)/100000;
    rrn=r/radius;
%
     theta=linspace(0,nd,dtheta);    
     theta=theta*pi/180;
     
     Z_theta=theta;
%   
    dZdth=1.0e+20;
    d2rec=1.0e+20;
    d3rec=1.0e+20;
%
%%% disp(' Enter number of trials ');
%%% nnn=input(' ');
%%% disp(' Enter number of cosines ');
%%% nc=input(' ');
%
    nnn=1;
    nc=4;
%
    argr=zeros(nc,1);
    AAr=zeros(nc,1);
%
    for k=1:nnn
        slopemax=-1.0e+20;
%   
%%    R=radius;
        R=1;
    
        clear AA;
        clear arg;
        clear    cos_sum;
        clear   dcos_sum;    
        clear  ddcos_sum;
        clear dddcos_sum;  
    
           cos_sum=zeros(length(r),1);    
          dcos_sum=zeros(length(r),1);        
         ddcos_sum=zeros(length(r),1);    
        dddcos_sum=zeros(length(r),1);    

        arg=[ 0.8709    0.0846    0.6709    0.6157 ]*pi;

        AA= [1.9619   -1.3048   -3.4583    3.0771];
    
        for ijk=1:nc
            Q=AA(ijk);
            eta=arg(ijk);

            for j=1:length(r)
                   alpha=arg(ijk)*rrn(j);
                   cos_sum(j)=   cos_sum(j)+Q*cos(alpha);
                  dcos_sum(j)=  dcos_sum(j)-Q*sin(alpha)*(eta/radius);
                 ddcos_sum(j)= ddcos_sum(j)-Q*cos(alpha)*(eta/radius)^2;   
                dddcos_sum(j)=dddcos_sum(j)+Q*sin(alpha)*(eta/radius)^3;         
            end
        end
        shift=min(cos_sum);
        cos_sum=cos_sum-min(cos_sum);

    shift=min(cos_sum);
    cos_sum=cos_sum-min(cos_sum);
%
     clear A;
     clear B;
     clear x;
%      
      der=-0.0065;
      mec=3.6059;
      med=3.9948;
 
     A=[ R^(mec-1) R^med; (mec-1)*R^(mec-2) med*R^(med-1) ];
     B=[ 1; der ];
     x=A\B;
     bb=0;
     cc=x(1);
     dd=x(2);
%
     cc=2.8808;
     dd=-1.8808;
%%
     clear A; 
     A=0.8744;

%%
    Z_mode=zeros(length(r),length(theta));
    T=0;
    V=0;
%
    Mr_max=0;
    Vr_max=0;
    dZdth_max=0;
    radius2=radius^2;
    radius3=radius^3;
%
    Z1A=0;
    Z2A=0;
%
    for i=1:length(theta)  % theta
%       
        cos_nth=cos(n*theta(i));
        dcos_nth=-n*sin(n*theta(i));
        ddcos_nth=-n^2*cos(n*theta(i));
%
        for j=1:length(r)  % radius
%
             rr=r(j);
            rrp2=rr^2;
                 
%
              modu=(                         cc*rrn(j)^(mec-1) +                     dd*rrn(j)^med);
             dmodu=(                 (mec-1)*cc*rrn(j)^(mec-2) +                 med*dd*rrn(j)^(med-1))/radius;
            ddmodu=(         (mec-1)*(mec-2)*cc*rrn(j)^(mec-3) +         med*(med-1)*dd*rrn(j)^(med-2))/radius2;  
           dddmodu=( (mec-1)*(mec-2)*(mec-3)*cc*rrn(j)^(mec-4) + med*(med-1)*(med-2)*dd*rrn(j)^(med-3))/radius3;  
%        
              wave=0.5+0.5*cos_nth;
              term=   modu*wave;
             dterm=   dmodu*wave;
            ddterm=  ddmodu*wave;      
             dddterm=  dddmodu*wave;  
%
            Z=A*term + cos_sum(j);
            Z_mode(j,i)=Z;
            
            if(i==1 && j==1)
                Zc=Z;
%                out1=sprintf('** Zc=%8.4g',Zc);
%                disp(out1);
            end
%           
            if(i==1)
                ZA(j)=A*term + cos_sum(j);
                ZL(j)=Z;
            end
            if(j==length(r))
                ZR(i)=term;
            end  
 %       
                    ZZ1(j,i)=Z;
                    
                    Z1A=Z1A+Z*rr;            
                    Z2A=Z2A+(Z^2)*rr;                    
                    
                 dZdr=  A*dterm  +   dcos_sum(j);
                dZ2dr2=A*ddterm  +  ddcos_sum(j);    
                dZ3dr3=A*dddterm + dddcos_sum(j);
                
                dZdth=A*modu*(0.5*dcos_nth);
               dZ2dth2=A*modu*(0.5*ddcos_nth);
               
               dZ3drth2=A*dmodu*(0.5*ddcos_nth);
               
               dZ2drdth=A*dmodu*(0.5*dcos_nth);
                
% 
               if( j==(length(r)) )
                   
                   if(i==1)
                       keys=dZ2dr2;
                   end

                    Mr=dZ2dr2 +mu*( (1/r(j))*dZdr   +(1/r(j)^2)*dZ2dth2    );

                    R=r(j);
                    
                    Vr1=dZ3dr3 -(1/R^2)*dZdr +(1/R)*dZ2dr2 -(2/R^3)*dZ2dth2  +(1/R^2)*dZ3drth2;
                    Vr2=(2/R^3)*dZdth -(1/R^2)*dZ2drdth    -(1/R^3)*dZ2dth2  +(1/R^2)*dZ3drth2;
                    
                    Vr=Vr1+(1-mu)*Vr2;
                    
                    if(abs(Mr)>Mr_max && wave >0.2  )
                       Mr_max=abs(Mr);
                    end
                    if(abs(Vr)>Vr_max && wave >0.2  )
                       Vr_max=abs(Vr);
                    end
             
               end
               
               if( dZdr > slopemax)
                   slopemax= dZdr;
               end  
%
      
               if( abs(dZdth) > dZdth_max && rrn(j) < 0.5)
                   dZdth_max= abs(dZdth);
               end  
%
               AA1=dZ2dr2;
               AA2=dZdr/rr;
               AA3=dZ2dth2/rrp2;
               AAS= (AA1+AA2+AA3)^2;
%
               BB1=dZdr/rr;
               BB2=dZ2dth2/rrp2;
               BB=-2*(1-mu)*dZ2dr2*(BB1 + BB2);          
% 
               term=A*(((mec-2)*bb*rrn(j)^(mec-3)   +(med-1)*cc*rrn(j)^(med-2) )/radius2)*(0.5*dcos_nth);
%
               CC=2*(1-mu)*( term^2 );
%
               V=V+(AAS+BB+CC)*rr;
               T=T+(Z^2)*rr;
%
               if(T<1.0e+40)
               else
                   disp(' T error ');
                   gg=input(' ');
               end
               if(V<1.0e+40)
               else
                   disp(' V error ');
                   gg=input(' ');
               end          
%
         end
    end
%
%%    out1=sprintf('\n V=%8.3g  T=%8.3g  V/T=%8.3g  sqrt(V/T)=%8.3g  \n',V,T,V/T,sqrt(V/T));
%%    disp(out1);
%
    V=V*(De/2)*(dr*dtheta);
    T=T*rho*h*(dr*dtheta);
    omegan=sqrt(V/T);
%    
    if(omegan<1.0e+40)
    else
       disp(' omegan error ');
       gg=input(' ');
    end   
%
    fn=omegan/(tpi);
end
%
     dtheta=(theta(2)-theta(1));  % rad
     qq=dtheta*dr*rho*h;
     ZA=Z1A*qq;
    ZAA=Z2A*qq;
%
ZAA=sqrt(ZAA);
part=(ZA/ZAA); 

Z_mode=Z_mode/ZAA;
