disp(' ');
disp(' read_data.m  ver 1.1  May 8, 2013 ');
disp(' ');
%
clear THM;
clear THF;
%
[filename, pathname] = uigetfile('*.*');
filename = fullfile(pathname, filename); 
fid = fopen(filename,'r');
%
j=1;
%
for i=1:20000000
%
    clear THF;
    THF = fgets(fid);
    if(THF==-1)
         if(max(size(THF))==1)
             break;
         end
    end
%
     clear aaa;
     aaa = sscanf(THF,'%g');
     aaa=aaa';
%%
    iflag=1;
%    
    k = findstr(THF,'0');   
    if(k>=1)
      iflag=2;
    else
      k = findstr(THF,'1');
      if(k>=1)
        iflag=2;
      else
        k = findstr(THF,'2');
        if(k>=1)
          iflag=2;
        else
          k = findstr(THF,'3');
          if(k>=1)
            iflag=2;
          else
            k = findstr(THF,'4');
            if(k>=1)
              iflag=2;
            else
              k = findstr(THF,'5');
              if(k>=1)
                iflag=2;
              else
                k = findstr(THF,'6');
                if(k>=1)
                  iflag=2;
                else
                  k = findstr(THF,'7');
                  if(k>=1)
                    iflag=2;
                  else
                    k = findstr(THF,'8');
                    if(k>=1)
                      iflag=2;
                    else
                      k = findstr(THF,'9');
                      if(k>=1)
                        iflag=2;
                      end                               
                    end                        
                  end                     
                end                    
              end                 
            end    
          end              
        end             
      end     
    end            
%%
    if(iflag==2)
        THM(j,:)=aaa;
        j=j+1;
    end
%
end
%
new_name= input(' Enter the new Matlab array name for this data:  ','s');
%
eval([new_name '=THM;']);
sz=size(THM);
disp(' ');
out1=sprintf(' size:  %d x %d  ',sz(1),sz(2));
disp(out1);