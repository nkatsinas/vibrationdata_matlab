%
%  enforced_motion_modal_transient_engine.m  ver 1.0  by Tom Irvine
%

function[a,v,d]=enforced_motion_modal_transient_engine(FP,a1,a2,df1,df2,df3,...
                                    vf1,vf2,vf3,af1,af2,af3,nt,num_modes,Q)
%
nx=zeros(nt,num_modes);
nv=zeros(nt,num_modes);
na=zeros(nt,num_modes);

for j=1:num_modes
%
    amodal=FP(j,:);
%
%  displacement
%
    d_forward=[   df1(j),  df2(j), df3(j) ];
    d_back   =[     1, -a1(j), -a2(j) ];
    d_resp=filter(d_forward,d_back,amodal);
%    
%  velocity
%
    v_forward=[   vf1(j),  vf2(j), vf3(j) ];
    v_back   =[     1, -a1(j), -a2(j) ];
    v_resp=filter(v_forward,v_back,amodal);
%    
%  acceleration
%   
    a_forward=[   af1(j),  af2(j), af3(j) ];
    a_back   =[     1, -a1(j), -a2(j) ]; 
    a_resp=filter(a_forward,a_back,amodal);
%
    nx(:,j)=d_resp;  % displacement
    nv(:,j)=v_resp;  % velocity
    na(:,j)=a_resp;  % acceleration  
%
end
%
clear d_resp;
clear v_resp;
clear a_resp;
%
disp(' Calculate d');
d=zeros(nt,num_modes);


size(d)
size(Q)
size(nx)

for i=1:nt
      d(i,:)=(Q*(nx(i,:))')';  
end
clear nx;
%
disp(' Calculate v');
v=zeros(nt,num_modes);
for i=1:nt
      v(i,:)=(Q*(nv(i,:))')';
end
clear nv;
%
disp(' Calculate a');
a=zeros(nt,num_modes);
for i=1:nt
    a(i,:)=(Q*(na(i,:))')';    
end
clear na;
