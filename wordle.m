

% word=wlist_match8;
% word=readlines("words_alpha.txt");
word=readlines("words_alpha.txt");
word=lower(word);

LLL={'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
sz=size(LLL);

must={'E';'A';'T'};
must_not={'D';'I';'S';'U';'B';'X';'C';'R'};


LLL = lower( LLL );
MMM=lower(must);
NNN=lower(must_not);

Q=max(size(MMM));
R=max(size(NNN));


P=max(size(word));

iflag=0;

for i=1:P

    for j=1:Q
            if(contains(word{i},MMM{j}))
                iflag=1;
                
            else
                iflag=0;
                break;
            end    
    end  

    

    if(iflag==1)
        for j=1:R
            if(contains(word{i},NNN{j}))
                iflag=0;
                break;
            else
                iflag=1;
            end                
        end    
    end    


    if(iflag==1 && length(word{i})==5)
        vv=cellstr(word{i});
        index=cell2mat(strfind(vv,'a'));
        indexq=cell2mat(strfind(vv,'e'));
        indexqq=cell2mat(strfind(vv,'t'));


  %      if(index(1)~=5 && indexq(1)==4)
   %        fprintf('%s \n',word{i});
   %     end    

       if(index(1)==4 && indexq(1)~=1 && indexq(1)~=2 && indexq(1)~=4 && indexq(1)~=5 && indexqq(1)~=3 && indexqq(1)~=5)
            fprintf('%s \n',word{i});
        end    
        
    end    
end    



        
