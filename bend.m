
%  bend.m  ver 1.0  by Tom Irvine

function[k,L,xx,kflag]=bend(k,L,xx,x1,x2,y1,y2,nb_elem,j)

%    fprintf(' k=%d j=%d  nb_elem=%d  L=%8.4g \n',k,j,nb_elem,L);
    
    kflag=0;
    
    x1o=x1;
    x2o=x2;
    y1o=y1;
    y2o=y2;

    [s1,s2,xa,xb,ya,yb,deltax1,deltax2]=slope_check(x1,x2,y1,y2,j);
    
%    fprintf('s1=%8.4g s2=%8.4g  deltax1=%8.4g  deltax2=%8.4g\n',s1,s2,deltax1,deltax2);
    
    if(abs(deltax1)>0 && abs(deltax2)>0)
        [k,L,xx,kflag]=bend_spline(k,L,xx,nb_elem,j,s1,s2,ya,yb,xa,xb);
    else
   
        alpha=-45;        
        
        Q1=rotz(alpha)*[x1o y1o x1o*0]';
        x1=Q1(1,:);
        y1=Q1(2,:)';
        
        Q2=rotz(alpha)*[x2o y2o x2o*0]';
        x2=Q2(1,:);
        y2=Q2(2,:); 
        
        [s1,s2,xa,xb,ya,yb,deltax1,deltax2]=slope_check(x1,x2,y1,y2,j);
        
        if(abs(deltax1)<1.0e-04 || abs(deltax2)<1.0e-04)
            
            alpha=-30;        
        
            Q1=rotz(alpha)*[x1o y1o x1*0]';
            x1=Q1(1,:);
            y1=Q1(2,:)';
        
            Q2=rotz(alpha)*[x2o y2o x2*0]';
            x2=Q2(1,:);
            y2=Q2(2,:); 
            
            [s1,s2,xa,xb,ya,yb,deltax1,deltax2]=slope_check(x1,x2,y1,y2,j);
        end
       
        Qx=rotz(alpha)*[xx(:,1) xx(:,2) xx(:,1)*0]';
        xx(:,1)=Qx(1,:)';
        xx(:,2)=Qx(2,:)';         
                            
        [k,L,xx,kflag]=bend_spline(k,L,xx,nb_elem,j,s1,s2,ya,yb,xa,xb);

        Qx=rotz(-alpha)*[xx(:,1) xx(:,2) xx(:,1)*0]';
        xx(:,1)=Qx(1,:)';
        xx(:,2)=Qx(2,:)';           
        
    end    

    
function[k,L,xx,kflag]=bend_spline(k,L,xx,nb_elem,j,s1,s2,ya,yb,xa,xb)

    disp('bend_spline');

    kflag=0;

    x=[xa xb];
    y=[ya yb];
    PP=[s1 y s2];
    
    try
        cs = spline(x,PP);
    catch
        disp(' cs fail');
        kflag=1;
    end

    ne=nb_elem;
    
    dL=(xb-xa)/ne;  
    
    try
        k1=k;
        for i=1:(ne-1)
            xx(k,1)=xa+dL*i;
            xx(k,2)=ppval(cs,xx(k,1));
            k=k+1;
        end
        k2=k-1;
%        disp('ppval passed'); 
    catch
        disp('ppval failed');
        kflag=1;
        return;
    end
    
% even arc length correction

    try

        p = polyfit(xx(k1:k2,1),xx(k1:k2,2),3);

        cube=@(x) p(1)*x.^3+p(2)*x.^2+p(3)*x+p(4);
        core=@(x) sqrt( 1+ (3*p(1)*x.^2+2*p(2)*x+p(3)).^2);

        alen=integral(core,xa,xb); 
   
        dL=alen/ne;
%        disp('polyfit passed');           
    catch
        disp('polyfit failed');
        kflag=1;
        return;
    end
 
    try
        nnn=1000;
        dxx=(xb-xa)/nnn;
        aa=zeros(nnn,1);
        xbb=zeros(nnn,1);

        for i=1:nnn
            xbb(i)=xa+i*dxx;
            aa(i)=integral(core,xa,xbb(i));
        end
%        disp('integral pass');       
    catch
        disp('integral fail');
        k=1;
        return;
    end
    
    try
    
        k=k1;
        for i=1:(ne-1)
            dLi=i*dL;
            [~,ijk]=min(abs(aa-dLi));
            xx(k,1)=xbb(ijk);
            xx(k,2)=cube(xx(k,1));
            
            k=k+1;
        end    
        
    catch
        disp(' xx fail');
        kflag=1;
    end
    

function[s1,s2,xa,xb,ya,yb,deltax1,deltax2]=slope_check(x1,x2,y1,y2,j)

    xa=x2(j);
    xb=x1(j+1);
    ya=y2(j);
    yb=y1(j+1);    

    deltax1=x2(j)-x1(j);
    deltay1=y2(j)-y1(j);
    
    s1=deltay1/deltax1;
 
    deltax2=x2(j+1)-x1(j+1);
    deltay2=y2(j+1)-y1(j+1);
   
    s2=deltay2/deltax2;

