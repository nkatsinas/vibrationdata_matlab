
%  hypersphere_SRS_core.m  ver 1.2  by Tom Irvine

%  atype = 1  absolute acceleration
%        = 2  pseudo velocity


function[fn,Drmax,cmax,CCr,iz]=...
               hypersphere_SRS_core(nnn,fn,damp,dt,THM,XX,YY,ZZ,atype,res)

[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
                               
num=length(fn);

omega=2*pi*fn;

nnnp=nnn+1;

CC=zeros(nnnp,nnnp);

nvk=1;

Zmax=0;

cmax=zeros(num,3);
Drmax=zeros(num,1);

progressbar;

NL=length(THM(:,1));

uniaxial=zeros(NL,1);

sz=size(XX);

nnnp=sz(1);

for ijk=1:num
    progressbar(ijk/num);
        
    
    if(atype==1)
        forward=[ b1(ijk),  b2(ijk),  b3(ijk) ];    
        back   =[       1, -a1(ijk), -a2(ijk) ];      
    else
        forward=[ rd_b1(ijk),  rd_b2(ijk),  rd_b3(ijk) ];    
        back   =[          1, -rd_a1(ijk), -rd_a2(ijk) ];         
    end    
        
        
    for i=1:nnnp
        for j=1:nnnp
       
            nvk=nvk+1;
    
            c=[XX(i,j),YY(i,j),ZZ(i,j)];
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

            uniaxial(:)=c(1)*THM(:,2)+c(2)*THM(:,3)+c(3)*THM(:,4);
%   
            if(res==1)
                ML=NL+round((1/fn(j))/dt);
                ys=zeros(ML,1);
                ys(1:NL)=uniaxial;
            else
                ys=uniaxial;
            end


            resp=filter(forward,back,ys);
            
            if(atype==2)
                resp=resp*omega(ijk);
            end
            
            Dr=max(abs(resp));
            
            CC(i,j)=Dr;
        
            if(Dr>Drmax(ijk))
                cmax(ijk,:)=c;
                Drmax(ijk)=Dr;
                
                if(Dr>Zmax)
                   Zmax=Dr;
                   iz=ijk;
                   
                   CCr=CC;
                   
                end
                
            end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
        end
    end
    
    out1=sprintf('%7.3g %7.3g %7.3g %7.3g %7.3g',...
                   fn(ijk),Drmax(ijk),cmax(ijk,1),cmax(ijk,2),cmax(ijk,3));
    disp(out1);
    
end  % end number of fn

% nnnp^2

pause(0.4);
progressbar(1);