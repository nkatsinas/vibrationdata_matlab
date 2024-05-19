disp(' ')
disp(' arbit.m   ver 3.9   October 11, 2018')
disp(' by Tom Irvine   Email: tom@irvinemail.org')
disp(' ')
disp(' This program calculates the response of a single-degree-of-freedom')
disp(' system to an arbitrary base input time history. ')
disp(' ')
disp(' The input time history must have two columns: time(sec) & accel(G)')
disp(' ')
%
close all;
%
clear omega;
clear omegad;
clear dt;
clear sr;
clear damp;
clear a1;
clear a2;
clear b1;
clear b2;
clear c1;
clear c2;
clear sum;
clear t;
clear tt;
clear y;
clear yy;
clear THM;
clear x_pos;
clear x_neg;
clear rd_pos;
clear rd_neg;
clear a_resp;
clear x_resp;
clear aa_forward;
clear rv_forward;
clear rd_forward;
clear back;
clear length;
%
fig_num=1;
%
while(1)
    disp(' Select units ');
    disp('  1=English: accel(G), vel(in/sec),  disp(in)  ');
    disp('  2=metric : accel(G),  vel(m/sec),  disp(mm)  ');
    iu=input(' ');
    if(iu==1 || iu==2)
        break;
    end
end
%
[t,y,dt,sr,tmx,tmi,n,ncontinue]=enter_time_history();
%
if(ncontinue==1)
%
disp(' ')
fn(1)=input(' Enter the natural frequency (Hz)  ');
%
disp(' ')
idamp=input(' Enter damping format:  1= damping ratio   2= Q  ');	
%
disp(' ')
if(idamp==1)
    damp=input(' Enter damping ratio (typically 0.05) ');
else
    Q=input(' Enter the amplification factor (typically Q=10) ');
    damp=1./(2.*Q);
end
%
%  Initialize coefficients
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt); 
%
%
disp(' ');
disp(' Include residual? ');
disp('  1=yes  2=no ')
ire=input(' ');
%
if(ire==1)
%
%   Add trailing zeros for residual response
%
    disp(' ')
    disp(' Add trailing zeros for residual response')
    tmax=(tmx-tmi) + 2./fn(1);
    limit = round( tmax/dt );
    n=limit;
end
%   
yy=zeros(1,n);
for i=1:length(y)
        yy(i)=y(i);        
end        
%
%  SRS engine
%
for j=1:1
%
    back   =[     1, -a1(j), -a2(j) ];
%
    disp(' ')
    disp(' Calculating absolute acceleration');
%
    aa_forward=[ b1(j),  b2(j),  b3(j) ];
%    
    a_resp=filter(aa_forward,back,yy);
%
    x_pos(j)= max(a_resp);
    x_neg(j)= min(a_resp);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    disp(' ')
    disp(' Calculating relative displacement');
%
    rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];
    rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];      
%    
    rd_resp=filter(rd_forward,rd_back,yy);
%
    rd_pos(j)= max(rd_resp);
    rd_neg(j)= min(rd_resp);
end
%
disp(' ')
disp(' Acceleration Response ')
disp(' ')

peak=max(abs(a_resp));
if(abs(x_neg(1))>peak)
    peak=abs(x_neg(1));
end
%
[mu,sd,rms,sk,kt]=kurtosis_stats(a_resp);
kurtosis=kt;
arms=rms;
%
T=(tmx-tmi);
ccc=sqrt(2*log(fn(1)*T));
ray=ccc+0.5772/ccc;
disp(' Rayleigh distibution expected peak for broadband random input ');
out10=sprintf('                 = %7.2f sigma',ray);
out11=sprintf('                 = %7.2f G ',ray*sd);
disp(out10);
disp(out11);
%
 out9=sprintf('\n absolute peak = %8.2f G',peak);
out10=sprintf('\n       maximum = %9.2f G',x_pos(1));
  out11=sprintf('       minimum = %9.2f G',x_neg(1));
  out12=sprintf('       overall = %9.2f GRMS',arms);
out13=sprintf('\n          mean = %9.2f G',mu);
  out14=sprintf('       std dev = %9.2f G',sd);
  out15=sprintf('  crest factor = %9.2f',peak/sd);
  out16=sprintf('      kurtosis = %9.2f',kurtosis);  
%
disp(out9);
disp(out10)
disp(out11)
disp(out12)
disp(out13)
disp(out14)
disp(out15)
disp(out16)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ')
disp(' Relative Displacement Response ')
mu=mean(rd_resp);
sd=std(rd_resp);
rd_rms=sqrt(sd^2+mu^2);
%
if(iu==1)
    rd_rms=rd_rms*386.;
    out10=sprintf('\n maximum = %10.3g inch',rd_pos(1)*386.);
    out11=sprintf(' minimum = %10.3g inch',rd_neg(1)*386.);
    out12=sprintf(' overall = %10.3g inch RMS',rd_rms);
else
    rd_rms=rd_rms*9.81*1000.;
    out10=sprintf('\n maximum = %10.3g mm',rd_pos(1)*9.81*1000.);
    out11=sprintf(' minimum = %10.3g mm',rd_neg(1)*9.81*1000.);
    out12=sprintf(' overall = %10.3g mm RMS',rd_rms);    
end    
%
disp(out10)
disp(out11)
disp(out12)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
nn=length(a_resp);
%
tmin=t(1);
tmax=(t(1)+(nn-1)*dt);
%
tt=linspace(tmin,tmax,nn);
ymin=1.3*min(a_resp);
ymax=1.3*max(a_resp);
if(abs(ymin)>abs(ymax))
    ymax=abs(ymin); 
end
if(abs(ymax)>abs(ymin))
    ymin=-abs(ymax); 
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%  Output 
%
clear acceleration;
clear rel_disp;
disp(' ');
acceleration(:,1)=tt';
acceleration(:,2)=a_resp';
%
    if(iu==1)
        rd_resp=rd_resp*386;
    else
        rd_resp=rd_resp*9.81*1000;        
    end    
%
rel_disp(:,1)=tt';
rel_disp(:,2)=rd_resp';
%
disp(' ')
disp('Output Acceleration Response Text File?')
choice=input(' 1=yes  2=no  ' );
disp(' ')
%
if choice == 1 
%
      [writefname, writepname] = uiputfile('*.dat','Save acceleration data as');
	  writepfname = fullfile(writepname, writefname);
%      
	  fid = fopen(writepfname,'w');
      clear length;
      n=length(tt);
%
      for i=1:n
	    fprintf(fid,' %g \t %g\n',tt(i),a_resp(i));
      end
%
      fclose(fid);
%    
end
%
%  Plot acceleration response
%
Q=1./(2.*damp);
t_string = sprintf(' SDOF Acceleration Response   fn=%g Hz   Q=%g ',fn(1),Q);
y_label=sprintf('Accel (G)');
x_label=sprintf('Time (sec)');   
[fig_num]=plot_TH(fig_num,x_label,y_label,t_string,acceleration);
%
disp(' ')
disp(' Plot histogram? ')
choice = input(' 1=yes 2=no ');
%
if(choice == 1)
     [fig_num]=plot_histogram(a_resp,'Accel(G)',fig_num);
end
%
%
disp(' ')
disp(' Plot absolute value peak distribution? ')
choice = input(' 1=yes 2=no ');
%
if(choice==1)
    [~]=...
    plot_peak_histogram_th(a_resp,'Histogram of Absolute Values of Peaks',fig_num);
end
%
disp(' ')
disp('Plot Relative Displacement Time History?')
choice=input(' 1=yes  2=no  ' );
disp(' ')
if choice == 1
    t_string = sprintf(' SDOF Relative Displacement  Response   fn=%g Hz   Q=%g ',fn(1),Q);
    if(iu==1)
        y_label=sprintf('Relative Disp (inch)');
    else
        y_label=sprintf('Relative Disp (mm)');       
    end
    x_label=sprintf('Time (sec)');   
    [fig_num]=plot_TH(fig_num,x_label,y_label,t_string,rel_disp);    
end
%
disp(' ');
disp(' plot phase portrait?');
k=input(' 1=yes  2=no ');
if(k==1)
    figure(fig_num);
    fig_num=fig_num+1;
    if(iu==1)
        plot(rd_resp,a_resp);
        xlabel('Relative Displacement (in)');   
    else
        plot(rd_resp,a_resp);        
        xlabel('Relative Displacement (mm)');   
    end    
    grid on;
%  
    ylabel('Acceleration (G)');
%
end
%
disp(' ');
disp(' Output arrays: ');
disp(' ');
disp('          Acceleration response:  acceleration');
disp(' Relative Displacement response:  rel_disp');
%
end