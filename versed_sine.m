disp(' ')
disp(' versed_sine.m  version 1.0    December 19, 2008 ')
disp(' By Tom Irvine   Email:  tomirvine@aol.com ')
disp(' ')
disp(' This program calculates the response of')
disp(' a single-degree-of-freedom system subjected')
disp(' to a versed sine base input shock.')
disp(' ')
disp(' Assume zero initial displacement and zero initial velocity.')
%
clear fnn;
clear fn;
%
clear srsp;  
clear srsn;
%
clear amax;
clear amin;
%
clear acc;
clear rd;
%
tpi=2.*pi;
%
disp(' ');
disp(' Select analysis ');
iopt = input('  1=time history response  2=SRS  ');
%
disp(' ');
amp = input('  Enter the amplitude (G) ');
%
dur = input('  Enter the duration (seconds) ');
%
disp(' ');
if(iopt==1)
   fn = input('  Enter the natural frequency (Hz) '); 
else
   fn = input('  Enter the starting frequency (Hz) ');   
end
%
Q = input('  Enter amplification factor Q ');
damp=1./(2.*Q);
%
if(iopt==1)
    limit=1;
else
    limit=200;
end
%
dt2 = dur/32.;
%
%%%%%
omega = 2.*pi/dur;
omega2= omega^2.;
%
if(iopt==2)
   disp(' ');
   disp('   Natural  ');
   disp('   Freq(Hz)   POS SRS(G)   NEG SRS(G)');
end
for(ijk=1:limit)
%	
		if(fn> (50/dur))
			break;
        end
%
		dt = 1./(40.*fn);
%	
		if(dt>dt2)
            dt=dt2;
        end 
        if(iopt==1)   
		    nt = 8.*( ( (1./fn) + dur) /dt );
        else
      		nt = 1.*( ( (1./fn) + dur) /dt );      
        end
%
		omegan=tpi*fn;
%
		omegad = omegan*sqrt(1.- (damp^2.));
%	
		rd_initial = 0.;
		rv_initial = 0.;
%
		omegan2=omegan^2.;
		omegad2=omegad^2.;
%
		domegan=damp*omegan;
%
		amax=-1.0e+12;
		amin=+1.0e+12;
%
        [amax,amin,acc,rd,rv,TT,yb,ain]=versed_time_calc(rd_initial,rv_initial,domegan,omegad,damp,omega,omegan,omega2,omegan2,nt,dt,dur,amp,amax,amin);
%
        if(iopt==2)
            fnn(ijk)=fn;
%
            srsp(ijk)=amax;  
            srsn(ijk)=abs(amin);            
%
 		    out1 = sprintf(' %10.2f  %10.4g  %10.4g ',fn,srsp(ijk),srsn(ijk));    
            disp(out1);            
%            
     	    fn=fn*(2.^(1./12.));       
        end
end
%    
if( iopt==1)
		out1 = sprintf('\n\n maximum acceleration = %12.4g G',amax);
		    out2 = sprintf(' minimum acceleration = %12.4g G',amin);
 %       
        disp(out1);
        disp(out2);
 %
        disp(' ');  
        disp(' Plot the acceleration response time history ?');
        choice = input(' 1=yes  2= no  ');
        if(choice==1)
            figure(1);   
            plot(TT,acc,TT,ain);
            legend ('response','input');         
            xlabel('Time (sec)');  
            ylabel('Accel (G)');    
            grid;
            set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','lin'); 
            out5 = sprintf(' SDOF Response, fn=%g Hz, Q=%g,    %g G, %g sec Versed-sineBase Input  ',fn,Q,amp,dur);
            title(out5);         
        end    
%
		out1 = sprintf('\n\n maximum relative disp = %12.4g inch',max(rd)*386.);
		    out2 = sprintf(' minimum relative disp = %12.4g inch ',min(rd)*386.);
        disp(out1);
        disp(out2);
%
		out1 = sprintf('\n maximum relative disp = %12.4g mm',max(rd)*386.*25.4);
		    out2 = sprintf(' minimum relative disp = %12.4g mm \n',min(rd)*386.*25.4);
        disp(out1);
        disp(out2);
%
        disp(' ');  
        disp(' Plot the relative displacement time history ?');
        choice = input(' 1=yes  2= no  ');
        if(choice==1)
            figure(2); 
            rd=rd*386.*1000.;
            plot(TT,rd);
            xlabel('Time (sec)');  
            ylabel('Relative Disp (Mils)');    
            grid;
            set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','lin'); 
            out5 = sprintf(' SDOF Response, fn=%g Hz, Q=%g,    %g G, %g sec Versed-sine Base Input  ',fn,Q,amp,dur);
            title(out5);         
        end            
else
    disp(' ');
    disp(' Plot SRS ?');
    choice = input(' 1=yes  2= no  ');
    if(choice==1)       
        plot(fnn,srsp,fnn,srsn,'-.');   
        out5 = sprintf(' SRS Q=%g    %g G, %g sec Versed-sine Base Input  ',Q,amp,dur);
        title(out5);
        grid;
        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
        legend ('positive','negative'); 
        ylabel('Peak Accel (G)');
        xlabel('Natural Frequency (Hz)');
    end
end
%
if(iopt==1)
    disp(' ');
    disp(' Show animation ?');
    achoice = input(' 1=yes  2= no  ');
    if(achoice==1) 
        plot_title = sprintf(' SDOF Response, fn=%g Hz, Q=%g,    %g G, %g sec Versed-sine Base Input  ',fn,Q,amp,dur);        
        n=length(TT);
        nn=round(n/3);
        TT_an=TT(1:nn);
        yb_an=yb(1:nn);
        acc_an=acc(1:nn);
        SDOF_base_animation_function(TT_an,yb_an,acc_an,plot_title)
    end
end