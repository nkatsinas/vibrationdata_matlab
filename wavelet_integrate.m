
%
%  wavelet_integrate.m  ver 1.0  by Tom Irvine
%
function[dispx,vel,acc]=wavelet_integrate(f,ramp,NHS,td,dt,dur,t)

accel=ramp;
freq=f;
delay=td;
num=length(t);
nw=length(f);

for i=1:nw
    
    te(i)=delay(i) + (double(NHS(i))/(2*freq(i)));
    
    if(te(i)>dur)
        dur=te(i);
    end
   
end



%%%%%%%%%%%%%%%%%

max_wf=max(freq);

tt=zeros(num,1);
acc=zeros(num,1);
vel=zeros(num,1);
dispx=zeros(num,1);

for i=1:num
    tt(i)=(i-1)*dt;
end    

omega=2*pi*freq;

for j=1:nw
    
    om=omega(j);
    om2=om^2;

    for i=1:num
        
        if(tt(i)>=delay(j) && tt(i)<=te(j))
            
            tx=tt(i)-delay(j);
            
            arg=om*tx;   
            
            
            dnhs=double(NHS(j));
 
            alpha=om/dnhs; 
            beta=om;   
            
            apb=alpha+beta;
            amb=alpha-beta;
            
            apbtx=apb*tx;
            ambtx=amb*tx;
            
            tapb=2*apb;
            tamb=2*amb;
            
            tapb2=2*apb^2;
            tamb2=2*amb^2;            
            
         
              acc(i)=  acc(i)+accel(j)*sin(arg)*sin(arg/dnhs);
              
              vel(i)=  vel(i)+accel(j)*(  -(sin(apbtx)/tapb) + (sin(ambtx)/tamb) );
              
            dispx(i)=dispx(i)+accel(j)*(  ((cos(apbtx)-1)/tapb2) - ((cos(ambtx)-1)/tamb2) );
            
        end    
        if(tt(i)>te(j))
            break;
        end
    
    end

end

%%%%%%%%%%%%%%%%
