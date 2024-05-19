

GRMS_hot=34.337;   % GRMS


broom = 9.62;
bhot = broom/1.05;

u_hot=109e+03;
u_room=120e+03;

A_hot=u_hot^bhot
A_room=u_room^broom

AAA=A_room/A_hot


GRMS_room = (((GRMS_hot)^(bhot))*(AAA))^(1/broom)

scale_GRMS=GRMS_room/GRMS_hot

scale_PSD=scale_GRMS^2

dB=10*log10(scale_PSD)


