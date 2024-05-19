
tic

exp=8

%% x=random(:,1);
%% y=random(:,2);

x=synth_response(:,1);
y=synth_response(:,2);

[c,hist,edges,rmm,idx] = rainflow(y,x);
%  T = array2table(c,'VariableNames',{'Count','Range','Mean','Start','End'});
sz=size(c);
damage=0;
for i=1:sz(1)
    damage=damage+c(i,1)*(c(i,2)/2)^exp;
end    
damage
toc