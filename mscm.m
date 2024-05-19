function main()
    disp('msc_eigenvector.cpp  ver 1.1    December 12, 2003');
    disp('by Tom Irvine');
    disp('Email: tomirvine@aol.com');
    disp(' ');
    disp('The input file is a MSC/Nastran f06 output file');
    disp('from a SOL SEMODES analysis.');
    filename = input('Enter the *.f06 filename: ', 's');

    fid = fopen(filename, 'r');
    if fid ~= -1
        disp(['File ', filename, ' opened']);
    else
        disp(['Failed to open ', filename]);
        return;
    end

    disp('begin eigenvalues');
    eigenvalues(fid);

    disp(' ');
    disp('begin eigenvectors');
    eigenvectors(fid);

end

function eigenvalues(fid)
    filename = 'fn.out';
    pFile = fopen(filename, 'w');

    while ~feof(fid)
        line = fgetl(fid);
        if contains(line, 'R E A L   E I G E N V A L U E S')
            fgetl(fid); % Skip a line
            while ~feof(fid)
                line = fgetl(fid);
                if contains(line, 'NASTRAN')
                    break;
                else
                    if ~contains(line, 'ORDER')
                        if contains(line,'0')
                            data = strsplit(line);
                            fprintf(pFile, '%s \t %8.2f\n', data{1}, str2double(data{5}));
                            disp([data{1}, '  ', num2str(str2double(data{5}), '%8.2f')]);
                        end
                    end
                end
            end
            break;
        end
    end

    fclose(pFile);
end

function eigenvectors(fid)

    while ~feof(fid)
        line = fgetl(fid);
        if contains(line, 'E I G E N V E C T O R')
            while ~feof(fid)
                line = fgetl(fid);
                if contains(line, 'F O R C E S')
                    return;
                end
                if contains(line, 'E I G E N V E C T O R')
                    fprintf('\n%s\n',line); 
                elseif ( (contains(line, 'G') || contains(line, 'T1')) && ~contains(line, 'JOB') && ~contains(line, 'VALUE') && ~contains(line, 'V E C T O R'))
                   disp(line); 
                   % data = strsplit(line);
%                    grid(i) = str2double(data{1});
%                    disp(['i=', num2str(i), '   grid[', num2str(i), '] = ', num2str(grid(i), '%12.4f')]);
%                    i = i + 1;
                end
            end
            break;
        end
    end
end
