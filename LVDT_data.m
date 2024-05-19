clear all;

load LVDT_X_GS1_154286.mat
asum_X_GS1_p1=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

load LVDT_X_mpe_154286.mat
asum_X_mpe_p1=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

load LVDT_Y_mpe_154286.mat
asum_Y_mpe_p1=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

load LVDT_Y_GS1_154286.mat
asum_Y_GS1_p1=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

load LVDT_Z_mpe_154286.mat
asum_Z_mpe_p1=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

load LVDT_Z_GS1_154286.mat
asum_Z_GS1_p1=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load LVDT_X_GS1_179087.mat
asum_X_GS1_p2=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

load LVDT_X_mpe_179087.mat
asum_X_mpe_p2=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

load LVDT_Y_GS1_179087.mat
asum_Y_GS1_p2=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

load LVDT_Y_mpe_179087.mat
asum_Y_mpe_p2=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

load LVDT_Z_GS1_179087.mat
asum_Z_GS1_p2=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];

load LVDT_Z_mpe_179087.mat
asum_Z_mpe_p2=[ a12(:,1)   a12(:,2)+a13(:,2)+a14(:,2) ];


save asum.mat asum*
clear all
load asum