%
%   complex_sine_tone_fatigue.m  ver 1.0  by Tom Irvine
%
%         f = frequency (Hz)
%     force = complex force response array, with one row per sine tone & two
%             columns
%             First column is real force  
%             Second column is imaginary force 
%
%         b = fatigue exponent (typically: 4 <= b <= 8 )
%         T = duration (sec)
%
%    damage = relative damage, dimension: (response amplitude unit)^b
%     ysine = worst case composite sine time history with two columns:
%             time(sec) & force
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Task instruction:
%
%   There will be between 1 to 3 inputs of the form shown above.  
%   If there are 2 or more inputs, it is requested to clock these inputs 
%   every 45 degrees (0,45,90,135,180,225,270,315 degrees).  
%   Then provide the results from the worst clocking combination.
%
function[ysine,damage]=complex_sine_tone_fatigue(f,force,T,b)
%
omega=2*pi*f;
sr=20*f;
dt=1/sr;
num_times=floor(T/dt);
t = (0:num_times-1)*dt;
t=t';
%
sz=size(force);
%
num_rows=sz(1);
%
y=zeros(num_times,num_rows);
%
A=zeros(num_rows,1);
phase=zeros(num_rows,1);

for i=1:num_rows
    complex_force=complex(force(i,1),force(i,2));
    A(i)=abs(complex_force);
    phase(i)=angle(complex_force);
end
%
y(:,1)=A(1)*sin(omega*t+phase(1));
%

if(num_rows==1)
    ysine=[t y(:,1)];
end    

if(num_rows==2)
    
    dmax=0;
    
    for i=1:8
        phi=phase(2)+(i-1)*pi/4;
        yt=A(2)*sin(omega*t+phi);
 
        x=y(:,1)+yt;
    
        c=rainflow(x);
        cycles=c(:,1);
        amp=c(:,2)/2;
        d=sum( cycles.*amp.^b );
        
        if(i==1 || d>dmax)
            y(:,2)=yt;
            dmax=d;
        end
        
    end   
    
    ysine=[t y(:,1)+y(:,2)];
    
end


%
if(num_rows==3)
    
    dmax=0;
    
    for i=1:8
        phi=phase(2)+(i-1)*pi/4;
        yt2=A(2)*sin(omega*t+phi);
 
        for j=1:8
            
            theta=phase(3)+(j-1)*pi/4;
            yt3=A(3)*sin(omega*t+theta);
 
            x=y(:,1)+yt2+yt3;
        
            c=rainflow(x);
            cycles=c(:,1);
            amp=c(:,2)/2;
            d=sum( cycles.*amp.^b );
   
            if((i==1 && j==1) || d>dmax)
                y(:,2)=yt2;
                y(:,3)=yt3;
                dmax=d;
            end
        end
    end       
    
    ysine=[t y(:,1)+y(:,2)+y(:,3)];    

end

damage=dmax;