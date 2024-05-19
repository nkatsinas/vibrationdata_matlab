%
disp(' ');
disp(' wavelet_propagation_joint.m  ver 1.1  by Tom Irvine ');
disp(' ');
%


clear tt;
clear A;
clear fff;

%%%%%%%%%%%%%%%%


[width,thick,joint_thick,B1,B2,E1,E2,I1,I2,L,area1,area2,br,e,HL,mp]=ei_input();



%%%%%%%%%%%%%%%%

% amp   freq   nhs  delay

wt=input(' Enter wavelet table name ');

  f=wt(:,2);
amp=wt(:,3);
nhs=wt(:,4);
 td=wt(:,5);



sr=50*max(f);
dt=1/sr;

dur=0.6;
nt=round(dur/dt);

tt=zeros(nt,1);
A=zeros(nt,1);


clear length;
nwaves=length(f);

tstart=zeros(nwaves,1);
  tend=zeros(nwaves,1);
  tdx=zeros(nwaves,1);
  ratio=zeros(nwaves,1);
  
  beta=zeros(nt,1);
  alpha=zeros(nt,1);
  
CL=sqrt(E1/rho);  
  
k=1;  
  
for i=1:nwaves

    beta(i)=2*pi*f(i);

    alpha(i)=beta(i)/nhs(i);
    
    
    [CB,rr,iflag]=bending_joint_atten(f(i),B1,B2,mp,e,HL,L,h,CL);    

    if(iflag==1)
        warndlg('Lambda too low');
        break;
    end
    
    ratio(i)=rr;
    
    tdx(i)=0;

    tstart(i)=(td(i)+tdx(i));
    tend(i)=tstart(i)+nhs(i)/(2*f(i));

    fff(k,:)=[f(i) rr];
    k=k+1;
    
end

fff=sortrows(fff,1)


max_ratio=max(ratio);
min_ratio=min(ratio);

ymax=10^(ceil(log10(max_ratio)));
ymin=10^(floor(log10(min_ratio)));


figure(111)
plot(fff(:,1),fff(:,2));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
grid on;
ylim([ymin,ymax]);



if(iflag==0)

    for i=1:nt
    
        tt(i)=(i-1)*dt; 
        t=tt(i);    

        for j=1:nwaves 
      
            tq=t-tstart(j);
        
            if(t>=tstart(j) && t<= tend(j))
                A(i)=A(i)+amp(j)*ratio(j)*sin(alpha(j)*tq)*sin(beta(j)*tq);
            end
    
        end

    end


figure(501);
plot(tt,A);
grid on;
xlabel('Time (sec) ');
ylabel('Accel (G)');

xh=[tt A];

mq=max(abs(accel_11k(:,2)));

ratio=max(abs(A))/mq;

dsq=sprintf('%g',br);

ds = strrep(dsq, '.', 'p');

strq=sprintf('e_bj_L%d_h%d_w%d_%s',L*100,h*100,width*100,ds);

eval('str1 = xh;'); 

assignin('base', strq, str1);

strq

clear length;

output_filename=sprintf('%s.txt',strq);

fid = fopen(output_filename,'w');

            fprintf(fid,' -0.01 \t 0. \n'); 
        for i=1:length(xh(:,1))            
            fprintf(fid,' %14.7e \t %g \n',xh(i,1),xh(i,2));       
        end 

fclose(fid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=1;

clear f;

f(1)=10;

damp=0.05;

while(1)
   
    fnn=f(k)*2^(1/12);
    
    if(fnn>23000)
        break;
    else
        k=k+1;
        f(k)=fnn;
    end
   
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear srs;

yy=xh(:,2);

[srs]=srs_function(yy,dt,damp,f);


sz=size(srs);

for i=1:sz(1)

    srsa(i,:)=[srs(i,1) max([ srs(i,2)  srs(i,3) ])];

end

strq=sprintf('e_bj_srs_L%d_h%d_w%d_%s',L*100,h*100,width*100,ds);

eval('str1 = srsa;'); 

assignin('base', strq, str1);

strq


output_filename=sprintf('%s.txt',strq);

fid = fopen(output_filename,'w');


        for i=1:sz(1)            
            fprintf(fid,' %14.7e \t %g \n',srsa(i,1),srsa(i,2));       
        end 

fclose(fid);


end