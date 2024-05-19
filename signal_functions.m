disp(' ')
disp(' signal_functions.m ')
disp(' ver 1.9  September 20, 2012 ')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
disp(' This program performs post-processing on a time history signal.')  
disp(' ')
%
clear THM;
clear amp;
clear pa;
clear tim;
%
disp(' The time history must be in a two-column matrix format: ')
disp(' Time(sec)  & amplitude ')
disp(' ')    
%
%
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=Excel file ');
file_choice = input('');
%
if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
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
amp=double(THM(:,2));
tim=double(THM(:,1));
%
ichoice=0;
%
tmx=max(tim);
tmi=min(tim);
disp(' ');
% out3 = sprintf(' start  = %g sec    end = %g sec            ',tmi,tmx);
% disp(out3)   
%
    [n] = signal_function_stats(tim,amp);
%
LAST=20;
%
while(ichoice ~= LAST)
%
    disp(' ')
    disp(' Select option ')
    disp(' 1=add constant to time column ')
    disp(' 2=multiply time column by scale factor ')
    disp(' 3=add constant to amplitude column ')
    disp(' 4=multiply amplitude by scale factor ')
    disp(' 5=remove mean ')
    disp(' 6=remove first-order trend ')
    disp(' 7=extract segment ')
    disp(' 8=reverse time history ')
    disp(' 9=linear interpolation ')
    disp(' 10=normalize ')
    disp(' 11=zero pad at start')
    disp(' 12=zero pad at end')
    disp(' 13=sort time history for ascending time')
    disp(' 14=std dev time history')
    disp(' 15=amplitude filter')
    disp(' 16=cubic spline') 
    disp(' 17=fade in or fade out'); 
%
    disp(' 18=view stats & plot time history option')
    disp(' 19=Output Processed Time History File as ASCII text')
    disp(' 20=exit ')
%
    ichoice=input(' ');
    disp(' ')
%
    if(ichoice==1)  % add constant to time column
        c = input(' Enter constant ')
        tim=tim+c;
        disp(' Add constant to time column completed.')
    end
    if(ichoice==2)   % multiply time column by scale factor
        c = input(' Enter scale factor ')
        tim=tim*c;
        disp(' Multiply time column by scale factor completed.')
    end
    if(ichoice==3)   % add constant to amplitude
        c = input(' Enter constant ')
        amp=amp+c;
        disp(' Add constant to amplitude column completed.') 
    end
    if(ichoice==4)   % multiply amplitude
        c = input(' Enter scale factor ')
        amp=amp*c;
        disp(' Multiply amplitude column by scale factor completed.')    
    end
    if(ichoice==5)    % remove mean
        mu=mean(amp);
        amp=amp-mu;
        disp(' Mean removed.')       
    end
    if(ichoice==6)    % remove first-order trend
        amp=detrend(amp);
    end
    if(ichoice==7)    % extract segment
        clear TT;
        clear x;
        [TT,x]=signal_function_extract(tim,amp);
        tim=TT;
        amp=x;
        disp(' Extraction completed.')   
    end
    if(ichoice==8)    % reverse time history
        clear aa;
        clear bb;
%
        sz=size(amp);
        if(sz(2)>sz(1))
            amp=amp';
        end
        bb= flipud(amp);
%            
        amp=bb;
        disp(' Reverse time history completed.')  
    end
    if(ichoice==9)    % linear interpolation
        n=length(tim);
        tmx=max(tim);
        tmi=min(tim);
        dt=(tmx-tmi)/(n-1);
        out4 = sprintf(' Current sample rate  = %8.4g samples/sec \n',1/dt);      
        disp(out4);
        srn= input(' Enter new sample rate (samples/sec) ');
        dt=1./srn;
%        xi = tim(1):dt:tim(n);    This method assumes that the sample rate is already uniform 
%        yi = interp1(x,y,xi);
%
        js=1;
        nnn=fix((tmx-tmi)/dt);
        x = tim; 
        y = amp;    
        xi=zeros(nnn,1);
        yi=zeros(nnn,1);
        for i=1:nnn
            xi(i)=(i-1)*dt+tmi;
            yi(i)=0.;
            for j=js:(n-1)
                if(xi(i)==x(j))
                    yi(i)=y(j);
                    js=j;
                    break;
                end
                if(xi(i)==x(j+1))
                    yi(i)=y(j+1);
                    js=j;
                    break;
                end         
                if(xi(i)>x(j) && xi(i)<x(j+1))
                    d=xi(i)-x(j);
                    ddt=d/(x(j+1)-x(j));
                    c2=ddt;
                    c1=1.-c2;
                    yi(i)=c1*y(j)+c2*y(j+1);
                    js=j;
                    break;
                end                
%               
            end
        end
%
        tim=xi;
        amp=yi;
        disp(' Linear interpolation completed.')     
    end
    if(ichoice==10)    % normalize
        mx=abs(max(amp));
        mi=abs(min(amp));
        if(mi>mx)
            mx=mi;
            amp=amp/mx;
        end
        disp(' Normalization completed.')        
    end
    if(ichoice==11)   % zero pad at start
        disp(' Option to be added in next revision ');
    end
    if(ichoice==12)   % zero pad at end
        n=length(tim);
        tmx=max(tim);
        tmi=min(tim);
        dt=(tmx-tmi)/(n-1);      
        disp(' Enter input option:    ');
	    ioption=input(' 1=duration  2= total number of points ');
        disp(' ')
        if(ioption==1)
            dur=input(' Enter new duration ');
            np=round(dur/dt);
        end
        if(ioption==2)
            np=input(' Enter number of points ');    
        end
        if(ioption==1 || ioption==2)
            npm1=np-1;
            xi= tim(1):dt:(npm1*dt+tim(1));    
            np=length(xi);    
            yi=  zeros(1,np);
            yi(1:n)=amp(1:n);   
            clear tim;
            clear amp;         
            tim=xi;
            amp=yi;
            disp(' Zero padding complete ');
        end
    end
    if(ichoice==13)   % sort time history for ascending time
        q=[tim,amp];
        sortrows(q);
        tim=q(:,1);
        amp=q(:,2);
        disp(' Sort completed.')        
    end
    if(ichoice==14)   % STD DEV time history
%
        tmx=max(tim);
        tmi=min(tim);
        n=length(tim);
%
        dt=(tmx-tmi)/(n-1);
        sr=1./dt;
%
        disp(' ');
        seg=input(' Enter segment duration (sec) ' );
%
        ns=fix(sr*seg);
%
        nnn=fix((tmx-tmi)/seg);
%
        j=1;
        for i=1:nnn
            if((j+ns)>n)
                break;
            end
            clear x;
            x=amp(j:j+ns);   
            sds(i)=std(x);
            av(i)=mean(x);
            tt(i)=(tim(j)+tim(j+ns))/2.;
            j=j+ns;
        end
%
        plot(tt,sds)
        xlabel(' Time (sec)');  
        ylabel(' STD DEV ');  
        grid;
        ymax=max(sds);
        ymax=ymax*1.3;
        ymin=0.;
        axis([tmi tmx ymin ymax]);
        clear tim;
        clear amp;
        tim=tt;
        amp=sds;
%
    end
%    
    if(ichoice==15)
%
         disp(' ');
         upper=input(' Enter upper amplitude limit ' );
%         
         disp(' ');
         lower=input(' Enter lower amplitude limit ' );         
%
         n=length(tim);
         for i=1:n
             if(amp(i)>upper)
                 amp(i)=upper;
             end
             if(amp(i)<lower)
                 amp(i)=lower;
             end
         end
    end
%
    if(ichoice==16)   % cubic spline
        n=length(tim);
        tmx=max(tim);
        tmi=min(tim);
        dt=(tmx-tmi)/(n-1);
        out4 = sprintf(' Current sample rate  = %8.4g samples/sec \n',1/dt);      
        disp(out4);
        srn= input(' Enter new sample rate (samples/sec) ');
        dt=1./srn;        
%
%  tim & amp
%
        clear xx;
        np=fix((tmx-tmi)/dt);
        xx=linspace(0,np*dt,(np+1));
        xx=xx+tmi;
        s_amp=spline(tim,amp,xx);
        s_tim=xx;
% 
        figure(2); 
        plot(tim,amp,'blue',s_tim,s_amp,'red');
        legend ('original','spline');  
        xlabel('Time (sec)'); 
        grid on;
%
        amp=s_amp;
        tim=s_tim;
%
    end
%
    if(ichoice==17)  % fade in or fade out
%        
        disp(' ');
        disp(' Apply fade in?  1=yes  2=no ');
        fin=input(' ');
        if(fin==1)
            perc=input(' Enter percent ');
            clear length;
            n=length(amp);
            nn=round(n*perc/100);
            for i=1:nn
                amp(i)=amp(i)*(i-1)/nn;
            end
        end    
%
        disp(' ');
        disp(' Apply fade out?  1=yes  2=no ');
        fout=input(' ');
        if(fout==1)
            perc=input(' Enter percent '); 
            nn=round(n*perc/100);
            ns=n-nn;
            j=0;
            for i=ns:n
                amp(i)=amp(i)*(1-(j/nn));
                j=j+1;
            end
            amp(n)=0.;
        end            
%
    end
%
    if(ichoice==18)   % stats
        [n] = signal_function_stats(tim,amp);
    end  
    if(ichoice==19)   % Output file  
%
        [writefname, writepname] = uiputfile('*.dat','Save time history as');
	    writepfname = fullfile(writepname, writefname);
        ss=size(tim);
        if(ss(1)<ss(2))
	        writedata = [tim' amp'];
        else
 	        writedata = [tim amp];         
        end  
	    fid = fopen(writepfname,'w');
	    fprintf(fid,'  %g     %g\n',writedata');
	    fclose(fid);
        break;
%    
%   disp(' Enter output filename ');
% TH_filename = input(' ','s');
%
%  fid = fopen(TH_filename,'w');
%   for i=1:nn
%        fprintf(fid,'%12.5f %10.3f \n',tt(i),a_resp(i));
%   end
%   fclose(fid);
%    
    end
%    
    if(ichoice==LAST)   % exit
        break;
    end
%
end
%
ss=size(tim);
if(ss(2)>ss(1))
    tim=tim';
end
%
ss=size(amp);
if(ss(2)>ss(1))
    amp=amp';
end
%
    signal_post  = [tim amp];         
%
out5 = sprintf('\n The time history is renamed as "signal_post" for Matlab use. \n');
disp(out5);      