
function[]=load_mat(pathname,filename)

    if(~contains(filename,'.mat'))
        filename=sprintf('%s.mat',filename);
    end    

    try
        NAME=char(fullfile(pathname,filename));
        struct=load(NAME);
    catch
    end

    try

        structnames = fieldnames(struct, '-full'); % fields in the struct
                    
        k=length(structnames);
                    
        for i=1:k
            namevar=strcat('struct.',structnames{i});
            value=eval(namevar);
            assignin('base',structnames{i},value);
        end

    catch
    end
