
%  matlab_direct_rainflow.m  ver 1.0  by Tom Irvine

function[B,aamax]=matlab_direct_rainflow(y)

%
m=length(y)-1;
a=zeros(m,1);
t=zeros(m,1);
a(1)=y(1);
t(1)=1;
k=2;
%
out1=sprintf(' total input points =%d ',m);
disp(out1)

%
disp(' Begin slope calculation ')
%
slope1=(  y(2)-y(1));
for i=2:m
     slope2=(y(i+1)-y(i));
     if((slope1*slope2)<=0 && abs(slope1) >0.)
          a(k)=y(i);
          t(k)=i;
          k=k+1;
     end
     slope1=slope2;
end
%

a(k)=y(m+1);
t(k)=t(k-1)+1;
k=k+1;
%

%% disp(' ');
%% for i=1:length(t)
%%     out1=sprintf('%8.4g %8.4g',t(i),a(i));
%%     disp(out1);
%% end
%


disp(' End slope calculation ')
%
clear temp;
temp(1:k-1)=a(1:k-1);
clear a;
a=temp;
%
clear temp;
temp(1:k-1)=t(1:k-1);
clear t;
t=temp;
%
clear aa;

a=fix_size(a);
t=fix_size(t);

%
aa=[t a];
%
% num=round(max(a)-min(a))+1;
%
i=1;
j=2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Rules for this method are as follows: let X denote
%   range under consideration; Y, previous range adjacent to X; and
%   S, starting point in the history.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
progressbar % Create figure and set starting time 
%
clear B;
aamax=0;
B=zeros(m,4);
kv=1;
msa_orig=max(size(aa));
while(1)
    msa=max(size(aa));
    progressbar(1-msa/msa_orig) % Update figure   
%
    if((j+1)>msa)
        break;
    end
    if((i+1)>=msa)
        break;
    end
%
    Y=(abs(aa(i,2)-aa(i+1,2)));
    X=(abs(aa(j,2)-aa(j+1,2)));
%
    if(X>=Y && Y>0)
        if(i==1)
           B(kv,2)=0.5;
           am=[aa(i,2) aa(i+1,2)];
           B(kv,3)=am(1);
           B(kv,4)=am(2);         
           aa(1,:)=[];
        else 
           B(kv,2)=1;
           am=[aa(i,2) aa(i+1,2)];
           B(kv,3)=am(1);
           B(kv,4)=am(2); 
           aa(i+1,:)=[]; 
           aa(i,:)=[];
        end
        B(kv,1)=Y;
%%        
%%        out1=sprintf(' %8.4g  %8.4g  %8.4g  %8.4g ',B(kv,1),B(kv,2),B(kv,3),B(kv,4));
%%        disp(out1);
%%        
        if(Y>aamax)
            p1=aa(i,2);
            p2=aa(i+1,2);
            tp1=aa(i,1);
            tp2=aa(i+1,1);        
            aamax=Y;
        end
        kv=kv+1; 
        i=1;
        j=2;        
    else
        i=i+1;
        j=j+1;
    end
%
end
progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Count each range that has not been previously counted
%  as one-half cycle.
%
N=max(size(aa));
disp(' ');
for i=1:N-1 
    Y=(abs(aa(i,2)-aa(i+1,2)));
%   
    if(Y>0)
        B(kv,1)=Y; 
        B(kv,2)=0.5;
        am=[aa(i,2) aa(i+1,2)];
        B(kv,3)=am(1);
        B(kv,4)=am(2);   
%%        
%%        out1=sprintf('* %8.4g  %8.4g  %8.4g  %8.4g ',B(kv,1),B(kv,2),B(kv,3),B(kv,4));
%%        disp(out1);
%%        
        if(Y>aamax)
            p1=aa(i,2);
            p2=aa(i+1,2);
            tp1=aa(i,1);
            tp2=aa(i+1,1);           
            aamax=Y;
        end      
        kv=kv+1;
    end
end
%
% amax=max(y)-min(y);
%



B=B(1:(kv-1),:);