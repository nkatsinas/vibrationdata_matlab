%
%  psd_mult_trans.m  ver 1.3   by Tom Irvine
%
function[C] = psd_mult_trans(P,T)
%
Psz=size(P);
Tsz=size(T);
%
Pn=Psz(1);
Tn=Tsz(1);
%
ijk=1;
%
js=1;
%
for i=1:Tn
    tf=T(i,1);
    power_trans=(T(i,2))^2;

    
%    
    for j=js:(Pn-1)
%        
        pf1=P(j,1);
        pf2=P(j+1,1);


        if(tf==pf1)
            C(ijk,1)=tf;
            C(ijk,2)=power_trans*P(j,2);

            ijk=ijk+1;
            js=j;

            break;
        end
%        
        if( pf1<tf && tf < pf2 )
            C(ijk,1)=tf;            
            n=log10(P(j+1,2)/P(j,2))/log10(pf2/pf1);
            Pint=P(j,2)*((tf/pf1)^n);
            C(ijk,2)=power_trans*Pint;    
%            
            ijk=ijk+1;
            js=j;
               
            break; 
        end
%        
        if(tf==pf2)
            C(ijk,1)=tf;
            C(ijk,2)=power_trans*P(j+1,2);         

            ijk=ijk+1;
            js=j;
              
            break; 
        end
%
    end
    
end    

C(:,2)=abs(C(:,2));


