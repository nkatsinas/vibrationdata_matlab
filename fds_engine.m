
% fds_engine.m  ver 1.1  by Tom Irvine

function[fds_th]=fds_engine(fds_th,yy,nf,nQ,Q,nbex,bex,fn,dt)

if(isempty(yy))
    warndlg('fds_engine:  yy empty');    
    return;
end

progressbar;
    
    for j=1:nf
        
        progressbar(j/nf);
        
        ijk=1;
        
        for k=1:nQ
            
            damp=1/(2*Q(k));
            
            [a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(fn(j),damp,dt); 
             
            [y,~,~]=arbit_engine_accel(a1,a2,b1,b2,b3,yy);
        
% 
            
            if(license('test','Signal_Toolbox')==0 ||  verLessThan('matlab','9.3'))
   
                dchoice=-1.; % needs to be double
                exponent=1;                
                
                [L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak,D,ac1,ac2,amean,amax,amin,cL]...
                                         =rainflow_mean_max_min_mex(y,dchoice,exponent);
                ac1=fix_size(ac1);
                ac2=fix_size(ac2);
                ncL=int64(cL);    
                
            else

                try
                    [c,~,~,~,~] = rainflow(y);
                catch
                    warndlg('fds_engine: rainflow failed');
                    return;
                end
          
                ac1=c(:,2)/2;
                ac2=c(:,1);
                ncL=length(ac1);

            end
                
                     
%
%            amp_cycles=[ ac1(1:ncL) ac2(1:ncL) ];
                        
            for iv=1:nbex 
                
               d=0; 
                
               for nv=1:ncL
                  d=d+ac1(nv)^bex(iv)*ac2(nv);
               end
               
               fds_th(j,ijk)=fds_th(j,ijk)+d;
               
               ijk=ijk+1;
               
            end
                       
        end
        
    end
    progressbar(1);
