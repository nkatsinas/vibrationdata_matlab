%
%  beam_frf.m  ver 1.0
%
function[HM_disp,HM_bending_moment,HM_shear]=...
                         beam_frf(n,nf,f,fn,damp,part,rho,EI,YY,YYdd,YYddd)
%
HM_disp=zeros(nf,1);
HM_bending_moment=zeros(nf,1);
HM_shear=zeros(nf,1);
%    
for k=1:nf
%
    om=2*pi*f(k);
%        
    for i=1:n
%            
        omn=2*pi*fn(i);
        den=(omn^2-om^2)+(1i)*2*damp(i)*om*omn;
%         
        num=part(i)*YY(i);
        
           if(k==1)
               out1=sprintf(' %d  %8.4g  %8.4g',i,part(i),YY(i));
               disp(out1); 
            end
            
        
   
        HM_disp(k)=HM_disp(k)+num/den;
%
        num=part(i)*YYdd(i);
        HM_bending_moment(k)=HM_bending_moment(k)+num/den;
%
        num=part(i)*YYddd(i);
        HM_shear(k)=HM_shear(k)+num/den;
%
    end
end
%
%%
HM_disp=abs(HM_disp)/rho;   %% divide by mass/length
HM_bending_moment=abs(HM_bending_moment)*EI/rho;
HM_shear=abs(HM_shear)*EI/rho;