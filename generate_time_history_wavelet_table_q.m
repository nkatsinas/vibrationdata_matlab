%
%  generate_time_history_wavelet_table_q.m  ver 1.1  by Tom Irvine
%
function[accel]=generate_time_history_wavelet_table_q(f,amp,~,td,t,...
                                         wavelet_low,wavelet_up,alpha,beta)


nt=length(t);

last_wavelet=length(f);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

accel=zeros(nt,1);
%    
for i=1:last_wavelet      
%
        ia=wavelet_low(i);
        ib=wavelet_up(i);   
%
        sa=sin( alpha(i)*( t(ia:ib)-td(i) ) );        
        sb=sin(  beta(i)*( t(ia:ib)-td(i) ) );
%
        try
            accel(ia:ib)=accel(ia:ib)+(amp(i)*sa.*sb)';
        catch
            try
                accel(ia:ib)=accel(ia:ib)+(amp(i)*sa.*sb);
            catch
                disp('ref q')
                size(accel(ia:ib))
                size(amp(i))
                size(sa)
                size(sb)
            end
        end
%
end