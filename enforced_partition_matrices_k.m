%
%   enforced_partition_matrices_k.m  ver 1.2  May 13, 2015
%
%  etype =1  enforced acceleration
%         2  enforced displacement
%
%
function[TT,T1,T2,Mwd,Mww,Kwd,Kww,Kff,Kfd]=...
                 enforced_partition_matrices_k(num,ea,mass,stiff,etype,dtype)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Partition Mass & Stiffness Matrices
%
%%%%%%%%%%%%%%%%%%%%% Mdd Kdd %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

nem=length(ea);
nff=num-nem;

out1=sprintf(' num=%d  nem=%d  nff=%d ',num,nem,nff);
disp(out1);

%
ic=1;
for i=1:num
   iflag=0;          
   for nv=1:nem
      if(i==ea(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==1)
      jc=1;      
      for j=1:num
          jflag=0;
          for nv=1:nem
             if(j==ea(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==1)             
             Mdd(ic,jc)=mass(i,j);
             Kdd(ic,jc)=stiff(i,j);
             jc=jc+1;
          end
      end
   end
   if(iflag==1)
       ic=ic+1;
   end
end
%
%%%%%%%%%%%%%%%%%%%%% Mdf Kdf %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for i=1:num
   iflag=0;          
   for nv=1:nem
      if(i==ea(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==1)
      jc=1;      
      for j=1:num
          jflag=0;
          for nv=1:nem
             if(j==ea(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==0)            
             Mdf(ic,jc)=mass(i,j);
             Kdf(ic,jc)=stiff(i,j);
             jc=jc+1;
          end
      end
   end
   if(iflag==1)
       ic=ic+1;
   end
end
%
%%%%%%%%%%%%%%%%%%%%% Mfd Kfd %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for i=1:num
   iflag=0;          
   for nv=1:nem
      if(i==ea(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==0)
      jc=1;      
      for j=1:num
          jflag=0;
          for nv=1:nem
             if(j==ea(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==1)             
             Mfd(ic,jc)=mass(i,j);
             Kfd(ic,jc)=stiff(i,j);
             jc=jc+1;
          end
      end
   end
   if(iflag==0)
       ic=ic+1;
   end
end
%
%%%%%%%%%%%%%%%%%%%%%%% Mff Kff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for i=1:num
   iflag=0;          
   for nv=1:nem
      if(i==ea(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==0)
      jc=1;      
      for j=1:num
          jflag=0;
          for nv=1:nem
             if(j==ea(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==0)     
             Mff(ic,jc)=mass(i,j);
             Kff(ic,jc)=stiff(i,j);
             jc=jc+1;
          end
      end
   end
   if(iflag==0)
       ic=ic+1;
   end
end
%
I=eye(nem,nem);
T2=eye(nff,nff);
%

out1=sprintf(' etype=%d \n',etype);
disp(out1);

if(etype==1)
    if(dtype==1)
        Kff
    end    
    invKff=pinv(Kff);
    if(dtype==1)
        invKff
    end    
    T1=-invKff*Kfd;
    if(dtype==1)
        T1
    end    
else
    invMff=pinv(Mff);
    T1=-invMff*Mfd;    
end    
%
TT=zeros(num,num);
%
TT(1:nem,1:nem)=I;

%% disp('***');
%% size(TT)
%% size(T1)
%% nem
%% num

TT(nem+1:num,1:nem)=T1;
TT(nem+1:num,nem+1:num)=T2;
%
MP=zeros(num,num);
MP(1:nem,1:nem)=Mdd;
MP(1:nem,nem+1:num)=Mdf;
MP(nem+1:num,1:nem)=Mfd;
MP(nem+1:num,nem+1:num)=Mff;
%
KP=zeros(num,num);
KP(1:nem,1:nem)=Kdd;
KP(1:nem,nem+1:num)=Kdf;
KP(nem+1:num,1:nem)=Kfd;
KP(nem+1:num,nem+1:num)=Kff;
%
MT=TT'*MP*TT;
%
KT=TT'*KP*TT;
%
Mwd=MT(nem+1:num,1:nem);
Kwd=KT(nem+1:num,1:nem);
Mww=MT(nem+1:num,nem+1:num);
Kww=KT(nem+1:num,nem+1:num);
%
if(dtype==1)
   TT 
   MT
   KT
   Mwd
   Kwd
   Mww
   Kww
end