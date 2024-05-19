a1=[20	0.03
150	2.5
230	2.5
2000	0.005];

a2=[20	0.25
150	2.25
230	2.25
2000	0.05];

a3=[20	0.025
150	0.55
230	0.55
2000	0.005];

a4=[20	0.15
170	2.3
300	2.3
2000	0.0375];

f=a1(:,1);
a=a1(:,2);
[s,grms] = calculate_PSD_slopes(f,a);
grms

f=a2(:,1);
a=a2(:,2);
[s,grms] = calculate_PSD_slopes(f,a);
grms

f=a3(:,1);
a=a3(:,2);
[s,grms] = calculate_PSD_slopes(f,a);
grms

f=a4(:,1);
a=a4(:,2);
[s,grms] = calculate_PSD_slopes(f,a);
grms



q1=[20	0.12
150	10
230	10
2000	0.02];

f=q1(:,1);
a=q1(:,2);
[s,grms] = calculate_PSD_slopes(f,a);
grms


q2=[20	1
150	9
230	9
2000	0.2];

f=q2(:,1);
a=q2(:,2);
[s,grms] = calculate_PSD_slopes(f,a);
grms



q3=[20	0.1
150	2.2
230	2.2
2000	0.02];

f=q3(:,1);
a=q3(:,2);
[s,grms] = calculate_PSD_slopes(f,a);
grms


q4=[20	0.6
170	9.2
300	9.2
2000	0.15];

f=q4(:,1);
a=q4(:,2);
[s,grms] = calculate_PSD_slopes(f,a);
grms





