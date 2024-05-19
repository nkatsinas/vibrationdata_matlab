%
%   simple_white_noise_LPF_segments.m  ver 1.0  by Tom Irvine
%

clear output_array;
clear white_arary;
clear ss;

mu=0;
sigma=1;
dur=30;

f=1000;
sr=12*f;
dt=1/sr;
nt=floor(dur/dt);

disp(' ');
kv=input(' Enter number of segments ');
disp(' ');

t=zeros(nt,1);

for i=1:nt
    t(i)=dt*(i-1);
end


progressbar;

for i=1:kv
    
    
    progressbar(i/kv);

    X=randn(nt,1);
    X=fix_size(X);
%

    [X]=simple_Butterworth_LP_filter_function(X,dt,f);

    X=X-mean(X);
    X=X*sigma/std(X);
    X=X+mu;    
    
    aaa=[t X];
 
    output_array{i}=sprintf('white%d_%d',dur,i);
    assignin('base', output_array{i}, aaa);
    
    out2=sprintf('%s',output_array{i});
    ss{i}=out2; 
end


assignin('base', 'white_array', ss');

white_array






