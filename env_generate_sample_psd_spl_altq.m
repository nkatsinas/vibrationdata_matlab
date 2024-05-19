%
%   env_generate_sample_psd_spl_altq.m  ver 1.8   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%             vibrationdata_envelope_fds.m
%             vibrationdata_envelope_fds_batch.m 
%
%
function[f_sam,apsd_sam,spla,x,y]=...
    env_generate_sample_psd_spl_altq(n_ref,nbreak,npb,f_ref,ik,slopec,initial,final,f1,f2,fc,reference)
%

x=zeros(nbreak,1);
y=zeros(nbreak,1);

f_sam=fc;     

fcq=fc;

fa=fcq(1);
fz=fcq(end);

noct=log(fz/fa)/log(2);

uu=20;

if(npb==1)
    x(2)=fa*2^(noct*1/2);    
end
if(npb==2)
    x(2)=fa*2^(noct*1/3);
    x(3)=fa*2^(noct*2/3);    
end
if(npb==3)
    x(2)=fa*2^(noct*1/4);
    x(3)=fa*2^(noct*2/4);
    x(4)=fa*2^(noct*3/4);
end
if(npb==4)
    x(2)=fa*2^(noct*1/5);
    x(3)=fa*2^(noct*2/5);
    x(4)=fa*2^(noct*3/5);
    x(5)=fa*2^(noct*4/5);
end
if(npb==5)
    x(2)=fa*2^(noct*1/6);
    x(3)=fa*2^(noct*2/6);
    x(4)=fa*2^(noct*3/6);
    x(5)=fa*2^(noct*4/6);
    x(6)=fa*2^(noct*5/6);
end
if(npb==6)
    x(2)=fa*2^(noct*1/7);
    x(3)=fa*2^(noct*2/7);
    x(4)=fa*2^(noct*3/7);
    x(5)=fa*2^(noct*4/7);
    x(6)=fa*2^(noct*5/7);
    x(7)=fa*2^(noct*6/7);    
end
if(npb==7)
    x(2)=fa*2^(noct*1/8);
    x(3)=fa*2^(noct*2/8);
    x(4)=fa*2^(noct*3/8);
    x(5)=fa*2^(noct*4/8);
    x(6)=fa*2^(noct*5/8);
    x(7)=fa*2^(noct*6/8);  
    x(8)=fa*2^(noct*7/8);    
end
if(npb==8)
    x(2)=fa*2^(noct*1/9);
    x(3)=fa*2^(noct*2/9);
    x(4)=fa*2^(noct*3/9);
    x(5)=fa*2^(noct*4/9);
    x(6)=fa*2^(noct*5/9);
    x(7)=fa*2^(noct*6/9);  
    x(8)=fa*2^(noct*7/9);    
    x(9)=fa*2^(noct*8/9);     
end
if(npb==9)
    x=fc;
end    

x(1)=fa;
x(end)=fz;


y(1)=80+uu*rand();
y(end)=80+uu*rand();




if(npb==4)
    ymin=80;
  
else
    ymin=max([y(1) y(end)]);    
end

for i=1:nbreak
    y(i)=ymin+uu*rand();
end  

if(ik==1)
    y(1:end)=80;
end
if(npb~=7 && ik>=2 && ik<=40)
    xx=[x(1) x(end)];
    yy=[y(1) y(end)]; 
    y = interp1(xx,yy,x);
end

if(nbreak==2 && ik>=41 && ik<200)
    y(2)=ymin+uu*rand();
end
if(nbreak==6 && ik>=41 && ik<200)
    y(2)=ymin+uu*rand();
    y(3)=ymin+uu+5*rand();
    y(4)=ymin+uu+5*rand();
    y(5)=ymin+uu*rand();
end
if(nbreak==7 && ik>=41 && ik<200)
    y(2)=ymin+uu*rand();
    y(3)=ymin+uu+5*rand();
    y(4)=ymin+uu+5*rand();
    y(5)=ymin+uu+5*rand();    
    y(6)=ymin+uu*rand();
end
if(nbreak==8 && ik>=41 && ik<200)
    y(2)=ymin+uu*rand();
    y(3)=ymin+uu+5*rand();
    y(4)=ymin+uu+5*rand();
    y(5)=ymin+uu+5*rand();    
    y(6)=ymin+uu+5*rand(); 
    y(7)=y(6);
end
if(nbreak==9 && ik>=41 && ik<200)
    y(2)=ymin+uu*rand();
    y(3)=ymin+uu+5*rand();
    y(4)=ymin+uu+5*rand();
    y(5)=ymin+uu+5*rand();    
    y(6)=ymin+uu+5*rand(); 
    y(7)=ymin+uu+5*rand();     
    y(8)=y(8);
end
if(nbreak==10 && ik>=41 && ik<200)
    y(2)=ymin+uu*rand();
    y(3)=ymin+uu+5*rand();
    y(4)=ymin+uu+5*rand();
    y(5)=ymin+uu+5*rand();    
    y(6)=ymin+uu+5*rand(); 
    y(7)=ymin+uu+5*rand();   
    y(8)=ymin+uu+5*rand();      
    y(9)=y(9);
end
if(npb==9)
    for i=1:length(fc)
        y(i)=ymin+uu*rand();
    end  
end

if(nbreak<=5)
    y(1)=min([ y(1)  y(2) ]);
    y(2)=max([ y(1)  y(2) ]);    
else
    yy=sort(y(1:3));
    y(1)=yy(1);
    y(2)=yy(2);
    y(3)=yy(3);
end

   
if(y(end)>y(end-1))
    y(end-1)=max([ y(end-1)  y(end) ]);
    y(end)=max([ y(end-1)  y(end) ]);    
end  

x=sort(x);     

% spla = interp1(x,y,fcq);

% n=3;
% p = polyfit(x,y,n);
% spla=(  p(1)*tt.^3 +p(2)*tt.^2 + p(3)*tt + p(4));



ymax=max(y);
YL=ymax-10;

for i=1:length(y)
    if(y(i)<YL)
        y(i)=YL;
    end
end


if(y(end)>y(end-1))
    y(end)=y(end-1);
end


if(npb==1)
    n=2;
    p = polyfit(x,y,n);
    spla=(  p(1)*fcq.^2 +p(2)*fcq + p(3));
end   
if(npb>=2 && npb<=8)
    spla = spline(x,y,fcq);
end    
if(npb==9)
    spla=y;
end



ymax=max(spla);
YL=ymax-12;

for i=1:length(spla)
    if(spla(i)<YL)
        spla(i)=YL;
    end
end


for i=1:length(spla)
    if(isinf(spla(i)))
        disp('spla inf');
        pause(2)
    end    
    
end
for i=1:length(spla)
    if(isnan(spla(i)))
        disp('spla NaN');
        pause(2) 
    end    
       
end


[apsd_sam]=one_third_octave_spl_to_pressure_psd(fc,spla,reference);



