
%  beam_partition.m  ver 1.1  by Tom Irvine


function[mass,stiff,nem,num,nff,ea,ngw,dof,mid_dof]=beam_partition(BC,mass,stiff)

mid_dof=0;

if(BC==1) % fixed-free

    mass(2,:)=[];
    mass(:,2)=[];

    stiff(2,:)=[];
    stiff(:,2)=[];

    nem=1;  % number of dof with enforced accel
%    
    ea(1)=1; 
end

if(BC==2) % pinned-pinned

    nem=2;  % number of dof with enforced accel
%    
    sz=size(mass);
    
    nq=sz(1);

    ea(1)=1;
    ea(2)=nq-1;
    
end 

if(BC==3) % fixed-fixed
    
    nem=2;
    
    sz=size(mass);
    nk=sz(1);
    
    mass(nk,:)=[];
    mass(:,nk)=[];

    stiff(nk,:)=[];
    stiff(:,nk)=[];    

    mass(2,:)=[];
    mass(:,2)=[];

    stiff(2,:)=[];
    stiff(:,2)=[];

    sz=size(mass);
    nq=sz(1);

    ea(1)=1;
    ea(2)=nq;    
%    
end
    
if(BC==4) % fixed-pinned
    
    nem=2;
    
    mass(2,:)=[];
    mass(:,2)=[];

    stiff(2,:)=[];
    stiff(:,2)=[];

    sz=size(mass);
    nq=sz(1);

    ea(1)=1;
    ea(2)=nq-1;    
%    
end
        
sz=size(mass);

dof=sz(1);

num=dof;

nff=num-nem;

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
