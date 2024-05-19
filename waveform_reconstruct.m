%
 clear dis;
 clear THM; 
 clear aaa;
 clear amp;
 clear amp_original;
 clear ddd;
 clear delay;
 clear disp;
 clear duration;
 clear error;
 clear f;
 clear fl;
 clear fmax;
 clear freq;
 clear fu;
 clear iunit;
 clear mm;
 clear nfr;
 clear nhs;
 clear nt;
 clear num2;
 clear out1;
 clear p;
 clear residual;
 clear sd;
 clear sr;
 clear t;
 clear tp;
 clear tpi; 
 clear velox;
 clear vlast;
 clear vvv;
 clear x1r;
 clear x2r;
 clear x3r;
 clear x4r;
 clear y;
 clear ffmax;
 clear ffmin;
%
disp(' ');
disp(' waveform_reconstruct.m   version 1.5   August 28, 2011');
disp(' By Tom Irvine   Email:  tomirvine@aol.com ');
%
disp(' ');
disp(' This program synthesizes a wavelet series to approximate ');
disp(' an input time history. ');
%
disp(' ');
disp(' The input file must be: time(sec) and amplitude(units) ');
%
MAX=50000;
MAXP=1000;
%
tp=2.*pi;
tpi=tp;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
iunit=input(' Enter acceleration unit:   1= G   2= m/sec^2  ');	
%
if(iunit==1)
    iscale=386.;
else
    iscale=1.;
end
%
disp(' ')
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=Excel file');
file_choice = input('');
%
if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
        fclose(fid);
        THM=THM';
end
if(file_choice==2)
        THM = input(' Enter the matrix name:  ');
end
if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        THM = xlsread(xfile);
%         
end
%
t=double(THM(:,1));
y=double(THM(:,2));
amp=y;
amp_original=y;
%
num2=max(size(y));
%		
duration=t(num2)-t(1);
%
disp(' ')
ffmin=input(' Enter minimum frequency (Hz) ');
%
low_f=3/(2*duration);
%
if(ffmin<low_f)
    ffmin=low_f;
    disp(' ');
    out1=sprintf(' Warning:  minimum frequency changed to %8.4g Hz ',ffmin);
    disp(out1);
end
%
disp(' ')
ffmax=input(' Enter maximum frequency (Hz) ');
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ik=0;
%      
x1r=zeros(MAXP,1);	
x2r=zeros(MAXP,1);	
x3r=zeros(MAXP,1);	
x4r=zeros(MAXP,1);	
%
disp(' ');		
nt=input(' Enter the number of trials per frequency. ');
disp(' ');		
nfr=input(' Enter the number of frequencies. ');
%
if(nfr>MAXP)
    nfr=MAXP;
end
%		   
fmax=0.;
%
residual=y;
%
clear y;
%
out1=sprintf(' number of input point= %d ',num2)
disp(out1);
%
sr=duration/(num2-1);
sr=1./sr;
%
out1=sprintf(' sample rate = %10.4g \n',sr);
disp(out1);
%
fl=3./duration;
fu=sr/5.;
%
if(ffmax>fu)
    out1=sprintf('\n maximum frequency reset to %8.4g Hz \n',fu);
    disp(out1);
    uv=input(' Press enter to continue ');
    ffmax=fu;
end
%
clear y;
%
for(ie=1:nfr)
%
    out1=sprintf(' frequency case %d ',ie);
    disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    disp(' ref 1');
    [x1r,x2r,x3r,x4r]=wgen(num2,t,residual,duration,sr,x1r,x2r,x3r,x4r,fl,fu,nt,ie,ffmin,ffmax);
    disp(' ref 2');
%            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    if(x2r(ie)<ffmin*tp)
        x2r(ie)=ffmin*tp;
        x1r(ie)=1.0e-20;
        x3r(ie)=3;
        x4r(ie)=0;
    end
%
	for(i=1:num2)
%			
	    tt=t(i);
%
		t1=x4r(ie) + t(1);
		t2=t1 + tp*x3r(ie)/(2.*x2r(ie));
%
		y=0.;
%
		if( tt>= t1 && tt <= t2)
%				
			arg=x2r(ie)*(tt-t1);  
			y=x1r(ie)*sin(arg/double(x3r(ie)))*sin(arg);			       
%
		    residual(i)=residual(i)-y;
        end
    end       
    ave=mean(residual); 
    sd=std(residual);
%
    out1=sprintf(' ave=%12.4g  sd=%12.4g \n\n',ave,sd);
    disp(out1);       
%			 
end    
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear aaa;
clear vvv;
clear ddd;
clear mm;
%
aaa=zeros(num2,1); 
vvv=zeros(num2,1); 
ddd=zeros(num2,1); 
%
		disp(' ');
%
		kk=0;
%
		for(i=1:nfr)
%
            if(x2r(i)<ffmin*tp)
                x2r(i)=ffmin*tp;
                x1r(i)=1.0e-20;
                x3r(i)=3;
                x4r(i)=0;
            end
%
			out1=sprintf(' amp=%10.4f   freq=%10.3f Hz   nhs=%d   delay=%10.4f ',x1r(i),x2r(i)/tp,x3r(i),x4r(i));
            disp(out1);
%
            wavelet_table(i,1)=i;
            wavelet_table(i,2)=x2r(i)/tpi;           
            wavelet_table(i,3)=x1r(i);
            wavelet_table(i,4)=x3r(i); 
            wavelet_table(i,5)=x4r(i);              
%
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('\n Enter the acceleration time history output filename: ');
disp(out1);
       output_filename1 = input(' ','s');
out1=sprintf('\n Enter the velocity time history output filename: ');
disp(out1);
       output_filename2 = input(' ','s');
%
out1=sprintf('\n Enter the displacement time history output filename: ');
disp(out1);
       output_filename3 = input(' ','s');
%
out1=sprintf('\n Enter the wavelet table output filename: ');
disp(out1);
       output_filename4 = input(' ','s');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		tf=0.;
%
		vlast=zeros(num2,1);
%
%%        num2
%%        nfr
%%        iscale
		for(k=1:num2)
%
				tt=t(k);
%              
				for(j=1:nfr)
%				
                    w=0.;
					v=0.;
					d=0.;
%
					v1=0.;
					v2=0.;
%
					d1=0.;
					d2=0.;
%
					t1=x4r(j)+t(1);
%
                    if(x2r(j)>=1.0e-10)
%
                    else
                        x2r(j)=ffmin*tp;
                        x1r(j)=1.0e-20;
                        x3r(j)=3;
                        x4r(j)=0;
                        t1=x4r(j)+t(1);  
                    end    
                    t2=tp*x3r(j)/(2.*x2r(j))+t1; 
%
					if( tt>=t1  && tt <=t2  )
%					
						arg=x2r(j)*(tt-t1);  
%
						w=  x1r(j)*sin(arg/double(x3r(j)))*sin(arg);
%
                        aa=x2r(j)/double(x3r(j));
						bb=x2r(j);
%
						te=tt-t1;
%
						alpha1=aa+bb;
					    alpha2=aa-bb;
%
                        alpha1te=alpha1*te;
                        alpha2te=alpha2*te;   
%
						v1= -sin(alpha1te)/(2.*alpha1);
				        v2= +sin(alpha2te)/(2.*alpha2);
%
                        d1= +(cos(alpha1te)-1)/(2.*(alpha1^2));
                        d2= -(cos(alpha2te)-1)/(2.*(alpha2^2));
%
						v=(v2+v1)*iscale*x1r(j);
						d=(d2+d1)*iscale*x1r(j);
%
						vlast(j)=v;
%
                    end
%
					aaa(k)=aaa(k)+w; 
					vvv(k)=vvv(k)+v;
					ddd(k)=ddd(k)+d;
%
					amp(k)=amp(k)-w;
%
					if(x3r(j)<1)
                        printf(' error x3r ');
                        break;
                    end
%
                end
%
%%               out1=sprintf(' %d t=%8.4g  %8.4g  %8.4g  %8.4g ',k,t(k),aaa(k),vvv(k),ddd(k));
%%               disp(out1);
        end
%%
        error=[t,amp];
        accel=[t,aaa];
        velox=[t,vvv];
        dis=[t,ddd];
%
save(output_filename1,'accel','-ASCII')
save(output_filename2,'velox','-ASCII')
save(output_filename3,'dis','-ASCII')
save(output_filename4,'wavelet_table','-ASCII')
%
        figure(1);
        plot(t,ddd);     
        title(' Displacement Time History ');
        xlabel(' Time(sec)');
        if(iunit==1)
            ylabel(' Displacment(inch)');
        else
            ylabel(' Displacement(m)');          
        end
        grid on;
 %
        figure(2);
        plot(t,vvv);     
        title(' Velocity Time History ');
        xlabel(' Time(sec)');
        if(iunit==1)
            ylabel(' Velocity(in/sec)');
        else
            ylabel(' Velocity(m/sec)');          
        end
        grid on;
%        
        figure(3);
        plot(t,amp_original,t,aaa);
        legend ('raw data','synthesis');         
        title(' Acceleration Time History ');
        xlabel(' Time(sec)');
        if(iunit==1)
            ylabel(' Accel(G)');
        else
            ylabel(' Accel(m/sec^2)');          
        end
        grid on;
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 clear disp;
 clear THM; 
 clear aaa;
 clear amp;
 clear amp_original;
 clear ddd;
 clear delay;
 clear error;
 clear f;
 clear fl;
 clear fmax;
 clear freq;
 clear fu;
 clear iunit;
 clear mm;
 clear nfr;
 clear nhs;
 clear nt;
 clear num2;
 clear out1;
 clear p;
 clear residual;
 clear sd;
 clear sr;
 clear t;
 clear tp;
 clear tpi; 
 clear vlast;
 clear vvv;
 clear x1r;
 clear x2r;
 clear x3r;
 clear x4r;
 clear y;
 %
clear aaa;
clear vvv;
clear ddd;
clear mm;
%%%%%%%%%%%%%%%%%%%%%
clear MAX;  
clear MAXP; 
clear aa;   
clear alpha1; 
clear alpha2; 
clear ans;   
clear arg;   
clear ave;   
clear bb;     
clear d;    
clear d1;    
clear d2;   
clear fid;     
clear file_choice;  
clear filename;    
clear i;          
clear ie;              
clear ik;            
clear iscale;        
clear j;             
clear k;              
clear kk;    
clear pathname;     
clear t1;      
clear t2;           
clear te;          
clear tf;              
clear tt;               
clear v;             
clear v1;               
clear v2;  
clear ffmax;
clear ffmin;
clear ans;
clear w;
%