clear THM;
clear THMQ;

disp(' ');

FS = input(' Enter the input SPL name:  ','s');
THM=evalin('caller',FS);

f=THM(:,1);
a=THM(:,2);


N=length(f);

THMQ=zeros(N,3);


for i=1:N
    
    lf=0.3/(f(i)^0.63);  

    THMQ(i,:)=[f(i) a(i) lf];  
    
end

output_name= input(' Enter the output SPL name:  ','s');

assignin('base', output_name, THMQ);