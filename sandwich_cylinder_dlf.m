
%
%  sandwich_cylinder_dlf.m  ver 1.0  by Tom Irvine
%

function[lf,stitle]=sandwich_cylinder_dlf(fc,imax,n)

k=1;

lf=zeros(imax,1);

if(n==1)  % Sandwich Cylinder, Bare
    
    stitle='Sandwich Cylinder, Bare, Dissipation Loss Factor';    
    
    for i=1:imax
           
        lf(k)=0.3/(fc(k)^0.63);
 
        k=k+1;
 
    end    
    
end
if(n==2)  % Sandwich Cylinder, Built-up  
    
    stitle='Sandwich Cylinder with Equipment Dissipation Loss Factor';
    
    k=1;
    
    fp=500;
    
    for i=1:imax
        if(fc(i)>=10)
            
            f(k)=fc(i);
            
            if(f(k)<=fp)
                lf(k)=0.05;
            else
                lf(k)=0.050*sqrt(fp/f(k));
            end
            
            k=k+1;
        end
    end        
end
