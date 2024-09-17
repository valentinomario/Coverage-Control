% This function runs the pinning control simulations with different
% velocities and plots the optimization error

n_sim = 10;
qs_velocities = linspace(0.01,0.1,n_sim);
Tdiff_average = zeros(1,n_sim);

strip = 200;
for i=1:length(qs_velocities)

    qs_velocity = qs_velocities(i);
    out = sim('cov_control.slx');
    close
    Tdiff_average(i) = mean(out.T_diff.Data(strip:end));
end

%%
scatter(qs_velocities, Tdiff_average, 'filled', 'r');
xlim([0.01, 0.1])
xlabel('u_s');
ylabel('T - T*');
grid on;
