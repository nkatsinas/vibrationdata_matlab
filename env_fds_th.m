%
%  env_fds_th.m  ver 1.1  December 6, 2013
%
function[fds_ref]=env_fds_th(base,dt,fn,dam,bex)
%
n_dam=length(dam);
n_bex=length(bex);
n_ref=length(fn);
%
fds_ref=zeros(n_dam,n_bex,n_ref);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
dchoice=1.;  % needs to be double 
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
        forward=[ b1,  b2,  b3 ];    
        back   =[     1, -a1, -a2 ];    
%    
        resp=filter(forward,back,base);
%
        for j=1:n_bex
%
            [L,C,AverageAmp,MaxAmp,AverageMean,MinValley,MaxPeak,D]=...
                                         rainflow_mex(resp,dchoice,bex(j));
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