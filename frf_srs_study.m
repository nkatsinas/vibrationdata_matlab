clear f;

f=tap_B_ext_dco_sf_srs(:,1);

n=length(f);

 srs_CB=zeros(n,2);
 srs_DB=zeros(n,2);
 srs_EB=zeros(n,2);
 srs_FB=zeros(n,2);
 srs_GB=zeros(n,2);
 
 srs_CB(:,1)=f;
 srs_DB(:,1)=f; 
 srs_EB(:,1)=f;
 srs_FB(:,1)=f; 
 srs_GB(:,1)=f;  
 
 for i=1:n
 
    srs_CB(i,2)=20*log10(tap_C_ext_dco_sf_z_srs(i,2)/tap_B_ext_dco_sf_srs(i,2));
    srs_DB(i,2)=20*log10(tap_D_ext_dco_sf_z_srs(i,2)/tap_B_ext_dco_sf_srs(i,2));
    srs_EB(i,2)=20*log10(tap_E_ext_dco_sf_z_srs(i,2)/tap_B_ext_dco_sf_srs(i,2));
    srs_FB(i,2)=20*log10(tap_F_ext_dco_sf_z_srs(i,2)/tap_B_ext_dco_sf_srs(i,2));
    srs_GB(i,2)=20*log10(tap_G_ext_dco_sf_z_srs(i,2)/tap_B_ext_dco_sf_srs(i,2));   
    
 end