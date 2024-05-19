disp(' ');
disp(' bending_elastic_interlayer.m  ver 1.1  by Tom Irvine ');
disp(' ');

clear ff;
clear fm;
clear ratio;
clear R;

tpi=2*pi;

[width,thick,joint_thick,B1,B2,E1,E2,I1,I2,L,area1,area2,br,e,HL,mp]=ei_input();

k=1;

f=1;




damp=0.05;
lf=2*damp;



CL=sqrt(E1/rho);

while(1)
    
    omega=tpi*f;
     
    [CB,rr,iflag]=bending_joint_atten(f,B1,B2,mp,e,HL,L,h,CL);    

    if(iflag==1)
        disp('Lambda too low');
        break;
    end
    

    ff(k)=f;

    fm(k,1)=ff(k);
    fm(k,2)=rr;    
    
    
    k=k+1;
    
    
    f=f*2^(1/12);
    
    if(f>60000)
        break;
    end

end

ratio=fm(:,2);

max_ratio=max(ratio);
min_ratio=min(ratio);

ymax=10^(ceil(log10(max_ratio)));
ymin=10^(floor(log10(min_ratio)));

if(ymin==ymax)
    ymin=ymax/10;
end


figure(100)
plot(ff,ratio);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
grid on;
ylim([ymin,ymax]);



dsq=sprintf('%g',br);

ds = strrep(dsq, '.', 'p');

strq=sprintf('e_rr_L%d_h%d_w%d_%s',L*100,h*100,width*100,ds);


ff=fix_size(ff);
ratio=fix_size(ratio);

fq=[ff ratio];

eval('str1 = fq;'); 

assignin('base', strq, str1);



strq


minf=1.0e+90;
clear length;

n=length(ff);

for i=1:n
    if(ratio(i)<minf)
        minf=ratio(i);
        k=i;
    end
end



output_filename=sprintf('%s.txt',strq);

fid = fopen(output_filename,'w');


        for i=1:n            
            fprintf(fid,' %14.7e \t %g \n',fq(i,1),fq(i,2));       
        end 

fclose(fid);

    
VT=( 2 / e^2 )^(1/3);


lambda=tpi*L*B1/(VT*B2);

f=(tpi/lambda^2)*sqrt(B1/mp);

out1=sprintf(' VT=%8.4g  lambda=%8.4g    f=%8.4g Hz  ',VT,lambda,f);
disp(out1);

