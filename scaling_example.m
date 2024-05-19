

GRMS_hot=1;   % GRMS
PSD_hot= 0.1;  % G^2/Hz
bhot = 9.1;
broom = 9;

Ahot=1;
Aroom=1.1;


GRMS_room = (((GRMS_hot)^(bhot))*(Aroom/Ahot))^(1/broom)

scale_GRMS=GRMS_room/GRMS_hot

scale_PSD=scale_GRMS^2

PSD_room=PSD_hot*scale_PSD


