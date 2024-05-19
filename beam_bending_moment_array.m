
% beam_bending_moment_array.m  ver 1.0  by Tom Irvine

function[MA,VA]=beam_bending_moment_array(L,x)

% bending
MA=[ -6+12*x   L*(-4+6*x)   6-12*x   L*(-2+6*x)  ];

% shear
VA=[   12     L*(6)    -12   L*(6)  ]/L;