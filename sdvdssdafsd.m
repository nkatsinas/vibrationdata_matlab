NASA_TN_D1836_skin_panels=[20 0.0056; 200 2.7; 700 2.7; 900 0.62; 2000 0.62]

NASA_TN_D1836_skin_stiffners=[20 0.001; 200 0.48; 700 0.48; 900 0.11; 2000 0.11]

NASA_TN_D1836_fwd_bulkheads=[ 20 0.001; 200 1.78; 1000 1.78; 2000 0.178]

NASA_TN_D1836_aft_bulkheads=[ 20 0.014; 520 0.014; 800 0.043;  2000 0.043]





NASA_TN_D1836_skin_panels(:,2)=NASA_TN_D1836_skin_panels(:,2)*(51/49.5)^2;

NASA_TN_D1836_skin_stiffners(:,2)=NASA_TN_D1836_skin_stiffners(:,2)*(21.1/20.9)^2;

NASA_TN_D1836_fwd_bulkheads(:,2)=NASA_TN_D1836_fwd_bulkheads(:,2)*(50/46.1)^2;

NASA_TN_D1836_aft_bulkheads(:,2)=NASA_TN_D1836_aft_bulkheads(:,2)*(8.15/8.13)^2;



NASA_TN_D1836_beams=[ 20 0.18; 2000 0.18]

NASA_TN_D1836_combustion_chamber_section=[ 20 0.22; 200 0.22; 350 0.935; 2000 0.935]

NASA_TN_D1836_turbopump=[ 20 0.587; 2000 0.587]

NASA_TN_D1836_actuator=[ 20 0.224; 2000 0.224]

