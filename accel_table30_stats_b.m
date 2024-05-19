
disp(' ');
disp(' * * * * ');
disp(' ');

clear ccc;

ccc=zeros(2000,1);

j=1;

for i=1:1:2000
    
    
    
    ccc(j)=accel_table30(i,2);
    j=j+1;
  
end

fig_num=777;

iu=1;

a_resp=ccc;


pmin=min(ccc);
pmax=max(ccc);   
pmu=mean(ccc);
psd=std(ccc); 

out1=sprintf('   Range: %7.4g to %7.4g ',pmin,pmax);
out2=sprintf('    Mean: %7.4g  ',pmu);
out3=sprintf(' Std Dev: %7.4g ',psd);

disp(out1);
disp(out2);
disp(out3);

    nbar=17;
    xx1=min(abs(a_resp));
    xx2=max(abs(a_resp));
    x=linspace(xx1,xx2,nbar);       
    figure(fig_num);
    fig_num=fig_num+1;
    hist(a_resp,x)
    ylabel(' Counts');
    if(iu==1 || iu==2)
        xlabel('Accel (G)')
    else
        xlabel('Accel (m/sec^2)')    
    end  
    title('Group Acceleration Response Peak Histogram');