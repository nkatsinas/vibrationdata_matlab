
%   convert_psd_octave_bands.m  ver 1.0  by Tom Irvine

%   input_psd:  freq(Hz) & accel(G^2/Hz)
%  output_psd:  freq(Hz) & accel(G^2/Hz)
%
%        noct:  octave band fraction such as noct=1/12
%
%        fmin:  minimum output frequency (Hz)
%        fmax:  maximum output frequency (Hz)


function[output_psd]=convert_psd_octave_bands(input_psd,noct,fmin,fmax)


om=[1 1/3 1/6 1/12 1/24];
[~,ioct]=min(abs(om-noct));


f=input_psd(:,1);    % freq
amp=input_psd(:,2);  % accel


df=0.05;
np=round((f(end)-f(1))/df);

new_freq=linspace(f(1),(np-1)*df,np);

[fi,ai] = interpolate_PSD_arbitrary_frequency_f(f,amp,new_freq);
input_grms=sqrt(sum(ai)*df);


[fl,fc,fu,~]=octaves_alt(ioct);

[ff,ossum,~,response_grms]=psd_oct_conversion(fi,ai,fl,fc,fu);

[~,i]=min(abs(ff-fmin));
[~,j]=min(abs(ff-fmax));
output_psd=[ff(i:j),ossum(i:j)];


fig_num=1;
md=5;  % maximum number of y-axis decades
y_label='Accel (G^2/Hz)';
x_label='Frequency (Hz)';
t_string='Power Spectral Density';
ppp1=input_psd;
ppp2=output_psd;
leg1=sprintf('Input %6.3g GRMS',input_grms);
leg2=sprintf('Output %6.3g GRMS',response_grms);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
