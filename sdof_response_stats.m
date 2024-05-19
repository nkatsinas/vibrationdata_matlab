%
%  sdof_response_stats.m  ver 1.0  by Tom Irvine
%

function[big_string]=...
    sdof_response_stats(a_resp,rd_resp,dur,t,dt,iu,rd_pos,rd_neg,a_pos,a_neg)


[~,a_sd,a_rms,sk,kt]=kurtosis_stats(a_resp);
[~,~,rd_rms,~,~]=kurtosis_stats(rd_resp);
crest=(max([a_pos(1) abs(a_neg(1))]))/a_sd;
[pszcr,peak_rate,~,~]=zero_crossing_function_alt(t,a_resp,dur);
[rf]=Rice_frequency(a_resp,dt);


%
if(iu==1 || iu==2)
    big_string=sprintf(' Acceleration Response (G) \n');
else
    big_string=sprintf(' Acceleration Response (m/sec^2) \n');
end

string1=sprintf('\n\n max=%8.4g',a_pos(1));
string2=sprintf('\n min=%8.4g',-a_neg(1));
string3=sprintf('\n\n RMS=%8.4g',a_rms);
string4=sprintf('\n std dev=%8.4g',std(a_resp));
string5=sprintf('\n mean=%8.4g',mean(a_resp));
string6=sprintf('\n\n crest factor=%7.3g',crest);
string7=sprintf('\n skewness=%7.3g',sk);
string8=sprintf('\n kurtosis=%7.3g',kt);

string_rf=sprintf('\n\n Rice Characteristic Frequency = %8.4g Hz ',rf);
string_zc=sprintf('\n Positive Slope Zero Cross Rate = %8.4g Hz ',pszcr);  
string_pr=sprintf('\n Peak Rate = %8.4g Hz ',peak_rate);    


big_string=strcat(big_string,string1);
big_string=strcat(big_string,string2);
big_string=strcat(big_string,string3); 
big_string=strcat(big_string,string4); 
big_string=strcat(big_string,string5); 
big_string=strcat(big_string,string6); 
big_string=strcat(big_string,string7);
big_string=strcat(big_string,string8);
%


if(iu==1)
    string8=sprintf('\n\n Relative Displacement (in) \n');    
else
    string8=sprintf('\n\n Relative Displacement (mm) \n');    
end
    
string9=sprintf('\n\n max=%7.3g',rd_pos(1));
string10=sprintf('\n min=%7.3g',rd_neg(1));
string11=sprintf('\n RMS=%7.3g',rd_rms);

big_string=strcat(big_string,string8);
big_string=strcat(big_string,string9);
big_string=strcat(big_string,string10);
big_string=strcat(big_string,string11); 

big_string=strcat(big_string,string_rf);    
big_string=strcat(big_string,string_zc); 
big_string=strcat(big_string,string_pr); 