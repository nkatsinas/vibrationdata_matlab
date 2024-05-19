%
%  enforced_motion_modal_transient_engine_fea_beam.m  ver 1.2  by Tom Irvine
%

function[aa,dd]=enforced_motion_modal_transient_engine_fea_beam(FP,a1,a2,df1,df2,df3,...
                                    vf1,vf2,vf3,af1,af2,af3,nt,num_modes,Q,retdof)
%
nx=zeros(nt,num_modes);
%% nv=zeros(nt,num_modes);
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
%%    v_forward=[   vf1(j),  vf2(j), vf3(j) ];
%%    v_back   =[     1, -a1(j), -a2(j) ];
%%    v_resp=filter(v_forward,v_back,amodal);
%    
%  acceleration
%   
    a_forward=[   af1(j),  af2(j), af3(j) ];
    a_back   =[     1, -a1(j), -a2(j) ]; 
    a_resp=filter(a_forward,a_back,amodal);
%
    nx(:,j)=d_resp;  % displacement
    na(:,j)=a_resp;  % acceleration  
%
end
%
clear d_resp;
clear a_resp;
%
disp(' Calculate d');

sz=size(Q);

d=zeros(sz(1),1);
dd=zeros(nt,1);

for i=1:nt
    d(:)=(Q*(nx(i,:))');
    dd(i)=d(retdof);
end

clear nx;
clear d;

%%%%

disp(' Calculate a');

a=zeros(sz(1),1);
aa=zeros(nt,1);

for i=1:nt
    a(:)=(Q*(na(i,:))');
    aa(i)=a(retdof);
end

clear nx;
clear d;
