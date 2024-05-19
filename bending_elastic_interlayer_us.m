disp(' ');
disp(' bending_elastic_interlayer_us.m  ver 1.1  by Tom Irvine ');
disp(' ');

clear ff;
clear fm;
clear ratio;
clear R;

tpi=2*pi;

   fc=input(' Enter transition frequency ');
slope=input(' Enter slope dB/octave ');

k=1;

f=1;

while(1)
    
    omega=tpi*f;
     
    [rr]=bending_joint_atten_us(f,fc,slope);    


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



dsq=sprintf('%g',slope);

ds = strrep(dsq, '.', 'p');

strq=sprintf('u_atten_L%d_%s',fc,ds);


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