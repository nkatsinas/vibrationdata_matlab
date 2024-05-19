

% power_transmissibility_mult_function.m  ver 1.0  by Tom Irvine

function[ppp,rms]=power_transmissibility_mult_function(fa,a,fb,b,nni)

numa=length(fa);
numb=length(fb);

k=1;

for i=1:numa
    for j=1:numb-1
        if(fa(i)==fb(j))
            fc(k)=fa(i);
             c(k)=a(i)*b(j); k=k+1;
            break;
        end
        if(fa(i)==fb(j+1))
            fc(k)=fa(i);            
             c(k)=a(i)*b(j+1); k=k+1;
            break;
        end        
        if(fa(i)>fb(j) && fa(i)<fb(j+1))
            
            x1=fb(j);
            y1=b(j);
            x2=fb(j+1);
            y2=b(j+1);
            xn=fa(i);
            
            if(nni==1)
                [yn]=linear_interpolation_function(x1,y1,x2,y2,xn);
            else
                [yn,~]=log_interpolation_function(x1,y1,x2,y2,xn);
            end
            
            fc(k)=fa(i);
            c(k)=a(i)*yn; k=k+1;
            break;
        end
    end
end

fc=fix_size(fc);
c=fix_size(c);

ppp=[fc c];

[~,rms]=calculate_PSD_slopes_no(fc,c);