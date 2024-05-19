%
%  env_fds_th2.m  ver 1.3  September 16, 2014
%
function[fds_ref]=env_fds_th2(base,dt,fn,dam,bex,iu,nmetric)
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
        if(nmetric==1) 
            forward=[ b1,  b2,  b3 ];    
            back   =[     1, -a1, -a2 ]; 
            resp=filter(forward,back,base);
        else
            forward=[ rd_b1,  rd_b2,  rd_b3 ];    
            back   =[     1, -rd_a1, -rd_a2 ];
            resp=filter(forward,back,base);
           
            [resp]=differentiate_function(resp,dt);
            
            if(iu==1)
               resp=386*resp;
            end
        end   
%
        for j=1:n_bex
%
            [L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak,D,ac1,ac2,cL]=...
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