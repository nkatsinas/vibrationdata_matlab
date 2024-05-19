
disp(' ');
disp(' traveling_wave_animation.m  ver 1.0  by Tom Irvine ');
disp(' ');

% http://www.mathpages.com/home/kmath210/kmath210.htm

ac1 = animatedline('Color',[0 .7 .7]);

maxL=30;

axis([0 maxL -1 1])
xc = linspace(0,maxL,10000);
nx=length(xc);

tpi=2*pi;

cg=20;

c1=0.5*cg;

f1=10;
omega1=tpi*f1;
k1=omega1/c1;

df=1;
f2=f1+df;
domega=tpi*df;
omega2=omega1+domega;


dk=domega/cg;
k2=k1+dk;

fmax=max([f1 f2]);

sr=32*fmax;

dt=1/sr;

dur=2;

nt=round(dur/dt);




x=zeros(nx,1);
y=zeros(nx,1);

nt
nx

v = VideoWriter('group_gt_phase.avi');
open(v);


figure(100);

for i=1:nt
    
    t=(i-1)*dt;

    for j = 1:nx
        x = xc(j);
        y(j) = a1*sin(k1*x-omega1*t)+a2*sin(k2*x-omega2*t);
    end

    h=plot(xc,y);
 
    title('Phase Speed = (1/2) Group Speed'); 
    ylabel('Amplitude');
    xlabel('Distance');
    ylim([-2 2]);
    
    if(i==1)
        set(gca,'nextplot','replacechildren');
    else    
        frame = getframe(gcf);
        writeVideo(v,frame);
    end
        
    drawnow;
    
end

close(v);