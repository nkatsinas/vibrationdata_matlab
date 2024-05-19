aaa=[10	143.8	150.5	140.9	147.4
12.5	143.8	151.4	141.6	148.5
16	143.8	152.4	142.4	149.7
20	143.8	153.2	143.1	150.8
25	144.6	154.1	143.8	151.9
31.5	145.3	154.1	144.5	153
40	146.1	154.1	145	153.5
50	146.8	154.1	145	153.5
63	147.6	154.1	145	153.5
80	148.3	154.1	145	153.5
100	149.1	153	145	153.5
125	149.8	151.9	145	153.5
160	149.8	150.6	144.5	153
200	149.8	149.5	143.9	152.4
250	149.8	149.5	143.3	151.9
315	149.3	149.5	142.7	151.3
400	147.8	149.5	142.1	150.7
500	146.4	149.5	141.5	150.2
630	145	149.5	140.9	149.6
800	143.5	149.5	140.2	149
1000	141.9	149.5	139.6	148.4
1250	140.4	148.8	139	147.9
1600	138.8	148	138.4	147.3
2000	137.4	147.4	137.8	146.7];


ascent_spl_P311=[aaa(:,1) aaa(:,2)];
ascent_spl_P312=[aaa(:,1) aaa(:,3)];
ascent_spl_P321=[aaa(:,1) aaa(:,4)];
ascent_spl_P322=[aaa(:,1) aaa(:,5)];


ascent_spl_P311_lf=ascent_spl_P311;
ascent_spl_P312_lf=ascent_spl_P312;
ascent_spl_P321_lf=ascent_spl_P321;
ascent_spl_P322_lf=ascent_spl_P322;

ascent_spl_P311_lf6=ascent_spl_P311;
ascent_spl_P312_lf6=ascent_spl_P312;
ascent_spl_P321_lf6=ascent_spl_P321;
ascent_spl_P322_lf6=ascent_spl_P322;

ascent_spl_P311_lf8=ascent_spl_P311;
ascent_spl_P312_lf8=ascent_spl_P312;
ascent_spl_P321_lf8=ascent_spl_P321;
ascent_spl_P322_lf8=ascent_spl_P322;


ascent_spl_P311_lf8(:,3)=0.08;
ascent_spl_P312_lf8(:,3)=0.08;
ascent_spl_P321_lf8(:,3)=0.08;
ascent_spl_P322_lf8(:,3)=0.08;

P31_LOA_spl_mpe_lf8=P31_LOA_spl_mpe_lf;
P32_LOA_spl_mpe_lf8=P32_LOA_spl_mpe_lf;

P31_LOA_spl_mpe_lf8(:,3)=0.08;
P32_LOA_spl_mpe_lf8(:,3)=0.08;


%%%%


ascent_spl_P311_lf6(:,3)=0.06;
ascent_spl_P312_lf6(:,3)=0.06;
ascent_spl_P321_lf6(:,3)=0.06;
ascent_spl_P322_lf6(:,3)=0.06;

P31_LOA_spl_mpe_lf6=P31_LOA_spl_mpe_lf;
P32_LOA_spl_mpe_lf6=P32_LOA_spl_mpe_lf;

P31_LOA_spl_mpe_lf6(:,3)=0.06;
P32_LOA_spl_mpe_lf6(:,3)=0.06;



