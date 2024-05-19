
%
cc_srs_mpe_x=[ 10 6; 320 5000; 2000 13600; 10000 13600];
a=cc_srs_mpe_x;
plot(a(:,1),a(:,2),'k','DisplayName','MPE');  % black

%
a=E1_sep3x_cleaned_abs_srs;
plot(a(:,1),a(:,2),'r','DisplayName','E1 3x');  % red
%
a=E3_sep2x_cleaned_abs_srs;
plot(a(:,1),a(:,2),'b','DisplayName','E3 2x');  %blue
%
a=E3_sep3x_cleaned_abs_srs;
plot(a(:,1),a(:,2),'color',[0 0.50 0.5],'DisplayName','E3 3x'); % teal

%
a=N1_sep2x_cleaned_abs_srs;
plot(a(:,1),a(:,2),'color',[0.2 0 0],'DisplayName','N1 2x'); % brown
%
a=N1_sep3x_cleaned_abs_srs;
plot(a(:,1),a(:,2),'color',[1 0.5 0],'DisplayName','N1 3x');  % orange
%
a=N2_sep2x_cleaned_abs_srs;
plot(a(:,1),a(:,2),'color',[0.5 0.5 0],'DisplayName','N2 2x'); % olive
%
a=N2_sep3x_cleaned_abs_srs;
plot(a(:,1),a(:,2),'color',[34 139 34]/255,'DisplayName','N2 3x'); % forest green
%
a=N3_sep2x_cleaned_abs_srs;
plot(a(:,1),a(:,2),'m','DisplayName','N3 3x'); % magenta


legend show;

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);