
word=readlines("words_alpha.txt");



LLL={'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
sz=size(LLL);

LLL = lower( LLL );

L1='r';
L2='t';
L3='w';
L4='o';
L5='a';
L6='n';
L7='h';

MM=L1;


LLL(strncmpi(LLL,L1,1)) = [];
LLL(strncmpi(LLL,L2,1)) = [];
LLL(strncmpi(LLL,L3,1)) = [];
LLL(strncmpi(LLL,L4,1)) = [];
LLL(strncmpi(LLL,L5,1)) = [];
LLL(strncmpi(LLL,L6,1)) = [];
LLL(strncmpi(LLL,L7,1)) = [];


LLL;


P=max(size(word));
L=max(size(LLL));

fprintf(' L=%d  P=%d  \n\n',L,P);

for i=1:P
    k=contains(word{i},MM);
    if(length(word{i})>=4 && k==1)

        iflag=1;

        for j=1:L

            v=contains(word{i},LLL{j});
            if(v==1)
                iflag=0;
%                fprintf(' %s  i=%d  j=%d  iflag=%d \n',word{i},i,j,iflag);
                break;
            end    
%            fprintf(' %s  i=%d  j=%d  iflag=%d \n',word{i},i,j,iflag);
        end
        
        if(iflag==1)
            if( contains(word{i},L1) &&...
                contains(word{i},L2) &&...
                contains(word{i},L3) &&...
                contains(word{i},L4) &&...
                contains(word{i},L5) &&...
                contains(word{i},L6) &&...
                contains(word{i},L7) )
                
                fprintf(' ****** %s\n',word{i});   
    
            end    

            fprintf(' %s\n',word{i});
        end    
    end    
end    

