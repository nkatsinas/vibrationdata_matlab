
disp(' ');
disp(' * * * * ');
disp(' ');

scale=5.60e+06/1.0e+06;


a=scale*max(abs(M7_6353_lpff(:,2)));
b=scale*max(abs(M7_6355_lpff(:,2)));
out1=sprintf(' %8.4g \t %8.4g ',a,b);
disp(out1);

a=scale*max(abs(M8_6353_lpff(:,2)));
b=scale*max(abs(M8_6355_lpff(:,2)));
out1=sprintf(' %8.4g \t %8.4g ',a,b);
disp(out1);

a=scale*max(abs(M9_6353_lpff(:,2)));
b=scale*max(abs(M9_6355_lpff(:,2)));
out1=sprintf(' %8.4g \t %8.4g ',a,b);
disp(out1);

a=scale*max(abs(P7_6353_lpff(:,2)));
b=scale*max(abs(P7_6355_lpff(:,2)));
out1=sprintf(' %8.4g \t %8.4g ',a,b);
disp(out1);

a=scale*max(abs(P8_6353_lpff(:,2)));
b=scale*max(abs(P8_6355_lpff(:,2)));
out1=sprintf(' %8.4g \t %8.4g ',a,b);
disp(out1);

% a=scale*max(abs(P9_6353_lpff(:,2)));
% b=scale*max(abs(P9_6355_nr_lpff(:,2)));
% out1=sprintf(' %8.4g \t %8.4g ',a,b);
% disp(out1);