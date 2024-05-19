
disp('     ');
disp('     ');
disp(' * * * * * *    ');
disp('     ');

iu=1;

M=200000;
C=0;
K=1500;

if(iu==1)
   M=M/386.;
end
%

Z=zeros(1,1);

clear A;
clear B;

A=[ C M ; M  Z ];
B=[ K Z ; Z -M ];


% A=[ M Z ; 0  -M ];
% B=[ C M ; K 0 ];


disp(' ');
disp(' A Matrix ');
disp(' ');
A


disp(' ');
disp(' B Matrix ');
disp(' ');
B

assignin('base','A',A); 
assignin('base','B',B); 


[RightEV,Eigenvalues,LeftEV]=eig(-B,A);

Eigenvalues

% RightEV'*A*RightEV
% RightEV*A*RightEV'

% LeftEV'*A*LeftEV
% LeftEV*A*LeftEV'

% RightEV*A*LeftEV'

%% RightEV'*A*LeftEV

%% LeftEV'*B*RightEV


%% RightEV'*A*RightEV


%% LeftEV'*B*RightEV


ar=RightEV'*A*RightEV;
br=RightEV'*B*RightEV;

assignin('base','ar',ar);
assignin('base','br',br);
assignin('base','LeftEV',LeftEV);
assignin('base','RightEV',RightEV);
assignin('base','ModeShapes',ModeShapes); 
assignin('base','Eigenvalues',Eigenvalues); 



