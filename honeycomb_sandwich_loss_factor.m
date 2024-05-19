
fp=500;

j=1;

for i=10:10:2000
    
    f=i;
    
    bare_loss=0.3/f^0.63;
    
    if(f<=500)
        built_loss=0.05;
    else
        built_loss=0.05*sqrt(fp/f);    
    end
    
    
    bare(j,:)=[f bare_loss];
    built(j,:)=[f built_loss];
    
    j=j+1;
    
end

fig_num=1;

x_label='Frequency (Hz)';
y_label='Loss Factor';
t_string='Sandwich Panel';

fmin=bare(1,1);
fmax=max(bare(:,1));

ppp1=bare;
ppp2=built;

leg1='Bare Panel';
leg2='Built-up Panel';

md=3;

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);