

%  compile_four_spl.m  ver 1.0  by Tom Irvine

%  freq(Hz), SPL(dB), rad eff, modal density

clear length;
clear a;
clear b;
clear c;
clear fa;
clear fb;
clear fc;
clear num_a;
clear num_b;
clear num_c;
clear four;

a=USA_spl_water;
% b=rad_eff;
b=rad_eff_half_space; 
c=modal_density;


fa=a(:,1);
fb=b(:,1);
fc=c(:,1);

aa=a(:,2);
bb=b(:,2);
cc=c(:,2);

num_a=length(fa);
num_b=length(fb);
num_c=length(fc);


four=zeros(num_a,1);

four(:,1)=fa;
four(:,2)=aa;

for i=num_a:-1:1
    if(four(i,1)<1.0e-04)
        fa(i)=[];
        four(i,:)=[];
    end    
end


for i=1:num_b

    [c,index] = min(abs(fa-fb(i)));
    
    four(index,3)=bb(i);

end

for i=1:num_c

    [c,index] = min(abs(fa-fc(i)));
    
    four(index,4)=cc(i);

end

four

four_water=four;

