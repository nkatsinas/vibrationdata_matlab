
sz=size(s_band_RF_converter_qtp_profile_1_1_inplane_1_fds_Q10_b4);
fn=s_band_RF_converter_qtp_profile_1_1_inplane_1_fds_Q10_b4(:,1);

n=sz(1);

s_band_RF_converter_qtp_damage_oop_Q10_b4=zeros(n,2);
s_band_RF_converter_qtp_damage_oop_Q10_b8=zeros(n,2);
s_band_RF_converter_qtp_damage_oop_Q30_b4=zeros(n,2);
s_band_RF_converter_qtp_damage_oop_Q30_b8=zeros(n,2);

s_band_RF_converter_qtp_damage_oop_Q10_b4(:,1)=fn;
s_band_RF_converter_qtp_damage_oop_Q10_b8(:,1)=fn;
s_band_RF_converter_qtp_damage_oop_Q30_b4(:,1)=fn;
s_band_RF_converter_qtp_damage_oop_Q30_b8(:,1)=fn;


for i=1:n
    s_band_RF_converter_qtp_damage_oop_Q10_b4(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_oop_fds_Q10_b4(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_oop_fds_Q10_b4(i,2);
                                              
    s_band_RF_converter_qtp_damage_oop_Q10_b8(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_oop_fds_Q10_b8(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_oop_fds_Q10_b8(i,2);
                                             
    s_band_RF_converter_qtp_damage_oop_Q30_b4(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_oop_fds_Q30_b4(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_oop_fds_Q30_b4(i,2);
                                              
    s_band_RF_converter_qtp_damage_oop_Q30_b8(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_oop_fds_Q30_b8(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_oop_fds_Q30_b8(i,2);                                              
                                              
end

s_band_RF_converter_qtp_damage_inplane_1_Q10_b4=zeros(n,2);
s_band_RF_converter_qtp_damage_inplane_1_Q10_b8=zeros(n,2);
s_band_RF_converter_qtp_damage_inplane_1_Q30_b4=zeros(n,2);
s_band_RF_converter_qtp_damage_inplane_1_Q30_b8=zeros(n,2);

s_band_RF_converter_qtp_damage_inplane_1_Q10_b4(:,1)=fn;
s_band_RF_converter_qtp_damage_inplane_1_Q10_b8(:,1)=fn;
s_band_RF_converter_qtp_damage_inplane_1_Q30_b4(:,1)=fn;
s_band_RF_converter_qtp_damage_inplane_1_Q30_b8(:,1)=fn;


for i=1:n
    s_band_RF_converter_qtp_damage_inplane_1_Q10_b4(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_inplane_1_fds_Q10_b4(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_inplane_1_fds_Q10_b4(i,2);
                                              
    s_band_RF_converter_qtp_damage_inplane_1_Q10_b8(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_inplane_1_fds_Q10_b8(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_inplane_1_fds_Q10_b8(i,2);
                                             
    s_band_RF_converter_qtp_damage_inplane_1_Q30_b4(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_inplane_1_fds_Q30_b4(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_inplane_1_fds_Q30_b4(i,2);
                                              
    s_band_RF_converter_qtp_damage_inplane_1_Q30_b8(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_inplane_1_fds_Q30_b8(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_inplane_1_fds_Q30_b8(i,2);                                              
end

s_band_RF_converter_qtp_damage_inplane_2_Q10_b4=zeros(n,2);
s_band_RF_converter_qtp_damage_inplane_2_Q10_b8=zeros(n,2);
s_band_RF_converter_qtp_damage_inplane_2_Q30_b4=zeros(n,2);
s_band_RF_converter_qtp_damage_inplane_2_Q30_b8=zeros(n,2);

s_band_RF_converter_qtp_damage_inplane_2_Q10_b4(:,1)=fn;
s_band_RF_converter_qtp_damage_inplane_2_Q10_b8(:,1)=fn;
s_band_RF_converter_qtp_damage_inplane_2_Q30_b4(:,1)=fn;
s_band_RF_converter_qtp_damage_inplane_2_Q30_b8(:,1)=fn;


for i=1:n
    s_band_RF_converter_qtp_damage_inplane_2_Q10_b4(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_inplane_2_fds_Q10_b4(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_inplane_2_fds_Q10_b4(i,2);
                                              
    s_band_RF_converter_qtp_damage_inplane_2_Q10_b8(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_inplane_2_fds_Q10_b8(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_inplane_2_fds_Q10_b8(i,2);
                                             
    s_band_RF_converter_qtp_damage_inplane_2_Q30_b4(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_inplane_2_fds_Q30_b4(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_inplane_2_fds_Q30_b4(i,2);
                                              
    s_band_RF_converter_qtp_damage_inplane_2_Q30_b8(i,2)= 3*s_band_RF_converter_qtp_profile_2_1_inplane_2_fds_Q30_b8(i,2)...
                                                  +24*s_band_RF_converter_qtp_profile_1_1_inplane_2_fds_Q30_b8(i,2);                                              
                                              
end