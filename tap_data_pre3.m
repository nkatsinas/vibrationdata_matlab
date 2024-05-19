  
  clear f;  

  tap_B_ext_dco_sf_ft_112        
  tap_C_ext_dco_sf_z_ft_112      
  tap_D_ext_dco_sf_z_ft_112      
  tap_E_ext_dco_sf_z_ft_112      
  tap_F_ext_dco_sf_z_ft_112      
  tap_G_ext_dco_sf_z_ft_112      

  f=tap_B_ext_dco_sf_ft_112(:,1);
  
  n=length(f);
  
  frf_CB=zeros(n,2);
  frf_DB=zeros(n,2);
  frf_EB=zeros(n,2);
  frf_FB=zeros(n,2);
  frf_GB=zeros(n,2);

  
  frf_CB(:,1)=f;
  frf_DB(:,1)=f;
  frf_EB(:,1)=f;
  frf_FB(:,1)=f;
  frf_GB(:,1)=f;
  
  for i=1:n
      
      if( tap_B_ext_dco_sf_ft_112(i,2) > 0 )
      
        frf_CB(i,2)=20*log10(  tap_C_ext_dco_sf_z_ft_112(i,2)/ tap_B_ext_dco_sf_ft_112(i,2) );
        frf_DB(i,2)=20*log10(  tap_D_ext_dco_sf_z_ft_112(i,2)/ tap_B_ext_dco_sf_ft_112(i,2) );     
        frf_EB(i,2)=20*log10(  tap_E_ext_dco_sf_z_ft_112(i,2)/ tap_B_ext_dco_sf_ft_112(i,2) );
        frf_FB(i,2)=20*log10(  tap_F_ext_dco_sf_z_ft_112(i,2)/ tap_B_ext_dco_sf_ft_112(i,2) );   
        frf_GB(i,2)=20*log10(  tap_G_ext_dco_sf_z_ft_112(i,2)/ tap_B_ext_dco_sf_ft_112(i,2) );
      
      else
        frf_CB(i,2)=20*log10(  tap_C_ext_dco_sf_z_ft_112(i+1,2)/ tap_B_ext_dco_sf_ft_112(i+1,2) );
        frf_DB(i,2)=20*log10(  tap_D_ext_dco_sf_z_ft_112(i+1,2)/ tap_B_ext_dco_sf_ft_112(i+1,2) );     
        frf_EB(i,2)=20*log10(  tap_E_ext_dco_sf_z_ft_112(i+1,2)/ tap_B_ext_dco_sf_ft_112(i+1,2) );
        frf_FB(i,2)=20*log10(  tap_F_ext_dco_sf_z_ft_112(i+1,2)/ tap_B_ext_dco_sf_ft_112(i+1,2) );   
        frf_GB(i,2)=20*log10(  tap_G_ext_dco_sf_z_ft_112(i+1,2)/ tap_B_ext_dco_sf_ft_112(i+1,2) );          
      end
      
  end
  