%
%  enforced_motion_modal_transient_engine_fea_beam_alt.m  ver 1.2  by Tom Irvine
%

function[na,nx]=enforced_motion_modal_transient_engine_fea_beam_alt(FP,a1,a2,df1,df2,df3,...
                                    vf1,vf2,vf3,af1,af2,af3,nt,num_modes,Q)
%
nx=zeros(nt,num_modes);
%% nv=zeros(nt,num_modes);
na=zeros(nt,num_modes);

progressbar;
for j=1:num_modes
    progressbar(j/num_modes);
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
progressbar(1)
