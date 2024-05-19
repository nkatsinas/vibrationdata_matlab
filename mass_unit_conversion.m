%
%  mass_unit_conversion.m  ver 1.0  by Tom Irvine
%


function[meters_per_inch,Pa_per_psi,kgpm3_per_lbmpft3,kgpm3_per_lbmpin3,...
                                    kgpm2_per_lbmpft2,kgpm2_per_lbmpin2,...
                                                             kg_per_lbm]...
                                                    =mass_unit_conversion()

meters_per_inch=0.0254;
Pa_per_psi = 6894.;

kgpm3_per_lbmpft3=16.016;
kgpm3_per_lbmpin3=27675;

kgpm2_per_lbmpft2=4.8816;
kgpm2_per_lbmpin2=702.95;

kg_per_lbm=0.45351;