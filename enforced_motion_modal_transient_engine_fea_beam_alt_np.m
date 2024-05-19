%
%  enforced_motion_modal_transient_engine_fea_beam_alt_np.m  ver 1.2  by Tom Irvine
%

function[na,nx]=enforced_motion_modal_transient_engine_fea_beam_alt_np(FP,a1,a2,df1,df2,df3,af1,af2,af3,nt,num_modes)
%
nx = zeros(nt, num_modes);
na = zeros(nt, num_modes);

for j = 1:num_modes
    amodal = FP(j, :);

    % Displacement
    d_resp = filter([df1(j), df2(j), df3(j)], [1, -a1(j), -a2(j)], amodal);

    % Acceleration
    a_resp = filter([af1(j), af2(j), af3(j)], [1, -a1(j), -a2(j)], amodal);

    nx(:, j) = d_resp;  % Displacement
    na(:, j) = a_resp;  % Acceleration
end

