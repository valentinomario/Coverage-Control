clear %!
close all

coverage1D_parameters;


if pinning
    out = sim('cov_control.slx');
else
    out = sim('cov_control_no_pinning.slx');
end

if ~exist("./img/pinning_"+string(pinning), 'dir')
        mkdir("./img/pinning_"+string(pinning));
end

figure
plot(out.T_diff.Time, out.T_diff.Data,'k');
xlabel('step')
ylabel('T - T*')
saveas(gcf, "./img/pinning_"+string(pinning)+"/Tdiff",'epsc');

figure
plot(out.Ti.Time, squeeze(out.Ti.Data));
xlabel('step')
ylabel('T_i')
saveas(gcf, "./img/pinning_"+string(pinning)+"/Ti",'epsc');


figure
plot(out.u.Time, squeeze(out.u.Data));
xlabel('step')
ylabel('u_i')
saveas(gcf, "./img/pinning_"+string(pinning)+"/ui",'epsc');


figure
plot(out.est_err.Time, out.est_err.Data);
xlabel('step')
ylabel('estimation error norm')
saveas(gcf, "./img/pinning_"+string(pinning)+"/est_err",'epsc');

figure
plot(out.Ti.Time, squeeze(out.q.Data));
xlabel('step')
ylabel('q_i')
if pinning
    hold;
    plot(out.qs.Time, out.qs.Data,'--')
end
saveas(gcf, "./img/pinning_"+string(pinning)+"/qi",'epsc');

plotPointsOnUnitCircle(out.q.Data(:,1,1));
saveas(gcf, "./img/pinning_"+string(pinning)+"/q0",'epsc');
plotPointsOnUnitCircle(out.q.Data(:,1,end));
saveas(gcf, "./img/pinning_"+string(pinning)+"/qend",'epsc');

