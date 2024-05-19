
sep_aq=[20	0.27
80	1.8
200	1.8
700	0.3
2000	0.3]

[~,grms] = calculate_PSD_slopes_alt(sep_aq)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


p311_aq=sep_aq;

p311_aq(:,2)=sep_aq(:,2)*2.88;

p311_aq

[~,grms] = calculate_PSD_slopes_alt(p311_aq)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


p312_aq=p311_aq;

[~,grms] = calculate_PSD_slopes_alt(p312_aq)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p321_aq=[20	1.2
70	7
180 7
700	0.8
2000	0.8]

[~,grms] = calculate_PSD_slopes_alt(p321_aq)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p322_aq=p321_aq

[~,grms] = calculate_PSD_slopes_alt(p322_aq)


