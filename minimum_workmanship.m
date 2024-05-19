        
% minimum_workmanship.m  ver 1.0  by Tom Irvine

function[]=minimum_workmanship()

        smc_s_016=[20           0.0053
                    150         0.04
                    800         0.04
                    2000       0.0064];
        
        output_name='smc_s_016';
        assignin('base', output_name, smc_s_016);