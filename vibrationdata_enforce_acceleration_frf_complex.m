%
%  vibrationdata_enforce_acceleration_frf_complex.m  ver 1.1  by Tom Irvine
%
function[acc_xc,rel_disp_xc,abs_disp_xc]=...
    vibrationdata_enforce_acceleration_frf(mass,stiff,damp,num,nem,ea,fmin,fmax,dtype,freq)
%
nff=num-nem;

%

np=length(freq);

omega=zeros(np,1);
om2=zeros(np,1);

for i=1:np
    omega(i)=2*pi*freq(i);
    om2(i)=omega(i)^2;    
end

%
%  Track changes
%
ijk=nem+1;
ngw=zeros(num,1);
ngw(1:nem)=ea;
for i=1:num
    iflag=0;
    for nv=1:nem
      if(i==ea(nv))
          iflag=1;
      end
    end
    if(iflag==0)
        ngw(ijk)=i;
        ijk=ijk+1;
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
%% disp(' Display partitioned matrices?  1=yes 2=no ');
%% dtype=input(' ');
disp(' ');
disp(' Partitioning Matrices ');
%
etype=1;  % enforced acceleration
[TT,T1,T2,Mwd,Mww,Kwd,Kww]=enforced_partition_matrices(num,ea,mass,stiff,etype,dtype);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
disp(' Calculating eigenvalues ');
if(num<=30)
    [fn,omegan,ModeShapes,MST]=Generalized_Eigen(Kww,Mww,1);
else
    [fn,omegan,ModeShapes,MST]=Generalized_Eigen(Kww,Mww,2);   
end
%

omn2=omegan.^2;
%
N=zeros(nff,np);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
acc_xc=zeros(np,num,nem);
rel_disp_xc=zeros(np,num,nem);
abs_disp_xc=zeros(np,num,nem);
%
for ijk=1:nem
%
    y=zeros(nem,1);
    y(ijk)=1;
%    
    A=-MST*Mwd*y;
%
    for i=1:nff  % dof
        for k=1:np
            N(i,k)=A(i)/(omn2(i)-om2(k) + (1i)*2*damp(i)*omegan(i)*omega(k));
        end
    end
%
    Ud=zeros(nem,np); 
    for i=1:np  % convert acceleration input to displacement
        Ud(ijk,i)=1/(-om2(i));
    end
%
    Uw=ModeShapes*N;
%
    Udw=[Ud; Uw];
%
    U=TT*Udw;
%
%   Fix order
%
    for i=1:num
        for j=1:np   
            acc_xc(j,ngw(i),ijk)=om2(j)*U(i,j);
            rel_disp_xc(j,ngw(i),ijk)=(U(i,j)-Ud(ijk,j));
            abs_disp_xc(j,ngw(i),ijk)=U(i,j);           
        end        
    end
%
end
%