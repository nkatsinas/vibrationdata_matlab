%
%  plot_histogram.m  ver 1.0  October 12, 2012
%
function[fig_num]=plot_histogram(y,amp_label,fig_num)
%
while(1)
            clear x;
            nbar=input(' Enter the number of bars ');
            xx=max(abs(y));
            x=linspace(-xx,xx,nbar);       
            figure(fig_num);
            fig_num=fig_num+1;
            hist(y,x)
            ylabel(' Counts');
            xlabel(amp_label);  
            title(' Histogram '); 
            disp(' Re-plot with different number of bars? ');
            disp(' 1=yes  2=no ');
            irp=input(' ');
            if(irp==2)
                break;
            end
end
