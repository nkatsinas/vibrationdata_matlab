
disp(' ');
disp(' * * * * *');
disp(' ');

% D=3

nnet=0.003
f=1000
delta_f=700

mdens=150/700;
mdens=31.02;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nnet=0.02;
f=500;
z=2^(1/6);
delta_f=f*(z-1/z);
mdens=0.2;
D=2;



% C=(pi*nnet*f/2)

%% ratio=1+((C*mdens)*(2^D)-1)*(C/delta_f)


%% 10*log10(ratio)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% for i=1:40

%% mdens=i;

C=(pi*nnet*f/2);


q=(C*mdens)*(2^D);
w=10*log10(q);

out1=sprintf(' mdens=%7.3g     sine amp=%7.3g dB  ',mdens,w);
disp(out1);

%% end

disp(' ');
disp(' ');

out1=sprintf(' C=%8.4g  D=%8.4g \n',C,D);
disp(out1);

ratio= 1+(q-1)*(C/delta_f);

ba=10*log10(ratio);


out1=sprintf(' ratio=%8.4g  broadband=%8.4g \n',ratio,ba);
disp(out1);



