% +------------------------------------------------------+
% |   Pink Noise Generation with MATLAB Implementation   | 
% |                                                      |
% | Author: Ph.D. Eng. Hristo Zhivomirov        07/31/13 | 
% +------------------------------------------------------+
%
% function: x = pinknoise(m, n)
%
% Input:
% m - number of rows in the output matrix x
% n - number of columns in the output matrix x
% 
% Output:
% x - m-by-n matrix with pink noise samples 
%     with mu = 0 and sigma = 1 (columnwise)
%
% The function generates a matrix of pink (flicker) noise samples.
% In terms of power at a constant frequency bandwidth, the pink  
% noise falls off by -3 dB/oct i.e., -10 dB/dec.

function x = pinknoise(m, n)

% input validation
validateattributes(m, {'double'}, ...
                      {'scalar', 'nonnan', 'nonempty', 'positive', 'finite', 'integer'}, ...
                      '', 'm', 1)
validateattributes(n, {'double'}, ...
                      {'scalar', 'nonnan', 'nonempty', 'positive', 'finite', 'integer'}, ...
                      '', 'n', 2)                  
          
% set the PSD slope
alpha = -1; 

% convert from PSD (power specral density) slope 
% to ASD (amplitude spectral density) slope
alpha = alpha/2;

% generate AWGN signal
x = randn(m, n);

% ensure that the processing is performed columnwise
% (this covers the case when one requests 1-by-n output matrix)
if m == 1, x = x(:); end

% calculate the number of unique fft points
NumUniquePts = ceil((size(x, 1)+1)/2);

% take fft of x
X = fft(x);

% fft is symmetric, throw away the second half
X = X(1:NumUniquePts, :);

% prepare a vector with frequency indexes 
k = 1:NumUniquePts; k = k(:);

% manipulate the first half of the spectrum so the spectral 
% amplitudes are proportional to the frequency by factor f^alpha
X = X.*(k.^alpha);

% perform ifft
if rem(size(x, 1), 2)	% odd length excludes Nyquist point 
    % reconstruct the whole spectrum
    X = [X; conj(X(end:-1:2, :))];
    
    % take ifft of X
    x = real(ifft(X));   
else                    % even length includes Nyquist point  
    % reconstruct the whole spectrum
    X = [X; conj(X(end-1:-1:2, :))];
    
    % take ifft of X
    x = real(ifft(X));  
end

% ensure zero mean value and unity standard deviation 
x = zscore(x);

% ensure the desired size of the output
% (this covers the case when one requests 1-by-n output matrix)
if m == 1, x = x'; end

end