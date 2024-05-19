
% fea_transmissibility_core_alt.m  ver 1.1 by Tom Irvine

function[f,acc_trans,rd_trans,acc_max,rd_max,acc_node,rd_node,Ur]=fea_transmissibility_core_alt(f,nff,nem,ModeShapes,MST,...
                             Mwd,damp,omegan,TT,ngw,TZ_tracking_array,node,num_modes)

np=length(f);
 
omega=2*pi*f;
om2=omega.^2;

omn2=omegan.^2;

N=zeros(nff,1);
L=length(TZ_tracking_array);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
y=ones(nem,1);

A=-MST*Mwd*y;
%
acc=zeros(np,1);
rd=zeros(np,1);

Macc=zeros(np,L);
Mrd=zeros(np,L);

nffx=min([nff length(damp) length(omegan) length(om2) num_modes]);

itdomegan=zeros(nffx,1);

for i=1:nffx
    itdomegan(i)=(1i)*2*damp(i)*omegan(i);
end

ij=TZ_tracking_array(node);

progressbar;

for k=1:np  % for each excitation frequency
    
    progressbar(k/np);
    
    for i=1:nffx  % dof
        N(i)=A(i)/(omn2(i)-om2(k) + itdomegan(i)*omega(k));
    end
     
%   convert acceleration to displacement    
    
    Ud=zeros(nem,1);   
    Ud(1:nem)=1/(-om2(k));
%
    Uw=ModeShapes*N;   
    
%    size(ModeShapes)
%    size(N)
%    size(Uw)
    
    Udw=[Ud; Uw];

%
    U=TT*Udw;    
    
    nu=length(U);
    
    if(k==1)
        Ur=zeros(np,nu);
        acc_trans=zeros(np,nu);
        rd_trans=zeros(np,nu);
    end    
    
    for i=1:nu
       Ur(k,ngw(i))=U(i);
       acc_trans(k,ngw(i))=om2(k)*abs(Ur(k,ij));
       rd_trans(k,ngw(i))=abs(Ur(k,ij)-Ud(1));
    end    
    
    acc(k)=om2(k)*abs(Ur(k,ij));
    rd(k)=abs(Ur(k,ij)-Ud(1));
 
    for nv=1:L
        ijk=TZ_tracking_array(nv);
        Macc(k,nv)=om2(k)*abs(Ur(k,ijk));
        Mrd(k,nv)=abs(Ur(k,ijk)-Ud(1));
        node(nv)=ij;
    end

end

MA=Macc;
MD=Mrd;

[~,column,~]=find_max_2d_array(MA);

acc_max=MA(:,column);
acc_node=column;

[~,column,~]=find_max_2d_array(MD);

rd_max=MD(:,column);
rd_node=column;

progressbar(1);

f=fix_size(f);
