%
%
disp(' ');
THM = input(' Enter amp-cycle array name  ');
%
nbins=input(' Enter the number of bins ');

scf=input(' Enter scf ');

THM(:,1)=scf*THM(:,1)/1000;

sz=size(THM);

maxS=max(THM(:,1));
minS=0;

stress=THM(:,1);
ncycles=THM(:,2);

delta_S=maxS/nbins;

%% delta_S=0.3691;
%% nbins=400;

hist=zeros(nbins,2);

out1=sprintf('\n delta_S=%8.4g   maxS=%8.4g  ',delta_S,maxS);
disp(out1);

%%%%%%%

s1=zeros(nbins,1);
s2=zeros(nbins,1);

for j=1:nbins
   
    s1(j)=(j-1)*delta_S;
    s2(j)=s1(j)+delta_S;
    
    hist(j,1)=mean([s1(j) s2(j)]);
        
end        

%%%%%%%

for i=1:sz(1)

    for j=1:nbins
        
        if( stress(i)>=s1(j) && stress(i)<=s2(j))
            hist(j,2)=hist(j,2)+ncycles(i);
            break;
        end    
        
    end    

end

%%%%%%%

while(1)
   [M,I] = min(hist(:,2));
   
   if(M>0)
      break;
   else
      hist(I,:)=[]; 
   end
end

hist(:,2)=hist(:,2)/delta_S;

figure(1234)
plot(  hist(:,1) , hist(:,2) );
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log')
grid on;

sum(hist(:,2))
