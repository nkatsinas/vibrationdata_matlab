%
%  env_ers_th_direct.m  ver 1.0  November 3, 2015
%
function[ers_ref,slabel]=env_ers_th_direct(base,dt,fn,dam,iu,pbar)
%

yy=base;
%
n_dam=length(dam);
n_ref=length(fn);
num=n_ref;
%
ers_ref=zeros(n_dam,n_ref);
%

%
if(iu==1)
    scale=386^2;
    slabel='Energy/Mass (in/sec)^2';
end 
if(iu==2)
    scale=1;  
    slabel='Energy/Mass ((m/sec)^2';        
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Initialize coefficients
%
%

ijk=0;

total=n_dam*num;

if(pbar==1)
    progressbar;
end    
%
for ind=1:n_dam
%
    damp=dam(ind);
    [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
%
%  SRS engine
%

    EK=zeros(num,1);
    ED=zeros(num,1);
    EA=zeros(num,1); 

    a_pos=zeros(num,1);
    a_neg=zeros(num,1); 

    for j=1:num
%
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];
%    
        a_resp=filter(forward,back,yy);
        zdd=a_resp-yy;    
%
        a_pos(j)= max(a_resp);
        a_neg(j)= min(a_resp);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
        rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];      
%    
        rd_resp=filter(rd_forward,rd_back,yy);
        z=rd_resp;    
%
        omegan=2*pi*fn(j);
        tdo=2*damp*omegan; 
%
        om2=omegan^2;
%
        zd=(-yy-zdd-om2*z)/tdo;
%
%
        for i=1:length(z);
            EK(j)=EK(j)+zdd(i)*zd(i);
            ED(j)=ED(j)+tdo*zd(i)^2;
            EA(j)=EA(j)+om2*z(i)*zd(i);
        end
%
        EK(j)=EK(j)*dt;
        ED(j)=ED(j)*dt;
        EA(j)=EA(j)*dt;   
 
        if(pbar==1)        
            progressbar(ijk/total);
            ijk=ijk+1;
        end
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    EK=EK*scale;
    ED=ED*scale;
    EA=EA*scale;
%
    EI=EK+ED+EA; 

    for j=1:num
        ers_ref(ind,j)=EI(j);
    end    
    
%%
%
end
%
if(pbar==1)
    pause(0.3);
    progressbar(1);
end
%