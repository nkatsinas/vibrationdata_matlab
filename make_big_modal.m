 

 
 tmax=max([ PH_X4570.Time(1)   AC_X4027.Time(1)  AC_X5268.Time(1)]);
 tmin=min([ PH_X4570.Time(end)   AC_X4027.Time(end)  AC_X5268.Time(end)]);
 
 [~,i1]=min(abs(tmax-PH_X4570.Time));
 [~,i21]= min(abs(tmax-AC_X4027.Time));
 [~,i22]= min(abs(tmax-AC_X5268.Time));
 i2=min([i21 i22]);
 
 
 [~,j1]=min(abs(tmin-PH_X4570.Time));
 
 [~,j21]= min(abs(tmin-AC_X4027.Time));
 [~,j22]= min(abs(tmin-AC_X5268.Time));
 j2=min([j21 j22]);
 
 delta1=j1-i1;
 delta2=j2-i2;
 
 delta=min([delta1 delta2]);
 
 j1=i1+delta;
 j2=i2+delta;

  data_1245=[PH_X4570.Time(i1:j1),   PH_X4570.Data(i1:j1), AC_X4027.Data(i2:j2), ...  
  AC_X4028.Data(i2:j2), ...  
  AC_X4029.Data(i2:j2), ...  
  AC_X4142.Data(i2:j2), ...  
  AC_X4198.Data(i2:j2), ...  
  AC_X4224.Data(i2:j2), ...  
  AC_X4225.Data(i2:j2), ...  
  AC_X4267.Data(i2:j2), ...  
  AC_X4268.Data(i2:j2), ...  
  AC_X4269.Data(i2:j2), ...  
  AC_X4545.Data(i2:j2), ...  
  AC_X4546.Data(i2:j2), ...  
  AC_X4547.Data(i2:j2), ...  
  AC_X4567.Data(i2:j2), ...  
  AC_X4568.Data(i2:j2), ...  
  AC_X4569.Data(i2:j2), ...  
  AC_X4590.Data(i2:j2), ...               
  AC_X4591.Data(i2:j2), ...  
  AC_X4592.Data(i2:j2), ...               
  AC_X4780.Data(i2:j2), ...               
  AC_X4781.Data(i2:j2), ...               
  AC_X4782.Data(i2:j2), ...  
  AC_X5069.Data(i2:j2), ...               
  AC_X5070.Data(i2:j2), ...  
  AC_X5236.Data(i2:j2), ...               
  AC_X5237.Data(i2:j2), ...              
  AC_X5268.Data(i2:j2), ...             
  AC_X5269.Data(i2:j2), ...  
  AC_X5270.Data(i2:j2), ...               
  AC_X5275.Data(i2:j2), ...  
  AC_X5276.Data(i2:j2), ...               
  AC_X5277.Data(i2:j2)];                  
