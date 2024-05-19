

% sandwich_panel_line.m  ver 1.0   by Tom Irvine

function[clf12,clf21,cg]=sandwich_panel_line(omega,B,Bf,G,mpa,hc,Lc,A1,A2)
    
f=omega/(2*pi);

[ccc]=sandwich_wavespeed_polynomial(omega,B,Bf,G,mpa,hc);
    
cp=ccc;

cg=2*cp;


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

term=cg*Lc*tau/(omega*pi);

clf12=term/A1;
clf21=term/A2;