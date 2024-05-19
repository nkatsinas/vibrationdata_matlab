


function[]=save_mat(writefname, writepname,FS)

                    
                    pattern = '.mat';
                    replacement = '';
                    sname=regexprep(writefname,pattern,replacement);
                    ss=sprintf('%s',sname);
                    ss1=sprintf('%s',sname);
                      
                    FS2=FS;        
                    FS2=evalin('base',FS2);
                               
                    out1=sprintf('%s=FS2;',ss);
                    
                    clear ss;
                    
                    eval(out1);
                    
                    elk=sprintf('%s\\%s',writepname,writefname);
                    
                    try
                        save(elk,ss1);
                    catch
                        out1=sprintf('save_mat failed:  %s',elk);
                        warndlg(out1);
                    end