
disp(' ');
disp(' * * * * ');
disp(' ');

clear lambda;
clear P;


b=6.4;

A=0;

num=1000;
maxL=7;

dL=maxL/num;


P=zeros(num,1);
lambda=zeros(num,1);


for i=2:num
    
    lambda(i)=(i-1)*dL;
    
    [P(i)]=integrate_normal_distribution_function(lambda(i));    
    
end 

for i=2:num

    A=A+(P(i) - P(i-1))*lambda(i)^6.4;
    
end
    
A^(1/b)