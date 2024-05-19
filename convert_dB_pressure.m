%
%  convert_dB_pressure.m  ver 1.0  by Tom Irvine
%
function[psi_rms,Pa_rms]=convert_dB_pressure(dB)
%
ref=20e-06;
%
Pa_rms=ref*10^(dB/20);
%
psi_rms=Pa_rms*0.00014511;