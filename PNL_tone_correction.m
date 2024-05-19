%%%%%%%%%%%%%%%%%%%%
%
%  PNL_tone_correction.m  ver 1.0  by Tom Irvine
%
%
%  Tone Correction
%

function[PNLT]=PNL_tone_correction(NL,SPL,PNL,nfc)

% step 1

s=zeros(NL,1);

for i=4:NL
   s(i)=SPL(i)-SPL(i-1); 
end

% step 2
%
%  encircle = 1 
%

enc=zeros(NL,1);

for i=4:NL
    if(abs(s(i))>5)
        enc(i)=1;
    end
end    

% step 3
%
%  encircle = 1 
%
SPL_enc=zeros(NL,1);

for i=4:NL
    if( enc(i)==1)
        if(s(i)>0 && s(i)>s(i-1))
            SPL_enc(i)=1;
        else
            SPL_enc(i-1)=1;
        end
    end
end    


% step 4

SPL_prime=SPL;

for i=1:23
   if(SPL_enc(i)==1)
       SPL_prime(i)=0.5*( SPL(i-1) + SPL(i) );
   end
end

if(SPL_enc(24)==1)
   SPL_prime(24)=SPL(23)+s(23); 
end


% step 5

s_prime=zeros(25,1);

for i=4:NL
   s_prime(i)=SPL_prime(i)-SPL_prime(i-1); 
end

s_prime(3)=s_prime(4);
s_prime(25)=s_prime(24);

% step 6

s_bar=zeros(23,1);

for i=3:23
   s_bar(i)=( s_prime(i)+s_prime(i+1)+s_prime(i+2) )/3; 
end

% step 7

SPL_prime_prime=SPL;

for i=4:23
   SPL_prime_prime(i)=SPL_prime_prime(i-1)+s_bar(i-1); 
end

% step 8

F=SPL-SPL_prime_prime;

% step 9

C=zeros(24,1);

for i=3:24
   
    if(F(i)>1.5)
        
        if(50<=nfc(i) && nfc(i)<=500)
           
            if(1.5<=F(i) && F(i)<3)
                C(i)=(1/3)*F(i)-0.5;
            end
            if(3<=F(i) && F(i)<20)
                C(i)=F(i)/6;
            end            
            if(20<=F(i))
                C(i)=10/3;
            end                
            
        end
        if(500<nfc(i) && nfc(i)<=5000)
           
            if(1.5<=F(i) && F(i)<3)
                C(i)=(2/3)*F(i)-1;
            end
            if(3<=F(i) && F(i)<20)
                C(i)=F(i)/3;
            end            
            if(20<=F(i))
                C(i)=20/3;
            end                
                        
            
        end
        if(5000<=nfc(i) && nfc(i)<=10000)
           
            if(1.5<=F(i) && F(i)<3)
                C(i)=(1/3)*F(i)-0.5;
            end
            if(3<=F(i) && F(i)<20)
                C(i)=F(i)/6;
            end            
            if(20<=F(i))
                C(i)=10/3;
            end   
            
        end        
        
    end    
    
end

% step 10

Cmax=max(C);

PNLT=PNL+Cmax;
