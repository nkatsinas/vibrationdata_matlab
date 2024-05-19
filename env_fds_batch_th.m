%
%  env_fds_batch_th.m  ver 1.5  by Tom Irvine
%
function[xfds]=env_fds_batch_th(accel_th,fn,Q,bex)

dt=mean(diff(accel_th(:,1)));
%
n=length(Q);

nnn=length(fn);

xfds=zeros(nnn,n);

dQ=unique(Q);
ndQ=length(dQ);
dbex=unique(bex);
ndbex=length(dbex);

progressbar;

for ijk=1:nnn

    progressbar(ijk/nnn);
    
    for i=1:ndQ
      
            damp=1/(2*dQ(i));
       
            [a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(fn(ijk),damp,dt);

            accel_resp=filter([ b1,  b2,  b3 ],[  1, -a1, -a2 ],accel_th(:,2));

            c=rainflow(accel_resp);

            cycles=c(:,1);
            amp=c(:,2)/2;
            
            for j=1:ndbex
                b=dbex(j);
                d=sum( cycles.*amp.^b );
            
                for nv=1:n
                    if(Q(nv)==dQ(i) && bex(nv)==dbex(j)) 
                        xfds(ijk,nv)=d;
                        break;
                    end
                end
    
            end % bex
    end % Q
  
end  % fn

progressbar(1);
pause(0.2);