

sz=size(FT_magnitude_H);
nrows=sz(1);

ms=0;

for i=1:nrows
    ms=ms+ (FT_magnitude_H(i,2)/sqrt(2))^2;
end

rms=sqrt(ms)

peak=sqrt(2)*rms    % only works for pure sine