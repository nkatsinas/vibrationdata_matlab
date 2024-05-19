%
%   sine_sweep_synth_function.m  ver 1.0  by Tom Irvine
%
%   The sine_sweep_synth array stores the amplitude at each time step
%

function[sine_sweep_synth]=sine_sweep_synth_function(sine_sweep,rate,t)

    num=length(t);
    dur=t(num)-t(1);

    f1=sine_sweep(:,1);
    f2=sine_sweep(:,2);    
    amp=sine_sweep(:,3);
    tpi=2*pi;
%
    number_sweeps=length(f1);

    sine_sweep_synth=zeros(num,1);
%
    for i=1:number_sweeps
          
        fstart=f1(i);
        fend=f2(i);
        df=fend-fstart;
        
        if(contains(rate,'lin'))
%           disp('linear sweep')
            fmax=0.5*df+fstart;
            freq=linspace(fstart,fmax,num);   
            freq=fix_size(freq);
            arg=tpi*freq.*t(1:num);
        else
%            disp('log sweep')
            arg=zeros(num,1);
            oct=log(fend/fstart)/log(2);
            rrr=oct/dur;   
            for j=1:num
                arg(j)=-1.+2^(rrr*t(j));
            end              
            arg=tpi*fstart*arg/(rrr*log(2));  
        end
        
        aa=fix_size(amp(i)*sin(arg));        
        
        sine_sweep_synth=sine_sweep_synth+aa;
    
    end