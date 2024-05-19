%
%   CPSD_function.m  ver 1.1  by Tom Irvine
%

function[freq,COH,CPSD,PSD_A,PSD_B,H1,H2,H1_m,H1_p,H1_real,H1_imag,H2_m,H2_p,H2_real,H2_imag]=...
                          CPSD_function(A,B,NW,mmm,mH,mr_choice,h_choice,df)
%
    nov=0;
%
    clear amp_seg_A;
    clear amp_seg_B;
%
    CPSD=zeros(mmm,1); 
    PSD_A=zeros(mmm,1); 
    PSD_B=zeros(mmm,1);
    H1=zeros(mmm,1);
    H2=zeros(mmm,1);
%
    H1_length=mmm;
    
    for ijk=1:(2*NW-1)
%
        amp_seg_A=zeros(mmm,1);
        amp_seg_A(1:mmm)=A((1+ nov):(mmm+ nov));  
%
        amp_seg_B=zeros(mmm,1);
        amp_seg_B(1:mmm)=B((1+ nov):(mmm+ nov));  
%
        nov=nov+fix(mmm/2);
%
        [complex_FFT_A]=CFFT_core(amp_seg_A,mmm,mH,mr_choice,h_choice);
        [complex_FFT_B]=CFFT_core(amp_seg_B,mmm,mH,mr_choice,h_choice);        
%
        CPSD=CPSD+(conj(complex_FFT_A)).*complex_FFT_B/df;   % two-sided
        PSD_A=PSD_A+(conj(complex_FFT_A)).*complex_FFT_A/df;
        PSD_B=PSD_B+(conj(complex_FFT_B)).*complex_FFT_B/df;
%
        GFX=(conj(complex_FFT_A)).*complex_FFT_B;
        GXF=(conj(complex_FFT_B)).*complex_FFT_A;
%        
        GFF=(conj(complex_FFT_A)).*complex_FFT_A;
        GXX=(conj(complex_FFT_B)).*complex_FFT_B;
%
%%%%%%%%%%%%%%%

        for i=1:H1_length
            
            if(isnan(GFF(i)) ||  isinf(GFF(i)) || isnan(GFX(i))  ||  isinf(GFX(i)) )
            else
                H1L=GFX(i)./GFF(i);
                
                if(abs(H1L)<1.0e+80)
                    H1(i)=H1(i)+H1L;
                end    
            end
                
            if(isnan(GXF(i)) ||  isinf(GXF(i)) || isnan(GXX(i)) ||  isinf(GXX(i)))
            else
                H2L=GXX(i)./GXF(i);
                
                if(abs(H2L)<1.0e+80)
                    H2(i)=H2(i)+H2L;
                end                   
            end           
            
        end
%
    end
%
    NN=(2*NW-1);

    CPSD=2*CPSD/NN;
    PSD_A=2*PSD_A/NN;
    PSD_B=2*PSD_B/NN;
    H1=H1/NN;
    H2=H2/NN;  
%

    fprintf(' df=%8.4g  NN=%d \n',df,NN);
    
    for ijk=1:H1_length
        if(isnan(H1(ijk)) ||  isinf(H1(ijk)) )
            out1=sprintf('1   %d  %g ',ijk,H1(ijk));
            disp(out1);            
            H1(ijk)=0+0i;
        end
        if(isnan(H2(ijk)) ||  isinf(H2(ijk)) )
            out1=sprintf('2   %d  %g ',ijk,H2(ijk));
            disp(out1);            
            H2(ijk)=0+0i;
        end 
        
        if(abs(H1(ijk))<1.0e+80)
        else
            out1=sprintf('3   %d  %g ',ijk,H1(ijk));
            disp(out1);            
            H1(ijk)=0+0i;
        end
        if(abs(H2(ijk))<1.0e+80)
        else
            out1=sprintf('4   %d  %g ',ijk,H2(ijk));
            disp(out1);            
            H2(ijk)=0+0i;
        end       
                      
    end
    
    H1_mag=abs(H1);
    H2_mag=abs(H2); 

  

    H1_phase=(180/pi)*atan2(imag(H1),real(H1));
    H2_phase=(180/pi)*atan2(imag(H2),real(H2));     
    
%
    CPSD_mag=abs(CPSD);
    CPSD_phase=(180/pi)*atan2(imag(CPSD),real(CPSD));  
%
    fffmax=(mH-1)*df;
    freq=linspace(0,fffmax,mH);
%
    CPSD_m(1)=CPSD_mag(1);
    CPSD_m(2:mH)=2*CPSD_mag(2:mH);
    CPSD_p=CPSD_phase(1:mH);
%
    H1_m(1)=H1_mag(1);
    H1_m(2:mH)=H1_mag(2:mH);
    H1_p=H1_phase(1:mH);
%
    H2_m(1)=H2_mag(1);
    H2_m(2:mH)=H2_mag(2:mH);
    H2_p=H2_phase(1:mH);
%
    COH=zeros(mH,1);
    H1_real=zeros(mH,1);
    H1_imag=zeros(mH,1);
    H2_real=zeros(mH,1);
    H2_imag=zeros(mH,1);
%    
    for i=1:mH
%        
        COH(i)=CPSD_mag(i)^2/( PSD_A(i)*PSD_B(i) );
%
        H1_real(i)=real(H1(i));
        H1_imag(i)=imag(H1(i)); 
        H2_real(i)=real(H2(i));
        H2_imag(i)=imag(H2(i));   
%
    end   
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    freq=fix_size(freq);
    
    H1_m=fix_size(H1_m);
    H1_p=fix_size(H1_p);
    H1_real=fix_size(H1_real);
    H1_imag=fix_size(H1_imag);

    H2_m=fix_size(H2_m);
    H2_p=fix_size(H2_p);
    H2_real=fix_size(H2_real);
    H2_imag=fix_size(H2_imag);

    