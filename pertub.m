
  FS='wt2';
  wavetable=evalin('base',FS);  
  freq=wavetable(:,3);
  amp=wavetable(:,2);

  n=length(freq);

  delta=0.04;
  c=1-delta;
  d=1+delta;

  a=zeros(n,1);

  for i=1:n
      a(i)=amp(i)*(c+d*rand());
  end    

  % synthesize time history;

  f=freq;
  amp=a;
  NHS=wavetable(:,4);
  td=wavetable(:,5);

  delay=0;
  vscale=386;
  dscale=386;
  dur=0.2;
  sr=100000;

  [t,dispx,velox,accel]=...
         wavelet_reconstruction_function(sr,f,amp,NHS,td,dur,vscale,dscale,delay);

  % srs

  % substitute srs
 
  % solve for amp

  % synthesize time history

  % srs

  % hopefully better