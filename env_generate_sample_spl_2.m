
% env_generate_sample_spl_2.m  ver 1.0  by Tom Irvine


function[apsd_sam,spl]=env_generate_sample_spl_2(fc,reference,xspl,slope)

num=length(fc);

a=slope/3;
b=2*a;

spl=zeros(num,1);

for i=1:num
    spl(i)=xspl(i)+(-0.5+1*rand());
end

for i=1:num
    
    if(i>=2)
        
        ss=(spl(i)-spl(i-1))/3;
        
        if(abs(ss)>slope)
            spl(i)=spl(i-1)+(-a+b*rand());
        end
        
    end
    
end

%
apsd_sam=zeros(num,1);
%
%
delta=(2.^(1./6.)) - 1./(2.^(1./6.));
%
for i=1:num    
%	
    if( spl(i) >= 1.0e-50)
%		
        pressure_rms=reference*(10.^(spl(i)/20.) );
%
		df=fc(i)*delta;
%
        if( df > 0. )	
            apsd_sam(i)=(pressure_rms^2.)/df;
        end
    end
end
%
