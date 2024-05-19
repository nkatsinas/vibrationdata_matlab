

% sandwich_panel_line_index.m  ver 1.0   by Tom Irvine

function[clf12,clf21,cg]=sandwich_panel_line_index(omega,B,Bf,G,mpa,hc,Lc,A1,A2,k1,k2)
    
f=omega/(2*pi);

[ccc_k1]=sandwich_wavespeed_polynomial(omega,B(k1),Bf(k1),G(k1),mpa(k1),hc(k1));
[ccc_k2]=sandwich_wavespeed_polynomial(omega,B(k2),Bf(k2),G(k2),mpa(k2),hc(k2));
    
cg_k1=2*ccc_k1;
cg_k2=2*ccc_k2;


% tau=2/(  sigma^(-1.25)  +   sigma^(1.25)   );

R= 5;  % Diffuse incidence, equal thickness, Nilsson, Liu, Vibroacoustics, Vol 1, Figure 5.22

tau1=1/(10^(R/10));

% See Hambric et al, Experimental Vibro-Acoustic Analysis of Honeycomb Sandwich Panels Connected by Lap and Sleeve Joints 

n=-1;  % 3 dB/octave slope 

if(f<=500)
    tau=tau1;
else
    tau=tau1*(f/500)^n; 
end

tau=tau1;

%%%

term1=cg_k1*Lc*tau/(omega*pi);
term2=cg_k2*Lc*tau/(omega*pi);

clf12=term1/A1;
clf21=term2/A2;

cg=cg_k1;