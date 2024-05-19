%
%  env_fds_batch_th_nop.m  ver 1.5  by Tom Irvine
%
function[xfds]=env_fds_batch_th_nop(accel_th,fn,Q,bex,dt)

%
n=length(Q);

nnn=length(fn);

xfds=zeros(nnn,n);

dQ=unique(Q);
ndQ=length(dQ);
dbex=unique(bex);
ndbex=length(dbex);


for ijk=1:nnn

    for i=1:ndQ
      
            damp=1/(2*dQ(i));
       
            [a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(fn(ijk),damp,dt);

            c=rainflow( filter([ b1,  b2,  b3 ],[  1, -a1, -a2 ],accel_th(:,2))  );

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
