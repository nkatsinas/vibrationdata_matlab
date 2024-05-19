 
clear comp;

fsweep=flipud(sweep);

qa=[sweep ; fsweep];
qqa=[qa; qa; qa; qa];

n=length(asynth(:,1));
m=length(qqa(:,1));
p=min([m n]);

comp=zeros(p,2);

comp(:,1)=asynth(1:p,1);

for i=1:p
   comp(i,2)=asynth(i,2)+qqa(i,2); 
end    

