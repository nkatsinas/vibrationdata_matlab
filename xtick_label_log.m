%
%   xtick_label_log.m  ver 3.4  by Tom Irvine
%
function[xtt,xTT,iflag]=xtick_label_log(fmin,fmax)

xtt=[1 2 3 4 4.3];
xTT={'10';'100';'1000';'10K';'20K'};
iflag=1;

try
    if(fmax<=1100)
        xtt=[1 2 3];
        xTT={'10';'100';'1000'};
        iflag=1;
        return;
    end 
    if(fmax<=2136)
        xtt=[1 2 3 3.3];
        xTT={'10';'100';'1000';'2000'};
        iflag=1;
        return;
    end
    if(fmax<=11000)
        xtt=[1 2 3 4];
        xTT={'10';'100';'1000';'10K'};
        iflag=1;
        return;
    end   
catch
   
   fprintf('\n fmin=%9.5g  fmax=%9.5g  \n',fmin,fmax);
   
   warndlg('xtick_label error ');
   return;
end

