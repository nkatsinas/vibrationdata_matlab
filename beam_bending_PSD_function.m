
%   beam_bending_PSD_function.m  ver 1.0  by Tom Irvine

%  Input variables
%
%           fn = natural frequencies
%       omegan = angular natural frequencies
%            C = mode shape parameter
%         part = participation factors
%         beta = mode shape factor
%          cna = distance from neutral axis to outer fiber
%            E = elastic modulus (lbf/in^2)
%          MOI = area moment of inertia (in^4) 
%         mass = mass (lbf sec^2/in)
%            Q = uniform amplification factor
%     base_psd = base input psd with two columns: fn(Hz) & accel(G^2/Hz)
%            x = response location (in) relative to left end
%
%   LBC left boundary condition
%     1 fixed
%     2 pinned
%     3 free
%
%   RBC right boundary condition
%     1 fixed
%     2 pinned
%     3 free

%  Output arrays for location x, two-columns each
%
%       acc_response_psd:  f(Hz) & accel(G^2/Hz)
%        rv_response_psd:  f(Hz) & rel vel((in/sec^2)^2/Hz)
%        rd_response_psd:  f(Hz) & rel disp(inch^2/Hz)
%     shear_response_psd:  f(Hz) & shear(lbf^2/Hz)  
%    moment_response_psd:  f(Hz) & moment((in-lbf)^2/Hz)    
%    stress_response_psd:  f(Hz) & sStress (psi^2/Hz)

function[acc_response_psd,rv_response_psd,rd_response_psd,shear_response_psd,moment_response_psd,stress_response_psd]...
    =beam_bending_PSD_function(fn,C,part,beta,cna,E,MOI,mass,Q,base_psd,x,LBC,RBC)

    I=MOI;

    sq_mass=sqrt(mass); 
   
    THM=base_psd;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    acc_trans
%
    fmax=THM(end,1);

    nf=10000;
    n=length(fn);
    
    damp=zeros(n,1);
    for i=1:n
        damp(i)=1/(2*Q);
    end
%
    f=zeros(nf,1);
    f(1)=0.8*THM(1,1);
    for k=2:nf
        f(k)=f(k-1)*2^(1/48);
        if(f(k)>fmax)
            break;
        end    
    end
   
   iu=1;
   [acc_trans,rv_trans,rd_trans,moment_trans,shear_trans]=...
          beam_bending_trans_core_alt(beta,C,sq_mass,x,iu,LBC,RBC,f,part,fn,damp,E,I);
   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    PSD_in=THM;
%
    [acc_response_psd]=psd_mult_trans(PSD_in,acc_trans);

    sz=size(acc_response_psd);

    fff=acc_response_psd(:,1);

%%%%%%%%%%%%%%

    rv_response_psd=zeros(sz(1),sz(2));
    rv_response_psd(:,1)=fff;

    rd_response_psd=zeros(sz(1),sz(2));
    rd_response_psd(:,1)=fff;

    moment_response_psd=zeros(sz(1),sz(2));
    moment_response_psd(:,1)=fff;

    shear_response_psd=zeros(sz(1),sz(2));
    shear_response_psd(:,1)=fff;

    stress_response_psd=zeros(sz(1),sz(2));
    stress_response_psd(:,1)=fff;

%%%%%%%%%%%%%%

    if( rv_trans(1,2)>1.0e-12 && max(rv_trans(:,2))>=1.0e-12)
        [rv_response_psd]=psd_mult_trans(PSD_in,rv_trans);
    end   

    if( rd_trans(1,2)>1.0e-12 && max(rd_trans(:,2))>=1.0e-12)
        [rd_response_psd]=psd_mult_trans(PSD_in,rd_trans);
    end    
%
    if( shear_trans(1,2)>1.0e-12 && max(shear_trans(:,2))>=1.0e-12)
       [shear_response_psd]=psd_mult_trans(PSD_in,shear_trans);  
    end


    if( moment_trans(1,2)>1.0e-12 && max(moment_trans(:,2))>=1.0e-12)
%  
        [moment_response_psd]=psd_mult_trans(PSD_in,moment_trans);
   
        stress_response_psd(:,1)=        moment_response_psd(:,1);    
        stress_response_psd(:,2)=(cna/I)^2*moment_response_psd(:,2);
    end
end