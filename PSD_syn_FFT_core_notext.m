%
%  PSD_syn_FFT_core_notext.m  ver 1.0  October 12, 2012
%
function[Y,Y_real,nL]=...
               PSD_syn_FFT_core_notext(mmm,np,fmax,df,sq_spec,YF)
%

% for i=1:nsegments

     
%       YF = fft(white_noise,np);
%
       Y=sq_spec.*YF;
%
%      Make symmetric
%
       for j=1:mmm
          fff=(j-1)*df;
          if(fff<fmax)
          else
              Y(j)=0.;
          end
       end
%
%       for j=2:np             
%          Y(j)=complex(real(Y(j)),-imag(Y(j)));
%       end

       Y(2:np) = complex(real(Y(2:np)), -imag(Y(2:np)));


%
       Y_real = real(ifft(Y));
%       
% end
%  
nL=length(Y_real);
