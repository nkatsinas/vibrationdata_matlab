%
%  env_fds_th_sine.m  ver 1.2  September 16, 2014
%
function[fds_ref]=env_fds_th_sine(base,dt,fn,dam,bex,iu,nmetric)
%
n_dam=length(dam);
n_bex=length(bex);
n_ref=length(fn);
%
fds_ref=zeros(n_dam,n_bex,n_ref);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
total=n_dam*n_ref*n_bex;
%
ijk=1;
%
progressbar;
%
for i=1:n_dam
    for k=1:n_ref
%
       [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                            srs_coefficients(fn(k),dam(i),dt);
%
        if(nmetric==1) 
            forward=[ b1,  b2,  b3 ];    
            back   =[     1, -a1, -a2 ]; 
            y=filter(forward,back,base);
        else
            forward=[ rd_b1,  rd_b2,  rd_b3 ];    
            back   =[     1, -rd_a1, -rd_a2 ];
            y=filter(forward,back,base);
            
           [y]=differentiate_function(y,dt);
            
            if(iu==1)
               y=386*y;
            end
        end   
%
        for j=1:n_bex
%
%
%    disp(' Begin slope calculation ')
%
            clear a;
            kv=1;     
            m=length(y)-1;
            slope1=(  y(2)-y(1));
            for ib=2:m
                slope2=(y(ib+1)-y(ib));
                if((slope1*slope2)<=0)
                    a(kv)=y(ib);
                    kv=kv+1;
                end
                slope1=slope2;
            end
%
            a(kv)=y(m+1);
            kv=kv+1;
%
%    disp(' End slope calculation ')
%
            clear temp;
            temp(1:kv-1)=a(1:kv-1);
            clear a;
            a=temp;
%
%
            p=length(a);
%
            D=0;
            for iv=2:p
                amp=0.5*abs(a(iv)-a(iv-1));
                D=D+0.5*amp^bex(j);
            end             
%
            fds_ref(i,j,k)=D;
%
            progressbar(ijk/total);
            ijk=ijk+1;
%
        end                           
%
    end
%
end    
%
progressbar(1);
pause(0.5);