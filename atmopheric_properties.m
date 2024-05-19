%
% atmopheric_properties.m  ver 1.2  by Tom Irvine
%
function[air_pressure,mass_dens,temp_K,temp_C,sound_speed]=...
                                              atmopheric_properties(alt,iu)
% 
%                                          
%   mass_dens (lbm/ft3)  for iu=1  
%   mass_dens (kg/m3)    for iu=2                                        
%
%   sound_speed (ft/sec) for iu=1
%   sound_speed (m/sec)  for iu=2
%                         

if(iu==1)  % feet

   alt=alt/3280.8; 
    
else       % km
    
   alt=alt/1000;
   
end
 
%
%  Table Columns
%
%   Altitude (km)
%   Pressure (kPa)
%   Mass Density (kg/m3)
%   Temp (Kelvin)
%   Temp (Celsius)
%   Speed of Sound (m/sec)

table=[ 0	101.3	1.226	288	14.9	340.2;
        1	89.85	1.112	282	8.4     336.3;
        2	79.47	1.007	275	1.9     332.4;
        3	70.09	0.9096	269	-4.7	328.5;
        4	61.62	0.8195	262	-11.2	324.5;
        5	54      0.7365	256	-17.7	320.4;
        6	47.17	0.66	249	-24.2	316.3;
        7	41.05	0.5898	243	-30.7	312.1;
        8	35.59	0.5254	236	-37.2	307.9;
        9	30.73	0.4666	230	-43.7	303.7;
        10	26.43	0.4129	223	-50.2	299.3;
        11	22.62	0.3641	217	-56.2	295;
        12	19.33	0.3104	217	-56.2	295;
        13	16.51	0.2652	217	-56.2	295;
        14	14.11	0.2266	217	-56.2	295;
        15	12.06	0.1936	217	-56.2	295;
        16	10.3	0.1654	217	-56.2	295;
        17	8.801	0.1413	217	-56.2	295;
        18	7.519	0.1207	217	-56.2	295;
        19	6.424	0.1032	217	-56.2	295;
        20	5.489	0.0881	217	-56.2	295;
        25  2.51    0.0395  222 -51.2   302;
        30  1.17    0.018   227 -46.2   304;
        35  0.56    0.008   237 -36.2   308;
        40  0.28    0.004   251 -22.2   313];


sz=size(table);
n=sz(1);

h=table(:,1);
p=table(:,2);
dens=table(:,3);
tK=table(:,4);
tC=table(:,5);
tspeed=table(:,6);

mass_dens=0;

for i=1:(n-1)

    if( alt >= h(i) && alt < h(i+1) )

        len = h(i+1)-h(i);

        c2  = (alt-h(i))/len;
        c1  = 1. -c2;

        air_pressure = c1*p(i)      + c2*p(i+1);
        mass_dens    = c1*dens(i)   + c2*dens(i+1);
        temp_K       = c1*tK(i)     + c2*tK(i+1);        
        temp_C       = c1*tC(i)     + c2*tC(i+1);
        sound_speed  = c1*tspeed(i) + c2*tspeed(i+1);          
        
        break;

    end
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   mass density
%
if(alt<=20)

    rho_o=1.225;
    To=288.12;
    L=6.5;  
    Lm=6.5/1000;
    RoM=287;
    g=9.81;
    e=(g/(Lm*RoM))-1;
    Tc=217;
    h1=11;

    T=To-L*h1;
    rho_1=rho_o*( T/To )^e;
    
    h=alt;
   
    if(h<=11)
       T=To-L*h;
       rho=rho_o*( T/To )^e;
    else
       delta_hm=(h-h1)*1000; 
       rho=rho_1*exp((-g/(RoM*Tc))*delta_hm);          
    end    
   
    mass_dens=rho;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    sound_speed=sound_speed*3.2808;
      mass_dens=mass_dens*0.062439;
end